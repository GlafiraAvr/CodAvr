unit QCanselForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StringConsts, Menus, ExtCtrls;

type
  Tfrm_QCansel = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label_: TLabel;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    num_btn:integer ;
    
  public
    procedure SetCaption(cap:string);
    procedure PreaPare(title,qestion,ans_yes,ans_no:string; num:integer=0;num3Visible:boolean=true);
    { Public declarations }
  end;

var
  frm_QCansel: Tfrm_QCansel;

implementation

{$R *.dfm}

procedure Tfrm_QCansel.FormShow(Sender: TObject);
begin
Caption:=gc_strDispAVR;
case num_btn of
 1: BitBtn1.SetFocus;
 2: BitBtn2.SetFocus;
 3: BitBtn3.SetFocus;
end;
end;

procedure Tfrm_QCansel.SetCaption(cap:string);
begin
label_.Alignment:=taCenter;
label_.Caption:=cap;
end;

procedure Tfrm_QCansel.PreaPare(title,qestion,ans_yes,ans_no:string;num:integer;num3Visible:boolean);
begin
 if title='' then
  Self.Caption:=gc_strDispAVR
 else
  Self.Caption:=title;
 Label_.Caption:=qestion;
 BitBtn1.Top:=Label_.Top+Label_.Height+20;
 BitBtn1.Caption:=ans_no;
 BitBtn2.Top:=Label_.Top+Label_.Height+20;
 BitBtn3.Top:=Label_.Top+Label_.Height+20;
 Self.Height:= BitBtn1.Top+BitBtn1.Height+40;
 BitBtn2.Caption:=ans_yes;
 if num>0 then
   num_btn:=num;
 BitBtn3.Visible:=num3Visible;
end;




end.
