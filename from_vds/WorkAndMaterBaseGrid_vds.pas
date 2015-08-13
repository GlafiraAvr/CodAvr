unit WorkAndMaterBaseGrid_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridFrame_vds, DB, IBDatabase, IBCustomDataSet, ExtCtrls,
  Grids, DBGridEh;

type
  Tframe_WorkAndMaterBaseGrid_vds = class(Tframe_BaseGrid_vds)
 protected
    F_OrderID: integer;
    F_DepID: integer;
  protected
    procedure OpenMainDset; override;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
  end;

var
  frame_WorkAndMaterBaseGrid_vds: Tframe_WorkAndMaterBaseGrid_vds;

implementation

{$R *.dfm}

procedure Tframe_WorkAndMaterBaseGrid_vds.OpenMainDset;
begin
  if dset_main.Active then
    dset_main.Close;
  dset_main.ParamByName('pOrderID').AsInteger:=F_OrderID;
  dset_main.ParamByName('pDepID').AsInteger:=F_DepID;
  dset_main.Open;
  end;


end.
