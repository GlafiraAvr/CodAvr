unit PeriodExcSpredSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons;

type
  Tfrm_PeriodExcSpreadSel = class(Tfrm_BaseOption)
    dp_date1: TDateEdit;
    dp_date2: TDateEdit;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    CB_DExcOnly: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses HelpFunctions, ExcSpreadSheet, StringConsts;

procedure Tfrm_PeriodExcSpreadSel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure Tfrm_PeriodExcSpreadSel.btn_okClick(Sender: TObject);
var
  fmExcSprSheet: TfmExcSprSheet;
begin
  if not IsDateCorrect(dp_Date1.Text) then
  begin
    Application.MessageBox('Неправильно введена дата начала', gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;

  if not IsDateCorrect(dp_Date2.Text) then
  begin
    Application.MessageBox('Неправильно введена дата окончания', gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if dp_Date1.Date>dp_Date2.Date then
  begin
    Application.MessageBox('Дата начала не может быть больше даты окончания', gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  fmExcSprSheet:=TfmExcSprSheet.CreateParam(self, dp_Date1.Date, dp_Date2.Date, CB_DExcOnly.checked);
  fmExcSprSheet.ShowModal;
end;

procedure Tfrm_PeriodExcSpreadSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
