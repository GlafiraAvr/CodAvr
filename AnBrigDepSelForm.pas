unit AnBrigDepSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons;

type
  Tfrm_AnBrigDepSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_Regions: TBitBtn;
    btn_Brigadiers: TBitBtn;
    btn_DamageType: TBitBtn;
    btn_Ok: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_BrigadiersClick(Sender: TObject);
    procedure btn_DamageTypeClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    F_Regions: string;
    F_Brigadiers: string;
    F_DamageType: string;

    F_strRegions: string;
    F_strBrigadiers: string;
    F_strDamageType: string;
  public
    property Regions: string read F_Regions;
    property Brigadiers: string read F_Brigadiers;
    property DamageType: string read F_DamageType;

    property strRegions: string read F_strRegions;
    property strBrigadiers: string read F_strBrigadiers;
    property strDamageType: string read F_strDamageType;

    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm, StringConsts;

procedure Tfrm_AnBrigDepSel.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

constructor Tfrm_AnBrigDepSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_AnBrigDepSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_Brigadiers:='';
  F_DamageType:='';

  F_strRegions:='Все';
  F_strBrigadiers:='Все';
  F_strDamageType:='Все';
end;

procedure Tfrm_AnBrigDepSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnBrigDepSel.btn_BrigadiersClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from brigadiers'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Бригадир', F_Brigadiers, F_strBrigadiers);
end;

procedure Tfrm_AnBrigDepSel.btn_DamageTypeClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagetype'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Тип повреждения', F_DamageType, F_strDamageType);
end;

procedure Tfrm_AnBrigDepSel.btn_OkClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Необходимо ввести дату начала', gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then dp_Date2.Date:=Date;
    ModalResult:=mrOk;
  end;
end;

end.
