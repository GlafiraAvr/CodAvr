unit VocWorkersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup, ToolEdit;

type
  Tfrm_VocWorkers = class(Tfrm_BaseVoc)
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    ed_Name: TDBEdit;
    lbl_Name: TLabel;
    lbl_Post: TLabel;
    dset_MainVocACTIVITY: TIBStringField;
    dset_WorkerPost: TIBDataSet;
    ds_WorkerPost: TDataSource;
    dset_WorkerPostID: TIntegerField;
    dset_WorkerPostNAME_: TIBStringField;
    dbl_Post: TRxDBLookupCombo;
    dset_MainVocID_WORKERPOST: TIntegerField;
    dset_MainVoclp_WorkerPost: TStringField;
    procedure btn_InsertClick(Sender: TObject);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
  public
  end;


implementation

uses RightsManagerDModule, AppGUIDS;

{$R *.dfm}


{ Tfrm_VocWorkers }

procedure Tfrm_VocWorkers.CloseDataset;
begin
  dset_WorkerPost.Close;
  inherited CloseDataset;
end;

procedure Tfrm_VocWorkers.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  ed_Name.Visible:=value;
  dbl_Post.Visible:=value;
  lbl_Name.Visible:=value;
  lbl_Post.Visible:=value;
end;

procedure Tfrm_VocWorkers.OpenDataset;
begin
  inherited OpenDataset;
  dset_WorkerPost.Open;
end;

procedure Tfrm_VocWorkers.btn_InsertClick(Sender: TObject);
begin
  inherited;
  dset_MainVoc.FieldByName( 'id_WorkerPost' ).AsInteger := -1;
end;

class function Tfrm_VocWorkers.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
