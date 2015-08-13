unit OptBlagRazr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, ExtCtrls,
  SelDateTimePeriodFrame, Mask, ToolEdit, SelDatePeriodFrame;

type
  Tfrm_OptBlagRazr = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    frame_SelDates: Tframe_SelDatePeriod;
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private declarations }
    procedure SetDefaultDateTime();
  public
    { Public declarations }
  end;

var
  frm_OptBlagRazr: Tfrm_OptBlagRazr;

implementation

{$R *.dfm}
procedure Tfrm_OptBlagRazr.SetDefaultDateTime();
begin
end;



procedure Tfrm_OptBlagRazr.FormCreate(Sender: TObject);
begin
  inherited;
  SetDefaultDateTime;
end;

procedure Tfrm_OptBlagRazr.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_SelDates.IsDatesCorrect
  then ModalResult:=mrOK;



end;

procedure Tfrm_OptBlagRazr.FormShow(Sender: TObject);
begin
  inherited;

  frame_SelDates.de_Begin.Date:=StrToDate('15.10.2012');
  frame_SelDates.de_End.Date:=Date();
  frame_SelDates.SetFocus;

end;

end.
