unit OptSvodVedForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls,
  SelRegionFrame;

type
  Tfrm_OptSvodVed = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    de_Date: TDateEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    chb_IsShowPreview: TCheckBox;
    frame_SelRegion: Tframe_SelRegion;
    procedure btn_okClick(Sender: TObject); dynamic;
    procedure btn_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    F_Dt: TDate;
    F_strRegions: string;
    F_RegionsID: string;
    F_IsShowPreview: boolean;
  public
    property Dt: TDate read F_Dt;
    property strRegions: string read F_strRegions;
    property RegionsID: string read F_RegionsID;
    property IsShowPreview: boolean read F_IsShowPreview;
  end;


implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions;

procedure Tfrm_OptSvodVed.btn_okClick(Sender: TObject);
begin
  inherited;
  if not IsDateCorrect(de_Date.Text) then
  begin
    Application.MessageBox('Дата введена неправильно', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if de_Date.Date>Date then
  begin
    Application.MessageBox('Дата не может быть больше текущей', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  frame_SelRegion.SetRegions(F_RegionsID, F_strRegions);

  F_Dt:=de_Date.Date;
  F_IsShowPreview:=chb_IsShowPreview.Checked;

  ModalResult:=mrOk;
end;

procedure Tfrm_OptSvodVed.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptSvodVed.FormShow(Sender: TObject);
begin
  inherited;
  F_strRegions:='Все';
  F_RegionsID:='';
end;

procedure Tfrm_OptSvodVed.FormCreate(Sender: TObject);
begin
  inherited;
  if (Date>2) then
  de_Date.Date:=Date-1;
end;

end.
