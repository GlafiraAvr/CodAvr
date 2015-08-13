unit VocMessageTypesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocMessageTypes = class(Tfrm_BaseVoc)
    lbl_MessageType: TLabel;
    ed_MessageType: TDBEdit;
    dset_MainVocID: TIntegerField;
    dset_MainVocMESSAGENAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
    lbl_MtCategory: TLabel;
    dbl_MtCategory: TRxDBLookupCombo;
    dset_MtCategory: TIBDataSet;
    ds_MtCategory: TDataSource;
    dset_MainVocS_MT_CATEGORY_ID: TIntegerField;
    dset_MainVoclistMTCategory: TStringField;
    procedure btn_InsertClick(Sender: TObject);
  protected
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableCtrls(value: boolean);override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocMessageTypes }

procedure Tfrm_VocMessageTypes.CloseDataset;
begin
  dset_MtCategory.Close;
  inherited CloseDataset;
end;

procedure Tfrm_VocMessageTypes.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_MessageType.Visible:=value;
  ed_MessageType.Visible:=value;
  lbl_MtCategory.Visible := value;
  dbl_MtCategory.Visible := value;

end;

procedure Tfrm_VocMessageTypes.OpenDataset;
begin
  inherited OpenDataset;
  dset_MtCategory.Open;
end;

procedure Tfrm_VocMessageTypes.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_MainVoc.FieldByName('S_MT_CATEGORY_ID').AsInteger := -1;
end;

end.
