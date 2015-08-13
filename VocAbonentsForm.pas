unit VocAbonentsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocAbonents = class(Tfrm_BaseVoc)
    lbl_Abonent: TLabel;
    ed_Abonent: TDBEdit;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME_R: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EnableCtrls(value: boolean); override;
  end;

var
  frm_VocAbonents: Tfrm_VocAbonents;

implementation

{$R *.dfm}

procedure Tfrm_VocAbonents.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  lbl_Abonent.Visible := value;
  ed_Abonent.Visible := value;
end;

end.
