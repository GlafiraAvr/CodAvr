unit SnapShotManagerDModule;

interface

{
    delete from snshot_types;

    set generator GEN_SNSHOT_TYPES_ID TO 0;

    delete from snshot_snapshots;
    set generator gen_snshot_snapshots_id TO 0;

    delete from snshot_dsets;
    set generator gen_snshot_dsets_id TO 0;

    delete from snshot_fields;
    set generator gen_snshot_fields_id TO 0;

    delete from snshot_values;
}

uses
  SysUtils, Classes, Controls, DB, IBSQL, IBDatabase, IBCustomDataSet, DModule;

type
  TSnShotDset=class
  private
    F_DataSet: TDataSet;
    F_FieldNameList: TStringList;
  public
    property FieldNameList: TStringList read F_FieldNameList write F_FieldNameList;
    property DataSet: TDataSet read F_DataSet;
    constructor Create(ADataSet: TDataSet);
    destructor Destroy; override;
  end;

  TActionType=(atDoSnapShot, atLoadSnapShot);

  Tdm_SnapShotManager = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    IBSQL: TIBSQL;
    dset_Dsets: TIBDataSet;
    dset_Fields: TIBDataSet;
    dset_Values: TIBDataSet;
  private
    F_SnapShotType: string;
    F_SnapShotDate: TDate;
    F_DsetList: TList;
    F_CurUser: string;
    procedure ExecSQL(sql: string);
    procedure OpenDset(sql: string);
    procedure IsCorrectFieldValues;
    procedure DoAction(ActionType: TActionType);
    procedure LoadSnapshotDset(id_dset: integer; sn_dset: TSnShotDset);
    procedure _DoSnapShot;
    procedure _LoadSnapShot;
    //
    function SelSNShotTypeID: integer;
    procedure InsSNShotType;
    //
    function SelShotID(id_type: integer): integer;
    procedure DelShort(id_short: integer);
    procedure InsShort(id_type: integer);
    //
    procedure InsDset(name: string; id_shot: integer);
    function SelMaxDsetID(id_shot: integer): integer;
    //
    procedure InsField(id_dset: integer; name: string);
    function SelMaxFieldID(id_dset: integer): integer;
    //
    procedure InsValue(id_field: integer; f_value: string; rec_num: integer);
    //
  private
    procedure SetSnapShotType(const Value: string);
  public
    property SnapShotType: string read F_SnapShotType write SetSnapShotType;
    property SnapShotDate: TDate read F_SnapShotDate write F_SnapShotDate;
    property CurUser: string read F_CurUser;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure ClearDsetList;
    function AddSNShotDset(ADataSet: TDataSet): TSnShotDset;
    procedure DoSnapShot;
    procedure LoadSnapShot;
    procedure LoadSnapshotDatesList(var list: TStringList);
  end;

implementation

uses RightsManagerDModule;

{$R *.dfm}

{ TSnShotDset }

constructor TSnShotDset.Create(ADataSet: TDataSet);
begin
  inherited Create;
  F_FieldNameList:=TStringList.Create;
  F_DataSet:=ADataSet;
end;

destructor TSnShotDset.Destroy;
begin
  F_FieldNameList.Clear;
  F_FieldNameList.Free;
  inherited Destroy;
end;

{ Tdm_SnapShotManager }

function Tdm_SnapShotManager.AddSNShotDset(
  ADataSet: TDataSet): TSnShotDset;
begin
  Result:=TSNShotDset.Create(ADataSet);
  F_DsetList.Add(Result);
end;

procedure Tdm_SnapShotManager.ClearDsetList;
var
  i: integer;
begin
  for i:=0 to F_DsetList.Count-1 do
    TSNShotDset(F_DsetList.Items[i]).Free;
  F_DsetList.Clear;
end;

constructor Tdm_SnapShotManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  F_DsetList:=TList.Create;
  F_SnapShotType:='';
  F_SnapShotDate:=0;
end;

destructor Tdm_SnapShotManager.Destroy;
begin
  ClearDsetList;
  F_DsetList.Free;
  inherited Destroy;
end;

procedure Tdm_SnapShotManager.DoSnapShot;
begin
  DoAction(atDoSnapShot);
end;

procedure Tdm_SnapShotManager.ExecSQL(sql: string);
begin
  if not IBSQL.Database.Connected then IBSQL.Database.Connected := true; 
  IBSQL.Close;
  IBSQL.SQL.Clear;
  IBSQL.SQL.Text:=sql;
  IBSQL.ExecQuery;
end;

function Tdm_SnapShotManager.SelSNShotTypeID: integer;
begin
  OpenDset('select id from snshot_types where name='+QuotedStr(F_SnapShotType));
  if dset.Eof and dset.Bof then
    Result:=-1
  else
    Result:=dset.FieldByName('id').AsInteger;  
end;

procedure Tdm_SnapShotManager.IsCorrectFieldValues;
begin
  if trim(F_SnapShotType)='' then
    raise Exception.Create('Не задано поле SnapShotType');
  if F_SnapShotDate=0 then
    raise Exception.Create('Не задано поле SnapShotDate');
end;

procedure Tdm_SnapShotManager.OpenDset(sql: string);
begin
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Text:=sql;
  dset.Open;
  dset.First;
end;

procedure Tdm_SnapShotManager.SetSnapShotType(const Value: string);
begin
  F_SnapShotType:=AnsiUpperCase(Value);
end;

procedure Tdm_SnapShotManager._DoSnapShot;
var
  TypeID, ShotID, DsetID, FieldID: integer;
  i, j, rec_num: integer;
  sn_dset: TSNShotDset;
  field_name, field_value, bmark: string;
begin
  {Находим TypeID}
  TypeID:=SelSNShotTypeID;
  if TypeID=-1 then
  begin
    InsSNShotType;
    TypeID:=SelSNShotTypeID;
  end;
  {/Находим TypeID}


  {Находим ShortID}
  ShotID:=SelShotID(TypeID);
  if ShotID<>-1 then
    DelShort(ShotID);
  InsShort(TypeID);
  ShotID:=SelShotID(TypeID);
  {/Находим ShortID}

  {Заносим значения}
  for i:=0 to F_DsetList.Count-1 do
  begin
    sn_dset:=TSNShotDset(F_DsetList.Items[i]);
    bmark:=sn_dset.DataSet.Bookmark;
    sn_dset.DataSet.DisableControls;

    InsDset(sn_dset.DataSet.Name, ShotID);
    DsetID:=SelMaxDsetID(ShotID);
    for j:=0 to sn_dset.FieldNameList.Count-1 do
    begin
      field_name:=sn_dset.FieldNameList.Strings[j];
      InsField(DsetID, field_name);
      FieldID:=SelMaxFieldID(DsetID);
      rec_num:=1;
      sn_dset.DataSet.First;
      while not sn_dset.DataSet.Eof do
      begin
        field_value:=sn_dset.DataSet.FieldByName(field_name).AsString;
        InsValue(FieldID, field_value, rec_num);

        inc(rec_num);
        sn_dset.DataSet.Next;
      end;
    end;

    sn_dset.DataSet.Bookmark:=bmark;
    sn_dset.DataSet.EnableControls;
  end;
  {/Заносим значения}
end;

procedure Tdm_SnapShotManager.InsSNShotType;
begin
  ExecSQL(Format('insert into snshot_types(name) values(''%s'')',[F_SnapShotType]));
end;

function Tdm_SnapShotManager.SelShotID(id_type: integer): integer;
begin
  OpenDset(Format('select id, cur_user from snshot_snapshots s where (id_type=%d) and (dt=''%s'')',
                [id_type, DateToStr(F_SnapShotDate)]));
  if dset.Eof and dset.Bof then
    Result:=-1
  else
    begin
     F_CurUser := dset.FieldByName('cur_user').AsString;
     Result:=dset.FieldByName('ID').AsInteger;
    end;
end;



procedure Tdm_SnapShotManager.DelShort(id_short: integer);
begin
  ExecSQL(Format('delete from snshot_snapshots where id=%d',[id_short]));

  ExecSQL(Format(
    ' delete from snshot_values where id_field in'+
    '   (select id from snshot_fields where id_dset in'+
    '     (select id from snshot_dsets where id_snapshot=%d))',
    [id_short]));

  ExecSQL(Format(
    ' delete from snshot_fields where id_dset in'+
    ' (select id from snshot_dsets where id_snapshot=%d)',
    [id_short]));

  ExecSQL(Format('delete from snshot_dsets where id_snapshot=%d',
    [id_short]));
end;

procedure Tdm_SnapShotManager.InsShort(id_type: integer);
begin
  ExecSQL(Format('insert into snshot_snapshots(dt, id_type, cur_user) values(''%s'', %d , ''' +
                  DM_RightsManager.CurrentUserName + ''')',
                  [DateToStr(F_SnapShotDate), id_type]));

end;

procedure Tdm_SnapShotManager.InsDset(name: string; id_shot: integer);
begin
  ExecSQL(Format(' insert into snshot_dsets(name, id_snapshot)'+
                ' values(''%s'', %d)',[name, id_shot]));
end;

function Tdm_SnapShotManager.SelMaxDsetID(id_shot: integer): integer;
begin
  OpenDset('select max(id) id from snshot_dsets where id_snapshot='+IntToStr(id_shot));
  Result:=dset.FieldByName('id').AsInteger;
end;

procedure Tdm_SnapShotManager.InsField(id_dset: integer; name: string);
begin
  ExecSQL(Format( ' insert into snshot_fields(id_dset, field_name)'+
                  ' values(%d, ''%s'')',
                  [id_dset, trim(name)]));
end;

function Tdm_SnapShotManager.SelMaxFieldID(id_dset: integer): integer;
begin
  OpenDset('select max(id) id from snshot_fields where id_dset='+IntToStr(id_dset));
  Result:=dset.FieldByName('id').AsInteger;
end;

procedure Tdm_SnapShotManager.InsValue(id_field: integer; f_value: string; rec_num: integer);
begin
  f_value:=trim(f_value);
  if f_value='' then f_value:='NULL'
  else f_value:=QuotedStr(f_value);

  ExecSQL(Format( ' insert into snshot_values(id_field, field_value, row_number)'+
                  ' values(%d, %s, %d)',
                  [id_field, f_value, rec_num]));
end;

procedure Tdm_SnapShotManager.LoadSnapShot;
begin
  DoAction(atLoadSnapShot);
end;

procedure Tdm_SnapShotManager.DoAction(ActionType: TActionType);
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    IsCorrectFieldValues;
    case ActionType of
      atDoSnapShot: _DoSnapShot;
      atLoadSnapShot: _LoadSnapShot;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_SnapShotManager.DoAction)');
    end;
  end;
end;

procedure Tdm_SnapShotManager._LoadSnapShot;
var
  TypeID, ShotID: integer;
  i: integer;
  sn_dset: TSNShotDset;
begin
  {Находим TypeID}
  TypeID:=SelSNShotTypeID;
  if TypeID=-1 then
    raise Exception.Create('В таблице SNSHOT_TYPES отсутствует значение равное полю SnapShotType');
  {/Находим TypeID}

  {Находим ShortID}
  ShotID:=SelShotID(TypeID);
  if ShotID=-1 then
    raise Exception.Create('В таблице SNSHOT_SNAPSHOTES отсутствует значение соответствующее полю SnapShotDate');
  {/Находим ShortID}


  dset_Dsets.Close;
  dset_Dsets.ParamByName('pShotID').AsInteger:=ShotID;
  dset_Dsets.Open;
  dset_Dsets.First;
  while not dset_Dsets.Eof do
  begin
    for i:=0 to F_DsetList.Count-1 do
    begin
      sn_dset:=TSNShotDset(F_DsetList.Items[i]);
      if trim(sn_dset.DataSet.Name)=trim(dset_Dsets.FieldByName('name').AsString) then
      begin
        LoadSnapshotDset(dset_Dsets.FieldByName('ID').AsInteger, sn_dset);
        break;
      end;
    end;
    dset_Dsets.Next;
  end;
end;

procedure Tdm_SnapShotManager.LoadSnapshotDset(id_dset: integer;
  sn_dset: TSnShotDset);
var
  ds: TDataSet;
  field_name: string;
begin
  ds:=sn_dset.DataSet;
  ds.DisableControls;
  ds.Close;
  ds.Open;

  dset_Fields.Close;
  dset_Fields.ParamByName('pDsetID').AsInteger:=id_dset;
  dset_Fields.Open;
  dset_Fields.Last;
  dset_Fields.First;
  while not dset_Fields.Eof do
  begin
    field_name:=dset_Fields.FieldByName('field_name').AsString;
    if ds.FindField(field_name)<>nil then
    begin
      dset_Values.Close;
      dset_Values.ParamByName('pFieldID').AsInteger:=dset_Fields.FieldByName('id').AsInteger;
      dset_Values.Open;
      dset_Values.First;
      ds.First;
      while not dset_Values.Eof do
      begin
        if dset_Fields.RecNo=1 then ds.Append
        else ds.Edit;
        ds.FieldByName(field_name).Value:=dset_Values.FieldByName('field_value').Value;
        ds.Post;

        if dset_Fields.RecNo<>1 then ds.Next;
        dset_Values.Next;
      end;
    end;
    dset_Fields.Next;
  end;
  ds.First;
  ds.EnableControls;
end;

procedure Tdm_SnapShotManager.LoadSnapshotDatesList(var list: TStringList);
var
  TypeID: integer;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    if trim(F_SnapShotType)='' then
      raise Exception.Create('Не задано поле SnapShotType');

    TypeID:=SelSNShotTypeID;
    if TypeID=-1 then
      raise Exception.Create('В таблице SNSHOT_TYPES отсутствует значение равное полю SnapShotType');

    list.Clear;
    OpenDset('select id, dt from SNSHOT_SNAPSHOTS where id_type='+IntToStr(TypeID)+' order by dt desc');
    while not dset.Eof do
    begin
      list.Add(dset.FieldByName('dt').AsString);
      dset.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_SnapShotManager.LoadSnapshotDatesList)');
    end;
  end;
end;

end.
