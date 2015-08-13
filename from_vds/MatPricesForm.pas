unit MatPricesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SecurityBaseForm, BaseGridFrame, ExtCtrls, RxLookup, StdCtrls,
  ComCtrls, MatPricesGridFrame, Buttons, DB;

type
  TActionType=(atAppend, atEdit, atDelete, atPost, atCancel);

  Tfrm_MatPrices = class(Tfrm_SecurityBase)
    pnl_Btns: TPanel;
    StatusBar1: TStatusBar;
    frame_MatPrices: Tframe_MatPricesGrid;
    btn_Append: TBitBtn;
    btn_Edit: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_AppendClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure frame_MatPricesdbl_MaterChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    class function GetGUID: string; override;
  private
    F_IsReadOnly: boolean;
    F_IsLockProcessStatus: boolean;
    procedure DoAction(ActionType: TActionType);
    procedure EnableBtns;
    procedure OnChangeProcessStatus(Text: string);
  public
    constructor Create(AOwner: TComponent; AIsReadOnly: boolean);
  end;


implementation

{$R *.dfm}

uses AppGUIDS;

{ Tfrm_MatPrices }

class function Tfrm_MatPrices.GetGUID: string;
begin
  Result:=ALLVOCFORMGUID;
end;

procedure Tfrm_MatPrices.FormShow(Sender: TObject);
begin
  inherited;
  frame_MatPrices.OnChangeProcessStatus:=OnChangeProcessStatus;
  frame_MatPrices.Start;
  EnableBtns;
end;

procedure Tfrm_MatPrices.FormDestroy(Sender: TObject);
begin
  inherited;
  frame_MatPrices.Stop;
end;

procedure Tfrm_MatPrices.btn_AppendClick(Sender: TObject);
begin
  DoAction(atAppend);
  if frame_MatPrices.pnl_Fields.Visible then
    frame_MatPrices.dbl_Regions.SetFocus;
end;

procedure Tfrm_MatPrices.btn_EditClick(Sender: TObject);
begin
  DoAction(atEdit);
  if frame_MatPrices.pnl_Fields.Visible then
    frame_MatPrices.dbl_Regions.SetFocus;
end;

procedure Tfrm_MatPrices.btn_DeleteClick(Sender: TObject);
begin
  DoAction(atDelete)
end;

procedure Tfrm_MatPrices.btn_PostClick(Sender: TObject);
begin
  DoAction(atPost);
end;

procedure Tfrm_MatPrices.btn_CancelClick(Sender: TObject);
begin
  DoAction(atCancel);
end;

procedure Tfrm_MatPrices.btn_ExitClick(Sender: TObject);
begin
  Close;
end;


procedure Tfrm_MatPrices.DoAction(ActionType: TActionType);
begin
  case ActionType of
    atAppend: frame_MatPrices.Append;
    atEdit: frame_MatPrices.Edit;
    atDelete: frame_MatPrices.Delete;
    atPost: frame_MatPrices.Post;
    atCancel: frame_MatPrices.Cancel;
  end;
  EnableBtns;
end;

procedure Tfrm_MatPrices.EnableBtns;
  procedure EnBtns(EnAppend, EnEdit, EnDelete, EnPost, EnCancel, DblMat: boolean);
  begin
    btn_Append.Enabled:=EnAppend;
    btn_Edit.Enabled:=EnEdit;
    btn_Delete.Enabled:=EnDelete;
    btn_Post.Enabled:=EnPost;
    btn_Cancel.Enabled:=EnCancel;
    frame_MatPrices.dbl_Mater.Enabled:=DblMat;
  end;
begin
  if not F_IsReadOnly then
  begin
    case frame_MatPrices.dset_Main.State of
      dsBrowse: EnBtns(true, true, true, false, false, true);
      dsEdit, dsInsert: EnBtns(false, false, false, true, true, false);
      else EnBtns(false, false, false, false, false, true);
    end;
  end else EnBtns(false, false, false, false, false, true);
end;

constructor Tfrm_MatPrices.Create(AOwner: TComponent;
  AIsReadOnly: boolean);
begin
  inherited Create(AOwner);
  if IsCurrentUserCanEdit then
  begin
    F_IsReadOnly:=AIsReadOnly;
    F_IsLockProcessStatus:=false;
  end else
  begin
    StatusBar1.SimpleText:='У вас недостаточно прав для редактирования данной формы';
    F_IsReadOnly:=true;
    F_IsLockProcessStatus:=true;
  end;
end;

procedure Tfrm_MatPrices.frame_MatPricesdbl_MaterChange(Sender: TObject);
begin
  inherited;
  EnableBtns;
end;

procedure Tfrm_MatPrices.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrm_MatPrices.OnChangeProcessStatus(Text: string);
begin
  if not F_IsLockProcessStatus then
    StatusBar1.SimpleText:=Text;
end;

end.
