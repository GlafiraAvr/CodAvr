unit OptPlanWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, DModule, DB, IBCustomDataSet, RxLookup,
  StdCtrls, Mask, ToolEdit, ExtCtrls, Buttons;

type
  Tfrm_OptPlanWork = class(Tfrm_BaseOption)
    Panel1: TPanel;
    de_Date: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    RxDBL_Region: TRxDBLookupCombo;
    dset_regions: TIBDataSet;
    dset_regionsID: TIntegerField;
    dset_regionsNAME: TIBStringField;
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    dset_regionsFULL_NAME: TIBStringField;
    procedure FormCreate(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

   F_Region_ID:integer;
    F_Date:TDate;
    f_REgion:string;
      procedure  OpenDset();
  public
    { Public declarations }
    property Region_ID:integer read F_Region_ID;
    property _Date:TDate read F_Date write F_Date;
    property REgion:string read F_Region;
  end;

var
  frm_OptPlanWork: Tfrm_OptPlanWork;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptPlanWork.OpenDset();
begin
try
 dset_regions.Open;
except on e:exception do
 begin
 Application.MessageBox(PChar('Ошибка формированиямписа районов!! Сводка запланироваеных работ'+#13+E.message),
  'Внимание', MB_OK+MB_ICONERROR);
  ModalResult:=mrCancel;
  Exit;
 end;
end ;
end;

procedure Tfrm_OptPlanWork.FormCreate(Sender: TObject);
begin
  inherited;
  OpenDset;
  F_Region_ID:=0;
end;

procedure Tfrm_OptPlanWork.btn_OKClick(Sender: TObject);
begin
  inherited;
  if not IsDateCorrect(de_Date.Text) then
 begin
  Application.MessageBox('Дата введена неправильно', 'Внимание', MB_OK+MB_ICONWARNING);
  exit;
 end;

if de_Date.Date>Date() then
 begin
  Application.MessageBox('Дата не может быть больше текущей', 'Внимание', MB_OK+MB_ICONWARNING);
  exit;
 end;
F_Date:=de_Date.Date;
{if StrToInt(RxDBL_Region.Value)<=0 then
  begin
  Application.MessageBox('Выберите район', 'Внимание', MB_OK+MB_ICONWARNING);
  exit;
 end;}
 if RxDBL_Region.Text<>'' then
F_Region_ID:=STrToInt(RxDBL_Region.Value);
if   F_Region_ID>0 then
f_Region:=dset_regions.Lookup('id',VarArrayof([F_REgion_Id]),'full_name')
else
f_Region:='';
ModalResult:=mrOk;
end;

procedure Tfrm_OptPlanWork.FormShow(Sender: TObject);
begin
  inherited;
if not dset_regions.Active then
 OpenDset;
end;

end.
