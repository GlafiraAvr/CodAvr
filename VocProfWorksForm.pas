unit VocProfWorksForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocProfWorks = class(Tfrm_BaseVoc)
    ed_ProfWork: TDBEdit;
    lbl_ProfWork: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocProfWorks }

procedure Tfrm_VocProfWorks.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_ProfWork.Visible:=value;
  ed_ProfWork.Visible:=value;
end;

end.
