unit OrderNumberForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_OrderNumber = class(TForm)
    btn_ok: TBitBtn;
    Label1: TLabel;
    lbl_OrderNumber: TLabel;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

  procedure ShowOrderNumber(const OrderNumber: string);

implementation

{$R *.dfm}

procedure ShowOrderNumber(const OrderNumber: string);
var
  frm: Tfrm_OrderNumber;
begin
  frm:=Tfrm_OrderNumber.Create(nil);
  try
    frm.lbl_OrderNumber.Caption:=OrderNumber;
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;


procedure Tfrm_OrderNumber.FormShow(Sender: TObject);
begin
  self.BringToFront;
end;

end.
