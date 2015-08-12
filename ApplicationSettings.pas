unit ApplicationSettings;

interface

{$I !TEST_DEFINE.inc}

uses Windows, SysUtils, Forms, IniFiles;

const
  SETTINGS_FILE='settings.ini';
  PATH_SECTION_NAME='Path';
  Time_Section='Timer';
  Setting_Sections='Settings 1562';
  default_int=60000;
  Cl_section='Cl_section';

type
  TApplicationSettings=class
  private
    F_SettingsFileName: string;
    F_TestDir: string;
    F_ExePath: string;
    F_TempDir: string;
    F_Reports_Path: string;
    procedure InitFields;
    function GetIniValue(section, param_name: string; default: string=''): string;
    function SetIniValue(section, param_name: string; value: string): boolean;
  public
    property SettingsFileName: string read F_SettingsFileName;
    property TestDir: string read F_TestDir;
    property TempDir: string read F_TempDir;
    property ExePath: string read F_ExePath;
    property Reports_Path: string read F_Reports_Path;
    function Get_GIK_Path: string;
    function Get_StDispDB_Path: string;
    function Get_ClorDB_Path: string;
    function Get_Abon_Path: string;
    function Get_MainDB_Path: string;
    function Get_VDSDB_Path: string;
    function Get_AVR1562DB_Path: string;
    function Get_AVR1562_1DB_Path: string;
    function Get_AddPrint_Dir: string;
    function IsShowLoginUserList: boolean;
    function IsUseVDSDB: boolean;
    function IsUseAlarm: boolean;
    function IsCanStartAvrOnMap: boolean;

    function Get_Interval: integer; //glasha 23.01.2012
    function Get_PathForXML: string; //glasha 01.03.2012

    function Set_Interval(value:integer):boolean; //glasha 23.01.2012
    function Set_Regions(ID_REG:string;REgions:string):boolean; //glasha 12.07.2012
    function Set_State(value:integer):boolean;
    function Set_Appurtenance(value:integer):boolean; //glasha 12.07.2012
    function Set_DateTime(dt1:string; dt2:string):boolean; //glasha 12.07.2012

    function Get_Regions(var ID_REG:string; var REgions:string):boolean; //glasha 12.07.2012
    function Get_Sate:integer; //glasha 12.07.2012
    function Get_Appurtenance:integer; //glasha 12.07.2012
    function Get_DateTime(var dt1:string;var  dt2:string):boolean;
    function Get_IsSentXML:string; //glasha 01.08.2012
    function Get_IsSaveRazr:string;// glasha 12.10.2012
    function Get_SaveVdsSvod2:string;
    function Get_ImageClient(var port:integer; var host:string) :boolean;     //glasha 07.05.2014
    constructor Create;
  end;

var AppSettings: TApplicationSettings;

implementation

{ TApplicationSettings }

constructor TApplicationSettings.Create;
begin
  inherited Create;
  F_ExePath:=ExtractFilePath(ParamStr(0));
  F_SettingsFileName:=F_ExePath+SETTINGS_FILE;

  InitFields;
end;

function TApplicationSettings.GetIniValue(section,
  param_name: string; default: string=''): string;
var
  ini_file: TIniFile;
begin
  ini_file:=TIniFile.Create(F_SettingsFileName);
  try
    Result:=ini_file.ReadString(section, param_name, default);
  finally
    ini_file.Free;
  end;
end;


function TApplicationSettings.SetIniValue(section, param_name: string; value: string): boolean;
var
  ini_file: TIniFile;
begin
result:=false;
ini_file:=TIniFile.Create(F_SettingsFileName);
 try
    ini_file.WriteString(section, param_name, value);
    result:=true;
  finally
    ini_file.Free;
  end;
end;


function TApplicationSettings.Get_Abon_Path: string;
const
  ABON_DIR_NAME='ABON';
var
  ab_dir: string;
begin

  ab_dir:=F_ExePath+ABON_DIR_NAME+'\';
  if not DirectoryExists(ab_dir) then
    if not CreateDir(ab_dir) then
      ab_dir:=F_ExePath;

  Result:=ab_dir;
end;

function TApplicationSettings.Get_AddPrint_Dir: string;
begin
  Result:=F_ExePath+'AddPrint\';
end;

function TApplicationSettings.Get_ClorDB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'ClorDB');
end;

function TApplicationSettings.Get_GIK_Path: string;
  function Create_GIK_Dir(dir: string): boolean;
  begin
    Result:=true;
    if not DirectoryExists(dir) then
      if not CreateDir(dir) then
        Result:=false;
  end;
const
  PAR_NAME='GIK_FR_Path';
  GIK_DIR='GIK_FR';
var
  def_gik_path, gik_path: string;
begin
  def_gik_path:=F_ExePath+gik_dir;

  gik_path:=GetIniValue(PATH_SECTION_NAME, PAR_NAME);

  if not Create_GIK_Dir(gik_path) then
  begin
    if not Create_GIK_Dir(def_gik_path) then
      Result:=F_ExePath
    else
      Result:=def_gik_path+'\';
  end else
  begin
    Result:=gik_path+'\';
  end;
end;

//23.01.2012 glasha
function TApplicationSettings.Get_Interval: integer;
var s:string;
begin
 s:=GetIniValue(Time_section, 'Interval');
 if s<>'' then
  Result:=StrToInt(s)
  else
  begin
   Result:=default_int;
   Set_Interval(default_int);
  end;
end;

function TApplicationSettings.Get_Regions(var ID_REG:string; var REgions:string):boolean; //glasha 12.07.2012
begin
 ID_REG:=GetIniValue(Setting_Sections, 'ID_REGS');
 REgions:=GetIniValue(Setting_Sections, 'REGions');
end;

function TApplicationSettings.Get_Sate:integer; //glasha 12.07.2012
begin
try
Result:=StrToINT(GetIniValue(Setting_Sections, 'State','0'));
except
REsult:=0;
end;
end;

function TApplicationSettings.Get_Appurtenance:integer; //glasha 12.07.2012
begin
try
Result:=StrToINT(GetIniValue(Setting_Sections, 'Appurtenance','0'));
except
result:=0;
end;
end;



function TApplicationSettings.Set_Interval(value:integer):boolean; //glasha 23.01.2012
begin
Result:=SetIniValue(Time_section, 'Interval',inttostr(value));
end;
 //23.01.2012

function TApplicationSettings.Set_Regions(ID_REG:string;REgions:string):boolean; //glasha 12.07.2012
begin
 Result:=SetIniValue(Setting_Sections, 'ID_REGS',ID_REG);
 Result:=SetIniValue(Setting_Sections, 'REGions',REgions);
end;

function TApplicationSettings.Set_State(value:integer):boolean; //glasha 12.07.2012
begin
Result:=SetIniValue(Setting_Sections, 'State',IntToStr(value));
end;

function TApplicationSettings.Set_Appurtenance(value:integer):boolean; //glasha 12.07.2012
begin
Result:=SetIniValue(Setting_Sections, 'Appurtenance',IntToStr(value));
end;

function TApplicationSettings.Set_DateTime(dt1:string; dt2:string):boolean; //glasha 12.07.2012
begin
Result:=SetIniValue(Setting_Sections, 'dt1',dt1);
Result:=SetIniValue(Setting_Sections, 'dt2',dt2);
end;


function TApplicationSettings.Get_MainDB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'MainDB');
end;

function TApplicationSettings.Get_VDSDB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'VDSDB');
end;

function TApplicationSettings.Get_AVR1562DB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'AVR1562DB');   //'172.16.2.17:e:\!base1562\avr_vs_1562.fdb'
end;


function TApplicationSettings.Get_DateTime(var dt1:string; var dt2:string):boolean;
begin
  Result:=false;
  dt1:=GetIniValue(Setting_Sections, 'dt1');
  dt2:=GetIniValue(Setting_Sections, 'dt2');
  if (dt1<>'')and (dt2<>'') then
   Result:=true;
end;
//20.07.2011
function TApplicationSettings.Get_AVR1562_1DB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'AVR1562_1DB');
end;
//

function TApplicationSettings.Get_StDispDB_Path: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'StDispDB');
end;

procedure TApplicationSettings.InitFields;
begin
  {$ifdef test}
  F_TestDir:=F_ExePath+'TEST\';
  if not DirectoryExists(F_TestDir) then
    if not CreateDir(F_TestDir) then
      F_TestDir := F_ExePath;
  {$endif}
  //
  F_Reports_Path:=GetIniValue(PATH_SECTION_NAME, 'ReportsDir', '');
  if F_Reports_Path='' then F_Reports_Path:=F_ExePath+'Reports';

  {TempDir}
  F_TempDir := F_ExePath + 'TEMP\';
  if not DirectoryExists( F_TempDir ) then
    if not CreateDir( F_TempDir ) then
      F_TempDir := F_ExePath;
  {/TempDir}
end;

function TApplicationSettings.IsCanStartAvrOnMap: boolean;
var
  _s: string;
begin
  _s:=F_ExePath+'AvarOnMap\AvarOnMap.exe';
  Result:=FileExists(_s);
end;

function TApplicationSettings.IsShowLoginUserList: boolean;
begin
  Result:=StrToBool(GetIniValue('Common', 'IsShowLoginUserList', '0'));
end;

function TApplicationSettings.IsUseVDSDB: boolean;
begin
  Result:=StrToBool(GetIniValue('Common', 'IsUseVDSDB', '0'));
end;

function TApplicationSettings.IsUseAlarm: boolean;
begin
  Result:=StrToBool(GetIniValue('Common', 'IsUseAlarm', '0'));
end;

function TApplicationSettings.Get_PathForXML: string;
begin
  Result:=GetIniValue(PATH_SECTION_NAME, 'GIK_FR_Path');
end;

function TApplicationSettings.Get_IsSentXML:string;
begin
  Result:=GetIniValue('Common', 'SentXML','0');
end;

function TApplicationSettings.Get_IsSaveRazr:string;
begin
  Result:=GetIniValue('Common', 'SaveRazr','0');
end;


function TApplicationSettings.Get_SaveVdsSvod2:string;
begin
 Result:=GetIniValue('Common', 'SaveSvod2_vds','0');
end;

function TApplicationSettings.Get_ImageClient(var port:integer; var host:string) :boolean;
begin
try
  port:=StrToInt(GetIniValue(Cl_section, 'Port','2000'));
  host:=GetIniValue(Cl_section, 'Host','172.16.33.50');
  result:=true;
except
result:=false;
exit;
end ;
end;

initialization
  AppSettings:=TApplicationSettings.Create;

finalization
  AppSettings.Free;

end.
