unit VocDamageLocalityForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocDamageLocality = class(Tfrm_BaseVoc)
    ed_DamageLocality: TDBEdit;
    lbl_DamageLocality: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocDamageLocality }

procedure Tfrm_VocDamageLocality.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_DamageLocality.Visible:=value;
  ed_DamageLocality.Visible:=value;
end;

end.
