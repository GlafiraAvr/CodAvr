unit DepEquipPlanForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DepChargeBaseFrame,
  DepEquipPlanFrame,DB;

type
  Tfrm_DepEqiupPlan = class(TForm)
    frame_DepEqipP: Tframe_DepEqipPlanChange;
    StatusBar: TStatusBar;
    Pnlbtns: TPanel;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Append: TBitBtn;
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frame_DepEqipPrdbl_equip_typChange(Sender: TObject);
  private
    { Private declarations }
        F_IsReadOnly: boolean;
    procedure BuildEnables;
    procedure EnableEditBtns(_value: boolean);
    procedure SetIsReadOnly(Value: boolean);
    function Post: boolean;
    procedure  ShowMsg( Text:string );
  public
    { Public declarations }
    procedure FieldValueChangeHandler(Sender: TField);
    property IsReadOnly: boolean  read F_IsReadOnly  write SetIsReadOnly;
  end;

var
  frm_DepEqiupPlan: Tfrm_DepEqiupPlan;

implementation

{$R *.dfm}

procedure Tfrm_DepEqiupPlan.btn_EditClick(Sender: TObject);
begin
  frame_DepEqipP.ds_Main.DataSet.Edit;
end;

procedure Tfrm_DepEqiupPlan.btn_DeleteClick(Sender: TObject);
begin
 if Application.MessageBox( '¬ы уверены, что хотите удалить запись?',
      PChar(Caption), MB_YESNO + MB_ICONQUESTION ) = IDYES then
      frame_DepEqipP.ds_Main.DataSet.Delete;

end;

function Tfrm_DepEqiupPlan.Post: boolean;
begin
  if frame_DepEqipP.IsFieldsCorrect then
  begin
    frame_DepEqipP.ds_Main.DataSet.Post;
    Result := true;
    ShowMsg( '' );
  end else Result := false;
end;

procedure Tfrm_DepEqiupPlan.btn_PostClick(Sender: TObject);
begin
Post;
end;

procedure  Tfrm_DepEqiupPlan.ShowMsg(Text:string);
begin
 StatusBar.SimpleText:=Text;
end;

procedure Tfrm_DepEqiupPlan.btn_CancelClick(Sender: TObject);
begin
frame_DepEqipP.ds_Main.DataSet.Cancel;
end;

procedure Tfrm_DepEqiupPlan.btn_ExitClick(Sender: TObject);
begin
Close;
end;

procedure Tfrm_DepEqiupPlan.FormShow(Sender: TObject);
begin
 frame_DepEqipP.BuildEnablesProc := BuildEnables;
  frame_DepEqipP.BuildEnables;
end;


procedure Tfrm_DepEqiupPlan.BuildEnables;
var
  _IsBr: boolean;
begin
  if frame_DepEqipP.IsReadOnly then
  begin
    frame_DepEqipP.EnableFields( false );
    frame_DepEqipP.EnableGrid( true );
    EnableEditBtns( false );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := false;
  end else
  begin
    _IsBr := ( frame_DepEqipP.ds_Main.DataSet.State = dsBrowse );
    frame_DepEqipP.EnableFields( not _IsBr );
    frame_DepEqipP.EnableGrid( _IsBr );
    EnableEditBtns( _IsBr );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := not _IsBr;
  end;
end;

procedure Tfrm_DepEqiupPlan.EnableEditBtns(_value: boolean);
begin
  btn_Append.Enabled := _value;
  btn_Edit.Enabled := _value;
  btn_Delete.Enabled := _value;
end;

procedure  Tfrm_DepEqiupPlan.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := value;
  frame_DepEqipP.IsReadOnly := value;
end;

procedure Tfrm_DepEqiupPlan.FieldValueChangeHandler(Sender: TField);
begin
  btn_Post.Enabled := ( frame_DepEqipP.ds_Main.DataSet.State <> dsBrowse );
end;



procedure Tfrm_DepEqiupPlan.BitBtn1Click(Sender: TObject);
begin

  frame_DepEqipP.ds_Main.DataSet.Append;
  frame_DepEqipP.rdbl_equip_typ.KeyValue:=-1;
end;

procedure Tfrm_DepEqiupPlan.frame_DepEqipPrdbl_equip_typChange(
  Sender: TObject);
begin
  frame_DepEqipP.rdbl_equip_typChange(Sender);
//  btn_post.Enabled:=false;
end;

end.
