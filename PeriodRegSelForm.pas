unit PeriodRegSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Mask, ToolEdit, Buttons, ExtCtrls;

type
  Tfrm_PeriodRegSel = class(Tfrm_BaseOption)
    btn_Regions: TBitBtn;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btn_asfcompany: TBitBtn;
    cb_Type: TComboBox;
    procedure btn_RegionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_asfcompanyClick(Sender: TObject);
  private
    F_RegionsID: string;
    F_strRegions: string;
    F_asfcompanyID:string; //glasha 12.04.2012
    F_asfcompanyString:string;

  public
    property RegionsID: string read F_RegionsID;
    property strRegions: string read F_strRegions;

    property asfcompanyID: string read F_asfcompanyID;
    property asfcompanyString: string read F_asfcompanyString;
    constructor Create(AOwner: TComponent; Title: string);
  end;

var
  frm_PeriodRegSel: Tfrm_PeriodRegSel;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions, StringConsts;


procedure Tfrm_PeriodRegSel.btn_RegionsClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_RegionsID, F_strRegions, wcName);
end;

constructor Tfrm_PeriodRegSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodRegSel.FormShow(Sender: TObject);
begin
  F_RegionsID:='';
  F_strRegions:='Все';
end;

procedure Tfrm_PeriodRegSel.btn_okClick(Sender: TObject);
begin
  if not IsDateCorrect(dp_Date1.Text) then
  begin
    Application.MessageBox('Проверте правильность ввода даты начала', gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_Date2.Date=0 then dp_Date2.Date:=Date;

  if not IsDateCorrect(dp_Date2.Text) then
  begin
    Application.MessageBox('Проверте правильность ввода даты окончания', gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  ModalResult:=mrOk;
end;

procedure Tfrm_PeriodRegSel.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_PeriodRegSel.btn_asfcompanyClick(Sender: TObject);
var  SQL:string;
begin
  inherited;
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_asfcompany'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Подрядчик', F_asfcompanyID, F_asfcompanyString, wcName);
end;

end.
