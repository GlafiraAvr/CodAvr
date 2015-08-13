unit RepDisconDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, IBCustomDataSet, DB,
  RxMemDS, DModule, FR_DSet, FR_DBSet, DateUtils;

type
  Tdm_RepDiscon_vds = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    ResultDsetID: TIntegerField;
    ResultDsetDTTM_DISCON: TDateTimeField;
    ResultDsetDTTM_CON: TDateTimeField;
    ResultDsetAPPLICANT: TStringField;
    ResultDsetADRES: TStringField;
    ResultDsetDISCONREASON: TStringField;
    ResultDsetEXECUTOR: TStringField;
    dset_Works: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    ResultDsetREGION: TStringField;
    ResultDsetWORKS: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetdistrict: TStringField;
    ResultDsetDistype: TStringField;
    ResultDsetTime_Diff: TStringField;
    dset_diff: TIBDataSet;
    dset_dep: TIBDataSet;
    ResultDsetAdditionalinfo: TStringField;
    ResultDsetG_KV: TIntegerField;
    ResultDsetG_ZHD: TIntegerField;
    ResultDsetG_STOJ: TIntegerField;
    ResultDsetG_ST_SP: TIntegerField;
  private
    {Input}
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_streetsID:string;  //glasha 09.04.2014
    F_RecordCount: integer;
    F_NCDP: boolean;
  private
    {Output}
  private
    F_MainSqlString: string;
    F_RecCountSqlString: string;
    function FillResultDset: boolean;
    procedure SetSqlString;
    procedure SetRecordCount;
    function GetWorks(OrderID: integer): string;
    function GetTimeDiff(OrderID: integer): integer;
  public
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property NCDP: boolean write F_NCDP;
    procedure Init;
    function PrepareDset: boolean;
    property RecordCount: integer read F_RecordCount;
    property StreetsID:string write F_streetsID;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepDiscon }

function Tdm_RepDiscon_vds.FillResultDset: boolean;
var
  i, diff: integer;
  str:string;
begin
  //ResultDset.Close;
  if (not ResultDset.Active) then
   ResultDset.Open
  else
   ResultDset.EmptyTable;

  MyOpenIBDS(dset_tmp, F_MainSqlString);
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    if F_NCDP then
      diff := GetTimeDiff(dset_tmp.FieldByName('ID').AsInteger) div 24
      else
      diff := GetTimeDiff(dset_tmp.FieldByName('ID').AsInteger);
    if (F_NCDP and (diff>0)) or (not F_NCDP) then
    begin
        ResultDset.Append;
        for i:=0 to dset_tmp.FieldCount-1 do
          ResultDset.FieldByName(dset_tmp.Fields[i].FieldName).Value:=
            dset_tmp.Fields[i].Value;
        ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);
        ResultDset.FieldByName('Time_Diff').AsString:=inttostr(diff);
         str:='';
    if ResultDset.FieldByName('G_ZHD').asinteger>0 then
      str:=str+'дм.-'+ResultDset.FieldByName('G_ZHD').AsString+ ', ';

    if ResultDset.FieldByName('G_STOJ').asinteger>0 then
      str:=str+'ст.-'+ResultDset.FieldByName('G_STOJ').AsString+ ', ';
    if ResultDset.FieldByName('G_ST_SP').asinteger>0 then
      str:=str+'сп. ст.-'+ResultDset.FieldByName('G_ST_SP').AsString+ ', ';
     if ResultDset.FieldByName('G_KV').asinteger>0 then
      str:=str+'кв.-'+ResultDset.FieldByName('G_KV').AsString+ ', ';
     delete(str,length(str)-1,1);

    ResultDset.FieldByName('Distype').AsString:=str;
        ResultDset.Post;
    end;
    dset_tmp.Next;
  end;
end;


function Tdm_RepDiscon_vds.GetWorks(OrderID: integer): string;
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


{begin
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
end;}

function Tdm_RepDiscon_vds.GetTimeDiff(OrderID: integer): integer;
var
  dttm_beg, dttm_end: TDateTime;
  dttm_zakr, dttm_otkr, dttm_coming, dttm_closed: TDateTime;
  delta, max_delta: integer;
  tek_id, i: integer;
begin

  dttm_beg:=StrToDateTime(DateToStr(F_Dtbeg)+' 00:00:00');
  dttm_end:=StrToDateTime(DateToStr(F_Dtend)+' 23:59:59');

  Result:=0;
  max_delta := -1;


  dset_diff.Close;
  dset_diff.ParamByName('pOrderID').AsInteger:=OrderID;
  dset_diff.ParamByName('pDttmBeg').AsDateTime:=dttm_beg;
  dset_diff.ParamByName('pDttmEnd').AsDateTime:=dttm_end;
  dset_diff.Open;
  dset_diff.First;

  while not dset_diff.Eof do
  begin
      delta := -1;
      dttm_otkr := 0;
      dttm_zakr:=dset_diff.FieldByName('dttm_discon').AsDateTime;
      dttm_otkr:=dset_diff.FieldByName('dttm_con').AsDateTime;

      if dset_diff.FieldByName('isclosed').AsInteger=1 then
               begin
                 dttm_closed := dset_diff.FieldByName('DateClosed').AsDateTime;
                 if dttm_otkr=0 then dttm_otkr:= dttm_closed
                    else
                      if frac(dttm_otkr)=0 then dttm_otkr:=trunc(dttm_otkr)+frac(dttm_end);
                end
          else
            if dttm_otkr=0 then dttm_otkr:=now;



      if (dttm_zakr<=dttm_end) and (dttm_otkr>=dttm_beg) then //проверяем временной интервал
      begin
        //if dttm_zakr<dttm_beg then dttm_zakr:=dttm_beg; //для расчёта теперь берём дату открытия, а не дату начала интервала
        if dttm_otkr>dttm_end then dttm_otkr:=dttm_end;
        delta:=HoursBetween(dttm_otkr, dttm_zakr);
        if delta>max_delta then max_delta:=delta;
      end;
    dset_diff.Next;
  end;

   Result:=max_delta;



end;


procedure Tdm_RepDiscon_vds.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

function Tdm_RepDiscon_vds.PrepareDset: boolean;
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

procedure Tdm_RepDiscon_vds.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;

procedure Tdm_RepDiscon_vds.SetSqlString;
var
  RegCond, DtCond, SqlBottom: string;
begin
  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';
  if trim(F_streetsID)<>'' then
    RegCond:=RegCond+Format(' and (d.fk_discon_street in%s)', [F_streetsID]) ;

  {DtCond:=Format(' and (d.DTTM_Discon>%s) and (d.DTTM_Discon<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);
   }

  DtCond:=Format(' and ((d.DTTM_Con>%s) or (d.DTTM_Con is null)) and (d.DTTM_Discon<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Disconnections_vds d'+
    ' left join Orders_vds o on o.id=d.fk_discon_order'+
    ' where 1=1 %s %s',[DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, d.dttm_discon, d.dttm_con, o.OrderNumber,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant_vds where id=o.fk_orders_applicant) Applicant,'+
    ' (select adres from get_adres2(d.fk_discon_street, d.housenum,'+
    '     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) Adres,'+
    ' (select name from s_DisconReason_vds where id=d.fk_discon_disconreason) DisconReason,'+
    ' (select name from s_Executor_vds where id=d.fk_discon_executor) Executor,'+
    ' (select name from s_district_vds where id=o.fk_orders_district) District'+
    ' , (select name from s_discontype_vds where id=d.fk_discon_discontype) Distype '+
    ' , rtrim(d.additionalinfo) Additionalinfo '+
    ' , G_ZHD, G_KV, G_STOJ, G_ST_SP'+
//    ' , o.isclosed, o.datecoming, o.dateclosed'+
    SqlBottom+
    ' order by 5, 2';
end;


end.


