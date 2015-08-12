unit DBDateEditFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, Mask, ToolEdit, RXDBCtrl;

type
  Tframe_DBDateEdit = class(Tframe_Input)
    DBDateEdit: TDBDateEdit;
    procedure DBDateEditChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
    procedure OnChange(Sender: TObject);
  end;


implementation

{$R *.dfm}

{ Tframe_DBDateEdit }

function Tframe_DBDateEdit.GetFieldValue: variant;
begin
  Result := DBDateEdit.Date;
end;

procedure Tframe_DBDateEdit.OnChange(Sender: TObject);
begin
  OnInputChange( Sender );
end;

procedure Tframe_DBDateEdit.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := DBDateEdit.OnChange;
  try
    DBDateEdit.OnChange := nil;
    DBDateEdit.Date := Value;
  finally
    DBDateEdit.OnChange := _OnChange;
  end;
end;

procedure Tframe_DBDateEdit.DBDateEditChange(Sender: TObject);
begin
  OnChange( Sender );
end;

end.
