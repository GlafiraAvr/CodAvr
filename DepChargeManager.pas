unit DepChargeManager;

interface

uses DepChargeForm, WorksVocCacheDModule, DB, VocCacheDModule,
  DepMatersDModule, MatersVocCacheDModule, EquipsVocCacheDModule, DepEquipsDModule,
  BaseDepChargeDModule, EquipsVADModule;

type
  TDepChargeManager = class
  private
    F_Form: Tfrm_DepCharge;
    //
    F_EquipsDM: Tdm_DepEquips;
    F_EquipsVA: Tdm_EquipsVA;
  private
    F_DepID: integer;
    F_OrderID: integer;
    F_IsReadOnly: boolean;
    procedure SetOrderID(const Value: integer);
    procedure SetDepID(const Value: integer);
    procedure AttachCtrlsAndEvents;
    procedure AfterPostAndCancelHandler(DataSet: TDataSet);
    procedure AfterInsertAndEditHandler(DataSet: TDataSet);
  public
    property OrderID: integer read F_OrderID write SetOrderID;
    property DepID: integer read F_DepID write SetDepID;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    procedure ShowCharge;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TDepChargeManager }

procedure TDepChargeManager.AfterInsertAndEditHandler(DataSet: TDataSet);
begin
  F_EquipsVA.SetRowShow( false, true );
end;

procedure TDepChargeManager.AfterPostAndCancelHandler(DataSet: TDataSet);
begin
  F_EquipsVA.SetRowShow( true, false );
end;

procedure TDepChargeManager.AttachCtrlsAndEvents;
begin
  F_Form.frame_Equips.ds_Main.DataSet := F_EquipsDM.dset_Main;
  F_Form.frame_Equips.ds_Equips.DataSet := F_EquipsVA.mt_Equips;

  F_EquipsDM.OnMyFieldChange := F_Form.FieldValueChangeHandler;
  F_EquipsDM.OnMyAfterInsert := AfterInsertAndEditHandler;
  F_EquipsDM.OnMyAfterEdit := AfterInsertAndEditHandler;
  F_EquipsDM.OnMyAfterPost := AfterPostAndCancelHandler;
  F_EquipsDM.OnMyAfterCancel := AfterPostAndCancelHandler;
end;

constructor TDepChargeManager.Create;
begin
  inherited Create;

  F_Form := Tfrm_DepCharge.Create(nil);

  F_EquipsDM := Tdm_DepEquips.Create( nil );
  F_EquipsVA := Tdm_EquipsVA.Create( nil );

  AttachCtrlsAndEvents;
end;

destructor TDepChargeManager.Destroy;
begin
  F_Form.Free;

  F_EquipsDM.Free;
  F_EquipsVA.Free;

  inherited Destroy;
end;


procedure TDepChargeManager.SetDepID(const Value: integer);
begin
  F_DepID := Value;
  F_EquipsDM.DepID := Value;
end;

procedure TDepChargeManager.SetOrderID(const Value: integer);
begin
  F_OrderID := Value;
  F_EquipsDM.OrderID := Value;
end;

procedure TDepChargeManager.ShowCharge;
begin
  F_EquipsVA.AttachToGlobalVocCache;
  F_EquipsDM.OpenDset;

  F_Form.IsReadOnly := F_IsReadOnly;
  F_Form.ShowModal;
end;


end.
