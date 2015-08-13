unit RepSvodVedDModule_vds;
{$DEFINE FROMBASE}
{$DEFINE FROMSNAPSHOT}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, HelpClasses,
  IBDatabase, DModule, IBCustomDataSet, FR_DSet, FR_DBSet, SnapShotManagerDModule_vds,
  xmldom, XMLIntf, msxmldom, XMLDoc, ADODB;

type
  Tdm_RepSvodVed_vds = class(Tdm_NGReportBase)
    md_CountByReg: TRxMemoryData;
    md_CountByRegRegion: TStringField;
    tran: TIBTransaction;
    md_CountByRego62_prin: TIntegerField;
    md_CountByRegods_prin: TIntegerField;
    md_CountByRegzhitel_prin: TIntegerField;
    md_CountByRego62_vip: TIntegerField;
    md_CountByRegods_vip: TIntegerField;
    md_CountByRegzhitel_vip: TIntegerField;
    md_CountByRegostalos: TIntegerField;
    dset_tmp: TIBDataSet;
    frDSet: TfrDBDataSet;
    md_CountByRegid_reg: TIntegerField;
    md_Discon: TRxMemoryData;
    md_Disconid_reg: TIntegerField;
    md_Disconregion: TStringField;
    md_Disconadres: TStringField;
    md_Discondiscontype: TStringField;
    frDS_Discon: TfrDBDataSet;
    md_Discondttm_discon: TDateTimeField;
    md_DisconSumInfo: TRxMemoryData;
    md_DisconSumInfodiscontype: TStringField;
    md_DisconSumInfodcount: TIntegerField;
    md_Disconid_discon: TIntegerField;
    frDS_DisconSumInfo: TfrDBDataSet;
    md_DisconOrderNumber: TIntegerField;
    md_Discondistrict: TStringField;
    md_DisconDaysCount: TIntegerField;
    md_CountByRegpercent_vip: TFloatField;
    md_CountByRegsum_prin: TIntegerField;
    md_CountByRegsum_vip: TIntegerField;
    md_DisconDisconReason: TStringField;
    XMLDocument1: TXMLDocument;
    md_DisconG_ZHD: TIntegerField;
    md_DisconG_KV: TIntegerField;
    md_DisconG_STOJ: TIntegerField;
    md_DisconG_ST_SP: TIntegerField;
    md_DisconG_POD: TIntegerField;
    md_DisconG_GV: TStringField;
    md_CountByReg_new: TRxMemoryData;
    md_CountByReg_newid_reg: TIntegerField;
    md_CountByReg_newprin_1562_new: TIntegerField;
    md_CountByReg_newprin_1562_rall: TIntegerField;
    md_CountByReg_newprin_zhit: TIntegerField;
    md_CountByReg_newprin_all: TIntegerField;
    md_CountByReg_newprin_narad: TIntegerField;
    md_CountByReg_newvip_tek_1562: TIntegerField;
    md_CountByReg_newvip_tek_zhit: TIntegerField;
    md_CountByReg_newptin_tek_all: TIntegerField;
    md_CountByReg_newprin_tek_nar: TIntegerField;
    md_CountByReg_newvip_per_1562: TIntegerField;
    md_CountByReg_newvip_per_zhit: TIntegerField;
    md_CountByReg_newvip_per_all: TIntegerField;
    md_CountByReg_newvip_per_nar: TIntegerField;
    md_CountByReg_newost_zayv: TIntegerField;
    md_CountByReg_newost_nar: TIntegerField;
    md_CountByReg_newods_vip: TIntegerField;
    md_CountByReg_newods_prin: TIntegerField;
    md_CountByReg_newRegion: TStringField;
    md_CountByReg_newvip_tek_nar: TIntegerField;
    md_CountByReg_newvip_tek_all: TIntegerField;
    query: TADOQuery;
    ado_dset: TADODataSet;
    ADOStoredProc1: TADOStoredProc;
    md_CountByReg_newost_1562: TIntegerField;
    md_CountByReg_newost_zhit: TIntegerField;
    md_CountByReg_newField1562_vipall_new: TIntegerField;
    md_CountByReg_newField1562_vipall_rall: TIntegerField;
    md_CountByReg_newField1562_vip_tek_new: TIntegerField;
    md_CountByReg_newField1562_vip_tek_rall: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure md_CountByRegCalcFields(DataSet: TDataSet);
    procedure md_CountByRego62_prinChange(Sender: TField);
    procedure md_CountByRego62_vipChange(Sender: TField);
    procedure md_CountByReg_newprin_1562_newChange(Sender: TField);
    procedure md_CountByReg_newvip_tek_1562Change(Sender: TField);
    procedure md_CountByReg_newvip_per_1562Change(Sender: TField);
  private
    F_Dt: TDate;
    F_HappyNewYear: boolean;
    F_CurSnapDt: TDate;
    F_BEG_YEAR: string;
    F_RegionsID: string;
    F_SnapUser:string;
    F_ApplicantList: TNameContainer;
    F_SnapShotMgr: Tdm_SnapShotManager;
    F_tmpSumPrin: integer;
    F_tmpSumPrinSnap: integer;
    F_tmpSumVipSnap: integer;
    F_tmpSumPrinSnapZh: integer;
    F_tmpSumPrinSnap062: integer;
    F_tmpSumVipSnapZh: integer;
    F_tmpSumVipSnap062: integer;
    F_OrderComingCount, F_ClosedOrdersCount, F_NotClosedOrdersCount : integer;


    F_ArrLastOst: array [0..10] of integer;
    procedure AddCountForApplicant;
    procedure AddOstalos;

    procedure InitCountByReg;
     procedure InitCountByReg_new;
    procedure InitIDByReg;
    procedure GetLastOst(_dt : TDate);
    procedure GetLastPrin(_dt : TDate);
    procedure FillApplicantList;
    function PrepareCountByReg(percent: integer): boolean;
    function PrepareDiscon(percent: integer): boolean;
    function PrepareDisconSumInfo(percent: integer): boolean;
    function GetDisconCount(id_discon: integer): integer;
    procedure InitSnapShotMgr;
    procedure SaveXML;
    procedure GetCountsForXML;
//    procedure FindNodeAttributes(Node: IXMLNode);
    procedure   AddCountForApplicant_new; //08.08.2012
    function PrepareCountByReg_new(percent: integer): boolean; //09.08.2012
    procedure Add_from_1562();
    function FromadoDsetMD(field_query,field_md:string):boolean;
    procedure fromquerytodm( procname,dt1,dt2,field_query, field_md:string; field_query2, field_md2:string);
    procedure CalcRowmdRegion();
    procedure CalMdRegion();
    procedure InitSnapShotMgr_new;
  public
    property Dt: TDate read F_Dt write F_Dt;
    property HappyNewYear: boolean read F_HappyNewYear write F_HappyNewYear;
    property CurSnapDt: TDate read F_CurSnapDt write F_CurSnapDt;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property SnapUser:string read F_SnapUser;
    function PrepareDsets: boolean; dynamic;
    function GetOfficialName(id: integer): string;
    function PrepareCountByRegPer(dtBeg, dtEnd: TDate): boolean;
    procedure DoSnapShot;
    procedure LoadSnapShot(dt: TDate);
    procedure LoadSnapshotDatesList(var list: TStringList);
    procedure CalcVsegoZaSmenu;
    function PrepareDsets_new: boolean;  //09.08.2012
   procedure CalcVsegoZaSmenu_new;
  end;


implementation

{$R *.dfm}

uses ApplicationSettings, HelpFunctions, DateUtils, RightsManagerDModule;

{ Tdm_RepSvodVed }

function Tdm_RepSvodVed_vds.PrepareDsets: boolean;
begin
  Result:=false;

  ResetProgressFields;

  F_BEG_YEAR:='01.01.'+IntToStr(YearOf(F_Dt));

  if not PrepareCountByReg(50) then exit
  else
  if not PrepareDiscon(30) then exit
  else
  if not PrepareDisconSumInfo(20) then exit;

  Result:=true;
end;

function Tdm_RepSvodVed_vds.PrepareDsets_new: boolean;
begin
  Result:=false;

  ResetProgressFields;

  F_BEG_YEAR:='01.01.'+IntToStr(YearOf(F_Dt));

  if not PrepareCountByReg_new(50) then exit
  else
  if not PrepareDiscon(30) then exit
  else
  if not PrepareDisconSumInfo(20) then exit;

  Result:=true;
end;

procedure Tdm_RepSvodVed_vds.DataModuleCreate(Sender: TObject);
begin
  inherited;
 F_ApplicantList:=TNameContainer.Create;
  FillApplicantList;
  F_SnapShotMgr:=Tdm_SnapShotManager.Create(nil);
  InitSnapShotMgr;

 // tran.StartTransaction;
end;

procedure Tdm_RepSvodVed_vds.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_ApplicantList.Free;
  F_SnapShotMgr.Free;

 if tran.Active then tran.Commit;
end;

procedure Tdm_RepSvodVed_vds.FillApplicantList;
begin
  with F_ApplicantList do
  begin
    IDByName['o62']:='2';
    IDByName['ods']:='3';
    IDByName['zhitel']:='1';
  end;
end;

function Tdm_RepSvodVed_vds.PrepareCountByReg(percent: integer): boolean;
var
  i: integer;
begin
  Result:=false;

  md_CountByReg.Close;
  md_CountByReg.Open;

  InitCountByReg;
  AddCountForApplicant;
  AddOstalos;
  CalcVsegoZaSmenu;
  F_CurSnapDt := F_Dt;

  Result:=true;
end;

function Tdm_RepSvodVed_vds.PrepareDiscon(percent: integer): boolean;
var
  i, _dc: integer;
  reg_cond: string;
  str:string;
begin
  md_discon.Close;
  md_discon.Open;

  if trim(F_RegionsID)<>'' then
    reg_cond:=' and (o.fk_orders_regions in'+F_RegionsID+')'
  else
    reg_cond:='';

  MyOpenIBDS(dset_tmp,
    ' select o.fk_orders_regions id_reg,'+
    ' (select name from s_regions where id=o.fk_orders_regions) region,'+
    ' d.dttm_discon,'+
    ' (select adres from get_adres2(d.fk_discon_street, d.housenum,'+
    '     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) adres,'+
    ' d.fk_discon_discontype id_discon,'+
    ' (select name from s_discontype_VDS where id=d.fk_discon_discontype) discontype,'+
    ' o.OrderNumber,'+
    ' (select name from s_district_vds where id=o.fk_orders_district) district,'+
    ' (select name from s_DisconReason_vds where id=d.fk_discon_disconreason) disconreason,'+
    '  G_ZHD, G_KV, G_STOJ, G_ST_SP, G_POD, G_GV'+
    ' from disconnections_vds d'+
    ' left join orders_vds o on d.fk_discon_order=o.id'+
    ' where (d.dttm_con is null)'+
    reg_cond+
    ' order by 2, 3');

  dset_tmp.First;
  _dc :=0;
  while not dset_tmp.Eof do
  begin
    md_Discon.Append;

    for i:=0 to dset_tmp.FieldCount-1 do
      md_Discon.FieldByName(dset_tmp.Fields[i].FieldName).Value:=dset_tmp.Fields[i].Value;
    _dc := trunc(F_Dt)-trunc(dset_tmp.FieldByName('dttm_discon').AsDateTime);
    str:='';
    if md_Discon.FieldByName('G_ZHD').asinteger>0 then
      str:=str+'дм.-'+md_Discon.FieldByName('G_ZHD').AsString+ ', ';
    if md_Discon.FieldByName('G_STOJ').asinteger>0 then
      str:=str+'ст.-'+md_Discon.FieldByName('G_STOJ').AsString+ ', ';
    if md_Discon.FieldByName('G_ST_SP').asinteger>0 then
      str:=str+'сп. ст.-'+md_Discon.FieldByName('G_ST_SP').AsString+ ', ';
    if md_Discon.FieldByName('G_KV').asinteger>0 then
      str:=str+'кв.-'+md_Discon.FieldByName('G_KV').AsString+ ', ';
    if md_Discon.FieldByName('G_Pod').asinteger>0 then
      str:=str+'пд.-'+md_Discon.FieldByName('G_Pod').AsString+ ', ';
    if trim(md_Discon.FieldByName('G_GV').AsString)='есть' then
      str:=str+'гв+'+', ';

     delete(str,length(str)-1,1);


    md_Discon.FieldByName('discontype').AsString:=str;



    if _dc < 0 then _dc := 0;
//    md_Discon.FieldByName('DaysCount').AsInteger:=trunc(F_Dt)-trunc(dset_tmp.FieldByName('dttm_discon').AsDateTime);
    md_Discon.FieldByName('DaysCount').AsInteger:= _dc;

    md_Discon.Post;

    dset_tmp.Next;
  end;

  dset_tmp.Close;

  Result:=true;
end;
{$IFDEF FROMBASE}
procedure Tdm_RepSvodVed_vds.AddCountForApplicant;

  function get_sql(_type, id_reg: integer; id_app: string): string;
  var
    dt_cond: string;
    dt_beg, dt_end, add_cond, reg_cond: string;
  begin
    if Trim(id_app)='3'  then
     begin
      Result:='select distinct 0 kol'+
      ' from orders_vds';
      Exit;
     end;
    if id_reg=-2 then
    begin //
      dt_beg:=F_BEG_YEAR;
      if trim(F_RegionsID)<>'' then reg_cond:=' and (fk_orders_regions in '+F_RegionsID+')'
      else reg_cond:='';
      //add_cond:=Format(' %s and (fk_orders_applicant=%s)', [reg_cond, id_app]);
       if Trim(id_app)='2' then
            add_cond:=' and fk_orders_organisations=18';
      if Trim(id_app)='1' then
            add_cond:=' and fk_orders_organisations<>18';
      add_cond:=id_app+' '+add_cond;

    end else
    begin
      dt_beg:=DateToStr(F_Dt);
       if Trim(id_app)='2' then
            add_cond:=' and fk_orders_organisations=18';
      if Trim(id_app)='1' then
            add_cond:=' and fk_orders_organisations<>18';
      add_cond:=Format('and (fk_orders_regions=%d) %s',[id_reg,add_cond]);
     // add_cond:=Format(' and (fk_orders_regions=%d) and (fk_orders_applicant=%s)', [id_reg, id_app]);
    end;
    dt_end:=DateToStr(F_Dt+1);

    if _type=0 then
      dt_cond:=Format('  (DateComing>=''%s 06:00'') and (DateComing<''%s 06:00'')', [dt_beg, dt_end])
    else
      dt_cond:=Format(' (IsClosed=1) and (DateClosed>=''%s 06:00'') and (DateClosed<''%s 06:00'')', [dt_beg, dt_end]);

    Result:=
      ' select count(*) kol'+
      ' from orders_vds'+
      ' where'+dt_cond+add_cond;
  end;
var
  sql: string;
  Arr: array [0..1] of string;
  i, j, iKol: integer;
begin
  Arr[0]:='_prin'; Arr[1]:='_vip';
  iKol := 0;
////////////////////////
  md_CountByReg.First;
  while not md_CountByReg.Eof do
  begin
    if md_CountByReg.FieldByName('id_reg').AsInteger<>-1 then
       {$IFDEF FROMSNAPSHOT}
        if md_CountByReg.FieldByName('id_reg').AsInteger=-2 then
//        for j:=0 to F_ApplicantList.Count-1 do
        for i:=0 to 1 do
        begin
        sql :=
         ' select sv.field_value kol from snshot_values_vds sv'+
          ' where (sv.row_number = 11) and ( '+
          ' sv.id_field = ( '+
          ' select sf.id from snshot_fields_vds sf where (sf.field_name =''sum' + Arr[i] + ''')'+
//          trim(F_ApplicantList.NameByIndex(j))+Arr[i] + ''')'+
          ' and (sf.id_dset = ('+
          ' select (sd.id) from snshot_dsets_vds sd where sd.id_snapshot ='+
          ' ( select max(ss.id) from snshot_snapshots_vds ss where ID_TYPE=1 and ss.dt = '''+
          formatdatetime('dd.mm.yyyy', F_Dt-1) +''' )))))';
          MyOpenIBDS(dset_tmp, sql);
          dset_tmp.First;
          if not dset_tmp.FieldByName('kol').IsNull then
          begin
           iKol := dset_tmp.FieldByName('kol').AsInteger;
           if i = 0 then F_tmpSumPrin:= iKol;
           F_tmpSumPrinSnap := F_tmpSumPrin;
            md_CountByReg.Edit;
            md_CountByReg.FieldByName('sum'+Arr[i]).AsInteger:= iKol;
            md_CountByReg.Post;
          end;
        end
        else
       {$ENDIF}
      for j:=0 to F_ApplicantList.Count-1 do
        for i:=0 to 1 do
        begin
          MyOpenIBDS(dset_tmp, get_sql(i, md_CountByReg.FieldByName('id_reg').AsInteger, F_ApplicantList.IDByIndex(j)));
          if dset_tmp.FieldByName('kol').AsInteger<>0 then
          begin            md_CountByReg.Edit;
            md_CountByReg.FieldByName(trim(F_ApplicantList.NameByIndex(j))+Arr[i]).AsInteger:=
                  dset_tmp.FieldByName('kol').AsInteger;
            md_CountByReg.Post;
          end;
        end;
    md_CountByReg.Next;
  end;
end;
{$ENDIF}


{$IFDEF FROMSNAPSHOT}
{$IFNDEF FROMBASE}
procedure Tdm_RepSvodVed_vds.AddCountForApplicant;
var
  sql: string;
  Arr: array [0..1] of string;
  i, j, iKol: integer;
begin
  Arr[0]:='_prin'; Arr[1]:='_vip';
  iKol := 0;
////////////////////////
  md_CountByReg.First;
  while not md_CountByReg.Eof do
  begin
    if md_CountByReg.FieldByName('id_reg').AsInteger=-2 then
        for i:=0 to 1 do
        begin
        sql :=
         ' select sv.field_value kol from snshot_values_vds sv'+
          ' where (sv.row_number = 11) and ( '+
          ' sv.id_field = ( '+
          ' select sf.id from snshot_fields_vds sf where (sf.field_name = ''sum' + Arr[i] + ''')'+
          ' and (sf.id_dset = ('+
          ' select (sd.id) from snshot_dsets_vds sd where sd.id_snapshot ='+
          ' ( select max(ss.id) from snshot_snapshots_vds ss where ID_TYPE=1 and ss.dt = '''+
          formatdatetime('dd.mm.yyyy', F_Dt-1) +''' )))))';
          MyOpenIBDS(dset_tmp, sql);
          iKol := dset_tmp.FieldByName('kol').AsInteger;
          if iKol <> 0 then
          begin
            md_CountByReg.Edit;
            md_CountByReg.FieldByName('sum'+Arr[i]).AsInteger:= iKol;
            md_CountByReg.Post;
          end;
        end;
    md_CountByReg.Next;
  end;
end;
{$ENDIF}
{$ENDIF}




procedure Tdm_RepSvodVed_vds.AddOstalos;
var
  reg_cond: string;
begin
  md_CountByReg.First;
  while not md_CountByReg.Eof do
  begin
    if md_CountByReg.FieldByName('id_reg').AsInteger>0 then
    begin
      MyOpenIBDS(dset_tmp,
        ' select count(*) kol'+
        ' from orders_vds'+
        ' where'+
        ' (DateComing<='+QuotedStr(DateToStr(F_Dt+1))+')'+
        ' and ((DateClosed is null) or (DateClosed>'+QuotedStr(DateToStr(F_Dt+1))+'))'+
        ' and (fk_orders_regions='+md_CountByReg.FieldByName('id_reg').AsString+')');

      if dset_tmp.FieldByName('kol').AsInteger<>0 then
      begin
        md_CountByReg.Edit;
        md_CountByReg.FieldByName('ostalos').AsInteger:=dset_tmp.FieldByName('kol').AsInteger;
        md_CountByReg.Post;
      end;
    end else
    if md_CountByReg.FieldByName('id_reg').AsInteger=-2 then
    begin
      if trim(F_RegionsID)<>'' then reg_cond:=' and (fk_orders_regions in'+F_RegionsID+')'
      else reg_cond:='';

      MyOpenIBDS(dset_tmp,
        ' select count(*) kol'+
        ' from orders_vds'+
        ' where'+
        ' (DateComing>'+QuotedStr(F_BEG_YEAR)+')'+
        ' and (DateComing<='+QuotedStr(DateToStr(F_Dt+1))+')'+
        ' and ((DateClosed is null) or (DateClosed>'+QuotedStr(DateToStr(F_Dt+1))+'))'+
        reg_cond);

      if dset_tmp.FieldByName('kol').AsInteger<>0 then
      begin
        md_CountByReg.Edit;
        md_CountByReg.FieldByName('ostalos').AsInteger:=dset_tmp.FieldByName('kol').AsInteger;
        md_CountByReg.Post;
      end;
    end;
    md_CountByReg.Next;
  end;
end;

procedure Tdm_RepSvodVed_vds.CalcVsegoZaSmenu;
  procedure SumByField(f_name: string);
  var
    sum: integer;
  begin
    sum:=0;
    md_CountByReg.First;
    while not md_CountByReg.Eof do
    begin
      if md_CountByReg.FieldByName('id_reg').AsInteger>0 then
        sum:=sum+md_CountByReg.FieldByName(f_name).AsInteger;
      md_CountByReg.Next;
    end;
    if (md_CountByReg.Locate('id_reg', -1, [])) and (sum<>0) then
    begin
      md_CountByReg.Edit;
      md_CountByReg.FieldByName(f_name).AsInteger:=sum;
      md_CountByReg.Post;
    end;
  end;

  procedure SumOstRecalc;
   var _ost, _prin, _vip:integer;
  begin
      //
     _ost := 0;
     _prin := 0;
     _vip := 0;
     md_CountByReg.First;
     while (not md_CountByReg.Eof) and (md_CountByReg.RecNo < 10) do
      begin
  //      if F_ArrLastOst[md_CountByReg.RecNo-1] > 0 then
        if md_CountByReg.FieldByName('sum_prin').IsNull then _prin := 0
          else _prin := md_CountByReg.FieldByName('sum_prin').AsInteger;
        if md_CountByReg.FieldByName('sum_vip').IsNull then _vip := 0
          else _vip := md_CountByReg.FieldByName('sum_vip').AsInteger;
        _ost := F_ArrLastOst[md_CountByReg.RecNo-1] + _prin - _vip;
        md_CountByReg.Edit;
        md_CountByReg.FieldByName('ostalos').AsInteger:= _ost;
        md_CountByReg.Post;
        md_CountByReg.Next;
      end;
  end;

const
  arr_field: array [0..3] of string=('o62','ods','zhitel','sum');
  arr_type: array[0..1] of string=('_prin', '_vip');
var
  i, j, _sump, _sumv, _sum_ost, _o62_prin, _o62_vip, _zhitel_prin, _zhitel_vip : integer;
  bmark: string;
begin
  md_CountByReg.DisableControls;
  bmark:=md_CountByReg.Bookmark;

  for i:=low(arr_type) to high(arr_type) do
    for j:=low(arr_field) to high(arr_field) do
      SumByField(arr_field[j]+arr_type[i]);

  {$IFDEF FROMSNAPSHOT}
  SumOstRecalc;
  SumByField('ostalos');

    if (md_CountByReg.Locate('id_reg', -1, [])) then
    begin
      _sump := md_CountByReg.FieldByName('sum_prin').AsInteger;
      _sumv := md_CountByReg.FieldByName('sum_vip').AsInteger;
      _sum_ost := md_CountByReg.FieldByName('ostalos').AsInteger;
      _o62_prin := md_CountByReg.FieldByName('o62_prin').AsInteger;
      _o62_vip := md_CountByReg.FieldByName('o62_vip').AsInteger;
      _zhitel_prin := md_CountByReg.FieldByName('zhitel_prin').AsInteger;
      _zhitel_vip := md_CountByReg.FieldByName('zhitel_vip').AsInteger;

      if F_HappyNewYear then
        begin
          F_tmpSumPrinSnap := 0; // с нового года всё с 0, кроме ost
          F_tmpSumVipSnap := 0;
          F_tmpSumPrinSnap062 := 0;
          F_tmpSumPrinSnapZh := 0;
          F_tmpSumVipSnap062 := 0;
          F_tmpSumVipSnapZh := 0;
        end;
      md_CountByReg.Next;
      md_CountByReg.Edit;
      md_CountByReg.FieldByName('sum_prin').AsInteger := F_tmpSumPrinSnap + _sump;
      md_CountByReg.FieldByName('sum_vip').AsInteger := F_tmpSumVipSnap + _sumv;

    //  F_OrderComingCount :=  _sump;
    //  F_ClosedOrdersCount :=  _sumv;
    //  F_NotClosedOrdersCount := F_OrderComingCount - F_ClosedOrdersCount;

      md_CountByReg.FieldByName('o62_prin').AsInteger := F_tmpSumPrinSnap062 + _o62_prin;
      md_CountByReg.FieldByName('o62_vip').AsInteger := F_tmpSumVipSnap062 + _o62_vip;
      md_CountByReg.FieldByName('zhitel_prin').AsInteger := F_tmpSumPrinSnapZh + _zhitel_prin;
      md_CountByReg.FieldByName('zhitel_vip').AsInteger := F_tmpSumVipSnapZh + _zhitel_vip;

      md_CountByReg.Post;
    end;
  {$ENDIF}
  md_CountByReg.Bookmark:=bmark;
  md_CountByReg.EnableControls;
end;

procedure Tdm_RepSvodVed_vds.InitIDByReg;
 var
    reg_cond: string;
    tmp_sump: integer;
begin
   if trim(F_RegionsID)<>'' then
    reg_cond:=' and (id in'+F_RegionsID+')'
  else
    reg_cond:='';

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_Regions'+
    ' where (id>0)'+
    reg_cond+
    ' order by name');

  dset_tmp.First;
  md_CountByReg.First;
  while not dset_tmp.Eof do
  begin
    md_CountByReg.Edit;
    md_CountByReg.FieldByName('id_reg').AsInteger:=dset_tmp.FieldByName('id').AsInteger;
    md_CountByReg.Post;
    md_CountByReg.Next;
    dset_tmp.Next;
  end;

  md_CountByReg.Edit;
  md_CountByReg.FieldByName('id_reg').AsInteger:=-1;
  md_CountByReg.Post;
  tmp_sump := md_CountByReg.FieldByName('sum_prin').AsInteger;
  md_CountByReg.Next;


  md_CountByReg.Edit;
  md_CountByReg.FieldByName('id_reg').AsInteger:=-2;
  md_CountByReg.Post;
 // F_tmpSumPrinSnap:= md_CountByReg.FieldByName('sum_prin').AsInteger - tmp_sump;
 // F_tmpSumPrinSnap
end;

procedure Tdm_RepSvodVed_vds.GetLastPrin(_dt : TDate);
var
    _sql, _fieldname : string;

begin
   F_tmpSumPrinSnap := 0;
  { _sql :=
     ' select sv.field_value, sv.row_number from snshot_values sv'+
      ' where (sv.row_number = 11) and ( '+
      ' sv.id_field = ( '+
      ' select sf.id from snshot_fields sf where (sf.field_name = ''sum_prin'')'+
      ' and (sf.id_dset = ('+
      ' select (sd.id) from snshot_dsets sd where sd.id_snapshot ='+
      ' ( select max(ss.id) from snshot_snapshots ss where ss.dt = '''+
      formatdatetime('dd.mm.yyyy', _dt-1) +''' ))))) order by sv.row_number';
   }
   _sql :=
     ' select sv.field_value, sv.row_number, sf.id, sf.field_name'+
     ' from snshot_fields_vds sf, snshot_values_vds sv'+
      ' where (sv.row_number = 11) and sv.id_field = sf.id and ( '+
      ' sf.field_name in ' +
      '(''zhitel_prin'', ''o62_prin'', ''sum_prin'', ''zhitel_vip'', ''o62_vip'',''sum_vip''))'+
      ' and (sf.id_dset = ('+
      ' select (sd.id) from snshot_dsets_vds sd where sd.id_snapshot ='+
      ' ( select max(ss.id) from snshot_snapshots_vds ss where  ID_TYPE =1 and ss.dt = '''+
      formatdatetime('dd.mm.yyyy', _dt-1) +''' ))) order by sf.field_name';

    MyOpenIBDS(dset_tmp, _sql);

    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      _fieldname := dset_tmp.FieldByName('field_name').AsString;
     if _fieldname  = 'o62_prin' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumPrinSnap062:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumPrinSnap062:= 0;

     if _fieldname  = 'sum_prin' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumPrinSnap:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumPrinSnap:= 0;

     if _fieldname  = 'zhitel_prin' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumPrinSnapZh:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumPrinSnapZh:= 0;

     if _fieldname  = 'o62_vip' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumVipSnap062:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumVipSnap062:= 0;

     if _fieldname  = 'zhitel_vip' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumVipSnapZh:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumVipSnapZh:= 0;

     if _fieldname  = 'sum_vip' then
                               if not dset_tmp.FieldByName('field_value').IsNull then
                                  F_tmpSumVipSnap:=  dset_tmp.FieldByName('field_value').AsInteger
                                  else F_tmpSumVipSnap:= 0;


     dset_tmp.Next;
    end;



    { if not dset_tmp.FieldByName('field_value').IsNull then
       F_tmpSumPrinSnap:=  dset_tmp.FieldByName('field_value').AsInteger
        else F_tmpSumPrinSnap:= 0;}
end;


procedure Tdm_RepSvodVed_vds.GetLastOst(_dt : TDate);
var
    _sql : string;
    _rn: integer;
begin
   _sql :=
     ' select sv.field_value, sv.row_number from snshot_values_vds sv'+
      ' where ( '+
      ' sv.id_field = ( '+
      ' select sf.id from snshot_fields_vds sf where (sf.field_name = ''ostalos'')'+
      ' and (sf.id_dset = ('+
      ' select (sd.id) from snshot_dsets_vds sd where sd.id_snapshot ='+
      ' ( select max(ss.id) from snshot_snapshots_vds ss   where ID_TYPE=1 and ss.dt = '''+
      formatdatetime('dd.mm.yyyy', _dt-1) +''' ))))) order by sv.row_number';
    MyOpenIBDS(dset_tmp, _sql);

    dset_tmp.First;

    while not dset_tmp.Eof do
    begin
    //
    _rn := dset_tmp.FieldByName('row_number').AsInteger - 1;
    if _rn <= 10 then
     if not dset_tmp.FieldByName('field_value').IsNull then
       F_ArrLastOst[_rn]:=  dset_tmp.FieldByName('field_value').AsInteger
        else F_ArrLastOst[_rn]:= 0;
    dset_tmp.Next;

    end;
     F_ArrLastOst[10]:= 0;
end;


procedure Tdm_RepSvodVed_vds.InitCountByReg;
var
  reg_cond: string;
begin
  if trim(F_RegionsID)<>'' then
    reg_cond:=' and (id in'+F_RegionsID+')'
  else
    reg_cond:='';

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_Regions'+
    ' where (id>0)'+
    reg_cond+
    ' order by name');

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    md_CountByReg.Append;
    md_CountByReg.FieldByName('id_reg').AsInteger:=dset_tmp.FieldByName('id').AsInteger;
    md_CountByReg.FieldByName('region').AsString:=NameCase(dset_tmp.FieldByName('name').AsString);
    md_CountByReg.Post;
    dset_tmp.Next;
  end;

  md_CountByReg.Append;
  md_CountByReg.FieldByName('id_reg').AsInteger:=-1;
  md_CountByReg.FieldByName('region').AsString:='Всего за смену';
  md_CountByReg.Post;

  md_CountByReg.Append;
  md_CountByReg.FieldByName('id_reg').AsInteger:=-2;
  md_CountByReg.FieldByName('region').AsString:='С '+F_BEG_YEAR;
  md_CountByReg.Post;
end;

function Tdm_RepSvodVed_vds.PrepareDisconSumInfo(percent: integer): boolean;
begin
  Result:=false;

  md_DisconSumInfo.Close;
  md_DisconSumInfo.Open;

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_discontype_vds'+
    ' where (activity is null)'+
    ' and (id>0)');
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    md_DisconSumInfo.Append;
    md_DisconSumInfo.FieldByName('DisconType').AsString:=dset_tmp.FieldByName('name').AsString;
    md_DisconSumInfo.FieldByName('DCount').AsInteger:=GetDisconCount(dset_tmp.FieldByName('id').AsInteger);
    md_DisconSumInfo.Post;

    dset_tmp.Next;
  end;
  dset_tmp.Close;

  Result:=true;
end;

function Tdm_RepSvodVed_vds.GetDisconCount(id_discon: integer): integer;
begin
  Result:=0;
  md_Discon.First;
  while not md_Discon.Eof do
  begin
    if md_Discon.FieldByName('id_discon').AsInteger=id_discon then
      Result:=Result+1;
    md_Discon.Next;
  end;
end;

function Tdm_RepSvodVed_vds.GetOfficialName(id: integer): string;
begin
  MyOpenIBDS(dset_tmp, 'select name from s_officials where id='+IntToStr(id));
  Result:=trim(dset_tmp.FieldByName('name').AsString);
  dset_tmp.Close;
end;

procedure Tdm_RepSvodVed_vds.md_CountByRegCalcFields(DataSet: TDataSet);
var
  percent: double;
begin
  inherited;
  with DataSet do
  begin
{
    sum:=FieldByName('o62_prin').AsInteger+FieldByName('zhitel_prin').AsInteger;
    if sum<>0 then FieldByName('sum_prin').AsInteger:=sum;
}

{
    sum:=FieldByName('o62_vip').AsInteger+FieldByName('zhitel_vip').AsInteger;
    if sum<>0 then FieldByName('sum_vip').AsInteger:=sum;
}


    if FieldByName('sum_prin').AsInteger<>0 then
    begin
      percent:=100*(FieldByName('sum_vip').AsInteger/FieldByName('sum_prin').AsInteger);
      if percent<>0 then
        FieldByName('percent_vip').AsFloat:=percent;
    end;

  end;
end;

procedure Tdm_RepSvodVed_vds.DoSnapShot;
begin
  //F_SnapShotMgr.SnapShotDate:=F_Dt;
  F_SnapShotMgr.SnapShotDate:=F_CurSnapDt;
  F_SnapShotMgr.DoSnapShot;
  F_SnapUser := DM_RightsManager.CurrentUserName;
  if tran.Active then tran.Commit;
  SaveXML;
end;

procedure Tdm_RepSvodVed_vds.InitSnapShotMgr;
const
  ARR_FIELD: array [0..9] of string=
    ('region','o62_prin','ods_prin','zhitel_prin','sum_prin',
    'o62_vip','ods_vip', 'zhitel_vip','sum_vip', 'ostalos');
var
  sn_dset: TSnShotDset;
  i: integer;
begin
    F_SnapShotMgr.SnapShotType:='SVODVEDVDS';

    sn_dset:=F_SnapShotMgr.AddSNShotDset(md_CountByReg);
    for i:=low(ARR_FIELD) to high(ARR_FIELD) do
      sn_dset.FieldNameList.Add(ARR_FIELD[i]);
end;



procedure Tdm_RepSvodVed_vds.LoadSnapShot(dt: TDate);
begin
  F_SnapShotMgr.SnapShotDate:=dt;
  F_SnapShotMgr.LoadSnapShot;
  F_CurSnapDt := dt;
  F_SnapUser:= F_SnapShotMgr.CurUser;
  InitIDByReg;

  {$IFDEF FROMSNAPSHOT}
  GetLastOst(dt);
  GetLastPrin(dt);
  //CalcVsegoZaSmenu;
  {$ENDIF}
end;

procedure Tdm_RepSvodVed_vds.LoadSnapshotDatesList(var list: TStringList);
begin
  F_SnapShotMgr.LoadSnapshotDatesList(list);
end;

procedure Tdm_RepSvodVed_vds.md_CountByRego62_prinChange(Sender: TField);
var
  sum: integer;
begin
  inherited;
  {$IFDEF FROMSNAPSHOT}
  if md_CountByReg.RecNo < 11 then
  {$ENDIF}
  with md_CountByReg do
  begin
    sum:=FieldByName('o62_prin').AsInteger+FieldByName('zhitel_prin').AsInteger;
    if sum<>0 then FieldByName('sum_prin').AsInteger:=sum
    else FieldByName('sum_prin').Clear;
  end;
end;

procedure Tdm_RepSvodVed_vds.md_CountByRego62_vipChange(Sender: TField);
var
  sum: integer;
begin
  inherited;
  {$IFDEF FROMSNAPSHOT}
  if md_CountByReg.RecNo < 11 then
  {$ENDIF}
  with md_CountByReg do
  begin
    sum:=FieldByName('o62_vip').AsInteger+FieldByName('zhitel_vip').AsInteger;
    if sum<>0 then FieldByName('sum_vip').AsInteger:=sum
    else FieldByName('sum_vip').Clear;
  end;
end;

function Tdm_RepSvodVed_vds.PrepareCountByRegPer(dtBeg, dtEnd: TDate): boolean;
var
  i: integer;
begin
  Result:=false;

  md_CountByReg.Close;
  md_CountByReg.Open;

  InitCountByReg;
  AddCountForApplicant;
  AddOstalos;
  CalcVsegoZaSmenu;
  F_CurSnapDt := F_Dt;

  Result:=true;
end;


procedure Tdm_RepSvodVed_vds.SaveXML;
var Xml: IXMLDocument;
    _filename: string;
    _new, _newval: boolean;
    i: integer;
    _sdate, _list, _NodeName, _Atr: string;
    _inode: integer;



begin
    //

   _filename := AppSettings.Get_PathForXML + '\vds_to_stdisp.xml';
   _sdate := DateToStr(F_CurSnapDt);
   _new := not(FileExists(_filename));
   _newval := false;
   GetCountsForXML;
   Xml := TXMLDocument.Create(nil);
    if _new then
        begin
            Xml := NewXMLDocument;
            Xml.Encoding := 'UTF-8';
             Xml.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
                                  doAutoPrefix, doNamespaceDecl];

          with Xml.AddChild('VDS').AddChild('row') do
            begin
              Attributes['date'] :=  _sdate;
               // дочерние элементы
               ChildValues['OrderComingCount'] := F_OrderComingCount ;
               ChildValues['ClosedOrdersCount'] := F_ClosedOrdersCount ;
               ChildValues['NotClosedOrdersCount'] := F_NotClosedOrdersCount ;
            end;

          end  // _new = true
            else
          begin
          Xml := LoadXMLDocument(_filename);
          Xml.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull,
                                  doAutoPrefix, doNamespaceDecl];



          for i:= 0 to Xml.ChildNodes.FindNode('VDS').ChildNodes.Count - 1 do
           begin
               _NodeName := Xml.ChildNodes.FindNode('VDS').ChildNodes.Get(i).NodeName;
               _Atr := Xml.ChildNodes.FindNode('VDS').ChildNodes.Get(i).Attributes['date'];
               if (StrToDate(_Atr) = F_CurSnapDt ) then
                      begin
                        with Xml.ChildNodes.FindNode('VDS').ChildNodes.Get(i) do
                            begin
                               // дочерние элементы
                               ChildValues['OrderComingCount'] := F_OrderComingCount ;
                               ChildValues['ClosedOrdersCount'] := F_ClosedOrdersCount ;
                               ChildValues['NotClosedOrdersCount'] := F_NotClosedOrdersCount ;
                            end;//with
                        _newval := true;
                        break;
                      end;
            end;

              if not( _newval ) then
                 with Xml.ChildNodes.FindNode('VDS').AddChild('row') do
                    begin
                      Attributes['date'] := DateToStr(F_CurSnapDt);
                       // дочерние элементы
                       ChildValues['OrderComingCount'] := F_OrderComingCount ;
                       ChildValues['ClosedOrdersCount'] := F_ClosedOrdersCount ;
                       ChildValues['NotClosedOrdersCount'] := F_NotClosedOrdersCount ;
                    end;

           end; // _new = false

   // записываем
   Xml.SaveToFile (_filename);

end;

procedure Tdm_RepSvodVed_vds.GetCountsForXML;
var bmark: string;
begin
    //
    bmark:=md_CountByReg.Bookmark;
    md_CountByReg.Last;
    md_CountByReg.Prior;
    F_OrderComingCount := md_CountByReg.FieldByName('sum_prin').AsInteger;
    F_ClosedOrdersCount := md_CountByReg.FieldByName('sum_vip').AsInteger;
    F_NotClosedOrdersCount := md_CountByReg.FieldByName('ostalos').AsInteger;
    md_CountByReg.Bookmark:=bmark;


end;

       {
procedure Tdm_RepSvodVed.FindNodeAttributes(Node: IXMLNode); //а вот и наша процедурка
var i:integer; Attributes:variant;
begin
  if (Node.HasChildNodes) then   //если есть дочерние ноды
    for i := 0 to Node.ChildNodes.Count - 1 do
      FindNodeAttributes(Node.ChildNodes.Get(i)); //рекурсивно вызываем нашу процедуру
    if (Node.NodeType = ntElement) and ( Node.LocalName = 'row' ) then   //если тип ntElement то выводим его атрибуты
    begin
        if (Node.Attributes['date'] = _sdate ) then
          begin
            // _inode := Xml.ChildNodes.IndexOf(Node);
            //Xml.ChildNodes.Remove(Node);
           _newval := true;
           Exit;
          end;
    end;
end;
      }



procedure Tdm_RepSvodVed_vds.AddCountForApplicant_new;

function  get_regions():string ;
begin
if  F_RegionsID<>'' then
 Result:=' and ov.fk_orders_regions in '+F_RegionsID+' '
else
 Result:='';
end;

const SQL_prin=' select ov.fk_orders_regions,''prin_zhit'' field,count(*) col from orders_vds ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2 and'+
                 ' fk_orders_organisations<>18  %s'  +
                 ' group by 1,2';
    SQL_prin_nar=' union '+
                 ' select ov.fk_orders_regions, ''prin_nar'' field, count(*) col from orders_vds ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2  %s'+
                 ' group by 1,2';
SQL_vip_tek_zhit=' union '+
                 ' select ov.fk_orders_regions, ''vip_tek_zhit'' field, count(*) col from orders_vds ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2 and '+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 and'+
                 ' fk_orders_organisations<>18  %s '+
                 ' group by 1,2';
 SQL_vip_tek_nar=' union'+
                 ' select ov.fk_orders_regions, ''vip_tek_nar'' field, count(*) col from orders_vds ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2 and'+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2  %s'+
                 ' group by 1,2'+
                 ' union';

    vip_per_zhit=' select ov.fk_orders_regions, ''vip_per_zhit'' field, count(*) col from orders_vds ov '+
                 ' where ov.datecoming<:d1 and '+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 and'+
                 ' fk_orders_organisations<>18  %s'+
                 ' group by 1,2';

    vip_per_nar=' union'+
                 ' select ov.fk_orders_regions, ''vip_per_nar'' field, count(*) col from orders_vds ov '+
                 ' where ov.datecoming<:d1 and'+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 %s'+
                 ' group by 1,2 ';

     ost_nar=' union '+
             ' select ov.fk_orders_regions, ''ost_nar'' field, count(*) col from orders_vds ov'+
             ' where (ov.dateclosed>:d2 or '+
             ' ov.isclosed =0) and ov.datecoming<:d2  %s'+
             ' group by 1,2 '+
             ' order by 1';

function get_SQL_all():string;
var
 regs:string;
 begin
   regs:=get_regions();
   Result:='';
   Result:=Result+Format(SQL_prin,[regs]);
   Result:=Result+Format(SQL_prin_nar,[regs]);
   Result:=Result+Format(SQL_vip_tek_zhit,[regs]);
   Result:=Result+Format(SQL_vip_tek_nar,[regs]);
   Result:=Result+Format(vip_per_zhit,[regs]);
   Result:=Result+Format(vip_per_nar,[regs]);
   Result:=Result+Format(ost_nar,[regs]);


 end;

var
  sql: string;
  Arr: array [0..1] of string;
  i, j, iKol: integer;
  field:string;
begin

  dset_tmp.SelectSQL.Text:=get_SQL_all();
  dset_tmp.ParamByName('d1').AsString:=DateToStr(F_DT-1)+' 6:00:00';
  dset_tmp.ParamByName('d2').AsString:=DateToStr(F_DT)+' 6:00:01';
  dset_tmp.Open;

  dset_tmp.First;

////////////////////////

  md_CountByReg_new.First;

  while not dset_tmp.Eof do
  begin
    md_CountByReg_new.Edit;
    while (dset_tmp.FieldByName('fk_orders_regions').AsInteger= md_CountByReg_new.FieldByName('id_reg').AsInteger)
    and (not dset_tmp.eof) do
     begin
       field:=trim(dset_tmp.fieldbyname('field').AsString);
        md_CountByReg_new.FieldByName(field).AsInteger:=dset_tmp.fieldbyname('col').AsInteger;
        dset_tmp.Next;

     end;
     md_CountByReg_new.Post;
     md_CountByReg_new.Next;
   end;

end;




function Tdm_RepSvodVed_vds.PrepareCountByReg_new(percent: integer): boolean;
var
  i: integer;
begin
  Result:=false;

  md_CountByReg_new.Close;
  md_CountByReg_new.Open;

  InitCountByReg_new;
  AddCountForApplicant_new;
  Add_from_1562;

 CalMdRegion;
//  AddOstalos_new;
  CalcVsegoZaSmenu_new;
  F_CurSnapDt := F_Dt;

  Result:=true;
end;

procedure Tdm_RepSvodVed_vds.InitCountByReg_new;
var
  reg_cond: string;
begin
  if trim(F_RegionsID)<>'' then
    reg_cond:=' and (id in'+F_RegionsID+')'
  else
    reg_cond:='';

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_Regions'+
    ' where (id>0)'+
    reg_cond+
    ' order by name');

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    md_CountByReg_new.Append;
    md_CountByReg_new.FieldByName('id_reg').AsInteger:=dset_tmp.FieldByName('id').AsInteger;
    md_CountByReg_new.FieldByName('region').AsString:=NameCase(dset_tmp.FieldByName('name').AsString);
    md_CountByReg_new.Post;
    dset_tmp.Next;
  end;

  md_CountByReg_new.Append;
  md_CountByReg_new.FieldByName('id_reg').AsInteger:=-1;
  md_CountByReg_new.FieldByName('region').AsString:='Всего за смену';
  md_CountByReg_new.Post;

  md_CountByReg_new.Append;
  md_CountByReg_new.FieldByName('id_reg').AsInteger:=-2;
  md_CountByReg_new.FieldByName('region').AsString:='С '+F_BEG_YEAR;
  md_CountByReg_new.Post;
end;


function Tdm_RepSvodVed_vds.FromadoDsetMD(field_query,field_md:string):boolean;
var val:integer;
    i, id_reg:integer;
    V:variant;
begin
  Result:=false;
  if  not ado_dset.IsEmpty then
  begin
   ado_dset.Last;
   ado_dset.Prior;

   md_CountByReg_new.First;
   while   (not ado_dset.eof)and
           ( not md_CountByReg_new.Eof)and
           (md_CountByReg_new.FieldByName('id_reg').AsInteger>0)  do
   begin
    md_CountByReg_new.Edit;
    id_reg:=md_CountByReg_new.FieldByName('id_reg').AsInteger;
    V:=ado_dset.Lookup('region',id_reg,field_query);
    if V<>null then
     begin
      val:=V;
      md_CountByReg_new.FieldByName(field_md).AsInteger:= val;
     end ;
    md_CountByReg_new.Post;
    md_CountByReg_new.Next;

   end;
    ado_dset.Last;
    while  md_CountByReg_new.FieldByName('id_reg').AsInteger<>-1 do
     md_CountByReg_new.Next;
    md_CountByReg_new.Edit;
    md_CountByReg_new.FieldByName(field_md).AsInteger:=ado_dset.FieldByName(field_query).AsInteger;
    md_CountByReg_new.Post;
  end;
  Result:=true;
end;

procedure  Tdm_RepSvodVed_vds.fromquerytodm( procname,dt1,dt2,field_query, field_md:string; field_query2, field_md2:string);
var i:integer;
begin
 try
  query.SQL.Clear;
  query.SQL.Add('execute '+procname+' '''+dt1+''' ,'''+dt2+'''');
  query.Open;
   try
    ado_dset.Recordset:=query.Recordset;
    if  FromadoDsetMD(field_query,field_md) then
     begin
     if field_md2<>'' then begin
     i:=0;
     ado_dset.Recordset:=query.NextRecordset(i);
     FromadoDsetMD(field_query2,field_md2);
     end;
     end;


   finally
    query.close;
   end;
 except on e:exception do
 begin
   Application.MessageBox(PChar(e.Message+#13+' 1562  Сводка Вдс 2'), 'Ошибка', MB_OK  );
   exit;
 end;
 end

end;

procedure Tdm_RepSvodVed_vds.Add_from_1562();
var
 dt1,dt2:string;
 dset:_Recordset;
  id_reg:integer;
 val:integer;
 i:integer;
begin
  dt1:=formatdatetime('mm.dd.yyyy', F_Dt-1)+' 6:00:00';
  dt2:=formatdatetime('mm.dd.yyyy', F_Dt)+' 6:00:00';

  fromquerytodm( 'spCountTendersPeriod2_2',dt1,dt2,'within_the_building','prin_1562_new','within_the_building','prin_1562_rall');
  fromquerytodm( 'spCountTendersPeriod',dt1,dt2, 'closed_within_the_building','1562_vip_tek_new','closed_within_the_building','1562_vip_tek_rall');
  fromquerytodm('spCountTendersClosedPeriod',dt1,dt2,'closed_within_the_building','1562_vipall_new','closed_within_the_building','1562_vipall_rall');


end;

procedure Tdm_RepSvodVed_vds.md_CountByReg_newprin_1562_newChange(
  Sender: TField);
  var sum:integer;
begin
  inherited;
  with  md_CountByReg_new do
  begin
    if RecNo<11 then
     begin
      sum:=FieldByName('prin_1562_new').AsInteger+FieldByName('prin_1562_rall').AsInteger+FieldByName('prin_zhit').AsInteger;
      if sum>0 then
        fieldbyname('prin_all').AsInteger:=sum;
     end
  end;



end;

procedure Tdm_RepSvodVed_vds.md_CountByReg_newvip_tek_1562Change(
  Sender: TField);
  var sum:integer;
begin
  inherited;
   with  md_CountByReg_new do begin
    if RecNo<11 then
    begin
      sum:=FieldByName('vip_tek_1562').asinteger+FieldByName('vip_tek_zhit').AsInteger;
      if sum>0 then
        FieldByName('vip_tek_all').asinteger:=0;
    end;
   end;

end;

procedure Tdm_RepSvodVed_vds.md_CountByReg_newvip_per_1562Change(
  Sender: TField);
 var
  sum:integer;
begin
  inherited;
  with  md_CountByReg_new do begin
    if RecNo<11 then
    begin
      sum:=FieldByName('vip_per_1562').asinteger+FieldByName('vip_per_zhit').AsInteger;
      if sum>0 then
        FieldByName('vip_per_all').asinteger:=0;
    end;
   end;
end;


procedure Tdm_RepSvodVed_vds.CalcVsegoZaSmenu_new;
  procedure SumByField(f_name: string);
  var
    sum: integer;
  begin
    sum:=0;
    md_CountByReg_new.First;
    while not md_CountByReg_new.Eof do
    begin
      if md_CountByReg_new.FieldByName('id_reg').AsInteger>0 then
        sum:=sum+md_CountByReg_new.FieldByName(f_name).AsInteger;
      md_CountByReg_new.Next;
    end;
    if (md_CountByReg_new.Locate('id_reg', -1, [])) and (sum<>0) then
    begin
      md_CountByReg_new.Edit;
      md_CountByReg_new.FieldByName(f_name).AsInteger:=sum;
      md_CountByReg_new.Post;
    end;
  end;

  {procedure SumOstRecalc;
   var _ost, _prin, _vip:integer;
  begin
      //
     _ost := 0;
     _prin := 0;
     _vip := 0;
     md_CountByReg.First;
     while (not md_CountByReg.Eof) and (md_CountByReg.RecNo < 10) do
      begin
  //      if F_ArrLastOst[md_CountByReg.RecNo-1] > 0 then
        if md_CountByReg.FieldByName('sum_prin').IsNull then _prin := 0
          else _prin := md_CountByReg.FieldByName('sum_prin').AsInteger;
        if md_CountByReg.FieldByName('sum_vip').IsNull then _vip := 0
          else _vip := md_CountByReg.FieldByName('sum_vip').AsInteger;
        _ost := F_ArrLastOst[md_CountByReg.RecNo-1] + _prin - _vip;
        md_CountByReg.Edit;
        md_CountByReg.FieldByName('ostalos').AsInteger:= _ost;
        md_CountByReg.Post;
        md_CountByReg.Next;
      end;
  end;}

const
  arr_field: array [0..3] of string=('o62','ods','zhitel','sum');
  arr_type: array[0..1] of string=('_prin', '_vip');
var
  i, j, _sump, _sumv, _sum_ost, _o62_prin, _o62_vip, _zhitel_prin, _zhitel_vip : integer;
  bmark: string;
begin
  md_CountByReg_new.DisableControls;
  bmark:=md_CountByReg_new.Bookmark;
  for i:=1 to 21  do
   SumByField(md_CountByReg_new.Fields[i].FieldName);

{  {$IFDEF FROMSNAPSHOT}
 // SumOstRecalc;
  ///SumByField('ostalos');

{    if (md_CountByReg.Locate('id_reg', -1, [])) then
    begin
      _sump := md_CountByReg.FieldByName('sum_prin').AsInteger;
      _sumv := md_CountByReg.FieldByName('sum_vip').AsInteger;
      _sum_ost := md_CountByReg.FieldByName('ostalos').AsInteger;
      _o62_prin := md_CountByReg.FieldByName('o62_prin').AsInteger;
      _o62_vip := md_CountByReg.FieldByName('o62_vip').AsInteger;
      _zhitel_prin := md_CountByReg.FieldByName('zhitel_prin').AsInteger;
      _zhitel_vip := md_CountByReg.FieldByName('zhitel_vip').AsInteger;

      if F_HappyNewYear then
        begin
          F_tmpSumPrinSnap := 0; // с нового года всё с 0, кроме ost
          F_tmpSumVipSnap := 0;
          F_tmpSumPrinSnap062 := 0;
          F_tmpSumPrinSnapZh := 0;
          F_tmpSumVipSnap062 := 0;
          F_tmpSumVipSnapZh := 0;
        end;
      md_CountByReg.Next;
      md_CountByReg.Edit;
      md_CountByReg.FieldByName('sum_prin').AsInteger := F_tmpSumPrinSnap + _sump;
      md_CountByReg.FieldByName('sum_vip').AsInteger := F_tmpSumVipSnap + _sumv;

    //  F_OrderComingCount :=  _sump;
    //  F_ClosedOrdersCount :=  _sumv;
    //  F_NotClosedOrdersCount := F_OrderComingCount - F_ClosedOrdersCount;

      md_CountByReg.FieldByName('o62_prin').AsInteger := F_tmpSumPrinSnap062 + _o62_prin;
      md_CountByReg.FieldByName('o62_vip').AsInteger := F_tmpSumVipSnap062 + _o62_vip;
      md_CountByReg.FieldByName('zhitel_prin').AsInteger := F_tmpSumPrinSnapZh + _zhitel_prin;
      md_CountByReg.FieldByName('zhitel_vip').AsInteger := F_tmpSumVipSnapZh + _zhitel_vip;

      md_CountByReg.Post;
    end;
  {$ENDIF}
  md_CountByReg_new.Bookmark:=bmark;
  md_CountByReg_new.EnableControls;
end;

procedure Tdm_RepSvodVed_vds.CalMdRegion();
begin
   md_CountByReg_new.First;
   while md_CountByReg_new.FieldByName('id_reg').AsInteger>0 do
   begin
     CalcRowmdRegion();
     md_CountByReg_new.Next;
   end;
end;

procedure Tdm_RepSvodVed_vds.CalcRowmdRegion();
function getv(field:string):integer;
begin
  Result:= md_CountByReg_new.FieldByName(field).AsInteger;
end;
begin
  with  md_CountByReg_new do
  begin
   Edit;
    fieldbyname('vip_tek_1562').AsInteger:=fieldbyname('1562_vip_tek_new').AsInteger+
                                            fieldbyname('1562_vip_tek_rall').AsInteger;
    fieldbyname('vip_per_1562').AsInteger:=fieldbyname('1562_vipall_new').AsInteger+
                                           fieldbyname('1562_vipall_rall').AsInteger-
                                           fieldbyname('vip_tek_1562').AsInteger ;
    fieldbyname('prin_all').AsInteger:=fieldbyname('prin_1562_new').AsInteger+
                                       getv('prin_1562_rall')+getv('prin_zhit');
    fieldbyname('vip_tek_all').AsInteger:=getv('vip_tek_1562')+getv('vip_tek_zhit');
    fieldbyname('vip_per_all').AsInteger:=getv('vip_per_1562')+getv('vip_per_zhit');
   Post;
  end;

end;

procedure Tdm_RepSvodVed_vds.InitSnapShotMgr_new;
const
  ARR_FIELD: array [0..25] of string=( 'prin_1562_new',
    'prin_1562_rall',
    'prin_zhit',
    'prin_all',
    'prin_narad',
    'vip_tek_1562',
    'vip_tek_zhit',
    'ptin_tek_all',
    'prin_tek_nar',
    'vip_per_1562',
    'vip_per_zhit',
    'vip_per_all',
    'vip_per_nar',
    'ost_zayv',
    'ost_nar',
    'ods_vip',
    'ods_prin',
    'Region',
    'vip_tek_nar',
    'vip_tek_all',
    'ost_1562',
    'ost_zhit',
    '1562_vipall_new',
    '1562_vipall_rall',
    '1562_vip_tek_new',
    '1562_vip_tek_rall');
var
  sn_dset: TSnShotDset;
  i: integer;
begin
    F_SnapShotMgr.SnapShotType:='SVODVEDVDS_2';

    sn_dset:=F_SnapShotMgr.AddSNShotDset(md_CountByReg_new);
    for i:=low(ARR_FIELD) to high(ARR_FIELD) do
      sn_dset.FieldNameList.Add(ARR_FIELD[i]);
end;

end.

