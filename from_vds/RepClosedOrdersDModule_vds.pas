unit RepClosedOrdersDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RepOpenOrdersDModule_vds, FR_DSet, FR_DBSet, IBCustomDataSet,
  IBDatabase, DB, RxMemDS, FR_Class;

type
  Tdm_RepClosedOrders_vds = class(Tdm_RepOpenOrders_vds)
    dset_dep: TIBDataSet;
    ResultDsetMessageTypes: TStringField;
    ResultDsetBrigadier: TStringField;
    ResultDsetadditionalinfo: TStringField;
    ResultDsetAPPLICANTPHONE: TStringField;
    ResultDsetAPPLICANTFIO: TStringField;
   private
    {Input}
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_RecordCount: integer;
    F_ALLChecked: boolean;
  private
    {Output}
  private
    F_MainSqlString: string;
    F_RecCountSqlString: string;
    function FillResultDset: boolean; virtual;

    procedure SetSqlString;
    procedure SetRecordCount;
    function GetWorks(OrderID: integer): string;
  public
    { Public declarations }
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property RecordCount: integer read F_RecordCount;
    property ALLChecked: boolean write F_ALLChecked;
    procedure Init;
    function PrepareDset: boolean;
  end;




var
  dm_RepClosedOrders_vds: Tdm_RepClosedOrders_vds;

implementation

{$R *.dfm}

uses HelpFunctions;

function Tdm_RepClosedOrders_vds.FillResultDset: boolean;
var
  i: integer;
  _tel, _fio, _adr, _addinforder, _messagetype : string;
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
    _addinforder := '';
    _messagetype := '';
    ResultDset.Append;
    for i:=0 to dset_tmp.FieldCount-1 do
      ResultDset.FieldByName(dset_tmp.Fields[i].FieldName).Value:=
        dset_tmp.Fields[i].Value;
    _tel := dset_tmp.FieldByName('APPLICANTPHONE').AsString;
    if _tel <> '' then _tel := ', тел.'+_tel;
    _fio := dset_tmp.FieldByName('APPLICANTFIO').AsString;
    if _fio <> '' then _fio := ', ' + _fio;           // + #13
    _adr := trim(ResultDset.FieldByName('Adres').AsString)+ _tel + _fio;
    ResultDset.FieldByName('Adres').AsString := _adr;
    ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);

      if not( Dset_tmp.FieldByName('additionalinfo').IsNull) then
      begin
        _addinforder := trim(Dset_tmp.FieldByName('additionalinfo').AsString);

        if not( ResultDset.FieldByName('MessageTypes').IsNull ) then
         _messagetype := trim(ResultDset.FieldByName('MessageTypes').AsString);
        if _messagetype <>'' then _messagetype := _messagetype +'; '+ _addinforder
         else
         _messagetype := _addinforder;
        ResultDset.FieldByName('MessageTypes').AsString := _messagetype;
      end;
   // ResultDset.FieldByName('WORKS').AsString:=ResultDset.FieldByName('WORKS').AsString +
   //                       ResultDset.FieldByName('ADDITIONALINFO').AsString;
    ResultDset.Post;

    dset_tmp.Next;
  end;
end;

function Tdm_RepClosedOrders_vds.GetWorks(OrderID: integer): string;
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
    ' from DEPARTURES_vds'+
    ' where (FK_DEPARTURES_ORDERS = '+ IntToStr(OrderID) +')'+
    ' and (id = (select max(id) from departures_vds where fk_departures_orders = '+ IntToStr(OrderID) +'))');
    dset_dep.First;
    while (not dset_dep.Eof) do
      begin
      _res := _res + dset_dep.FieldByName('ADDITIONALINFO').AsString;
      dset_dep.Next;
      end;
    dset_dep.Close;

  Result := _res;
end;


procedure Tdm_RepClosedOrders_vds.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_RepClosedOrders_vds.PrepareDset: boolean;
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



procedure Tdm_RepClosedOrders_vds.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;


procedure Tdm_RepClosedOrders_vds.SetSqlString;
var
  RegCond, DtCond, SqlBottom, CheckCond: string;
begin
  //F_ALLChecked:= false; // пока что пусть будет так :), т.е. только закрытые
  if not F_ALLChecked then CheckCond := ' and (o.isclosed= 1 ) '
  else CheckCond := '';

  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (o.DateComing>%s) and (o.DateComing<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Orders_vds o'+
    ' where ( 1 = 1 ) %s %s %s',[ CheckCond, DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.OrderNumber, o.dateclosed,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant_vds where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres_vds(o.fk_orders_streets, o.housenum,'+
    '      o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) Adres,'+
    ' (select name from s_district_vds where id=o.fk_orders_district) District'+
    ', (select name from brigadiers where id=o.fk_orders_brigadiers) brigadier'+
    ', (select messagename from s_messagetypes_vds where id=o.fk_orders_messagetypes) MessageTypes'+
    ' , o.additionalinfo, o.APPLICANTPHONE, o.APPLICANTFIO'+
    SqlBottom+
    ' order by 5, 2';
end;


end.
