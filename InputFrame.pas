unit InputFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ControlFrame, StdCtrls;

type
  Tframe_Input = class(Tframe_Control)
    lbl_FieldCaption: TLabel;
  protected
    F_OnControlChange: TNotifyEvent;
    F_IsChanged: boolean;
    F_ResetValue: variant;
    F_FieldIndex: integer;
    function GetFieldValue: variant; virtual; abstract;
    procedure SetFieldValue(Value: variant); virtual; abstract;
  public
    procedure OnInputChange(Sender: TObject);
    property FieldValue: variant read GetFieldValue write SetFieldValue;
    property IsChanged: boolean read F_IsChanged write F_IsChanged;
    property ResetValue: variant read F_ResetValue write F_ResetValue;
    property FieldIndex: integer read F_FieldIndex write F_FieldIndex;
    procedure ResetFrame; virtual;
    property OnControlChange: TNotifyEvent read F_OnControlChange
      write F_OnControlChange;
  end;

implementation

{$R *.dfm}

{ Tframe_Input }

procedure Tframe_Input.OnInputChange(Sender: TObject);
begin
  F_IsChanged := true;
end;

procedure Tframe_Input.ResetFrame;
begin
  F_IsChanged := false;
  SetFieldValue( F_ResetValue );
end;

end.
