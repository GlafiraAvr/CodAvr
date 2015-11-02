unit DModule;

interface

uses
  SysUtils, Classes, DB, IBDatabase, Dialogs, IBCustomDataSet,
  IBSQL, Forms, Windows, IB, IBErrorCodes, ExtCtrls, IBQuery,
  DateUtils, ADODB ;

type
  TDM_Main = class(TDataModule)
    IBDatabase: TIBDatabase;
    Tr_RCommited: TIBTransaction;
    Tr_RWSnapshot: TIBTransaction;
    Tr_ROTableStab: TIBTransaction;
    Tr_RWCommited: TIBTransaction;
    dset_tmp: TIBDataSet;
    Tr_tmp: TIBTransaction;
    IBDatabaseVDS: TIBDatabase;
    Timer1: TTimer;
    dset_tmp2: TIBDataSet;
	IBQSmena: TIBQuery;
    IBQNewHost: TIBQuery;
    ADOConn_1562: TADOConnection;
    ADOQ_ost1562: TADOQuery;
    dset_time: TIBDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IBDatabaseBeforeDisconnect(Sender: TObject);
  private
    List_dsets:TLISt;
    function getServerTime():TDateTime;
  public
    function Connect(const UserName: string; const Password: string): boolean;
    function ConnectVDS(const UserName: string; const Password: string): boolean;
    procedure Disconnect;
    procedure DisconnectVDS;
//    function Connect1562(const UserName: string; const Password: string): boolean;
///    procedure Disconnect1562;
   

    function GetAdres(id_HouseType, id_street: integer; HouseNum: string; AddAdres: string=''): string; overload;
    function GetAdres( _tran: TIBTransaction; id_HouseType, id_street: integer; HouseNum: string; AddAdres: string=''): string; overload;
    function IsNeedToChangeShift: boolean;
    function IsNeedToInputTemper: boolean;
    function GetIDOfficialPost(id_Official: integer): integer;
    function GetNewSessionID: integer;
	function IsNeedToChangeShiftBlock(showmess:boolean): boolean;
   function ConnectADO1562(const UserName, Password: string): boolean;
   procedure DisconectADO1562;
    function ReconnectAll:boolean;
  end;

function ReconnectAll(Base:TIBDataBase):boolean;
procedure MyOpenSQL(IBDataSet: TIBDataSet; const SQL: string);
procedure MyExecSQL(IBSQL: TIBSQL; const SQL: string);

var
  DM_Main: TDM_Main;
  
implementation

{$R *.dfm}

uses ApplicationSettings, HelpFunctions, StringConsts,
  RightsManagerDModule, MainForm;

{ TDM_Main }

procedure MyOpenSQL(IBDataSet: TIBDataSet; const SQL: string);
begin
  IBDataSet.Close;
  IBDataSet.SelectSQL.Clear;
  IBDataSet.SelectSQL.Add(SQL);
  IBDataSet.Open;
end;

procedure MyExecSQL(IBSQL: TIBSQL; const SQL: string);
begin
  IBSQL.Close;
  IBSQL.SQL.Clear;
  IBSQL.SQL.Add(SQL);
  IBSQL.ExecQuery;
end;


function TDM_Main.Connect(const UserName, Password: string): boolean;
var str:string;
begin
  Result:=true;
  try
    with IBDatabase do
    begin
      if Connected then Connected:=false;
      DatabaseName:=AppSettings.Get_MainDB_Path;
      str:=AppSettings.Get_MainDB_Path;
      Params.Clear;
      Params.Add('user_name='+trim(UserName));

      Params.Add('password='+trim(Password));

      Params.Add('lc_ctype=WIN1251');
      Connected:=true;
    end;
  except
      on E: EIBInterBaseError do
      begin
        if E.IBErrorCode=isc_login then
        begin
          Result:=false;
          Application.MessageBox('Неправильно задано имя или пароль',gc_strDispAVR, MB_OK+MB_ICONERROR)
        end else raise Exception.Create(E.Message+'(TDM_Main.Connect)');
      end;
      on E: Exception do raise Exception.Create(E.Message+'(TDM_Main.Connect)');
  end;
end;

procedure TDM_Main.DataModuleDestroy(Sender: TObject);
begin
  DisconnectVDS;
//  Disconnect1562;
  //Disconnect1562_1;//20.07.2011
  Disconnect;
  DisconectADO1562;
end;

procedure TDM_Main.Disconnect;
begin
  if IBDatabase.Connected then
    IBDatabase.Connected:=false;
end;

function TDM_Main.GetAdres(id_HouseType, id_street: integer; HouseNum: string;
  AddAdres: string=''): string;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    Result := GetAdres( tr_tmp, id_HouseType, id_street, HouseNum, AddAdres );

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(TDM_Main.GetAdres)');
    end;
  end;
end;

function TDM_Main.GetAdres(_tran: TIBTransaction; id_HouseType,
  id_street: integer; HouseNum, AddAdres: string): string;
begin
  Result:='';

  MyOpenIBDS(dset_tmp, Format('select adres from get_adres(%d, %d, ''%s'', ''%s'')',
    [id_HouseType, id_street, trim(HouseNum), trim(AddAdres)]));
  if not dset_tmp.Eof then
    Result:=dset_tmp.FieldByName('Adres').AsString;
end;

function TDM_Main.GetIDOfficialPost(id_Official: integer): integer;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp,
      'select fk_offic_officpost id_post from s_officials where id='+IntToStr(id_Official));
    Result:=dset_tmp.FieldByName('id_post').AsInteger;

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(TDM_Main.GetIDOfficialPost)');
    end;
  end;
end;

function TDM_Main.GetNewSessionID: integer;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp, 'select session_id from get_session_id');
    Result := dset_tmp.Fields[0].AsInteger;

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      E.Message := E.Message + '(TDM_Main.GetNewSessionID)';
      raise;
    end;
  end;
end;

function TDM_Main.IsNeedToChangeShift: boolean;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp, 'select is_need_tochange_shift from is_need_tochange_shift');
    Result:=(dset_tmp.Fields[0].AsInteger=1);
    MyOpenIBDS(dset_tmp, 'select ShiftNumber, ShiftDate from ServantTable');
    frm_main.shiftDate:=dset_tmp.Fieldbyname('ShiftDate').AsDateTime;

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(TDM_Main.IsNeedToChangeShift)');
    end;
  end;
end;

function TDM_Main.IsNeedToInputTemper: boolean;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp, 'select is_need_toinput_temper from is_need_toinput_temper');
    Result:=(dset_tmp.Fields[0].AsInteger=1);

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(TDM_Main.IsNeedToInputTemper)');
    end;
  end;
end;

function TDM_Main.ConnectVDS(const UserName, Password: string): boolean;
begin
  Result:=true;
  try
   if (not IBDatabaseVDS.Connected) and (AppSettings.IsUseVDSDB) then
    with IBDatabaseVDS do
    begin
      DatabaseName:=AppSettings.Get_VDSDB_Path;
      Params.Clear;
      Params.Add('user_name=AVR_VDS');
      Params.Add('password=avr_vds_pwd');
      Params.Add('lc_ctype=WIN1251');
      Connected:=true;
    end;
  except
      on E: EIBInterBaseError do
      begin
        if E.IBErrorCode=isc_login then
        begin
          Result:=false;
          Application.MessageBox('Неправильно задано имя или пароль',gc_strDispAVR, MB_OK+MB_ICONERROR)
        end else raise Exception.Create(E.Message+'(TDM_Main.ConnectVDS)');
      end;
      on E: Exception do raise Exception.Create(E.Message+'(TDM_Main.ConnectVDS)');
  end;
end;

procedure TDM_Main.DisconnectVDS;
begin
  if IBDatabaseVDS.Connected then
    IBDatabaseVDS.Connected:=false;
end;

{используем соединение для получения остатка заявок 1562}
{function TDM_Main.Connect1562(const UserName, Password: string): boolean;
begin
  Result:=true;
  try
   if (not IBDatabase1562.Connected) then
    with IBDatabase1562 do
    begin
      DatabaseName:=AppSettings.Get_AVR1562DB_Path;
      Params.Clear;
      Params.Add('user_name=VIEWWEB');//('user_name=AVR1562');    //glasha 15.11.2012
      Params.Add('password=1562'); //avr1562_pwd
      Params.Add('lc_ctype=WIN1251');
      Connected:=true;
    end;
  except
      on E: EIBInterBaseError do
      begin
        if E.IBErrorCode=isc_login then
        begin
          Result:=false;
          Application.MessageBox('Неправильно задано имя или пароль',gc_strDispAVR, MB_OK+MB_ICONERROR)
        end else raise Exception.Create(E.Message+'(TDM_Main.Connect1562)');
      end;
      on E: Exception do raise Exception.Create(E.Message+'(TDM_Main.Connect1562)');
  end;
end;


 }

//09.12.2011 by GLasha
function TDM_Main.ConnectADO1562(const UserName, Password: string): boolean;
begin
 Result:=true;
 try
  if not ADOConn_1562.Connected then
    ADOConn_1562.Connected:=true;
 except
   on   E: Exception do
         raise Exception.Create(E.Message+'(TDM_Main.ADO1562)');
 end;
end;
//


//
procedure TDM_Main.DisconectADO1562;
begin
if   ADOConn_1562.Connected then
ADOConn_1562.Connected:=false;
end;

procedure TDM_Main.Timer1Timer(Sender: TObject);

const _interval = 5;// в минутах

var  time_morning, time_evening: TDateTime;


   function PartOfDay: string;
   var _t: TDateTime;
   begin
     _t := Time;
      if (_t < time_evening)
      and (_t >= time_morning) then
          result := '_1'
          else
          result := '_2';
   end;

   function checkfile: boolean;
   var fn: string ;
       _dttm, _dt: TDateTime;
       _res: boolean;
       _Part:string;
       _t1,_t2:tdatetime;
   begin
    if frac(Now)<strtotime('16:00') then
    begin
    _t1:=strTOTime('7:00');
    _t2:=strToTime('8:30');
    end
    else
    begin
     _t1:=strTOTime('16:40');
     _t2:=strToTime('17:40');
    end;
    Result:=false;
    if (frac(Now)>_t1) and (frac(Now)<_t2) then
    begin
      if (frac(Now) < time_morning) then _dt := Date-1 else _dt := Date;
      _Part:=PartOfDay;
      fn:=trim('disconAVR_'+ReplaceChar(DateToStr(_dt), '.', '_'))+_Part+ '.xls';

      MyOpenSQL(dset_tmp2, 'select REP_AVRDISCON_FILENAME from servanttable');
//      _dttm := dset_tmp.FieldByName('DTTM_REP_AVRDISCON').AsDateTime;
     _res := (fn = trim(dset_tmp2.FieldByName('REP_AVRDISCON_FILENAME').AsString));
      if not _res then
       begin
        if _Part='_1' then
         fn:=trim('disconAVR_'+ReplaceChar(DateToStr(_dt), '.', '_'))+'_2'+ '.xls';
        if _Part='_2' then
         fn:=trim('disconAVR_'+ReplaceChar(DateToStr(_dt+1), '.', '_'))+'_1'+ '.xls';
         _res := (fn = trim(dset_tmp2.FieldByName('REP_AVRDISCON_FILENAME').AsString));
      end;

      dset_tmp2.Transaction.Commit;
      Result:= not _res;
     end;
   end;

  function DeltaCorrect: integer;
  var _hh, _mm, _ss, _ms : Word;
      _dm: integer;
  begin
      DecodeTime(Now, _hh, _mm, _ss, _ms);
      _dm := _mm mod _interval;
      result :=  _dm * 60000;
  end;

  function checkAvasit:boolean; //проверка отправления сводки "Информация по аварийным ситуациям"
  var
        _t1 ,_t2:TDatetime;
        fn:string;
   begin
     Result:=false;
    _t1:=strTOTime('7:00');
    _t2:=strToTime('8:30');
    if (frac(Now)>_t1) and (frac(Now)<_t2) then
    begin
     fn:=trim('AVR_Sit'+ReplaceChar(DateToStr(Date), '.', '_'))+ '.xls';
     MyOpenSQL(dset_tmp2,'select  file_name from SentSvEmail where id=1');
     Result:=not (fn=trim(dset_tmp2.FieldByName('file_name').AsString));
     if  Result then
     begin
       fn:=trim('AVR_Sit'+ReplaceChar(DateToStr(Date+1), '.', '_'))+ '.xls';
       Result:=not (fn=trim(dset_tmp2.FieldByName('file_name').AsString));
     end;

    end;
   end;

  function checkAvarSvod:boolean; //проверка отправки сводкки Ведомость аварийных ситуация Dtljvjcnm fdfhbqys[ cbnefwbz
  var _t1,_t2:TDateTime;
       fn:string;
  begin
     _t1:=strToTime('15:45');
     _t2:=strToTime('16:00');
     result:=false;
     if (frac(now)>_t1) and (frac(now)<_t2) then
     begin
       fn:='avar_svod_';
       MyOpenSQL(dset_tmp2,'select  file_name,datetime from SentSvEmail where id=2');
       result:= dset_tmp2.FieldByName('datetime').AsDateTime<Date+StrToTime('15:00');
     end;


  end;

  function checkDisconSite:boolean;//напоминалека мводка отключений на сайт
   var  t2:TDateTime;
        t1:TDateTime;
   fn:string;
  begin
   t2:=strtotime('07:40');
   t1:=strtotime('17:40');
   result:=false;
   if (abs(Time()-t2)<0.013)or(abs(Time()-t1)<0.013) then //20 минут
    begin
     fn:='disconAVRsite';
       MyOpenSQL(dset_tmp2,'select  file_name,datetime from SentSvEmail where sv_name='''+fn+'''');
       if Time()>0.5 then
       result:= (dset_tmp2.FieldByName('datetime').AsDateTime<Date+0.5)
       else
        result:= (dset_tmp2.FieldByName('datetime').AsDateTime<Date);
    end;
  end;
{нужноотправлять 2 раза 8:45-9:30 9:45-10:30}
  function checkReportAll:boolean;//напоминалека "Комплекс Харькковводоснабжение отчет"
   var  t2:TDateTime;
        t1,t3,t4:TDateTime;
        timeNow,timeSent:TDateTime;
        dateNow:TDatetime;
   fn:string;
  begin
   t1:=strtotime('08:45');
   t2:=strtotime('09:30');
   t3:=strtotime('09:45');
   t4:=strtotime('10:30');

   result:=false;
   if (Time()<t4+0.013)and(Time()>t1-0.013) then //20 минут
    begin
     fn:='reportAll';
       MyOpenSQL(dset_tmp2,' select sv.sv_name, sv.file_name,sv.datetime, '+
                           ' current_timestamp dateNow  from SentSvEmail sv where sv_name='''+fn+'''');

       timeNow:=frac(dset_tmp2.fieldbyname('dateNow').AsDateTime);
       timeSent:=dset_tmp2.fieldbyname('datetime').AsDateTime;
       dateNow:=trunc(dset_tmp2.fieldbyname('dateNow').AsDateTime);
       if (timeNow>=t1) and (timeNow<=t2) then
        result:=((dateNow+t1)>timeSent);
       if (timeNow>=t3) and (timeNow<=t4) then
          result:= ((dateNow+t3)>timeSent);
    end;
  end;



begin
  //
  time_morning := strtotime('07:40');
  time_evening := strtotime('16:40');
  if not (DM_RightsManager.IsCurrentUserDisp and AppSettings.IsUseAlarm)
    then
       exit;
      Timer1.Enabled := false;
      Timer1.Interval := (_interval * 60000) - DeltaCorrect;
  if (checkfile) then
    begin
      Application.BringToFront;
      Application.MessageBox(PChar('Отправьте сведения об отключениях в ДКХ  и на сайт!'),
                            'Внимание!', MB_OK+MB_ICONQUESTION);
    end;
   if (checkAvasit) then
   begin
      Application.BringToFront;
      Application.MessageBox(PChar('Отправьте Информацию по аварийным ситуациям'),
                            'Внимание!', MB_OK+MB_ICONQUESTION);
    end;
   if (checkAvarSvod) then
   begin
      Application.BringToFront;
      Application.MessageBox(PChar('Отправьте Ведомость аварийных ситуаций'),
                            'Внимание!', MB_OK+MB_ICONINFORMATION);
    end;
  if  checkDisconSite then
  begin
    Application.BringToFront;
    Application.MessageBox(PChar('Отправьте Ведомость аварийных ситуаций на сайт'),
                            'Внимание!', MB_OK+MB_ICONINFORMATION);

  end;

   if  checkReportAll then
  begin
    Application.BringToFront;
    Application.MessageBox(PChar('Отправьте "Комплекс Харькковводоснабжение отчет"'),
                            'Внимание!', MB_OK+MB_ICONINFORMATION);

  end;




{ if (Time>StrToTime('6:00:01')) and (Time<StrToTime('6:30:01')) then //31.07.2012 glasha
 if AppSettings.Get_IsSentXML='1' then  //1.08.2012 glasha
 //   SaveForStDispXML();    //31.07.2012 glasha
     OneDayManagerTime.ExcuteAll;
except
   on e:exception do
   Application.MessageBox(PChar(E.message+'Не прошло сохранение информации для программы старший сменный!'), 'Ошибка', MB_OK);
end; }
  Timer1.Enabled := true;
end;

function TDM_Main.IsNeedToChangeShiftBlock(showmess:boolean): boolean;
var
  Year, Month, Day : Word;
  Hour, Minute, Second, MilliSecond : Word;
  curdate, preddate : TDateTime;

  dateorder: TDatetime;
  s, numborder  : string;
begin
  Hour:=0; Minute:=0; Second:=0; MilliSecond:=0;
  curdate:=now;
  DecodeDate(curdate,Year,Month,Day);
  curdate:=EncodeDateTime(Year,Month,Day,Hour,Minute,Second,MilliSecond);
  predDate:=CurDate-1;
  IBQSmena.ParamByName('PStartDate').AsDateTime:=preddate;
  if IBQSmena.Active then IBQSmena.Close;
  try
    if IBQSmena.Transaction.Active then
      IBQSmena.Transaction.Rollback;
    IBQSmena.Transaction.StartTransaction;
    IBQSmena.Open;
    if   IBQSmena.RecordCount=0 then Result:=False
    else                             Result:=True;
    frm_main.flagshift:=Result;
    if ShowMess and Result then
    begin
      IBQSmena.First;
      if IBQSmena.FieldByName('numborder').IsNull then

      else
      begin
      if IBQSmena.FieldByName('pris').asinteger=1 then begin
      numborder:=IBQSmena.FieldByName('numborder').Asstring;
      dateorder:=IBQSmena.FieldByName('dateorder').AsDateTime;
      s:='Предыдущая смена должна закрыть выезды'+#13#10+
         'в наряде № '+numborder+' за '+DateTimeToStr(dateorder);
       end
     else
     begin
      numborder:=IBQSmena.FieldByName('numborder').Asstring;
      dateorder:=IBQSmena.FieldByName('dateorder').AsDateTime;
      delete(numborder,length(numborder)-3,2);
      numborder:=trim(numborder)+'ОГО';
      s:='Предыдущая смена должна закрыть выезды'+#13#10+
          numborder+' района за '+DateTimeToStr(dateorder);
     end;
      end;

      Application.MessageBox( pchar(s), 'Пересменка запрещена', MB_OK+MB_ICONWARNING);
    end;
  finally
    IBQSmena.Close;
    IBQSmena.Transaction.Commit;
  end;
end;

function TDM_Main.ReconnectAll:boolean; //08.06.2012 Glasha
var i,j:integer;
   List:TList;
   b:boolean;
begin
Result:=false;

 try

  if  IBDatabase.Connected then
  begin
   IBDatabase.Connected:=false;
  end;
  IBDatabase.Connected:=true;
  for i:=0 to List_dsets.Count-1 do
   TIBDataSet(List_dsets.Items[i]).Open;
  List_dsets.Clear;
  //List_dsets.Destroy;
 // b:=Assigned(list_dsets);
 except on E:exception  do
 begin
   Application.MessageBox(PChar('Соединится не получилось.'+#13+e.message),'Ощибка соединения', MB_OK+MB_ICONERROR);
   exit;
 end;
 end;

 try
   if ADOConn_1562.Connected then
   begin
     if ADOConn_1562.InTransaction then
        ADOConn_1562.RollbackTrans;
     ADOConn_1562.Connected:=false;
   end;
 //   ADOConn_1562.Connected:=true;

 except on E:exception do
   Application.MessageBox(PChar('Соединится не получилось.'+#13+e.message),'Ощибка соединения', MB_OK+MB_ICONERROR);
 end;

Result:=true;
end;




procedure TDM_Main.IBDatabaseBeforeDisconnect(Sender: TObject);
var i:integer;
begin
 if  not Assigned(list_dsets) then
 list_dsets:=TList.Create
  else
 list_dsets.Clear;
for i:=0 to IBDatabase.DataSetCount-1 do
 if IBDatabase.DataSets[i].Active then
  list_dsets.Add(IBDatabase.DataSets[i]);
end;

function ReconnectAll(Base:TIBDataBase):boolean;
var c:integer;
     i,j:integer;
   List:TList;
begin
 c:=0;
 result:=false;
 while (c<10) and   (not result) do
 try
  if  Base.Connected then
  begin
   Base.Connected:=false;
  end;
   base.Connected:=true;

  result:=true;

 except
   c:=c+1;
   Sleep(1000);
 end;

end;

function TDM_Main.getServerTime: TDateTime;
begin
if not dset_time.Active then
 dset_time.Open;
 result:=dset_time.fieldbyname('current_time').AsDateTime;
end;

end.
