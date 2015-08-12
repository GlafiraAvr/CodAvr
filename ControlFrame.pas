unit ControlFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs;

type
  Tframe_Control = class(TFrame)
  private
    F_FieldCaption: string;
    procedure SetMyEnabled(Value: boolean);
  public
    property FieldCaption: string read F_FieldCaption write F_FieldCaption;
    property MyEnabled: boolean write SetMyEnabled;
    procedure MySetFocus; virtual;
  end;

implementation

{$R *.dfm}

{ Tframe_Control }

procedure Tframe_Control.MySetFocus;
begin
//
end;

procedure Tframe_Control.SetMyEnabled(Value: boolean);
var
  i: integer;
begin
  for i:=0 to ControlCount-1 do
    Controls[i].Enabled := Value;
end;

end.
