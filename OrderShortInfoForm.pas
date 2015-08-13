unit OrderShortInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, AddOrderInfoForm, Grids, Aligrid;

type
  Tfrm_OrderShortInfo = class(Tfrm_AddOrderInfo)
    Label1: TLabel;
    lbl_OrderNumber: TLabel;
    Label2: TLabel;
    lbl_DateComing: TLabel;
    mem_WhatIsDone: TMemo;
    btn_Exit: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Grid: TStringAlignGrid;
    procedure btn_ExitClick(Sender: TObject);
  private
    procedure SetOrderNumber(const Value: integer);
    procedure SetDateComing(const Value: TDateTime);
    procedure SetWhatIsDone(const Value: string);
  public
    property OrderNumber: integer write SetOrderNumber;
    property DateComing: TDateTime write SetDateComing;
    property WhatIsDone: string write SetWhatIsDone;
  end;


implementation

{$R *.dfm}

procedure Tfrm_OrderShortInfo.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OrderShortInfo.SetDateComing(const Value: TDateTime);
begin
  lbl_DateComing.Caption:=DateToStr(Value);
end;

procedure Tfrm_OrderShortInfo.SetOrderNumber(const Value: integer);
begin
  lbl_OrderNumber.Caption:=IntToStr(Value);
end;

procedure Tfrm_OrderShortInfo.SetWhatIsDone(const Value: string);
begin
  mem_WhatIsDone.Text:=Value;
end;

end.
