unit DateEditFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, Mask, ToolEdit;

type
  Tframe_DateEdit = class(Tframe_Input)
    DateEdit: TDateEdit;
    procedure DateEditChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
    procedure MySetFocus; override;
  end;


implementation

{$R *.dfm}

{ Tframe_DateEdit }

function Tframe_DateEdit.GetFieldValue: variant;
begin
  Result := Trunc( DateEdit.Date );
end;

procedure Tframe_DateEdit.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := DateEdit.OnChange;
  try
    DateEdit.OnChange := nil;
    DateEdit.Date := TDateTime( Value );
  finally
    DateEdit.OnChange := _OnChange;
  end;
end;

procedure Tframe_DateEdit.DateEditChange(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

procedure Tframe_DateEdit.MySetFocus;
begin
  DateEdit.SetFocus;
end;

end.
