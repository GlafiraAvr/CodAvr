unit DgrForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Diagram, StdCtrls, ComCtrls, Menus, Buttons;

type
  TGraph = class(TForm)
    Panel: TPanel;
    pn2: TPanel;
    pn3: TPanel;
    pn4: TPanel;
    pn5: TPanel;
    pn1: TPanel;
    Diagram: TDiagram;
    Timer: TTimer;
    pn6: TPanel;
    pn7: TPanel;
    pn8: TPanel;
    pn9: TPanel;
    pn10: TPanel;
    PopupMenu: TPopupMenu;
    track: TMenuItem;
    Panel_Track: TPanel;
    TrackBar: TTrackBar;
    Button1: TSpeedButton;
    BitBtn1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pnYearClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure DiagramDblClick(Sender: TObject);
    procedure trackClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    BufSize:Longint;
    CurYear:word;
    dType:integer;
  public
    { Public declarations }
  end;

var
  Graph: TGraph;

implementation

uses AN_DIAGR, print_image;

var p1, p2, p3, p4,p5,p6,p7,p8,p9,p10 : Integer;
{$R *.DFM}

procedure TGraph.FormCreate(Sender: TObject);
var i,k,j,l,raz_god:integer;
    _min,_max:double;
    s:string;
begin
Inherited;
//raz_god:=0;
p1:=TQueryForm(Owner).nYear1;
p2:=TQueryForm(Owner).nYear1+1;
p3:=TQueryForm(Owner).nYear1+2;
p4:=TQueryForm(Owner).nYear1+3;
p5:=TQueryForm(Owner).nYear1+4;
p6:=TQueryForm(Owner).nYear1+5;
p7:=TQueryForm(Owner).nYear1+6;
p8:=TQueryForm(Owner).nYear1+7;
p9:=TQueryForm(Owner).nYear1+8;
p10:=TQueryForm(Owner).nYear1+9;
  k:=TQueryForm(Owner).Num1;
  l:=0;
  for i:=TQueryForm(Owner).Num1 to TQueryForm(Owner).Num2 do
    begin
      j:=trunc((i-TQueryForm(Owner).Num1)/TQueryForm(Owner).sRange);
      if j<>l
        then begin
          s:=IntToStr(k);
          if k<>(i-1)
            then s:=s+' - '+IntToStr(i-1);
          Diagram.LabelsCol.Add(s);
          l:=j;
          k:=i
        end
    end;
  i:=TQueryForm(Owner).Num2;
  s:=IntToStr(k);
  if k<>i
    then s:=s+' - '+IntToStr(i);
  Diagram.LabelsCol.Add(s);
  dType:=TQueryForm(Owner).gbGraph.Tag;
  _min:=TQueryForm(Owner)._MinValue;
  _max:=TQueryForm(Owner)._MaxValue;
  if _min=_max
    then _max:=_min+1.0;
  Diagram.SetMinMax(_min,_max);
  raz_god:=TQueryForm(Owner).nYear2 - TQueryForm(Owner).nYear1+1;
  If raz_god=0 Then raz_god:=1;
  for i:=1 to raz_god do
    begin
      case i of
        1:
              begin
                pn1.Caption:=IntToStr(TQueryForm(Owner).nYear1);
                pn1.Visible:=True;
                Diagram.Colors[1]:=pn1.Color
              end;
        2:
              begin
                pn2.Caption:=IntToStr(TQueryForm(Owner).nYear1+1);
                pn2.Visible:=True;
                Diagram.Colors[2]:=pn2.Color
              end;
        3:
              begin
                pn3.Caption:=IntToStr(TQueryForm(Owner).nYear1+2);
                pn3.Visible:=True;
                Diagram.Colors[3]:=pn3.Color
              end;
        4:
              begin
                pn4.Caption:=IntToStr(TQueryForm(Owner).nYear1+3);
                pn4.Visible:=True;
                Diagram.Colors[4]:=pn4.Color
              end;
        5:
              begin
                pn5.Caption:=IntToStr(TQueryForm(Owner).nYear1+4);
                pn5.Visible:=True;
                Diagram.Colors[5]:=pn5.Color
              end;
        6:
              begin
                pn6.Caption:=IntToStr(TQueryForm(Owner).nYear1+5);
                pn6.Visible:=True;
                Diagram.Colors[6]:=pn6.Color
//                Diagram.Colors[i-TQueryForm(Owner).nYear1+1]:=pn6.Color
              end;
        7:
              begin
                pn7.Caption:=IntToStr(TQueryForm(Owner).nYear1+6);
                pn7.Visible:=True;
                Diagram.Colors[7]:=pn7.Color
              end;
        8:
              begin
                pn8.Caption:=IntToStr(TQueryForm(Owner).nYear1+7);
                pn8.Visible:=True;
                Diagram.Colors[8]:=pn8.Color
              end;
        9:
              begin
                pn9.Caption:=IntToStr(TQueryForm(Owner).nYear1+8);
                pn9.Visible:=True;
                Diagram.Colors[9]:=pn9.Color
              end;
        10:
              begin
                pn10.Caption:=IntToStr(TQueryForm(Owner).nYear1+9);
                pn10.Visible:=True;
                Diagram.Colors[10]:=pn10.Color
              end;
      end;
      Diagram.LabelsRow.Add(IntToStr(i));
    end;
  with Diagram do
    case dType of
      1:
         begin
           CountRows:=1;
           CountColumns:=nRange;
           AngleTurn:=310;
           PercentRow:=10;
           PercentLayer:=30;
           LabelCaption:='Годовая динамика аварий';
           ValuesFromArray(TQueryForm(Self.Owner).Count);
           CurYear:=TQueryForm(Self.Owner).nYear1
         end;
      2:
         begin
           CountRows:=TQueryForm(Self.Owner).nYear2-TQueryForm(Self.Owner).nYear1+1;
           CountColumns:=nRange;
           AngleTurn:=310;
           PercentRow:=50;
           PercentLayer:=30;
           LabelCaption:='Годовая матрица аварий';
           ValuesFromArray(TQueryForm(Self.Owner).Count);
         end;
      3:
         begin
           CountRows:=TQueryForm(Self.Owner).nYear2-TQueryForm(Self.Owner).nYear1+1;
           CountColumns:=nRange;
           AngleTurn:=305;
           PercentRow:=10;
           PercentLayer:=30;
           for i:=2 to CountRows do
             HidedRows[i]:=True;
           LabelCaption:='Суммирующая диаграмма аварий';
           Style:=dsTower;
           ValuesFromArray(TQueryForm(Self.Owner).Count);
           CurYear:=TQueryForm(Self.Owner).nYear1;
           LabelsRow.Strings[0]:=IntToStr(TQueryForm(Self.Owner).nYear1)+' - '+
                                 IntToStr(TQueryForm(Self.Owner).nYear2)
         end;
    end;
  BufSize:=Diagram.CountColumns*sizeof(double);
  _min:=TQueryForm(Owner)._MinValue;
  _max:=TQueryForm(Owner)._MaxValue;
  if dType=3
    then for i:=1 to Diagram.CountColumns do
       begin
         l:=0;
         for j:=1 to Diagram.CountRows do
           l:=l+trunc(Diagram.Values[j,i]);
         if trunc(_max)<l
           then _max:=l+0.0;
       end;
  if _min=_max
    then _max:=_min+1.0;
  l:=1;
  while (trunc(_max) div l)>10 do
    if l=1
      then l:=5
      else l:=l+5;
  Diagram.CountLayers:=round(_max/l+0.5);
  for i:=0 to Diagram.CountLayers do
    Diagram.LabelsLayer.Add(IntToStr(i*l));
  _max:=Diagram.CountLayers*l+0.0;
  Diagram.SetMinMax(_min,_max);
  Diagram.Active:=True;
end;

procedure TGraph.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape
    then if Panel_Track.Visible
      then trackClick(Self)
      else Close;
  if not Panel_Track.Visible
    then case Key of
    vk_Left: Diagram.AngleTurn:=Diagram.AngleTurn+5;
    vk_Right: Diagram.AngleTurn:=Diagram.AngleTurn-5;
    vk_Up: if Diagram.AngleSlope<90
             then Diagram.AngleSlope:=Diagram.AngleSlope+5;
  vk_Down: if Diagram.AngleSlope>0
             then  Diagram.AngleSlope:=Diagram.AngleSlope-5;
    end;
end;

procedure TGraph.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  Timer.enabled:=False;
end;

procedure TGraph.FormKeyPress(Sender: TObject; var Key: Char);
var i,j:integer;
begin
  with Owner as TQueryForm do
    if (dType in [1,3]) and (Key=' ') and (nYear1<nYear2)
      then begin
        Key:=#0;
        if CurYear<nYear2
          then CurYear:=CurYear+1
          else exit;
        case dType of
         1: begin
              Diagram.LabelsRow.Strings[0]:=IntToStr(CurYear);
              If p1=CurYear Then Diagram.Colors[1]:=pn1.Color;
              If p2=CurYear Then Diagram.Colors[1]:=pn2.Color;
              If p3=CurYear Then Diagram.Colors[1]:=pn3.Color;
              If p4=CurYear Then Diagram.Colors[1]:=pn4.Color;
              If p5=CurYear Then Diagram.Colors[1]:=pn5.Color;
              If p6=CurYear Then Diagram.Colors[1]:=pn6.Color;
              If p7=CurYear Then Diagram.Colors[1]:=pn7.Color;
              If p8=CurYear Then Diagram.Colors[1]:=pn8.Color;
              If p9=CurYear Then Diagram.Colors[1]:=pn9.Color;
              If p10=CurYear Then Diagram.Colors[1]:=pn10.Color;
              Diagram.SmoothValuesFromArray(
              Pointer(Longint(Count)+(CurYear-nYear1)*BufSize),20,0.0);
            end;
         3: begin
              Diagram.Active:=False;
              i:=CurYear-nYear1+1;
              for j:=1 to Diagram.CountColumns do
                Diagram.Values[i,j]:=0.0;
              Diagram.HidedRows[i]:=False;
              Diagram.Active:=True;
              Diagram.SmoothValuesFromArray(Count,20,0.0);
            end;
        end
      end
end;

procedure TGraph.pnYearClick(Sender: TObject);
var i:integer;
begin
  with Owner as TQueryForm do
    if (dType in [1,3]) and (nYear1<nYear2)
      then begin
        case dType of
          1:begin
               CurYear:=StrToInt((Sender as TPanel).Caption);
               Diagram.Active:=False;
               Diagram.LabelsRow.Strings[0]:=IntToStr(CurYear);
               Diagram.Colors[1]:=(Sender as TPanel).Color;
               Diagram.ValuesFromArray(
                   Pointer(Longint(Count)+(CurYear-nYear1)*BufSize));
               Diagram.Active:=True;
             end;
          3:begin
               CurYear:=StrToInt((Sender as TPanel).Caption);
               Diagram.Active:=False;
               for i:=1 to CurYear-nYear1+1 do
                 Diagram.HidedRows[i]:=False;
               for i:=CurYear-nYear1+2 to Diagram.CountRows do
                 Diagram.HidedRows[i]:=True;
               Diagram.Active:=True;
             end
        end
      end;
end;

procedure TGraph.TrackBarChange(Sender: TObject);
begin
   Diagram.rho:=TrackBar.Position;
end;

procedure TGraph.TimerTimer(Sender: TObject);
var Key:word;
    Shift:TShiftState;
begin
  Key:=vk_Left;
  Shift:=[];
  FormKeyDown(Self,Key,Shift)
end;

procedure TGraph.DiagramDblClick(Sender: TObject);
begin
  Timer.Enabled:=not Timer.Enabled
end;

procedure TGraph.trackClick(Sender: TObject);
begin
  with Panel_Track do
    begin
      Enabled:=not Enabled;
      Visible:=Enabled;
      if Visible then SetFocus;
    end
end;

procedure TGraph.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TGraph.Button1Click(Sender: TObject);
var
  graf_s : TPrintImage;
begin
  graf_s:=TPrintImage.Create(self);
  try

    graf_s.img:=TImage.Create(nil);
    graf_s.img.Picture.Bitmap.Height:=Diagram.Height;
    graf_s.img.Picture.Bitmap.Width:=Diagram.Width;
    StretchBlt(graf_s.Img.Canvas.Handle,0,0,Diagram.Width,Diagram.Height,Diagram.Canvas.Handle,0,0,Diagram.Width,Diagram.Height,SRCCOPY);

    graf_s.ShowModal;
  finally
    graf_s.img.Free;
  end;  
end;

end.
