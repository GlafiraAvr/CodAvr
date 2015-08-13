unit SubOrderGridForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SubOrderDModule, Grids, DBGridEh, DB, ExtCtrls, DBCtrls,
  StdCtrls, Buttons, Menus, IBCustomDataSet, ComCtrls, HelpClasses, Search1562DModule,
  Spisok1562_FrameUnit;

type
  TOnShowSOForm = procedure (var _IsOk: boolean ) of object;
  TOnChangeShowMode = procedure ( _ShowMode: TSubOrderShowMode ) of object;

  Tfrm_SubOrderGrid = class(TForm)
    ds_Main: TDataSource;
    pnl_Top: TPanel;
    pnl_Navig: TPanel;
    sb_Add: TSpeedButton;
    sb_Del: TSpeedButton;
    MainMenu1: TMainMenu;
    mi_View: TMenuItem;
    mi_ShowCheck: TMenuItem;
    mi_Exit: TMenuItem;
    mi_Action: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    sb_Post: TSpeedButton;
    mi_ShowAll: TMenuItem;
    mi_ShowCheckAndFree: TMenuItem;
    btn_Attach: TBitBtn;
    StatusBar1: TStatusBar;
    Spisok1562_Frame1: TSpisok1562_Frame;
    procedure GridDblClick(Sender: TObject);
    procedure sb_AddClick(Sender: TObject);
    procedure sb_DelClick(Sender: TObject);
    procedure mi_ShowCheckClick(Sender: TObject);
    procedure mi_ExitClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N3Click(Sender: TObject);
    procedure sb_PostClick(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn_AttachClick(Sender: TObject);
  private
    F_OnShowSOFrm: TOnShowSOForm;
    F_OnChangeShowMode: TOnChangeShowMode;
    F_IsReadOnly: boolean;
    F_IsAttached: TIsAttached;
    F_ChangeAttachState: TChangeAttachState;
    F_OnAttach: TNotifyEvent;
    function _IsAttached( _id_suborder: integer ): boolean;
    procedure _ChangeAttachState( _id_suborder: integer );
    function ShowSOFrm: boolean;
    procedure ChangeShowMode( _NewShowMode: TSubOrderShowMode );
    procedure Add;
    procedure Delete;
    procedure Post;
    procedure Edit;
    procedure SelectMode;
    procedure SetIsExtended( Value: boolean );
    procedure SetIsReadOnly(Value: boolean);
  public
    property OnShowSOFrm: TOnShowSOForm read F_OnShowSOFrm write F_OnShowSOFrm;
    property OnChangeShowMode: TOnChangeShowMode read F_OnChangeShowMode
      write F_OnChangeShowMode;
    property IsExtended: boolean write SetIsExtended;
    property IsReadOnly: boolean write SetIsReadOnly;
    property IsAttached: TIsAttached read F_IsAttached write F_IsAttached;
    property OnAttach: TNotifyEvent read F_OnAttach write F_OnAttach;
    property ChangeAttachState: TChangeAttachState read F_ChangeAttachState
      write F_ChangeAttachState;
    procedure OnChangeAttachCountHandler( _AttachCount: integer );
    procedure ShowMsg( _msg: string );
  end;


implementation

{$R *.dfm}

function Tfrm_SubOrderGrid.ShowSOFrm: boolean;
begin
  if Assigned( F_OnShowSOFrm ) then
    F_OnShowSOFrm( Result );
end;

procedure Tfrm_SubOrderGrid.GridDblClick(Sender: TObject);
begin
  if F_IsReadOnly then
    ShowSOFrm
  else
    Edit;
end;

procedure Tfrm_SubOrderGrid.sb_AddClick(Sender: TObject);
begin
  Add;
end;

procedure Tfrm_SubOrderGrid.sb_DelClick(Sender: TObject);
begin
  Delete;
end;

procedure Tfrm_SubOrderGrid.mi_ShowCheckClick(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to mi_View.Count-1 do
    mi_View.Items[ i ].Checked := false;

  ( Sender as TMenuItem ).Checked := true;

  SelectMode;
end;

procedure Tfrm_SubOrderGrid.mi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SubOrderGrid.Add;
begin
  ds_Main.DataSet.Insert;
  if ShowSOFrm and (ds_Main.State in [dsInsert, dsEdit]) then
  begin
    ds_Main.DataSet.Post;
  end
  else
    ds_Main.DataSet.Cancel;
end;

procedure Tfrm_SubOrderGrid.Delete;
begin
  if (not ds_Main.DataSet.IsEmpty ) and 
    ( Application.MessageBox( 'Вы уверены, что хотите удалить запись?',
    'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES ) then
    ds_Main.DataSet.Delete;
end;

procedure Tfrm_SubOrderGrid.ChangeShowMode(
  _NewShowMode: TSubOrderShowMode);
begin
  if Assigned( F_OnChangeShowMode ) then
    F_OnChangeShowMode( _NewShowMode );
end;

procedure Tfrm_SubOrderGrid.SelectMode;
var
  _mode: TSubOrderShowMode;
begin
  if mi_ShowAll.Checked then
    _mode := smAllWithChecking else
  if mi_ShowCheck.Checked then
    _mode := smOnlyChecked else
  if mi_ShowCheckAndFree.Checked then
    _mode := smCheckedAndFree;

  ChangeShowMode( _mode );
end;

procedure Tfrm_SubOrderGrid.SetIsExtended(Value: boolean);
begin
  Spisok1562_Frame1.Grid.Columns[0].Visible := Value;
  mi_View.Visible := Value;
  btn_Attach.Visible := not Value;
end;

procedure Tfrm_SubOrderGrid.N1Click(Sender: TObject);
begin
  Add;
end;

procedure Tfrm_SubOrderGrid.N2Click(Sender: TObject);
begin
  Delete;
end;

procedure Tfrm_SubOrderGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Post;
end;

procedure Tfrm_SubOrderGrid.N3Click(Sender: TObject);
begin
  Edit;
end;

procedure Tfrm_SubOrderGrid.Post;
begin
  if ds_Main.State in [dsInsert, dsEdit] then
    ds_Main.DataSet.Post;
end;

procedure Tfrm_SubOrderGrid.sb_PostClick(Sender: TObject);
begin
  Post;
end;

procedure Tfrm_SubOrderGrid.Edit;
begin
  ds_Main.Edit;
  if ShowSOFrm and (ds_Main.State in [dsInsert, dsEdit]) then ds_Main.DataSet.Post
  else ds_Main.DataSet.Cancel;
end;

procedure Tfrm_SubOrderGrid.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    {
    if ( not ds_Main.DataSet.FieldByName('id_order').IsNull ) and
    ( ds_Main.DataSet.FieldByName('id_order').AsInteger <> -1 ) then
    }

  ///  if ds_Main.DataSet.FieldByName( 'IsALIEN' ).AsBoolean then
  ///    Canvas.Brush.Color := clGrayText;

  ///  if _IsAttached( ds_Main.DataSet.FieldByName( 'ID' ).AsInteger ) then
  ///    Canvas.Brush.Color := clYellow;

    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_SubOrderGrid.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := Value;

  sb_Add.Enabled := not Value;
  sb_Del.Enabled := not Value;
  sb_Post.Enabled := not Value;
  btn_Attach.Enabled := not Value;

  Spisok1562_Frame1.Grid.Columns[0].ReadOnly := Value;

  mi_Action.Enabled := not Value;
end;

function Tfrm_SubOrderGrid._IsAttached(_id_suborder: integer): boolean;
begin
  if Assigned( F_IsAttached ) then
    F_IsAttached( _id_suborder, Result );
end;

procedure Tfrm_SubOrderGrid._ChangeAttachState(_id_suborder: integer);
begin
  if Assigned( F_ChangeAttachState ) then
    F_ChangeAttachState( _id_Suborder );
end;

procedure Tfrm_SubOrderGrid.GridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ( Button = mbLeft ) and ( ssShift in Shift  ) then
  begin
    _ChangeAttachState( ds_Main.DataSet.FieldByName( 'ID' ).AsInteger );
    Spisok1562_Frame1.Grid.Refresh;
  end;
end;

procedure Tfrm_SubOrderGrid.OnChangeAttachCountHandler(
  _AttachCount: integer);
begin
  if _AttachCount > 0 then
    ShowMsg( 'Для привязки выбрано ' + IntToStr( _AttachCount ) + ' записи' )
  else
    ShowMsg('');
end;

procedure Tfrm_SubOrderGrid.ShowMsg(_msg: string);
begin
  StatusBar1.SimpleText := _msg;
end;

procedure Tfrm_SubOrderGrid.btn_AttachClick(Sender: TObject);
begin
  if Assigned( F_OnAttach ) then
    F_OnAttach( Sender );
end;

end.
