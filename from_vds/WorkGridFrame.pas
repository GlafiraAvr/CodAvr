unit WorkGridFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid, DB, IBDatabase, IBCustomDataSet, ExtCtrls,
  Grids, DBGridEh, StdCtrls, Mask, DBCtrls, RxLookup;

type
  Tframe_WorkGrid = class(Tframe_WorkAndMaterBaseGrid)
    dset_MainID: TIntegerField;
    dset_MainFK_DEPWORK_ORDERS: TIntegerField;
    dset_MainFK_DEPWORK_DEPARTURE: TIntegerField;
    dset_MainFK_DEPWORK_DIAMETER: TIntegerField;
    dset_MainQUANTITY: TIBBCDField;
    dset_MainISPAYED: TSmallintField;
    dset_Work: TIBDataSet;
    ds_Work: TDataSource;
    ds_Diam: TDataSource;
    dset_MainFK_DEPWORK_WORKS: TIntegerField;
    dset_Diam: TIBDataSet;
    dbl_Work: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    ed_Quantity: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dset_MainWORK_NAME: TIBStringField;
    dset_MainDIAM: TIntegerField;
  protected
    procedure OpenVocDset; override;
    function IsDataFieldsCorrect: boolean; override;
  public
    procedure Append; override;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_WorkGrid }

procedure Tframe_WorkGrid.Append;
begin
  inherited Append;
  dset_Main.FieldByName('FK_DEPWORK_ORDERS').AsInteger:=F_OrderID;
  dset_Main.FieldByName('FK_DEPWORK_DEPARTURE').AsInteger:=F_DepID;
end;

function Tframe_WorkGrid.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Work) then
  begin
    dbl_Work.SetFocus;
    SetProcessStatus('¬ведите наименование работы');
    exit;
  end;

  Result:=true;
end;

procedure Tframe_WorkGrid.OpenVocDset;
begin
  inherited;
  if not dset_Work.Active then
    dset_Work.Open;
  if not dset_Diam.Active then
    dset_Diam.Open;  
end;

end.
