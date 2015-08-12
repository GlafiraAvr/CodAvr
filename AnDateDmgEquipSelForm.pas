unit AnDateDmgEquipSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_AnDateDmgEquipSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    chk_EquipPlanned: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    F_Regions: string;
    F_DamagePlace: string;

    F_strRegions: string;
    F_strDamagePlace: string;
  public
    property Regions: string read F_Regions;
    property DamagePlace: string read F_DamagePlace;

    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;

    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm, StringConsts;

{ Tfrm_AnDateDmgEquipSel }

constructor Tfrm_AnDateDmgEquipSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_AnDateDmgEquipSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
end;

procedure Tfrm_AnDateDmgEquipSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnDateDmgEquipSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, F_strDamagePlace);
end;

procedure Tfrm_AnDateDmgEquipSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Необходимо ввести начало периода!',gc_strDispAVR,MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then
      dp_Date2.Date:=Date;
    ModalResult:=mrOk;
  end;
end;

procedure Tfrm_AnDateDmgEquipSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
