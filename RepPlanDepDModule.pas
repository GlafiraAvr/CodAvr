unit RepPlanDepDModule;         // Сводка планируемых выездов by Vadim 19.02.2009

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, FR_DSet, FR_DBSet,
  DB, kbmMemTable, IBCustomDataSet,  DModule, IBSQL;



type
  Tdm_PlanDep = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    ResultDset: TkbmMemTable;
    frDBResult: TfrDBDataSet;
    dset_OrderInfo: TIBDataSet;
    tran: TIBTransaction;
    ResultDsetPlanStartDate: TDateTimeField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetdlname: TStringField;
    ResultDsetEquip: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetPlanStartTime: TStringField;
    ResultDsetBrigName: TStringField;
    IBSQL: TIBSQL;
    tran_ex: TIBTransaction;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_RegionID: integer;
    F_excav,F_tripper,F_pumping:integer;
    F_is_Update:boolean;
//    F_frValueRec: TfrValueRec;
    F_RegionName:String;
    procedure FillResultDset;

    procedure updateDate();
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property RegionID: integer read F_RegionID write F_RegionID;
    function PrepareDset: boolean;
    property is_Update:boolean write F_is_Update;
    property  excav:integer write  F_excav;
    property tripper:integer write F_tripper;
    property pumping:integer write f_pumping;
    property RegionName: string read F_RegionName ;
  end;

var
  dm_PlanDep: Tdm_PlanDep;

implementation

{$R *.dfm}
uses HelpFunctions;

procedure Tdm_PlanDep.FillResultDset;
var _on, _ton : integer;
    _RegCond: string;
begin
  _on := 0;
  ResultDset.Close;
  ResultDset.Open;
{
select o.ordernumber, o.fk_orders_regions, d.id, d.StartDate, d.EndDate ,d.fk_departures_orders, d.DepNumber
        ,d.PLANSTARTDATE , d.PLANENDDATE, d.fk_departures_equipment,
        (select rtrim(name)||' №'||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,
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
//    ' (select rtrim(name)||'' №''||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,' +
    ' (select '' №''||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,' +
    ' (select name from s_regions where id = o.fk_orders_regions) region, '+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres, '+
    ' (select rtrim(sdl.name) from s_damagelocality sdl where sdl.id = o.fk_orders_damagelocality) dlname, '+
    ' d.depnumber ' +
    ' ,(select rtrim(name) from brigadiers where id = d.FK_DEPARTURES_BRIGADIERS ) BrigName, '+
    ' (select lowername from SPIDREGION where id = o.fk_orders_regions) regionname'  +
    ' from orders o , departures d '+
    ' where (o.id = d.fk_departures_orders) ' +
    _RegCond +
    ' and ( d.planstartdate < ''' + DateToStr( F_DtBeg + 1 ) + ' 8:00:00'' )' +
    ' and ( d.planenddate >= ''' + DateToStr( F_DtBeg ) + ' 8:00:00'' )' +
    ' and not( d.fk_departures_equipment is null) and   o.fk_orders_damageplace in (1,2,11) ' +

    ' and o.isclosed=0 '+
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
  if F_RegionID>0 then
   F_regionName := dset.fieldByname('regionname').AsString;
  dset.Close;
end;

function Tdm_PlanDep.PrepareDset: boolean;
begin
  Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
    if F_is_Update then updateDate();
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_PlanDep.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_PlanDep.updateDate();
const ex_SQL=' update or insert into  Svod_plan_Equip (saveddate, field, val ) values (''%s'', ''%s'',%d)'+
              ' matching  (saveddate, field) ';
begin
 try
  if tran_ex.InTransaction then tran_ex.Rollback;
   tran_ex.StartTransaction;
   MyExecIBSQL(IBSQL,Format(ex_SQL,[DateToStr(F_DtBeg),'Excav',F_excav]));
   MyExecIBSQL(IBSQL,Format(ex_SQL,[DateToStr(F_DtBeg),'Tripper',F_tripper]));
   MyExecIBSQL(IBSQL,Format(ex_SQL,[DateToStr(F_DtBeg),'Pumping',F_pumping]));
  tran_ex.Commit;



 except
  if tran.InTransaction then
    tran.Rollback;
 end;
end;

end.
