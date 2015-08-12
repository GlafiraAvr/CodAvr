unit AnLeakTimeSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, CheckLst, Mask, ToolEdit, Buttons;

type
  Tfrm_AnLeakTimeSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    chl_Dates: TCheckListBox;
    btn_Fill: TBitBtn;
    btn_FillAndCheck: TBitBtn;
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_Ok: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_FillClick(Sender: TObject);
    procedure btn_FillAndCheckClick(Sender: TObject);
  private
    F_Regions: string;
    F_DamagePlace: string;

    function IsDatesEnter: boolean;
    procedure FillDates;
    procedure CheckDates;
  public
    property Regions: string read F_Regions;
    property DamagePlace: string read F_DamagePlace;
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses SelectItemForm, StringConsts;

{ Tfrm_AnLeakTimeSel }

constructor Tfrm_AnLeakTimeSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_AnLeakTimeSel.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AnLeakTimeSel.btn_OkClick(Sender: TObject);
begin
  if not IsDatesEnter then exit;

  if chl_Dates.Items.Count<1 then
  begin
    Application.MessageBox('Список дат пуст, необходимо вести хотя бы одно значение',
                          gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  ModalResult:=mrOk;
end;

procedure Tfrm_AnLeakTimeSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';
end;

procedure Tfrm_AnLeakTimeSel.btn_RegionsClick(Sender: TObject);
var
  SQL, str: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, str);
end;

procedure Tfrm_AnLeakTimeSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL, str: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, str);
end;

function Tfrm_AnLeakTimeSel.IsDatesEnter: boolean;
begin
  Result:=false;

  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Введите дату начала',gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;

  Result:=true;
end;

procedure Tfrm_AnLeakTimeSel.btn_FillClick(Sender: TObject);
begin
  FillDates;
end;

procedure Tfrm_AnLeakTimeSel.FillDates;
var
  i, dt_count: integer;
begin
  if not IsDatesEnter then exit;

  dt_count:=trunc(dp_Date2.Date)-trunc(dp_Date1.Date)+1;

  chl_Dates.Items.Clear;
  for i:=0 to dt_count-1 do
    chl_Dates.Items.Add(DateToStr(dp_Date1.Date+i));
end;

procedure Tfrm_AnLeakTimeSel.CheckDates;
var
  i: integer;
begin
  for i:=0 to chl_Dates.Items.Count-1 do
    chl_Dates.Checked[i]:=true;
end;

procedure Tfrm_AnLeakTimeSel.btn_FillAndCheckClick(Sender: TObject);
begin
  FillDates;
  CheckDates;
end;

end.
