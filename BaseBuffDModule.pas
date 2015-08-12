unit BaseBuffDModule;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DModule, IBDatabase, IBCustomDataSet,
  IBSQL;

type
  TRecState = (rsDeleted,    //удаленная запись
               rsOriginal,   //неменявшаяся запись
               rsModifed,    //измененная запись
               rsInserted);  //вставленная запись

  TBuffStack=class
  public
    mt_BuffData: TkbmMemTable;
    IsDataChanged,
    IsDataLoad: boolean;
    OnDataChanged: TNotifyEvent;
    constructor Create;
    destructor Destroy; override;
  end;

  Tdm_BaseBuff = class(TDataModule)
    mt_BuffData: TkbmMemTable;
    mt_BuffDataREC_STATE: TSmallintField;
    dset: TIBDataSet;
    tran: TIBTransaction;
    sql_Insert: TIBSQL;
    sql_Update: TIBSQL;
    sql_Delete: TIBSQL;
    procedure mt_BuffDataFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure mt_BuffDataBeforePost(DataSet: TDataSet);
    procedure mt_BuffDataAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  protected
    F_IsDataChanged,
    F_IsDataLoad: boolean;
    F_OnDataChanged: TNotifyEvent;
    F_IsInternalDataBuffMod: boolean;  //перед внутренним изменением ставим в true !!!
    F_IsReadOnly: boolean;
    F_BuffStack: TBuffStack;
    procedure SetIsDataChanged( Value: boolean );
  protected
    procedure OpenVocs; virtual;
    procedure FillBuffData; virtual;
    procedure InsertBuffRec; virtual;
    procedure UpdateBuffRec; virtual;
    procedure DeleteBuffRec; virtual;
    procedure ISSentRallBack; virtual;
  public
    procedure SaveData; virtual;
    procedure ResetBuff;
    procedure LoadData;
    procedure SaveToStack;
    procedure LoadFromStack;
    property OnDataChanged: TNotifyEvent read F_OnDataChanged
      write F_OnDataChanged;
    procedure DeleteCurrentRec;
    property IsDataLoad: boolean read F_IsDataLoad write F_IsDataLoad;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
  end;

implementation

{$R *.dfm}

{ Tdm_BaseBuff }

procedure Tdm_BaseBuff.OpenVocs;
begin
//
end;

procedure Tdm_BaseBuff.ISSentRallBack;
begin
//
end;



procedure Tdm_BaseBuff.ResetBuff;
begin
  mt_BuffData.Close;
  mt_BuffData.Open;

  F_IsInternalDataBuffMod := false;
  F_IsDataChanged := false;
  F_IsDataLoad := false;
end;

procedure Tdm_BaseBuff.mt_BuffDataFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := ( DataSet.FieldByName( 'REC_STATE' ).AsInteger <> Ord( rsDeleted ) );
end;

procedure Tdm_BaseBuff.FillBuffData;
begin
//
end;

procedure Tdm_BaseBuff.LoadData;
begin
  ResetBuff;
  OpenVocs;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    F_IsInternalDataBuffMod := true;
    try
      FillBuffData;
    finally
      F_IsInternalDataBuffMod := false;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_BaseBuff.LoadData)' );
    end;
  end;

  mt_BuffData.Filtered := true;
  F_IsDataLoad := true;
end;

procedure Tdm_BaseBuff.SetIsDataChanged(Value: boolean);
begin
  F_IsDataChanged := Value;
  if Assigned( F_OnDataChanged ) then
    F_OnDataChanged( nil );
end;

procedure Tdm_BaseBuff.mt_BuffDataBeforePost(DataSet: TDataSet);
begin
  if not F_IsInternalDataBuffMod then
  begin
    with mt_BuffData do
    begin
      if State = dsInsert then
      begin
        FieldByName( 'REC_STATE' ).AsInteger := Ord( rsInserted )
      end else
      if ( State = dsEdit ) then
      begin
        if FieldByName( 'REC_STATE' ).AsInteger = Ord( rsOriginal ) then
          FieldByName( 'REC_STATE' ).AsInteger := Ord( rsModifed );
      end;
    end;
  end;
end;

procedure Tdm_BaseBuff.mt_BuffDataAfterPost(DataSet: TDataSet);
begin
  if not F_IsInternalDataBuffMod then
    SetIsDataChanged( true );
end;

procedure Tdm_BaseBuff.DeleteCurrentRec;
begin
  F_IsInternalDataBuffMod := true;
  try
    if mt_BuffData.FieldByName( 'REC_STATE' ).AsInteger = Ord( rsInserted ) then
    begin
      mt_BuffData.Delete;
    end else
    begin
      mt_BuffData.Edit;
      mt_BuffData.FieldByName( 'REC_STATE' ).AsInteger := Ord( rsDeleted );
      ISSentRallBack;
      mt_BuffData.Post;
    end;
    SetIsDataChanged( true );
  finally
    F_IsInternalDataBuffMod := false;
  end;
end;

procedure Tdm_BaseBuff.DataModuleCreate(Sender: TObject);
begin
  F_IsInternalDataBuffMod := false;
  F_IsDataChanged := false;
  F_IsDataLoad := false;
  F_IsReadOnly := false;

  F_BuffStack := TBuffStack.Create;
end;

procedure Tdm_BaseBuff.SaveData;
begin
  if F_IsDataChanged then
  begin
    if tran.InTransaction then tran.Rollback;
    tran.StartTransaction;
    try
      mt_BuffData.Filtered := false;
      mt_BuffData.First;
      while not mt_BuffData.Eof do
      begin
        case mt_BuffData.FieldByName( 'REC_STATE' ).AsInteger of
          Ord( rsDeleted ):
            begin
              sql_Delete.Close;
              DeleteBuffRec;
              sql_Delete.ExecQuery;
            end;
          Ord( rsModifed ):
            begin
              sql_Update.Close;
              UpdateBuffRec;
              sql_Update.ExecQuery;
            end;
          Ord( rsInserted ):
            begin
              sql_Insert.Close;
              InsertBuffRec;
              sql_Insert.ExecQuery;
            end;
        end;
        mt_BuffData.Next;
      end;

      tran.Commit;
    except
      on E: Exception do
      begin
        tran.Rollback;
        raise Exception.Create( E.Message + '(Tdm_BaseBuff.SaveData)' );
      end;
    end;
  end;
end;

procedure Tdm_BaseBuff.DeleteBuffRec;
begin
//
end;

procedure Tdm_BaseBuff.InsertBuffRec;
begin
//
end;

procedure Tdm_BaseBuff.UpdateBuffRec;
begin
//
end;

procedure Tdm_BaseBuff.SaveToStack;
begin
  F_IsInternalDataBuffMod := true;
  try
    F_BuffStack.mt_BuffData.LoadFromDataSet( self.mt_BuffData, [ mtcpoStructure ] );
    F_BuffStack.IsDataChanged := F_IsDataChanged;
    F_BuffStack.IsDataLoad := F_IsDataLoad;
  finally
    F_IsInternalDataBuffMod := false;
  end;
end;

procedure Tdm_BaseBuff.DataModuleDestroy(Sender: TObject);
begin
  F_BuffStack.Free;
end;

procedure Tdm_BaseBuff.LoadFromStack;
begin
  F_IsInternalDataBuffMod := true;
  try
    mt_BuffData.LoadFromDataSet( F_BuffStack.mt_BuffData, [] );
    F_IsDataChanged := F_BuffStack.IsDataChanged;
    F_IsDataLoad := F_BuffStack.IsDataLoad;
  finally
    F_IsInternalDataBuffMod := false;
  end;
end;

{ TBuffStack }

constructor TBuffStack.Create;
begin
  inherited;
  mt_BuffData := TkbmMemTable.Create( nil );
end;

destructor TBuffStack.Destroy;
begin
  mt_BuffData.Free;
  inherited;
end;

end.
