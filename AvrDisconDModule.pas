unit AvrDisconDModule;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBSQL, IBCustomDataSet, inifiles,
  RxMemDS, Controls, FR_DSet, FR_DBSet, FR_Class, BaseFrPreviewForm, FrPreviewForm
  , RGSendEmail, FR_E_RTF_RS, frOLEExl, Forms, Windows;

type
  TDModule = class(TDataModule)
    IBDB_Main: TIBDatabase;
    IBDB_NS: TIBDatabase;
    IBDB_VDS: TIBDatabase;
    tran_NS: TIBTransaction;
    tran_VDS: TIBTransaction;
    tran: TIBTransaction;
    dset: TIBDataSet;
    ib_exec: TIBSQL;
    dset_NS: TIBDataSet;
    dset_VDS: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetAdres: TStringField;
    ResultDsetZhd: TIntegerField;
    ResultDsetPod: TIntegerField;
    ResultDsetStojak: TIntegerField;
    ResultDsetKv: TIntegerField;
    ResultDsetDK: TIntegerField;
    ResultDsetShK: TIntegerField;
    ResultDsetLU: TIntegerField;
    ResultDsetVed: TIntegerField;
    ResultDsetDisconReason: TStringField;
    ResultDsetDttm_Discon: TStringField;
    ResultDsetDttm_ConnWait: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetPodrazd: TStringField;
    ds_result: TDataSource;
    frReport: TfrReport;
    frDBDataSet: TfrDBDataSet;
  private
    { Private declarations }
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_RecordCount: integer;
    F_NCDP: boolean;
    F_VDSSqlString: string;
    F_NSSqlString: string;
    F_AppPath: string;
    F_frPreview: Tfrm_FrPreview;
    function LoadReportFileTo(var fr_rep: TfrReport): boolean;
    procedure ShowFastReport(fr_rep: TfrReport);
    procedure FillResultDset(_dset: TIBDataSet);
    procedure PrepareNSDset;
    procedure PrepareVDSDset;
    procedure LoadParamsFromIni;
    procedure SetSqlString;
    function  ReplaceChar(str: string; old_char, new_char: char): string;
    procedure SendByEmail(FileName, BodyOfLetter: string);
    //Email
    procedure ExportFRAndSendByEmail(frRep: TfrReport; const AFileName: string; BodyOfLetter: string);
    function  ExportFastReportToExcel(fr_rep: TfrReport; excel_file_name: string): boolean;

  public
    { Public declarations }
    procedure EMailPrint;
    procedure PrepareAndPrintFR;
    procedure PrepareDset;
    property AppPath: string write F_AppPath;
  end;

var
  DModule: TDModule;
implementation

//uses HelpFunctions;

{$R *.dfm}

procedure TDModule.LoadParamsFromIni;
var
  inifile:TIniFile;
  helpstr:string;

begin
   //   app_path :=extractfiledir(application.GetNamePath);

 if filesearch(F_AppPath + '\AvrDiscon.INI',F_AppPath)<>'' then
  begin
      IniFile := TIniFile.Create(F_AppPath+'\AvrDiscon.INI');

      helpstr:=IniFile.ReadString('Path','MainDB','');
      IBDB_Main.DatabaseName:= helpstr;

      helpstr:=IniFile.ReadString('Common','MainUN','');
      if helpstr = '' then helpstr := 'AVR_IB';
        IBDB_Main.Params.Values['User_Name'] := helpstr;

      helpstr:=IniFile.ReadString('Common','MainPW','');
      if helpstr = '' then helpstr := 'avr_ib_pwd';
          IBDB_Main.Params.Values['password']:=helpstr;


      helpstr:=IniFile.ReadString('Path','NSDB','');
      IBDB_NS.DatabaseName:= helpstr;

      helpstr:=IniFile.ReadString('Common','NS_UN','');
      if helpstr = '' then helpstr := 'AVR_IB';
        IBDB_NS.Params.Values['User_Name'] := helpstr;

      helpstr:=IniFile.ReadString('Common','NS_PW','');
      if helpstr = '' then helpstr := 'avr_ib_pwd';
          IBDB_NS.Params.Values['password']:=helpstr;


      helpstr:=IniFile.ReadString('Path','VDSDB','');
      IBDB_VDS.DatabaseName:= helpstr;

      helpstr:=IniFile.ReadString('Common','VDS_UN','');
      if helpstr = '' then helpstr := 'AVR_VDS';
        IBDB_VDS.Params.Values['User_Name'] := helpstr;

      helpstr:=IniFile.ReadString('Common','VDS_PW','');
      if helpstr = '' then helpstr := 'avr_vds_pwd';
          IBDB_VDS.Params.Values['password']:=helpstr;

      IniFile.Free;
  end;

end;



procedure TDModule.PrepareNSDset;
begin
    //
  LoadParamsFromIni;
  if not IBDB_NS.Connected then IBDB_NS.Connected := true;
  dset_NS.SelectSQL.Text := F_NSSqlString;
  dset_NS.Open;
  FillResultDset(dset_NS);
  dset_NS.Close;
  IBDB_NS.Connected := false;

end;


procedure TDModule.PrepareVDSDset;
begin
    //

    LoadParamsFromIni;    
  if not IBDB_VDS.Connected then IBDB_VDS.Connected := true;
  dset_VDS.SelectSQL.Text := F_VDSSqlString;
  dset_VDS.Open;
  FillResultDset(dset_VDS);
  dset_VDS.Close;
  IBDB_VDS.Connected := false;

end;

procedure TDModule.FillResultDset(_dset: TIBDataSet);
var _Podr: string;
    _isNS: boolean;

    function GetDisconReasonNS : string;
     var _place: integer;
     begin
         //
         _place := _dset.FieldByName('fk_orders_damageplace').AsInteger;
         case _place of
            1: result:= 'повреждение на маг-ли' ;
            2: result:= 'повреждение на вводе';
            3: result:= 'повреждение в колодце';
          else
            result := '';
          end;
     end;

begin
    //
    if (_dset.Name = dset_NS.Name) then
    begin
      _isNS := true;
      _Podr := 'ПУВХ "Харьков"';
     end
      else
        begin
         _isNS := false;
         _Podr := 'ПЭУ "Харьковводсервис"';
        end;
    _dset.First;
    while not(_dset.Eof) do
    begin
       ResultDset.Append;
       ResultDset.FieldByName('adres').AsString := _dset.FieldByName('adres').AsString;
       ResultDset.FieldByName('region').AsString := _dset.FieldByName('region').AsString;
       ResultDset.FieldByName('dttm_discon').AsString := _dset.FieldByName('dttm_discon').AsString;
       ResultDset.FieldByName('Podrazd').AsString := _Podr;
       if _isNS then
          ResultDset.FieldByName('DisconReason').AsString := GetDisconReasonNS
          else
          ResultDset.FieldByName('DisconReason').AsString := _dset.FieldByName('DisconReason').AsString;
       ResultDset.Post;
      _dset.Next;
    end;

end;


procedure TDModule.PrepareDset;
begin
    //

  if ResultDset.Active then ResultDset.Close;
  ResultDset.Open;
  SetSqlString;
  PrepareNSDset;
  PrepareVDSDset;

end;


procedure TDModule.SetSqlString;
begin
  {if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (d.DTTM_Con is null) ');
  SqlBottom:=Format(
    ' from Disconnections d'+
    ' left join Orders o on o.id=d.fk_discon_order'+
    ' where 1=1 %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;
 }

 
  F_VDSSqlString:=
    ' select o.id, d.dttm_discon, d.dttm_con, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres2(d.fk_discon_street, d.housenum,'+
    '     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) Adres,'+
    ' (select name from s_DisconReason where id=d.fk_discon_disconreason) DisconReason,'+
    ' (select name from s_Executor where id=d.fk_discon_executor) Executor,'+
    ' (select name from s_district where id=o.fk_orders_district) District'+
    ' , (select name from s_discontype where id=d.fk_discon_discontype) Distype '+
    ' from Disconnections d '+
    ' join orders o on (d.fk_discon_order = o.id ) '+
    ' where ( d.dttm_con is null )and (d.dttm_discon is not null) and (d.fk_discon_street > 0) '+
    ' order by 5, 2';

  F_NSSqlString:=  ' select o.id, d.dttm_discon, d.dttm_con, o.OrderNumber, '+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' ((select rtrim(name) from get_fullstreetname2(d.fk_id_street))||'', ''||rtrim(d.houses)) adres '+
    ' , o.fk_orders_damageplace '+
    ' from Disconnections d '+
    ' join Orders o on (o.id=d.fk_id_order) '+
    ' where ( d.dttm_con is null )and (d.dttm_discon is not null) and (d.fk_id_street > 0) '+
    ' order by 5, 2';


end;


procedure TDModule.PrepareAndPrintFR;
begin

  if LoadReportFileTo(frReport) then
  begin
    //PrepareFastReport;
    frReport.PrepareReport;
    ShowFastReport(frReport);
    EMailPrint;
  end;
end;


function TDModule.LoadReportFileTo(var fr_rep: TfrReport): boolean;
var
  FullReportFileName: string;
begin
  FullReportFileName:= F_AppPath + '\AVRDiscon.frf';

  Result:=fr_rep.LoadFromFile(FullReportFileName);
  if not Result then
    Application.MessageBox(PChar('Не могу загрузить файл '+FullReportFileName),
              'Error', MB_OK+MB_ICONWARNING);
              
end;

procedure TDModule.ShowFastReport(fr_rep: TfrReport);
begin
  fr_rep.ShowPreparedReport;
  if Assigned(fr_rep.Preview)
  and (fr_rep.Preview.Owner is Tfrm_BaseFrPreview)
   then
    (fr_rep.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;
end;

procedure TDModule.EMailPrint;
var
  file_name: string;
  begin
    {Отправка по почте}
    if Application.MessageBox('Отправить сформированную ведомость по почте?',
        'Отключения КП "Вода"', MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim( F_AppPath +
                    '\out\disconAVR_'+ReplaceChar(DateToStr(Date), '.', '_'));      
//                    '\out\Отключения КП "Вода" _'+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRAndSendByEmail(frReport, file_name, '');
     // ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
//      ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
    end;
    {/Отправка по почте}
end;

function  TDModule.ReplaceChar(str: string; old_char, new_char: char): string;
var
  i: integer;
begin
  str:=str+' ';
  for i:=0 to Length(str)-1 do
    if str[i]=old_char then
      str[i]:=new_char;
  Result:=str;
end;

procedure  TDModule.ExportFRAndSendByEmail(frRep: TfrReport; const AFileName: string; BodyOfLetter: string);
var
  out_file_name: string;
begin

  out_file_name:=AFileName+'.xls';

  if ExportFastReportToExcel(frRep, out_file_name) then
    SendByEmail(out_file_name, BodyOfLetter);
end;

function TDModule.ExportFastReportToExcel(fr_rep: TfrReport;
  excel_file_name: string): boolean;
var
  excel_exp: TfrOLEExcelExport;
begin
  try
    excel_exp:=TfrOLEExcelExport.Create(nil);
    try
      excel_exp.ShowDialog:=false;
      fr_rep.ExportTo(excel_exp, excel_file_name);
      Result:=not fr_rep.Terminated;
    finally
      excel_exp.Free;
    end;
  except
    on E: Exception do
    begin
      Result:=false;
      Application.MessageBox('Ошибка экспорта в Excel(TRootReport.ExportFastReportToExcel)',
                                'Отключения АВР', MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure TDModule.SendByEmail(FileName, BodyOfLetter: string);
var
  send_mail: TRGSendMail;
  send_mail_ini: TRGSendMailIni;
  ini_file: TIniFile;
  mes, inif_name: string;
begin
  try
    try
      //inif_name:=ExtractFilePath(Application.ExeName)+ExtractFileName(Application.ExeName)+'.'+ClassName+'.ini';
      inif_name:=F_AppPath+'\AvrDiscon.INI';
      send_mail:=TRGSendMail.Create;
      send_mail_ini:=TRGSendMailIni.Create;
      ini_file:=TIniFile.Create(inif_name);

      //
      send_mail.ThreadMode:=false;
      send_mail.FreeOnTerminate:=false;
      //
      send_mail_ini.SectionName:='EMAIL';
      send_mail_ini.LoadFromIniFile(ini_file);
      //
      send_mail.Port:=send_mail_ini.Port;
      send_mail.Host:=send_mail_ini.Host;
      send_mail.Recipients:=send_mail_ini.Recipients;
      send_mail.FromAddress:=send_mail_ini.FromAddress;
      send_mail.Username:=send_mail_ini.SMTPUser;
      send_mail.Password:=send_mail_ini.SMTPPass;

      send_mail.BodyOfLetter.Clear;
      send_mail.BodyOfLetter.Add(BodyOfLetter);
      send_mail.Attachment:=FileName;
      send_mail.FromSubject:=BodyOfLetter;
      send_mail.FromName:='КП "ПТП "ВОДА"';

      //send_mail_ini.IniStrings.SaveToFile(inif_name);

      mes:=send_mail.SendMail;
      if mes<>'ok' then raise Exception.Create(mes);
    finally
      send_mail.Resume;
      send_mail.Terminate;
      send_mail.Free;

      send_mail_ini.Free;
      ini_file.Free;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message+'(TDModule.SendByEmail)'),
                        'Отключения АВР', MB_OK+MB_ICONERROR);
    end;
  end;
end;


end.
