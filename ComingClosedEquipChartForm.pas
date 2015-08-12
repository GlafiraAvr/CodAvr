unit ComingClosedEquipChartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnChartForm, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine,
  Chart;

type
  TChartValue=record
    FValue: double;
    FLabel: string;
  end;

  Tfrm_ComingClosedEquipChart = class(Tfrm_Chart)
    btn_Vse: TBitBtn;
    btn_BezVsego: TBitBtn;
    procedure btn_BezVsegoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_VseClick(Sender: TObject);
  private
    F_LastValues: array of TChartValue;
    F_IsBezVsego: boolean;
  public

  end;


implementation

{$R *.dfm}

procedure Tfrm_ComingClosedEquipChart.btn_BezVsegoClick(Sender: TObject);
var
  i: integer;
begin
  if not F_IsBezVsego then
    for i:=0 to ChartSeriesCount-1 do
      ChartSeries[i].Delete(ChartSeries[i].LastValueIndex);

  F_IsBezVsego:=true;
end;

procedure Tfrm_ComingClosedEquipChart.FormShow(Sender: TObject);
var
  i, LastIndex: integer;
begin
  SetLength(F_LastValues, ChartSeriesCount);
  for i:=0 to ChartSeriesCount-1 do
  begin
    LastIndex:=ChartSeries[i].Count-1;
    F_LastValues[i].FValue:=ChartSeries[i].YValue[LastIndex];
    F_LastValues[i].FLabel:=ChartSeries[i].XLabel[LastIndex];
  end;

  F_IsBezVsego:=false;
end;

procedure Tfrm_ComingClosedEquipChart.btn_VseClick(Sender: TObject);
var
  i: integer;
begin
  if F_IsBezVsego then
    for i:=0 to ChartSeriesCount-1 do
      ChartSeries[i].Add(F_LastValues[i].FValue, 'бяецн'{F_LastValues[i].FLabel});

  F_IsBezVsego:=false;
end;

end.
