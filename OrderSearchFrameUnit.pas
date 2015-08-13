unit OrderSearchFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, Aligrid;

type
  TOrderSearchFrame = class(TFrame)
    Grid: TStringAlignGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
