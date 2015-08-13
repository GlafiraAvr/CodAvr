unit RootReport;

interface

uses Windows, SysUtils, Forms, FR_Class, frOLEExl, ztvZip, RGSendEmail, IniFiles,
      FR_E_RTF_RS;

type
  TExportType=(etExcel, etRTF);

  TVASendMailIni = class( TRGSendMailIni )
  private
      FPort:word;
      FHost:string;
      FFromAddress:string;
      FSMTPUser,FSMTPPass:string;
      FEnabled:boolean;
  public
      FaRecipients: array of string; //реципиенты, разделенные точкой с запятой
      procedure LoadFromIniFile(_inifile:TIniFile); override;
  end;

  TRootReport=class
  private
    procedure ExportFRAndSendByEmail(AExportType:  TExportType; frRep: TfrReport;
          const AFileName: string; BodyOfLetter: string='';zip:boolean=false);
  protected
    FLetSendByEmail: boolean;
    function ExportFastReportToExcel(fr_rep: TfrReport; excel_file_name: string): boolean;
    function ExportFastReportToRTF(fr_rep: TfrReport; rtf_file_name: string): boolean;
    function ZipFile(const FileName: string): string;
    procedure SendByEmail(FileName:string; BodyOfLetter: string='';  _RegID: integer = 0 );
    procedure ExportFRToRTFAndSendByEmail(frRep: TfrReport; const AFileName: string; BodyOfLetter: string='';zip:boolean=true);
   procedure ExportFRToExcelAndSendByEmail(frRep: TfrReport; const AFileName: string; BodyOfLetter: string='';zip:boolean=true);
  public
    constructor Create;    
  end;

implementation

uses StringConsts;
{ TRootReport }


procedure TVASendMailIni.LoadFromIniFile(_inifile:TIniFile);
var i: integer;
begin
  SetLength(FaRecipients, 10);
  FaRecipients[0]:=_inifile.ReadString(FSectionName,'Recipients','mv@aqua.kharkov.ua');
  for i:= 1 to 9 do
  begin
    FaRecipients[i]:=_inifile.ReadString(FSectionName,'Recipients'+inttostr(i),''{'mv@aqua.kharkov.ua'});
  end;
  inherited;
{
  FFromAddress:=_inifile.ReadString(FSectionName,'FromAddress','mv@aqua.kharkov.ua');
  FSMTPUser:=_inifile.ReadString(FSectionName,'SMTPUser','');
  FSMTPPass:=_inifile.ReadString(FSectionName,'SMTPUser','');
  FHost:=_inifile.ReadString(FSectionName,'Host','sw');
  try
    FEnabled:=boolean(StrToInt(_inifile.ReadString(FSectionName,'Enabled','1')));
  except
    FEnabled:=TRUE;
  end;
  try
    FPort:=_inifile.ReadInteger(FSectionName,'Port',25);
  except
    FPort:=25;
  end;}
end;

constructor TRootReport.Create;
begin
  FLetSendByEmail := FALSE;
end;

function TRootReport.ExportFastReportToExcel(fr_rep: TfrReport;
  excel_file_name: string): boolean;
var
  excel_exp: TfrOLEExcelExport;
begin
  try
    excel_exp:=TfrOLEExcelExport.Create(nil);
   //  excel_exp.CellsMerged:=false;
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
                                gc_strDispAVR, MB_OK+MB_ICONERROR);
    end;
  end;
end;

function TRootReport.ExportFastReportToRTF(fr_rep: TfrReport;
  rtf_file_name: string): boolean;
var
  rtf_exp: TfrRTF_rsExport;
begin
  try

    rtf_exp:=TfrRTF_rsExport.Create(nil);
    try
      rtf_exp.ShowDialog:=false;
      fr_rep.ExportTo(rtf_exp, rtf_file_name);
      Result:=not fr_rep.Terminated;
    finally
      rtf_exp.Free;
    end;

  except
    on E: Exception do
    begin
      Result:=false;
      Application.MessageBox('Ошибка экспорта в RTF(TRootReport.ExportFastReportToRTF)',
                                gc_strDispAVR, MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure TRootReport.ExportFRAndSendByEmail(AExportType: TExportType;
  frRep: TfrReport; const AFileName: string; BodyOfLetter: string;zip:boolean);
var
  out_file_name, zip_file_name: string;
  ExportFunc: function (fr_rep: TfrReport; excel_file_name: string): boolean of object;
begin
///
  case AExportType of
    etExcel:
      begin
        out_file_name:=AFileName+'.xls';
        ExportFunc:=ExportFastReportToExcel;
      end;
    etRTF:
      begin
        out_file_name:=AFileName+'.rtf';
        ExportFunc:=ExportFastReportToRTF;
      end;
  end;
  zip_file_name:=AFileName+'.zip';

  DeleteFile(out_file_name);
  DeleteFile(zip_file_name);
///

  if ExportFunc(frRep, out_file_name) then
  begin
       if zip then begin
         ZipFile(out_file_name);
         SendByEmail(zip_file_name, BodyOfLetter);
       end
       else
        SendByEmail(out_file_name, BodyOfLetter);

  end;
end;

procedure TRootReport.ExportFRToExcelAndSendByEmail(frRep: TfrReport;
  const AFileName: string; BodyOfLetter: string; zip:boolean);
begin
  ExportFRAndSendByEmail(etExcel, frRep, AFileName, BodyOfLetter,zip);
end;

procedure TRootReport.ExportFRToRTFAndSendByEmail(frRep: TfrReport;
  const AFileName: string; BodyOfLetter: string;zip:boolean);
begin
  ExportFRAndSendByEmail(etRTF, frRep, AFileName, BodyOfLetter,zip);
end;

procedure TRootReport.SendByEmail(FileName: string; BodyOfLetter: string= ''; _RegID: integer = 0);
var
  send_mail: TRGSendMail;
  send_mail_ini: TVASendMailIni;
  ini_file: TIniFile;
  mes, inif_name: string;
begin
  try
    try
      //inif_name:=ExtractFilePath(Application.ExeName)+ExtractFileName(Application.ExeName)+'.'+ClassName+'.ini';
      inif_name:=ExtractFilePath(Application.ExeName)+'avr_arm.exe.'+ ClassName +'.ini';
      send_mail:=TRGSendMail.Create;
      send_mail_ini:=TVASendMailIni.Create;
      ini_file:=TIniFile.Create(inif_name);
      //
      send_mail.ThreadMode:=false;
      send_mail.FreeOnTerminate:=false;

      //
      send_mail_ini.SectionName:='EMAIL';
      send_mail_ini.LoadFromIniFile(ini_file);
      //
      if send_mail_ini.Enabled then
      //
      begin
      send_mail.Port:=send_mail_ini.Port;
      send_mail.Host:=send_mail_ini.Host;

       send_mail.Recipients:=send_mail_ini.FaRecipients[_RegID]; // new version
      if send_mail.Recipients<>'' then
      begin
//      send_mail.Recipients:=send_mail_ini.Recipients; // old version

      send_mail.FromAddress:=send_mail_ini.FromAddress;
      send_mail.Username:=send_mail_ini.SMTPUser;
      send_mail.Password:=send_mail_ini.SMTPPass;

      send_mail.BodyOfLetter.Clear;
      send_mail.BodyOfLetter.Add(BodyOfLetter);
      send_mail.Attachment:=FileName;
      send_mail.FromSubject:=BodyOfLetter;
      send_mail.FromName:='КП Харьковводоканал';//'КП КТП "ВОДА"';

      //send_mail_ini.IniStrings.SaveToFile(inif_name);

    //  if send_mail_ini.FEnabled then
      mes:=send_mail.SendMail;
    //   else
    //    mes := 'ok';

      if mes<>'ok' then raise Exception.Create(mes);
      end;
      end;

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
      Application.MessageBox(PChar(E.Message+'(TNGBaseReport.SendByEmail)'),
                        gc_strDispAVR, MB_OK+MB_ICONERROR);
    end;
  end;
end;

function TRootReport.ZipFile(const FileName: string): string;
var
  zip: TZip;
  zip_file_name: string;
begin
  try
    zip_file_name:=ChangeFileExt(FileName, '.zip');
    zip:=TZip.Create(nil);
    try
      zip.FileSpec.Clear;
      zip.FileSpec.Add(FileName);
      zip.ArchiveFile :=zip_file_name;
      zip.Compress;
    finally
      zip.Free;
    end;
    Result:=zip_file_name;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
    end;
  end;
end;

end.
