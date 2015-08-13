unit DepWorkMaterPlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DepMatersFrame, DepChargeBaseFrame,
  DepWorksFrame, ComCtrls,DB;

type
  Tfrm_DepWorkMaterPlan = class(TForm)
    StatusBar: TStatusBar;
    PageControl: TPageControl;
    Works: TTabSheet;
    Maters: TTabSheet;
    frame_DepWorks: Tframe_DepWorks;
    frame_DepMaters: Tframe_DepMaters;
    Pnlbtns: TPanel;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Append: TBitBtn;
    procedure btn_AppendClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    f_CurrentFrame:Tframe_DepChargeBase;
    F_IsReadOnly:boolean;
    function Post: boolean;
    procedure BuildEnables;
    procedure EnableEditBtns(_value: boolean);
    procedure SetIsReadOnly(Value: boolean);
    procedure FieldValueChangeHandler(Sender: TField);
    procedure  ShowMsg( Text:string );
  public
    { Public declarations }
    property IsReadOnly: boolean  read F_IsReadOnly  write SetIsReadOnly;


  end;

var
  frm_DepWorkMaterPlan: Tfrm_DepWorkMaterPlan;

implementation

{$R *.dfm}


procedure Tfrm_DepWorkMaterPlan.BuildEnables;
var
  _IsBr: boolean;
begin
  if f_CurrentFrame.IsReadOnly then
  begin
    f_CurrentFrame.EnableFields( false );
    f_CurrentFrame.EnableGrid( true );
    EnableEditBtns( false );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := false;
  end else
  begin
    _IsBr := ( f_CurrentFrame.ds_Main.DataSet.State = dsBrowse );
    f_CurrentFrame.EnableFields( not _IsBr );
    f_CurrentFrame.EnableGrid( _IsBr );
    EnableEditBtns( _IsBr );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := not _IsBr;
  end;
end;

procedure Tfrm_DepWorkMaterPlan.EnableEditBtns(_value: boolean);
begin
  btn_Append.Enabled := _value;
  btn_Edit.Enabled := _value;
  btn_Delete.Enabled := _value;
end;

procedure  Tfrm_DepWorkMaterPlan.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := value;
  f_CurrentFrame.IsReadOnly := value;
end;

procedure Tfrm_DepWorkMaterPlan.FieldValueChangeHandler(Sender: TField);
begin
  btn_Post.Enabled := ( f_CurrentFrame.ds_Main.DataSet.State <> dsBrowse );
end;




procedure Tfrm_DepWorkMaterPlan.btn_AppendClick(Sender: TObject);
begin
 f_CurrentFrame.ds_Main.DataSet.Append;
end;

procedure Tfrm_DepWorkMaterPlan.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
   0: f_CurrentFrame:=frame_DepWorks;
   1: f_CurrentFrame:=frame_DepMaters;
  end;
  f_CurrentFrame.BuildEnables;
end;

procedure Tfrm_DepWorkMaterPlan.btn_EditClick(Sender: TObject);
begin
  f_CurrentFrame.ds_Main.DataSet.Edit;
end;

procedure Tfrm_DepWorkMaterPlan.btn_DeleteClick(Sender: TObject);
begin
if Application.MessageBox( '¬ы уверены, что хотите удалить запись?',
      PChar(Caption), MB_YESNO + MB_ICONQUESTION ) = IDYES then
      f_CurrentFrame.ds_Main.DataSet.Delete;
end;

procedure Tfrm_DepWorkMaterPlan.btn_PostClick(Sender: TObject);
begin
Post;
end;

function Tfrm_DepWorkMaterPlan.Post: boolean;
begin
  if f_CurrentFrame.IsFieldsCorrect then
  begin
    f_CurrentFrame.ds_Main.DataSet.Post;
    Result := true;
    ShowMsg( '' );
  end else Result := false;
end;

procedure Tfrm_DepWorkMaterPlan.btn_CancelClick(Sender: TObject);
begin
f_CurrentFrame.ds_Main.DataSet.Cancel;
end;

procedure Tfrm_DepWorkMaterPlan.btn_ExitClick(Sender: TObject);
begin
Close;
end;


procedure Tfrm_DepWorkMaterPlan.FormShow(Sender: TObject);
begin
case  PageControl.ActivePageIndex of
   0: f_CurrentFrame:=frame_DepWorks;
   1: f_CurrentFrame:=frame_DepMaters;
end;
 f_CurrentFrame.BuildEnablesProc := BuildEnables;
 f_CurrentFrame.BuildEnables;
end;


procedure  Tfrm_DepWorkMaterPlan.ShowMsg(Text:string);
begin
 StatusBar.SimpleText:=Text;
end;

end.
