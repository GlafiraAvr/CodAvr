unit ver;

interface
uses SysUtils,Windows;

VAR
   TempVersion:string;

implementation

function _MyGetFileVersion(FileName: TFileName; var res_ver:string): boolean;
var
  InfoSize, Wnd: Cardinal;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  ccc: char;
 VerSize: DWORD;
 Major, Minor,Release, Build:integer;
  s:string;
begin
 ccc:='\';
  Result:= False;
  s := FileName;
  UniqueString(s);
  InfoSize:= GetFileVersionInfoSize(PChar(s), Wnd);
  if InfoSize <> 0 then begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then begin
          Major:= FI.dwFileVersionMS shr 16;
          Minor:= FI.dwFileVersionMS and $FFFF;
          Release:= FI.dwFileVersionLS shr 16;
          Build:= FI.dwFileVersionLS and $FFFF;
          res_ver:=IntToStr(Major)+'.'+
                   IntToStr(Minor)+'.'+
                   IntToStr(Release)+'.'+
                   IntToStr(Build);
          Result:= True;
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function AppGetFileVersion:string;
var s:string;
begin
  s:='';
  result:=s;
  if _MyGetFileVersion(ParamStr(0),s) then
    begin
      result:=result + s ;
    end;
end;

initialization

 TempVersion:=AppGetFileVersion;

end.
 