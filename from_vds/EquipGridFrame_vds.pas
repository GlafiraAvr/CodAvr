unit EquipGridFrame_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid_vds, RxLookup, StdCtrls, DB, IBDatabase,
  IBCustomDataSet, ExtCtrls, Grids, DBGridEh;

type
  Tframe_EquipGrid_vds = class(Tframe_WorkAndMaterBaseGrid_vds)
    Label1: TLabel;
    dbl_Equip: TRxDBLookupCombo;
    dset_Equip: TIBDataSet;
    ds_Equip: TDataSource;
    dset_MainID: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_ORDERS: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_DEPARTURES: TIntegerField;
    dset_MainFK_DEPEQUIPMENT_EQUIPMENT: TIntegerField;
    dset_MainEQUIP_NAME: TIBStringField;
  private
    { Private declarations }
  public
    { Public declarations }

   protected
    procedure OpenVocDset; override;
    function IsDataFieldsCorrect: boolean; override;
  public
    procedure Append; override;
  end;

var
  frame_EquipGrid_vds: Tframe_EquipGrid_vds;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tframe_EquipGrid_vds.Append;
begin
  inherited Append;
  dset_Main.FieldByName('FK_DEPEQUIPMENT_ORDERS').AsInteger:=F_OrderID;
  dset_Main.FieldByName('FK_DEPEQUIPMENT_DEPARTURES').AsInteger:=F_DepID;
end;

function Tframe_EquipGrid_vds.IsDataFieldsCorrect: boolean;
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

procedure Tframe_EquipGrid_vds.OpenVocDset;
begin
  inherited;
  if not dset_Equip.Active then
    dset_Equip.Open;
end;

end.
