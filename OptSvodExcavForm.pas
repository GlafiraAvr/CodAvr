unit OptSvodExcavForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrameOptionForm, StdCtrls, Buttons, VocItemSelBaseFrame,
  VocItemSelFrame, SelDatePeriodFrame, GlobalVocCacheDModule, ExtCtrls;

type
  Tfrm_OptSvodExcav = class(Tfrm_BaseFrameOption)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    frame_Region: Tframe_VocItemSel;
    frame_Dates: Tframe_SelDatePeriod;
    Bevel1: TBevel;
    cb_IsFinish: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;


implementation

{$R *.dfm}

procedure Tfrm_OptSvodExcav.FormCreate(Sender: TObject);
begin
  inherited;
  frame_Region.mt_VocAttach.AttachedTo := dm_GlobalVocCache.mt_s_regions;
end;

procedure Tfrm_OptSvodExcav.FormShow(Sender: TObject);
begin
  inherited;
  ResetSelFrames;
end;

procedure Tfrm_OptSvodExcav.btn_exitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptSvodExcav.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_Dates.IsDatesCorrect then
    ModalResult := mrOk;
end;

end.
