unit UtechkiNaVodosetiDModule;

interface

uses
  SysUtils, Classes, DB, RxMemDS, IBDatabase, IBCustomDataSet, DModule,
  Controls, NGReportBaseDModule, Forms, Windows, IBQuery, StDispDModule,
  FR_DSet, FR_DBSet, FR_Class, frOLEExl,Math;

const
  PROG_LENGTH=1000;

type
  TArr_Retznach = array[1..4] of double;

  Tdm_UtechkiNaVodoseti = class(Tdm_NGReportBase)
    md_Podacha: TRxMemoryData;
    md_Utechka: TRxMemoryData;
    dset: TIBDataSet;
    tran: TIBTransaction;
    dset_bolt: TIBDataSet;
    md_Utechkaregion: TStringField;
    md_Utechkadamage_count: TIntegerField;
    md_Utechkaleak: TFloatField;
    md_Utechkaleak_percent: TFloatField;
    dset_reg: TIBDataSet;
    md_Utechkamain_gr: TIntegerField;
    md_PodachaDonec: TFloatField;
    md_PodachaLednoe: TFloatField;
    md_PodachaSAVH: TFloatField;
    md_PodachaItogo: TFloatField;
    qry_StDisp: TIBQuery;
    tran_StDisp: TIBTransaction;
    frDS_Podacha: TfrDBDataSet;
    frDS_Utechka: TfrDBDataSet;
    md_Utechkaemptibg: TFloatField;
    md_Utechkaleak_kol: TFloatField;
  private
    F_Dt_beg: TDate;
    F_Dt_end: TDate;
    F_TotalUtechka: double;
    F_TotalPodacha: double;
    F_TotalDamageCount: integer;

    F_TotalEmpting:double;
    F_TotalLeak_KOl:double;
  private
    function Get_Leak(id_reg: integer;id_amegeplece:string=''): double;
    function Get_Damage_Count(id_reg: integer): integer;
    function CalcLeak(FlowSpeed: double; DTTM_Order_Coming, DTTM_Order_Closed,
                      DTTM_1Dep_Start, DTTM_2Dep_Start, DTTM_Close_Bolt, DTTM_beg_cut,
                      DTTM_end_cut: TDateTime; IsWasDep: boolean): double;
    function LoadPodachaFromStDisp(var retznach : TArr_Retznach): boolean;
  private
    function PreparePodacha(percent: integer): boolean;
    function PrepareUtechka(percent: integer): boolean;
    function GetEmpting(id_reg:integer):double; //glasha 18.10.2012
  public
    property Dt_beg: TDate read F_Dt_beg write F_Dt_beg;
    property Dt_end: TDate read F_Dt_end write F_Dt_end;
    property TotalUtechka: double read F_TotalUtechka;
    property TotalPodacha: double read F_TotalPodacha;
    property TotalDamageCount: integer read F_TotalDamageCount;

    property TotalEmpting:double read F_TotalEmpting;
    property TotalLeak_KOl:double read F_TotalLeak_KOl;
    function PrepareDsets: boolean;

  end;


implementation

{$R *.dfm}

uses HelpFunctions, StringConsts;


function Tdm_UtechkiNaVodoseti.CalcLeak(FlowSpeed: double;
  DTTM_Order_Coming, DTTM_Order_Closed, DTTM_1Dep_Start, DTTM_2Dep_Start,
  DTTM_Close_Bolt, DTTM_beg_cut, DTTM_end_cut: TDateTime; IsWasDep: boolean): double;
var
  _BegPeriod, _EndPeriod, _CloseBolt: TDateTime;
  _DtNull: TDateTime;
begin
  _DtNull := StrToDate( '01.01.1990' );

  {Задаем начало периода}
  if ( DTTM_beg_cut > DTTM_Order_Coming ) then
    _BegPeriod := DTTM_beg_cut
  else
    _BegPeriod := DTTM_Order_Coming;
  {/Задаем начало периода}


  {Задаем дату и время перекрытия последней задвижки}
  if IsWasDep then
    _CloseBolt := trunc( DTTM_Close_Bolt ) + Frac( DTTM_1Dep_Start )
  else
    _CloseBolt := 0;
  {/Задаем дату и время перекрытия последней задвижки}

  {Задаем окончание периода}
  if IsWasDep and ( _CloseBolt > _DtNull ) and ( _CloseBolt < DTTM_end_cut ) then
    _EndPeriod := _CloseBolt
  else
    if ( DTTM_Order_Closed > _DtNull ) and ( DTTM_Order_Closed < DTTM_end_cut ) then
      _EndPeriod := DTTM_Order_Closed
    else
      _EndPeriod := DTTM_end_cut;
  {/Задаем окончание периода}

  Result := Round( FlowSpeed * 24 * ( _EndPeriod - _BegPeriod ) *100 ) / 100; //округляем до 2-х знаков

(*
  {С принцыпом подсчета не согласен,
  алгоритм был тупо взят из старых аварий}


  // Если не было выезда, считаем так как-будто не крутили задвижки
  if IsWasDep then
  begin
    _Time_1Dep := Frac( DTTM_1Dep_Start )
  end else
  begin
    _Time_1Dep := 0;
    DTTM_Close_Bolt := 0;
  end;
  //

  _DTTM_Dep := DTTM_Order_Coming;

  //Время перекрытия задвижки
  if DTTM_Close_Bolt <> 0 then
    _DTTM_Close := Trunc( DTTM_Close_Bolt ) + _Time_1Dep
  else
    _DTTM_Close := 0;

  //Выбираем меньшее из времени
  if ( DTTM_2Dep_Start > 0 ) and ( DTTM_2Dep_Start < DTTM_end_cut ) then
    DTTM_end_cut := DTTM_2Dep_Start;

  if ( _DTTM_Close > 0 ) and ( _DTTM_Close < DTTM_end_cut ) then
    DTTM_end_cut := _DTTM_Close;

  //Утечка за период
  if ( DTTM_beg_cut > _DTTM_Dep ) then
    _DTTM_Dep := DTTM_beg_cut;
  Result := round( FlowSpeed * 24 * ( DTTM_end_cut-_DTTM_Dep ) *100 ) / 100; //округляем до 2-х знаков

*)

  //Проверка на маразм
  if Result < 0 then Result := 0;
end;

function Tdm_UtechkiNaVodoseti.Get_Damage_Count(id_reg: integer): integer;
begin
  MyOpenIBDS(dset,
    ' select count(*) kol'+
    ' from orders o'+
    ' where (o.flowspeed>0)'+
    ' and (o.fk_orders_damageplace in(1,2,3,4,7))'+
    ' and (o.fk_orders_regions='+IntToStr(id_reg)+')'+
    ' and  (o.DateComing<'''+DateTimeToStr(F_Dt_end)+''')'+
    ' and ((o.DateClosed>='''+DateTimeToStr(F_Dt_beg)+''') or (o.DateClosed is null))');

  Result:=dset.FieldByName('kol').AsInteger;
end;

function Tdm_UtechkiNaVodoseti.Get_Leak(id_reg: integer;id_amegeplece:string): double;
  function GetMaxClosedBoltsDate(id_order: integer): TDate;
  begin
    MyOpenIBDS(dset_bolt,
      ' select max(CloseDate) max_dt'+
      ' from ClosedBolts'+
      ' where fk_closedbolts_orders='+IntToStr(id_order));
    Result:=dset_bolt.FieldByName('max_dt').AsDateTime;
  end;
  function get_damageplace():string;
  begin
   if id_amegeplece='' then
    Result:='1,2,3,7'
   else
    Result:=id_amegeplece;
  end;
begin
  Result:=0;

  MyOpenIBDS(dset,
    ' select o.id, o.DateComing, o.DateClosed,'+
    ' (select StartDate from departures where (fk_departures_orders=o.id)'+
    '     and (DepNumber=1) and (FK_DEPARTURES_BRIGADIERS<>-1) ) Dep1Start,'+
    ' (select min(StartDate) from departures where (fk_departures_orders=o.id)'+
    '     and (DepNumber<>1)) Dep2Start,'+
    ' o.FlowSpeed, '+
    '(select Leak from get_leak_for_period(o.id, '''+DateTimeToStr(F_Dt_beg)+''', '''+DateTimeToStr(F_Dt_end)+''')) Leak '+
    ' from orders o'+
    ' where (o.flowspeed>0)'+
    ' and (o.fk_orders_regions='+IntToStr(id_reg)+')'+
    ' and (o.fk_orders_damageplace in('+get_damageplace+'))'+
    ' and  (o.DateComing<='''+DateTimeToStr(F_Dt_end)+''')'+
    ' and ((o.DateClosed>='''+DateTimeToStr(F_Dt_beg)+''') or (o.DateClosed is null))');

  with dset do
  begin
    dset.First;
    while not dset.Eof do
    begin
      Result:=Result+FieldByName( 'Leak' ).AsFloat;
      {CalcLeak(FieldByName( 'FlowSpeed' ).AsFloat,
                              FieldByName( 'DateComing' ).AsDateTime,
                              FieldByName( 'DateClosed' ).AsDateTime,
                              FieldByName( 'Dep1Start' ).AsDateTime,
                              FieldByName( 'Dep2Start' ).AsDateTime,
                              GetMaxClosedBoltsDate( FieldByName( 'id' ).AsInteger ),
                              F_Dt_beg,
                              F_Dt_end,
                              (not FieldByName( 'Dep1Start' ).IsNull ) );}
      dset.Next;
    end;  //end  while not dset_eof
  end; //end with
end;

function Tdm_UtechkiNaVodoseti.LoadPodachaFromStDisp(var retznach : TArr_Retznach): boolean;
var
  dm_StDisp: Tdm_StDisp;
  dt_beg, dt_end: TDate;
  tm_beg, tm_end: TTime;
  i: integer;
begin
  Result:=true;
  
  dm_StDisp:=Tdm_StDisp.Create(nil);
  tran_StDisp.DefaultDatabase := dm_StDisp.IBDB_StDisp;
  try
    if dm_StDisp.ConnectToStDispBase('ST_DISP', 'R_onlY') then
    begin
      if tran_StDisp.InTransaction then
        tran_StDisp.Rollback;
      tran_StDisp.StartTransaction;
      try
        dt_beg:=trunc(F_Dt_beg);
        dt_end:=trunc(F_Dt_end);
        tm_beg:=frac(F_Dt_beg);
        tm_end:=frac(F_Dt_end);

        if tm_beg=0 then
        begin
          tm_beg:=1/24;
          dt_beg:=dt_beg-1;
        end;
        if tm_end=0 then
        begin
          tm_end:=1/24;
          dt_end:=dt_end-1;
        end;

        with qry_StDisp do
        begin
          ParamByName('date1').AsDate:=dt_beg;
          ParamByName('date2').AsDate:=dt_end;
          ParamByName('time1').AsTime:=(tm_beg-1/24);
          ParamByName('time2').AsTime:=(tm_end-1/24);
          Prepare;
          Open;
          for i:=1 to 4 do
            retznach[i]:=0;
          First;
          while not Eof do
          begin
            case FieldByName('kpodr').AsInteger of
              35:retznach[1]:=FieldByName('znach').AsFloat;
              45:retznach[2]:=FieldByName('znach').AsFloat;
              8..14:retznach[3]:=retznach[3]+FieldByName('znach').AsFloat;
            end;
            Next;
          end;
          qry_StDisp.Close;
        end;  //end with qry_StDisp
        retznach[4]:=retznach[1]+retznach[2]+retznach[3]+retznach[4];

        tran_StDisp.Commit;
      except
        on E: Exception do
        begin
          tran_StDisp.Rollback;
          Result:=false;
          dm_StDisp.Free;
          Application.MessageBox(PChar(E.Message+'(Tdm_UtechkiNaVodoseti.LoadPodacha)'),
                        gc_strDispAVR, MB_OK+MB_ICONERROR);
        end;
      end;
    end;
  finally
    dm_StDisp.Free;
  end;
end;

function Tdm_UtechkiNaVodoseti.PrepareDsets: boolean;
begin
  Result:=true;

  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    if not PreparePodacha(10) then Result:=false
    else
    if not PrepareUtechka(90) then Result:=false;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_UtechkiNaVodoseti.PrepareDsets)');
    end;
  end;
end;

function Tdm_UtechkiNaVodoseti.PreparePodacha(percent: integer): boolean;
var
  ret_arr: TArr_Retznach;
  i, progress_shag: integer;
  res_str: string;
begin
  Result:=false;

  if F_IsStopProgress then exit;

  md_Podacha.Close;
  md_Podacha.Open;
  md_Podacha.Append;

  if LoadPodachaFromStDisp(ret_arr) then
  begin
    for i:=1 to 4 do
      md_Podacha.Fields[i-1].AsFloat:=ret_arr[i];
    F_TotalPodacha:=ret_arr[4];
  end else
  begin
    for i:=1 to 4 do
      md_Podacha.Fields[i-1].AsFloat:=-1;
    F_TotalPodacha:=-1;
  end;
  md_podacha.Post;
  IncProgressStatus(GetProgressShagLength(percent, 1));

  Result:=true;
end;

function Tdm_UtechkiNaVodoseti.PrepareUtechka(percent: integer): boolean;
const
  SHAG_COUNT=10;
var
  leak: double;
  damage_count: integer;
  progress_shag: integer;
  empting:double;
  leak_kol:double;
begin
  Result:=false;

  progress_shag:=GetProgressShagLength(percent, SHAG_COUNT);

  md_Utechka.Close;
  md_Utechka.Open;

  F_TotalDamageCount:=0;
  F_TotalUtechka:=0;
  F_Totalempting:=0;
  F_TotalLeak_KOl:=0;

  {Заносим основные данные}
  MyOpenIBDS(dset_reg,
    ' select id, name'+
    ' from s_regions'+
    ' where (activity is null) and (id>0)'+
    ' order by name');

  dset_reg.First;
  while not dset_reg.Eof do
  begin
    if F_IsStopProgress then exit;

    md_Utechka.Append;

    damage_count:=Get_Damage_Count(dset_reg.FieldByName('id').AsInteger);
    leak:=Get_Leak(dset_reg.FieldByName('id').AsInteger);
    empting:=GetEmpting(dset_reg.fieldbyname('id').AsInteger);
    Leak_kol:=Get_Leak(dset_reg.FieldByName('id').AsInteger,'4');

    F_TotalDamageCount:=F_TotalDamageCount+damage_count;
    F_TotalUtechka:=F_TotalUtechka+leak;
    F_Totalempting:=F_Totalempting+empting;
    F_TotalLeak_KOl:=F_TotalLeak_KOl+Leak_kol;

    md_Utechka.FieldByName('main_gr').AsInteger:=1;
    md_Utechka.FieldByName('region').AsString:=trim(dset_reg.FieldByName('name').AsString);
    md_Utechka.FieldByName('damage_count').AsInteger:=damage_count;
    md_Utechka.FieldByName('leak').AsFloat:=leak;
    md_Utechka.FieldByName('leak_percent').AsFloat:=0;
    md_Utechka.FieldByName('empting').AsFloat:=empting;
    md_Utechka.FieldByName('leak_kol').AsFloat:=leak_kol;


    md_Utechka.Post;

    IncProgressStatus(progress_shag);
    dset_reg.Next;
  end;  //end while not dset_reg.eof
  {/Заносим основные данные}

  {считаем опроцент}
  with md_Utechka do
  begin
    First;
    while not md_Utechka.Eof do
    begin
      Edit;
      FieldByName('leak_percent').AsFloat:=round((FieldByName('leak').AsFloat/F_TotalUtechka)*100);
      Post;
      Next;
    end;
  end; //end with md_Utechka
  {/считаем процент}

  IncProgressStatus(progress_shag);

  Result:=true;
end;



function Tdm_UtechkiNaVodoseti.GetEmpting(id_reg:integer):double; //glasha 18.10.2012
begin
 MyOpenIBDS(dset,'select sum(dd.empting)  from departures dd, orders o '+
                 ' where '+
                 '  o.id=dd.fk_departures_orders and '+
                 '  dd.startdate<='''+DateTimeToStr(Dt_end)+''' and '+
                 '  (dd.enddate>= '''+DateTimeToStr(Dt_beg)+''' or (dd.enddate is null)) '+
                 '  and o.fk_orders_damageplace in (1,2,3,4,7) '+
                 '  and o.fk_orders_regions='+IntToStr(id_reg));
if dset.Fields[0].IsNull then
 Result:=0
else
  Result:=floor(dset.Fields[0].AsFloat*100)/100;
end;
end.
