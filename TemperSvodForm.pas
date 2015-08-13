unit TemperSvodForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, Mask, ToolEdit, DB,
  IBCustomDataSet, DModule, ExcelWorksForm, TeeProcs, TeEngine, Chart;

type
  Tfrm_TemperSvod = class(TForm)
    pnl_Top: TPanel;
    pnl_Bottom: TPanel;
    dbg_Grid: TDBGrid;
    btn_ok: TBitBtn;
    btn_Graph: TBitBtn;
    btn_Excel: TBitBtn;
    btn_Exit: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    dset_Temper: TIBDataSet;
    ds_Temper: TDataSource;
    dset_TemperTEMPDATE: TDateTimeField;
    dset_TemperTEMPERATURE: TIBBCDField;
    procedure dp_Date1Enter(Sender: TObject);
    procedure dp_Date2Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_okClick(Sender: TObject);
    procedure btn_GraphClick(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    xlOwner: TExcelWorks;
  public
  end;


implementation

{$R *.dfm}

uses UnChartForm;

procedure Tfrm_TemperSvod.dp_Date1Enter(Sender: TObject);
begin
  dp_Date1.Color:=clLime;
end;

procedure Tfrm_TemperSvod.dp_Date2Enter(Sender: TObject);
begin
  dp_Date2.Color:=clLime;
  if dp_Date2.Date=0 then
    dp_Date2.Date:=Date;
end;

procedure Tfrm_TemperSvod.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dset_Temper.Transaction.InTransaction then
    dset_Temper.Transaction.Commit;
  Action:=caFree;
end;

procedure Tfrm_TemperSvod.btn_okClick(Sender: TObject);
begin
  if dp_Date2.Date=0 then
    dp_Date2.Date:=Date;

  if not dset_Temper.Transaction.InTransaction then
    dset_Temper.Transaction.StartTransaction;
  dset_Temper.Close;
  dset_Temper.ParamByName('pDt1').AsDate:=dp_Date1.Date;
  dset_Temper.ParamByName('pDt2').AsDate:=dp_Date2.Date;
  dset_Temper.Open;


  btn_Graph.Enabled:=true;
  btn_Excel.Enabled:=true;
end;

procedure Tfrm_TemperSvod.btn_GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  t: double;
  dt: string;
begin
  frm_Chart:=Tfrm_Chart.Create(self, 'График температур');
  with frm_Chart.Chart, frm_Chart do
  begin
    Title.Text.Strings[0]:='График температур';

    LeftAxis.Title.Caption:='Температура';
    LeftAxis.Title.Font.Style:=[fsBold];

    BottomAxis.Title.Caption:='Дата';
    BottomAxis.Title.Font.Style:=[fsBold];
    BottomAxis.LabelsAngle:=90;

    AddChartSeries(stBar);
    ChartSeries[0].Marks.Visible:=false;

    dset_Temper.First;
    while not dset_Temper.Eof do
    begin
      dt:=dset_Temper.FieldByName('TempDate').AsString;
      t:=dset_Temper.FieldByName('Temperature').AsFloat;
      ChartSeries[0].Add(t, dt);
      dset_Temper.Next;
    end;

    ShowModal;
  end; // end with
end;

procedure Tfrm_TemperSvod.btn_ExcelClick(Sender: TObject);
var
  title: string;
begin
  title:='Сводка по температуре';
  xlOwner.Close();
  xlOwner.SetWSName(title);
  xlOwner.SetTitle(title);
  xlOwner.SetMargins(1, 1,0, 0);
  xlOwner.MapDBGrid(dbg_Grid);
end;

procedure Tfrm_TemperSvod.FormCreate(Sender: TObject);
begin
  xlOwner:=TExcelWorks.Create;
end;

procedure Tfrm_TemperSvod.FormDestroy(Sender: TObject);
begin
  xlOwner.Free;
end;

end.
