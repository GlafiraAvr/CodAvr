unit BaseEditDModule;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_BaseEdit = class(TDataModule)
    dset_Main: TIBDataSet;
    tran_Main: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure dset_MainAfterPost(DataSet: TDataSet);
    procedure dset_MainBeforeClose(DataSet: TDataSet);
    procedure dset_MainAfterOpen(DataSet: TDataSet);
    procedure dset_MainBeforeOpen(DataSet: TDataSet);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure dset_MainAfterCancel(DataSet: TDataSet);
    procedure dset_MainAfterScroll(DataSet: TDataSet);
  protected
    F_LastRecordID: integer;
    F_OnMyAfterPost: TDataSetNotifyEvent;
    F_OnMyAfterEdit: TDataSetNotifyEvent;
    F_OnMyAfterInsert: TDataSetNotifyEvent;
    F_OnMyAfterCancel: TDataSetNotifyEvent;
    F_OnMyAfterScroll: TDataSetNotifyEvent;
    F_OnMyFieldChange:  TFieldNotifyEvent;
  public
    procedure OpenDset; virtual;
    property OnMyAfterPost: TDataSetNotifyEvent read F_OnMyAfterPost
      write F_OnMyAfterPost;
    property OnMyAfterEdit: TDataSetNotifyEvent read F_OnMyAfterEdit
      write F_OnMyAfterEdit;
    property OnMyAfterInsert: TDataSetNotifyEvent read F_OnMyAfterInsert
      write F_OnMyAfterInsert;
    property OnMyAfterCancel: TDataSetNotifyEvent read F_OnMyAfterCancel
      write F_OnMyAfterCancel;
    property OnMyAfterScroll: TDataSetNotifyEvent read F_OnMyAfterScroll
      write F_OnMyAfterScroll;
    property OnMyFieldChange: TFieldNotifyEvent read F_OnMyFieldChange
      write F_OnMyFieldChange;
  end;


implementation

{$R *.dfm}

{ Tdm_BaseEdit }

procedure Tdm_BaseEdit.OpenDset;
begin
  if tran_Main.InTransaction then
    tran_Main.Rollback;
  tran_Main.StartTransaction;
end;

procedure Tdm_BaseEdit.DataModuleDestroy(Sender: TObject);
begin
  if tran_Main.InTransaction then tran_Main.Rollback;
end;

procedure Tdm_BaseEdit.dset_MainAfterPost(DataSet: TDataSet);
begin
  tran_Main.CommitRetaining;
  dset_Main.Close;
  dset_Main.Open;

  if Assigned( F_OnMyAfterPost ) then
    F_OnMyAfterPost( DataSet );
end;

procedure Tdm_BaseEdit.dset_MainBeforeClose(DataSet: TDataSet);
begin
  if Assigned( dset_Main.FindField( 'ID' ) ) then
    F_LastRecordID := dset_Main.FieldByName( 'ID' ).AsInteger;
end;

procedure Tdm_BaseEdit.dset_MainAfterOpen(DataSet: TDataSet);
begin
  dset_Main.Last;

  if Assigned( dset_Main.FindField( 'ID' ) ) then
    if not dset_Main.Locate( 'ID', F_LastRecordID, [] ) then
      dset_Main.First;

  dset_Main.EnableControls;
end;

procedure Tdm_BaseEdit.dset_MainBeforeOpen(DataSet: TDataSet);
begin
  dset_Main.DisableControls;
end;

procedure Tdm_BaseEdit.dset_MainAfterEdit(DataSet: TDataSet);
begin
  if Assigned( F_OnMyAfterEdit ) then
    F_OnMyAfterEdit( DataSet );
end;

procedure Tdm_BaseEdit.dset_MainAfterInsert(DataSet: TDataSet);
begin
  if Assigned( F_OnMyAfterInsert ) then
    F_OnMyAfterInsert( DataSet );
end;

procedure Tdm_BaseEdit.dset_MainAfterCancel(DataSet: TDataSet);
begin
  if Assigned( F_OnMyAfterCancel ) then
    F_OnMyAfterCancel( DataSet );
end;

procedure Tdm_BaseEdit.dset_MainAfterScroll(DataSet: TDataSet);
begin
  if Assigned( F_OnMyAfterScroll ) then
    F_OnMyAfterScroll( DataSet );
end;

end.
