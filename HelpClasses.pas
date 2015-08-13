unit HelpClasses;

interface

uses Classes, SysUtils;

type
   TProce=procedure (str:string) of object;
  TQueryGenerator=class
  private
    F_StrLs: TStringList;
    F_TableName: string;
    F_Condition: string;
    procedure SetValueByFieldName(const FieldName, Value: string);
    procedure InitFields;
  public
    property ValueByFieldName[const FieldName: string]: string write SetValueByFieldName;
    property Condition: string write F_Condition;
    property TableName: string write F_TableName;
    function GenInsertQuery: string;
    function GenUpdateQuery: string;
    function GenDeleteQuery: string;
    function GenUpdateToNullQuery: string;

  function GenUpdateOrInsertQuery: string;
    
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

  TNameContainer=class
  private
    F_StrLs: TStringList;
    function GetIDByName(const Name: string): string;
    procedure SetIDByName(const Name: string; Value: string);
  public
    property IDByName[const Name: string]: string read GetIDByName write SetIDByName;
    function IDByIndex(Index: integer): string;
    function NameByIndex(Index: integer): string;
    function Count: integer;
    constructor Create;
    destructor Destroy; override;
  end;

  TOnChangeAttachCount = procedure ( _AttachCount: integer ) of object;
  TIsAttached = procedure( _id: integer; var _IsAttached: boolean ) of object;
  TChangeAttachState = procedure( _id: integer ) of object;

  TAttachList=class(TList)
  private
    F_OnChangeAttachCount: TOnChangeAttachCount;
    procedure ChangeAttachCount( _AttachCount: integer );
  public
    function IsAttached( _id: integer ): boolean;
    procedure ChangeAttachState( _id: integer );
    property OnChangeAttachCount: TOnChangeAttachCount read F_OnChangeAttachCount
      write F_OnChangeAttachCount;
  end;


  TQCGField=class
  private
    F_FieldID: integer;
    F_FormatStr: string;
    F_FieldValue: string;
  public
    constructor Create( _FieldID: integer );
    property FormatStr: string read F_FormatStr write F_FormatStr;
    property FieldValue: string read F_FieldValue write F_FieldValue;
    function GenFieldCondition: string;
  end;


  TQueryConditionGenerator=class
  private
    F_FieldList: TList;
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;
    function AddField( _FieldID: integer ): TQCGField; overload;
    procedure AddField( _FieldID: integer; _FormatStr: string; _FieldValue: string ); overload;
    function GenConditon: string;
  end;


implementation

{ TQueryGenerator }

procedure TQueryGenerator.Clear;
begin
  F_StrLs.Clear;
end;

constructor TQueryGenerator.Create;
begin
  inherited Create;
  F_StrLs:=TstringList.Create;

  InitFields;
end;

destructor TQueryGenerator.Destroy;
begin
  F_StrLs.Free;
  inherited Destroy;
end;

function TQueryGenerator.GenDeleteQuery: string;
begin
  Result:=Format('delete from %s', [F_TableName]);
  if F_Condition<>'' then
    Result:=Result+' where '+F_Condition;
end;

function TQueryGenerator.GenInsertQuery: string;
var
  i: integer;
  fields, values: string;
begin
  fields:=''; values:=''; Result:='';

  for i:=0 to F_StrLs.Count-1 do
  begin
    fields:=fields+F_StrLs.Names[i]+',';
    values:=values+F_StrLs.ValueFromIndex[i]+',';
  end;

  Delete(fields, length(fields),1);
  Delete(values,length(values),1);
  Result:=Format('insert into %s(%s) values(%s)',[F_TableName, fields, values]);
end;

function TQueryGenerator.GenUpdateOrInsertQuery: string;
var
  i: integer;
  fields, values: string;
begin
   fields:=''; values:=''; Result:='';

  for i:=0 to F_StrLs.Count-1 do
  begin
    fields:=fields+F_StrLs.Names[i]+',';
    values:=values+F_StrLs.ValueFromIndex[i]+',';
  end;

  Delete(fields, length(fields),1);
  Delete(values,length(values),1);
  Result:=Format('update or insert into %s(%s) values(%s) %s',[F_TableName, fields, values,F_Condition]);
end;

function TQueryGenerator.GenUpdateQuery: string;
var
  i: integer;
  field_value: string;
begin
  field_value:=''; Result:='';
  for i:=0 to F_StrLs.Count-1 do
    field_value:=field_value+F_StrLs.Strings[i]+',';
  Delete(field_value, length(field_value),1);
  Result:=Format('update %s set %s ',[F_TableName, field_value]);
  if F_Condition<>'' then
    Result:=Result+' where '+F_Condition;
end;

function TQueryGenerator.GenUpdateToNullQuery: string;
var
  i: integer;
  field_value: string;
begin
  field_value:=''; Result:='';
  for i:=0 to F_StrLs.Count-1 do
    field_value:=field_value+F_StrLs.Names[i]+'=NULL,';
  Delete(field_value, length(field_value),1);
  Result:=Format('update %s set %s ',[F_TableName, field_value]);
  if F_Condition<>'' then
    Result:=Result+' where '+F_Condition;
end;

procedure TQueryGenerator.InitFields;
begin
  F_TableName:='';
  F_Condition:='';
end;

procedure TQueryGenerator.SetValueByFieldName(const FieldName,
  Value: string);
begin
  F_StrLs.Values[FieldName]:=Value;
end;

{ TNameContainer }

function TNameContainer.Count: integer;
begin
  Result:=F_StrLs.Count;
end;

constructor TNameContainer.Create;
begin
  inherited Create;
  F_StrLs:=TStringList.Create;
end;

destructor TNameContainer.Destroy;
begin
  F_StrLs.Free;
  inherited Destroy;
end;

function TNameContainer.GetIDByName(const Name: string): string;
begin
  Result:=F_StrLs.Values[trim(Name)];
  if Result='' then
    raise Exception.Create('Функция TNameContainer.GetIDByName вернула пустую строку');
end;

function TNameContainer.IDByIndex(Index: integer): string;
begin
  Result:=F_StrLs.ValueFromIndex[Index];
end;

function TNameContainer.NameByIndex(Index: integer): string;
begin
  Result:=F_StrLs.Names[Index];
end;

procedure TNameContainer.SetIDByName(const Name: string; Value: string);
begin
  F_StrLs.Values[trim(Name)]:=Value;
end;

{ TAttachList }

procedure TAttachList.ChangeAttachCount(_AttachCount: integer);
begin
  if Assigned( F_OnChangeAttachCount ) then
    F_OnChangeAttachCount( _AttachCount );
end;

procedure TAttachList.ChangeAttachState(_id: integer);
var
  i: integer;
  _IsFind: boolean;
begin
  _IsFind := false;
  i:=0;
  while i<Count do
  begin
    if Integer( Items[i] ) = _id then
    begin
      self.Delete( i );
      _IsFind := true;
    end else Inc(i);
  end;

  if not _IsFind then
    self.Add( ptr( _id ) );

  ChangeAttachCount( Count );
end;

function TAttachList.IsAttached(_id: integer): boolean;
var
  i: integer;
begin
  Result := false;
  for i:=0 to Count-1 do
    if integer( Items[i] ) = _id then
    begin
      Result := true;
      break;
    end;
end;

{ TQCGField }

constructor TQCGField.Create(_FieldID: integer);
begin
  inherited Create;
  F_FieldID := _FieldID;
end;

function TQCGField.GenFieldCondition: string;
begin
  if trim( F_FieldValue ) <> '' then
    Result := Format( F_FormatStr, [ F_FieldValue ] )
  else
    Result := '';
end;

{ TQueryConditionGenerator }

function TQueryConditionGenerator.AddField(_FieldID: integer): TQCGField;
begin
  Result := TQCGField.Create( _FieldID );
  F_FieldList.Add( Result );
end;

procedure TQueryConditionGenerator.AddField(_FieldID: integer; _FormatStr,
  _FieldValue: string);
var
  _field: TQCGField;
begin
  _field := AddField( _FieldID );
  _field.FormatStr := _FormatStr;
  _field.FieldValue := _FieldValue;
end;

procedure TQueryConditionGenerator.Clear;
var
  i: integer;
begin
  for i:=0 to F_FieldList.Count -1 do
    TQCGField( F_FieldList.Items[i] ).Free;
  F_FieldList.Clear;
end;

constructor TQueryConditionGenerator.Create;
begin
  inherited Create;
  F_FieldList := TList.Create;
end;

destructor TQueryConditionGenerator.Destroy;
begin
  F_FieldList.Clear;
  F_FieldList.Free;

  inherited Destroy;
end;

function TQueryConditionGenerator.GenConditon: string;
var
  i: integer;
  _cond: string;
begin
  Result := '';
  for i:=0 to F_FieldList.Count-1 do
  begin
    _cond := TQCGField( F_FieldList.Items[i] ).GenFieldCondition;
    if trim( _cond ) <> '' then
      Result := Result + ' and (' +_cond + ')';
  end;
end;

end.
