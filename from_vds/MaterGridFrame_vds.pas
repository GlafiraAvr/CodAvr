unit MaterGridFrame_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WorkAndMaterBaseGrid_vds, DB, IBCustomDataSet, StdCtrls, Mask,
  DBCtrls, RxLookup, IBDatabase, ExtCtrls, Grids, DBGridEh;

type
  Tframe_MaterGrid_vds = class(Tframe_WorkAndMaterBaseGrid_vds)
    Label1: TLabel;
    dbl_Mater: TRxDBLookupCombo;
    Label4: TLabel;
    dbl_MatPrices: TRxDBLookupCombo;
    ed_quantity: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    dbl_Diam: TRxDBLookupCombo;
    dset_MatPrices: TIBDataSet;
    dset_MatPricesID: TIntegerField;
    dset_MatPricesNUMBER: TIBStringField;
    dset_MatPricesPRICE: TIBBCDField;
    dset_MatPricesQUANTITY: TIBBCDField;
    dset_MatPricesQUANTITYREST: TIBBCDField;
    ds_MatPrices: TDataSource;
    dset_Mater: TIBDataSet;
    ds_Mater: TDataSource;
    dset_Diam: TIBDataSet;
    ds_Diam: TDataSource;
    dset_MainID: TIntegerField;
    dset_MainFK_USEDMATERIALS_ORDERS: TIntegerField;
    dset_MainFK_USEDMATERIALS_DEPARTURE: TIntegerField;
    dset_MainFK_USEDMATERIALS_MATERIALS: TIntegerField;
    dset_MainISPAYED: TSmallintField;
    dset_MainQUANTITY: TIBBCDField;
    dset_MainFK_USEDMATERIALS_DIAMETER: TIntegerField;
    dset_MainNOMENNUMBER: TIBStringField;
    dset_MainPRICE: TIBBCDField;
    dset_MainMATPRICES_QUANTITY: TIBBCDField;
    dset_MainMATER_NAME: TIBStringField;
    dset_MainDIAM: TIntegerField;
    dset_MainMATPRICES: TStringField;
    procedure dset_MatPricesNUMBERGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbl_MaterChange(Sender: TObject);
    procedure dset_MainCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }

  protected
    procedure OpenVocDset; override;
    function IsDataFieldsCorrect: boolean; override;
    procedure AddMatPrices;
  public
    procedure Append; override;
    function Post: boolean; override;
    procedure Edit; override;
  end;

var
  frame_MaterGrid_vds: Tframe_MaterGrid_vds;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tframe_MaterGrid_vds.Append;
begin
  inherited Append;
  dset_Main.FieldByName('FK_USEDMATERIALS_ORDERS').AsInteger:=F_OrderID;
  dset_Main.FieldByName('FK_USEDMATERIALS_DEPARTURE').AsInteger:=F_DepID;

  dbl_MatPrices.Value:='';
end;

function Tframe_MaterGrid_vds.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Mater) then
  begin
    dbl_Mater.SetFocus;
    SetProcessStatus('Введите наименование материала');
    exit;
  end;

  Result:=true;
end;

procedure Tframe_MaterGrid_vds.OpenVocDset;
begin
  if not dset_Mater.Active then
    dset_Mater.Open;
  if not dset_Diam.Active then
    dset_Diam.Open;
  if not dset_MatPrices.Active then
    dset_MatPrices.Open;
end;


procedure Tframe_MaterGrid_vds.dset_MatPricesNUMBERGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);

var
  number, price, quantity: string;
begin
  inherited;

   number:=''; price:=''; quantity:='';

  if not dset_MatPrices.FieldByName('number').IsNull then
    number:=trim(dset_MatPrices.FieldByName('number').AsString);

  if not dset_MatPrices.FieldByName('price').IsNull then
    price:=FormatFloat('0.##', dset_MatPrices.FieldByName('price').AsFloat);

  if not dset_MatPrices.FieldByName('quantity').IsNull then
    quantity:=FormatFLoat('0.##', dset_MatPrices.FieldByName('quantity').AsFloat);

  Text:=Format('%s / %s / %s', [number, price, quantity]);

end;

procedure Tframe_MaterGrid_vds.dbl_MaterChange(Sender: TObject);
begin
  inherited;
  dbl_MatPrices.Value:='';
end;

procedure Tframe_MaterGrid_vds.dset_MainCalcFields(DataSet: TDataSet);
var
  number, price, quantity: string;
begin
  inherited;
  number:=''; price:=''; quantity:='';

  if not DataSet.FieldByName('nomennumber').IsNull then
    number:=trim(DataSet.FieldByName('nomennumber').AsString);

  if not DataSet.FieldByName('price').IsNull then
    price:=FormatFloat('0.##', DataSet.FieldByName('price').AsFloat);

  if not DataSet.FieldByName('matprices_quantity').IsNull then
    quantity:=FormatFLoat('0.##', DataSet.FieldByName('matprices_quantity').AsFloat);

  DataSet.FieldByName('MatPrices').AsString:=Format('%s / %s / %s', [number, price, quantity]);
end;


procedure Tframe_MaterGrid_vds.AddMatPrices;
  procedure AddValue(MainDsetFieldName, MatPricesFieldName: string);
  begin
    if not dset_MatPrices.FieldByName(MatPricesFieldName).IsNull then
      dset_Main.FieldByName(MainDsetFieldName).Value:=dset_MatPrices.FieldByName(MatPricesFieldName).Value;
  end;

begin
  if dbl_MatPrices.Value<>'' then
  begin
    AddValue('NomenNumber', 'Number');
    AddValue('Price', 'Price');
    AddValue('MatPrices_Quantity','Quantity');
  end else
  begin
    dset_Main.FieldByName('NomenNumber').Clear;
    dset_Main.FieldByName('Price').Clear;
    dset_Main.FieldByName('MatPrices_Quantity').Clear;
  end;
end;

function Tframe_MaterGrid_vds.Post: boolean;
begin
  if dset_Main.State in [dsInsert, dsEdit] then
    AddMatPrices;

  inherited Post;
end;

procedure Tframe_MaterGrid_vds.Edit;
begin
  inherited Edit;
  dbl_MatPrices.Value:='';
end;

end.
