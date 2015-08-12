unit DateSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_DateSel = class(Tfrm_BaseOption)
    dp_Date: TDateEdit;
    Label1: TLabel;
    btn_Ok: TBitBtn;
    btn_Exit: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    F_strDate: string;

    F_ResultCondition: string;
  public
    property strDate: string read F_strDate;
    property ResultCondition: string read F_ResultCondition;
    procedure setDate(dat:TDate);
  end;


implementation

{$R *.dfm}

procedure Tfrm_DateSel.FormShow(Sender: TObject);
begin
  if strDate='' then begin
  F_strDate:=FormatDateTime('dd.mm.yyyy',Now());

  dp_Date.Date := Now();
  end;
  F_ResultCondition:='';

end;

procedure Tfrm_DateSel.btn_OkClick(Sender: TObject);
begin
  F_ResultCondition:=' where id>-1 ';

  if dp_Date.Date<>0 then
  begin
    F_ResultCondition:=F_ResultCondition+' and DateComing<'''+DateToStr(dp_Date.Date+1)+'''';
    F_strDate:=DateToStr(dp_Date.Date);
  end else
    F_strDate:=DateToStr(Date);

  ModalResult:=mrOK;
end;


procedure Tfrm_DateSel.setDate(dat:TDate);
begin
 if F_strDate='' then begin
  dp_Date.Date:=dat;
  F_strDate:=FormatDateTime('dd.mm.yyyy',dat);
end;
end;

end.
