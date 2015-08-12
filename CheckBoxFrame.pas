unit CheckBoxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls;

type
  Tframe_CheckBox = class(Tframe_Input)
    CheckBox: TCheckBox;
    procedure CheckBoxClick(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
  end;

implementation

{$R *.dfm}

{ Tframe_CheckBox }

function Tframe_CheckBox.GetFieldValue: variant;
begin
  Result := CheckBox.Checked;
end;

procedure Tframe_CheckBox.SetFieldValue(Value: variant);
begin
  CheckBox.Checked := Value;
end;

procedure Tframe_CheckBox.CheckBoxClick(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

end.
