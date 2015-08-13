unit GridEditDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseEditDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_GridEdit = class(Tdm_BaseEdit)
  protected
    F_OrderID: integer;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    procedure OpenDset; override;
  end;


implementation

{$R *.dfm}

{ Tdm_GridEdit }

procedure Tdm_GridEdit.OpenDset;
begin
  inherited;
  dset_Main.ParamByName('pOrderID').AsInteger := F_OrderID;
  dset_Main.Open;
end;

end.
