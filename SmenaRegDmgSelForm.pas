unit SmenaRegDmgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_SmenaRegDmgSel = class(Tfrm_BaseOption)
    dp_Smena: TDateEdit;
    btn_Region: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_Ok: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_RegionClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    F_DamagePlace: string;
    F_Regions: string;
    F_strDamagePlace: string;
    F_strRegions: string;
    F_strDate: string;

    F_ResultCondition: string;
  public
    property strDamagePlace: string read F_strDamagePlace;
    property strRegions: string read F_strRegions;
    property strDate: string read F_strDate;
    property ResultCondition: string read F_ResultCondition;
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

procedure Tfrm_SmenaRegDmgSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';
  F_ResultCondition:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
  F_strDate:='';
end;

procedure Tfrm_SmenaRegDmgSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_DamagePlace:='FK_ORDERS_DAMAGEPLACE in '+ItemsID;
    F_strDamagePlace:=ItemsName;
  end;
end;



procedure Tfrm_SmenaRegDmgSel.btn_RegionClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_Regions:='FK_ORDERS_REGIONS in '+ItemsID;
    F_strRegions:=ItemsName;
  end;
end;

procedure Tfrm_SmenaRegDmgSel.btn_OkClick(Sender: TObject);
var
  SelSmena: string;
begin
  if dp_Smena.Date=0 then
  begin
    MessageDlg('Введите дату смены', mtError, [mbOk], 1);
    exit;
  end;

  if trunc(dp_Smena.Date)>trunc(Date-1) then
  begin
    MessageDlg('Дата смены должна быть меньше текущей', mtError, [mbOk], 1);
    exit;
  end;


  SelSmena:=DateTimeToStr(dp_Smena.date+1+StrToTime('8:00:00'));
  F_strDate:=DateToStr(dp_Smena.Date);

  F_ResultCondition:=F_ResultCondition+' where DateComing<'''+SelSmena+
                              ''' and (DateClosed>='''+SelSmena+''' or DateClosed is null)';
  if trim(F_Regions)<>'' then
    F_ResultCondition:=F_ResultCondition+' and '+F_Regions;

  if trim(F_DamagePlace)<>'' then
    F_ResultCondition:=F_ResultCondition+' and '+F_DamagePlace;

  ModalResult:=mrOk;
end;

end.
