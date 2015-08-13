unit RepSvodVedDModule;
{$DEFINE FROMBASE}
{$DEFINE FROMSNAPSHOT}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, HelpClasses,
  IBDatabase, DModule, IBCustomDataSet, FR_DSet, FR_DBSet, SnapShotManagerDModule,
  xmldom, XMLIntf, msxmldom, XMLDoc;

type
  Tdm_RepSvodVed = class(Tdm_NGReportBase)
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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure md_CountByRegCalcFields(DataSet: TDataSet);
    procedure md_CountByRego62_prinChange(Sender: TField);
    procedure md_CountByRego62_vipChange(Sender: TField);
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
  end;


implementation

{$R *.dfm}

uses ApplicationSettings, HelpFunctions, DateUtils, RightsManagerDModule;

{ Tdm_RepSvodVed }

function Tdm_RepSvodVed.PrepareDsets: boolean;
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

procedure Tdm_RepSvodVed.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_ApplicantList:=TNameContainer.Create;
  FillApplicantList;
  F_SnapShotMgr:=Tdm_SnapShotManager.Create(nil);
  InitSnapShotMgr;
 // tran.StartTransaction;
end;

procedure Tdm_RepSvodVed.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_ApplicantList.Free;
  F_SnapShotMgr.Free;

 if tran.Active then tran.Commit;
end;

procedure Tdm_RepSvodVed.FillApplicantList;
begin
  with F_ApplicantList do
  begin
    IDByName['o62']:='2';
    IDByName['ods']:='3';
    IDByName['zhitel']:='1';
  end;
end;

function Tdm_RepSvodVed.PrepareCountByReg(percent: integer): boolean;
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

function Tdm_RepSvodVed.PrepareDiscon(percent: integer): boolean;
var
  i, _dc: integer;
  reg_cond: string;
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
    ' (select name from s_discontype where id=d.fk_discon_discontype) discontype,'+
    ' o.OrderNumber,'+
    ' (select name from s_district where id=o.fk_orders_district) district,'+
    ' (select name from s_DisconReason where id=d.fk_discon_disconreason) disconreason'+
    ' from disconnections d'+
    ' left join orders o on d.fk_discon_order=o.id'+
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
procedure Tdm_RepSvodVed.AddCountForApplicant;

  function get_sql(_type, id_reg: integer; id_app: string): string;
  var
    dt_cond: string;
    dt_beg, dt_end, add_cond, reg_cond: string;
  begin
    if Trim(id_app)='3'  then
     begin
      Result:='select distinct ''0'' kol'+
      ' from orders';
      Exit;
     end;
    if id_reg=-2 then
    begin //
      dt_beg:=F_BEG_YEAR;
      if trim(F_RegionsID)<>'' then reg_cond:=' and (fk_orders_regions in '+F_RegionsID+')'
      else reg_cond:='';
      //add_cond:=Format(' %s and (fk_orders_applicant=%s)', [reg_cond, id_app]);
       if Trim(id_app)='2' then
            add_cond:=' and fk_orders_organisations=17';
      if Trim(id_app)='1' then
            add_cond:=' and fk_orders_organisations<>17';
      add_cond:=id_app+' '+add_cond;

    end else
    begin
      dt_beg:=DateToStr(F_Dt);
       if Trim(id_app)='2' then
            add_cond:=' and fk_orders_organisations=17';
      if Trim(id_app)='1' then
            add_cond:=' and fk_orders_organisations<>17';
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
      ' from orders'+
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
         ' select sv.field_value kol from snshot_values sv'+
          ' where (sv.row_number = 11) and ( '+
          ' sv.id_field = ( '+
          ' select sf.id from snshot_fields sf where (sf.field_name =''sum' + Arr[i] + ''')'+
//          trim(F_ApplicantList.NameByIndex(j))+Arr[i] + ''')'+
          ' and (sf.id_dset = ('+
          ' select (sd.id) from snshot_dsets sd where sd.id_snapshot ='+
          ' ( select max(ss.id) from snshot_snapshots ss where ss.dt = '''+
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
          begin
            md_CountByReg.Edit;
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
procedure Tdm_RepSvodVed.AddCountForApplicant;
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
         ' select sv.field_value kol from snshot_values sv'+
          ' where (sv.row_number = 11) and ( '+
          ' sv.id_field = ( '+
          ' select sf.id from snshot_fields sf where (sf.field_name = ''sum' + Arr[i] + ''')'+
          ' and (sf.id_dset = ('+
          ' select (sd.id) from snshot_dsets sd where sd.id_snapshot ='+
          ' ( select max(ss.id) from snshot_snapshots ss where ss.dt = '''+
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




procedure Tdm_RepSvodVed.AddOstalos;
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
        ' from orders'+
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
        ' from orders'+
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

procedure Tdm_RepSvodVed.CalcVsegoZaSmenu;
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

procedure Tdm_RepSvodVed.InitIDByReg;
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

procedure Tdm_RepSvodVed.GetLastPrin(_dt : TDate);
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
     ' from snshot_fields sf, snshot_values sv'+
      ' where (sv.row_number = 11) and sv.id_field = sf.id and ( '+
      ' sf.field_name in ' +
      '(''zhitel_prin'', ''o62_prin'', ''sum_prin'', ''zhitel_vip'', ''o62_vip'',''sum_vip''))'+
      ' and (sf.id_dset = ('+
      ' select (sd.id) from snshot_dsets sd where sd.id_snapshot ='+
      ' ( select max(ss.id) from snshot_snapshots ss where ss.dt = '''+
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


procedure Tdm_RepSvodVed.GetLastOst(_dt : TDate);
var
    _sql : string;
    _rn: integer;
begin
   _sql :=
     ' select sv.field_value, sv.row_number from snshot_values sv'+
      ' where ( '+
      ' sv.id_field = ( '+
      ' select sf.id from snshot_fields sf where (sf.field_name = ''ostalos'')'+
      ' and (sf.id_dset = ('+
      ' select (sd.id) from snshot_dsets sd where sd.id_snapshot ='+
      ' ( select max(ss.id) from snshot_snapshots ss where ss.dt = '''+
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


procedure Tdm_RepSvodVed.InitCountByReg;
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

function Tdm_RepSvodVed.PrepareDisconSumInfo(percent: integer): boolean;
begin
  Result:=false;

  md_DisconSumInfo.Close;
  md_DisconSumInfo.Open;

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_discontype'+
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

function Tdm_RepSvodVed.GetDisconCount(id_discon: integer): integer;
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

function Tdm_RepSvodVed.GetOfficialName(id: integer): string;
begin
  MyOpenIBDS(dset_tmp, 'select name from s_officials where id='+IntToStr(id));
  Result:=trim(dset_tmp.FieldByName('name').AsString);
  dset_tmp.Close;
end;

procedure Tdm_RepSvodVed.md_CountByRegCalcFields(DataSet: TDataSet);
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

procedure Tdm_RepSvodVed.DoSnapShot;
begin
  //F_SnapShotMgr.SnapShotDate:=F_Dt;
  F_SnapShotMgr.SnapShotDate:=F_CurSnapDt;
  F_SnapShotMgr.DoSnapShot;
  F_SnapUser := DM_RightsManager.CurrentUserNameOnly;
  if tran.Active then tran.Commit;
  SaveXML;
end;

procedure Tdm_RepSvodVed.InitSnapShotMgr;
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

procedure Tdm_RepSvodVed.LoadSnapShot(dt: TDate);
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

procedure Tdm_RepSvodVed.LoadSnapshotDatesList(var list: TStringList);
begin
  F_SnapShotMgr.LoadSnapshotDatesList(list);
end;

procedure Tdm_RepSvodVed.md_CountByRego62_prinChange(Sender: TField);
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

procedure Tdm_RepSvodVed.md_CountByRego62_vipChange(Sender: TField);
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

function Tdm_RepSvodVed.PrepareCountByRegPer(dtBeg, dtEnd: TDate): boolean;
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


procedure Tdm_RepSvodVed.SaveXML;
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

procedure Tdm_RepSvodVed.GetCountsForXML;
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

end.
