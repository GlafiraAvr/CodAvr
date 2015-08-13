unit WorkAndMaterForm_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SecurityBaseForm, EquipGridFrame_vds, WorkGridFrame_vds,
  BaseGridFrame_vds, WorkAndMaterBaseGrid_vds, MaterGridFrame_vds,
  ComCtrls, StdCtrls, Buttons, ExtCtrls,DB;

type
  TActionType=(atAppend, atEdit, atDelete, atPost, atCancel);

  Tfrm_WorkAndMater = class(Tfrm_SecurityBase)
    StatusBar: TStatusBar;
    pnl_Btns: TPanel;
    btn_Append: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Cancel: TBitBtn;
    PageControl: TPageControl;
    ts_FreeMater: TTabSheet;
    ts_PayedMater: TTabSheet;
    ts_FreeWorks: TTabSheet;
    ts_PayedWorks: TTabSheet;
    ts_Equip: TTabSheet;
    frame_FreeMater: Tframe_MaterGrid_vds;
    frame_PayedMater: Tframe_MaterGrid_vds;
    frame_PayedWorks: Tframe_WorkGrid_vds;
    frame_Equip: Tframe_EquipGrid_vds;
    frame_FreeWork: Tframe_WorkGrid_vds;
    procedure btn_AppendClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControlChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  private
    F_OrderID: integer;
    F_DepID: integer;
    F_IsReadOnly: boolean;
    F_CurrentFrame: Tframe_WorkAndMaterBaseGrid_vds;
    F_ArrFrame: array[1..1] of Tframe_WorkAndMaterBaseGrid_vds;
    F_IsLockProcessStatus: boolean;
    procedure DoAction(ActionType: TActionType);
    procedure EnableBtns;
    procedure ShowFormCaption;
    procedure SetImageToActivePage;
    procedure OnChangeProcessStatus(Text: string);
    procedure OnActivateFieldsPnl(Value: boolean);
 protected
    class function GetGUID: string; override;

  public
    constructor Create(AOwner: TComponent; AOrderID, ADepID: integer; AIsReadOnly: boolean);
  end;


var
  frm_WorkAndMater: Tfrm_WorkAndMater;

implementation

{$R *.dfm}
uses RxLookup, WarningForm, AppGUIDS;

constructor Tfrm_WorkAndMater.Create(AOwner: TComponent; AOrderID,
  ADepID: integer; AIsReadOnly: boolean);
begin
  inherited Create(AOwner);
  F_OrderID:=AOrderID;
  F_DepID:=ADepID;
  F_IsReadOnly:=AIsReadOnly;
  F_IsLockProcessStatus:=false;
  /////////////////
  ////////////////
  ////////////////
  if not IsCurrentUserCanEdit then
  begin
    F_IsReadOnly:=true;
    StatusBar.SimpleText:='У вас недостаточно прав для редактирования данной формы';
    F_IsLockProcessStatus:=true;
  end;
end;


procedure Tfrm_WorkAndMater.DoAction(ActionType: TActionType);
begin
  if Assigned(F_CurrentFrame) then
  begin
    case ActionType of
      atAppend: F_CurrentFrame.Append;
      atEdit: F_CurrentFrame.Edit;
      atDelete: F_CurrentFrame.Delete;
      atPost: F_CurrentFrame.Post;
      atCancel: F_CurrentFrame.Cancel;
    end;
  end;
  EnableBtns;
end;

procedure Tfrm_WorkAndMater.EnableBtns;
  procedure EnBtns(EnAppend, EnEdit, EnDelete, EnPost, EnCancel: boolean);
  begin
    btn_Append.Enabled:=EnAppend;
    btn_Edit.Enabled:=EnEdit;
    btn_Delete.Enabled:=EnDelete;
    btn_Post.Enabled:=EnPost;
    btn_Cancel.Enabled:=EnCancel;
  end;
begin
  if Assigned(F_CurrentFrame) and (not F_IsReadOnly) then
  begin
    case F_CurrentFrame.dset_Main.State of
      dsBrowse: EnBtns(true, true, true, false, false);
      dsEdit, dsInsert: EnBtns(false, false, false, true, true);
      else EnBtns(false, false, false, false, false);
    end;
  end else EnBtns(false, false, false, false, false);
end;

procedure Tfrm_WorkAndMater.OnActivateFieldsPnl(Value: boolean);
var
  i: integer;
  frame: Tframe_WorkAndMaterBaseGrid_vds;
begin
  if Value and Assigned(F_CurrentFrame) then
    for i:=0 to F_CurrentFrame.pnl_Fields.ControlCount-1 do
      if (F_CurrentFrame.pnl_Fields.Controls[i] is TRxDBLookupCombo) then
      begin
        (F_CurrentFrame.pnl_Fields.Controls[i] as TRxDBLookupCombo).SetFocus;
        break;
      end;
end;

procedure Tfrm_WorkAndMater.OnChangeProcessStatus(Text: string);
begin
  if not F_IsLockProcessStatus then
    StatusBar.SimpleText:=Text;
end;


procedure Tfrm_WorkAndMater.btn_AppendClick(Sender: TObject);
begin
  inherited;
DoAction(atAppend);
end;

procedure Tfrm_WorkAndMater.btn_EditClick(Sender: TObject);
begin
  inherited;
  DoAction(atEdit);
end;

procedure Tfrm_WorkAndMater.btn_DeleteClick(Sender: TObject);
begin
  inherited;
  DoAction(atDelete);
  ShowFormCaption;
end;

procedure Tfrm_WorkAndMater.btn_PostClick(Sender: TObject);
begin
  inherited;
 DoAction(atPost);
  ShowFormCaption;
end;

procedure Tfrm_WorkAndMater.btn_CancelClick(Sender: TObject);
begin
  inherited;
  DoAction(atCancel);
end;

procedure Tfrm_WorkAndMater.btn_ExitClick(Sender: TObject);
begin
  inherited;
Close;
end;

procedure Tfrm_WorkAndMater.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(F_CurrentFrame) then
  begin
    if F_CurrentFrame.dset_Main.State in [dsEdit, dsInsert] then
    begin
       case ShowWarningDlg of
          raSave: if not F_CurrentFrame.Post then Action:=caNone;
          raNoSave: F_CurrentFrame.Cancel;
          else Action:=caNone;
       end; //end case
    end;
  end;
end;

procedure Tfrm_WorkAndMater.FormDestroy(Sender: TObject);
var i:integer;
begin
  inherited;
for i:=0 to ComponentCount-1 do
    if (Components[i] is Tframe_WorkAndMaterBaseGrid_vds) then
    begin
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).Stop;
    end;
end;

procedure Tfrm_WorkAndMater.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_WorkAndMater.PageControlChange(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePage.Tag of
    1: F_CurrentFrame:=frame_FreeMater;
    2: F_CurrentFrame:=frame_PayedMater;
    3: F_CurrentFrame:=frame_FreeWork;
    4: F_CurrentFrame:=frame_PayedWorks;
    5: F_CurrentFrame:=frame_Equip;
    else F_CurrentFrame:=nil;
  end;
  EnableBtns;
  ShowFormCaption;
  //
  SetImageToActivePage;
end;

procedure Tfrm_WorkAndMater.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
 if Assigned(F_CurrentFrame) then
  begin
    if F_CurrentFrame.dset_Main.State in [dsInsert, dsEdit] then
    begin
      AllowChange:=false;
      OnChangeProcessStatus('Сохраните или отмените внесенные данные');
    end else AllowChange:=true;
  end else AllowChange:=true;
end;


procedure Tfrm_WorkAndMater.ShowFormCaption;
begin
  Caption:='Работы, материалы, оборудование - '+PageControl.ActivePage.Caption;
{  if Assigned(F_CurrentFrame) then
    Caption:=Caption+Format(' (Кол-во: %d)', [F_CurrentFrame.GetRecordCount]);}
end;

procedure Tfrm_WorkAndMater.SetImageToActivePage;
var
  i, img_index: integer;
begin
  for i:=0 to PageControl.PageCount-1 do
  begin
    if i=PageControl.TabIndex then
      img_index:=0
    else
      img_index:=-1;
    PageControl.Pages[i].ImageIndex:=img_index;
  end
end;

class function Tfrm_WorkAndMater.GetGUID: string;
begin
  Result:=WORKANDMATERFORMGUID_vds;
end;

procedure Tfrm_WorkAndMater.FormShow(Sender: TObject);
var i:integer;
begin
  inherited;
 for i:=0 to ComponentCount-1 do
    if (Components[i] is Tframe_WorkAndMaterBaseGrid_vds) then
    begin
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).OrderID:=F_OrderID;
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).DepID:=F_DepID;
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).OnChangeProcessStatus:=OnChangeProcessStatus;
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).OnActivateFieldsPanel:=OnActivateFieldsPnl;
      (Components[i] as Tframe_WorkAndMaterBaseGrid_vds).Start;
    end;

  PageControl.TabIndex:=0;
  PageControlChange(nil)
end;

end.
