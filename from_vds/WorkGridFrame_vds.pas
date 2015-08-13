unit WorkGridFrame_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid_vds, DB, IBDatabase, IBCustomDataSet,
  ExtCtrls, Grids, DBGridEh, StdCtrls, Mask, DBCtrls, RxLookup;

type
  Tframe_WorkGrid_vds = class(Tframe_WorkAndMaterBaseGrid_vds)
    Label1: TLabel;
    dbl_Work: TRxDBLookupCombo;
    Label2: TLabel;
    dbl_Diam: TRxDBLookupCombo;
    Label3: TLabel;
    ed_Quantity: TDBEdit;
    dset_Work: TIBDataSet;
    ds_Diam: TDataSource;
    dset_Diam: TIBDataSet;
    ds_Work: TDataSource;
    dset_MainID: TIntegerField;
    dset_MainFK_DEPWORK_ORDERS: TIntegerField;
    dset_MainFK_DEPWORK_DEPARTURE: TIntegerField;
    dset_MainFK_DEPWORK_WORKS: TIntegerField;
    dset_MainFK_DEPWORK_DIAMETER: TIntegerField;
    dset_MainQUANTITY: TIBBCDField;
    dset_MainISPAYED: TSmallintField;
    dset_MainWORK_NAME: TIBStringField;
    dset_MainDIAM: TIntegerField;
    DBCheckBox1: TDBCheckBox;
    dset_MainboolSenet_1562: TBooleanField;
    dset_MainSENT_1562: TSmallintField;
    procedure dset_MainCalcFields(DataSet: TDataSet);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure dset_MainBeforePost(DataSet: TDataSet);
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
  frame_WorkGrid_vds: Tframe_WorkGrid_vds;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tframe_WorkGrid_vds.Append;
begin
  inherited Append;
  dset_Main.FieldByName('FK_DEPWORK_ORDERS').AsInteger:=F_OrderID;
  dset_Main.FieldByName('FK_DEPWORK_DEPARTURE').AsInteger:=F_DepID;
  dset_Main.FieldByName('sent_1562').AsInteger:=0;
  dset_Main.FieldByName('boolsenet_1562').AsBoolean:=false;
end;

function Tframe_WorkGrid_vds.IsDataFieldsCorrect: boolean;
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

procedure Tframe_WorkGrid_vds.OpenVocDset;
begin
  inherited;
  if not dset_Work.Active then
    dset_Work.Open;
  if not dset_Diam.Active then
    dset_Diam.Open;

end;


procedure Tframe_WorkGrid_vds.dset_MainCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('boolSenet_1562').AsBoolean:=false;

   if  not Dataset.FieldByName('sent_1562').IsNull then
    if Dataset.FieldByName('sent_1562').AsInteger=1 then
     DataSet.FieldByName('boolSenet_1562').AsBoolean:=true;
end;

procedure Tframe_WorkGrid_vds.dset_MainAfterEdit(DataSet: TDataSet);
begin
  inherited;
   if Dataset.FieldByName('boolsenet_1562').AsBoolean then
  Dataset.FieldByName('sent_1562').AsInteger:=1
  else
   Dataset.FieldByName('sent_1562').AsInteger:=0;

end;

procedure Tframe_WorkGrid_vds.dset_MainBeforePost(DataSet: TDataSet);
begin
  inherited;
  if Dataset.FieldByName('boolsenet_1562').AsBoolean then
   Dataset.FieldByName('sent_1562').AsInteger:=1
  else
   Dataset.FieldByName('sent_1562').AsInteger:=0;
end;

end.
