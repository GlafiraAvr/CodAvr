unit TimeMaskFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, Mask;

type
  Tframe_TimeMask = class(Tframe_Input)
    MaskEdit: TMaskEdit;
    procedure MaskEditChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
    procedure MySetFocus; override;
  end;


implementation

{$R *.dfm}

{ Tframe_TimeMask }

function Tframe_TimeMask.GetFieldValue: variant;
begin
  Result := StrToTime( MaskEdit.Text );
end;

procedure Tframe_TimeMask.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := MaskEdit.OnChange;
  try
    MaskEdit.OnChange := nil;
    MaskEdit.Text := FormatDateTime('hh:mm', Value);
  finally
    MaskEdit.OnChange := _OnChange;
  end;
end;

procedure Tframe_TimeMask.MaskEditChange(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

procedure Tframe_TimeMask.MySetFocus;
begin
  MaskEdit.SetFocus;
end;

end.
