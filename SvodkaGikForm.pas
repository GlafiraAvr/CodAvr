unit SvodkaGikForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls, BaseOptionForm;

type
  Tfrm_SvodkaGik = class(Tfrm_BaseOption)
    dp_Date: TDateEdit;
    lbl_Date: TLabel;
    chb_ForGen: TCheckBox;
    bb_ok: TBitBtn;
    bb_exit: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnl: TPanel;
    bv_ShiftNumber: TBevel;
    bv_Equip: TBevel;
    lbl_Equip: TLabel;
    lbl_ShiftNumber: TLabel;
    cb_Equip: TComboBox;
    cb_ShiftNumber: TComboBox;
    chb_ReCreate: TCheckBox;
    procedure bb_okClick(Sender: TObject);
    procedure bb_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_IsShowDopPnl: boolean;
    F_IsEquipPrint: boolean;
    F_IsShiftNumberUchit: boolean;
    F_IsReCreate: boolean;
    F_IsForGen: boolean;
  public
    property IsShowDopPnl: boolean read F_IsShowDopPnl write F_IsShowDopPnl;
    property IsEquipPrint: boolean read F_IsEquipPrint;
    property IsShiftNumberUchit: boolean read F_IsShiftNumberUchit;
    property IsReCreate: boolean read F_IsReCreate;
    property IsForGen: boolean read F_IsForGen;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, StringConsts;

procedure Tfrm_SvodkaGik.bb_okClick(Sender: TObject);
var tt:ttime;
begin
   tt:=StrToTime('08:20:00');
  if dp_Date.Date=0 then
  begin
    Application.MessageBox('Дата введена неверно. Попробуйте еще раз.',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_IsEquipPrint:=(cb_Equip.ItemIndex=0);
  F_IsShiftNumberUchit:=(cb_ShiftNumber.ItemIndex=0) and (cb_ShiftNumber.Visible);
  F_IsReCreate:=chb_ReCreate.Checked;
  F_IsForGen:=chb_ForGen.Checked;
  // Малеев 15.08.11
  
  Time ;
  if F_IsReCreate then
  begin
    if (dp_Date.Date<(Date-1))  or ((dp_Date.Date=(Date-1)) and (Time >tt))then
    begin
      Application.MessageBox('Дата введена неверно. Формировать заново сводку чужой смены нельзя. Попробуйте еще раз.',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
      exit;
    end;

  end;

  ModalResult:=mrOk;
end;

procedure Tfrm_SvodkaGik.bb_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SvodkaGik.FormCreate(Sender: TObject);
begin
 dp_Date.Date:=Date-1;

  F_IsShowDopPnl:=true;
end;

procedure Tfrm_SvodkaGik.FormShow(Sender: TObject);
begin
  inherited;
  pnl.Visible:=F_IsShowDopPnl;
end;

end.
