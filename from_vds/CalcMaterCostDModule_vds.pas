unit CalcMaterCostDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, IBCustomDataSet,
  IBDatabase, DModule, FR_DSet, FR_DBSet;

type
  Tdm_CalcMaterCost_vds = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    ResultDsetAdres: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetworks: TStringField;
    ResultDsetMater: TStringField;
    ResultDsetMeasurement: TStringField;
    ResultDsetQuantity: TFloatField;
    ResultDsetPrice: TFloatField;
    ResultDsetCost: TFloatField;
    ResultDsetStartDate: TDateField;
    tran: TIBTransaction;
    dset_tmp: TIBDataSet;
    frDset: TfrDBDataSet;
    dset_Maters: TIBDataSet;
    dset_Works: TIBDataSet;
    ResultDsetRowNumber: TIntegerField;
    procedure ResultDsetCalcFields(DataSet: TDataSet);
  private
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_MainSqlString: string;
    F_RecCountSqlString: string;
    F_RecordCount: integer;
    procedure SetSqlString;
    procedure SetRecordCount;
    function FillResultDset: boolean;
    function GetWorks(DepID: integer): string;
  public
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property RecordCount: integer read F_RecordCount;
    procedure Init;
    function PrepareDset: boolean;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_CalcMaterCost }


function Tdm_CalcMaterCost_vds.FillResultDset: boolean;
var
  RowNumber: integer;
begin
  ResultDset.Close;
  ResultDset.Open;

  RowNumber:=1;
  MyOpenIBDS(dset_tmp, F_MainSqlString);
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    ResultDset.Append;
    ResultDset.FieldByName('RowNumber').AsInteger:=RowNumber;
    ResultDset.FieldByName('Region').AsString:=dset_tmp.FieldByName('Region').AsString;
    ResultDset.FieldByName('StartDate').AsDateTime:=dset_tmp.FieldByName('StartDate').AsDateTime;
    ResultDset.FieldByName('Adres').AsString:=dset_tmp.FieldByName('Adres').AsString;
    ResultDset.FieldByName('Works').AsString:=GetWorks(dset_tmp.FieldByName('DepID').AsInteger);

    dset_Maters.Close;
    dset_Maters.ParamByName('pDepID').AsInteger:=dset_tmp.FieldByName('DepID').AsInteger;
    dset_Maters.Open;
    dset_Maters.First;
    while not dset_Maters.Eof do
    begin
      if ResultDset.State<>dsInsert then
        ResultDset.Append;
      ResultDset.FieldByName('Region').AsString:=dset_tmp.FieldByName('Region').AsString;
      ResultDset.FieldByName('Mater').AsString:=dset_Maters.FieldByName('Name').AsString;
      ResultDset.FieldByName('Measurement').AsString:=dset_Maters.FieldByName('Measurement').AsString;
      ResultDset.FieldByName('Quantity').AsFloat:=dset_Maters.FieldByName('Quantity').AsFloat;
      ResultDset.FieldByName('Price').AsFloat:=dset_Maters.FieldByName('Price').AsFloat;

      ResultDset.Post;
      dset_Maters.Next;
    end;

    if ResultDset.State in [dsEdit, dsInsert] then
      ResultDset.Post;

    inc(RowNumber);
    dset_tmp.Next;
  end;

  Result:=true;
end;

procedure Tdm_CalcMaterCost_vds.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_CalcMaterCost_vds.PrepareDset: boolean;
begin
  Result:=false;

  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_CalcMaterCost.PrepareDset)');
    end;
  end;

  Result:=true;
end;

procedure Tdm_CalcMaterCost_vds.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

procedure Tdm_CalcMaterCost_vds.SetSqlString;
var
  RegCond, DtCond, SqlBottom: string;
begin
  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (d.StartDate>%s) and (d.StartDate<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Departures_vds d'+
    ' left join Orders_vds o on o.id=d.fk_departures_orders'+
    ' where'+
    ' exists(select dm.id from departurematerials_vds dm where dm.fk_usedmaterials_departure=d.id)'+
    ' %s %s', [DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select d.id DepID, d.StartDate,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select adres from get_adres_vds(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres'+
    SqlBottom+
    ' order by 3, 2';
end;

procedure Tdm_CalcMaterCost_vds.ResultDsetCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Cost').AsFloat:=DataSet.FieldByName('Quantity').AsFloat*
      DataSet.FieldByName('Price').AsFloat;
end;

function Tdm_CalcMaterCost_vds.GetWorks(DepID: integer): string;
begin
  Result:='';

  dset_Works.Close;
  dset_Works.ParamByName('pDepID').AsInteger:=DepID;
  dset_Works.Open;
  dset_Works.First;
  while not dset_Works.Eof do
  begin
    Result:=Result+', '+NameCase(dset_Works.FieldByName('WorksName').AsString);
    dset_Works.Next;
  end;

  Delete(Result, 1, 2);
end;

end.
