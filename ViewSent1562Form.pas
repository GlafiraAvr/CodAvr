unit ViewSent1562Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ToolEdit, Grids, DBGridEh,VeiwSent1562DModule, DB,
  DBCtrls, Buttons;

type
  Tfrm_ViewClosed1562 = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    DBGE_main: TDBGridEh;
    Panel2: TPanel;
    DBE_Adress: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBM_About: TDBMemo;
    btn_Ok: TBitBtn;
    btn_Cansel: TBitBtn;
    mem_closed: TMemo;
    Label3: TLabel;

    procedure DateEdit2ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure btn_CanselClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGE_mainCellClick(Column: TColumnEh);
  private
    { Private declarations }
    DopInf:TMemo;
    procedure ExitMemo(Sender:TObject);
  public
    { Public declarations }
    f_typForm:typ_Form;
  end;

var
  frm_ViewClosed1562: Tfrm_ViewClosed1562;

implementation

{$R *.dfm}




 { o:=Sender.ClassName;

  Rec:=DBGrid.CellRect(DbGrid.Col,DbGrid.row);
  Edit1.Text:=IntToStr(Rec.top)+' '+IntToStr(Rec.left)+' '+IntToStr(Rec.Right);
  DopInf.Top:=Rec.top;
  DopInf.Left:=Rec.left;

  DopInf.Width:=Rec.Right-Rec.Left;
  a:=(abs(DopInf.Font.Height)+2)*5;
 DopInf.Height:=abs(a);

  DopInf.Text:=
  DbGrid.DataSource.DataSet.FieldByName(DbGrid.Columns[DbGrid.Col-1].FieldName).AsString;
   DopInf.Visible:=true;
 DopInf.SetFocus;
  }

procedure Tfrm_ViewClosed1562.DateEdit2ButtonClick(Sender: TObject);    //90 368 570
begin

//
end;

procedure Tfrm_ViewClosed1562.FormCreate(Sender: TObject);
begin

   DopInf:=TMemo.Create(Self);
   DopInf.Parent:=  Self;
   //CreateParented(Form1.WindowHandle);
   DopInf.ScrollBars:=ssVertical;
   DopInf.Color:=$DDFFFF;//o001111H;
   DopInf.BevelInner:=bvRaised;
   DopInf.BevelOuter:=bvSpace;
   DopInf.BevelKind:=bkFlat;


   DopInf.Visible:=false;
   DopInf.ReadOnly:=true;
   DopInf.OnExit:=ExitMemo;
   F_typForm:=default;

end;

procedure Tfrm_ViewClosed1562.FormDestroy(Sender: TObject);
begin
//DopInf.Destroy;
DopInf.Free;
end;

procedure Tfrm_ViewClosed1562.ExitMemo(Sender:TOBject);
begin
 (Sender as TMemo).Visible:=false;
end;

procedure Tfrm_ViewClosed1562.btn_OkClick(Sender: TObject);
begin

  ModalResult:=mrOk

end;

procedure Tfrm_ViewClosed1562.btn_CanselClick(Sender: TObject);
begin
ModalResult:=mrCancel;
Close;
end;

procedure Tfrm_ViewClosed1562.FormShow(Sender: TObject);
begin
if F_typForm=before_Closed then
  DBGE_main.Columns.Items[1].Visible:=false;


end;

procedure Tfrm_ViewClosed1562.DBGE_mainCellClick(Column: TColumnEh);
begin
  Column.CheckboxState
end;

end.
