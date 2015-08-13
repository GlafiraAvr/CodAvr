unit UniSearchResultForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, ExtCtrls, Grids, Aligrid, StdCtrls, Buttons;

type
  Tfrm_UniSearchResult = class(Tfrm_BaseResult)
    pnl_LeakInfo: TPanel;
    pnl_btns: TPanel;
    Label1: TLabel;
    lbl_SumLeak: TLabel;
    btn_Order: TBitBtn;
    lbl_RegionLeak: TLabel;
    pnl_RegInfo: TPanel;
    lbl_RegionName: TLabel;
    lbl_DmgCount: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chk_IsPrintAddInfo: TCheckBox;
    btn_Print: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Map: TBitBtn;
    pnl_Wait: TPanel;
    Grid: TStringAlignGrid;
    procedure GridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetSumLeak(const Value: double);
    procedure SetRegion(const Value: string);
    procedure SetDmgCount(const Value: integer);
    procedure SetRegionLeak(const Value: double);
    procedure SetIsShowLeakInfo(const Value: boolean);
    function GetIsPrintAddInfo: boolean;
  public
    property SumLeak: double  write SetSumLeak;
    property RegionLeak: double write SetRegionLeak;
    property Region: string write SetRegion;
    property DmgCount: integer write SetDmgCount;
    property IsShowLeakInfo: boolean write SetIsShowLeakInfo;
    property IsPrintAddInfo: boolean read GetIsPrintAddInfo;
    procedure StartWait; override;
    procedure StopWait; override;
  end;


implementation

{$R *.dfm}

var
  OldColorRow: TColor;


{ Tfrm_UniSearchResult }

procedure Tfrm_UniSearchResult.SetSumLeak(const Value: double);
begin
  lbl_SumLeak.Caption:=FormatFloat('0.##', Value);
end;

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

procedure Tfrm_UniSearchResult.SetRegionLeak(const Value: double);                        
begin
  lbl_RegionLeak.Caption:=FormatFloat('0.##', Value);
end;

procedure Tfrm_UniSearchResult.SetIsShowLeakInfo(const Value: boolean);
begin
  pnl_LeakInfo.Visible:=Value;
end;

procedure Tfrm_UniSearchResult.FormShow(Sender: TObject);
begin
  inherited;
  btn_Map.Visible:=Assigned(btn_Map.OnClick);
  WindowState:=wsMaximized;
  chk_IsPrintAddInfo.Checked:=false;
  if Assigned(Grid.OnClick) then Grid.OnClick(nil);
end;

function Tfrm_UniSearchResult.GetIsPrintAddInfo: boolean;
begin
  Result:=chk_IsPrintAddInfo.Checked;
end;

procedure Tfrm_UniSearchResult.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_UniSearchResult.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key=VK_F5) or (Key=VK_RETURN) then
    GridDblClick(Sender);
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

procedure Tfrm_UniSearchResult.StartWait;
begin
  pnl_Wait.Visible:=true;
  Application.ProcessMessages;
end;

procedure Tfrm_UniSearchResult.StopWait;
begin
  pnl_Wait.Visible:=false;
  Application.ProcessMessages;
end;

procedure Tfrm_UniSearchResult.FormCreate(Sender: TObject);
begin
  inherited;
  pnl_Wait.Align:=alClient;
end;

end.
