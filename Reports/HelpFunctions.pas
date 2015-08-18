unit HelpFunctions;


interface
uses SysUtils;
const LogFilemName='Log.txt';

procedure myWorkLog(_logtext:string);
implementation
procedure myWorkLog(_logtext:string);
var f: textfile;
     FileHandle: Integer;

begin
    if not FileExists(ExtractFilePath(ParamStr(0))+ 'Log.txt') then
    begin
     FileHandle:= FileCreate('Log.txt');
     FileClose(FileHandle);
    end;
    AssignFile(F, ExtractFilePath(ParamStr(0)) + 'Log.txt');
    Append(F);
    WriteLn(F, DateTimeToStr(Now)+' :: '+ _logtext);
    Flush(F);
    CloseFile(F);
end;

end.
