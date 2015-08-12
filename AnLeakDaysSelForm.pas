unit AnLeakDaysSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RXSpin, Mask, ToolEdit, BaseOptionForm;

type
  Tfrm_AnLeakDaysSel = class(Tfrm_BaseOption)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    sp_begin: TRxSpinEdit;
    sp_end: TRxSpinEdit;
    btn_Regions: TBitBtn;
    btn_DamagePlace: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
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
  end;


implementation

{$R *.dfm}

uses SelectItemForm, StringConsts;

procedure Tfrm_AnLeakDaysSel.FormShow(Sender: TObject);
begin
  F_Regions:='';
  F_DamagePlace:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';

  if dp_Date1.Date=0 then dp_Date1.Date:=Date;
  if dp_Date2.Date=0 then dp_Date2.Date:=Date;
end;

procedure Tfrm_AnLeakDaysSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_Regions, F_strRegions);
end;

procedure Tfrm_AnLeakDaysSel.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlace, F_strDamagePlace);
end;

procedure Tfrm_AnLeakDaysSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AnLeakDaysSel.btn_okClick(Sender: TObject);
begin
  (* if (sp_end.Value-sp_begin.Value)>9 then
    Application.MessageBox('Разность между началом и концом интервала дней не должна превышать 9',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING)
  else *)
    ModalResult:=mrOk;
end;

end.
