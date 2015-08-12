unit BaseVocForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBDatabase, DModule, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, SecurityBaseForm;

type
  Tfrm_BaseVoc = class(Tfrm_SecurityBase)
    Tr_MainVoc: TIBTransaction;
    dset_MainVoc: TIBDataSet;
    ds_MainVoc: TDataSource;
    pnl_Buttons: TPanel;
    btn_Insert: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    pnl_EditFields: TPanel;
    pnl_Grid: TPanel;
    dbg_MainVoc: TDBGrid;
    procedure GetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure CtrlsChange(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);virtual;

    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dset_MainVocAfterScroll(DataSet: TDataSet);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_DeleteClick(Sender: TObject);
    procedure dbg_MainVocDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  protected
    class function GetGUID: string; override;
  protected
    F_CtrlsChange: boolean;
    F_ReadOnly: boolean;

    procedure ShowDelBtnCaption;
    procedure EnableChngBtns(value: boolean); virtual;
    function SaveData: boolean;
    function Post: boolean;

    procedure OpenDataset; virtual;
    procedure CloseDataset; virtual;
    function IsDataFieldsCorrect: boolean; virtual;

    procedure EnableCtrls(value: boolean); virtual;
  public
    constructor Create(AOwner: TComponent; A_ReadOnly: boolean=false);
  end;


implementation

{$R *.dfm}

uses WarningForm, AppGUIDS;

procedure Tfrm_BaseVoc.btn_ExitClick(Sender: TObject);
begin
  Close;
end;


procedure Tfrm_BaseVoc.OpenDataset;
begin
  dset_MainVoc.Open;
end;

procedure Tfrm_BaseVoc.FormShow(Sender: TObject);
begin
  if Tr_MainVoc.InTransaction then
    Tr_MainVoc.Rollback;
  Tr_MainVoc.StartTransaction;

  OpenDataset;

  EnableCtrls(false);

  if F_ReadOnly then
  begin
    EnableChngBtns(false);
  end else
  begin
    EnableChngBtns(true);
  end;
end;

procedure Tfrm_BaseVoc.EnableCtrls(value: boolean);
begin
  btn_Post.Enabled:=value;
  btn_Cancel.Enabled:=value;
end;

procedure Tfrm_BaseVoc.CtrlsChange(Sender: TObject);
begin
  F_CtrlsChange:=true;
end;

procedure Tfrm_BaseVoc.dset_MainVocAfterScroll(DataSet: TDataSet);
begin
  ShowDelBtnCaption;
  F_CtrlsChange:=false;
end;

procedure Tfrm_BaseVoc.EnableChngBtns(value: boolean);
begin
  btn_Insert.Enabled:=value;
  btn_Edit.Enabled:=value;
  btn_Delete.Enabled:=value;
end;

constructor Tfrm_BaseVoc.Create(AOwner: TComponent; A_ReadOnly: boolean);
begin
  inherited Create(AOwner);
  F_CtrlsChange:=false;
  if IsCurrentUserCanEdit then
  begin
    F_ReadOnly:=A_ReadOnly;
  end else
  begin
    F_ReadOnly:=true;
    Caption:=Caption+' - (нет прав для редактирования)'
  end;
end;

function Tfrm_BaseVoc.SaveData: boolean;
var
  _id: integer;
begin
  if not IsDataFieldsCorrect then
  begin
    Result:=false;
    exit;
  end;

  try
    dset_MainVoc.Post;
  except
    Result:=false;
    Tr_MainVoc.RollbackRetaining;
    dset_MainVoc.Close;
    dset_MainVoc.Open;
    Raise;
  end;

  Result:=true;
  Tr_MainVoc.CommitRetaining;


  if Assigned( dset_MainVoc.FindField( 'ID' ) ) then
    _id := dset_MainVoc.FieldByName( 'ID' ).AsInteger
  else
    _id := -1;

  dset_MainVoc.Close;
  dset_MainVoc.Open;

  if _id <> -1 then
    if not dset_MainVoc.Locate( 'ID', _id, [] ) then
      dset_MainVoc.First;
end;

function Tfrm_BaseVoc.IsDataFieldsCorrect: boolean;
begin
  Result:=true;
end;

procedure Tfrm_BaseVoc.btn_InsertClick(Sender: TObject);
begin
  dset_MainVoc.Insert;
  EnableCtrls(true);
  EnableChngBtns(false);
  dbg_MainVoc.Enabled:=false;
end;

procedure Tfrm_BaseVoc.btn_EditClick(Sender: TObject);
begin
  if dset_MainVoc.Eof and dset_MainVoc.Bof then exit;

  dset_MainVoc.Edit;
  EnableCtrls(true);
  EnableChngBtns(false);
  dbg_MainVoc.Enabled:=false;
end;

procedure Tfrm_BaseVoc.btn_PostClick(Sender: TObject);
begin
  Post;
end;

procedure Tfrm_BaseVoc.btn_CancelClick(Sender: TObject);
begin
  dset_MainVoc.Cancel;
  EnableCtrls(false);
  EnableChngBtns(true);
  dbg_MainVoc.Enabled:=true;
end;

procedure Tfrm_BaseVoc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not(dset_MainVoc.Eof and dset_MainVoc.Bof) and not F_ReadOnly then
  begin
    if F_CtrlsChange then
    begin
      case ShowWarningDlg of
        raSave:
          if not SaveData then
          begin
            Action:=caNone;
            exit;
          end;
        raNoSave:;
      else
        begin
          Action:=caNone;
          exit;
        end;
      end; //end case
    end;
  end;

  CloseDataset;


  if Tr_MainVoc.InTransaction then
    Tr_MainVoc.Rollback;
end;

procedure Tfrm_BaseVoc.CloseDataset;
begin
  dset_MainVoc.Close;
end;

procedure Tfrm_BaseVoc.btn_DeleteClick(Sender: TObject);
begin
  if dset_MainVoc.Eof and dset_MainVoc.Bof then exit;

  dset_MainVoc.Edit;
  if dset_MainVoc.FieldByName('activity').IsNull  then
    dset_MainVoc.FieldByName('activity').Value:='0'
  else
    dset_MainVoc.FieldByName('activity').Value:=null;
  dset_MainVoc.Post;
  Tr_MainVoc.CommitRetaining;

  ShowDelBtnCaption;
end;

procedure Tfrm_BaseVoc.dbg_MainVocDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 with (Sender as TDBGrid) do
 begin
    if dset_MainVoc.FieldByName('activity').IsNull then
      Canvas.Brush.Color:=clWindow
    else
      Canvas.Brush.Color:=clYellow;
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
 end;
end;

procedure Tfrm_BaseVoc.ShowDelBtnCaption;
begin
  if dset_MainVoc.FieldByName('activity').IsNull then
    btn_Delete.Caption:='Удалить'
  else
    btn_Delete.Caption:='Восстановить';
end;

procedure Tfrm_BaseVoc.GetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  Text:=trim(Sender.AsString);
end;

class function Tfrm_BaseVoc.GetGUID: string;
begin
  Result:=ALLVOCFORMGUID;
end;

function Tfrm_BaseVoc.Post: boolean;
begin
  Result := SaveData;
  if Result then
  begin
    EnableCtrls(false);
    EnableChngBtns(true);
    F_CtrlsChange:=false;
  end;
  dbg_MainVoc.Enabled:=true;
end;

end.
