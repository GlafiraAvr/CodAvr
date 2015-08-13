unit ActExeWorksDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, DModule,
  IBCustomDataSet, IBDatabase, FR_DSet, FR_DBSet;

type
  Tdm_ActExeWorks_vds = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    ResultDsetID: TIntegerField;
    ResultDsetAPPLICANT: TStringField;
    ResultDsetADRES: TStringField;
    ResultDsetREGION: TStringField;
    ResultDsetWORKS: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetdistrict: TStringField;
    tran: TIBTransaction;
    dset_tmp: TIBDataSet;
    dset_Works: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetDateClosed: TDateTimeField;
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
    function GetWorks(OrderID: integer): string;
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

{ Tdm_RepDiscon }

function Tdm_ActExeWorks_vds.FillResultDset: boolean;
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
    ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);    
    ResultDset.Post;

    dset_tmp.Next;
  end;
end;


function Tdm_ActExeWorks_vds.GetWorks(OrderID: integer): string;
begin
  Result:='';

  dset_Works.Close;
  dset_Works.ParamByName('pOrderID').AsInteger:=OrderID;
  dset_Works.Open;
  dset_Works.First;
  while not dset_Works.Eof do
  begin
    Result:=Result+', '+NameCase(dset_Works.FieldByName('WorksName').AsString);
    dset_Works.Next;
  end;

  Delete(Result, 1, 2);
end;

procedure Tdm_ActExeWorks_vds.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_ActExeWorks_vds.PrepareDset: boolean;
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

procedure Tdm_ActExeWorks_vds.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

procedure Tdm_ActExeWorks_vds.SetSqlString;
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
    ' from Orders_vds o'+
    ' where (o.isclosed=1) %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.dateclosed, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant_vds where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres_vds(o.fk_orders_streets, o.housenum,'+
    ' o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres,'+
    ' (select name from s_district_vds where id=o.fk_orders_district) District'+
    SqlBottom+
    ' order by 5, 2';
end;

end.
