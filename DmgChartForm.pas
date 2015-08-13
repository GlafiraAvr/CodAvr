unit DmgChartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, StdCtrls, Buttons, CheckLst,
  Series, RXCtrls;

type
  TSeriesType=(stLine, stBar, stPie);

  Tfrm_DmgChart = class(TForm)
    Chart: TChart;
    pnl_Bottom: TPanel;
    grb_Control: TGroupBox;
    btn_Line: TSpeedButton;
    btn_Bar: TSpeedButton;
    btn_Pie: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    chlb_DmgPlace: TRxCheckListBox;
    chb_Marks: TCheckBox;
    chb_Legend: TCheckBox;
    btn_Setting: TBitBtn;
    btn_Print: TBitBtn;
    btn_Exit: TBitBtn;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_LineClick(Sender: TObject);
    procedure chlb_DmgPlaceClick(Sender: TObject);
    procedure chb_MarksClick(Sender: TObject);
    procedure chb_LegendClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SettingClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
  private
    F_RegDmgList: TList;
    F_ChartSeries: array [0..5] of TChartSeries;
    F_SeriesType: TSeriesType;

    procedure BuildChart;
    procedure InitChart;
    procedure LoadData;
    procedure InitSelectList;
    procedure FreeSeries;
  public

    constructor Create(AOwner: TComponent; ATitle: string; ARegDmgList: TList);
  end;


implementation

{$R *.dfm}

uses RegionDamageCount, DmgChartSettingForm, PrinterWorks;

procedure Tfrm_DmgChart.BuildChart;
begin
  InitChart;
  InitSelectList;
  LoadData;
  chlb_DmgPlaceClick(nil);
  chb_MarksClick(nil);
  chb_LegendClick(nil);
end;

constructor Tfrm_DmgChart.Create(AOwner: TComponent; ATitle: string; ARegDmgList: TList);
var
  p: integer;
begin
  inherited Create(AOwner);
  F_RegDmgList:=ARegDmgList;
  Chart.Title.Text.Clear;

  p:=pos(#13, ATitle);
  Chart.Title.Text.Add(copy(Atitle, 0, p-1));
  Chart.Title.Text.Add(copy(ATitle, p+1, length(ATitle)-p+1));
end;

procedure Tfrm_DmgChart.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeSeries;
  Action:=caFree;
end;

procedure Tfrm_DmgChart.btn_LineClick(Sender: TObject);
begin
  if (Sender=nil) or ((Sender as TSpeedButton).Tag=111) then
    F_SeriesType:=stLine else
  if (Sender as TSpeedButton).Tag=222 then
    F_SeriesType:=stBar else
  if (Sender as TSpeedButton).Tag=333 then
    F_SeriesType:=stPie else exit;

  BuildChart;
end;

procedure Tfrm_DmgChart.InitChart;
var
  i: integer;
begin
  Chart.RemoveAllSeries;
  FreeSeries;

  for i:=0 to 5 do
  begin
    case F_SeriesType of
      stLine: F_ChartSeries[i]:=TLineSeries.Create(self);
      stBar: F_ChartSeries[i]:=TBarSeries.Create(self);
      stPie: F_ChartSeries[i]:=TPieSeries.Create(self);
    end;
    F_ChartSeries[i].ParentChart:=Chart;
    F_ChartSeries[i].Marks.Style:=smsValue;
  end;

  F_ChartSeries[0].Title:='Трещина';
  F_ChartSeries[1].Title:='Перелом';
  F_ChartSeries[2].Title:='Стык соединения';
  F_ChartSeries[3].Title:='Свищ';
  F_ChartSeries[4].Title:='Прочее';
  F_ChartSeries[5].Title:='Итого';

  if (F_SeriesType=stLine) or (F_SeriesType=stBar) then
  begin
    Chart.BottomAxis.Visible:=true;
    Chart.LeftAxis.Visible:=true;
  end else
  begin
    Chart.BottomAxis.Visible:=false;
    Chart.LeftAxis.Visible:=false;
  end;
end;

procedure Tfrm_DmgChart.FreeSeries;
var
  i: integer;
begin
  for i:=low(F_ChartSeries) to high(F_ChartSeries) do
    F_ChartSeries[i].Free;
end;

procedure Tfrm_DmgChart.LoadData;
var
  i, j: integer;
  pRegDmg: TPRegDmg;
begin
  for i:=0 to F_RegDmgList.Count-2 do
  begin
    pRegDmg:=TPRegDmg(F_RegDmgList.Items[i]);
    for j:=0 to 4 do
    begin
      F_ChartSeries[j].Add(pRegDmg.RegDmgArr[j+1], copy(pRegDmg.Name,1,5));
    end;
    F_ChartSeries[5].Add(pRegDmg.Total, copy(pRegDmg.Name,1,5));  //Итого
  end;
end;

procedure Tfrm_DmgChart.InitSelectList;
var
  i: integer;
begin
  chlb_DmgPlace.Clear;
  for i:=low(F_ChartSeries) to high(F_ChartSeries) do
    chlb_DmgPlace.Items.Add(F_ChartSeries[i].Title);

  case F_SeriesType of
    stLine, stBar:
      begin
        chlb_DmgPlace.CheckKind:=ckCheckBoxes;
        for i:=0 to chlb_DmgPlace.Items.Count-1 do
          chlb_DmgPlace.Checked[i]:=true;
      end;
    stPie:
      begin
        chlb_DmgPlace.CheckKind:=ckRadioButtons;
          chlb_DmgPlace.ItemIndex:=0;
      end;
  end;

end;

procedure Tfrm_DmgChart.chlb_DmgPlaceClick(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to chlb_DmgPlace.Items.Count-1 do
    if chlb_dmgPlace.Checked[i] then
      F_ChartSeries[i].Active:=true
    else
      F_ChartSeries[i].Active:=false;
end;

procedure Tfrm_DmgChart.chb_MarksClick(Sender: TObject);
var
  i: integer;
begin
  for i:=low(F_ChartSeries) to High(F_ChartSeries) do
    F_ChartSeries[i].Marks.Visible:=chb_Marks.Checked;
end;

procedure Tfrm_DmgChart.chb_LegendClick(Sender: TObject);
begin
  Chart.Legend.Visible:=chb_Legend.Checked;
end;

procedure Tfrm_DmgChart.FormShow(Sender: TObject);
begin
  btn_LineClick(nil);
end;

procedure Tfrm_DmgChart.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DmgChart.btn_SettingClick(Sender: TObject);
var
  frm_Setting: Tfrm_DmgChartSetting;
begin
  frm_Setting:=Tfrm_DmgChartSetting.Create(nil, self);
  frm_Setting.ShowModal;
end;

procedure Tfrm_DmgChart.btn_PrintClick(Sender: TObject);
begin
  TPrintWorks.PrintChartData(Chart, self);
end;

end.
