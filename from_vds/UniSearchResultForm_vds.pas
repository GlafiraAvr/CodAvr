unit UniSearchResultForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, ExtCtrls, Grids, Aligrid, StdCtrls, Buttons;

type
  Tfrm_UniSearchResult = class(Tfrm_BaseResult)
    Grid: TStringAlignGrid;
    pnl_btns: TPanel;
    btn_Order: TBitBtn;
    pnl_RegInfo: TPanel;
    lbl_RegionName: TLabel;
    lbl_DmgCount: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btn_Print: TBitBtn;
    btn_Exit: TBitBtn;
    procedure GridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
  private
    procedure SetRegion(const Value: string);
    procedure SetDmgCount(const Value: integer);
  public
    property Region: string write SetRegion;
    property DmgCount: integer write SetDmgCount;
  end;


implementation

{$R *.dfm}

var
  OldColorRow: TColor;


{ Tfrm_UniSearchResult }


procedure Tfrm_UniSearchResult.SetRegion(const Value: string);
begin
  lbl_RegionName.Caption:=Value;
end;

procedure Tfrm_UniSearchResult.SetDmgCount(const Value: integer);
begin
  lbl_DmgCount.Caption:=IntToStr(Value);
end;

procedure Tfrm_UniSearchResult.GridDblClick(Sender: TObject);
begin
  if (btn_Order.Visible) and (btn_Order.Enabled)
     and Assigned(btn_Order.OnClick) then
    btn_Order.OnClick(Sender);     
end;

procedure Tfrm_UniSearchResult.FormShow(Sender: TObject);
begin
  inherited;
  WindowState:=wsMaximized;
  if Assigned(Grid.OnClick) then Grid.OnClick(nil);
end;

procedure Tfrm_UniSearchResult.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_UniSearchResult.GridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  with Sender as TStringAlignGrid do
  begin
    if Row<>ARow then
    begin
      ColorRow[Row]:=OldColorRow;
      OldColorRow:=ColorRow[ARow];
      ColorRow[ARow]:=clLime;
    end;
  end;
end;

procedure Tfrm_UniSearchResult.GridEnter(Sender: TObject);
begin
  with Sender as TStringAlignGrid do
  begin
    OldColorRow:=ColorRow[Row];
  end;
end;

procedure Tfrm_UniSearchResult.GridExit(Sender: TObject);
begin
  with Sender as TStringAlignGrid do
  begin
    ColorRow[Row]:=OldColorRow;
  end;
end;

end.
