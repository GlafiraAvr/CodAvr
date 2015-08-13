unit PeriodRegDmgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm_vds, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin, UniversalSearchForm, SelectItemForm;
const
 id_Vvod='2';
 Id_Mag='1';
 arr_ID_Damage_place :array [1..17] of string  =('2','19','5','22','14','15','3','4','39','1','11','18','16','10','7','13','6');

type
  Tfrm_PeriodRegDmgSel = class(Tfrm_UniversalSearch)
    chk_IsShort: TCheckBox;
    chk_IsMiddle: TCheckBox;
    procedure btn_okClick(Sender: TObject);
    procedure chk_IsShortClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
  private
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodRegDmgSel }

constructor Tfrm_PeriodRegDmgSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodRegDmgSel.OpenDataSets;
begin
//
end;

procedure Tfrm_PeriodRegDmgSel.btn_okClick(Sender: TObject);
begin
  inherited;
  if chk_IsShort.Checked then
    F_ResultCondition:=F_ResultCondition+' and (fk_orders_damageplace in(1,2))'
  else if chk_IsMiddle.Checked then
    //F_ResultCondition:=F_ResultCondition+' and (fk_orders_damageplace not in (4,8, 20)) ';
    if pos('FK_ORDERS_DAMAGEPLACE',F_ResultCondition)=0 then
     F_ResultCondition:=F_ResultCondition+' and (fk_orders_damageplace  in (2,19,5,22,14,15,3,4,39,1,11,18,16,10,7,13,6)) ';//

end;

procedure Tfrm_PeriodRegDmgSel.chk_IsShortClick(Sender: TObject);
begin
  inherited;
    chk_IsMiddle.Enabled := not chk_IsShort.Checked;
end;

procedure Tfrm_PeriodRegDmgSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
  ItemsIDList:TStringList;
  i:integer;
begin
  //inherited;
   SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  if chk_IsMiddle.Checked then
  begin
   ItemsIDList:=TStringList.Create;
   for i:=1 to 17 do
     ItemsIDList.Add(arr_ID_Damage_place[i]);
  end
  else
  if chk_IsShort.Checked then
  begin
   ItemsIDList:=TStringList.Create;
   ItemsIDList.Add(Id_Vvod);
   ItemsIDList.Add(Id_Mag);
  end
  else
   ItemsIDList:=nil;
  ShowSelectItemsDlg2(SQL, 'Место повреждения',ItemsIDList,ItemsID );
  if ItemsID<>'' then
  begin
    F_DamagePlace:=Format('%sFK_ORDERS_DAMAGEPLACE in %s', [F_ShortTableName, ItemsID]);
  //  F_strDamagePlace:=ItemsName;
  end;
  if ItemsIDList<>nil then ItemsIDList.Free;
  ItemsIDList:=nil; 
end;

end.
