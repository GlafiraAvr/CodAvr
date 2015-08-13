unit WorkAndMaterBaseGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridFrame, DB, IBDatabase, IBCustomDataSet, ExtCtrls, Grids,
  DBGridEh;

type
  Tframe_WorkAndMaterBaseGrid = class(Tframe_BaseGrid)
  protected
    F_OrderID: integer;
    F_DepID: integer;
  protected
    procedure OpenMainDset; override;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
  end;


implementation

{$R *.dfm}

{ Tframe_WorkAndMaterBaseGrid }

procedure Tframe_WorkAndMaterBaseGrid.OpenMainDset;
begin
  if dset_main.Active then
    dset_main.Close;
  dset_main.ParamByName('pOrderID').AsInteger:=F_OrderID;
  dset_main.ParamByName('pDepID').AsInteger:=F_DepID;
  dset_main.Open;  
end;

end.
