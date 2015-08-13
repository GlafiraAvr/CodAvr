unit VAbonBezVodyDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, DModule, RxMemDS, IBDatabase, DB,
  IBCustomDataSet, DateUtils, FR_Class, FR_DSet, FR_DBSet;

type
  Tdm_VAbonBezVody = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    tran: TIBTransaction;
    md_res: TRxMemoryData;
    md_resid: TIntegerField;
    md_resdatecoming: TDateTimeField;
    md_resdateclosed: TDateTimeField;
    md_resadres: TStringField;
    md_resordernumber: TIntegerField;
    md_resdisconnections: TStringField;
    md_resfk_orders_regions: TIntegerField;
    md_resisclosed: TIntegerField;
    md_resregions: TStringField;
    md_resdt_bolt_close: TDateTimeField;
    md_resdt_bolt_open: TDateTimeField;
    md_reshours: TIntegerField;
    md_resmain_gr: TIntegerField;
    frDS_res: TfrDBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetordernumber: TIntegerField;
    ResultDsetdatecoming: TDateTimeField;
    ResultDsetadres: TStringField;
    ResultDsetregions: TStringField;
    ResultDsetdisconadres: TStringField;
    ResultDsetdttm_discon: TDateTimeField;
    ResultDsetdttm_con: TDateTimeField;
    ResultDsethours: TIntegerField;
    ResultDsetmain_gr: TIntegerField;
    ResultDsetMonth: TStringField;
    ResultDsetdateclosed: TDateTimeField;
    ResultDsetfk_orders_regions: TIntegerField;
    ResultDsetid: TIntegerField;
    ResultDsetMCount: TIntegerField;
    ResultDsetsdt_open: TStringField;
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_strRegionsID: string;
    F_NCDP: boolean;
    F_all:boolean; //glasha 14.11.2012
    F_Streets:string ;//glasha 09.04.2014
  private
    function PrepareRes: boolean;
    function PrepareResNG: boolean;
    function PrepareResForMonth(dttm_beg, dttm_end: TDateTime): boolean;
    function GetRegCondition: string;
    procedure FillResultDset(dttm_beg, dttm_end: TDateTime; _sMonth: string);

  public
    property Dt_beg: TDate write F_Dt_beg;
    property Dt_end: TDate write F_Dt_end;
    property strRegionsID: string write F_strRegionsID;
    property NCDP: boolean write F_NCDP;
    function PrepareDsets: boolean;

    property All:boolean write F_all;
    property  Streets:string write  F_Streets;

  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_VAbonBezVody }

function Tdm_VAbonBezVody.PrepareDsets: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
 //   Result:=PrepareRes;
    Result:=PrepareResNG;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_VAbonBezVody.PrepareDsets)');
    end;
  end;
end;

function Tdm_VAbonBezVody.PrepareRes: boolean;
//const
//  LIMIT_HOURS=6;
var
  dttm_beg, dttm_end: TDateTime;
  dttm_zakr, dttm_otkr: TDateTime;
  delta, max_delta: integer;
  tek_id, i: integer;
  bookmark: string;
  progress_shag: integer;
  reg_cond: string;
  LIMIT_HOURS: integer;
begin
  Result:=false;
  if F_NCDP then LIMIT_HOURS := 24 else LIMIT_HOURS := 6;
  if F_All then LIMIT_HOURS:=0;
  md_res.Close;
  md_res.Open;

  dttm_beg:=StrToDateTime(DateToStr(F_Dt_beg)+' 00:00:00');
  dttm_end:=StrToDateTime(DateToStr(F_Dt_end)+' 23:59:59');
  if F_strRegionsID<>'' then reg_cond:=' and (o.fk_orders_regions in'+F_strRegionsID+')'
  else reg_cond:='';
  if F_Streets<>'' then reg_cond:=reg_cond+' and (o.FK_ORDERS_STREETS in '+ F_Streets+ ')';



{  MyOpenIBDS(dset,
    ' select o.id, o.DateComing, o.DateClosed, o.ordernumber,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres,'+
    ' o.disconnections, o.fk_orders_regions, o.isclosed,'+
    ' sr.name as regions,'+
    ' cb.closedate as dt_bolt_close, cb.opendate as dt_bolt_open'+
    ' from orders o, s_regions sr, closedbolts cb'+
    ' where (o.fk_orders_damageplace in (1,2,3))'+
    reg_cond+
    ' and (o.fk_orders_regions=sr.id) and (cb.fk_closedbolts_orders=o.id)'+
    ' and'+
    ' ('+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.dateclosed>'''+DateTimeToStr(dttm_beg)+''') and (o.isclosed=1)) or'+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.isclosed=0))'+
    ' )'+
    ' order by sr.name, o.datecoming, cb.closedate');}

  MyOpenIBDS(dset,
    ' select o.id, o.DateComing, o.DateClosed, o.ordernumber,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres,'+
    ' (select disconadress from get_disconnections(o.id, 0)) Disconnections, '+
    ' o.fk_orders_regions, o.isclosed,'+
    ' sr.name as regions,'+
    ' cb.closedate as dt_bolt_close, cb.opendate as dt_bolt_open'+
    ' from orders o, s_regions sr, closedbolts cb'+
    ' where (o.fk_orders_damageplace in (1,2,3))'+
    reg_cond+
    ' and (o.fk_orders_regions=sr.id) and (cb.fk_closedbolts_orders=o.id)'+
    ' and'+
    ' ('+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.dateclosed>'''+DateTimeToStr(dttm_beg)+''') and (o.isclosed=1)) or'+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.isclosed=0))'+
    ' )'+
    ' order by sr.name, o.datecoming, cb.closedate');


  dset.Last;

  progress_shag:=GetProgressShagLength(100, dset.RecordCount)*2; // хер его знает почему только до половины

  dset.First;
  while not dset.Eof do
  begin
    if F_IsStopProgress then exit;

    delta:=-1;
    max_delta:=-1;
    tek_id:=dset.FieldByName('id').AsInteger;

    {Ќаходим max_delta}
    while not dset.Eof do
    begin
      dttm_zakr:=dset.FieldByName('dt_bolt_close').AsDateTime;
      dttm_otkr:=dset.FieldByName('dt_bolt_open').AsDateTime;

      if dset.FieldByName('IsClosed').AsInteger=0 then
        if dttm_otkr=0 then dttm_otkr:=now
       else
        if frac(dttm_otkr)=0 then
          dttm_otkr:=trunc(dttm_otkr)+frac(dset.FieldByName('DateClosed').AsDateTime);

      if (dttm_zakr<=dttm_end) and (dttm_otkr>=dttm_beg) then //провер€ем временной интервал
      begin
        //if dttm_zakr<dttm_beg then dttm_zakr:=dttm_beg;  // чтобы начало не обрезало
        if dttm_otkr>dttm_end then dttm_otkr:=dttm_end;
        delta:=HoursBetween(dttm_otkr, dttm_zakr);
        if delta>max_delta then max_delta:=delta;
      end;

      dset.Next;
      if tek_id<>dset.FieldByName('id').AsInteger then
      begin
        dset.Prior;
        break;
      end;
    end;
    {/Ќаходим max_delta}

    if (F_NCDP and  (max_delta>=LIMIT_HOURS)) or (not(F_NCDP) and (max_delta>LIMIT_HOURS)) then
    begin
      {ƒобавл€ем строку в результирующий набор данных}
      md_res.Append;

      for i:=0 to dset.FieldCount-1 do
        md_res.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
      if F_NCDP then md_res.FieldByName('hours').AsInteger:=max_delta div 24
        else
        md_res.FieldByName('hours').AsInteger:=max_delta;
      md_res.FieldByName('main_gr').AsInteger:=1;

      md_res.Post;
      {/ƒобавл€ем строку в результирующий набор данных}
    end;

    IncProgressStatus(progress_shag);
    dset.Next;
  end; //end 1-st while not Eof

  Result:=true;
end;


function Tdm_VAbonBezVody.PrepareResNG: boolean;
var
  _dt_beg, _dt_end, dttm_beg, dttm_end: TDateTime;
  progress_shag, i: integer;
  C_MONTH : integer;
  year_beg, year_end ,month_beg, month_end, day_beg, day_end: word;

begin

  ResultDset.Close;
  ResultDset.Open;

  Result:=false;

  dttm_beg:=StrToDateTime(DateToStr(F_Dt_beg)+' 00:00:00');
  dttm_end:=StrToDateTime(DateToStr(F_Dt_end)+' 23:59:59');

  DecodeDate( dttm_beg, year_beg, month_beg, day_beg);
  DecodeDate( dttm_end, year_end, month_end, day_end);
  C_MONTH := month_end - month_beg;
  if year_beg<year_end then
   C_MONTH:=C_MONTH+(year_end-year_beg)*12;

  progress_shag:=GetProgressShagLength(100, dset.RecordCount)*2; // хер его знает почему только до половины

 for i := 0 to C_MONTH do begin
    if (i = 0) then
     _dt_beg := dttm_beg
     else
     begin
     month_beg:=month_beg+1;
     if month_beg>12 then
      begin
       year_beg:=year_beg+1;
       month_beg:=1;
      end;
     TryEncodeDate(year_beg, month_beg, 1, _dt_beg); // first day of month
     end;
    if i=C_MONTH then
     _dt_end := dttm_end
    else
     begin
       _dt_end:=LastMonthDay(month_beg,1,year_beg);

     //  TryEncodeDate(year_beg+i div 12, month_beg + i mod 12 + 1, 1 , _dt_end);
      // _dt_end := _dt_end - 1;// last day of month
     end;

    PrepareResForMonth(_dt_beg, _dt_end+1);   //

    IncProgressStatus(progress_shag);
  end;

  Result:=true;
end;

function Tdm_VAbonBezVody.PrepareResForMonth(dttm_beg, dttm_end: TDateTime): Boolean;
var    _SQL, bookmark, m1, m2: string;
begin

   _SQL := ' select o.ordernumber, o.datecoming '+
   ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres '+
   ' , sr.name regions '+
   ' , (select adres from Get_adres(0 , dc.fk_id_street, dc.houses, dc.additionalinfo)) disconadres '+
   ' , dc.dttm_discon , dc.dttm_con , o.dateclosed, o.fk_orders_regions, o.id'+
   ' , (select name from s_streets where id = dc.fk_id_street) streetname '+
   ' from disconnections dc, orders o  , s_regions sr ' +
   ' where (o.id = dc.fk_id_order )and (o.fk_orders_regions=sr.id)'+
{  '  and (o.fk_orders_damageplace in (1,2,3,10)) '}
   ' and (dc.fk_id_street is not null) '+
       ' and (dc.fk_id_street > 0)'+
       GetRegCondition+
       ' and (((dc.dttm_discon >= '''+DateTimeToStr(dttm_beg)+''') and (dc.dttm_discon < '''+DateTimeToStr(dttm_end)+'''))'+ {exbnsdftv gjcktlybt cenrb}
       ' or '+
       ' ((dc.dttm_discon<'''+DateTimeToStr(dttm_beg)+''') and ((dc.dttm_con>'''+DateTimeToStr(dttm_beg)+''') or (dc.dttm_con is null))))'+
       {смотрим отлько по дате начала отключени€!!}
      // ' and (dc.dttm_con <= '''+DateTimeToStr(dttm_end)+''' or dc.dttm_con is null )'+
    '   order by sr.name, 11';

  MyOpenIBDS(dset, _SQL);

  dset.Last;
  dset.First;

  m1 := FormatDateTime('mmmm', dttm_beg);
  m2 := FormatDateTime('mmmm', dttm_end);
  FillResultDset(dttm_beg, dttm_end, m1);
  dset.Close;
end;

function Tdm_VAbonBezVody.GetRegCondition: string;
begin
  if F_strRegionsID<>'' then Result:=' and (o.fk_orders_regions in'+F_strRegionsID+')'
  else Result:='';
  if F_Streets<>'' then REsult:=Result+' and (dc.FK_ID_STREET in '+F_Streets+')';
end;

procedure Tdm_VAbonBezVody.FillResultDset(dttm_beg, dttm_end: TDateTime; _sMonth: string);
var delta, max_delta, tek_id, i, LIMIT_HOURS, _Count: integer;
    dttm_zakr, dttm_otkr: TDateTime;

  function GetCount6(dt_open, dt_close: TDateTime): integer;
  var _dt1, _dt2: TDateTime;
      _cd : integer;
       i, res: integer;
  begin
   res := 0;
   _cd := (abs((trunc(dt_open) - trunc(dt_close))));
   if _cd > 0 then
    begin
      res := _cd-1; // все полные сутки
      if abs(HoursBetween( dt_open, trunc(dt_open))) >6 then inc(res); //остаток последних
     // if abs(HoursBetween( dt_close, trunc(dt_close + 1))) >6 then inc(res); //начало первых суток
      //считаем что 6ч  - 0.25 суток тогда
      if abs(dt_close - trunc(dt_close+1))>0.25 then inc(res);
    end
   else
    if ( _cd = 0 )and( HoursBetween( dt_open, dt_close ) > 6 ) then res := 1;

    Result := res;
  end;

  Procedure GetMaxDelta;
  var _ct, _sum : integer;
      NextOrder: boolean;
  begin
    _ct := 0;

    while not dset.Eof do
     begin
      _sum := 0;
      dttm_zakr:=dset.FieldByName('dttm_discon').AsDateTime;

      if dset.FieldByName('dttm_con').IsNull then dttm_otkr:=now else
        begin
          dttm_otkr:=dset.FieldByName('dttm_con').AsDateTime;
          if (frac(dttm_otkr)=0) and (not dset.FieldByName('DateClosed').IsNull) then
            dttm_otkr:=trunc(dttm_otkr)+frac(dset.FieldByName('DateClosed').AsDateTime);
        end;

      if (dttm_zakr<=dttm_end) and (dttm_otkr>=dttm_beg) then //провер€ем временной интервал
      begin
        //if dttm_zakr<dttm_beg then dttm_zakr:=dttm_beg;  // чтобы начало не обрезало
        if dttm_otkr>dttm_end then dttm_otkr:=dttm_end;

        _ct := GetCount6(dttm_otkr, dttm_zakr); // считаем новый кусок
        _sum := _sum + _ct;
        delta:=HoursBetween(dttm_otkr, dttm_zakr);
        if delta>max_delta then max_delta:=delta;
      end;
      dset.Next;
      NextOrder := (tek_id <> dset.FieldByName('id').AsInteger);

     _Count :=  _sum;
      if tek_id<>dset.FieldByName('id').AsInteger then
      begin
        dset.Prior;
        break;
      end;
    end;
  end;

  function GetDelta: integer;
  var _discon, _con: TDateTime;
  begin
      _discon:=dset.FieldByName('dttm_discon').AsDateTime;
      if  _discon < dttm_beg then
        _discon := dttm_beg;
      _con:=dset.FieldByName('dttm_con').AsDateTime;
      if (dset.FieldByName('dttm_con').IsNull) or (_con = 0) then _con:=now else
        begin
          if (frac(_con)=0) and not dset.FieldByName('DateClosed').IsNull then
            _con:=trunc(_con)+frac(dset.FieldByName('DateClosed').AsDateTime);
        end;
      if (_discon<=dttm_end) and (_con>=dttm_beg) then //провер€ем временной интервал
      begin
        if _con>dttm_end then _con:=dttm_end;
        delta:=HoursBetween(_con+0.0001, _discon); //глючит при 23:00 не ечитывает последний час
        _Count := GetCount6(_con+0.0001, _discon); //не учитывает последний час если целое часов
      end;
      Result := delta;
  end;



begin

  if F_NCDP then LIMIT_HOURS := 24 else
     LIMIT_HOURS := 6;
   if F_All then LIMIT_HOURS := 0;

  while not dset.Eof do
  begin
    if F_IsStopProgress then exit;

    delta:=-1;
    max_delta:=-1;
    _Count := 0;
    {Ќаходим max_delta}
   // GetMaxDelta;
    max_delta := GetDelta;
    {/Ќаходим max_delta}

    if (F_NCDP and  (max_delta>=LIMIT_HOURS)) or (not(F_NCDP) and (max_delta>LIMIT_HOURS)or(F_ALL)) then
    begin
      {ƒобавл€ем строку в результирующий набор данных}
      ResultDset.Append;

      for i:=0 to dset.FieldCount-2 do
        ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
    {
     if (dset.FieldByName('dttm_con').AsDateTime > 0) then
        ResultDset.FieldByName('sdt_open').AsString  sdt_Open:=  DateTimeToStr(dset.FieldByName('dttm_con').AsDateTime)
          else  ' ';
     }

      if F_NCDP then ResultDset.FieldByName('hours').AsInteger:=max_delta div 24
        else
        ResultDset.FieldByName('hours').AsInteger:=max_delta;
      ResultDset.FieldByName('main_gr').AsInteger:=1;
      ResultDset.FieldByName('Month').AsString:= _sMonth;// FormatDateTime('mmmm', dttm_otkr) ;
      ResultDset.FieldByName('mCount').AsInteger:=_Count;
      ResultDset.Post;
      {/ƒобавл€ем строку в результирующий набор данных}
    end;

    dset.Next;
  end; //end 1-st while not Eof

end;

end.
