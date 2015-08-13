unit DmgChartSettingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, RXSpin, DmgChartForm;

type
  Tfrm_DmgChartSetting = class(TForm)
    GroupBox1: TGroupBox;
    ed_ChartTitle: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox2: TGroupBox;
    chb_AutoX: TCheckBox;
    chb_AutoY: TCheckBox;
    chb_Grid: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    sp_Xmin: TRxSpinEdit;
    sp_Xmax: TRxSpinEdit;
    sp_Ymin: TRxSpinEdit;
    sp_Ymax: TRxSpinEdit;
    GroupBox3: TGroupBox;
    sp_lblFontSize: TRxSpinEdit;
    sp_TitFontSize: TRxSpinEdit;
    sp_LblSize: TRxSpinEdit;
    btn_Color: TBitBtn;
    btn_Apply: TBitBtn;
    btn_Cancel: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ColorDlg: TColorDialog;
    FontDlg: TFontDialog;
    Label7: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure chb_AutoXClick(Sender: TObject);
    procedure chb_AutoYClick(Sender: TObject);
    procedure ed_ChartTitleChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sp_XminChange(Sender: TObject);
    procedure sp_XmaxChange(Sender: TObject);
    procedure sp_YminChange(Sender: TObject);
    procedure sp_YmaxChange(Sender: TObject);
    procedure chb_GridClick(Sender: TObject);
    procedure sp_lblFontSizeChange(Sender: TObject);
    procedure sp_TitFontSizeChange(Sender: TObject);
    procedure sp_LblSizeChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btn_ColorClick(Sender: TObject);
    procedure btn_ApplyClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
  private
    F_ChartForm: Tfrm_DmgChart;

    F_ChartTitle: string;
    F_ChartTitleFont, F_LblFont, F_TitFont: TFont;
    F_IsXAuto, F_IsYAuto, F_IsGrid: boolean;
    F_Xmin, F_Xmax, F_Ymin, F_Ymax, F_LblSize: integer;
    F_Color: TColor;

    procedure ChngXAuto;
    procedure ChngYAuto;
  public
    constructor Create(AOwner: TComponent; AChartForm: Tfrm_DmgChart);
  end;


implementation

{$R *.dfm}

procedure Tfrm_DmgChartSetting.ChngXAuto;
begin
  sp_Xmin.Enabled:=not chb_AutoX.Checked;
  sp_Xmax.Enabled:=not chb_AutoX.Checked;
end;

procedure Tfrm_DmgChartSetting.ChngYAuto;
begin
  sp_Ymin.Enabled:=not chb_AutoY.Checked;
  sp_Ymax.Enabled:=not chb_AutoY.Checked;
end;

constructor Tfrm_DmgChartSetting.Create(AOwner: TComponent;
  AChartForm: Tfrm_DmgChart);
begin
  F_ChartForm:=AChartForm;
  inherited Create(AOwner);
end;

procedure Tfrm_DmgChartSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  F_ChartTitleFont.Free;
  F_TitFont.Free;
  F_LblFont.Free;

  Action:=caFree;
end;

procedure Tfrm_DmgChartSetting.FormCreate(Sender: TObject);
begin
  with F_ChartForm do
  begin
    ed_ChartTitle.Text:=Chart.Title.Text.Strings[0];
    F_ChartTitle:=Chart.Title.Text.Strings[0];

    F_ChartTitleFont:=TFont.Create;
    F_ChartTitleFont.Assign(Chart.Title.Font);

    F_LblFont:=TFont.Create;
    F_LblFont.Assign(Chart.BottomAxis.LabelsFont);
    sp_LblFontSize.Value:=Chart.BottomAxis.LabelsFont.Size;

    F_TitFont:=TFont.Create;
    F_TitFont.Assign(Chart.BottomAxis.Title.Font);
    sp_TitFontSize.Value:=Chart.BottomAxis.Title.Font.Size;

    F_LblSize:=Chart.LeftAxis.LabelsSize;
    sp_LblSize.Value:=Chart.LeftAxis.LabelsSize;

    F_Color:=Chart.Color;

    F_IsGrid:=Chart.BottomAxis.Grid.Visible;
    chb_Grid.Checked:=Chart.BottomAxis.Grid.Visible;

    F_IsXAuto:=Chart.BottomAxis.Automatic;
    chb_AutoX.Checked:=Chart.BottomAxis.Automatic;

    F_IsYAuto:=Chart.LeftAxis.Automatic;
    chb_AutoY.Checked:=Chart.LeftAxis.Automatic;
    
    F_Xmin:=round(Chart.BottomAxis.Minimum);
    F_Xmax:=round(Chart.BottomAxis.Maximum);
    F_Ymin:=round(Chart.LeftAxis.Minimum);
    F_Ymax:=round(Chart.LeftAxis.Maximum);
    sp_Xmin.Value:=F_Xmin;
    sp_Xmax.Value:=F_Xmax;
    sp_Ymin.Value:=F_Ymin;
    sp_Ymax.Value:=F_Ymax;
  end;
end;

procedure Tfrm_DmgChartSetting.chb_AutoXClick(Sender: TObject);
begin
  F_ChartForm.Chart.BottomAxis.Automatic:=chb_AutoX.Checked;

  ChngXAuto;
end;

procedure Tfrm_DmgChartSetting.chb_AutoYClick(Sender: TObject);
begin
  F_ChartForm.Chart.LeftAxis.Automatic:=chb_AutoY.Checked;

  ChngYAuto;
end;

procedure Tfrm_DmgChartSetting.ed_ChartTitleChange(Sender: TObject);
begin
  F_ChartForm.Chart.Title.Text.Strings[0]:=ed_ChartTitle.Text;
end;

procedure Tfrm_DmgChartSetting.SpeedButton1Click(Sender: TObject);
begin
  FontDlg.Font.Assign(F_ChartForm.Chart.Title.Font);
  if FontDlg.Execute then
    F_ChartForm.Chart.Title.Font.Assign(FontDlg.Font);
end;

procedure Tfrm_DmgChartSetting.sp_XminChange(Sender: TObject);
var
  Xmin_old: integer;
begin
  Xmin_old:=round(F_ChartForm.Chart.BottomAxis.Minimum);
  try
    F_ChartForm.Chart.BottomAxis.Minimum:=sp_Xmin.Value;
  except
    sp_Xmin.Value:=Xmin_old;
    F_ChartForm.Chart.BottomAxis.Minimum:=Xmin_old;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.sp_XmaxChange(Sender: TObject);
var
  Xmax_old: integer;
begin
  Xmax_old:=round(F_ChartForm.Chart.BottomAxis.Maximum);
  try
    F_ChartForm.Chart.BottomAxis.Maximum:=sp_Xmax.Value;
  except
    sp_Xmax.Value:=Xmax_old;
    F_ChartForm.Chart.BottomAxis.Maximum:=Xmax_old;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.sp_YminChange(Sender: TObject);
var
  Ymin_old: integer;
begin
  Ymin_old:=round(F_ChartForm.Chart.LeftAxis.Minimum);
  try
    F_ChartForm.Chart.LeftAxis.Minimum:=sp_Ymin.Value;
  except
    sp_Ymin.Value:=Ymin_old;
    F_ChartForm.Chart.LeftAxis.Minimum:=Ymin_old;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.sp_YmaxChange(Sender: TObject);
var
  Ymax_old: integer;
begin
  Ymax_old:=round(F_ChartForm.Chart.LeftAxis.Maximum);
  try
    F_ChartForm.Chart.LeftAxis.Maximum:=sp_Ymax.Value;
  except
    sp_Ymax.Value:=Ymax_old;
    F_ChartForm.Chart.LeftAxis.Maximum:=Ymax_old;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.chb_GridClick(Sender: TObject);
begin
  F_ChartForm.Chart.BottomAxis.Grid.Visible:=chb_Grid.Checked;
  F_ChartForm.Chart.LeftAxis.Grid.Visible:=chb_Grid.Checked;
end;

procedure Tfrm_DmgChartSetting.sp_lblFontSizeChange(Sender: TObject);
var
  old_size: integer;
begin
  old_size:=F_ChartForm.Chart.BottomAxis.LabelsFont.Size;
  try
    F_ChartForm.Chart.BottomAxis.LabelsFont.Size:=round(sp_lblFontSize.Value);
    F_ChartForm.Chart.LeftAxis.LabelsFont.Size:=round(sp_lblFontSize.Value);
  except
    F_ChartForm.Chart.BottomAxis.LabelsFont.Size:=old_size;
    F_ChartForm.Chart.LeftAxis.LabelsFont.Size:=old_size;
    sp_lblFontSize.Value:=old_size;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.sp_TitFontSizeChange(Sender: TObject);
var
  old_size: integer;
begin
  old_size:=F_ChartForm.Chart.BottomAxis.Title.Font.Size;
  try
    F_ChartForm.Chart.BottomAxis.Title.Font.Size:=round(sp_TitFontSize.Value);
    F_ChartForm.Chart.LeftAxis.Title.Font.Size:=round(sp_TitFontSize.Value);
  except
    F_ChartForm.Chart.BottomAxis.Title.Font.Size:=old_size;
    F_ChartForm.Chart.LeftAxis.Title.Font.Size:=old_size;
    sp_TitFontSize.Value:=old_size;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.sp_LblSizeChange(Sender: TObject);
var
  old_size: integer;
begin
  old_size:=F_ChartForm.Chart.LeftAxis.LabelsSize;
  try
    F_ChartForm.Chart.BottomAxis.LabelsSize:=round(sp_LblSize.Value);
    F_ChartForm.Chart.LeftAxis.LabelsSize:=round(sp_LblSize.Value);
  except
    F_ChartForm.Chart.BottomAxis.LabelsSize:=old_size;
    F_ChartForm.Chart.LeftAxis.LabelsSize:=old_size;
    sp_LblSize.Value:=old_size;
    Raise;
  end;
end;

procedure Tfrm_DmgChartSetting.SpeedButton2Click(Sender: TObject);
begin
  FontDlg.Font.Assign(F_ChartForm.Chart.BottomAxis.LabelsFont);
  if not FontDlg.Execute then exit;

  F_ChartForm.Chart.BottomAxis.LabelsFont.Assign(FontDlg.Font);
  F_ChartForm.Chart.LeftAxis.LabelsFont.Assign(FontDlg.Font);

  sp_lblFontSize.Value:=F_ChartForm.Chart.BottomAxis.LabelsFont.Size;
end;

procedure Tfrm_DmgChartSetting.SpeedButton3Click(Sender: TObject);
begin
  FontDlg.Font.Assign(F_ChartForm.Chart.BottomAxis.Title.Font);
  if not FontDlg.Execute then exit;

  F_ChartForm.Chart.BottomAxis.Title.Font.Assign(FontDlg.Font);
  F_ChartForm.Chart.LeftAxis.Title.Font.Assign(FontDlg.Font);

  sp_TitFontSize.Value:=F_ChartForm.Chart.BottomAxis.Title.Font.Size;
end;

procedure Tfrm_DmgChartSetting.btn_ColorClick(Sender: TObject);
begin
  if ColorDlg.Execute then
    F_ChartForm.Chart.Color:=ColorDlg.Color;
end;

procedure Tfrm_DmgChartSetting.btn_ApplyClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DmgChartSetting.btn_CancelClick(Sender: TObject);
begin
  with F_ChartForm.Chart do
  begin
    Title.Text.Strings[0]:=F_ChartTitle;
    Title.Font.Assign(F_ChartTitleFont);

    BottomAxis.LabelsFont.Assign(F_LblFont);
    LeftAxis.LabelsFont.Assign(F_LblFont);

    BottomAxis.Title.Font.Assign(F_TitFont);
    LeftAxis.Title.Font.Assign(F_TitFont);

    BottomAxis.LabelsSize:=F_LblSize;
    LeftAxis.LabelsSize:=F_LblSize;

    Color:=F_Color;

    BottomAxis.Automatic:=F_IsXAuto;
    LeftAxis.Automatic:=F_IsYAuto;

    if not F_IsXAuto then
    begin
      BottomAxis.Minimum:=F_Xmin;
      BottomAxis.Maximum:=F_Xmax;
    end;

    if not F_IsYAuto then
    begin
      LeftAxis.Minimum:=F_Ymin;
      LeftAxis.Maximum:=F_Ymax;
    end
  end; //end with

  Close;
end;

end.
