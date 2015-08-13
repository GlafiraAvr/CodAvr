unit SvodVedPrintDateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Buttons;

type
  Tfrm_SvodVedPrintDate = class(TForm)
    Label1: TLabel;
    de_Date: TDateEdit;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_Dt: TDate;
  public
    property Dt: TDate read F_Dt write F_Dt;
  end;


implementation

{$R *.dfm}

procedure Tfrm_SvodVedPrintDate.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SvodVedPrintDate.btn_okClick(Sender: TObject);
begin
  if de_Date.Date=0 then
  begin
    Application.MessageBox('Введите дату', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_Dt:=de_Date.Date;

  ModalResult:=mrOk;
end;

procedure Tfrm_SvodVedPrintDate.FormShow(Sender: TObject);
begin
  de_Date.Date:=F_Dt;
end;

end.
