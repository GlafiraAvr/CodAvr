unit AnLeakDiamSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Buttons, BaseOptionForm;

type
  Tfrm_AnLeakDiamSel = class(Tfrm_BaseOption)
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_TubeDiameter: TBitBtn;
    btn_DamageType: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_TubeDiameterClick(Sender: TObject);
    procedure btn_DamageTypeClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_Regions: string;
    F_DamagePlace: string;
    F_TubeDiameter: string;
    F_DamageType: string;

    F_strRegions: string;
    F_strDamagePlace: string;
  public
    property Regions: string read F_Regions;
    property DamagePlace: string read F_DamagePlace;
    property TubeDiameter: string read F_TubeDiameter;
    property DamageType: string read F_DamageType;
    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;

    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

constructor Tfrm_AnLeakDiamSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_AnLeakDiamSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AnLeakDiamSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';
  F_TubeDiameter:='';
  F_DamageType:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
end;

procedure Tfrm_AnLeakDiamSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnLeakDiamSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, F_strDamagePlace);
end;

procedure Tfrm_AnLeakDiamSel.btn_TubeDiameterClick(Sender: TObject);
var
  SQL, ItemsName: string;
begin
  SQL:= ' select id ItemID, diameter ItemName'+
        ' from s_tubediameter'+
        ' where id<>-1 and activity is null'+
        ' order by diameter';

  ShowSelectItemsDlg(SQL, 'Диаметер', F_TubeDiameter, ItemsName);
end;

procedure Tfrm_AnLeakDiamSel.btn_DamageTypeClick(Sender: TObject);
var
  SQL,ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagetype'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Тип повреждения', F_DamageType, ItemsName);
end;

procedure Tfrm_AnLeakDiamSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Необходимо ввести начало периода','ДиспетчерАВР',MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then dp_Date2.Date:=Date;
    ModalResult:=mrOk;
  end;
end;

end.
