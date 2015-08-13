unit TestUnit;

interface

uses Classes, SysUtils, HelpFunctions, ApplicationSettings;

procedure TEST_SaveStrings2File(strs: TStrings; short_fn: string);

implementation

procedure TEST_SaveStrings2File(strs: TStrings; short_fn: string);
begin
  strs.SaveToFile(AppSettings.TestDir+DateTime2FileName(Now)+'_'+short_fn+'.txt');
end;

end.
