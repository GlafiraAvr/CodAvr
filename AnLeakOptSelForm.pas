unit AnLeakOptSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Buttons, BaseOptionForm;

type
  TPeriodType=(ptSmena, ptSutki);

  Tfrm_AnLeakOptSel = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    lbl_s: TLabel;
    lbl_po: TLabel;
    procedure dp_Date1Change(Sender: TObject);
    procedure dp_Date2Change(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_Regions: string;
    F_DamagePlace: string;

    F_strDamagePlace: string;
    F_strRegions: string;
    F_strStartDate: string;
    F_strFinishedDate: string;

    F_PeriodType: TPeriodType;
  public
    property Regions: string read F_Regions;
    property DamagePlace: string read F_DamagePlace;
    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;

    constructor Create(AOwner: TComponent; Title: string; APeriodType: TPeriodType);
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

procedure Tfrm_AnLeakOptSel.dp_Date1Change(Sender: TObject);
begin
  if dp_Date1.Date<>0 then
    if F_PeriodType=ptSmena then
      F_strStartDate:=DateToStr(dp_Date1.Date)+' 8:00:00'
    else
      F_strStartDate:=DateToStr(dp_Date1.Date);
end;

procedure Tfrm_AnLeakOptSel.dp_Date2Change(Sender: TObject);
begin
  if dp_Date2.Date<>0 then
    if F_PeriodType=ptSmena then
      F_strFinishedDate:=DateToStr(dp_Date2.Date)+' 8:00:00'
    else
      F_strFinishedDate:=DateToStr(dp_Date2.Date);
end;

procedure Tfrm_AnLeakOptSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnLeakOptSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';

  F_strStartDate:='';
  F_strFinishedDate:='';
  F_strRegions:='Все';
  F_strDamagePlace:='Все';

  if F_PeriodType=ptSmena then
  begin
    dp_Date1.Date:=Date-1;
    dp_Date2.Date:=Date;
    lbl_s.Caption:='С 8:00';
    lbl_po.Caption:='по 8:00';
  end else
  begin
    lbl_s.Caption:='С';
    lbl_po.Caption:='по';
  end;

  dp_Date1Change(nil);
  dp_Date2Change(nil);
end;

procedure Tfrm_AnLeakOptSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, F_strDamagePlace);
end;

constructor Tfrm_AnLeakOptSel.Create(AOwner: TComponent; Title: string;
  APeriodType: TPeriodType);
begin
  inherited Create(AOwner);
  Caption:=Title;
  F_PeriodType:=APeriodType;
end;

procedure Tfrm_AnLeakOptSel.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AnLeakOptSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Введите дату начала периода','ДиспетчерАВР', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;

  ModalResult:=mrOk;
end;

end.
