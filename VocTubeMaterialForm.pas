unit VocTubeMaterialForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocTubeMaterial = class(Tfrm_BaseVoc)
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
    ed_TubeMaterial: TDBEdit;
    lbl_TubeMaterial: TLabel;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocTubeMaterial }

procedure Tfrm_VocTubeMaterial.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_TubeMaterial.Visible:=value;
  ed_TubeMaterial.Visible:=value;
end;

end.
