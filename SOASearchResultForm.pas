unit SOASearchResultForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, SOAttacheDModule, Grids, DBGridEh, StdCtrls, Buttons,
  ExtCtrls, HelpClasses, ComCtrls;

type
  Tfrm_SOASearchRes = class(TForm)
    ds_Search: TDataSource;
    Grid: TDBGridEh;
    Panel1: TPanel;
    btn_Exit: TBitBtn;
    btn_Attach: TBitBtn;
    btn_AddToCache: TBitBtn;
    StatusBar1: TStatusBar;
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_AddToCacheClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_AttachClick(Sender: TObject);
  private
    F_IsReadOnly: boolean;
    F_IsAttachedToCache: TIsAttached;
    F_ChangeAttachToCacheState: TChangeAttachState;
    F_OnAddSelOrdersToCache: TNotifyEvent;
    procedure _ChangeAttachState( _id_order: integer );
    function _IsAttached( _id_order: integer ): boolean;
    procedure ShowMsg( _msg: string );
  public
    property IsAttachedToCache: TIsAttached read F_IsAttachedToCache
      write F_IsAttachedToCache;
    property ChangeAttachToCacheState: TChangeAttachState read F_ChangeAttachToCacheState
      write F_ChangeAttachToCacheState;
    property OnAddSelOrdersToCache: TNotifyEvent read F_OnAddSelOrdersToCache
      write F_OnAddSelOrdersToCache;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    procedure OnChangeAttachedToCacheCountHandler( _AttachCount: integer );
  end;


implementation

{$R *.dfm}

procedure Tfrm_SOASearchRes.GridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ( Button = mbLeft ) and ( ssShift in Shift  ) then
  begin
    _ChangeAttachState( ds_Search.DataSet.FieldByName( 'ID' ).AsInteger );
    Grid.Refresh;
  end;
end;

procedure Tfrm_SOASearchRes._ChangeAttachState(_id_order: integer);
begin
  if Assigned( F_ChangeAttachToCacheState ) then
    F_ChangeAttachToCacheState( _id_order );
end;

procedure Tfrm_SOASearchRes.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    if _IsAttached( ds_Search.DataSet.FieldByName( 'ID' ).AsInteger ) then
      Canvas.Brush.Color := clYellow;

    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

function Tfrm_SOASearchRes._IsAttached(_id_order: integer): boolean;
begin
  if Assigned( F_IsAttachedToCache ) then
    F_IsAttachedToCache( _id_order, Result );
end;

procedure Tfrm_SOASearchRes.btn_AddToCacheClick(Sender: TObject);
begin
  if Assigned( F_OnAddSelOrdersToCache ) then
    F_OnAddSelOrdersToCache( nil );
  Grid.Refresh;
  ShowMsg( '' );
end;

procedure Tfrm_SOASearchRes.OnChangeAttachedToCacheCountHandler(
  _AttachCount: integer);
begin
  if _AttachCount >0 then
    ShowMsg( Format( 'Выделено %d записи', [ _AttachCount ] ) )
  else
    ShowMsg( '' );
end;

procedure Tfrm_SOASearchRes.FormCreate(Sender: TObject);
begin
  F_IsReadOnly := false;
end;

procedure Tfrm_SOASearchRes.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SOASearchRes.ShowMsg(_msg: string);
begin
  StatusBar1.SimpleText := _msg;
end;

procedure Tfrm_SOASearchRes.btn_AttachClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
