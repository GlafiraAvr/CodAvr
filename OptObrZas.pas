unit OptObrZas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, SelDatePeriodFrame;

type
  Tfrm_OptObrZas = class(Tfrm_BaseOption)
    frame_SelDates: Tframe_SelDatePeriod;
    btn_ok: TBitBtn;
    btn_close: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_OptObrZas: Tfrm_OptObrZas;

implementation

{$R *.dfm}

procedure Tfrm_OptObrZas.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_SelDates.IsDatesCorrect then
    ModalResult := mrOk;
end;

procedure Tfrm_OptObrZas.btn_closeClick(Sender: TObject);
begin
  inherited;
   Close;
end;

end.
