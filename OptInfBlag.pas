unit OptInfBlag;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDatePeriodFrame, StdCtrls, ExtCtrls, Buttons,
  Mask, ToolEdit, SelDateTimePeriodFrame;


type
  Tfrm_InfBlag = class(Tfrm_BaseOption)
    rg_Blag: TRadioGroup;
    btn_ok: TBitBtn;
    btn_close: TBitBtn;
    frame_SelDateTimePeriod1: Tframe_SelDateTimePeriod;
    procedure btn_closeClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    _dt_beg,_dt_end:TDateTime;
  public
     { Public declarations }
      typeBlag:integer;
      property dt_beg:TDateTime read _dt_beg write _dt_beg ;
      property dt_end:TDateTime read _dt_end write _dt_end ;
  end;

var
  frm_InfBlag: Tfrm_InfBlag;


implementation

{$R *.dfm}
uses HelpFunctions;


procedure Tfrm_InfBlag.btn_closeClick(Sender: TObject);
begin
  inherited;
    Close;
end;


procedure Tfrm_InfBlag.btn_okClick(Sender: TObject);
begin
  inherited;
  typeBlag:=rg_Blag.ItemIndex+1;

  if  frame_SelDateTimePeriod1.IsDateTimeCorrect then
    ModalResult := mrOk;
end;

end.
