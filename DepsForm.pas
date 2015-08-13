unit DepsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, ToolEdit, RXDBCtrl, RxLookup,
  DBCtrlsEh, DBCtrls, DepartureVocCacheDModule, DB, DepsDModule, Grids,
  DBGridEh, Buttons, ExtCtrls, GridEditForm;

const
  NEW_TAB = 777;  

type
  Tfrm_Deps = class(Tfrm_GridEdit)
    ds_Brig: TDataSource;
    StatusBar: TStatusBar;
    pnl_Fields: TPanel;
    tc_Deps: TTabControl;
    lbl_Brig: TLabel;
    dbl_Brig: TRxDBLookupCombo;
    gb_StartWork: TGroupBox;
    dbt_OfficialOpen: TDBText;
    lbl_StartDate: TLabel;
    lbl_StartTime: TLabel;
    lbl_OfficialOpen: TLabel;
    de_StartDate: TDBDateEdit;
    te_StartTime: TDBDateTimeEditEh;
    gb_EndWork: TGroupBox;
    dbt_OfficialClose: TDBText;
    lbl_EndDate: TLabel;
    lbl_EndTime: TLabel;
    lbl_OfficialClose: TLabel;
    de_EndDate: TDBDateEdit;
    te_EndTime: TDBDateTimeEditEh;
    pnl_Grid: TPanel;
    DBG_Deps: TDBGridEh;
    btn_DepCharge: TBitBtn;
    btn_DepWorkers: TBitBtn;
    btn_DepEquip: TBitBtn;
    procedure btn_PostClick(Sender: TObject);
    procedure ds_DepsDataChange(Sender: TObject; Field: TField);
    procedure btn_CancelClick(Sender: TObject);
    procedure tc_DepsChange(Sender: TObject);
    procedure te_StartTimeChange(Sender: TObject);
    procedure tc_DepsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure DBG_DepsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_DepChargeClick(Sender: TObject);
    procedure btn_DepWorkersClick(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);
    procedure ds_MainDataChange(Sender: TObject; Field: TField);
    procedure btn_DepEquipClick(Sender: TObject);
  private
    F_OnDepWorkBtnClick: TNotifyEvent;
    F_OnDepWorkersBtnClick: TNotifyEvent;
    F_OnDepEquipBtnClick: TNotifyEvent;
    procedure EnableFields( _value: boolean );
    procedure EnableEditBtns( _value: boolean );
    procedure EnablePostBtns( _value: boolean );
    procedure EnableChargeBtns( _value: boolean );
  protected
    function IsFieldsCorrect: boolean; override;
    procedure ShowMsg( _msg: string ); override;
    procedure BuildEnables; override;
  public
    property OnDepWorkBtnClick: TNotifyEvent read F_OnDepWorkBtnClick
      write F_OnDepWorkBtnClick;
    property OnDepWorkersBtnClick: TNotifyEvent read F_OnDepWorkersBtnClick
      write F_OnDepWorkersBtnClick;
    property OnDepEquipBtnClick: TNotifyEvent read F_OnDepEquipBtnClick
      write F_OnDepEquipBtnClick;
    procedure AfterOpenHandler(DataSet: TDataSet);
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_Deps.btn_PostClick(Sender: TObject);
begin
  if Post then btn_Insert.SetFocus;
end;

procedure Tfrm_Deps.ds_DepsDataChange(Sender: TObject; Field: TField);
begin
  if ds_Main.DataSet.State <> dsInsert then
    tc_Deps.TabIndex := ds_Main.DataSet.RecNo - 1;
end;

procedure Tfrm_Deps.btn_CancelClick(Sender: TObject);
var
  i: integer;
begin
  inherited;

  for i:=0 to tc_Deps.Tabs.Count - 1 do
    if integer(tc_Deps.Tabs.Objects[ i ]) = NEW_TAB then
    begin
      tc_Deps.Tabs.Delete( i );
      break;
    end;
end;

procedure Tfrm_Deps.tc_DepsChange(Sender: TObject);
begin
  ds_Main.DataSet.RecNo := tc_Deps.TabIndex + 1;
end;

procedure Tfrm_Deps.EnableFields(_value: boolean);
begin
  lbl_StartDate.Enabled := _value;
  lbl_StartTime.Enabled := _value;
  lbl_EndDate.Enabled := _value;
  lbl_EndTime.Enabled := _value;
  lbl_Brig.Enabled := _value;
  lbl_OfficialOpen.Enabled := _value;
  lbl_OfficialClose.Enabled := _value;

  de_StartDate.Enabled  := _value;
  te_StartTime.Enabled := _value;
  de_EndDate.Enabled := _value;
  te_EndTime.Enabled := _value;
  //dbt_OfficialOpen.Enabled := _value;
  //dbt_OfficialClose.Enabled := _value;
  gb_StartWork.Enabled := _value;
  gb_EndWork.Enabled := _value;
  dbl_Brig.Enabled := _value;
end;

procedure Tfrm_Deps.EnableEditBtns(_value: boolean);
begin
  btn_Insert.Enabled := _value;
  btn_Edit.Enabled := _value;
  btn_Delete.Enabled := _value;
end;

procedure Tfrm_Deps.EnablePostBtns(_value: boolean);
begin
  btn_Post.Enabled := _value;
  btn_Cancel.Enabled := _value;
end;

function Tfrm_Deps.IsFieldsCorrect: boolean;
var
  _dset: TDataSet;
begin
  Result := false;

  _dset := ds_Main.DataSet;

  if _dset.FieldByName('StartDate').IsNull then
  begin
    ShowMsg( 'Введите дату и время начала работ' );
    ActiveControl := de_StartDate;
    exit;
  end;

  if _dset.FieldByName('StartDate').AsDateTime > Now then
  begin
    ShowMsg( 'Дата и время начала работ не могут быть больше текущих' );
    ActiveControl := te_StartTime;
    exit;
  end;

  if ( not _dset.FieldByName('EndDate').IsNull )
    and ( _dset.FieldByName('EndDate').AsDateTime > Now ) then
  begin
    ShowMsg( 'Дата и время окончания работ не могут быть больше текущих' );
    ActiveControl := te_EndTime;
    exit;
  end;

  if ( not _dset.FieldByName('EndDate').IsNull )
  and ( _dset.FieldByName('EndDate').AsDateTime < _dset.FieldByName('StartDate').AsDateTime ) then
  begin
    ShowMsg( 'Дата начала работ не может быть больше даты конца работ' );
    ActiveControl := de_EndDate;
    exit;
  end;

  //if IsDBLEmpty( dbl_Brig ) then
  if trim( dbl_Brig.Text ) = '' then
  begin
    ShowMsg( 'Введите ответственного за проведение работ' );
    ActiveControl := dbl_Brig;
    exit;
  end;

  Result := true;
end;

procedure Tfrm_Deps.ShowMsg(_msg: string);
begin
  if trim(F_ConstMessage) <> '' then _msg := F_ConstMessage;
  StatusBar.SimpleText := _msg
end;

procedure Tfrm_Deps.te_StartTimeChange(Sender: TObject);
begin
  btn_Post.Enabled := ( ds_Main.DataSet.State <> dsBrowse );
end;

procedure Tfrm_Deps.tc_DepsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if ds_Main.DataSet.State <> dsBrowse then
    if Application.MessageBox( 'Сохранить внесенные изменения?', 'Выезды',
      MB_YESNO + MB_ICONQUESTION ) = IDYES then AllowChange := Post
    else Cancel;
end;

procedure Tfrm_Deps.BuildEnables;
var
  _IsBr: boolean;
begin
  {В зависимости от состояния набора данных енеблим контролы}
  if F_IsReadOnly then
  begin
    EnableFields( false );
    EnableEditBtns( false );
    EnablePostBtns( false );
    DBG_Deps.Enabled := true;
    //EnableChargeBtns( false );
  end else
  begin
    _IsBr := ds_Main.DataSet.State = dsBrowse;
    EnableFields(not _IsBr);
    DBG_Deps.Enabled := _IsBr;
    btn_Insert.Enabled := _IsBr;
    btn_Edit.Enabled := ( _IsBr ) and (ds_Main.DataSet.FieldByName('CALC_IsCanEditRec').AsBoolean);
    btn_Delete.Enabled := ( _IsBr ) and (ds_Main.DataSet.FieldByName('CALC_IsCanDelRec').AsBoolean);
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := not _IsBr;
    //EnableChargeBtns( ds_Deps.DataSet.FieldByName( 'CALC_IsCanEditRec' ).AsBoolean );
  end;
end;

procedure Tfrm_Deps.DBG_DepsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    if ds_Main.DataSet.FieldByName('DepNumber').AsInteger = 1 then
      Canvas.Brush.Color:=clMoneyGreen
    else
    begin
      if ds_Main.DataSet.FieldByName('EndDate').IsNull then Canvas.Brush.Color:=clWindow
      else Canvas.Brush.Color:=clGrayText;
    end;

    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_Deps.btn_DepChargeClick(Sender: TObject);
begin
  if Assigned( F_OnDepWorkBtnClick ) then
    F_OnDepWorkBtnClick(  Sender ) ;
end;

procedure Tfrm_Deps.btn_DepWorkersClick(Sender: TObject);
begin
  if Assigned( F_OnDepWorkersBtnClick ) then
    F_OnDepWorkersBtnClick( Sender );
end;

procedure Tfrm_Deps.EnableChargeBtns(_value: boolean);
begin
  btn_DepCharge.Enabled := _value;
  btn_DepWorkers.Enabled := _value;
end;

procedure Tfrm_Deps.AfterOpenHandler(DataSet: TDataSet);
var
  i, _DepNum: integer;
  _TabCap: string;
begin
  tc_Deps.Tabs.Clear;
  i := 3;

  DataSet.DisableControls;
  DataSet.First;
  while not DataSet.Eof do
  begin
    _DepNum := DataSet.FieldByName('DepNumber').AsInteger;

    if _DepNum = 1 then
      _TabCap := 'Первичный'
    else
    if _DepNum = 2 then
      _TabCap := 'Вторичный'
    else
    begin
      _TabCap := 'N' + IntToStr(i);
      i := i + 1;
    end;

    tc_Deps.Tabs.AddObject( _TabCap, ptr(0) );
    DataSet.Next;
  end;

  DataSet.EnableControls;
end;

procedure Tfrm_Deps.btn_InsertClick(Sender: TObject);
begin
  inherited;
  de_StartDate.SetFocus;

  tc_Deps.Tabs.AddObject( 'Новый', ptr( NEW_TAB ) );
  tc_Deps.TabIndex := tc_Deps.Tabs.Count - 1;
end;

procedure Tfrm_Deps.ds_MainDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if ds_Main.DataSet.State <> dsInsert then
    tc_Deps.TabIndex := ds_Main.DataSet.RecNo - 1;
end;

procedure Tfrm_Deps.btn_DepEquipClick(Sender: TObject);
begin
  if Assigned( F_OnDepEquipBtnClick ) then
    F_OnDepEquipBtnClick( nil );
end;

end.
