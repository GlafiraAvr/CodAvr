unit UnChartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine, Chart, Series;

type
  TSeriesType=(stLine, stBar, stPie);


  Tfrm_Chart = class(TForm)
    Chart: TChart;
    pnl_Bottom: TPanel;
    btn_exit: TBitBtn;
    btn_Print: TBitBtn;
    procedure btn_exitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_PrintClick(Sender: TObject);
  private
    F_ChartSeries: array of TChartSeries;
    function GetChartSeries(Index: integer):TChartSeries;
    procedure FreeChartSeries;
  public
    property ChartSeries[Index: integer]: TChartSeries read GetChartSeries;
    constructor Create(AOwner: TComponent; Title: string='');
    procedure AddChartSeries(SeriesType: TSeriesType);
    function ChartSeriesCount: integer;
  end;

implementation

{$R *.dfm}

uses PrinterWorks;

procedure Tfrm_Chart.btn_exitClick(Sender: TObject);
begin
  Close;
end;

constructor Tfrm_Chart.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_Chart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeChartSeries;
  Action:=caFree;
end;

procedure Tfrm_Chart.btn_PrintClick(Sender: TObject);
begin
  TPrintWorks.PrintChartData(Chart, self);
end;

function Tfrm_Chart.GetChartSeries(Index: integer): TChartSeries;
var
  len: integer;
begin
  len:=Length(F_ChartSeries);

  if (Index<0) or (Index>len-1) then
    Raise Exception.Create('Выход за пределы массива F_ChartSeries');

  Result:=F_ChartSeries[Index];
end;

procedure Tfrm_Chart.FreeChartSeries;
var
  i: integer;
begin
  for i:=low(F_ChartSeries) to High(F_ChartSeries) do
    F_ChartSeries[i].Free;
end;

procedure Tfrm_Chart.AddChartSeries(SeriesType: TSeriesType);
var
  len: integer;
begin
  len:=Length(F_ChartSeries);
  SetLength(F_ChartSeries, len+1);
  case SeriesType of
    stLine: F_ChartSeries[len]:=TLineSeries.Create(self);
    stBar: F_ChartSeries[len]:=TBarSeries.Create(self);
    stPie: F_ChartSeries[len]:=TPieSeries.Create(self);
  end;
  F_ChartSeries[len].ParentChart:=Chart;
end;

function Tfrm_Chart.ChartSeriesCount: integer;
begin
  Result:=length(F_ChartSeries);
end;

end.
