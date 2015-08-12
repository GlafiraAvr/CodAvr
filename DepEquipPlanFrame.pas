unit DepEquipPlanFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DepChargeBaseFrame, RxLookup, DB, ExtCtrls, Grids, DBGridEh,
  StdCtrls, EquipsVocCacheDModule, DepEquipPlanDmodule,GlobalData;

type
  State_Insert=(StartEdit,TypeIsChosed,EndEdit);

  Tframe_DepEqipPlanChange = class(Tframe_DepChargeBase)
    rdbl_equip_typ: TRxDBLookupCombo;
    rdbl_equip: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    ds_equip: TDataSource;
    ds_equip_typ: TDataSource;
    procedure rdbl_equip_typEnter(Sender: TObject);
    procedure rdbl_equip_typExit(Sender: TObject);
    procedure rdbl_equip_typChange(Sender: TObject);
  private
    { Private declarations }
    
    F_State:integer;
    procedure SetStartEdit(st:integer);
    procedure EnableFields( _value: boolean ); override;
  public
    { Public declarations }
     function IsFieldsCorrect: boolean;


  end;

var
  frame_DepEqipPlanChange: Tframe_DepEqipPlanChange;

implementation


{$R *.dfm}

procedure Tframe_DepEqipPlanChange.EnableFields( _value: boolean );
begin
  pnl_Fields.Visible:=_value ;
  rdbl_equip_typ.Enabled:=_value;
if rdbl_equip_typ.Text='' then
  rdbl_equip.Enabled:=false
else
begin
rdbl_equip.Enabled:=true;
 rdbl_equip.LookupSource.DataSet.Filter:='id_typ='+rdbl_equip_typ.KeyValue;
  rdbl_equip.LookupSource.DataSet.Filtered:=false;
  rdbl_equip.LookupSource.DataSet.Filtered:=true;
end;
end;

procedure Tframe_DepEqipPlanChange.SetStartEdit(st:integer);
begin


end;


procedure Tframe_DepEqipPlanChange.rdbl_equip_typEnter(Sender: TObject);
begin
  inherited;
 (Sender as TRxDBLookupCombo).Color:=New_Col;
end;



procedure Tframe_DepEqipPlanChange.rdbl_equip_typExit(Sender: TObject);
begin
  inherited;
  (Sender as TRxDBLookupCombo).Color:=Old_Col;
end;

procedure Tframe_DepEqipPlanChange.rdbl_equip_typChange(Sender: TObject);
var v:integer;

begin
  inherited;
  v:=rdbl_equip_typ.KeyValue;
  if v>-1 then
  begin
  rdbl_equip.LookupSource.DataSet.Filter:='id_typ='+rdbl_equip_typ.KeyValue;
  rdbl_equip.LookupSource.DataSet.Filtered:=false;
  rdbl_equip.LookupSource.DataSet.Filtered:=true;
  rdbl_equip.KeyValue:=-1;
  rdbl_equip.Enabled:=true;
  end
  else
  rdbl_equip.Enabled:=false;

end;

function Tframe_DepEqipPlanChange.IsFieldsCorrect: boolean;
begin
  Result := false;

  if trim( rdbl_equip_typ.Text ) = '' then
  begin
    ShowMsg( '¬ведите ' );
    rdbl_equip.SetFocus;
    exit;
  end;

  Result := true;
end;

end.
