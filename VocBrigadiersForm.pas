unit VocBrigadiersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocBrigadiers = class(Tfrm_BaseVoc)
    lbl_Name: TLabel;
    ed_Name: TDBEdit;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TIBStringField;
    rg_Type: TRadioGroup;
    dbl_Reg: TRxDBLookupCombo;
    lbl_reg: TLabel;
    dset_MainVocFK_BRIGADIERS_REGIONS: TIntegerField;
    dset_Reg: TIBDataSet;
    ds_Reg: TDataSource;
    procedure rg_TypeClick(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);
  private
    procedure VisibleRegCtrls(value: boolean);
    function GetIDReg: integer;
  protected
    procedure EnableCtrls(value: boolean);override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
  public
  end;

implementation

{$R *.dfm}

{ Tfrm_VocBrigadiers }

procedure Tfrm_VocBrigadiers.CloseDataset;
begin
  inherited CloseDataset; 
  dset_Reg.Close;
end;

procedure Tfrm_VocBrigadiers.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  ed_Name.Visible:=value;
  lbl_Name.Visible:=value;
end;

function Tfrm_VocBrigadiers.GetIDReg: integer;
begin
  case rg_type.ItemIndex of
    0: Result:=30;
    1: Result:=dset_Reg.FieldByName('ID').AsInteger;
    2: Result:=50;
  end;
  VisibleRegCtrls((rg_Type.ItemIndex=1));
end;

procedure Tfrm_VocBrigadiers.OpenDataset;
begin
  if not dset_reg.Active then dset_reg.Open;
  dbl_reg.DisplayValue:=dset_reg.FieldByName('name').AsString;

  {Задаем главный DataSet}
  if dset_MainVoc.Active then
    dset_MainVoc.Close;
  //dset_MainVoc.ParamByName('pID_REG').AsInteger:=30;

  dset_MainVoc.SelectSQL.Clear;
  dset_MainVoc.SelectSQL.Text:=
    ' select id, name, activity, fk_brigadiers_regions'+
    ' from brigadiers'+
    ' where id<>-1'+
    ' and fk_brigadiers_regions='+IntToStr(GetIDReg)+
    ' order by name';
  {/Задаем главный DataSet}

  inherited OpenDataset;
end;

procedure Tfrm_VocBrigadiers.VisibleRegCtrls(value: boolean);
begin
  lbl_Reg.Visible:=value;
  dbl_Reg.Visible:=value;
end;


procedure Tfrm_VocBrigadiers.rg_TypeClick(Sender: TObject);
begin
  OpenDataset;
end;

procedure Tfrm_VocBrigadiers.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_MainVoc.FieldByName('fk_brigadiers_regions').AsInteger:=GetIDReg;
end;

end.

