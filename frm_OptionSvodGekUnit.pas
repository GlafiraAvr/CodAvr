unit frm_OptionSvodGekUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls;

type
  Tfrm_OptionSvodGek = class(Tfrm_BaseOption)
    Dt_end: TDateEdit;
    Dt_beg: TDateEdit;
    T_beg: TMaskEdit;
    T_end: TMaskEdit;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    F_DTBeg: TDateTime;
    F_DTEnd: TDateTime;
    { Private declarations }
  public
    { Public declarations }
    property DTBeg: TDateTime read F_DTBeg;
    property DTEnd: TDateTime read F_DTEnd;
    constructor Create(AOwner: TComponent; ATitle: string);
  end;

var
  frm_OptionSvodGek: Tfrm_OptionSvodGek;

implementation

{$R *.dfm}

constructor Tfrm_OptionSvodGek.Create(AOwner: TComponent; ATitle: string);
begin
  inherited Create(AOwner);
  Caption:=ATitle;

end;

procedure Tfrm_OptionSvodGek.btn_exitClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure Tfrm_OptionSvodGek.btn_okClick(Sender: TObject);
begin
  inherited;
   if dt_Beg.Date=0 then
  begin
    Application.MessageBox('Введите дату начала периода!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dt_End.Date=0 then dt_End.Date:=Date;

  if dt_Beg.Date>dt_End.Date then
  begin
    Application.MessageBox('Дата начала не может быть больше даты окончания!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;


  F_DTBeg:=StrToDateTime(dt_beg.Text+' '+t_beg.Text);
  F_DTEnd:=StrToDateTime(dt_End.Text+' '+t_end.Text);
  //frame_SelRegion.SetRegions(F_RegionsID, F_RegionsName);

  ModalResult:=mrOk;

end;

procedure Tfrm_OptionSvodGek.FormCreate(Sender: TObject);
begin
  inherited;
   T_beg.Text:='00:00';
   T_end.Text:='23:59';
end;

end.
