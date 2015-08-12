unit DepChargeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DepChargeBaseFrame, DepWorksFrame, ExtCtrls, StdCtrls,
  Buttons, DB, DepMatersFrame, DepEquipsFrame;

type
  Tfrm_DepCharge = class(TForm)
    pnl_Btns: TPanel;
    btn_Append: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    StatusBar: TStatusBar;
    frame_Equips: Tframe_DepEquips;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AppendClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    F_IsReadOnly: boolean;
    procedure BuildEnables;
    procedure EnableEditBtns(_value: boolean);
    procedure SetIsReadOnly(Value: boolean);
    procedure ShowMsg( _msg: string );
    function Post: boolean;
  public
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    procedure FieldValueChangeHandler(Sender: TField);
  end;

implementation

{$R *.dfm}

uses WarningForm;

procedure Tfrm_DepCharge.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DepCharge.FormShow(Sender: TObject);
begin
  frame_Equips.BuildEnablesProc := BuildEnables;
  frame_Equips.BuildEnables;
end;

procedure Tfrm_DepCharge.btn_AppendClick(Sender: TObject);
begin
  frame_Equips.ds_Main.DataSet.Append;
end;

procedure Tfrm_DepCharge.btn_EditClick(Sender: TObject);
begin
  if frame_Equips.ds_Main.DataSet.FieldByName( 'clc_IsCanEdit' ).AsBoolean then
    frame_Equips.ds_Main.DataSet.Edit;
end;

procedure Tfrm_DepCharge.btn_DeleteClick(Sender: TObject);
begin
  if frame_Equips.ds_Main.DataSet.FieldByName( 'clc_IsCanDel' ).AsBoolean then
    if Application.MessageBox( '¬ы уверены, что хотите удалить запись?',
      PChar(Caption), MB_YESNO + MB_ICONQUESTION ) = IDYES then
      frame_Equips.ds_Main.DataSet.Delete;
end;

procedure Tfrm_DepCharge.btn_PostClick(Sender: TObject);
begin
  Post;
end;

procedure Tfrm_DepCharge.btn_CancelClick(Sender: TObject);
begin
  frame_Equips.ds_Main.DataSet.Cancel;
end;

procedure Tfrm_DepCharge.BuildEnables;
var
  _IsBr: boolean;
begin
  if frame_Equips.IsReadOnly then
  begin
    frame_Equips.EnableFields( false );
    frame_Equips.EnableGrid( true );
    EnableEditBtns( false );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := false;
  end else
  begin
    _IsBr := ( frame_Equips.ds_Main.DataSet.State = dsBrowse );
    frame_Equips.EnableFields( not _IsBr );
    frame_Equips.EnableGrid( _IsBr );
    EnableEditBtns( _IsBr );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := not _IsBr;
  end;
end;

procedure Tfrm_DepCharge.EnableEditBtns(_value: boolean);
begin
  btn_Append.Enabled := _value;
  btn_Edit.Enabled := _value;
  btn_Delete.Enabled := _value;
end;

procedure Tfrm_DepCharge.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := value;
  frame_Equips.IsReadOnly := value;
end;

procedure Tfrm_DepCharge.FieldValueChangeHandler(Sender: TField);
begin
  btn_Post.Enabled := ( frame_Equips.ds_Main.DataSet.State <> dsBrowse );
end;

procedure Tfrm_DepCharge.ShowMsg(_msg: string);
begin
  StatusBar.SimpleText := _msg;
end;

function Tfrm_DepCharge.Post: boolean;
begin
  if frame_Equips.IsFieldsCorrect then
  begin
    frame_Equips.ds_Main.DataSet.Post;
    Result := true;
    ShowMsg( '' );
  end else Result := false;
end;

procedure Tfrm_DepCharge.FormCreate(Sender: TObject);
begin
  frame_Equips.ShowMsgProc := ShowMsg;
end;

procedure Tfrm_DepCharge.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if frame_Equips.ds_Main.DataSet .State <> dsBrowse then
  begin
    case ShowWarningDlg of
      raSave: if not Post then Action:=caNone;
      raNoSave: frame_Equips.ds_Main.DataSet.Cancel;
      else Action:=caNone;
    end; //end case
  end;
end;

end.

