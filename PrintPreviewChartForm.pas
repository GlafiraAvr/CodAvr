unit PrintPreviewChartForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, Chart, Printers;

type
  TPrintPreviewChartFrm = class(TForm)
    Image2: TImage;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    PrintBtn: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ScaleEdit: TSpinEdit;
    HorzOffsetEdit: TSpinEdit;
    VertOffsetEdit: TSpinEdit;
    svdlg: TSaveDialog;
    psdlg: TPrinterSetupDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ScaleEditChange(Sender: TObject);
    procedure HorzOffsetEditChange(Sender: TObject);
    procedure VertOffsetEditChange(Sender: TObject);


  private
    m_bit:TBitmap;
    m_chart:TChart;
    procedure DrawChart();
    procedure ShowPrinterSettings();
  public
    property Chart:TChart read m_chart write m_chart;
  end;

implementation

{$R *.dfm}

procedure TPrintPreviewChartFrm.DrawChart();
var rect:TRect;
    val:integer;
    width, height, rubric:integer;
    str:AnsiString;
    nHorzSize, nVertSize{, nPhysicalWidth, nPhysicalHeight}:integer;
    nScale, nVertOffset, nHorzOffset:integer;
begin
  if chart <> nil then
  begin
    try
      nScale := ScaleEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nScale > 100) or (nScale < 0) then
      Exit;

    try
      nHorzOffset := HorzOffsetEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nHorzOffset > 1000) or (nHorzOffset < -1000)then
      Exit;

    try
      nVertOffset := VertOffsetEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nVertOffset > 1000) or (nVertOffset < -1000)then
      Exit;

    rect.Top := 0;  rect.Bottom := Image2.Height;
    rect.Left := 0; rect.Right := Image2.Width;
    Image2.Picture.Bitmap.Canvas.Brush.Color := clWhite;
    Image2.Picture.Bitmap.Canvas.FillRect(rect);

    rubric := 5;
    width := Image2.Width - 2*rubric;
    height := trunc(chart.Height*(width/chart.Width));
    if height > Image2.Height - 2*rubric then
    begin
      height := Image2.Height - 2*rubric;
      width := trunc(chart.Width*(height/chart.height));
    end;

    width := trunc(width*nScale/100);
    height := trunc(height*nScale/100);


    rect.Top := rubric;
    rect.Left := trunc((Image2.Width - width)/2);
    rect.Right := trunc((Image2.Width - width)/2 + width);
    rect.Bottom := rubric + height;

{    rect.Top := 0;
    rect.left := 0;
    rect.Right := Image2.Width; Rect.Bottom := Image2.Height;
 }
    nHorzSize := GetDeviceCaps(printer.Handle, HORZSIZE);
    nVertSize := GetDeviceCaps(printer.Handle, VERTSIZE);
//    nPhysicalWidth := GetDeviceCaps(printer.Handle, PHYSICALWIDTH);
//    nPhysicalHeight := GetDeviceCaps(printer.Handle, PHYSICALHEIGHT);

    val := trunc(nHorzOffset*((1.*Image2.Width)/nHorzSize));
    rect.Left := rect.Left + val;
    rect.Right := rect.Right + val;
    val := trunc(nVertOffset*((1.*Image2.Height)/nVertSize));;
    rect.Top := rect.Top + val;
    rect.Bottom := rect.Bottom + val;


    str := 'Здесь должна появиться картинка с графиком, '+
                                          #10#13+'но функция PrintPartialCanvasToScreen похоже не '+
                                          #10#13+'реализована в используемой версии TeeChart';
//    Image2.Picture.Bitmap.Canvas.TextOut(10,10, str);
//    DrawText(Image2.Picture.Bitmap.Canvas.Handle, PChar(str), Length(str), rect,DT_Left);
//    chart.Draw(Image2.Picture.Bitmap.Canvas, rect);

//    chart.PrintPartialCanvasToScreen(Image2.Picture.Bitmap.Canvas, rect, rect);
    chart.PrintPartialCanvas(Image2.Picture.Bitmap.Canvas, rect);
//Image2.Picture.Bitmap.Canvas.Brush.Color := clRed;
//Image2.Picture.Bitmap.Canvas.FillRect(rect);

  end;
end;

procedure TPrintPreviewChartFrm.ShowPrinterSettings();
var  nHorzSize, nVertSize, {nHorzRes, nVertRes, }nLogPixelsX, nLogPixelsY{, nPhysicalHeight, nPhysicalWidth}:integer;
begin
  Label2.Caption := printer.Printers.Strings[printer.printerindex];
  Label3.Caption := IntToSTr(printer.pageheight) + ' ' + IntToStr(printer.PageWidth);
  nHorzSize := GetDeviceCaps(printer.Handle, HORZSIZE);
  nVertSize := GetDeviceCaps(printer.Handle, VERTSIZE);
{  nHorzRes := GetDeviceCaps(printer.Handle, HORZRES);
  nVertRes := GetDeviceCaps(printer.Handle, VERTRES);
  nPhysicalHeight := GetDeviceCaps(printer.Handle, PHYSICALHEIGHT);
  nPhysicalWidth := GetDeviceCaps(printer.Handle, PHYSICALWIDTH);
 }
  nLogPixelsX := GetDeviceCaps(printer.Handle, LOGPIXELSX);
  nLogPixelsY := GetDeviceCaps(printer.Handle, LOGPIXELSY);
  Label3.Caption := IntToStr( nLogPixelsX) + 'x' + IntToStr(nLogPixelsY) + 'dpi, ' +
                      IntToSTr(nHorzSize) + 'x' + IntToStr(nVertSize) + 'мм';

end;

procedure TPrintPreviewChartFrm.FormShow(Sender: TObject);
begin
  m_bit := TBitmap.Create();
  m_bit.Width := Image2.Width;
  m_bit.Height := Image2.Height;

  Image2.Picture.Bitmap := m_bit;

  ScaleEdit.Value := 100;
  HorzOffsetEdit.Value := 0;
  VertOffsetEdit.Value := 0;
  ShowPrinterSettings();
  DrawChart();
end;

procedure TPrintPreviewChartFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  m_bit.FreeImage();
  m_bit.Free();
  m_chart := nil;
end;

procedure TPrintPreviewChartFrm.BitBtn1Click(Sender: TObject);
begin
  Close();
end;

procedure TPrintPreviewChartFrm.FormCreate(Sender: TObject);
begin
  m_chart := nil;
end;

procedure TPrintPreviewChartFrm.BitBtn4Click(Sender: TObject);
var strFileName:AnsiString;
begin
  svdlg.DefaultExt := '.bmp';
  svdlg.Filter := 'Bitmap file (.bmp)|*.bmp';
  if Svdlg.Execute then
  begin
    strFileName := svdlg.FileName;
    Image2.Picture.Bitmap.SaveToFile(strFileName);
  end;
end;


procedure TPrintPreviewChartFrm.PrintBtnClick(Sender: TObject);
var pr, oldpr:TPrinter;
    n, nCount:integer;
    rect:TRect;
    val, rubric:integer;
    width,height:integer;
    nScale, nHorzOffset,nVertOffset:integer;
    nHorzSize, nVertSize, nPhysicalWidth, nPhysicalHeight:integer;
begin

  if chart <> nil then
  begin
    try
      nScale := ScaleEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nScale > 100) or (nScale < 0) then
      Exit;

    try
      nHorzOffset := HorzOffsetEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nHorzOffset > 1000) or (nHorzOffset < -1000)then
      Exit;

    try
      nVertOffset := VertOffsetEdit.Value;
    except
      on E:Exception do
      begin
        Exit;
      end;
    end;
    if (nVertOffset > 1000) or (nVertOffset < -1000)then
      Exit;


  pr := printer;//TPrinter.Create();
  nCount := pr.Printers.Count - 1;
  for n := 0 to nCount do
  begin
    if pr.Printers[n] = printer.Printers[printer.PrinterIndex] then //that's useless
    begin
      pr.PrinterIndex := n;
      break;
    end;
  end;

  rubric := 200;

  pr.BeginDoc;

  width := pr.PageWidth - 2*rubric;
  height := trunc(chart.Height*(width/chart.Width));

  if height > printer.PageHeight - 2*rubric then
  begin
    height := printer.PageHeight - 2*rubric;
    width := trunc(chart.Width*height/chart.Height);
  end;


  width := trunc(width*ScaleEdit.Value/100);
  height := trunc(height*ScaleEdit.Value/100);

  rect.Left := trunc((pr.PageWidth - width)/2);
  rect.Right := width + rect.Left;
  rect.Top := rubric;
  rect.Bottom := height + rect.Top;

  nHorzSize := GetDeviceCaps(printer.Handle, HORZSIZE);
  nVertSize := GetDeviceCaps(printer.Handle, VERTSIZE);
  nPhysicalWidth := GetDeviceCaps(printer.Handle, PHYSICALWIDTH);
  nPhysicalHeight := GetDeviceCaps(printer.Handle, PHYSICALHEIGHT);

  val := trunc(nHorzOffset*((1.*nPhysicalWidth)/nHorzSize));
  rect.Left := rect.Left + val;
  rect.Right := rect.Right + val;
  val := trunc(nVertOffset*((1.*nPhysicalHeight)/nVertSize));;
  rect.Top := rect.Top + val;
  rect.Bottom := rect.Bottom + val;

  m_chart.PrintPartial(rect);

  pr.EndDoc;
//  pr.Free();
 end;
end;

procedure TPrintPreviewChartFrm.BitBtn3Click(Sender: TObject);
var po:TPrinterOrientation;
    rect:TREct;
begin
  po := printer.Orientation;
  psdlg.Execute();
  if po <> printer.Orientation then
  begin
    po := printer.Orientation;
    if po = poPortrait then
    begin
      Image2.Width := 285;
      Image2.Height := 403;
      self.Height := 441;
      self.Width := 514;
      GroupBox1.Left := 289;
    end else
    begin
      Image2.Width := 403;
      Image2.Height := 285;
      self.Height := 321;
      self.Width := 632;
      GroupBox1.Left := 413;
    end;
    rect.Top := 0; rect.Left := 0;
    rect.Bottom := Image2.Height; rect.Right := Image2.Width;
    Image2.Picture.Bitmap := nil;
    m_bit.Free;
    m_bit := TBitmap.Create();
    m_bit.Width := Image2.Width;
    m_bit.Height := Image2.Height;
    Image2.Picture.Bitmap := m_bit;
    DrawChart();
  end;
  ShowPrinterSettings();
end;

procedure TPrintPreviewChartFrm.ScaleEditChange(Sender: TObject);
begin
  DrawChart();
end;

procedure TPrintPreviewChartFrm.HorzOffsetEditChange(Sender: TObject);
begin
  
  DrawChart();
end;

procedure TPrintPreviewChartFrm.VertOffsetEditChange(Sender: TObject);
begin
  DrawChart();
end;

end.
