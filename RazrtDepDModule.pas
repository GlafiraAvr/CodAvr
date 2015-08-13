unit RazrtDepDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB,
  kbmMemTable, IBDatabase, IBCustomDataSet;

type
  Tdm_RazrtDep = class(Tdm_NGReportBase)
    dset_OrderInfo: TIBDataSet;
    tran: TIBTransaction;
    dset: TIBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetPlanStartDate: TDateTimeField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetdlname: TStringField;
    ResultDsetEquip: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetPlanStartTime: TStringField;
    ResultDsetBrigName: TStringField;
    frDBResult: TfrDBDataSet;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_RegionID: integer;
     procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property RegionID: integer read F_RegionID write F_RegionID;
    function PrepareDset: boolean;
  end;

var
  dm_RazrtDep: Tdm_RazrtDep;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tdm_RazrtDep.FillResultDset;
var _on, _ton : integer;
    _RegCond: string;
begin
  _on := 0;
  ResultDset.Close;
  ResultDset.Open;
{
select o.ordernumber, o.fk_orders_regions, d.id, d.StartDate, d.EndDate ,d.fk_departures_orders, d.DepNumber
        ,d.PLANSTARTDATE , d.PLANENDDATE, d.fk_departures_equipment,
        (select rtrim(name)||' ¹'||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,
        (select name from s_regions where id = o.fk_orders_regions) region,
        (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres,
        (select rtrim(sdl.name) from s_damagelocality sdl where sdl.id = o.fk_orders_damagelocality) dlname
from orders o , departures d
where ((o.id = d.fk_departures_orders)  and  d.planstartdate < '20.02.2009' and d.planenddate >= '19.02.2009' and not( d.fk_departures_equipment is null) )
order by 12, 1
}

  if F_RegionID > 0 then
     _RegCond := ' and o.fk_orders_regions = '+ IntToStr( F_RegionID )
     else _RegCond := '';


  MyOpenIBDS( dset,
    ' select o.ordernumber, o.fk_orders_regions, d.id, d.StartDate, d.EndDate ,d.fk_departures_orders, d.DepNumber' +
    ' ,d.PLANSTARTDATE , d.PLANENDDATE, d.fk_departures_equipment,' +
//    ' (select rtrim(name)||'' ¹''||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,' +
    ' (select '' ¹''||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,' +
    ' (select name from s_regions where id = o.fk_orders_regions) region, '+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres, '+
    ' (select rtrim(sdl.name) from s_damagelocality sdl where sdl.id = o.fk_orders_damagelocality) dlname, '+
    ' d.depnumber ' +
    ' ,(select rtrim(name) from brigadiers where id = d.FK_DEPARTURES_BRIGADIERS ) BrigName '+
    ' from orders o , departures d '+
    ' where (o.id = d.fk_departures_orders) ' +
    _RegCond +
    ' and ( d.planstartdate < ''' + DateToStr( F_DtBeg + 1 ) + ' 8:00:00'' )' +
    ' and ( d.planenddate >= ''' + DateToStr( F_DtBeg ) + ' 8:00:00'' )' +
    ' and not( d.fk_departures_equipment is null) ' +
    ' order by  12, 1, 15' );

  dset.First;
  while not dset.Eof do
  begin
  {  dset_OrderInfo.Close;
    dset_OrderInfo.ParamByName( 'pOrderID' ).AsInteger :=
      dset.FieldByName( 'fk_depworks_order' ).AsInteger;
    dset_OrderInfo.Open;
   }
    _ton := dset.FieldByName( 'OrderNumber' ).AsInteger;
    if _on <>  _ton then
    begin
      _on := _ton;
      with ResultDset do
      begin
        Append;
        FieldByName( 'PlanStartDate' ).AsDateTime := dset.FieldByName( 'planstartdate' ).AsDateTime;
        FieldByName( 'PlanStartTime' ).AsString :=
       //     MyFormatStartEndDate(dset.FieldByName( 'planstartdate' ).AsDateTime,
       //                           dset.FieldByName( 'planenddate' ).AsDateTime, false);
            formatdatetime('hh:mm', dset.FieldByName( 'planstartdate' ).AsDateTime) ;


        FieldByName( 'Adres' ).AsString := dset.FieldByName( 'adres' ).AsString;
        FieldByName( 'OrderNumber' ).AsInteger := _on;  // dset.FieldByName( 'OrderNumber' ).AsInteger;
        FieldByName( 'dlname' ).AsString := dset.FieldByName( 'dlname' ).AsString;
        if dset.FieldByName( 'fk_departures_equipment' ).AsInteger = -1 then
          FieldByName( 'Equip' ).AsString := ' - '
        else
          FieldByName( 'Equip' ).AsString := dset.FieldByName( 'Equip' ).AsString;
        FieldByName( 'region' ).AsString := dset.FieldByName( 'region' ).AsString;
        FieldByName( 'BrigName' ).AsString := dset.FieldByName( 'BrigName' ).AsString;
        Post;
      end;
    end;
    dset.Next;
  end;
  dset.Close;
end;

function Tdm_RazrtDep.PrepareDset: boolean;
begin
  Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_PlanDep.PrepareDset)' );
    end;
  end;
end;





end.
