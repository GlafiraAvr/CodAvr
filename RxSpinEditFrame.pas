unit RxSpinEditFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, RXSpin;

type
  Tframe_RxSpinEdit = class(Tframe_Input)
    RxSpinEdit: TRxSpinEdit;
    procedure RxSpinEditChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_RxSpinEdit }

function Tframe_RxSpinEdit.GetFieldValue: variant;
begin
  Result := RxSpinEdit.Value;
end;

procedure Tframe_RxSpinEdit.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := RxSpinEdit.OnChange;
  try
    RxSpinEdit.OnChange := nil;
    RxSpinEdit.Value := Value;
  finally
    RxSpinEdit.OnChange := _OnChange;
  end;
end;

procedure Tframe_RxSpinEdit.RxSpinEditChange(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

end.
