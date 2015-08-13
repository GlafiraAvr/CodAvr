unit HelpFunctions;

interface

  uses Classes, SysUtils, RxLookup, RxDBComb, DB, Controls, GridViewBuilder,
  aligrid, Graphics, IBCustomDataSet, Variants, IBSQL, Dialogs, Windows,
  rxStrUtils, StdCtrls, ExtCtrls, Mask, DateUtils,ADODB;

  function RevPos(src:AnsiString; c:char):integer;
  function IsStringContainsInteger(val:AnsiString):boolean;
  function IsFileExists(strFileName:AnsiString):boolean;
  procedure MessageStringVal(val:AnsiString);
  procedure MessageBoolVal(val:boolean);
  procedure MessageIntVal(val:integer);
  function ASTring2Multiline(strAnsi:AnsiSTring):AnsiString;
  function Multiline2PureASTring(strMultiline:AnsiSTring):AnsiString;
  function Multiline2ClearSTring(strMultiline:AnsiSTring):AnsiString;
  function Multiline2ASTring(strMultiline:AnsiSTring):AnsiString;
  function Change1stword(strPhrase:AnsisTring; strWord:AnsiSTring):AnsiString;
  procedure ResetDBL(dbl: TRxDBLookupCombo);
  procedure FixDBLValue(value: integer; dbl: TRxDBLookupCombo);
  function IsDBLEmpty(dbl: TRxDBLookupCombo): boolean;
  function DateTime2Str(ADate: TDate; ATime: TTime): string;
  function FixFloatStr(str: string): string;
  function IsDateLess(lhs, rhs:string):boolean;
  function ReplaceChar(str: string; old_char, new_char: char): string;

  function AddColumnToGridViewBuilder(GridViewBuilder: TGridViewBuilder;
            FieldName, Title: string; Align:TMyAlign=alDefault):TGBColumn;
  function AddColToGVB(GridViewBuilder: TGridViewBuilder; FieldName, Title: string;
            Align:TMyAlign=alDefault; ShowCellEvent: TShowColumnCellEvent=nil):TGBColumn;
  procedure AddSelSQLToDset(dset: TIBDataSet; SelSQL: string);
  function VarToString(val: variant): string;
  function VarToFloat(val: variant): double;
  function VarToInteger(val: variant): integer;
  function IsDateCorrect(strDateTime: string): boolean;
  procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
  procedure MyExecIBSQL(ibsql: TIBSQL; const exec_sql: string);
  function AddField(_DataSet:TDataSet; const AFieldName:string;
              AFieldClass:TFieldClass; ASize:Word; _Calculated:boolean):TField;
  function NameCase(const s: string): string;
  function Date2FileName(dt: TDate): string;
  function DateTime2FileName(dttm: TDateTime): string;
  procedure EnableLblOnGroupBox(gb: TGroupBox; value: boolean);
  procedure EnableLblOnPanel(pnl: TPanel; value: boolean);
  procedure CorrectTimeEdit(MaskEdit: TMaskEdit);
  function GetComputerName: string;
  function GetYear(dttm: TDateTime): integer;
  procedure SaveBlobToFile(_Field: TField; _FileName: string);
  function Str_to_Int(s: string): integer;
  function MyVarToStr(const V: Variant): string;
//  function IsHasProp(obj: TObject; prop_name: string): boolean;
  function MixDateTime( _Date, _Time: TDateTime ): TDateTime;
  function MyNow: TDateTime;
  function CrazyNow: TDateTime;
  function MyFormatStartEndDate(AStartDT, AEndDT : TDateTime; Afull: boolean): string;
  function FormatHouseNum( HouseNum: string ): string;
  function DateTimeFormat(_form: string ;_datetime: TDateTime): string;  
  procedure MuOpenADOSQL(ADOQ:TADOQuery; sql:string ); //23/12/2011
  function StrListToString(List:tStringList ):String; //05.04.2012
  procedure myWorkLog(_logtext:string); //07.08.2012
  
  function LastMonthDay( month,day, year:integer):TDate; overload; //19.01.2015
  function LastMonthDay(inputday:TDate=0):TDate; overload; //14.05.2013
  function RussianMonth(num_nummonth:Word ):string; //23.07.2013
  function getBeginOfYear() :Tdate; //12.08.2014
  function StrinFirstUpperCaseLowCase(input:string):string; //30.01.2015

implementation

function MyFormatStartEndDate(AStartDT, AEndDT : TDateTime; Afull: boolean): string;
var _StartDate, _EndDate: string;
begin
  if Trunc(AStartDT) <> Trunc(AEndDT) then
  begin
    if Afull then _StartDate := formatdatetime( 'dd.mm.yyyy',AStartDT )
        else _StartDate := '';
    _EndDate := #13 + formatdatetime( 'dd.mm.yyyy',AEndDT );
  end
  else
  begin
    _StartDate := '';
    _EndDate := '';
  end;

  result := _StartDate + ' ' + formatdatetime( 'hh:mm',AStartDT ) +
          ' - '  +  _EndDate + ' ' + formatdatetime( 'hh:mm',AEndDT );

end;

function CrazyNow: TDateTime;
var
  _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond: Word;
begin
  DecodeDateTime( Now, _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond );
  Result := EncodeDateTime( _Year, _Month, _Day, _Hour, _Minute, 0, 0 );
  //
  if Frac( Result ) < StrToTime( '06:00:00' ) then
    Result := trunc( Result - 1 ) + StrToTime( '8:30:00' );
end;


function MyNow: TDateTime;
var
  _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond: Word;
begin
  DecodeDateTime( Now, _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond );
  Result := EncodeDateTime( _Year, _Month, _Day, _Hour, _Minute, 0, 0 );
end;

function DateTimeFormat(_form: string ;_datetime: TDateTime): string;
begin
  if _datetime > 0 then
   result := FormatDateTime(_form, _datetime)
   else
   result := '';
end;

function MixDateTime( _Date, _Time: TDateTime ): TDateTime;
begin
  Result := Trunc( _Date ) + Frac( _Time );
end;

{
function IsHasProp(obj: TObject; prop_name: string): boolean;
var
  p_info: PPropInfo;
begin
  p_info:=GetPropInfo(obj, prop_name);
  if p_info=nil then
    Result:=false
  else
    Result:=true;
end;
}

function MyVarToStr(const V: Variant): string;
begin
  Result := VarToStr( V );
  if ( VarType( V ) = varString ) or
     ( VarType( V ) = varDate ) then
    Result := QuotedStr( Result );;
end;


function Strip(L:char;C:string;Str:string):string;
{L is left,center,right,all,ends}
var Ii :  integer;
begin
   if length(str)<>0 then
    Case Upcase(L) of
    'L' : begin       {Left}
              While (length(Str) > 0)  and  (pos(Str[1],C)<>0) and (length(Str) > 0) do
                    Delete(Str,1,1);
          end;
    'R' : begin       {Right}
              While ((length(Str) > 0)  and ( pos(Str[length(Str)],C)<>0)) do
                    Delete(Str,length(Str),1);
          end;
    'B' : begin       {Both left and right}
              While (length(Str) > 0)  and    (pos(Str[1],C)<>0) do
                    Delete(Str,1,1);
              While (length(Str) > 0)  and  (pos(Str[length(Str)],C)<>0)  do
                    Delete(Str,length(Str),1);
             {удаляем лишние символы}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0)
                    and (ii<length(Str))and (pos(Str[Ii+1],C)<>0)
                    then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    'A' : begin       {All}
              II := 1;
              Repeat
                   If (length(Str) > 0)  and  (pos(Str[Ii],C)<>0) then
                      Delete(Str,Ii,1)
                   else
                      Ii := succ(Ii);
              Until (Ii > length(Str)) or (Str = '');
          end;
    end;
    Strip := Str;
end;  {Func Strip}



function Str_to_Int(s: string): integer;
var
  temp, i: integer;
  Str: string;
begin
    Str:=s;
    If length(Str) = 0 then
       Str_to_Int := 0
    else
    begin
       Str:=Strip('A',' ',Str);
       for i:=1 to length(str) do
          if not (str[i] in ['0'..'9','+','-']) then begin
            delete (str,i,length(str));
            break;
          end;
       val(Str,temp,i);
          Str_to_Int := temp
    end;
end;


procedure SaveBlobToFile(_Field: TField; _FileName: string);
var
  _FileS: TFileStream;
  _BlobS: TStream;
  _DirName: string;
begin
  if FileExists(_FileName) then SysUtils.DeleteFile(_FileName);

  _DirName:=ExtractFilePath(_FileName);
  if not DirectoryExists(_DirName) then
    CreateDir(_DirName);

  _BlobS:=_Field.DataSet.CreateBlobStream(_Field, bmRead);
  try
    _FileS:=TFileStream.Create(_FileName, fmCreate);
    try
      _FileS.CopyFrom(_BlobS, _BlobS.Size);
    finally
      _FileS.Free;
    end;
  finally
    _BlobS.Free;
  end;
end;


function GetYear(dttm: TDateTime): integer;
var
  y, m, d: word;
begin
  DecodeDate(dttm, y, m, d);
  Result:=y;
end;

function GetComputerName: string;
var
   buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
   Size: Cardinal;
begin
   Size := MAX_COMPUTERNAME_LENGTH + 1;
   Windows.GetComputerName(@buffer, Size);
   Result := StrPas(buffer);
end;


procedure CorrectTimeEdit(MaskEdit: TMaskEdit);
var
  s: string;
  i: integer;
begin
  s:=MaskEdit.Text;
  for i:=1 to length(s) do
    if s[i]=' ' then
      s[i]:='0';
  MaskEdit.Text:=s;
end;

procedure EnableLblOnPanel(pnl: TPanel; value: boolean);
var
  i: integer;
begin
  for i:=0 to pnl.ControlCount-1 do
    if (pnl.Controls[i] is TLabel) then
      (pnl.Controls[i] as TLabel).Enabled:=value;
end;


procedure EnableLblOnGroupBox(gb: TGroupBox; value: boolean);
var
  i: integer;
begin
  for i:=0 to gb.ControlCount-1 do
    if (gb.Controls[i] is TLabel) then
      (gb.Controls[i] as TLabel).Enabled:=value;
end;


function RevPos(src:AnsiString; c:char):integer;
var n:integer;
begin
  RevPos := -1;
  n := Length(src);
  while n <> 0 do
  begin
    if src[n] = c then
    begin
      RevPos := n;
      break;
    end;
    n := n - 1;
  end;
end;

function IsStringContainsInteger(val:AnsiString):boolean;
var nNum:integer;
begin
        IsStringContainsInteger := true;
          try
        nNum := StrToInt(val);
        except
          On E: EConvertError do
          begin
            MessageDlg(val + ' не является числом.', mtError, [mbOK], 0);
            IsStringContainsInteger := false;
          end;
        end;
end;

function IsFileExists(strFileName:AnsiString):boolean;
var finddata:TWin32FindData;
    findres:integer;
begin
  findres := windows.FindFirstFile( PChar(strFileName), finddata);
  if findres = -1 then //INVALID_HANDLE_VALUE then ?????? а какого собсно делфя не понимает знаковых констант? это ж  0хFFFFFFFF
  begin
    IsFileExists := false;
    Exit;
  end;
  Windows.findclose(findres);
  IsFileExists := true;
end;


procedure MessageStringVal(val:AnsiString);
begin
  MessageDlg(val, mtInformation, [mbOK], 0);
end;


procedure MessageBoolVal(val:boolean);
begin
  if val then
    MessageDlg('true', mtInformation, [mbOK], 0)
  else
    MessageDlg('false', mtInformation, [mbOK], 0);
end;


procedure MessageIntVal(val:integer);
begin
  MessageDlg(IntToStr(val), mtInformation, [mbOK], 0);
end;


function ASTring2Multiline(strAnsi:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
  n:= 0;

  while n <= Length(strAnsi) - 3 do    //seems that Pos function searches only in first substring// n := Pos(strAddInfo, 'QokQ');
  begin
     if (strAnsi[n] = 'Q') and (strAnsi[n + 1] = 'o') and
          (strAnsi[n + 2] = 'k') and (strAnsi[n + 3] = 'Q') then
     begin
       strAnsi := Copy(strAnsi, 1, n-1) + #13 + #10 + Copy(strAnsi, n+4, Length(strAnsi) - n - 3);
       n:= n + 1;
     end;
     n:= n + 1;
  end;
  strRes := strAnsi;
  AString2Multiline := strRes;
end;



function Multiline2PureASTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
      begin
        strRes := Copy(strRes, 1, n-1) + ' ' + Copy(strRes, n+2, Length(strRes) - n - 1);
        n := n + 2;
      end;
      n:= n + 1;
    end;

  Multiline2PureASTring := strRes;
end;

function Multiline2ClearSTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
        strRes := Copy(strRes, 1, n-1) + ' ' + Copy(strRes, n+1, Length(strRes) - n);
      n:= n + 1;
    end;

  Multiline2ClearSTring := strRes;
end;


function Multiline2ASTring(strMultiline:AnsiSTring):AnsiString;
var n:integer;
  strRes:AnsiSTring;
begin
    n := 1;
    strRes := strMultiline;
    while n <= Length(strRes) do
    begin
      if (strRes[n] = #13) then //local eos found
      begin
        strRes := Copy(strRes, 1, n-1) + 'QokQ' + Copy(strRes, n+2, Length(strRes) - n - 1);
        n := n + 2;
      end;
      n:= n + 1;
    end;

  Multiline2ASTring := strRes;
end;


function Change1stword(strPhrase:AnsisTring; strWord:AnsiSTring):AnsiString;
var i, nLen:integer;
begin
  Change1stWord := strPhrase;
  if strPhrase = '' then
    exit;
  nLen := Length(strPhrase);
  i := 1;
  while (strPhrase[i] = ' ') and (i < nLen) do
  begin
    i := i+1;
  end;
  if i = nLen then
  begin
    exit;
  end;

  while (strPhrase[i] <> ' ') and (i < nLen) do
  begin
    i := i+1;
  end;

  if i = nLen then
    exit;
  Change1stWord := ' ' + strWord + ' ' + Copy(strPhrase, i, Length(strPhrase) - i + 1);
end;


function Date2FileName(dt: TDate): string;
begin
  Result:=DateToStr(dt);
  Delete(Result,3,1);
  Delete(Result,5,1);
end;

function NameCase(const s: string): string;
var
  sym: string;
begin
  Result:=AnsiLowerCase(trim(s));
  sym:=copy(Result, 1, 1);
  Delete(Result, 1, 1);
  Result:=AnsiUpperCase(sym)+Result;
end;


function AddField(_DataSet:TDataSet; const AFieldName:string;
  AFieldClass:TFieldClass; ASize:Word; _Calculated:boolean):TField;
begin
  Result:=_DataSet.FindField(AFieldName); // Field may already exists!
  if Result<>nil then Exit;

  Result:=AFieldClass.Create(_DataSet);
  with Result do
  try
    FieldName:=AFieldName;
    if (Result is TStringField) or (Result is TBCDField) or (Result is TBlobField) or
      (Result is TBytesField) or (Result is TVarBytesField) then
    begin
      Size:=ASize;
    end;
    Calculated:=_Calculated;
    DataSet:=_Dataset;
    Name:=_DataSet.Name+AFieldName;
  except
    Free; // We must release allocated memory on error!
    raise;
  end;
end;


procedure MyExecIBSQL(ibsql: TIBSQL; const exec_sql: string);
begin
  ibsql.Close;
  ibsql.SQL.Clear;
  ibsql.SQL.Add(exec_sql);
  ibsql.ExecQuery;
end;



procedure MyOpenIBDS(dset: TIBDataSet; const sel_sql: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Add(sel_sql);
  dset.Open;
end;


procedure ResetDBL(dbl: TRxDBLookupCombo);
var
  dbl_dset: TDataSet;
begin
  dbl_dset:=dbl.LookupSource.DataSet;
  if dbl_dset.Locate('ID',Integer(-1),[]) then
    dbl.DisplayValue:=dbl_dset.FieldByName('name').AsString
  else
    dbl.DisplayValue:='';  
end;


procedure FixDBLValue(value: integer; dbl:TRxDBLookupCombo);
var
  dbl_dset: TDataSet;
begin
  dbl_dset:=dbl.LookupSource.DataSet;
  if not dbl_dset.Locate('ID', value, []) then
    ResetDBL(dbl)
  else
///    dbl.DisplayValue:=dbl_dset.FieldByName('name').AsString;
   dbl.DisplayValue:=dbl_dset.FieldByName(dbl.LookupDisplay).AsString;
end;


function IsDBLEmpty(dbl: TRxDBLookupCombo): boolean;
var
  dbl_dset: TDataSet;
begin
  Result:=false;
  dbl_dset:=dbl.LookupSource.DataSet;
  if (dbl_dset.FieldByName('ID').AsInteger=-1) or
      (trim(dbl.Text)='')  then
    Result:=true;
end;

function DateTime2Str(ADate: TDate; ATime: TTime): string;
var
  dt: TDateTime;
begin
  dt:=Trunc(ADate);
  dt:=dt+(ATime-Trunc(ATime));
  Result:=''''+DateTimeToStr(dt)+'''';
end;

function FixFloatStr(str: string): string;
var
  p:integer;
begin
  p:=Pos(',',str);
  if p<>0 then
    str[p]:='.';
  Result:=str;
end;

function IsDateLess(lhs, rhs:string):boolean;
var
  dt1, dt2:TDatetime;
begin
  dt1 := StrToDateTime(lhs);
  dt2 := strToDateTime(rhs);
  Result := false;
  if(dt1 < dt2) then
    Result := true;
end;


function ReplaceChar(str: string; old_char, new_char: char): string;
var
  i: integer;
begin
  str:=str+' ';
  for i:=0 to Length(str)-1 do
    if str[i]=old_char then
      str[i]:=new_char;
  Result:=str;
end;


function AddColumnToGridViewBuilder(GridViewBuilder: TGridViewBuilder;
        FieldName, Title: string; Align:TMyAlign=alDefault): TGBColumn;
begin
  with GridViewBuilder do
  begin
    Result:=AddColumn;
    Result.FieldName:=FieldName;
    Result.Alignment:=Align;

    Result.ColumnTitle.Caption:=Title;
    Result.ColumnTitle.Alignment:=alCenter;
    Result.ColumnTitle.Font.Style:=[fsBold];
  end;
end;

function AddColToGVB(GridViewBuilder: TGridViewBuilder; FieldName, Title: string;
        Align:TMyAlign=alDefault; ShowCellEvent: TShowColumnCellEvent=nil):TGBColumn;
begin
  with GridViewBuilder do
  begin
    Result:=AddColumn;
    Result.FieldName:=FieldName;
    Result.Alignment:=Align;
    if Assigned(ShowCellEvent) then
      Result.OnShowColumnCell:=ShowCellEvent;

    Result.ColumnTitle.Caption:=Title;
    Result.ColumnTitle.Alignment:=alCenter;
    Result.ColumnTitle.Font.Style:=[fsBold];
  end;
end;



procedure AddSelSQLToDset(dset: TIBDataSet; SelSQL: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Add(SelSQL);
end;

function VarToString(val: variant): string;
begin
  if val=Null then
    Result:=''
  else
    Result:=string(val);
end;

function VarToFloat(val: variant): double;
begin
  if val=Null then
    Result:=0
  else
    Result:=double(val);
end;

function VarToInteger(val: variant): integer;
begin
  if val=Null then
    Result:=0
  else
    Result:=integer(val);
end;

function IsDateCorrect(strDateTime: string): boolean;
var
  dttm: TDateTime;
begin
  try
    dttm:=StrToDateTime(strDateTime);
  except
    Result:=false;
    exit;
  end;
  Result:=true;
end;

function DateTime2FileName(dttm: TDateTime): string;
begin
  Result:=DelSpace(DateTimeToStr(dttm));
  Result:=DelChars(Result,'.');
  Result:=DelChars(Result,':');
end;

function FormatHouseNum( HouseNum: string ): string;
var
  _ChislaSet, _RazdelSet :set of Char;
  i, length_s: integer;
  _IntPart, _CharPart, _s: string;
begin
  try
    _ChislaSet := ['0'..'9'];
    _RazdelSet := [' ', '.', '-', '+', ',', '\', '/'];

    _IntPart := '';
    _CharPart := '';
    _s := trim( HouseNum );
    length_s := length( _s );    //
    i := 1;
    while ( i <= length_s ) and ( _s[i] in _ChislaSet ) do
    begin
      _IntPart := _IntPart + _s[i];
      i := i + 1;
    end;

    while ( i <= length_s ) and ( _s[i] in _RazdelSet ) do i := i + 1;

    while ( i <= length_s ) and not(  _s[i] in [' ', '-', '\', '/'] ) do
    begin
      _CharPart := _CharPart + _s[i];
      i := i + 1;
    end;

    Result := AnsiUpperCase( _IntPart + _CharPart );
  except
  end
end;


procedure MuOpenADOSQL(ADOQ:TADOQuery; sql:string ) ;
begin
     if ADOQ.Active then
      ADOQ.Close;
      ADOQ.SQL.Clear;
      ADOQ.SQL.Add(sql);
      ADOQ.Open;

end;


function StrListToString(List:tStringList ):String; //05.04.2012
 var i:integer;
begin
Result:='';

for i:=0 to List.Count-1 do
 Result:=Result+List[i]+', ';
Delete(Result,length(Result)-1,1);
end;

procedure myWorkLog(_logtext:string); //07.08.2012
var f: textfile;
    filename:string;
    handler:integer;
begin
    filename:= ExtractFilePath(ParamStr(0)) + 'LogAVR.txt';

    if not IsFileExists(filename) then
    begin
     handler:=FileCreate(filename);
      FileClose(handler);
    end ;


     AssignFile(F, ExtractFilePath(ParamStr(0)) + 'LogAVR.txt');
     Append(F);
     WriteLn(F, DateTimeToStr(Now)+' :: '+ _logtext);
     Flush(F);
     CloseFile(F);


end;

function LastMonthDay( month,day, year:integer):TDate;
begin
  if month=12 then
  begin
   month:=1;
   year:=year+1;
 end
  else
    month:=month+1;
 Result:=EncodeDate(year,month,1);
 Result:=Result-1;
end;

function LastMonthDay(inputday:TDate=0 ):TDate;
var year,month,day:word;
    date:TDate;
begin
if inputday=0 then date:=Now
else date:=inputday;

 DecodeDate(date,year,month,day) ;
 Result:=LastMonthDay( month,day, year);
end;

function RussianMonth(num_nummonth:Word ):string;
begin
  case num_nummonth of
  1:	Result:='Январь';
  2:	Result:='Февраль';
  3:	Result:='Март';
  4:	Result:='Апрель';
  5:	Result:='Май';
  6:	Result:='Июнь';
  7:	Result:='Июль';
  8:	Result:='Август';
  9:	Result:='Сентябрь';
  10:	Result:='Октябрь';
  11:	Result:='Ноябрь';
  12:	Result:='Декабрь';
  end;


end;

function getBeginOfYear() :Tdate;
var year,month,day:word;
begin
 DecodeDate(Date,year,month,day);
 result:=EncodeDate(year,1,1);
end;

function StrinFirstUpperCaseLowCase( input:string):string;
 var endString:string;
begin
 Result := Copy(input,1,1);
 Result:=UpperCase(Result);
 delete(input,1,1);
 input := lowerCase(input);
 REsult:= REsult +input;

end;

end.

