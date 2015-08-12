unit DepChargeBaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, DB, ExtCtrls;

type
  TProc = procedure of object;
  TProcMsg = procedure(msg: string) of object;

  Tframe_DepChargeBase = class(TFrame)
    DBGrid: TDBGridEh;
    ds_Main: TDataSource;
    pnl_Fields: TPanel;
    procedure ds_MainStateChange(Sender: TObject);
  protected
    F_IsReadOnly: boolean;
    F_BuildEnablesProc: TProc;
    F_ShowMsgProc: TProcMsg;
    procedure ShowMsg( _msg: string );
    procedure SetIsReadOnly(Value: boolean);
  public
    procedure BuildEnables;
    function IsFieldsCorrect: boolean; virtual; abstract;
    procedure EnableFields( _value: boolean ); virtual; abstract;
    procedure EnableGrid( _value: boolean );
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    property BuildEnablesProc: TProc read F_BuildEnablesProc write F_BuildEnablesProc;
    property ShowMsgProc: TProcMsg read F_ShowMsgProc write F_ShowMsgProc;
  end;

implementation

{$R *.dfm}


{ Tframe_DepChargeBase }

procedure Tframe_DepChargeBase.EnableGrid(_value: boolean);
begin
  DBGrid.Enabled := _value;
end;

procedure Tframe_DepChargeBase.ds_MainStateChange(Sender: TObject);
begin
  BuildEnables;
end;

procedure Tframe_DepChargeBase.BuildEnables;
begin
  if Assigned( F_BuildEnablesProc ) then
    F_BuildEnablesProc;
end;

procedure Tframe_DepChargeBase.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := Value;
  BuildEnables;
end;

procedure Tframe_DepChargeBase.ShowMsg(_msg: string);
begin
  if Assigned( F_ShowMsgProc ) then
    F_ShowMsgProc( _msg );
end;

end.
