unit PeriodRegPlaceTypeSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, RXSpin, Mask, ToolEdit;

type
  Tfrm_PeriodRegPlaceTypeSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    sp_DayCount: TRxSpinEdit;
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_DamageType: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_DamageTypeClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_RegionsID: string;
    F_DamagePlaceID: string;
    F_DamageTypeID:string;

    F_strRegions: string;
    F_strDamagePlace: string;
    F_strDamageType: string;
  public
    property RegionsID: string read F_RegionsID;
    property DamagePlaceID: string read F_DamagePlaceID;
    property DamageTypeID: string read F_DamageTypeID;

    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;
    property strDamageType: string read F_strDamageType;

    constructor Create(AOwner: TComponent; Title: string);
  end;

var
  frm_PeriodRegPlaceTypeSel: Tfrm_PeriodRegPlaceTypeSel;

implementation

{$R *.dfm}

uses SelectItemForm, StringConsts;

{ Tfrm_PeriodRegPlaceTypeSel }

constructor Tfrm_PeriodRegPlaceTypeSel.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodRegPlaceTypeSel.FormShow(Sender: TObject);
begin
  F_RegionsID:='';
  F_DamagePlaceID:='';
  F_DamageTypeID:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
  F_strDamageType:='Все';
end;

procedure Tfrm_PeriodRegPlaceTypeSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_RegionsID, F_strRegions);
end;

procedure Tfrm_PeriodRegPlaceTypeSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlaceID, F_strDamagePlace);
end;

procedure Tfrm_PeriodRegPlaceTypeSel.btn_DamageTypeClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagetype'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Тип повреждения', F_DamageTypeID, F_strDamageType);
end;

procedure Tfrm_PeriodRegPlaceTypeSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_PeriodRegPlaceTypeSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Введите дату начала!', gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then
      dp_Date2.Date:=Date;

    ModalResult:=mrOk;  
  end;
end;

end.
