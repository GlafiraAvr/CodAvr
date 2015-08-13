unit KolvoOtkazGraphForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeeProcs, TeEngine, Chart, StdCtrls, CheckLst, ExtCtrls, Menus,
  Buttons;

type
  Tfrm_KolvoOtkazGraph = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    chlb_Series: TCheckListBox;
    Chart1: TChart;
    pm_Group: TPopupMenu;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    bb_Exit: TBitBtn;
    bb_print: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure chlb_SeriesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure bb_ExitClick(Sender: TObject);
    procedure bb_printClick(Sender: TObject);
  private
    procedure FillChlbSeries;
    procedure mi1Click(Sender: TObject);
    procedure mi2Click(Sender: TObject);
    procedure EnableGroup(index: integer; value: boolean);
  public
    procedure AddGroup(index: integer; name: string);
  end;


implementation

{$R *.dfm}

uses PrinterWorks;

{ Tfrm_KolvoOtkazGraph }

procedure Tfrm_KolvoOtkazGraph.FillChlbSeries;
var
  i: integer;
begin
  chlb_Series.Clear;
  for i:=0 to Chart1.SeriesCount-1 do
  begin
    chlb_Series.Items.Add(Chart1.Series[i].Title);
    chlb_Series.Checked[i]:=true;
  end;
end;

procedure Tfrm_KolvoOtkazGraph.FormShow(Sender: TObject);
begin
  FillChlbSeries;
  WindowState:=wsMaximized;
  CheckBox1Click(Sender);
end;

procedure Tfrm_KolvoOtkazGraph.chlb_SeriesClick(Sender: TObject);
var
  i: integer;
begin
  chlb_Series.Enabled:=false;
  try
    for i:=0 to Chart1.SeriesCount-1 do
      if chlb_Series.Checked[i]<>Chart1.Series[i].Active then
        Chart1.Series[i].Active:=chlb_Series.Checked[i];
  finally
    Chart1.Repaint;
    chlb_Series.Enabled:=true;
  end;
end;

procedure Tfrm_KolvoOtkazGraph.AddGroup(index: integer; name: string);
var
  mi, smi1, smi2: TMenuItem;
begin
  mi:=TMenuItem.Create(self);
  mi.Caption:=name;
  mi.Tag:=index;

  smi1:=TMenuItem.Create(self);
  smi1.Caption:='Показать все графики';
  smi1.Tag:=index;
  smi1.OnClick:=mi1Click;

  smi2:=TMenuItem.Create(self);
  smi2.Caption:='Спрятать все графики';
  smi2.Tag:=index;
  smi2.OnClick:=mi2Click;

  mi.Add(smi1);
  mi.Add(smi2);

  pm_Group.Items.Add(mi);
end;

procedure Tfrm_KolvoOtkazGraph.mi1Click(Sender: TObject);
begin
  EnableGroup((Sender as TMenuItem).Tag, true);
end;

procedure Tfrm_KolvoOtkazGraph.mi2Click(Sender: TObject);
begin
  EnableGroup((Sender as TMenuItem).Tag, false);
end;

procedure Tfrm_KolvoOtkazGraph.FormCreate(Sender: TObject);
begin
  AddGroup(1, 'Основная');
  AddGroup(2, 'По местам повреждений');
end;

procedure Tfrm_KolvoOtkazGraph.EnableGroup(index: integer; value: boolean);
var
  i: integer;
begin
  chlb_Series.Enabled:=false;

  for i:=0 to Chart1.SeriesCount-1 do
    if Chart1.Series[i].Tag=index then
    begin
      Chart1.Series[i].Active:=value;
      chlb_Series.Checked[i]:=value;
    end;

  chlb_series.Enabled:=true;
end;

procedure Tfrm_KolvoOtkazGraph.CheckBox1Click(Sender: TObject);
var
  i: integer;
  val: boolean;
begin
  val:=CheckBox1.Checked;
  for i:=0 to Chart1.SeriesCount-1 do
    Chart1.Series[i].Marks.Visible:=val;
end;

procedure Tfrm_KolvoOtkazGraph.bb_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_KolvoOtkazGraph.bb_printClick(Sender: TObject);
begin
  TPrintWorks.PrintChartData(Chart1, self);
end;

end.
