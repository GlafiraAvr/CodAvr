unit BaseGridFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, IBDatabase, IBCustomDataSet, Grids, DBGrids, DModule,
  DBGridEh, ExtCtrls;

type
  TOnChangeProcessStatus=procedure(Text: string) of object;
  TOnActivateFieldsPanel=procedure(value: boolean) of object;

  Tframe_BaseGrid = class(TFrame)
    dset_Main: TIBDataSet;
    tr_Main: TIBTransaction;
    ds_Main: TDataSource;
    tr_Voc: TIBTransaction;
    DBGrid: TDBGridEh;
    pnl_Fields: TPanel;
    procedure dset_MainAfterOpen(DataSet: TDataSet);
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure dset_MainAfterPost(DataSet: TDataSet);
    procedure dset_MainAfterDelete(DataSet: TDataSet);
    procedure dset_MainAfterCancel(DataSet: TDataSet);
    procedure EntryEnter(Sender: TObject);
    procedure EntryExit(Sender: TObject);
  protected
    F_OnChangeProcessStatus: TOnChangeProcessStatus;
    F_OnActivateFieldsPanel: TOnActivateFieldsPanel;
    function SaveData: boolean;
    procedure SetProcessStatus(Text: string);
    procedure FieldsPnlActivity(value: boolean);
  protected
    function IsDateCorrect: boolean; virtual;
    function IsDataFieldsCorrect: boolean; virtual;
    procedure ActivateFieldsPanel(value: boolean); virtual;
    procedure OpenMainDset; virtual; abstract;
    procedure OpenVocDset; virtual; abstract;
  public
    property OnChangeProcessStatus: TOnChangeProcessStatus
      read F_OnChangeProcessStatus write F_OnChangeProcessStatus;
    property OnActivateFieldsPanel: TOnActivateFieldsPanel
      read F_OnActivateFieldsPanel write F_OnActivateFieldsPanel;  
    procedure Start;
    procedure Stop;
    procedure Append; virtual;
    procedure Edit; virtual;
    procedure Delete;
    function Post: boolean; virtual;
    procedure Cancel;
    function GetRecordCount: integer;
  end;

implementation

{$R *.dfm}

uses RxLookup, DBCtrls, RXDBCtrl, DBCtrlsEh, StringConsts;

{ Tframe_BaseGrid }

procedure Tframe_BaseGrid.Append;
begin
  dset_Main.Append;
end;

procedure Tframe_BaseGrid.Cancel;
begin
  dset_Main.Cancel;
  SetProcessStatus('');
end;

procedure Tframe_BaseGrid.Delete;
var
  BMark: string;
begin
  if dset_Main.Bof and dset_Main.Eof then exit;
  if Application.MessageBox('Удалить запись?', gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=IDYES then
  begin
    dset_Main.Delete;
    Tr_Main.CommitRetaining;
    BMark:=dset_Main.Bookmark;
    dset_Main.Close;
    dset_Main.Open;
    dset_Main.Bookmark:=BMark;
  end;
end;

procedure Tframe_BaseGrid.Edit;
begin
  if dset_Main.Eof and dset_Main.Bof then exit;
  dset_Main.Edit;
end;

procedure Tframe_BaseGrid.FieldsPnlActivity(value: boolean);
begin
  ActivateFieldsPanel(value);
  if Assigned(F_OnActivateFieldsPanel) then
    F_OnActivateFieldsPanel(value);
end;

procedure Tframe_BaseGrid.Start;
begin
  if tr_voc.InTransaction then
    tr_voc.Rollback;
  tr_voc.StartTransaction;

  if tr_main.InTransaction then
    tr_main.Rollback;
  tr_main.StartTransaction;

  OpenVocDset;
  OpenMainDset;
end;

function Tframe_BaseGrid.IsDataFieldsCorrect: boolean;
begin
  Result:=true;
end;

function Tframe_BaseGrid.IsDateCorrect: boolean;
begin
  Result:=true;
end;

function Tframe_BaseGrid.Post: boolean;
begin
  Result:=false;
  if dset_Main.State in [dsInsert, dsEdit] then
  begin
    if SaveData then
    begin
      Result:=true;
      SetProcessStatus('');
    end;
  end;
end;

function Tframe_BaseGrid.SaveData: boolean;
var
  BMark: string;
begin
  Result:=false;

  if IsDateCorrect and IsDataFieldsCorrect then
  begin
    try
      dset_Main.Post;
      Tr_Main.CommitRetaining;
      BMark:=dset_Main.Bookmark;
      dset_Main.Close;
      dset_Main.Open;
      dset_Main.Bookmark:=BMark;
      Result:=true;
    except
      on E:Exception do
      begin
        Tr_Main.RollbackRetaining;
        dset_Main.Close;
        dset_Main.Open;
        Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
      end;
    end;
  end;
end;

procedure Tframe_BaseGrid.SetProcessStatus(Text: string);
begin
  if Assigned(F_OnChangeProcessStatus) then
    F_OnChangeProcessStatus(Text);
end;

procedure Tframe_BaseGrid.Stop;
begin
  if tr_voc.InTransaction then
    tr_voc.Commit;
  if tr_main.InTransaction then
    tr_main.Commit;  
end;

procedure Tframe_BaseGrid.dset_MainAfterOpen(DataSet: TDataSet);
begin
  FieldsPnlActivity(false);
  DBGrid.Enabled:=true;
end;

procedure Tframe_BaseGrid.dset_MainAfterInsert(DataSet: TDataSet);
begin
  FieldsPnlActivity(true);
  DBGrid.Enabled:=false;
end;

procedure Tframe_BaseGrid.dset_MainAfterEdit(DataSet: TDataSet);
begin
  FieldsPnlActivity(true);
  DBGrid.Enabled:=false;
end;

procedure Tframe_BaseGrid.dset_MainAfterPost(DataSet: TDataSet);
begin
  FieldsPnlActivity(false);
  DBGrid.Enabled:=true;
end;

procedure Tframe_BaseGrid.dset_MainAfterDelete(DataSet: TDataSet);
begin
  FieldsPnlActivity(false);
  DBGrid.Enabled:=true;
end;

procedure Tframe_BaseGrid.dset_MainAfterCancel(DataSet: TDataSet);
begin
  FieldsPnlActivity(false);
  DBGrid.Enabled:=true;
end;

procedure Tframe_BaseGrid.EntryEnter(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
    (Sender as TRXDBLookupCombo).color := clLime else
  if Sender is TDBEdit then
    (Sender as TDBEdit).Color :=  clLime else
  if Sender is TDBDateEdit then
    (Sender as TDBDateEdit).Color := clLime else
  if Sender is TDBDateTimeEditEh then
    (Sender as TDBDateTimeEditEh).Color := clLime else
  if (Sender is TDBNumberEditEh) then
    (Sender as TDBNumberEditEh).Color := clLime;
end;

procedure Tframe_BaseGrid.EntryExit(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
    (Sender as TRXDBLookupCombo).color := clWindow else
  if Sender is TDBEdit then
    (Sender as TDBEdit).Color :=  clWindow else
  if Sender is TDBDateEdit then
    (Sender as TDBDateEdit).Color := clWindow else
  if Sender is TDBDateTimeEditEh then
    (Sender as TDBDateTimeEditEh).Color := clWindow else
  if (Sender is TDBNumberEditEh) then
    (Sender as TDBNumberEditEh).Color := clWindow;
end;

procedure Tframe_BaseGrid.ActivateFieldsPanel(value: boolean);
begin
  pnl_Fields.Visible:=value;
end;

function Tframe_BaseGrid.GetRecordCount: integer;
var
  BMark: string;
begin
  Result:=0;
  if dset_Main.Active then
  begin
    dset_Main.DisableControls;
    try
      BMark:=dset_Main.Bookmark;
      dset_Main.Last;
      Result:=dset_Main.RecordCount;
      dset_Main.Bookmark:=BMark;
    finally
      dset_Main.EnableControls;
    end;
  end;
end;

end.
