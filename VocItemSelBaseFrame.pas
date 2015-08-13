unit VocItemSelBaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs;

type
  Tframe_VocItemSelBase = class(TFrame)
  protected
    F_OnSelChange: TNotifyEvent;
  public
    procedure Reset; virtual;
    property OnSelChange: TNotifyEvent read F_OnSelChange write F_OnSelChange;
  end;

implementation

{$R *.dfm}

{ Tframe_VocItemSelBase }

procedure Tframe_VocItemSelBase.Reset;
begin
//
end;

end.
