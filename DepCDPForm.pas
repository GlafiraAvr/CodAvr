unit DepCDPForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGDepDModule, DepFrame, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridEh, WorkBuffDModule, DB, Menus, RxLookup,
  RXDBCtrl, DBCtrls, DBCtrlsEh;

type
  Tfrm_DepCDP = class(TForm)
    frame_Dep: Tframe_Dep;
    StatusBar: TStatusBar;
    pnl_DepWorks: TPanel;
    dbg_DepWorks: TDBGridEh;
    pnl_Btns: TPanel;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    ds_DepWorks: TDataSource;
    btn_Exit: TBitBtn;
    pm_DepWorks: TPopupMenu;
    mi_DelWork: TMenuItem;
    pnl_WorkBtns: TPanel;
    btn_DeleteDep: TBitBtn;
    btn_AddWork: TBitBtn;
    btn_DeleteWork: TBitBtn;
    btn_EditWork: TBitBtn;
    Panel1: TPanel;
    btn_DepEquips: TBitBtn;
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure frame_Deptc_DepsChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbg_DepWorksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_DepWorksDblClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frame_Depmi_DelDepClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frame_Deptc_DepsChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure mi_DelWorkClick(Sender: TObject);
    procedure pm_DepWorksPopup(Sender: TObject);
    procedure dbg_DepWorksDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btn_AddWorkClick(Sender: TObject);
    procedure btn_EditWorkClick(Sender: TObject);
    procedure btn_DeleteWorkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frame_Depde_EndDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_DeleteDepClick(Sender: TObject);
    procedure frame_Depde_EndDateEnter(Sender: TObject);
    procedure frame_Depte_EndTimeEnter(Sender: TObject);
    procedure frame_Depmem_AddInfoEnter(Sender: TObject);
    procedure dbg_DepWorksEnter(Sender: TObject);
    procedure CtrlEnter(Sender: TObject);
    procedure CtrlExit(Sender: TObject);
    procedure CtrlWithClearMsgExit(Sender: TObject);
    procedure btn_DepEquipsClick(Sender: TObject);
  private
    F_DepData: Tdm_NGDep;
    F_WorkBuff: Tdm_WorkBuff;
    procedure LoadDataToWorkBuff;
    procedure EditWork;
    procedure DeleteWork;
    procedure DeleteDep;
    procedure BuildEnableCtrls;
    procedure ShowMsg( _msg: string );
  private
    procedure OnDepShowMsgHandler( _Msg: string );
    procedure OnChangeEnabledDepBtnsHandler( _EnabledDepBtns: TEnabledDepBtns );
    procedure OnDepWorksChangeHandler( Sender: TObject );
    procedure OnWorkBuffBeforePostHandler( DataSet: TDataSet );
  public
    constructor Create(AOwner: TComponent; ADepData: Tdm_NGDep);
  end;


implementation

{$R *.dfm}

uses WorkBuffVocAttacherDModule, EditWorkBuffForm, GlobalData, DepChargeManager;

var
  OldCtrlColor: TColor;

{ Tfrm_DepCDP }

constructor Tfrm_DepCDP.Create(AOwner: TComponent; ADepData: Tdm_NGDep);
begin
  inherited Create( AOwner );
  F_DepData := ADepData;
  F_DepData.OnShowMsg := OnDepShowMsgHandler;
  //
  frame_Dep.Init( ADepData );
  frame_Dep.OnChangeEnabledDepBtns := OnChangeEnabledDepBtnsHandler;
  //
  F_WorkBuff := Tdm_WorkBuff.Create( nil );
  F_WorkBuff.OnDataChange := OnDepWorksChangeHandler;
  F_WorkBuff.OnBeforePost := OnWorkBuffBeforePostHandler;
  ds_DepWorks.DataSet := F_WorkBuff.mt_DepWorks;
//  frame_Dep.gb_PlanWork.Visible := (F_DepData.DefaultOfficPostID = GlobalData.DISP_CDP_POST_ID);

end;

procedure Tfrm_DepCDP.OnChangeEnabledDepBtnsHandler(
  _EnabledDepBtns: TEnabledDepBtns);
begin
  btn_Post.Enabled := _EnabledDepBtns.EnabledPost;
  btn_Cancel.Enabled := _EnabledDepBtns.EnabledCancel; 
end;

procedure Tfrm_DepCDP.OnDepShowMsgHandler(_Msg: string);
begin
  ShowMsg( _Msg );
end;

procedure Tfrm_DepCDP.btn_PostClick(Sender: TObject);
begin


  if frame_Dep.DepPost then
  begin
    F_WorkBuff.OrderID := F_DepData.OrderID;
    F_WorkBuff.DepID := F_DepData.CurrentDepID;
    F_WorkBuff.SaveModifedData;

    if ((F_DepData.dset_Dep.FieldByName('ENDDATE').AsFloat - F_DepData.dset_Dep.FieldByName('STARTDATE').AsFloat) > 0.25)
        then application.MessageBox('Не забыли-ли Вы внести отключения и прекрытия задвижек?', 'Внимание'); 

    btn_Exit.SetFocus;
  end;
end;

procedure Tfrm_DepCDP.btn_CancelClick(Sender: TObject);
begin
  frame_Dep.DepCancel;
  LoadDataToWorkBuff;
end;

procedure Tfrm_DepCDP.frame_Deptc_DepsChange(Sender: TObject);
begin
  frame_Dep.tc_DepsChange(Sender);
  //
  LoadDataToWorkBuff;
end;

procedure Tfrm_DepCDP.FormDestroy(Sender: TObject);
begin
  F_WorkBuff.Free;
end;

procedure Tfrm_DepCDP.LoadDataToWorkBuff;
begin
  if F_DepData.CurrentDepID > 0 then
  begin
    F_WorkBuff.OrderID := F_DepData.OrderID;
    F_WorkBuff.DepID := F_DepData.CurrentDepID;
    F_WorkBuff.LoadData;
  end else
    F_WorkBuff.ResetBuff;
end;

procedure Tfrm_DepCDP.EditWork;
var
  _frm: Tfrm_EditWorkBuff;
  _dm: Tdm_WorkBuffVocAttacher;
begin
  if ( not F_DepData.IsReadOnly ) and
    ( ds_DepWorks.DataSet.FieldByName( 'IS_CAN_EDIT' ).AsBoolean ) then
  begin
    _frm := Tfrm_EditWorkBuff.Create( nil );
    _dm := Tdm_WorkBuffVocAttacher.Create( nil );
    try
      _dm.AttachToGlobalVocCache;
      _frm.ds_Main.DataSet := F_WorkBuff.mt_DepWorks;
      _frm.ds_WorkAtt.DataSet := _dm.mt_s_work;
      _frm.ds_DiamAtt.DataSet := _dm.mt_s_diam;
      if  _frm.ds_Main.DataSet.Modified then
        _frm.ds_Main.DataSet.FieldByName('SentTo1562').AsBoolean :=false;

      if _frm.ShowModal = mrOk then
        F_WorkBuff.Post
      else
        F_WorkBuff.Cancel;
    finally
      _frm.Free;
      _dm.Free;
    end;
  end;
end;

procedure Tfrm_DepCDP.dbg_DepWorksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure _SelBtn;
  begin
    if btn_Post.Enabled then btn_Post.SetFocus
    else  btn_Exit.SetFocus;
  end;
begin
  case Key of
    VK_RETURN:
      if ssCtrl in Shift then EditWork
      else _SelBtn;
    VK_CONTROL: EditWork;
    VK_DELETE: DeleteWork;
    VK_TAB: _SelBtn;
  end;
end;

procedure Tfrm_DepCDP.dbg_DepWorksDblClick(Sender: TObject);
begin
  EditWork;
end;

procedure Tfrm_DepCDP.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DepCDP.FormShow(Sender: TObject);
begin
  LoadDataToWorkBuff;
  BuildEnableCtrls;
  frame_Dep.tc_Deps.SetFocus;
end;


procedure Tfrm_DepCDP.OnDepWorksChangeHandler(Sender: TObject);
var
  _enab: boolean;
begin
  _enab := ( (not F_DepData.IsReadOnly) and F_WorkBuff.IsDataChanged );
  btn_Post.Enabled := _enab;
  btn_Cancel.Enabled := _enab;
end;

procedure Tfrm_DepCDP.frame_Depmi_DelDepClick(Sender: TObject);
begin
{
  frame_Dep.mi_DelDepClick(Sender);
  LoadDataToWorkBuff;
}
  DeleteDep;
end;

procedure Tfrm_DepCDP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if btn_Post.Enabled then
  begin
    Action := caNone;
    Application.MessageBox( 'Сохраните или отмените изменения!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end;
end;

procedure Tfrm_DepCDP.frame_Deptc_DepsChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  _s: string;
begin
  frame_Dep.tc_DepsChanging(Sender, AllowChange);
  if AllowChange then
  begin
      if F_WorkBuff.IsDataChanged then
      begin
        AllowChange := false;
        _s := 'Сохраните или отмените изменения!';
        Application.MessageBox( PChar( _s ), 'Выезды', MB_OK + MB_ICONWARNING );
      end;
  end;
end;

procedure Tfrm_DepCDP.mi_DelWorkClick(Sender: TObject);
begin
  DeleteWork;
end;

procedure Tfrm_DepCDP.BuildEnableCtrls;
var
  _en: boolean;
begin
  dbg_DepWorks.ReadOnly := F_DepData.IsReadOnly;
  _en := not F_DepData.IsReadOnly;

  btn_AddWork.Enabled := _en;
  btn_EditWork.Enabled := _en;
  btn_DeleteWork.Enabled := _en;

  btn_DeleteDep.Enabled := _en;
end;

procedure Tfrm_DepCDP.DeleteWork;
begin
  if ( not F_DepData.IsReadOnly ) and
      ( ds_DepWorks.DataSet.FieldByName( 'IS_CAN_EDIT' ).AsBoolean )  then
    F_WorkBuff.Delete;
end;

procedure Tfrm_DepCDP.pm_DepWorksPopup(Sender: TObject);
begin
  mi_DelWork.Enabled := not F_DepData.IsReadOnly;
end;

procedure Tfrm_DepCDP.dbg_DepWorksDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    if ( not F_DepData.IsReadOnly ) and
      ( not ds_DepWorks.DataSet.FieldByName( 'IS_CAN_EDIT' ).AsBoolean )
    then
      Canvas.Brush.Color := clSilver
    else
      Canvas.Brush.Color := dbg_DepWorks.Color;
      
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_DepCDP.OnWorkBuffBeforePostHandler(DataSet: TDataSet);
begin
  F_WorkBuff.CurrentStartDate := F_DepData.CurrentStartDate; 
end;

procedure Tfrm_DepCDP.btn_AddWorkClick(Sender: TObject);
begin
  if not F_DepData.IsReadOnly then
  begin
    ds_DepWorks.DataSet.Append;
    EditWork;
  end;
end;

procedure Tfrm_DepCDP.btn_EditWorkClick(Sender: TObject);
begin
  EditWork;
end;

procedure Tfrm_DepCDP.btn_DeleteWorkClick(Sender: TObject);
begin
  DeleteWork;
end;

procedure Tfrm_DepCDP.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure _Next;
  begin
    SelectNext( ActiveControl, true, true );
  end;
begin

 if (key=VK_CONTROL) and (Sender is TDBDateEdit) and ( (Sender as TDBDateEdit).Tag = 123)
      and ( (Sender as TDBDateEdit).DataSource.DataSet.State in [dsInsert, dsEdit])
      and ((Sender as TDBDateEdit).DataSource.DataSet.FieldByName('PLANSTARTDATE').IsNull) then
     (Sender as TDBDateEdit).DataSource.DataSet.FieldByName('PLANSTARTDATE').AsDateTime := Now;

  if ( Key=VK_RETURN ) and not( ssCtrl in Shift ) then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        _Next;
    end else _Next;
  end;
end;

procedure Tfrm_DepCDP.frame_Depde_EndDateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  frame_Dep.de_EndDateKeyDown(Sender, Key, Shift);
  FormKeyDown(Sender, Key, Shift);
end;

procedure Tfrm_DepCDP.DeleteDep;
begin
  if frame_Dep.DepDelete then
    LoadDataToWorkBuff;
end;

procedure Tfrm_DepCDP.btn_DeleteDepClick(Sender: TObject);
begin
  DeleteDep;
end;

procedure Tfrm_DepCDP.frame_Depde_EndDateEnter(Sender: TObject);
begin
  ShowMsg( 'Нажмите "Ctrl", чтобы установить тек. дату' );
  CtrlEnter(Sender);
end;

procedure Tfrm_DepCDP.ShowMsg(_msg: string);
begin
  if F_DepData.IsReadOnly then
    _msg := 'У вас недостаточно прав для редактирования данной формы';

  StatusBar.SimpleText := _Msg;
end;

procedure Tfrm_DepCDP.frame_Depte_EndTimeEnter(Sender: TObject);
begin
  ShowMsg( 'Нажмите "Ctrl", чтобы установить тек. дату' );
  CtrlEnter( Sender );
end;

procedure Tfrm_DepCDP.frame_Depmem_AddInfoEnter(Sender: TObject);
begin
  ShowMsg( 'Нажмите "Ctrl+Enter", чтобы перейти на новую строку' );
  CtrlEnter( Sender );
end;

procedure Tfrm_DepCDP.dbg_DepWorksEnter(Sender: TObject);
begin
  ShowMsg( 'Нажмите "Ctrl", чтобы редактировать работу' );
  CtrlEnter( Sender );
end;

procedure Tfrm_DepCDP.CtrlEnter(Sender: TObject);
var
  //_ctrl: TWinControl;
  _cl: TColor;
begin
  {
  if Sender is TWinControl then
  begin
    _ctrl := Sender as TWinControl;
    OldCtrlColor := _ctrl.Color;
  end;
  }
  _cl := clMoneyGreen;

  if Sender is TRXDBLookupCombo then
  begin
    OldCtrlColor := ( Sender as TRXDBLookupCombo ).color;
    ( Sender as TRXDBLookupCombo ).color := _cl;
  end else
  if Sender is TDBDateEdit then
  begin
    OldCtrlColor := ( Sender as TDBDateEdit ).Color;
    ( Sender as TDBDateEdit ).Color := _cl;
  end else
  if Sender is TDBDateTimeEditEh then
  begin
    OldCtrlColor := ( Sender as TDBDateTimeEditEh ).Color;
    ( Sender as TDBDateTimeEditEh ).Color := _cl;
  end else
  if Sender is TDBMemo then
  begin
    OldCtrlColor := ( Sender as TDBMemo ).Color;
    ( Sender as TDBMemo ).Color := _cl;
  end else
  if Sender is TDBGridEh then
  begin
    OldCtrlColor := ( Sender as TDBGridEh ).Color;
    ( Sender as TDBGridEh ).Color := _cl;
  end else
  if Sender is TBitBtn then
  begin
    OldCtrlColor := ( Sender as TBitBtn ).Font.Color;
    ( Sender as TBitBtn ).Font.Color := clRed;
  end   else
  if Sender is TDBNumberEditEh then
  begin
    OldCtrlColor := ( Sender as TDBNumberEditEh ).Color;
    ( Sender as TDBNumberEditEh ).Color := _cl;
  end else

end;

procedure Tfrm_DepCDP.CtrlExit(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
  begin
    ( Sender as TRXDBLookupCombo ).color := OldCtrlColor;
  end else
  if Sender is TDBDateEdit then
  begin
    ( Sender as TDBDateEdit ).Color := OldCtrlColor;
  end else
  if Sender is TDBDateTimeEditEh then
  begin
    ( Sender as TDBDateTimeEditEh ).Color := OldCtrlColor;
  end else
  if Sender is TDBMemo then
  begin
    ( Sender as TDBMemo ).Color := OldCtrlColor;
  end else
  if Sender is TDBGridEh then
  begin
    ( Sender as TDBGridEh ).Color := OldCtrlColor;
  end else
  if Sender is TBitBtn then
  begin
    ( Sender as TBitBtn ).Font.Color := OldCtrlColor;
  end
end;

procedure Tfrm_DepCDP.CtrlWithClearMsgExit(Sender: TObject);
begin
  CtrlExit( Sender );
  ShowMsg( '' );
end;

procedure Tfrm_DepCDP.btn_DepEquipsClick(Sender: TObject);
var
  _DepChargeMan: TDepChargeManager;
  _DepID: integer;
begin
  _DepID := F_DepData.CurrentDepID;

  if _DepID > 0 then
  begin
    _DepChargeMan := TDepChargeManager.Create;
    try
      _DepChargeMan.OrderID := F_DepData.OrderID;
      _DepChargeMan.DepID := _DepID;

      _DepChargeMan.IsReadOnly := (F_DepData.IsReadOnly);
      _DepChargeMan.ShowCharge;
    finally
      _DepChargeMan.Free;
    end;
  end else
    if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );
end;

end.
