unit EquipGridFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid_vds, DB, IBDatabase, IBCustomDataSet, ExtCtrls,
  Grids, DBGridEh, StdCtrls, RxLookup;

type
  Tframe_EquipGrid = class(Tframe_WorkAndMaterBaseGrid)
    dset_MainID: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_ORDERS: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_DEPARTURES: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_EQUIPMENT: TIntegerField;
    dset_MainEQUIP_NAME: TIBStringField;
    dbl_Equip: TRxDBLookupCombo;
    Label1: TLabel;
    ds_Equip: TDataSource;
    dset_Equip: TIBDataSet;
  protected
    procedure OpenVocDset; override;
    function IsDataFieldsCorrect: boolean; override;
  public
    procedure Append; override;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_EquipGrid }

procedure Tframe_EquipGrid.Append;
begin
  inherited Append;
  dset_Main.FieldByName('FK_DEPEQUIPMENT_ORDERS').AsInteger:=F_OrderID;
  dset_Main.FieldByName('FK_DEPEQUIPMENT_DEPARTURES').AsInteger:=F_DepID;
end;

function Tframe_EquipGrid.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Equip) then
  begin
    dbl_Equip.SetFocus;
    SetProcessStatus('Введите оборудование');
    exit;
  end;

  Result:=true;
end;

procedure Tframe_EquipGrid.OpenVocDset;
begin
  inherited;
  if not dset_Equip.Active then
    dset_Equip.Open;
end;

end.
