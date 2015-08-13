unit OptSTexnForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_SOptTexn = class(Tfrm_BaseOption)
    de_Date: TDateEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SetDate(D:TDate);
  private
    { Private declarations }
    F_Date:TDate;
  public
    { Public declarations }
    property _Date:TDate read F_Date write SetDate;

  end;

var
  frm_SOptTexn: Tfrm_SOptTexn;

implementation
uses HelpFunctions;

{$R *.dfm}
procedure Tfrm_SOptTexn.SetDate(D:TDate);
begin
if de_Date.Date=0 then
 de_Date.Date:=D;
end;

procedure Tfrm_SOptTexn.BitBtn1Click(Sender: TObject);
begin
  inherited;

if not IsDateCorrect(de_Date.Text) then
 begin
  Application.MessageBox('Дата введена неправильно', 'Внимание', MB_OK+MB_ICONWARNING);
  exit;
 end;

if de_Date.Date>Date() then
 begin
  Application.MessageBox('Дата не может быть больше текущей', 'Внимание', MB_OK+MB_ICONWARNING);
  exit;
 end;
F_Date:=de_Date.Date;
ModalResult:=mrOk;
end;

procedure Tfrm_SOptTexn.BitBtn2Click(Sender: TObject);
begin
  inherited;
ModalResult:= mrCancel;
end;

end.
