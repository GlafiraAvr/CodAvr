unit print_image;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Printers, StdCtrls, Spin, Buttons, ExtDlgs,DBChart, ComCtrls;

type
  TPrintImage = class(TForm)
    Im_Print: TImage;
    GrB_Upr: TGroupBox;
    Label9: TLabel;
    Label2: TLabel;
    SpE_Xots: TSpinEdit;
    SpE_YOts: TSpinEdit;
    SpE_Scl: TSpinEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BB_Close: TBitBtn;
    BB_Save: TBitBtn;
    PicDlg: TSavePictureDialog;
    BB_Print: TBitBtn;
    BB_Setup: TBitBtn;
    PrSetupD: TPrinterSetupDialog;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpE_SclChange(Sender: TObject);
    procedure SpE_XotsChange(Sender: TObject);
    procedure BB_CloseClick(Sender: TObject);
    procedure BB_SaveClick(Sender: TObject);
    procedure BB_PrintClick(Sender: TObject);
    procedure BB_SetupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PrHres,PrVres,PrColors,PrPlanes:SmallInt;
    hs_pageDef,vs_pageDef:double;
    cdWidth,cdHeight,cdrWidth,cdrHeight:double;
    oldMono:boolean;
//    img : TBitMap;
    img : TImage;
    FileStr:TFileStream;
    procedure Redraw(xWidth,yHeight:double;Xot,Yot:integer);
    procedure ClearIm;
  end;
const
  INCH:double = 25.4;       { дюйм }
var
  PrintImage: TPrintImage;

type
  PPalEntriesArray = ^TPalEntriesArray; {for palette re-construction}
  TPalEntriesArray = array[0..0] of TPaletteEntry;

procedure BltTBitmapAsDib(DestDc: hdc; {Handle of where to blt}
  x: word; {Bit at x}
  y: word; {Blt at y}
  Width: word; {Width to stretch}
  Height: word; {Height to stretch}
  bm: TBitmap); {the TBitmap to Blt}
  

implementation


{$R *.DFM}

procedure TPrintImage.FormActivate(Sender: TObject);
var tt_str:string;
    Kfx,Kfy:double;
begin

  PrintImage:=Self;
  PrintImage.Height:=441;
  PrintImage.Width:=682;
  Im_Print.Height:=400;
  Im_Print.Picture.Bitmap.Height:=400;
  Im_Print.Width:=400;
  Im_Print.Picture.Bitmap.Width:=400;

  GrB_Upr.Left:=412;
  PrintImage.Update;
//  oldMono:=img.Monochrome;
              PrHres:=GetDeviceCaps(Printer.Handle,LogPixelsX);
              PrVres:=GetDeviceCaps(Printer.Handle,LogPixelsY);
              PrColors:=GetDeviceCaps(Printer.Handle,BITSPIXEL);
              PrPlanes:=GetDeviceCaps(Printer.Handle,PLANES);
              if (PrColors=1) and (PrPlanes=1) then
                begin
                 //ChBBl_Wt.Checked:=true;
                 //ChBBl_Wt.Enabled:=false; tprinter
                end;
              if Printer.PrinterIndex<0 then
                 Label9.Caption:='по умолчанию:'
              else
                 Label9.Caption:=Printer.Printers.Strings[Printer.PrinterIndex];

              if (PrColors=1) and (PrPlanes=1) then
                 tt_str:='2'
              else if (PrColors>1) then
                 str(2 shl (PrColors-1),tt_str)
              else if (PrColors=1)and (PrPlanes>1) then
                 str(2 shl PrPlanes,tt_str);

              Label2.Caption:=IntToStr(PrHRes)+'x'+IntToStr(PrVRes)+
                                    'dpi,'+tt_str+'цв.';
              hs_pageDef:=0.001*INCH*Printer.PageWidth/PrHres;
              vs_pageDef:=0.001*INCH*Printer.PageHeight/PrVres;
              str(hs_pageDef:5:3,tt_str);
              Label2.Caption:=Label2.Caption+tt_str+'x';
              str(vs_pageDef:5:3,tt_str);
              Label2.Caption:=Label2.Caption+tt_str;


  Kfx:=hs_pageDef/vs_pageDef;
  if Kfx<1 then
     Im_Print.Width:=Round(Im_Print.Width*Kfx)
  else
     Im_Print.Height:=Round(Im_Print.Height/Kfx);

  GrB_Upr.Left:=Im_Print.Left+Im_Print.Width+4;
  PrintImage.Width:=Im_Print.Width+GrB_Upr.Width+20;
  if Im_Print.Height<GrB_Upr.Height then
     PrintImage.Height:=GrB_Upr.Height+43;

{nut
  Kfx:=img.Width/Im_Print.Width;
  Kfy:=img.Height/Im_Print.Height;
  if Kfx>Kfy then
    begin
     cdWidth:=hs_pageDef;
     cdHeight:=hs_pageDef*
           img.Height/img.Width;
    end
  else
    begin
     cdHeight:=vs_pageDef;
     cdWidth:=vs_pageDef*
           img.Width/img.Height;
    end;
}
  Kfx:=img.Picture.Bitmap.Width/Im_Print.Width;
  Kfy:=img.Picture.Bitmap.Height/Im_Print.Height;
  if Kfx>Kfy then
    begin
     cdWidth:=hs_pageDef;
     cdHeight:=hs_pageDef*
           img.Picture.Bitmap.Height/img.Picture.Bitmap.Width;
    end
  else
    begin
     cdHeight:=vs_pageDef;
     cdWidth:=vs_pageDef*
           img.Picture.Bitmap.Width/img.Picture.Bitmap.Height;
    end;


{nut}
  SpE_SclChange(Self);
end;

procedure TPrintImage.Redraw(xWidth,yHeight:double;Xot,Yot:integer);
var tt_str:string;
    ix1,ix2,iy1,iy2:integer;
    iXot,iYot,iWidth,iHeight:double;
begin

  str(xWidth:5:3,tt_str);
  Label1.Caption:='% Размер:'+tt_str;
  str(yHeight:5:3,tt_str);
  Label1.Caption:=Label1.Caption+'x'+tt_str+'m.';

  iXot:=(Xot*Im_Print.Width/hs_pageDef)/1000;
  iYot:=(Yot*Im_Print.Height/vs_pageDef)/1000;
  iWidth:=xWidth*Im_Print.Width/hs_pageDef;
  iHeight:=yHeight*Im_Print.Height/vs_pageDef;
  ClearIm;
  ix1:=round(iXot);                              // tbitmap
  iy1:=round(iYot);
  ix2:=round(iWidth+iXot);
  iy2:=round(iHeight+iYot);
//  chartDB.PrintPartialCanvas(Im_Print.Canvas,Rect(ix1,iy1,ix2,iy2));
//  Im_Print.Canvas.CopyRect(Rect(ix1,iy1,ix2,iy2),Img.Canvas,Rect(ix1,iy1,ix2,iy2));
//  Im_Print.Update;

//  StretchBlt(Im_Print.Canvas.Handle,0,0,Im_Print.Width,Im_Print.Height,img.Canvas.Handle,0,0,img.Width,img.Height,SRCCOPY);

//  StretchBlt(Im_Print.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Canvas.Handle,0,0,img.Width,img.Height,SRCCOPY);
  StretchBlt(Im_Print.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Picture.Bitmap.Canvas.Handle,0,0,img.Picture.Bitmap.Width,img.Picture.Bitmap.Height,SRCCOPY);
end;

procedure TPrintImage.ClearIm;
begin
  Im_Print.Canvas.Brush.Style:=bsSolid;
  Im_Print.Canvas.Brush.Color:=clWhite;
  Im_Print.Canvas.FillRect(Rect(0,0,Im_Print.Width,Im_Print.Height));
end;
procedure TPrintImage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  chartDB.Monochrome:=oldMono;
  Action:=caFree;
end;

procedure TPrintImage.SpE_SclChange(Sender: TObject);
begin
  cdrWidth:=cdWidth*SpE_Scl.Value/100;
  cdrHeight:=cdHeight*SpE_Scl.Value/100;
  SpE_Xots.MaxValue:=round((hs_pageDef-cdrWidth)*1000);
  SpE_Yots.MaxValue:=round((vs_pageDef-cdrHeight)*1000);
  if SpE_Xots.Value>SpE_Xots.MaxValue then
    begin
     SpE_Xots.OnChange:=NIL;
     SpE_Xots.Value:=SpE_Xots.MaxValue;
     SpE_Xots.OnChange:=SpE_XotsChange;
    end;
  if SpE_Yots.Value>SpE_Yots.MaxValue then
    begin
     SpE_Yots.OnChange:=NIL;
     SpE_Yots.Value:=SpE_Xots.MaxValue;
     SpE_Yots.OnChange:=SpE_XotsChange;
    end;
  Redraw(cdrWidth,cdrHeight,SpE_Xots.Value,SpE_Yots.Value);
end;

procedure TPrintImage.SpE_XotsChange(Sender: TObject);
begin
  Redraw(cdrWidth,cdrHeight,SpE_Xots.Value,SpE_Yots.Value);
end;

procedure TPrintImage.BB_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPrintImage.BB_SaveClick(Sender: TObject);
var tt_path:string;
begin
 PicDlg.Execute;
 tt_path:=UpperCase(ExtractFileExt(PicDlg.FileName));
// FileStr:=TFileStream.Create(PicDlg.FileName,fmCreate);
// Img.SaveToFile(PicDlg.FileName);
 Img.Picture.Bitmap.SaveToFile(PicDlg.FileName);
{nut
 if tt_path='.BMP' then
   chartDB.SaveToBitmapFile(PicDlg.FileName)
 else if tt_path='.WMF' then
   chartDB.SaveToMetafile(PicDlg.FileName)
 else if tt_path='.EMF' then
   chartDB.SaveToMetafileEnh(PicDlg.FileName);
}
end;

procedure TPrintImage.BB_PrintClick(Sender: TObject);
var ix1,ix2,iy1,iy2:integer;
    iXot,iYot,iWidth,iHeight:double;
begin
  iXot:=(SpE_Xots.Value*Printer.PageWidth/hs_pageDef)/1000;
  iYot:=(SpE_Yots.Value*Printer.PageHeight/vs_pageDef)/1000;
  iWidth:=cdrWidth*Printer.PageWidth/hs_pageDef;
  iHeight:=cdrHeight*Printer.PageHeight/vs_pageDef;
  //ClearIm;
  ix1:=round(iXot);                              // tbitmap
  iy1:=round(iYot);
  ix2:=round(iWidth+iXot);
  iy2:=round(iHeight+iYot);

//  SetStretchBltMode(Printer.Canvas.Handle,COLORONCOLOR);
  Printer.BeginDoc;
//  SetStretchBltMode(Printer.Canvas.Handle,COLORONCOLOR);
//  chartDB.PrintPartialCanvas(Printer.Canvas,Rect(ix1,iy1,ix2,iy2));
//  StretchBlt(Printer.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Canvas.Handle,0,0,img.Width,img.Height,SRCCOPY);
//  Printer.Canvas.TextOut(20,20,'Это был мой бифштекс!!!!');
//  Printer.Canvas.CopyRect(Rect(ix1,iy1,ix2 mod 2,iy2 mod 2),img.Canvas,Rect(0,0,img.Width mod 2,img.Height mod 2));
 // Printer.Canvas.TextOut(120,120,'Ты самая красивая девушка в СССР!!!!');
//  StretchBlt(Im_Print.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Canvas.Handle,0,0,img.Width,img.Height,SRCCOPY);

//  StretchBlt(Im_Print.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Canvas.Handle,0,0,img.Width,img.Height,SRCAND);

//  StretchBlt(Printer.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,Im_Print.Canvas.Handle,0,0,Im_Print.Width,Im_Print.Height,SRCCOPY);
//  StretchDIBits(Printer.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,0,0,Im_Print.Width,Im_Print.Height,SRCCOPY)

//  StretchBlt(Printer.Canvas.Handle,ix1,iy1,ix2-ix1,iy2-iy1,img.Picture.Bitmap.Canvas.Handle,0,0,img.Picture.Bitmap.Width,img.Picture.Bitmap.Height,SRCAND);
//   Printer.Canvas.StretchDraw(Rect(ix1,iy1,ix2,iy2),img.Picture.MetaFile);

   BltTBitmapAsDib(Printer.Canvas.Handle, ix1,iy1,ix2-ix1,iy2-iy1, Img.Picture.Bitmap);

  Printer.EndDoc;
end;

procedure TPrintImage.BB_SetupClick(Sender: TObject);
begin
 PrSetupD.Execute;
 FormActivate(Self);
end;

procedure BltTBitmapAsDib(DestDc: hdc; {Handle of where to blt}
  x: word; {Bit at x}
  y: word; {Blt at y}
  Width: word; {Width to stretch}
  Height: word; {Height to stretch}
  bm: TBitmap); {the TBitmap to Blt}
var
  OriginalWidth: LongInt; {width of BM}
  dc: hdc; {screen dc}
  IsPaletteDevice: bool; {if the device uses palettes}
  IsDestPaletteDevice: bool; {if the device uses palettes}
  BitmapInfoSize: integer; {sizeof the bitmapinfoheader}
  lpBitmapInfo: PBitmapInfo; {the bitmap info header}
  hBm: hBitmap; {handle to the bitmap}
  hPal: hPalette; {handle to the palette}
  OldPal: hPalette; {temp palette}
  hBits: THandle; {handle to the DIB bits}
  pBits: pointer; {pointer to the DIB bits}
  lPPalEntriesArray: PPalEntriesArray; {palette entry array}
  NumPalEntries: integer; {number of palette entries}
  i: integer; {looping variable}
begin
  {If range checking is on - lets turn it off for now}
  {we will remember if range checking was on by defining}
  {a define called CKRANGE if range checking is on.}
  {We do this to access array members past the arrays}
  {defined index range without causing a range check}
  {error at runtime. To satisfy the compiler, we must}
  {also access the indexes with a variable. ie: if we}
  {have an array defined as a: array[0..0] of byte,}
  {and an integer i, we can now access a[3] by setting}
  {i := 3; and then accessing a[i] without error}
{$IFOPT R+}
{$DEFINE CKRANGE}
{$R-}
{$ENDIF}

  {Save the original width of the bitmap}
  OriginalWidth := bm.Width;

  {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);
  {Are we a palette device?}
  IsPaletteDevice :=
    GetDeviceCaps(dc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;
  {Give back the screen dc}
  dc := ReleaseDc(0, dc);

  {Allocate the BitmapInfo structure}
  if IsPaletteDevice then
    BitmapInfoSize := sizeof(TBitmapInfo) + (sizeof(TRGBQUAD) * 255)
  else
    BitmapInfoSize := sizeof(TBitmapInfo);
  GetMem(lpBitmapInfo, BitmapInfoSize);

  {Zero out the BitmapInfo structure}
  FillChar(lpBitmapInfo^, BitmapInfoSize, #0);

  {Fill in the BitmapInfo structure}
  lpBitmapInfo^.bmiHeader.biSize := sizeof(TBitmapInfoHeader);
  lpBitmapInfo^.bmiHeader.biWidth := OriginalWidth;
  lpBitmapInfo^.bmiHeader.biHeight := bm.Height;
  lpBitmapInfo^.bmiHeader.biPlanes := 1;
  if IsPaletteDevice then
    lpBitmapInfo^.bmiHeader.biBitCount := 8
  else
    lpBitmapInfo^.bmiHeader.biBitCount := 24;
  lpBitmapInfo^.bmiHeader.biCompression := BI_RGB;
  lpBitmapInfo^.bmiHeader.biSizeImage :=
    ((lpBitmapInfo^.bmiHeader.biWidth *
    longint(lpBitmapInfo^.bmiHeader.biBitCount)) div 8) *
    lpBitmapInfo^.bmiHeader.biHeight;
  lpBitmapInfo^.bmiHeader.biXPelsPerMeter := 0;
  lpBitmapInfo^.bmiHeader.biYPelsPerMeter := 0;
  if IsPaletteDevice then
  begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 256;
    lpBitmapInfo^.bmiHeader.biClrImportant := 256;
  end
  else
  begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 0;
    lpBitmapInfo^.bmiHeader.biClrImportant := 0;
  end;

  {Take ownership of the bitmap handle and palette}
  hBm := bm.ReleaseHandle;
  hPal := bm.ReleasePalette;

  {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);

  if IsPaletteDevice then
  begin
    {If we are using a palette, it must be}
    {selected into the dc during the conversion}
    OldPal := SelectPalette(dc, hPal, TRUE);
    {Realize the palette}
    RealizePalette(dc);
  end;
  {Tell GetDiBits to fill in the rest of the bitmap info structure}
  GetDiBits(dc,
    hBm,
    0,
    lpBitmapInfo^.bmiHeader.biHeight,
    nil,
    TBitmapInfo(lpBitmapInfo^),
    DIB_RGB_COLORS);

  {Allocate memory for the Bits}
  hBits := GlobalAlloc(GMEM_MOVEABLE,
    lpBitmapInfo^.bmiHeader.biSizeImage);
  pBits := GlobalLock(hBits);
  {Get the bits}
  GetDiBits(dc,
    hBm,
    0,
    lpBitmapInfo^.bmiHeader.biHeight,
    pBits,
    TBitmapInfo(lpBitmapInfo^),
    DIB_RGB_COLORS);

  if IsPaletteDevice then
  begin
    {Lets fix up the color table for buggy video drivers}
    GetMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
{$IFDEF VER100}
    NumPalEntries := GetPaletteEntries(hPal,
      0,
      256,
      lPPalEntriesArray^);
{$ELSE}
    NumPalEntries := GetSystemPaletteEntries(dc,
      0,
      256,
      lPPalEntriesArray^);
{$ENDIF}
    for i := 0 to (NumPalEntries - 1) do
    begin
      lpBitmapInfo^.bmiColors[i].rgbRed :=
        lPPalEntriesArray^[i].peRed;
      lpBitmapInfo^.bmiColors[i].rgbGreen :=
        lPPalEntriesArray^[i].peGreen;
      lpBitmapInfo^.bmiColors[i].rgbBlue :=
        lPPalEntriesArray^[i].peBlue;
    end;
    FreeMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
  end;

  if IsPaletteDevice then
  begin
    {Select the old palette back in}
    SelectPalette(dc, OldPal, TRUE);
    {Realize the old palette}
    RealizePalette(dc);
  end;

  {Give back the screen dc}
  dc := ReleaseDc(0, dc);

  {Is the Dest dc a palette device?}
  IsDestPaletteDevice :=
    GetDeviceCaps(DestDc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;

  if IsPaletteDevice then
  begin
    {If we are using a palette, it must be}
    {selected into the dc during the conversion}
    OldPal := SelectPalette(DestDc, hPal, TRUE);
    {Realize the palette}
    RealizePalette(DestDc);
  end;

  {Do the blt}
  StretchDiBits(DestDc,
    x,
    y,
    Width,
    Height,
    0,
    0,
    OriginalWidth,
    lpBitmapInfo^.bmiHeader.biHeight,
    pBits,
    lpBitmapInfo^,
    DIB_RGB_COLORS,
    SrcCopy);

  if IsDestPaletteDevice then
  begin
    {Select the old palette back in}
    SelectPalette(DestDc, OldPal, TRUE);
    {Realize the old palette}
    RealizePalette(DestDc);
  end;

  {De-Allocate the Dib Bits}
  GlobalUnLock(hBits);
  GlobalFree(hBits);

  {De-Allocate the BitmapInfo}
  FreeMem(lpBitmapInfo, BitmapInfoSize);

  {Set the ownership of the bimap handles back to the bitmap}
  bm.Handle := hBm;
  bm.Palette := hPal;

  {Turn range checking back on if it was on when we started}
{$IFDEF CKRANGE}
{$UNDEF CKRANGE}
{$R+}
{$ENDIF}
end;

end.
