unit VocSOMsgForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocSOMsg = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME_: TIBStringField;
    dset_MainVocACTIVITY: TSmallintField;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocSOMsg }

procedure Tfrm_VocSOMsg.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  ed_Name.Visible := value;
end;

end.
