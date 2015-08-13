unit OptRepDiscon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit,
  SelRegionFrame;

type
  Tfrm_OptRepDiscon = class(Tfrm_BaseOption)
    de_beg: TDateEdit;
    de_End: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    frame_SelRegion: Tframe_SelRegion;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    F_RegionsID: string;
    F_RegionsName: string;
    F_DTBeg: TDate;
    F_DTEnd: TDate;
  public
    constructor Create(AOwner: TComponent; ATitle: string);
    property RegionsID: string read F_RegionsID;
    property RegionsName: string read F_RegionsName;
    property DTBeg: TDate read F_DTBeg;
    property DTEnd: TDate read F_DTEnd;
  end;

implementation

{$R *.dfm}

{ Tfrm_OptRepDiscon }

constructor Tfrm_OptRepDiscon.Create(AOwner: TComponent; ATitle: string);
begin
  inherited Create(AOwner);
  Caption:=ATitle;
end;

procedure Tfrm_OptRepDiscon.btn_okClick(Sender: TObject);
begin
  inherited;
  if de_Beg.Date=0 then
  begin
    Application.MessageBox('Введите дату начала периода!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if de_End.Date=0 then de_End.Date:=Date;

  if de_Beg.Date>de_End.Date then
  begin
    Application.MessageBox('Дата начала не может быть больше даты окончания!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_DTBeg:=de_Beg.Date;
  F_DTEnd:=de_End.Date;
  frame_SelRegion.SetRegions(F_RegionsID, F_RegionsName);

  ModalResult:=mrOk;  
end;

procedure Tfrm_OptRepDiscon.btn_exitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
