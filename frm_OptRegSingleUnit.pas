unit frm_OptRegSingleUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls,
  IBDatabase, DB, IBCustomDataSet, RxLookup;

type
  Tfrm_OptRegSingle = class(Tfrm_BaseOption)
    Bevel1: TBevel;
    Label1: TLabel;
    de_beg: TDateEdit;
    Label2: TLabel;
    de_End: TDateEdit;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dset: TIBDataSet;
    tran: TIBTransaction;
    dbl_Reg: TRxDBLookupCombo;
    ds_Items: TDataSource;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    F_DTBeg: TDate;
    F_DTEnd: TDate;
    F_RegID: integer;
    procedure InitList;
  public
    { Public declarations }
    property DTBeg: TDate read F_DTBeg;
    property DTEnd: TDate read F_DTEnd;
    property RegID: integer read F_RegID;
    constructor Create(AOwner: TComponent; ATitle: string);
  end;

var
  frm_OptRegSingle: Tfrm_OptRegSingle;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions, RightsManagerDModule;

constructor Tfrm_OptRegSingle.Create(AOwner: TComponent; ATitle: string);
begin
  inherited Create(AOwner);
  Caption:=ATitle;

end;

procedure Tfrm_OptRegSingle.InitList;
var
  SQL: string;
begin
   F_RegID := 0;
  SQL:=
      ' select dd.id_region ID, sr.name Name'+
      ' from db_districtregion dd'+
      '  join s_regions sr on ( dd.id_region = sr.id )'+
      ' where id_district= '+ inttostr(DM_RightsManager.CurrentDistrictID) ;

   dset.SelectSQL.Text := SQL;
   dset.Open;
   FixDBLValue(dset.fieldbyname('ID').AsInteger, dbl_Reg);
end;


procedure Tfrm_OptRegSingle.btn_okClick(Sender: TObject);
begin
  inherited;
  if de_Beg.Date=0 then
  begin
    Application.MessageBox('Введите дату начала периода!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if de_End.Date=0 then de_End.Date:=Date;

  if de_Beg.Date>de_End.Date then
  begin
    Application.MessageBox('Дата начала не может быть больше даты окончания!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_RegID := dbl_Reg.LookupSource.DataSet.fieldbyname('ID').AsInteger;  

  if F_RegID = 0 then
  begin
    Application.MessageBox('Выберите район!',
      'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_DTBeg:=de_Beg.Date;
  F_DTEnd:=de_End.Date;
  //frame_SelRegion.SetRegions(F_RegionsID, F_RegionsName);

  ModalResult:=mrOk;
end;

procedure Tfrm_OptRegSingle.btn_exitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptRegSingle.FormCreate(Sender: TObject);
begin
  inherited;
  InitList;
end;

end.
