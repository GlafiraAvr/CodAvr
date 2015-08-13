unit VocMeasurementForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocMeasurement = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    Label1: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TSmallintField;
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

uses AppGUIDS, RightsManagerDModule;

{ Tfrm_VocMeasurement }

procedure Tfrm_VocMeasurement.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  pnl_EditFields.Visible := value;
end;

class function Tfrm_VocMeasurement.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
