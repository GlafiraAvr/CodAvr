unit BaseDepChargeDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseEditDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_BaseDepCharge = class(Tdm_BaseEdit)
  protected
    F_OrderID: integer;
    F_DepID: integer;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
    procedure OpenDset; virtual;
  end;

implementation

{$R *.dfm}

{ Tdm_BaseDepCharge }

procedure Tdm_BaseDepCharge.OpenDset;
begin
  inherited;
  dset_Main.ParamByName('pDepID').AsInteger := F_DepID;
  dset_Main.Open;
end;

end.
