unit RepPlanDenialDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, FR_DSet, FR_DBSet,
  DB, kbmMemTable, IBCustomDataSet,  DModule;

type
  Tdm_PlanDenial = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    ResultDset: TkbmMemTable;
    frDBResult: TfrDBDataSet;
    dset_OrderInfo: TIBDataSet;
    tran: TIBTransaction;
    ResultDsetPlanStartDate: TDateTimeField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetEquip: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetPlanStartTime: TStringField;
    dset2: TIBDataSet;
    ResultDsetdateclosed: TStringField;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_DtEnd: TDateTime;
    procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    function PrepareDset: boolean;
    function getequip(dset:TIBDataset; num:Integer;
                      Year, Month, Day: Word ):string;
{    function formSelectdset2:string;}

  end;

var
  dm_PlanDenial: Tdm_PlanDenial;

implementation

{$R *.dfm}
uses HelpFunctions;

{function formSelectdset2:string;
begin
  result:='select d.additionalinfo , d.fk_departures_orders, d.startdate '+
          'from departures d '+
           'where ';
  dset.first;
  while not dset.eof do
  begin
     result:= result + '(d.fk_departures_orders= ' + dset. перемен fk_departures_orders
            and cast (d.startdate as date) = премен cast (d.planstartdate) )
   or ( ...)
  end;
  dset.close;
end; }

function Tdm_PlanDenial.getequip(dset:TibDataset; num:integer;
                                 Year, Month, Day: Word ):string;
var
  Year1, Month1, Day1: Word;
begin
  dset.First;
  while not dset.Eof do
  begin
    DecodeDate(dset.FieldByName('startdate').AsDateTime,Year1,Month1,Day1);
    if ( dset.FieldByName('fk_departures_orders').Value=num) and
       ( Year1=year) and (Month1=Month) and (Day1=Day)
    then begin
           result:=dset.FieldByName('additionalinfo').AsString;
           exit;
         end
    else result:='';
    dset.Next;
  end;
end;

procedure Tdm_PlanDenial.FillResultDset;
var _on, _ton, in1: integer;
zap2: string;
tmpDate:string;
Year, Month, Day: Word;
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

 zap2:='select d.additionalinfo , d.fk_departures_orders, d.startdate '+
          'from departures d '+
           'where ';

  MyOpenIBDS( dset,
' select o.ordernumber, o.fk_orders_regions, d.id, d.StartDate, d.EndDate ,d.fk_departures_orders, d.DepNumber' +
    ' ,d.PLANSTARTDATE , d.PLANENDDATE, d.fk_departures_equipment,' +
    ' (select rtrim(name)||'' №''||cast(number as char(3)) from equipment  where id = d.fk_departures_equipment) Equip,' +
    ' (select name from s_regions where id = o.fk_orders_regions) region, '+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres, '+
    ' (select rtrim(sdl.name) from s_damagelocality sdl where sdl.id = o.fk_orders_damagelocality) dlname, '+
    ' d.depnumber , d.additionalinfo' +
    ' ,o.dateclosed, o.isclosed '+
    ' from orders o , departures d '+
    ' where (o.id = d.fk_departures_orders) ' +
    ' and ( d.planstartdate < ''' + DateToStr( F_DtEnd + 1 ) + ''' )' +
    ' and ( d.planenddate >= ''' + DateToStr( F_DtBeg ) + ''' )' +
    ' and (not( d.fk_departures_equipment is null)) ' +
    ' and (((o.id = d.fk_departures_orders) and(o.isclosed !=1)) or '+
    ' ((o.id = d.fk_departures_orders) and (cast(o.dateclosed as date) > cast(d.planenddate as date)) '+
    '  and (o.isclosed =1)))'+
    ' order by  12, 1, 15' );


  dset.first;
  in1:=0;
  while not dset.eof do
  begin
     if (in1 <> 0) then
     begin
      zap2:=zap2 + ' or '
     end
     else
       in1:=1;

     zap2:= zap2 + '(d.fk_departures_orders= ' + dset.FieldByName('fk_departures_orders').AsString;
     zap2:=zap2+ ' and cast (d.startdate as date) = '
         + 'cast (''';
     tmpDate:=DateTimeToSTR( dset.FieldByName('planstartdate').AsDateTime);
     setlength(tmpDate,10);
     zap2:=zap2+ tmpDate
         + ''' as date ) )';
   dset.Next;
  end;
  if in1 > 0 then
       begin
        MyopenIBDS(dset2,zap2);

         dset.First;
        while not dset.Eof do
        begin
        {  dset_OrderInfo.Close;
          dset_OrderInfo.ParamByName( 'pOrderID' ).AsInteger :=
            dset.FieldByName( 'fk_depworks_order' ).AsInteger;
          dset_OrderInfo.Open;
         }
          _ton := dset.FieldByName( 'OrderNumber' ).AsInteger;
         // if _on <>  _ton then
          begin
            _on := _ton;
            with ResultDset do
            begin
              Append;
              FieldByName( 'PlanStartDate' ).AsDateTime := dset.FieldByName( 'planstartdate' ).AsDateTime;
              FieldByName( 'PlanStartTime' ).AsString :=
                  MyFormatStartEndDate(dset.FieldByName( 'planstartdate' ).AsDateTime,
                                       dset.FieldByName( 'planenddate' ).AsDateTime, false);
      {            formatdatetime('hh:mm', dset.FieldByName( 'planstartdate' ).AsDateTime) +
                  ' - ' +
                  formatdatetime('hh:mm', dset.FieldByName( 'planenddate' ).AsDateTime) ;}
              FieldByName( 'Adres' ).AsString := dset.FieldByName( 'adres' ).AsString;
              FieldByName( 'OrderNumber' ).AsInteger := _on;  // dset.FieldByName( 'OrderNumber' ).AsInteger;
              FieldByName( 'dlname' ).AsString := dset.FieldByName( 'dlname' ).AsString;
              DecodeDate(dset.FieldByName('planstartdate').AsDateTime,Year,Month,Day);

              if dset.FieldByName('isclosed').AsInteger = 1 then
                  FieldByName('dateclosed').AsString := dset.FieldByName('dateclosed').AsString ;
//                  else
//                  FieldByName('dateclosed').AsString := '';

              FieldByName( 'Equip' ).AsString :=getequip(dset2,
                                                         dset.FieldByName('fk_departures_orders').AsInteger,
                                                         Year,Month,Day);
              //FieldByName( 'Equip' ).AsString := dset.FieldByName( 'Equip' ).AsString;
              FieldByName( 'region' ).AsString := dset.FieldByName( 'region' ).AsString;
              Post;
              //a1=dset.FieldByName( 'planstartdate' ).AsDateTime
              //a2=d.fk_departures_orders

            end;
          end;
          dset.Next;
        end;
       end; // in1 > 0
  dset.Close;
end;

function Tdm_PlanDenial.PrepareDset: boolean;
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
      raise Exception.Create( E.Message + '(Tdm_PlanDenial.PrepareDset)' );
    end;
  end;
end;


end.
