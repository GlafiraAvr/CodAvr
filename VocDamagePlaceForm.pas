unit VocDamagePlaceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocDamagePlace = class(Tfrm_BaseVoc)
    ed_DamagePlace: TDBEdit;
    lbl_DamagePlace: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean);override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocDamagePlace }

procedure Tfrm_VocDamagePlace.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_DamagePlace.Visible:=value;
  ed_DamagePlace.Visible:=value;
end;

end.
