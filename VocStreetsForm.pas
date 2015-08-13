unit VocStreetsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, RxLookup, Mask, DBCtrls;

type
  Tfrm_VocStreets = class(Tfrm_BaseVoc)
    ed_Streets: TDBEdit;
    dbl_StreetTypes: TRxDBLookupCombo;
    dbl_Streets: TRxDBLookupCombo;
    lbl_Streets: TLabel;
    lbl_StreetTypes: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocFK_STREETS_STREETTYPES: TIntegerField;
    dset_MainVocACTIVITY: TSmallintField;
    dset_StreetTypes: TIBDataSet;
    ds_Streettypes: TDataSource;
    dset_MainVocluf_StreetTypes: TStringField;
    procedure btn_InsertClick(Sender: TObject);
  protected
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableCtrls(value: boolean);override;
  public
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tfrm_VocStreets }

procedure Tfrm_VocStreets.CloseDataset;
begin
  dset_StreetTypes.Close;
  inherited CloseDataset;
end;

procedure Tfrm_VocStreets.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_Streets.Visible:=value;
  lbl_StreetTypes.Visible:=value;
  ed_Streets.Visible:=value;
  dbl_StreetTypes.Visible:=value;
  dbl_Streets.Enabled:=not value;
end;

procedure Tfrm_VocStreets.OpenDataset;
begin
  inherited OpenDataset;
  dset_StreetTypes.Open;
end;

procedure Tfrm_VocStreets.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);

  dset_MainVoc.FieldByName('fk_streets_streettypes').AsInteger:=-1;
end;

end.
