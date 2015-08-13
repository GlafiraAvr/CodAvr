unit OptNetBarForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDatePeriodFrame, StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_OptNetBar = class(Tfrm_BaseOption)
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    frame_Dates: Tframe_SelDatePeriod;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure Tfrm_OptNetBar.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptNetBar.btn_okClick(Sender: TObject);
begin
  if frame_Dates.IsDatesCorrect then
    ModalResult := mrOk;
end;

end.
