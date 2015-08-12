unit DBDateTimeEditFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InputFrame, StdCtrls, Mask, DBCtrlsEh;

type
  Tframe_DBDateTimeEdit = class(Tframe_Input)
    DBDateTimeEditEh: TDBDateTimeEditEh;
    procedure DBDateTimeEditEhChange(Sender: TObject);
  private
    function GetFieldValue: variant; override;
    procedure SetFieldValue(Value: variant); override;
  public
    procedure OnChange(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ Tframe_DBDateTimeEdit }

function Tframe_DBDateTimeEdit.GetFieldValue: variant;
begin
  Result := DBDateTimeEditEh.Value;
end;

procedure Tframe_DBDateTimeEdit.OnChange(Sender: TObject);
begin
  OnInputChange( Sender );
end;

procedure Tframe_DBDateTimeEdit.SetFieldValue(Value: variant);
begin
  DBDateTimeEditEh.Value := Value;
end;

procedure Tframe_DBDateTimeEdit.DBDateTimeEditEhChange(Sender: TObject);
begin
  OnChange( Sender );
end;

end.
