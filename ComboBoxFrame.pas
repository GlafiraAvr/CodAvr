unit ComboBoxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls;

type
  Tframe_ComboBox = class(Tframe_Input)
    ComboBox: TComboBox;
    procedure ComboBoxChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_ComboBox }

function Tframe_ComboBox.GetFieldValue: variant;
begin
  Result := ComboBox.ItemIndex;
end;

procedure Tframe_ComboBox.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := ComboBox.OnChange;
  try
    ComboBox.OnChange := nil;
    ComboBox.ItemIndex := Integer(Value);
  finally
    ComboBox.OnChange := _OnChange;
  end;
end;

procedure Tframe_ComboBox.ComboBoxChange(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

end.
