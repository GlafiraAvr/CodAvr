unit UtechkiNaVodosetiOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons, ExtCtrls;

type
  Tfrm_UtechkiNaVodosetiOpt = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_Dt_beg: TDateTime;
    F_Dt_end: TDateTime;
  public
    property Dt_beg: TDateTime read F_Dt_beg write F_Dt_beg;
    property Dt_end: TDateTime read F_Dt_end write F_Dt_end;
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses StringConsts;

{ Tfrm_UtechkiNaVodosetiOpt }

constructor Tfrm_UtechkiNaVodosetiOpt.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_UtechkiNaVodosetiOpt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_UtechkiNaVodosetiOpt.FormCreate(Sender: TObject);
var
  dt: TDate;
begin
  inherited;
  dt:=Date;
  dp_Date1.Date:=dt-1;
  dp_Date2.Date:=dt;
end;

procedure Tfrm_UtechkiNaVodosetiOpt.btn_okClick(Sender: TObject);
begin
  {Проверка правильности ввода}
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Дата начала периода введена неверно',
      gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then
  begin
    Application.MessageBox('Дата окончания периода введена неверно',
      gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  if (dp_Date1.Date>dp_Date2.Date) then
  begin
    Application.MessageBox('Дата начала периода не может быть больше даты окончания периода',
      gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;
  {/Проверка правильности ввода}

  F_Dt_beg:=StrToDateTime(DateToStr(dp_Date1.Date)+' 08:00');
  F_Dt_end:=StrToDateTime(DateToStr(dp_Date2.Date)+' 08:00');

  ModalResult:=mrOk;
end;

end.
