unit VocAsfCompanyForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocAsfcompany = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    lbl_Name: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  protected
    procedure EnableCtrls(value: boolean);override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocAsfcompany }

procedure Tfrm_VocAsfcompany.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_Name.Visible:=value;
  ed_Name.Visible:=value;
end;

end.
