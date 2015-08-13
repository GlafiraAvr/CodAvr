unit RepRayonOrdersDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, IBCustomDataSet, IBDatabase,
  FR_DSet, FR_DBSet, RxMemDS;

type
  Tdm_RepRayonOrders = class(Tdm_NGReportBase)
    frDS_Result: TfrDBDataSet;
    tran: TIBTransaction;
    dset_tmp: TIBDataSet;
    dset_disconnections: TIBDataSet;
    dset_Works: TIBDataSet;
    dset_dep: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetID: TIntegerField;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetREGION: TStringField;
    ResultDsetAPPLICANT: TStringField;
    ResultDsetADRES: TStringField;
    ResultDsetdistrict: TStringField;
    ResultDsetDisAdres: TStringField;
    ResultDsetDistype: TStringField;
    ResultDsetDateClosed: TDateTimeField;
    ResultDsetMT: TStringField;
    ResultDsetdttm_discon: TStringField;
    ResultDsetMessageTypes: TStringField;
    ResultDsetBrigadier: TStringField;
    ResultDsetadditionalinfo: TStringField;
    ResultDsetAPPLICANTPHONE: TStringField;
    ResultDsetAPPLICANTFIO: TStringField;
    ResultDsetWORKS: TStringField;
  private
    {Input}
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_RecordCount: integer;
    F_MainSqlString: string;
    F_RecCountSqlString: string;

    function FillResultDset: boolean;
    procedure SetSqlString;
    procedure SetRecordCount;
    function GetWorks(OrderID: integer): string;
  public
    { Public declarations }
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    procedure Init;
    function PrepareDset: boolean;
    property RecordCount: integer read F_RecordCount;

  end;

var
  dm_RepRayonOrders: Tdm_RepRayonOrders;

implementation

{$R *.dfm}
uses HelpFunctions;

procedure Tdm_RepRayonOrders.SetSqlString;
var
  RegCond, DtCond, SqlBottom, CheckCond: string;
begin

  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (o.DateComing>%s) and (o.DateComing<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Orders o'+
    ' where ( 1 = 1 ) %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.OrderNumber, o.dateclosed,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres,'+
    ' (select name from s_district where id=o.fk_orders_district) District'+
    ', (select name from brigadiers where id=o.fk_orders_brigadiers) brigadier'+
    ', (select messagename from s_messagetypes where id=o.fk_orders_messagetypes) MessageTypes'+
    ' , o.additionalinfo, o.APPLICANTPHONE, o.APPLICANTFIO'+
    SqlBottom+
    ' order by 5, 2';

end;

procedure Tdm_RepRayonOrders.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

procedure Tdm_RepRayonOrders.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

function Tdm_RepRayonOrders.PrepareDset: boolean;
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

function Tdm_RepRayonOrders.FillResultDset: boolean;

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
  _tel, _fio, _adr : string;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS(dset_tmp, F_MainSqlString);
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    _tel := '';
    _fio := '';
    _adr := '';
    ResultDset.Append;
    for i:=0 to dset_tmp.FieldCount-1 do
      ResultDset.FieldByName(dset_tmp.Fields[i].FieldName).Value:=
        dset_tmp.Fields[i].Value;
    _tel := dset_tmp.FieldByName('APPLICANTPHONE').AsString;
    if _tel <> '' then _tel := ', тел.'+_tel;
    _fio := dset_tmp.FieldByName('APPLICANTFIO').AsString;
    if _fio <> '' then _fio := ', ' + _fio;           // + #13
    _adr := trim(ResultDset.FieldByName('Adres').AsString)+ _tel + _fio;
    if  trim(ResultDset.FieldByName('Brigadier').AsString) = '' then
        ResultDset.FieldByName('Brigadier').AsString :=  ' '; 
    ResultDset.FieldByName('Adres').AsString := _adr;
    ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);
    ResultDset.Post;

    dset_tmp.Next;
  end;
end;


function Tdm_RepRayonOrders.GetWorks(OrderID: integer): string;
var _res: string;
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

  Delete(_res, 1, 2);

  MyOpenIBDS(dset_dep,
    ' select ADDITIONALINFO'+
    ' from DEPARTURES'+
    ' where (FK_DEPARTURES_ORDERS = '+ IntToStr(OrderID) +')'+
    ' and (id = (select max(id) from departures where fk_departures_orders = '+ IntToStr(OrderID) +'))');
    dset_dep.First;
    while (not dset_dep.Eof) do
      begin
      _res := _res + dset_dep.FieldByName('ADDITIONALINFO').AsString;
      dset_dep.Next;
      end;
    dset_dep.Close;

  Result := _res;
end;


end.
