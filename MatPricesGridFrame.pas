unit MatPricesGridFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridFrame, DB, IBDatabase, IBCustomDataSet, ExtCtrls, Grids,
  DBGridEh, RxLookup, StdCtrls, DModule, Mask, DBCtrls;

type
  Tframe_MatPricesGrid = class(Tframe_BaseGrid)
    pnl_Master: TPanel;
    dbl_Mater: TRxDBLookupCombo;
    Label1: TLabel;
    dset_Mater: TIBDataSet;
    ds_Mater: TDataSource;
    dset_MainID: TIntegerField;
    dset_MainFK_MATPRICES_REGIONS: TIntegerField;
    dset_MainREGIONS: TIBStringField;
    dset_MainFK_MATPRICES_MATERIALS: TIntegerField;
    dset_MainNUMBER: TIBStringField;
    dset_MainPRICE: TIBBCDField;
    dset_MainQUANTITY: TIBBCDField;
    dset_MainQUANTITYREST: TIBBCDField;
    dset_Regions: TIBDataSet;
    ds_Regions: TDataSource;
    dbl_Regions: TRxDBLookupCombo;
    ed_Number: TDBEdit;
    ed_Price: TDBEdit;
    ed_Quantity: TDBEdit;
    ed_QuantityRest: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
  private
    procedure OpenMainDset; override;
    procedure OpenVocDset; override;
    function IsDataFieldsCorrect: boolean; override;
    function IsMatCorrect: boolean;
  public
    procedure Append; override;
    procedure Edit; override;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_MatPricesGrid }

procedure Tframe_MatPricesGrid.Append;
begin
  if IsMatCorrect then
  begin
    inherited Append;
    dset_Main.FieldByName('fk_matprices_materials').AsInteger:=
      dset_Mater.FieldByName('id').AsInteger;
  end;
end;

procedure Tframe_MatPricesGrid.Edit;
begin
  if IsMatCorrect then
  begin
    inherited Edit;
  end;
end;

function Tframe_MatPricesGrid.IsDataFieldsCorrect: boolean;
begin
  Result:=false;
{
  if IsDBLEmpty(dbl_Regions) then
  begin
    SetProcessStatus('Введите район');
    exit;
  end;
}
  if trim(ed_Price.Text)='' then
  begin
    SetProcessStatus('Введите цену на материал');
    exit;
  end;


  Result:=true;
end;

function Tframe_MatPricesGrid.IsMatCorrect: boolean;
begin
  Result:=(dset_Mater.FieldByName('id').AsInteger<>-1);

  if not Result then
    Application.MessageBox('Прежде необходимо выбрать материал',
          'Внимание', MB_OK+MB_ICONWARNING);
end;

procedure Tframe_MatPricesGrid.OpenMainDset;
begin
  dset_Main.Open;
end;

procedure Tframe_MatPricesGrid.OpenVocDset;
begin
  dset_Mater.Open;
  dset_Regions.Open;
end;

end.
