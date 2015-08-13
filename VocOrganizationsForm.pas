unit VocOrganizationsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocOrganizations = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    ed_Phone: TDBEdit;
    lbl_Name: TLabel;
    lbl_Phone: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocPHONE: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocOrganizations }

procedure Tfrm_VocOrganizations.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_Name.Visible:=value;
  lbl_Phone.Visible:=value;
  ed_Name.Visible:=value;
  ed_Phone.Visible:=value;
end;

end.
