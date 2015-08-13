unit VocTubeDiameterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocTubeDiameter = class(Tfrm_BaseVoc)
    ed_TubeDiameter: TDBEdit;
    lbl_TubeDiameter: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocDIAMETER: TIntegerField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocTubeDiameter }

procedure Tfrm_VocTubeDiameter.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_TubeDiameter.Visible:=value;
  ed_TubeDiameter.Visible:=value;
end;

end.
