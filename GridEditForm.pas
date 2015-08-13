unit GridEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, ExtCtrls, RxLookup;

type
  Tfrm_GridEdit = class(TForm)
    ds_Main: TDataSource;
    pnl_Btns: TPanel;
    btn_Insert: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    procedure ds_MainStateChange(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    F_ConstMessage: string;
    F_IsReadOnly: boolean;
    procedure SetIsReadOnly(const Value: boolean);
    function Post: boolean;
    procedure Cancel;
  protected
    procedure BuildEnables; virtual; abstract;
    function IsFieldsCorrect: boolean; virtual; abstract;
    procedure ShowMsg(_msg: string); virtual; abstract;
  public
    property ConstMessage: string read F_ConstMessage write F_ConstMessage;
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    procedure AfterScrollHandler(DataSet: TDataSet);
    procedure FieldValueChangeHandler(Sender: TField);
  end;

implementation

{$R *.dfm}

uses StringConsts, WarningForm;

{ Tfrm_GridEdit }

procedure Tfrm_GridEdit.AfterScrollHandler(DataSet: TDataSet);
begin
  BuildEnables;
end;

procedure Tfrm_GridEdit.FieldValueChangeHandler(Sender: TField);
begin
  btn_Post.Enabled := ( ds_Main.DataSet.State <> dsBrowse );
end;

procedure Tfrm_GridEdit.SetIsReadOnly(const Value: boolean);
begin
  F_IsReadOnly := Value;
  BuildEnables;
end;

procedure Tfrm_GridEdit.ds_MainStateChange(Sender: TObject);
begin
  BuildEnables;
end;

procedure Tfrm_GridEdit.btn_InsertClick(Sender: TObject);
begin
  ds_Main.DataSet.Append;
end;

procedure Tfrm_GridEdit.btn_EditClick(Sender: TObject);
begin
  ds_Main.DataSet.Edit;
end;

procedure Tfrm_GridEdit.btn_DeleteClick(Sender: TObject);
begin
  if Application.MessageBox( '¬ы уверены, что хотите удалить запись?',
    gc_strDispAVR, MB_YESNO + MB_ICONQUESTION ) = IDYES then
      ds_Main.DataSet.Delete;
end;

procedure Tfrm_GridEdit.btn_CancelClick(Sender: TObject);
begin
  Cancel;
end;

procedure Tfrm_GridEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

function Tfrm_GridEdit.Post: boolean;
begin
  if IsFieldsCorrect then
  begin
    ds_Main.DataSet.Post;
    ShowMsg( '' );
    Result := true;
  end else Result := false;
end;

procedure Tfrm_GridEdit.btn_PostClick(Sender: TObject);
begin
  Post;
end;

procedure Tfrm_GridEdit.FormShow(Sender: TObject);
begin
  ShowMsg('');
end;

procedure Tfrm_GridEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ds_Main.DataSet.State <> dsBrowse then
  begin
    case ShowWarningDlg of
      raSave: if not Post then Action:=caNone;
      raNoSave: Cancel;
      else Action:=caNone;
    end; //end case
  end;
end;

procedure Tfrm_GridEdit.Cancel;
begin
  ds_Main.DataSet.Cancel;
  ShowMsg('');
end;

procedure Tfrm_GridEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

end.
