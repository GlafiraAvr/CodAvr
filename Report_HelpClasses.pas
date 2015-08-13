unit Report_HelpClasses;

interface

uses RGSendEmail, IniFiles, SysUtils, Classes;

type
  TDataForStDisp = record
    VodoSetiVsego, VvodyVsego, KolodtsyVsego, KolonkiVsego,
      LikvidNaVodoSetyax, LikvidNaVvodax, UstanLukov,
      PostupNaVodoSetyax, PostupNaVvodax: string;
  end;

  TUprCityRGSendMailIni = class(TRGSendMailIni)
  private
    FLastSendDate:string;
  protected
    function GetIniStrings:TStrings;
  public
    constructor Create;
    procedure LoadFromIniFile(_inifile:TIniFile);
    property LastSendDate:string read FLastSendDate write FLastSendDate;
    property IniStrings:TStrings read GetIniStrings;
  end;

implementation

{ TUprCityRGSendMailIni }

constructor TUprCityRGSendMailIni.Create;
begin
  inherited;
  FLastSendDate := '01.01.1900'; 
end;

function TUprCityRGSendMailIni.GetIniStrings: TStrings;
var _str:TStrings;
begin
  _str := inherited GetIniStrings();
  with _str do
    begin
      Add('; Дата последней посылки');
      Add('LastSendDate='+FLastSendDate);
      Add(';;');
      Add(';;');
    end;
  result:=_str;
end;

procedure TUprCityRGSendMailIni.LoadFromIniFile(_inifile: TIniFile);
begin
  inherited;
  FLastSendDate := _inifile.ReadString(FSectionName,'LastSendDate',FLastSendDate);
  try
    StrToDate(FLastSendDate);
  except
    FLastSendDate := '01.01.1900';
  end;
end;

end.
