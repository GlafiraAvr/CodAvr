unit LeakDiamChartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnChartForm, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine,
  Chart;

type
  Tfrm_LeakDiamChart = class(Tfrm_Chart)
    btn_count: TButton;
    btn_percent: TButton;
    procedure btn_countClick(Sender: TObject);
    procedure btn_percentClick(Sender: TObject);
  private
    procedure ActivValSeries(val: boolean);
  public
  end;


implementation

{$R *.dfm}

procedure Tfrm_LeakDiamChart.ActivValSeries(val: boolean);
var
  i, count: integer;
begin
  count:=ChartSeriesCount;
  for i:=0 to count-2 do
    ChartSeries[i].Active:=val;
  ChartSeries[count-1].Active:=not val;
end;

procedure Tfrm_LeakDiamChart.btn_countClick(Sender: TObject);
begin
  ActivValSeries(true);
end;

procedure Tfrm_LeakDiamChart.btn_percentClick(Sender: TObject);
begin
  ActivValSeries(false);
end;

end.
