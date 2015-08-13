unit EditFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls;

type
  Tframe_Edit = class(Tframe_Input)
    Edit1: TEdit;
    procedure Edit1Change(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
  end;


implementation

{$R *.dfm}

{ Tframe_Edit }

function Tframe_Edit.GetFieldValue: variant;
begin
  Result := Edit1.Text;
end;

procedure Tframe_Edit.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := Edit1.OnChange;
  try
    Edit1.OnChange := nil;
    Edit1.Text := String( Value );
  finally
    Edit1.OnChange := _OnChange;
  end;
end;

procedure Tframe_Edit.Edit1Change(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;


end.
