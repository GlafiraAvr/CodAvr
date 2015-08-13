unit VocWorksForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocWorks = class(Tfrm_BaseVoc)
    ed_work: TDBEdit;
    lbl_work: TLabel;
    ds_Measurement: TDataSource;
    dset_Measurement: TIBDataSet;
    dset_MeasurementID: TIntegerField;
    dset_MeasurementNAME: TIBStringField;
    RxDBLookupCombo1: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    RxDBLookupCombo2: TRxDBLookupCombo;
    dset_WorkKind: TIBDataSet;
    ds_WorkKind: TDataSource;
    dset_WorkKindID: TIntegerField;
    dset_WorkKindNAME: TIBStringField;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocID_MEASUREMENT: TIntegerField;
    dset_MainVocID_WORKKIND: TIntegerField;
    dset_MainVocACTIVITY: TIBStringField;
    dset_MainVocMEASUREMENT: TIBStringField;
    dset_MainVocWORKKIND: TIBStringField;
    procedure dset_MainVocAfterInsert(DataSet: TDataSet);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
  public
  end;


implementation

{$R *.dfm}

uses AppGUIDS, RightsManagerDModule;

{ Tfrm_VocWorks }

procedure Tfrm_VocWorks.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  pnl_EditFields.Visible := value;
end;

class function Tfrm_VocWorks.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

procedure Tfrm_VocWorks.dset_MainVocAfterInsert(DataSet: TDataSet);
begin
  inherited;
  dset_MainVoc.FieldByName( 'id_measurement' ).AsInteger := -1;
  dset_MainVoc.FieldByName( 'id_workkind' ).AsInteger := -1;
end;

procedure Tfrm_VocWorks.OpenDataset;
begin
  inherited;
  dset_Measurement.Open;
  dset_workkind.Open;
end;

procedure Tfrm_VocWorks.CloseDataset;
begin
  inherited;
  dset_Measurement.Close;
  dset_workkind.Close;
end;

end.
