unit MiniSearchOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, VocItemSelBaseFrame, VocItemSelFrame,  GlobalVocCacheDModule,
  StdCtrls, BaseFrameOptionForm, ExtCtrls, SelDatePeriodFrame, Buttons;

type
  Tfrm_MiniSearchOpt = class(Tfrm_BaseFrameOption)
    mem_SelParams: TMemo;
    frame_StreetSel: Tframe_VocItemSel;
    frame_RegSel: Tframe_VocItemSel;
    frame_DmgPlaceSel: Tframe_VocItemSel;
    frame_Dates: Tframe_SelDatePeriod;
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure frame_RegSelbtn_selClick(Sender: TObject);
    procedure frame_StreetSelbtn_selClick(Sender: TObject);
  private
    procedure ShowSelParams;
  protected
    procedure OnSelFrameChange(Sender: TObject); override;
  public
  end;

implementation

{$R *.dfm}

procedure Tfrm_MiniSearchOpt.FormShow(Sender: TObject);
begin
  inherited;
  ResetSelFrames;
  ShowSelParams;
end;

procedure Tfrm_MiniSearchOpt.ShowSelParams;
begin
  with mem_SelParams do
  begin
    Clear;
    Lines.Add( 'Район: ' + frame_RegSel.ItemSelecter.SelItemList.ItemsName + ';' );
    Lines.Add( '' );
    Lines.Add( 'Улица: ' + frame_StreetSel.ItemSelecter.SelItemList.ItemsName  +  ';' );
    Lines.Add( '' );
    Lines.Add( 'Место повреждения: ' + frame_DmgPlaceSel.ItemSelecter.SelItemList.ItemsName  +  ';' );
  end;
end;

procedure Tfrm_MiniSearchOpt.OnSelFrameChange(Sender: TObject);
begin
  ShowSelParams;
end;

procedure Tfrm_MiniSearchOpt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_MiniSearchOpt.btn_okClick(Sender: TObject);
begin
  if frame_Dates.IsDatesCorrect then ModalResult := mrOK;
end;

procedure Tfrm_MiniSearchOpt.frame_RegSelbtn_selClick(Sender: TObject);
begin
  inherited;
  frame_RegSel.btn_selClick(Sender);

end;

procedure Tfrm_MiniSearchOpt.frame_StreetSelbtn_selClick(Sender: TObject);
begin
  inherited;
  frame_StreetSel.btn_selClick(Sender);

end;

end.
