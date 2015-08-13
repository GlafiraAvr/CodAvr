unit NODSBezVodyDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB, RxMemDS,
  IBDatabase, IBCustomDataSet, DateUtils;

type
  Tdm_NODSBezVody = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    tran: TIBTransaction;
    md_res: TRxMemoryData;
    md_resid: TIntegerField;
    md_resdatecoming: TDateTimeField;
    md_resdateclosed: TDateTimeField;
    md_resordernumber: TIntegerField;
    md_resadres: TStringField;
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
    IntegerField1: TIntegerField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField3: TStringField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    ResultDsets_dt_bolt_close: TStringField;
    ResultDsets_dt_bolt_open: TStringField;
    ResultDsetBoltAdres: TStringField;
    ResultDsetdiameter: TStringField;
    ResultDsets_hours: TStringField;
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_strRegionsID: string;
    F_NCDP: boolean;
  private
    function PrepareRes: boolean;
    function PrepareResNG: boolean;    
    function GetRegCondition: string;
    procedure FillResultDset(dttm_beg, dttm_end: TDateTime);

  public
    property Dt_beg: TDate write F_Dt_beg;
    property Dt_end: TDate write F_Dt_end;
    property strRegionsID: string write F_strRegionsID;
    property NCDP: boolean write F_NCDP;
    function PrepareDsets: boolean;
  end;

var
  dm_NODSBezVody: Tdm_NODSBezVody;

implementation

{$R *.dfm}
uses HelpFunctions;

{ Tdm_VAbonBezVody }

function Tdm_NODSBezVody.PrepareDsets: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
  //  Result:=PrepareRes;
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

function Tdm_NODSBezVody.PrepareRes: boolean;
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
  md_res.Close;
  md_res.Open;

  dttm_beg:=StrToDateTime(DateToStr(F_Dt_beg)+' 00:00:00');
  dttm_end:=StrToDateTime(DateToStr(F_Dt_end)+' 23:59:59');
  if F_strRegionsID<>'' then reg_cond:=' and (o.fk_orders_regions in'+F_strRegionsID+')'
  else reg_cond:='';

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

    {Находим max_delta}
    while not dset.Eof do
    begin
      dttm_zakr:=dset.FieldByName('dt_bolt_close').AsDateTime;
      dttm_otkr:=dset.FieldByName('dt_bolt_open').AsDateTime;

      if dset.FieldByName('IsClosed').AsInteger=0 then
        if dttm_otkr=0 then dttm_otkr:=now
       else
        if frac(dttm_otkr)=0 then
          dttm_otkr:=trunc(dttm_otkr)+frac(dset.FieldByName('DateClosed').AsDateTime);

      if (dttm_zakr<=dttm_end) and (dttm_otkr>=dttm_beg) then //проверяем временной интервал
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
    {/Находим max_delta}

    if (F_NCDP and  (max_delta>=LIMIT_HOURS)) or (not(F_NCDP) and (max_delta>LIMIT_HOURS)) then
    begin
      {Добавляем строку в результирующий набор данных}
      md_res.Append;

      for i:=0 to dset.FieldCount-1 do
        md_res.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
      if F_NCDP then md_res.FieldByName('hours').AsInteger:=max_delta div 24
        else
        md_res.FieldByName('hours').AsInteger:=max_delta;
      md_res.FieldByName('main_gr').AsInteger:=1;

      md_res.Post;
      {/Добавляем строку в результирующий набор данных}
    end;

    IncProgressStatus(progress_shag);
    dset.Next;
  end; //end 1-st while not Eof

  Result:=true;
end;


function Tdm_NODSBezVody.PrepareResNG: boolean;
var
  dttm_beg, dttm_end: TDateTime;
  progress_shag, i: integer;
  _SQL: string;
begin

  ResultDset.Close;
  ResultDset.Open;

  Result:=false;

  dttm_beg:=StrToDateTime(DateToStr(F_Dt_beg)+' 00:00:00');
  dttm_end:=StrToDateTime(DateToStr(F_Dt_end)+' 23:59:59');

  progress_shag:=GetProgressShagLength(100, dset.RecordCount)*2; // хер его знает почему только до половины

    //

        _SQL := ' select o.id, o.DateComing, o.DateClosed, o.ordernumber,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres,'+
    ' (select adres from Get_adres(cb.FK_CLOSEDBOLTS_HOUSETYPE, cb.FK_CLOSEDBOLTS_STREETS '+
    ', cb.HOUSENUM, cb.ADDITIONALADDRESS)) BoltAdres, '+
    ' o.fk_orders_regions, o.isclosed,'+
    ' sr.name as regions,'+
    ' cb.closedate as dt_bolt_close, cb.opendate as dt_bolt_open'+
    ' , (select diameter from S_TUBEDIAMETER where id = cb.FK_CLOSEDBOLTS_TUBEDIAM) diameter '+
    ' from orders o, s_regions sr, closedbolts cb'+
    ' where (o.fk_orders_damageplace in (1,2,3))'+
    GetRegCondition+
    ' and (o.fk_orders_regions=sr.id) and (cb.fk_closedbolts_orders=o.id)'+
    ' and ('+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.dateclosed>'''+DateTimeToStr(dttm_beg)+''') and (o.isclosed=1)) or'+
    '     ((o.datecoming<='''+DateTimeToStr(dttm_end)+''') and (o.isclosed=0))'+
    ' )'+
    ' order by sr.name, o.datecoming, cb.closedate';

  MyOpenIBDS(dset, _SQL );

  dset.Last;

  dset.First;

  FillResultDset(dttm_beg, dttm_end);
  dset.Close;

    IncProgressStatus(progress_shag);

  Result := true;
end;


function Tdm_NODSBezVody.GetRegCondition: string;
begin
  if F_strRegionsID<>'' then Result:=' and (o.fk_orders_regions in'+F_strRegionsID+')'
  else Result:='';
end;

procedure Tdm_NODSBezVody.FillResultDset(dttm_beg, dttm_end: TDateTime);
var delta, max_delta, tek_id, i, LIMIT_HOURS, _Count : integer;
    dttm_zakr, dttm_otkr: TDateTime;
    sdt_Close, sdt_Open, _adr_tmp, _diam_tmp, _s_hours: string;

  function GetCount6(dt_open, dt_close: TDateTime): integer;
  var _dt1, _dt2: TDateTime;
      _cd : integer;
       i, res: integer;
  begin
   res := 0;
   _cd := (abs((trunc(dt_open)) - (trunc(dt_close))));
   if _cd > 0 then
    begin
      res := _cd-1; // все полные сутки
      if abs(HoursBetween( dt_open, trunc(dt_open + 1))) >6 then inc(res); //начало первых суток
      if abs(HoursBetween( dt_close, trunc(dt_close))) >6 then inc(res); //остаток последних
    end
   else
    if ( _cd = 0 )and( HoursBetween( dt_open, dt_close ) > 6 ) then res := 1;

    Result := res;
  end;

  Procedure GetMaxDelta;
  var _ct, _sum : integer;
      NextOrder: boolean;
      _sep, _empty_sep: string;
  begin
    _ct := 0;
    _sep:='';
    _empty_sep := '';
    while not dset.Eof do
     begin
      _sum := 0;
      dttm_zakr:=dset.FieldByName('dt_bolt_close').AsDateTime;
      dttm_otkr:=dset.FieldByName('dt_bolt_open').AsDateTime;

      if dset.FieldByName('IsClosed').AsInteger=0 then
        if dttm_otkr=0 then dttm_otkr:=now
       else
        if frac(dttm_otkr)=0 then
          dttm_otkr:=trunc(dttm_otkr)+frac(dset.FieldByName('DateClosed').AsDateTime);

      if (dttm_zakr<=dttm_end) and (dttm_otkr>=dttm_beg) then //проверяем временной интервал
      begin
        //if dttm_zakr<dttm_beg then dttm_zakr:=dttm_beg;  // чтобы начало не обрезало
        if dttm_otkr>dttm_end then dttm_otkr:=dttm_end;

     {   if not _first then
         begin
           if (last_dttm_zakr >= dttm_otkr) then  //если время пересекается, то считаем как один отрезок
              begin
                dttm_otkr := last_dttm_otkr; // т.е. начало отодвигаем в начало прошлой записи и считаем как один кусок
                _sum := _sum - _ct;
              end
              else if (trunc(last_dttm_zakr) = trunc(dttm_otkr)) //в тот-же день есть промежуток между закрытиями задвижек
                     and (abs(HoursBetween( last_dttm_zakr, trunc(last_dttm_zakr)))<=6) // но прошлую часть не засчитали, то
                        then dttm_otkr := dttm_otkr - frac(last_dttm_zakr); // прибавляем время
                                                            //, т.е начало отодвигаем раньше на время остатка прошлой записи
         end;
   }

        _ct := GetCount6(dttm_otkr, dttm_zakr); // считаем новый кусок
        _sum := _sum + _ct;
        sdt_Close:= sdt_Close +_sep + DateTimeToStr(dset.FieldByName('dt_bolt_close').AsDateTime);
        if (dset.FieldByName('dt_bolt_open').AsDateTime > 0) then
          sdt_Open:= sdt_Open +_sep + DateTimeToStr(dset.FieldByName('dt_bolt_open').AsDateTime)
          else sdt_Open:= sdt_Open + _empty_sep + '- - - - -';

        delta:=HoursBetween(dttm_otkr, dttm_zakr);
        if delta>max_delta then max_delta:=delta;

        _s_hours := _s_hours + _empty_sep + IntToStr(delta div LIMIT_HOURS);
        _adr_tmp :=  _adr_tmp + _empty_sep + dset.FieldByName('BoltAdres').AsString;
        _diam_tmp := _diam_tmp + _empty_sep + dset.FieldByName('Diameter').AsString;
        _empty_sep := #13;
        _sep := '; '+ _empty_sep;



      end;
      dset.Next;
    //  NextOrder := (tek_id <> dset.FieldByName('id').AsInteger);

     _Count :=  _sum;
      if tek_id<>dset.FieldByName('id').AsInteger then
      begin
        dset.Prior;
        break;
      end;
    end;
  end;




begin

  if F_NCDP then LIMIT_HOURS := 24 else
     LIMIT_HOURS := 6;

  while not dset.Eof do
  begin
    if F_IsStopProgress then exit;

    delta:=-1;
    max_delta:=-1;
    tek_id:=dset.FieldByName('id').AsInteger;
    _Count := 0;
    {Находим max_delta}

    sdt_Close:= '';
    sdt_Open:= '';
    _adr_tmp:='';
    _s_hours := '';
    _diam_tmp := '';
    GetMaxDelta;

    {/Находим max_delta}


    if (F_NCDP and  (max_delta>=LIMIT_HOURS)) or (not(F_NCDP) and (max_delta>LIMIT_HOURS)) and (_Count > 0) then
    begin
      {Добавляем строку в результирующий набор данных}
      ResultDset.Append;

      for i:=0 to dset.FieldCount-1 do
        ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
      if F_NCDP then ResultDset.FieldByName('hours').AsInteger:=max_delta div 24
        else
        ResultDset.FieldByName('hours').AsInteger:=max_delta;

      ResultDset.FieldByName('s_hours').AsString:=_s_hours;

      ResultDset.FieldByName('main_gr').AsInteger:=1;
      ResultDset.FieldByName('BoltAdres').AsString:= _adr_tmp;
      ResultDset.FieldByName('Diameter').AsString:= _diam_tmp;
      ResultDset.FieldByName('s_dt_bolt_close').AsString := sdt_Close;
      ResultDset.FieldByName('s_dt_bolt_open').AsString := sdt_Open;
     // ResultDset.FieldByName('mCount').AsInteger:=_Count;
      ResultDset.Post;
      {/Добавляем строку в результирующий набор данных}
    end;

    dset.Next;
  end; //end 1-st while not Eof

end;


end.
