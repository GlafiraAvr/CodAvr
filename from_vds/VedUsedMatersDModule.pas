unit VedUsedMatersDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, FR_DSet, FR_DBSet,
  IBCustomDataSet, IBDatabase, DB, RxMemDS;

type
  Tdm_VedUsedMaters = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    ResultDsetID: TIntegerField;
    ResultDsetAPPLICANT: TStringField;
    ResultDsetADRES: TStringField;
    ResultDsetREGION: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetdistrict: TStringField;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetDateClosed: TDateTimeField;
    tran: TIBTransaction;
    dset_tmp: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    dset_Maters: TIBDataSet;
    ResultDsetMATERS: TStringField;
    dset_MatersNAME: TIBStringField;
    dset_MatersMEASUREMENT: TIBStringField;
    dset_MatersQUANTITY: TIBBCDField;
    dset_MatersMATERSNAME: TStringField;
    procedure dset_MatersCalcFields(DataSet: TDataSet);
  private
    {Input}
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_RecordCount: integer;
  private
    {Output}
  private
    F_MainSqlString: string;
    F_RecCountSqlString: string;
    function FillResultDset: boolean;
    procedure SetSqlString;
    procedure SetRecordCount;
    function GetMaters(OrderID: integer): string;
  public
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    procedure Init;
    function PrepareDset: boolean;
    property RecordCount: integer read F_RecordCount;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

function Tdm_VedUsedMaters.FillResultDset: boolean;
var
  i: integer;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS(dset_tmp, F_MainSqlString);
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    ResultDset.Append;
    for i:=0 to dset_tmp.FieldCount-1 do
      ResultDset.FieldByName(dset_tmp.Fields[i].FieldName).Value:=
        dset_tmp.Fields[i].Value;
    ResultDset.FieldByName('MATERS').AsString:=GetMaters(dset_tmp.FieldByName('ID').AsInteger);
    ResultDset.Post;

    dset_tmp.Next;
  end;
end;


function Tdm_VedUsedMaters.GetMaters(OrderID: integer): string;
begin
  Result:='';

  dset_Maters.Close;
  dset_Maters.ParamByName('pOrderID').AsInteger:=OrderID;
  dset_Maters.Open;
  dset_Maters.First;
  while not dset_Maters.Eof do
  begin
    Result:=Result+', '+NameCase(dset_Maters.FieldByName('MatersName').AsString);
    dset_Maters.Next;
  end;

  Delete(Result, 1, 2);
end;

procedure Tdm_VedUsedMaters.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_VedUsedMaters.PrepareDset: boolean;
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
      raise Exception.Create(E.Message+'(Tdm_RepDiscon.PrepareDsets)');
    end;
  end;

  Result:=true;
end;

procedure Tdm_VedUsedMaters.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

procedure Tdm_VedUsedMaters.SetSqlString;
var
  RegCond, DtCond, SqlBottom: string;
begin
  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (o.DateComing>%s) and (o.DateComing<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Orders o'+
    ' where (o.isclosed=1)'+
    ' and exists(select id from departurematerials  where fk_usedmaterials_orders=o.id)'+
    ' %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.dateclosed, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres,'+
    ' (select name from s_district where id=o.fk_orders_district) District'+
    SqlBottom+
    ' order by 5, 2';
end;

procedure Tdm_VedUsedMaters.dset_MatersCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('MatersName').AsString:=Format('%s (%s %s)',[
      trim(FieldByName('Name').AsString),
      trim(FieldByName('Quantity').AsString),
      trim(FieldByName('Measurement').AsString)]);
  end;
end;

end.
