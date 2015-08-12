unit ChartMarkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnChartForm, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine,
  Chart;

type
  Tfrm_ChartMark = class(Tfrm_Chart)
    btn_Mark: TBitBtn;
    procedure btn_MarkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_IsShowMark: boolean;
    procedure SetIsShowMark(Value: boolean);
  public
    property IsShowMark: boolean read F_IsShowMark write SetIsShowMark;
  end;

var
  frm_ChartMark: Tfrm_ChartMark;

implementation

{$R *.dfm}

procedure Tfrm_ChartMark.SetIsShowMark(Value: boolean);
begin
  F_IsShowMark:=Value;

  if Value then
  begin
    btn_Mark.Caption:='Отключить маркеры';
    ChartSeries[0].Marks.Visible:=true;
  end else
  begin
    btn_Mark.Caption:='Включить маркеры';
    ChartSeries[0].Marks.Visible:=false;
  end;
end;

procedure Tfrm_ChartMark.btn_MarkClick(Sender: TObject);
begin
  IsShowMark:=not IsShowMark;
end;

procedure Tfrm_ChartMark.FormShow(Sender: TObject);
begin
  IsShowMark:=false;
end;

end.
