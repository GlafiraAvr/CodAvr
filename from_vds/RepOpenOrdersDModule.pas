unit RepOpenOrdersDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, FR_DSet, FR_DBSet,
  IBCustomDataSet, IBDatabase, DB, RxMemDS;

type
  Tdm_RepOpenOrders = class(Tdm_NGReportBase)
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
    dset_Works: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    OLD_ResultDset: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField2: TIntegerField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    ResultDsetDisAdres: TStringField;
    ResultDsetDistype: TStringField;
    ResultDsetMT: TStringField;
    dset_disconnections: TIBDataSet;
    ResultDsetdttm_discon: TStringField;
    ResultDsetWORKS: TStringField;
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


function Tdm_RepOpenOrders.FillResultDset: boolean;

    procedure GetDisconnections(OrderID: integer);
      var _DisAdres, _DisType, _DisDate, _s13: string;
      begin
        _DisAdres := '';
        _DisType := '';
        _DisDate := '';
        _s13 := '';
        if dset_disconnections.Active then dset_disconnections.Close;
        dset_disconnections.ParamByName('pOrderID').AsInteger:=OrderID;
        dset_disconnections.Open;
        dset_disconnections.First;
        while not dset_disconnections.Eof do
        begin
          _DisAdres := _DisAdres + _s13 + trim(dset_disconnections.FieldByName('DisAdres').AsString);
          _DisType := _DisType + _s13 + trim(dset_disconnections.FieldByName('DisType').AsString);
          _DisDate := _DisDate + _s13 + trim(dset_disconnections.FieldByName('dttm_discon').AsString);
{          ResultDset.FieldByName('DisAdres').AsString:=dset_disconnections.FieldByName('DisAdres').AsString;
          ResultDset.FieldByName('Distype').AsString:=dset_disconnections.FieldByName('Distype').AsString;
          ResultDset.FieldByName('dttm_discon').AsDateTime:=dset_disconnections.FieldByName('dttm_discon').AsDateTime;
          ResultDset.FieldByName('REGION').AsString:=dset_tmp.FieldByName('REGION').AsString;}
          dset_disconnections.Next;
          if not dset_disconnections.Eof then _s13 := '; ' + #13 ;
//          if not dset_disconnections.Eof then ResultDset.Append;
        end;
          ResultDset.FieldByName('DisAdres').AsString:=_DisAdres;
          ResultDset.FieldByName('Distype').AsString:=_DisType;
          ResultDset.FieldByName('dttm_discon').AsString:=_DisDate+' ';
        dset_disconnections.Close
      end;

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
      GetDisconnections(dset_tmp.FieldByName('ID').AsInteger);
//    ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);
// Работы пока отключим 20.01.2009    
    ResultDset.Post;

    dset_tmp.Next;
  end;
end;


function Tdm_RepOpenOrders.GetWorks(OrderID: integer): string;
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

procedure Tdm_RepOpenOrders.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_RepOpenOrders.PrepareDset: boolean;
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

procedure Tdm_RepOpenOrders.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

procedure Tdm_RepOpenOrders.SetSqlString;
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
//    ' left join disconnections d on o.id=d.fk_discon_order'+
    ' where (o.isclosed=0) %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres,'+
    ' (select name from s_district where id=o.fk_orders_district) District'+
    ' , (select messagename from s_messagetypes where id=o.fk_orders_messagetypes) MT'+
//    ' , (select adres from get_adres2(d.fk_discon_street, d.housenum,     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) DisAdres'+
//    ' , (select name from s_discontype where id=d.fk_discon_discontype) Distype'+
//    ' , d.dttm_discon '+
    SqlBottom+
    ' order by 4, 2';
end;

{procedure Tdm_RepOpenOrders.SetSqlString;
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
    ' where (o.isclosed=0) %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres2(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum)) Adres,'+
    ' (select name from s_district where id=o.fk_orders_district) District'+
    SqlBottom+
    ' order by 4, 2';
end;
 } // - старая версия 20.01.2009 by Vadim
end.
