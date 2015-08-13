unit VocMaterialsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocMaterials = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    ed_measurement: TDBEdit;
    lbl_name: TLabel;
    lbl_measurement: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocMEASUREMENT: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

uses AppGUIDS, RightsManagerDModule;

{ Tfrm_VocMaterials }

procedure Tfrm_VocMaterials.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_name.Visible:=value;
  lbl_measurement.Visible:=value;
  ed_Name.Visible:=value;
  ed_measurement.Visible:=value;
end;

class function Tfrm_VocMaterials.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
