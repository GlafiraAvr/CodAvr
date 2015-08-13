unit e;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid_vds, RxLookup, StdCtrls, DB, IBDatabase,
  IBCustomDataSet, ExtCtrls, Grids, DBGridEh;

type
  Tframe_EquipGrid = class(Tframe_WorkAndMaterBaseGrid_vds)
    Label1: TLabel;
    dbl_Equip: TRxDBLookupCombo;
    dset_Equip: TIBDataSet;
    ds_Equip: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frame_EquipGrid: Tframe_EquipGrid;

implementation

{$R *.dfm}

end.
