unit OptZvCloseOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, SelDatePeriodFrame;

type
  Tfrm_OptZvCloseOrder = class(Tfrm_BaseOption)
    frame_SelDatePeriod1: Tframe_SelDatePeriod;
    btn_ok: TBitBtn;
    btn_Cancel: TBitBtn;
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    function getdate1():TDate;
    function getDate2():TDate;
  public
    { Public declarations }
    property Date1:TDate read getDate1;
    property Date2:TDate read getDate2;

  end;

var
  frm_OptZvCloseOrder: Tfrm_OptZvCloseOrder;

implementation

{$R *.dfm}

procedure Tfrm_OptZvCloseOrder.btn_CancelClick(Sender: TObject);
begin
  inherited;
  ModalResult:=mrCancel;
  Close;
end;

function Tfrm_OptZvCloseOrder.getdate1: TDate;
begin

  result:=   frame_SelDatePeriod1.BeginDate;
end;

function Tfrm_OptZvCloseOrder.getDate2: TDate;
begin
  result:=   frame_SelDatePeriod1.EndDate;
end;

procedure Tfrm_OptZvCloseOrder.btn_okClick(Sender: TObject);
begin
  inherited;
if  frame_SelDatePeriod1.IsDatesCorrect then
 Modalresult:=mrOk;
end;

end.
