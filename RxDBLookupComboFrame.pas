unit RxDBLookupComboFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, RxLookup;

type
  Tframe_RxDBLookupCombo = class(Tframe_Input)
    dbl: TRxDBLookupCombo;
    procedure dblChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
    procedure MySetFocus; override;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_RxDBLookupCombo }

function Tframe_RxDBLookupCombo.GetFieldValue: variant;
begin
  Result := dbl.LookupSource.DataSet.FieldByName(dbl.LookupField).Value;
end;

procedure Tframe_RxDBLookupCombo.SetFieldValue(Value: variant);
var
  _OnChange: TNotifyEvent;
begin
  _OnChange := dbl.OnChange;
  try
    dbl.OnChange := nil;
    FixDBLValue( Integer( Value ), dbl );
  finally
    dbl.OnChange := _OnChange;
  end;
end;

procedure Tframe_RxDBLookupCombo.dblChange(Sender: TObject);
begin
  if Assigned( F_OnControlChange ) then
    F_OnControlChange( Sender );
  OnInputChange( Sender );
end;

procedure Tframe_RxDBLookupCombo.MySetFocus;
begin
  dbl.SetFocus;
end;

end.
