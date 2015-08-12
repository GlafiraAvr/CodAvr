unit DateDmgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_DateDmgSel = class(Tfrm_BaseOption)
    dp_Date: TDateEdit;
    btn_DamagePlace: TBitBtn;
    btn_Ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_DamagePlace: string;
    F_strDamagePlace: string;
    F_strDate: string;
    
    F_ResultCondition: string;
  public
    property strDamagePlace: string read F_strDamagePlace;
    property strDate: string read F_strDate;
    property ResultCondition: string read F_ResultCondition;
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

procedure Tfrm_DateDmgSel.btn_DamagePlaceClick(Sender: TObject);
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

procedure Tfrm_DateDmgSel.btn_OkClick(Sender: TObject);
var
  SelDate: string;
begin
  if dp_Date.Date=0 then
  begin
    MessageDlg('Введите дату выбора', mtError, [mbOk], 1);
    exit;
  end;

  if trunc(dp_Date.Date)>trunc(Date) then
  begin
    MessageDlg('Дата выбора не может быть больше текущей даты', mtError, [mbOk], 1);
    exit;
  end;

  F_strDate:=DateToStr(dp_Date.Date);
  F_ResultCondition:=F_ResultCondition+Format(' where DateClosed>''%s'' and DateClosed<=''%s'' ',
                                              [DateToStr(dp_Date.Date), DateToStr(dp_Date.Date+1)]);

  if trim(F_DamagePlace)<>'' then
    F_ResultCondition:=F_ResultCondition+' and '+F_DamagePlace;
      
  ModalResult:=mrOk;
end;

procedure Tfrm_DateDmgSel.FormShow(Sender: TObject);
begin
  F_DamagePlace:='';
  F_ResultCondition:='';

  F_strDamagePlace:='Все';
  F_strDate:='';
end;

end.
