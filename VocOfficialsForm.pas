unit VocOfficialsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocOfficials = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    lbl_Name: TLabel;
    lbl_Post: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
    dbl_Post: TRxDBLookupCombo;
    dset_MainVocFK_OFFIC_OFFICPOST: TIntegerField;
    dset_Post: TIBDataSet;
    ds_Post: TDataSource;
    dset_MainVoclufPOST: TStringField;
  protected
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

{$R *.dfm}

{ Tfrm_VocOfficials }

procedure Tfrm_VocOfficials.CloseDataset;
begin
  inherited;
  dset_Post.Close;
end;

procedure Tfrm_VocOfficials.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  ed_Name.Visible:=value;
  dbl_Post.Visible:=value;
  lbl_Name.Visible:=value;
  lbl_Post.Visible:=value;
end;


procedure Tfrm_VocOfficials.OpenDataset;
begin
  inherited;
  dset_Post.Open;
end;

end.
