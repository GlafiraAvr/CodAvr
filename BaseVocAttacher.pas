unit BaseVocAttacher;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tdm_BaseVocAttacher = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_MemTableList: TList;
    F_IsShowDeletedRowInVocs,                  //показывать или нет удаленные записи
    F_IsShowRowOnlyForCurDistrict: boolean;    //показывать или нет только строки разрешенные для данного участка
    procedure SetIsShowDeletedRowInVocs(const Value: boolean);
    procedure SetIsShowRowOnlyForCurDistrict(const Value: boolean);
  protected
    procedure VocFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure VocBeforeClose(DataSet: TDataSet);
    procedure VocAfterOpen(DataSet: TDataSet);
    procedure RefilterAllMemTable;
  public
    property IsShowDeletedRowInVocs: boolean read F_IsShowDeletedRowInVocs
      write SetIsShowDeletedRowInVocs;
    property IsShowRowOnlyForCurDistrict: boolean read F_IsShowRowOnlyForCurDistrict
      write SetIsShowRowOnlyForCurDistrict;
    procedure SetRowShow( _IsShowDeletedRowInVocs, _IsShowRowOnlyForCurDistrict: boolean );
    procedure AttachToGlobalVocCache;
    procedure Reopen;
  end;

implementation

{$R *.dfm}

uses VocsConst;

procedure Tdm_BaseVocAttacher.AttachToGlobalVocCache;
begin
  dm_GlobalVocCache.CheckVocs( F_MemTableList );
  Reopen;
end;

procedure Tdm_BaseVocAttacher.DataModuleCreate(Sender: TObject);
var
  i: integer;
  _mem: TkbmMemTable;
begin
  F_IsShowDeletedRowInVocs := true;            //по умолчанию удаленные записи не показываем
  F_IsShowRowOnlyForCurDistrict := false;      //по умолчанию показываем записи для всех участков

  F_MemTableList := TList.Create;
  for i:=0 to ComponentCount-1 do
    if ( Components[i] is TkbmMemTable ) then
    begin
      _mem := ( Components[i] as TkbmMemTable );
      _mem.Tag := -1;
      _mem.OnFilterRecord := VocFilterRecord;
      _mem.AfterOpen := VocAfterOpen;
      _mem.BeforeClose := VocBeforeClose;
      _mem.Filtered := true;
      F_MemTableList.Add( _mem );
    end;
end;

procedure Tdm_BaseVocAttacher.DataModuleDestroy(Sender: TObject);
begin
  F_MemTableList.Free;
end;

procedure Tdm_BaseVocAttacher.RefilterAllMemTable;
var
  i: integer;
  _mem: TkbmMemTable;
begin
  for i := 0 to F_MemTableList.Count - 1 do
  begin
    _mem := TkbmMemTable( F_MemTableList.Items[ i ] );
    _mem.Filtered := false;
    _mem.Filtered := true;
  end;
end;

procedure Tdm_BaseVocAttacher.Reopen;
var
  _mem: TkbmMemTable;
  i: integer;
begin
  for i:=0 to F_MemTableList.Count-1 do
  begin
    _mem := TkbmMemTable( F_MemTableList.Items[i] );
    if not _mem.Active then _mem.Open;
  end;
end;

procedure Tdm_BaseVocAttacher.SetIsShowDeletedRowInVocs(
  const Value: boolean);
begin
  F_IsShowDeletedRowInVocs := Value;
  RefilterAllMemTable;
end;

procedure Tdm_BaseVocAttacher.SetIsShowRowOnlyForCurDistrict(
  const Value: boolean);
begin
  F_IsShowRowOnlyForCurDistrict := Value;
  RefilterAllMemTable;
end;

procedure Tdm_BaseVocAttacher.SetRowShow(_IsShowDeletedRowInVocs,
  _IsShowRowOnlyForCurDistrict: boolean);
begin
  F_IsShowDeletedRowInVocs := _IsShowDeletedRowInVocs;
  F_IsShowRowOnlyForCurDistrict := _IsShowRowOnlyForCurDistrict;
  RefilterAllMemTable;
end;

procedure Tdm_BaseVocAttacher.VocAfterOpen(DataSet: TDataSet);
begin
  DataSet.Locate( 'id', DataSet.Tag, [] );
end;

procedure Tdm_BaseVocAttacher.VocBeforeClose(DataSet: TDataSet);
begin
  DataSet.Tag := DataSet.FieldByName('id').AsInteger;
end;

procedure Tdm_BaseVocAttacher.VocFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := true;

  if ( not F_IsShowDeletedRowInVocs ) and ( not DataSet.FieldByName('Activity').IsNull ) then
    Accept := false;

  if ( Accept ) and ( F_IsShowRowOnlyForCurDistrict ) and Assigned( DataSet.FindField( VocsConst.IS_VISIBLE_FOR_CUR_REC ) ) and
    ( DataSet.FieldByName( IS_VISIBLE_FOR_CUR_REC ).AsInteger <> 1 )
  then
      Accept := false;
end;

end.
