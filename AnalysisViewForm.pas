unit AnalysisViewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, Aligrid, StdCtrls, Buttons, BaseResultForm;

type
  Tfrm_AnalysisView = class(Tfrm_BaseResult)
    pnl_Top: TPanel;
    pnl_Bottom: TPanel;
    Grid: TStringAlignGrid;
    btn_Exit: TBitBtn;
    lbl_Center: TLabel;
    lbl_Left: TLabel;
    pnl_Buttons: TPanel;
    btn_Order: TBitBtn;
    btn_Print: TBitBtn;
    btn_Excel: TBitBtn;
    btn_Graph: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    Bevel1: TBevel;
    Label1: TLabel;
    pnl_Wait: TPanel;
    btn_Close_Z: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
  private
    F_OnF5KeyDown: TNotifyEvent;
    procedure EqualTopPanel;
    procedure EqualBtnPanel;
    procedure EqualBtnPos;
    procedure EqualBtnWidth;

    function GetCenterLabel: string;
    procedure SetCenterLabel(const Value: string);
    function GetLeftLabel1: string;
    procedure SetLeftLabel1(const Value: string);
  public
    property CenterLabel: string read GetCenterLabel write SetCenterLabel;
    property LeftLabel: string read GetLeftLabel1 write SetLeftLabel1;
    procedure ResetForm;
    property OnF5KeyDown: TNotifyEvent read F_OnF5KeyDown write F_OnF5KeyDown;
    constructor Create(AOwner:TComponent; const ATitle: string); overload;
    constructor Create(AOwner:TComponent);overload;
    procedure StartWait; override;
    procedure StopWait; override;
  end;

var
  frm_AnalysisView:Tfrm_AnalysisView;

implementation

{$R *.dfm}

var
  OldColorRow: TColor;
  
{ Tfrm_AnalysisView }

function Tfrm_AnalysisView.GetCenterLabel: string;
begin
  Result:=lbl_Center.Caption;
end;

function Tfrm_AnalysisView.GetLeftLabel1: string;
begin
  Result:=lbl_Left.Caption;
end;


procedure Tfrm_AnalysisView.SetCenterLabel(const Value: string);
begin
  lbl_Center.Visible:=true;
  lbl_Center.Caption:=Value;
end;

procedure Tfrm_AnalysisView.SetLeftLabel1(const Value: string);
begin
  lbl_Left.Visible:=true;
  lbl_Left.Caption:=Value;
end;


procedure Tfrm_AnalysisView.FormShow(Sender: TObject);
begin
  if Assigned(btn_Order.OnClick) then btn_Order.Visible:=true
  else btn_Order.Visible:=false;

  if Assigned(btn_Print.OnClick) then btn_Print.Visible:=true
  else btn_Print.Visible:=false;

  if Assigned(btn_Excel.OnClick) then btn_Excel.Visible:=true
  else btn_Excel.Visible:=false;

  if Assigned(btn_Graph.OnClick) then btn_Graph.Visible:=true
  else btn_Graph.Visible:=false;

  if Assigned(btn_Close_Z.OnClick) then btn_Close_Z.Visible:=true
  else btn_Close_Z.Visible:=false;

  EqualTopPanel;
  EqualBtnPanel;

  WindowState:=wsMaximized;
end;

procedure Tfrm_AnalysisView.ResetForm;
var
  i,j: integer;
begin
  btn_Order.OnClick:=nil;
  btn_Print.OnClick:=nil;
  btn_Excel.OnClick:=nil;
  btn_Graph.OnClick:=nil;
  btn_Close_Z.OnClick:=nil;
  btn_Close_Z.Enabled:=true;

  lbl_Left.Visible:=false;
  lbl_Center.Visible:=false;


  for j:=0 to Grid.RowCount-1 do
  begin
    if Assigned(Grid.Rows[j].Objects[0]) then
      Grid.Rows[j].Objects[0]:=nil;
    for i:=0 to Grid.ColCount-1 do
      Grid.Cells[i,j]:='';
  end;

  Grid.RowHeights[0]:=Grid.DefaultRowHeight;

  Grid.ResetAllCellAll;
  Grid.ResetAllRowAll;
  Grid.ResetAllColAll;
  Grid.ColCount:=1;
  Grid.RowCount:=1;
end;

procedure Tfrm_AnalysisView.EqualTopPanel;
var
  Height: integer;
begin
  Height:=10;
  if lbl_Center.Visible then
    Height:=Height+lbl_Center.Height;
  if lbl_Left.Visible then
    Height:=Height+lbl_Left.Height;

  pnl_Top.Height:=Height;
end;

procedure Tfrm_AnalysisView.EqualBtnPanel;
begin
  pnl_Buttons.BevelOuter:=bvNone;

  EqualBtnWidth;
  EqualBtnPos;
end;

constructor Tfrm_AnalysisView.Create(AOwner:TComponent; const ATitle: string);
begin
  inherited Create(AOwner);
  Caption:=ATitle;
end;

constructor Tfrm_AnalysisView.Create(AOwner: TComponent);
begin
  Create(AOwner, 'Результат поиска');
end;

procedure Tfrm_AnalysisView.GridDblClick(Sender: TObject);
begin
  if (btn_Order.Visible) and (btn_Order.Enabled)
     and Assigned(btn_Order.OnClick) then
    btn_Order.OnClick(Sender);     
end;

procedure Tfrm_AnalysisView.FormCreate(Sender: TObject);
begin
  lbl_Center.Caption:='';
  lbl_Left.Caption:='';

  pnl_Wait.Align:=alClient;
end;

procedure Tfrm_AnalysisView.EqualBtnPos;
const
  SPACE=5;
  LEFT_MARGIN=0;
  TOP_MARGIN=0;
var
  i: integer;
  left_pos: integer;
begin
  left_pos:=LEFT_MARGIN;
  with pnl_Buttons do
  begin
    for i:=0 to ControlCount-1 do
      if Controls[i] is TBitBtn then
        if (Controls[i] as TBitBtn).Visible then
        begin
          (Controls[i] as TBitBtn).Left:=left_pos;
          (Controls[i] as TBitBtn).Top:=TOP_MARGIN;
          left_pos:=left_pos+(Controls[i] as TBitBtn).Width+SPACE;
        end;
  end;  // end with
end;

procedure Tfrm_AnalysisView.EqualBtnWidth;
  function get_add_width(width: integer): integer;
  const
    PERCENT=30;
  begin
    Result:=trunc((width/100)*PERCENT);
  end;
const
  ADD_WIDTH=30;
var
  i, text_width: integer;
begin
  for i:=0 to pnl_Buttons.ControlCount-1 do
    if pnl_Buttons.Controls[i] is TBitBtn then
      if (pnl_Buttons.Controls[i] as TBitBtn).Visible then
      begin
        text_width:=Canvas.TextWidth((pnl_Buttons.Controls[i] as TBitBtn).Caption);
        (pnl_Buttons.Controls[i] as TBitBtn).Width:=text_width+get_add_width(text_width)+ADD_WIDTH;
      end;
end;

procedure Tfrm_AnalysisView.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key=VK_F5) and Assigned(F_OnF5KeyDown) then
    F_OnF5KeyDown(Sender) else
 if Key=VK_RETURN then
    GridDblClick(Sender);
end;

procedure Tfrm_AnalysisView.GridSelectCell(Sender: TObject; ACol,
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

procedure Tfrm_AnalysisView.GridEnter(Sender: TObject);
begin
  with Sender as TStringAlignGrid do
  begin
    OldColorRow:=ColorRow[Row];
  end;
end;

procedure Tfrm_AnalysisView.GridExit(Sender: TObject);
begin
  with Sender as TStringAlignGrid do
  begin
    ColorRow[Row]:=OldColorRow;
  end;
end;

procedure Tfrm_AnalysisView.StartWait;
begin
  pnl_Wait.Visible:=true;
  Application.ProcessMessages;
end;

procedure Tfrm_AnalysisView.StopWait;
begin
  pnl_Wait.Visible:=false;
  Application.ProcessMessages;
end;

end.
