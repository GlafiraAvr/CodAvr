unit DepPlanChangManager;

interface

uses DepChargeForm, WorksVocCacheDModule, DB, VocCacheDModule,
  DepMatersDModule, MatersVocCacheDModule, EquipsVocCacheDModule, DepEquipPlanDModule,
  BaseDepChargeDModule, EquipsVADModule, DepEquipPlanForm;

type

  TDepPlanChangManager = class
  private
    F_Form: Tfrm_DepEqiupPlan;
    //
    F_EquipsDM: Tdm_DepPlanEqChange;
    F_EquipsVA: Tdm_EquipsVA;
  private
    F_DepID: integer;
    F_OrderID: integer;
    F_IsReadOnly: boolean;
    F_table:string;
    procedure SetOrderID(const Value: integer);
    procedure SetDepID(const Value: integer);
    procedure AttachCtrlsAndEvents;
    procedure AfterPostAndCancelHandler(DataSet: TDataSet);
    procedure AfterInsertAndEditHandler(DataSet: TDataSet);
    procedure Settable(value:string);
  public
    property OrderID: integer read F_OrderID write SetOrderID;
    property DepID: integer read F_DepID write SetDepID;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    procedure ShowCharge;
    constructor Create;
    destructor Destroy; override;
    procedure ChangeTyp(Field: TField);
    property table:string write Settable;
  end;



implementation
procedure TDepPlanChangManager.AfterInsertAndEditHandler(DataSet: TDataSet);
var r:integer;
begin

  F_EquipsVA.SetRowShow( false, true );



end;

procedure TDepPlanChangManager.AfterPostAndCancelHandler(DataSet: TDataSet);
begin
  F_EquipsVA.SetRowShow( true, false );
   F_EquipsVA.SetRowShow( false, true );
  F_EquipsVA.mt_Equips.Filtered:=false;
end;

procedure TDepPlanChangManager.AttachCtrlsAndEvents;
begin
  F_Form.frame_DepEqipP.ds_Main.DataSet := F_EquipsDM.dset_Main;
  F_Form.frame_DepEqipP.ds_equip_typ.DataSet:=F_EquipsDM.dset_eqip_type;
  F_Form.frame_DepEqipP.ds_Equip.DataSet := F_EquipsVA.mt_Equips;

  F_EquipsDM.OnMyFieldChange := F_Form.FieldValueChangeHandler;
  F_EquipsDM.OnMyAfterInsert := AfterInsertAndEditHandler;
  F_EquipsDM.OnMyAfterEdit := AfterInsertAndEditHandler;
  F_EquipsDM.OnMyAfterPost := AfterPostAndCancelHandler;
  F_EquipsDM.OnMyAfterCancel := AfterPostAndCancelHandler;
  F_EquipsDM.OnMyTypChange:= ChangeTyp;
end;

constructor TDepPlanChangManager.Create;
begin
  inherited Create;

  F_Form :=  Tfrm_DepEqiupPlan.Create(nil);

  F_EquipsDM := Tdm_DepPlanEqChange.Create( nil );
  F_EquipsVA := Tdm_EquipsVA.Create( nil );

  AttachCtrlsAndEvents;
end;

destructor TDepPlanChangManager.Destroy;
begin
  F_Form.Free;

  F_EquipsDM.Free;
  F_EquipsVA.Free;

  inherited Destroy;
end;


procedure TDepPlanChangManager.SetDepID(const Value: integer);
begin
  F_DepID := Value;
  F_EquipsDM.DepID := Value;
end;

procedure TDepPlanChangManager.SetOrderID(const Value: integer);
begin
  F_OrderID := Value;
  F_EquipsDM.OrderID := Value;
end;

procedure TDepPlanChangManager.ShowCharge;
begin
  F_EquipsVA.AttachToGlobalVocCache;
  F_EquipsDM.OpenDset;

  F_Form.frame_DepEqipP.IsReadOnly := F_IsReadOnly;
  F_Form.ShowModal;
end;

procedure TDepPlanChangManager.ChangeTyp(Field: TField) ;
begin
if F_EquipsDM.dset_Main.FieldValues['FK_EQUIP_TYP']>-1 then begin
 F_EquipsVA.mt_Equips.Filter:='id_typ='+F_EquipsDM.dset_Main.FieldByName('FK_EQUIP_TYP').AsString;
 F_EquipsVA.mt_Equips.Filtered:=false;

 F_EquipsVA.mt_Equips.Filtered:=true;
 // f_Form.frame_DepEqipP.rdbl_equip.KeyValue:=F_EquipsDM.dset_MainID.Value;
end
else
 f_Form.frame_DepEqipP.rdbl_equip.Enabled:=false;



end;


procedure TDepPlanChangManager.Settable(value:string);
begin
 F_table:=value;
 F_EquipsDM.Table:=value;
end;

end.
