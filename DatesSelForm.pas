unit DatesSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_DatesSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_Ok: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_OkClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent; const Title: string);
  end;


implementation

{$R *.dfm}

uses StringConsts;

{ Tfrm_DatesSel }

constructor Tfrm_DatesSel.Create(AOwner: TComponent; const Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_DatesSel.btn_OkClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('¬ведите дату начала',gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;

  if dp_Date2.Date=0 then
    dp_Date2.Date:=Date;

  if dp_Date1.Date>dp_Date2.Date then
  begin
    Application.MessageBox('ƒата окончани€ периода не можит быть меньше даты начала',
      gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;



  ModalResult:=mrOk;
end;

end.
