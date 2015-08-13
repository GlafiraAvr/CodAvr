unit VocEquipmentForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocEquipment = class(Tfrm_BaseVoc)
    ed_EquipName: TDBEdit;
    ed_EquipNumber: TDBEdit;
    lbl_EquipName: TLabel;
    lbl_EquipNumber: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocNUMBER: TIntegerField;
    dset_MainVocACTIVITY: TIBStringField;
    dset_MainVocID_REGION: TIntegerField;
    dset_MainVocID_VOCRECTYPE: TIntegerField;
    dset_Region: TIBDataSet;
    dset_VocRecType: TIBDataSet;
    dset_RegionID: TIntegerField;
    dset_RegionNAME: TIBStringField;
    dset_MainVocluf_REGION: TStringField;
    dbl_Region: TRxDBLookupCombo;
    dbl_VocRecType: TRxDBLookupCombo;
    ds_Region: TDataSource;
    ds_VocRecType: TDataSource;
    lbl_Region: TLabel;
    dset_VocRecTypeID: TIntegerField;
    dset_VocRecTypeNAME: TIBStringField;
    dset_MainVocluf_VOCRECTYPE: TStringField;
    lbl_VocRecType: TLabel;
    procedure btn_InsertClick(Sender: TObject);
  protected
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableCtrls(value: boolean);override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocEquipment }

procedure Tfrm_VocEquipment.CloseDataset;
begin
  dset_Region.Close;
  dset_VocRecType.Close;
  inherited CloseDataset;
end;

procedure Tfrm_VocEquipment.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  lbl_EquipName.Visible:=value;
  lbl_EquipNumber.Visible:=value;
  lbl_Region.Visible := value;
  lbl_VocRecType.Visible := value;
  ed_EquipName.Visible:=value;
  ed_EquipNumber.Visible:=value;
  dbl_Region.Visible := value;
  dbl_VocRecType.Visible := value;
end;

procedure Tfrm_VocEquipment.OpenDataset;
begin
  inherited OpenDataset;
  dset_Region.Open;
  dset_VocRecType.Open;
end;

procedure Tfrm_VocEquipment.btn_InsertClick(Sender: TObject);
begin
  inherited;
  dset_MainVoc.FieldByName( 'id_region' ).AsInteger := -1;
  dset_MainVoc.FieldByName( 'id_vocrectype' ).AsInteger := -1;
end;

end.
