unit PeriodRegBlagSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_PeriodRegBlagSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    btn_Regions: TBitBtn;
    chk_Blag: TCheckBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure dp_Date1Change(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dp_Date2Change(Sender: TObject);
  private
    F_Regions: string;

    F_strRegions: string;
    F_strStartDate: string;
    F_strFinishedDate: string;

    F_ResultCondition: string;
    F_ShortTableName: string;
  public
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;
    property strRegions: string read F_strRegions;
    property ResultCondition: string read F_ResultCondition;
    property ShortTableName: string write F_ShortTableName;
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm;

procedure Tfrm_PeriodRegBlagSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_ResultCondition:='';

  F_strRegions:='Все';
  F_strStartDate:='';
  F_strFinishedDate:='';

  if (F_ShortTableName<>'') and (pos('.', F_ShortTableName)=0) then
    F_ShortTableName:=F_ShortTableName+'.';
end;

procedure Tfrm_PeriodRegBlagSel.dp_Date1Change(Sender: TObject);
begin
  if dp_Date1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Date1.Date);
end;

procedure Tfrm_PeriodRegBlagSel.btn_RegionsClick(Sender: TObject);
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
    F_Regions:=Format('%sFK_ORDERS_REGIONS in %s', [F_ShortTableName, ItemsID]);
    F_strRegions:=ItemsName;
  end;
end;

procedure Tfrm_PeriodRegBlagSel.btn_okClick(Sender: TObject);
var
  AddCondSQL: string;
begin
  F_ResultCondition:=' where 1=1';

  if dp_Date1.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateComing>=''%s'' ', [F_ShortTableName, DateToStr(dp_Date1.Date)]);

  if dp_Date2.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateComing<=''%s'' ',
      [F_ShortTableName, DateToStr(dp_Date2.Date+1)]);

  if trim(F_Regions)<>'' then
    F_ResultCondition:=F_ResultCondition+' and '+F_Regions;

  if not chk_Blag.Checked then
  begin
    AddCondSQL:=' and'+
                ' ('+
                '     ('+
                '         fk_Orders_DamageLocality in (1,2,6,7) and'+
                '         not exists'+
                '             ('+
                '             select id'+
                '             from Excavations'+
                '             where fk_excavations_excwt in (5, 8) and'+  // chenged by Vadim 12.01.2009
                '             fk_excavations_orders=%sid'+
                '             )'+
                '     )'+
                '     or'+
                '     ('+
                '         fk_Orders_DamageLocality in (3,5) and'+ 
//                '         fk_Orders_DamageLocality=3 and'+
                '         not exists'+
                '             ('+
                '             select id'+
                '             from Excavations'+
                '             where fk_excavations_excwt=6 and'+
                '             fk_excavations_orders=%sid'+
                '             )'+
                '     )'+
                ' )';

    F_ResultCondition:=F_ResultCondition+Format(AddCondSQL,
      [F_ShortTableName, F_ShortTableName]);
  end;

  ModalResult:=mrOk;
end;

constructor Tfrm_PeriodRegBlagSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodRegBlagSel.FormCreate(Sender: TObject);
begin
  F_ShortTableName:='';
end;

procedure Tfrm_PeriodRegBlagSel.dp_Date2Change(Sender: TObject);
begin
  if dp_Date2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Date2.Date);
end;

end.
