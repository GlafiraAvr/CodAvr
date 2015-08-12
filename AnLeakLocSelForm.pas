unit AnLeakLocSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_AnLeakLocSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_Regions: TBitBtn;
    btn_DamageLocality: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_Ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_DamageLocalityClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    F_Regions: string;
    F_DamagePlace: string;
    F_DamageLocality: string;

    F_strRegions: string;
    F_strDamagePlace: string;
  public
    property Regions: string read F_Regions;
    property DamagePlace: string read F_DamagePlace;
    property DamageLocality: string read F_DamageLocality;
    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;

    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

procedure Tfrm_AnLeakLocSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

constructor Tfrm_AnLeakLocSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_AnLeakLocSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';
  F_DamageLocality:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
end;

procedure Tfrm_AnLeakLocSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnLeakLocSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, F_strDamagePlace);
end;

procedure Tfrm_AnLeakLocSel.btn_DamageLocalityClick(Sender: TObject);
var
  SQL, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagelocality'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Местность повреждения', F_DamageLocality, ItemsName);
end;

procedure Tfrm_AnLeakLocSel.btn_OkClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Необходимо ввести дату начала периода','ДиспетчерАВР', MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then dp_Date2.Date:=Date;
    ModalResult:=mrOk;
  end;
end;

end.
