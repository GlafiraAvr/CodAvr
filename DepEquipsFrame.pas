unit DepEquipsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DepChargeBaseFrame, DB, Grids, DBGridEh, ExtCtrls, StdCtrls,
  RxLookup, EquipsVocCacheDModule, DepEquipsDModule;

type
  Tframe_DepEquips = class(Tframe_DepChargeBase)
    dbl_Equips: TRxDBLookupCombo;
    ds_Equips: TDataSource;
    Label1: TLabel;
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
  public
    function IsFieldsCorrect: boolean; override;
    procedure EnableFields( _value: boolean ); override;
  end;


implementation

{$R *.dfm}

{ Tframe_DepEquips }

procedure Tframe_DepEquips.EnableFields(_value: boolean);
begin
  dbl_Equips.Enabled := _value;
  pnl_Fields.Visible := _value;
end;

function Tframe_DepEquips.IsFieldsCorrect: boolean;
begin
  Result := false;

  if trim( dbl_Equips.Text ) = '' then
  begin
    ShowMsg( 'Введите оборудование' );
    dbl_Equips.SetFocus;
    exit;
  end;

  Result := true;
end;

procedure Tframe_DepEquips.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    if ( not F_IsReadOnly ) and
      ( not ds_Main.DataSet.FieldByName( 'clc_IsCanEdit' ).AsBoolean )
    then
      Canvas.Brush.Color := clSilver
    else
      Canvas.Brush.Color := DBGrid.Color;
      
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.
