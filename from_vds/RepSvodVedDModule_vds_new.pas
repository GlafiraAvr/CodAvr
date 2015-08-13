unit RepSvodVedDModule_vds_new;    { !_save - отключения нс}
{$define from_snshot}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, xmldom, XMLIntf, ADODB, msxmldom, XMLDoc,
  DB, FR_DSet, FR_DBSet, IBCustomDataSet, IBDatabase, RxMemDS, FR_Class,
  HelpClasses, SnapShotManagerDModule_vds;
const
  GET_FIREBIRDDATA='Формирование данных по нарядам';
  GET_MSSQL_DATA='Формирование данных  по заявкам';
  GET_ALLDATA='Формирование  итога' ;
  GET_DATA_YEAR = 'Данные за год :  ';

type TOrgs=( ns, vds);
type

  Tdm_RepSvodVed_vds_new = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset_tmp: TIBDataSet;
    frDSet: TfrDBDataSet;
    md_Discon: TRxMemoryData;
    md_Disconid_reg: TIntegerField;
    md_Disconregion: TStringField;
    md_Disconadres: TStringField;
    md_Discondiscontype: TStringField;
    md_Discondttm_discon: TDateTimeField;
    md_Disconid_discon: TIntegerField;
    md_DisconOrderNumber: TIntegerField;
    md_Discondistrict: TStringField;
    md_DisconDaysCount: TIntegerField;
    md_DisconDisconReason: TStringField;
    md_DisconG_ZHD: TIntegerField;
    md_DisconG_KV: TIntegerField;
    md_DisconG_STOJ: TIntegerField;
    md_DisconG_ST_SP: TIntegerField;
    md_DisconG_POD: TIntegerField;
    md_DisconG_GV: TStringField;
    frDS_Discon: TfrDBDataSet;
    md_DisconSumInfo: TRxMemoryData;
    md_DisconSumInfodiscontype: TStringField;
    md_DisconSumInfodcount: TIntegerField;
    frDS_DisconSumInfo: TfrDBDataSet;
    XMLDocument1: TXMLDocument;
    md_CountByReg_new: TRxMemoryData;
    md_CountByReg_newid_reg: TIntegerField;
    md_CountByReg_newprin_all: TIntegerField;
    md_CountByReg_newprin_1562_new: TIntegerField;
    md_CountByReg_newprin_1562_rall: TIntegerField;
    md_CountByReg_newprin_zhit: TIntegerField;
    md_CountByReg_newprin_narad: TIntegerField;
    md_CountByReg_newvip_tek_1562: TIntegerField;
    md_CountByReg_newvip_tek_zhit: TIntegerField;
    md_CountByReg_newvip_per_1562: TIntegerField;
    md_CountByReg_newvip_per_zhit: TIntegerField;
    md_CountByReg_newvip_per_all: TIntegerField;
    md_CountByReg_newvip_per_nar: TIntegerField;
    md_CountByReg_newvip_tek_nar: TIntegerField;
    md_CountByReg_newost_zayv: TIntegerField;
    md_CountByReg_newost_nar: TIntegerField;
    md_CountByReg_newods_vip: TIntegerField;
    md_CountByReg_newods_prin: TIntegerField;
    md_CountByReg_newvip_tek_all: TIntegerField;
    md_CountByReg_newost_1562: TIntegerField;
    md_CountByReg_newost_zhit: TIntegerField;
    md_CountByReg_newField1562_vipall_new: TIntegerField;
    md_CountByReg_newField1562_vipall_rall: TIntegerField;
    md_CountByReg_newField1562_vip_tek_new: TIntegerField;
    md_CountByReg_newField1562_vip_tek_rall: TIntegerField;
    md_CountByReg_newRegion: TStringField;
    query: TADOQuery;
    ado_dset: TADODataSet;
    md_CountByReg_newvip_nar_all: TIntegerField;
    md_CountByReg_newpercent_n: TFloatField;
    md_CountByReg_newprin_zhit_new: TIntegerField;
    md_CountByReg_newField1562_vip_per_rall: TIntegerField;
    md_CountByReg_newprin_all_1562: TIntegerField;
    md_CountByReg_newvip_zhit_all: TIntegerField;
    md_CountByReg_newvip_all_1562: TIntegerField;
    md_CountByReg_newprin_1562_rall_new: TIntegerField;
    md_CountByReg_newprin_1562_rall_old: TIntegerField;
    md_CountByReg_newprin_failure_1562: TIntegerField;
    md_CountByReg_newprin_failure_rall_1562: TIntegerField;
    md_CountByReg_newvip_tek_failure_1562: TIntegerField;
    md_CountByReg_newvip_per_failure_1562: TIntegerField;
    md_CountByReg_newvip_per_failure_rall_1562: TIntegerField;
    md_CountByReg_newvip_tek_failure_rall_1562: TIntegerField;
    md_CountByReg_newcol_dep: TIntegerField;
    md_CountByReg_newprin_1562_all: TIntegerField;
    md_CountByReg_newprin__orders_tech: TIntegerField;
    md_CountByReg_newost_order_tech: TIntegerField;
    md_CountByReg_newwip_per_rall_1562: TIntegerField;
    md_CountByReg_newvip_nar_leak: TIntegerField;
    md_HappyNewYear: TRxMemoryData;
    md_HappyNewYearid_reg: TIntegerField;
    md_HappyNewYearprin_all: TIntegerField;
    md_HappyNewYearprin_1562_new: TIntegerField;
    md_HappyNewYearprin_1562_all: TIntegerField;
    md_HappyNewYearprin_zhit: TIntegerField;
    md_HappyNewYearprin_nar: TIntegerField;
    md_HappyNewYearvip_tek_1562: TIntegerField;
    md_HappyNewYearvip_tek_xhit: TIntegerField;
    md_HappyNewYearvip_per_1562: TIntegerField;
    md_HappyNewYearvip_per_zhit: TIntegerField;
    md_HappyNewYearvip_per_all: TIntegerField;
    md_HappyNewYearvip_per_nar: TIntegerField;
    md_HappyNewYearvip_tek_nar: TIntegerField;
    md_HappyNewYearcol_dep: TIntegerField;
    md_HappyNewYearost_zayv: TIntegerField;
    md_HappyNewYearost_nar: TIntegerField;
    md_HappyNewYearods_vip: TIntegerField;
    md_HappyNewYearods_prin: TIntegerField;
    md_HappyNewYearvip_tek_all: TIntegerField;
    md_HappyNewYearost_1562: TIntegerField;
    md_HappyNewYearpercent_n: TFloatField;
    md_HappyNewYearost_zhit: TIntegerField;
    md_HappyNewYear1562_vip_tek_new: TIntegerField;
    md_HappyNewYear1562_vip_all_new: TIntegerField;
    md_HappyNewYear1562_vip_all_rall: TIntegerField;
    md_HappyNewYear1562_vip_tek_rall: TIntegerField;
    md_HappyNewYear_vip_nar_all: TIntegerField;
    md_HappyNewYearprin_zhit_new: TIntegerField;
    md_HappyNewYear1562_vip_per_rall: TIntegerField;
    md_HappyNewYearprin_all_1562: TIntegerField;
    md_HappyNewYearvip_zhit_all: TIntegerField;
    md_HappyNewYearprin_1562_rall_old: TIntegerField;
    md_HappyNewYearprin_failure_1562: TIntegerField;
    md_HappyNewYearprin_1562_rall_new: TIntegerField;
    md_HappyNewYearprin_failure_rall_1562: TIntegerField;
    md_HappyNewYearprin__1562_all: TIntegerField;
    md_HappyNewYearprin_nar_leak: TIntegerField;
    md_HappyNewYearost_nar_leak: TIntegerField;
    md_HappyNewYearvip_nar_leak: TIntegerField;
    md_HappyNewYearvip_per_rall_1562: TIntegerField;
    md_HappyNewYearvip_tek_failurel_1562: TIntegerField;
    md_HappyNewYearvip_per_failurel_1562: TIntegerField;
    md_HappyNewYearvip_per_failure_ralll_1562: TIntegerField;
    md_HappyNewYearvip_tek_failure_ralll_1562: TIntegerField;
    md_HappyNewYearvip_per_alll_1562: TIntegerField;
    md_HappyNewYearRegion: TStringField;
    frDBD_NewYEar: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
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

    F_DTbeg,F_Dt_end:TDateTime;
    F_tip:integer;
    F_org:TOrgs; {для vds ns}
    F_SetMessage:TGetStrProc;
    procedure setMessage(mes:String);
    procedure InitCountByReg;
    procedure InitCountByReg_new;

    //procedure InitIDByReg;
  //  procedure GetLastOst(_dt : TDate);
  //  procedure GetLastPrin(_dt : TDate);


    function PrepareDiscon(percent: integer): boolean;
    function PrepareDisconSumInfo(percent: integer): boolean;
    function GetDisconCount(id_discon: integer): integer;

    procedure SaveXML;
    procedure GetCountsForXML;
//    procedure FindNodeAttributes(Node: IXMLNode);
    procedure   AddCountForApplicant_new(fieldname:string;F_DtBeg, F_Dt_End:TDateTime); //08.08.2012
    function PrepareCountByReg_new(percent: integer): boolean; //09.08.2012
    procedure Add_from_1562(F_DtBeg,F_Dt_End:TDateTime; id_input_reg:integer=0);
    function FromadoDsetMD(field_query,field_md:string;id_input_reg:integer=0):boolean;
    procedure fromquerytodm( procname:string; Pars:TStringList; field_query, field_md:string; field_query2, field_md2:string;id_input_regio:integer);
    procedure CalcRowmdRegion();
    procedure CalMdRegion();
    procedure InitSnapShotMgr_new;
    procedure InitIDByReg;
    procedure GetostZayav;
    procedure FromNewYear();
    procedure ClearFields();
    procedure AfterLoad();//заполнаяем не сохранямые поля
    procedure setItogYearFromMSSQL();{попробуем выбрать из view}
  public
    _save:boolean;
    Cond_leak_vds:String;
    Cond_leak_ns:String;
    property Dt: TDate read F_Dt write F_Dt;
    property HappyNewYear: boolean read F_HappyNewYear write F_HappyNewYear;
    property CurSnapDt: TDate read F_CurSnapDt write F_CurSnapDt;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property SnapUser:string read F_SnapUser;

    property   DT_Beg:TDateTime  read F_DTbeg write F_DTbeg;
    property   DT_End:TDateTime  read F_Dt_end write F_Dt_end ;
    property   tip:integer write F_tip;

 //   function PrepareDsets: boolean; dynamic;
    function GetOfficialName(id: integer): string;
   // function PrepareCountByRegPer(dtBeg, dtEnd: TDate): boolean;
    function DoSnapShot:boolean;
    procedure LoadSnapShot(dt: TDate);

    procedure LoadSnapshotDatesList(var list: TStringList);

    function PrepareDsets_new: boolean;  //09.08.2012
    procedure CalcVsegoZaSmenu_new;
    procedure Recalc();
    property  Org:TOrgs write  F_org;
    property PSetMessage:TGetStrProc write F_SetMessage;

    private
    {считаем также как и остновную инфу но сдругим интервалом дат и район -2}
     procedure calcFromNewYearFact();
     procedure CopyToNewYear();

  end;

var
  dm_RepSvodVed_vds_new: Tdm_RepSvodVed_vds_new;

implementation

uses ApplicationSettings, HelpFunctions, DateUtils, RightsManagerDModule, WaitProcessForm;

{$R *.dfm}

procedure Tdm_RepSvodVed_vds_new.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_ApplicantList:=TNameContainer.Create;
//  FillApplicantList;
  F_SnapShotMgr:=Tdm_SnapShotManager.Create(nil);
  InitSnapShotMgr_new;
  _Save:=false;
end;

procedure Tdm_RepSvodVed_vds_new.DataModuleDestroy(Sender: TObject);
begin
  inherited;
   F_ApplicantList.Free;
  F_SnapShotMgr.Free;
 if tran.Active then tran.Commit;
end;



function Tdm_RepSvodVed_vds_new.PrepareDsets_new: boolean;
var  frm_w:Tfrm_WaitProcess;
     id_typ:integer ;{2- новая ВДС 3- НС}
begin


  Result:=false;
  F_BEG_YEAR:=IntToStr(YearOf(F_Dt));
 { if F_DTBeg=0 then
  begin
   F_DTBeg:=Trunc( F_Dt-1 ) + Frac( StrToTime('6:00:00') );
   F_Dt_End:=Trunc( F_Dt ) + Frac( StrToTime('6:00:01') );
  end;}
   ResetProgressFields;
{$ifdef from_snshot}
 case F_org of
  ns :begin id_typ:=3; F_SnapShotMgr.SnapShotType:='SVODVEDNS_2'; Cond_Leak_ns:=' and ov.fk_orders_damageplace in(1,2)'; end;
  vds : begin id_typ:=2; F_SnapShotMgr.SnapShotType:='SVODVEDVDS_2';  Cond_Leak_vds:=' join s_messagetypes_vds sm on sm.id=ov.fk_orders_messagetypes and sm.group_message=1 ';  end;
  end;
 MyOpenIBDS(dset_tmp,format(
    ' select count(dt)'+
    ' from SNSHOT_SNAPSHOTS_vds'+
    ' where (dt = '''+ DateToStr(Dt) +''') and id_type=%d' ,[id_typ]));
   dset_tmp.first;
   if dset_tmp.FieldByName('count').AsInteger>0 then
   begin
    LoadSnapshot(Dt);
    CopyToNewYear();
   end
  else
 {$endif}
    if not PrepareCountByReg_new(50) then exit;

      if (F_tip=0) and (f_org=vds) then
      if not PrepareDiscon(30) then exit
      else
       if not PrepareDisconSumInfo(20) then exit;


  Result:=true;
end;


procedure Tdm_RepSvodVed_vds_new.AddCountForApplicant_new( fieldname:string; F_DtBeg, F_Dt_End:TDateTime);

function  get_regions():string ;
begin
if  F_RegionsID<>'' then
 Result:=' and ov.fk_orders_regions in '+F_RegionsID+' '
else
 Result:='';
end;

const {SQL_prin=' select ov.fk_orders_regions,''prin_zhit'' field,count(*) col '+
               ' from orders_vds ov left join numsorders_vds nvs  on ov.id=nvs.id_order'+
               ' where ov.datecoming>=:d1 and ov.datecoming<:d2 %s and '+
               ' nvs.id is null '+
               ' group by 1,2';}
    SQL_prin_nar=' select %s fk_orders_regions, ''prin_nar'' field, count(*) col from %s ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2  %s'+
                 ' group by 1,2';
{SQL_vip_tek_zhit=' union '+
                 ' select ov.fk_orders_regions, ''vip_tek_zhit'' field, count(*) col'+
                 ' from orders_vds ov '+
                 ' left join numsorders_vds nvs on nvs.id_order=ov.id'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2 %s and'+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 and'+
                 ' nvs.id is null'+
                 ' group by 1,2';}
 SQL_vip_tek_nar=' union'+
                 ' select %s, ''vip_tek_nar'' field, count(*) col from %s ov'+
                 ' where ov.datecoming>=:d1 and ov.datecoming<:d2 and'+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2  %s'+
                 ' group by 1,2';


{    vip_per_zhit=' union'+
                 ' select %s, ''vip_per_zhit'' '+
                 ' field, count(*) col from orders_vds ov '+
                 ' left join numsorders_vds nvs on ov.id=nvs.id_order'+
                 ' where ov.datecoming<:d1  %s and '+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 and'+
                 ' nvs.id is null'+
                 ' group by 1,2';}

    vip_per_nar=' union'+
                 ' select %s, ''vip_per_nar'' field, count(*) col from %s ov '+
                 ' where ov.datecoming<:d1 and'+
                 ' ov.dateclosed>=:d1 and ov.dateclosed<:d2 %s'+
                 ' group by 1,2 ';

     ost_nar=' union '+
             ' select %s, ''ost_nar'' field, count(*) col from %s ov'+
             ' where (ov.dateclosed>:d2 or '+
             ' ov.isclosed =0)   %s'+ //учитываем все оставшиесянаряды
             ' group by 1,2 ';


   {  ost_zhit=' union '+
              ' select ov.fk_orders_regions, ''ost_zhit'' field ,count(*)'+
              ' from orders_vds ov left join numsorders_vds nvs on ov.id=nvs.id_order '+
              ' where (ov.isclosed=0 or ov.dateclosed>:d2) and ov.datecoming<:d2  %s'+
              ' and nvs.id is null '+
              ' group by 1,2'; }

      ost_1562=' union '+
               ' select %s,''ost_1562'',val from SVODKA_OST1562 '+
               ' where Place=''%s'' and dt>:d3 and dt<:d4 %s '               ;

      col_dep=' union '+
              ' select %s , ''col_dep'', count(*) '+
              ' from %s d inner join %s ov on ov.id=d.fk_departures_orders '+
              ' where d.enddate>=:d1 and d.enddate<=:d2 %s'+
              '  group by 1 ,2 ';
      SQL_prin_nar_leak=' union '+
                        'select %s, ''prin_nar_leak'' field, count(*) col from %s ov '+
                        ' %s '+ //Cond_vds
                        ' where ov.datecoming>=:d1 and ov.datecoming<:d2  %s'+ //Conds_leak_ns
                        '%s group by 1,2';      //Cond_region

      SQL_ost_nar_leak=' union '+
                       ' select %s, ''ost_nar_leak'' field, count(*) col from %s ov '+
                       ' %s ' + //Cond_vds
                       ' where (ov.dateclosed>:d2 or '+
                       '     ov.isclosed =0)   %s'+ //Cond_region учитываем все наряды
                       ' %s   group by 1,2'; //Cond_ns
      SQL_vip_nar_leak=' union '+
                        'select %s, ''vip_nar_leak'' field, count(*) col from %s ov '+
                        ' %s '+ //Cond_vds
                        ' where ov.dateclosed>=:d1 and ov.dateclosed<:d2  %s'+ //Conds_leak_ns
                        '%s group by 1,2';      //Cond_region



       ost_nar_new_year=' union '+
             ' select %s, ''ost_nar'' field, count(*) col from %s ov'+
             ' where (ov.dateclosed>:d2 or '+
             ' ov.isclosed =0)    '+ //учитываем все оставшиесянаряды
             ' and ov.datecoming>:d1 %s '+
             ' group by 1,2 ';

       SQL_ost_nar_leak_new_year=' union '+
                       ' select %s, ''ost_nar_leak'' field, count(*) col from %s ov '+
                       ' %s ' + //Cond_vds
                       ' where (ov.dateclosed>:d2 or '+
                       '     ov.isclosed =0) '+
                       ' and  ov.datecoming>:d1 ' +
                       '  %s'+ //Cond_region учитываем все наряды

                       ' %s   group by 1,2'; //Cond_ns




function calsFieldnaem():string;
begin
 if fieldname = 'ov.fk_orders_regions' then
  result:='id_region'
 else
  result:='-2';
end;

function get_SQL_all():string;
var
 regs:string;
 t_order, t_dep,place:string;
 begin
  case F_Org of
   ns: begin
         t_order:='orders';
         t_dep:='departures';
         place:='НС';
       end;
  vds: begin
         t_order:='orders_vds';
         t_dep:='departures_vds';
         place:='ВДС';
       end;
  end;
   regs:=get_regions();
   Result:='';
//   Result:=Result+Format(SQL_prin,[regs]);
   Result:=Result+Format(SQL_prin_nar,[fieldname,t_order,regs]);
  // Result:=Result+Format(SQL_vip_tek_zhit,[regs]);
   Result:=Result+Format(SQL_vip_tek_nar,[fieldname,t_order,regs]);
  // Result:=Result+Format(vip_per_zhit,[regs]);
   Result:=Result+Format(vip_per_nar,[fieldname,t_order,regs]);
   if (fieldname = '-2') then
   begin
     Result:=Result+Format(ost_nar_new_year,[fieldname,t_order,regs]);
     Result:=REsult+Format(SQL_ost_nar_leak_new_year,[fieldname,t_order,Cond_leak_vds,regs,Cond_leak_ns]);

   end
   else
   begin
     Result:=Result+Format(ost_nar,[fieldname,t_order,regs]);
     Result:=REsult+Format(SQL_ost_nar_leak,[fieldname,t_order,Cond_leak_vds,regs,Cond_leak_ns]);

   end;
    Result:=Result+Format(ost_1562,[calsFieldnaem(),place,regs]);
 //  Result:=Result+Format(ost_nar,[fieldname,t_order,regs]);
  // Result:=Result+Format(ost_zhit,[regs]);

   Result:=Result+Format(col_dep,[fieldname,t_dep,t_order,regs]);
   Result:=REsult+Format(SQL_prin_nar_leak,[fieldname,t_order,Cond_leak_vds,regs,Cond_leak_ns]);
 //  Result:=REsult+Format(SQL_ost_nar_leak,[fieldname,t_order,Cond_leak_vds,regs,Cond_leak_ns]);
   Result:=REsult+Format(SQL_vip_nar_leak,[fieldname,t_order,Cond_leak_vds,regs,Cond_leak_ns]);

   Result:=Result+' order by 1,2';

 end;

var
  sql: string;
  Arr: array [0..1] of string;
  i, j, iKol: integer;
  field:string;
begin

  dset_tmp.SelectSQL.Text:=get_SQL_all();
  dset_tmp.ParamByName('d1').AsString:=DateTimeFormat('dd.mm.yyyy hh:mm:ss',F_DtBeg);
//  DateToStr(F_DT-1)+' 6:00:00';//DateToStr(F_DT-1)+' 6:00:00'//DateTimeFormat('dd.mm.yyyy hh:mm:ss',F_DtBeg);

  dset_tmp.ParamByName('d2').AsString:=DateTimeFormat('dd.mm.yyyy hh:mm:ss',F_Dt_End);
  //DateToStr(F_DT)+' 6:00:01';//;//DateToStr(F_DT)+' 6:00:01';
  dset_tmp.ParamByName('d3').AsString:=DateTimeFormat('dd.mm.yyyy',F_Dt_End);
  dset_tmp.ParamByName('d4').AsString:=DateTimeFormat('dd.mm.yyyy',F_Dt_End)+'  12:00:00';
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




function Tdm_RepSvodVed_vds_new.PrepareCountByReg_new(percent: integer): boolean;
var
  i: integer;
begin
  Result:=false;

  md_CountByReg_new.Close;
  md_CountByReg_new.Open;

  InitCountByReg_new;
  setMessage(GET_FIREBIRDDATA);
  AddCountForApplicant_new('ov.fk_orders_regions',F_DtBeg, F_dt_End);
  setMessage(GET_MSSQL_DATA);
  Add_from_1562(F_dtBeg, F_Dt_End);


//  AddOstalos_new;
  setMessage(GET_ALLDATA);
  CalMdRegion;
//  GetostZayav;
  CalcVsegoZaSmenu_new;


//  FromNewYear ;

calcFromNewYearFact;

  F_CurSnapDt := F_Dt;

  Result:=true;
end;

procedure Tdm_RepSvodVed_vds_new.InitCountByReg_new;
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
  md_CountByReg_new.FieldByName('region').AsString:='C 01.01.'+F_BEG_YEAR;
  md_CountByReg_new.Post;
end;

{если считаем итог id_input_reg =-2}
function Tdm_RepSvodVed_vds_new.FromadoDsetMD(field_query,field_md:string; id_input_reg:integer):boolean;
var val:integer;
    i, p:integer;
    id_reg:string;
    V:variant;
    lf_query,lf_md :tStringList  ;
    str:string;
    search:boolean;

begin
  Result:=false;

   lf_query:=tStringList.Create;
 lf_md:=TStringList.Create;

 while Pos(';', field_query)>0 do
 begin
   p:=Pos(';', field_query);
   str:=copy(field_query,1,p-1);
   lf_query.Add(str);
   delete(field_query,1,p);

   p:=Pos(';', field_md);
   str:=copy(field_md,1,p-1);
   lf_md.Add(str);
   delete(field_md,1,p);

 end;

  lf_query.Add(field_query);
  lf_md.Add(field_md);



  if  not ado_dset.IsEmpty then
  begin
   ado_dset.Last;
   ado_dset.Prior;

  search:=false;
   if id_input_reg <>0 then
   begin
    search:= md_CountByReg_new.Locate('id_reg',id_input_reg,[loCaseInsensitive]);
   end
   else
     md_CountByReg_new.First;

   while   (not ado_dset.eof)and
           (((md_CountByReg_new.FieldByName('id_reg').AsInteger>0)
           and
           ( not md_CountByReg_new.Eof))or

           (search) )do
   begin
    search:= false;
    id_reg:=md_CountByReg_new.FieldByName('id_reg').AsString;
    {если считаем всего}
    if id_input_reg = -2 then
     id_reg := 'all count';
    md_CountByReg_new.Edit;
    for i:= 0 to lf_query.Count-1 do
    begin

     V:=ado_dset.Lookup('region',id_reg,lf_query.Strings[i]);

     if V<>null then
      begin
       val:=V;
        md_CountByReg_new.FieldByName(lf_md.Strings[i]).AsInteger:= val;
      end ;

    end;
    md_CountByReg_new.Post;
    md_CountByReg_new.Next;

   end;
    ado_dset.Last;
    if (id_input_reg=0) then
    begin
    while  md_CountByReg_new.FieldByName('id_reg').AsInteger<>-1 do
     md_CountByReg_new.Next;
    md_CountByReg_new.Edit;
    md_CountByReg_new.FieldByName(field_md).AsInteger:=ado_dset.FieldByName(field_query).AsInteger;
    md_CountByReg_new.Post;
    end;
  end;
  Result:=true;
end;

procedure  Tdm_RepSvodVed_vds_new.fromquerytodm( procname:string; Pars:TStringList; field_query, field_md:string; field_query2, field_md2:string;id_input_regio:integer);
var i,p:integer;
    lf_query,lf_md:TStringList;
    str:string;
begin
str:='execute '+procname;

 {IF dt1<>'' then
     str:=str +' '''+dt1+'''';
 if dt2<>'' then
    str:=str+', '''+dt2+'''';}
 for i:=0 to Pars.Count-1 do begin
 if i>0 then
    str:= str+', ';
 str:=str +' '+ Pars[i]+' ' ;
end;


 try
  query.SQL.Clear;
  query.SQL.Add(str);
  query.Open;
   try
    ado_dset.Recordset:=query.Recordset;
    if  FromadoDsetMD(field_query,field_md,id_input_regio) then
     begin
     if field_md2<>'' then begin
     i:=0;
     ado_dset.Recordset:=query.NextRecordset(i);
     FromadoDsetMD(field_query2,field_md2,id_input_regio);
     end;
     end;


   finally
    query.close;
   end;
 except on e:exception do
 begin
   Application.MessageBox(PChar(e.Message+#13+' 1562 Сводная ведомость 2'), 'Ошибка', MB_OK  );
   exit;
 end;
 end

end;

procedure Tdm_RepSvodVed_vds_new.Add_from_1562(F_DtBeg,F_Dt_End:TDateTime; id_input_reg:integer);
var
 dt1,dt2:string;
 dset:_Recordset;
  id_reg:integer;
 val:integer;
 i:integer;
  Pars:TStringList;
  field_part,field_part_WC:string;
  PartFromNewYear:TStringList;
begin
try  { within_the_building-}
  dt1:=formatdatetime('mm.dd.yyyy hh:mm:ss', F_DtBeg);{F_DtBeg}{F_Dt-1+StrToTime(' 6:00:00')}
  dt2:=formatdatetime('mm.dd.yyyy hh:mm:ss', F_Dt_End); {F_Dt_End}  { F_Dt+StrToTime(' 6:00:00')}
  Pars:=TStringList.Create;
  Pars.Add(' '''+dt1+'''');
  Pars.Add(' '''+dt2+'''');
  case F_org of
    ns:  begin  field_part:='trunk_line'; field_part_WC:='trunk_line';  end;
   vds:   begin field_part:='within_the_building';  field_part_WC :='building'; end;
  end;


  fromquerytodm( 'spCountTendersOpenedClosedPeriod',Pars,
                 format(
                 '%s_1562;%s_telephone;failure_%s_1562',
                 [field_part,field_part,field_part]),
                 '1562_vip_tek_new;vip_tek_zhit;vip_tek_failure_1562',
                 format('%s_1562;failure_%s_1562',[field_part,field_part]),
                 '1562_vip_tek_rall;vip_tek_failure_rall_1562',
                 id_input_reg);


  fromquerytodm('spCountTendersClosedPeriodWithoutOpened',Pars,
                format('%s_1562;%s_telephone;failure_%s_1562',
                [field_part,field_part,field_part]),
                 'vip_per_1562;vip_per_zhit;vip_per_failure_1562',
                 format('%s_1562;failure_%s_1562',[field_part,field_part]),
                 '1562_vip_per_rall;vip_per_failure_rall_1562',
                 id_input_reg);
 if (_save) and (id_input_reg=0) then
  Pars.Add('1')
 else
  Pars.Add('0');
 fromquerytodm( 'spCountTendersOpenedPeriod',Pars,
                 format(
                 '%s_1562;%s_telephone;failure_%s_1562',
                 [field_part,field_part,field_part]),
                 'prin_1562_new;prin_zhit;prin_failure_1562',
                 format('%s_1562;failure_%s_1562;in_period_%s_1562',
                 [field_part,field_part,field_part]),
                 'prin_1562_rall;prin_failure_rall_1562;prin_1562_rall_new',
                 id_input_reg);

  Pars.Clear;

  dt1 :=  formatdatetime('01.01.yyyy 00:00:00', F_Dtbeg);
  dt2 :=  formatdatetime('mm.dd.yyyy hh:mm:ss', Now());
  Pars.Add(' '''+dt1+'''');
  Pars.Add(' '''+dt2+'''');
  if (id_input_reg <>-2) then
     fromquerytodm('spNumberOfUnfinishedLeaks',Pars,
                 format('%s_unclosed_phone;%s_unclosed_for_all_time_1562',[field_part_WC,field_part_WC]),
                 'ost_zhit;ost_1562','','',id_input_reg)
  else
     fromquerytodm('spNumberOfUnfinishedLeaks',Pars,
                 format('%s_unclosed_over_a_given_time_phone;%s_unclosed_over_a_given_time_1562',[field_part_WC,field_part_WC]),
                 'ost_zhit;ost_1562','','',id_input_reg);
  except on e:exception  do
  exit;
  end;


end;


procedure Tdm_RepSvodVed_vds_new.CalcVsegoZaSmenu_new;
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
  for i:=1 to 38  do
  if  md_CountByReg_new.Fields[i].FieldName='percent_n' then
  begin
   md_CountByReg_new.Last;
   md_CountByReg_new.Prior;
   md_CountByReg_new.Edit;
   if  md_CountByReg_new.FieldByName('prin_nar').AsInteger<> 0 then
    md_CountByReg_new.FieldByName('percent_n').AsFloat:=100*
   ( md_CountByReg_new.FieldByName('vip_tek_nar').AsInteger+md_CountByReg_new.FieldByName('vip_per_nar').AsInteger)/
   md_CountByReg_new.FieldByName('prin_nar').AsInteger
   else   md_CountByReg_new.FieldByName('percent_n').AsFloat:=0;
   md_CountByReg_new.Post;
  end
  else
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

procedure Tdm_RepSvodVed_vds_new.CalMdRegion();
begin
   md_CountByReg_new.First;
   while md_CountByReg_new.FieldByName('id_reg').AsInteger>0 do
   begin
     CalcRowmdRegion();
     md_CountByReg_new.Next;
   end;
end;

procedure Tdm_RepSvodVed_vds_new.CalcRowmdRegion();
function getv(field:string):integer;
begin
  Result:= md_CountByReg_new.FieldByName(field).AsInteger;
end;
begin
  with  md_CountByReg_new do
  begin
   Edit;

    fieldbyname('prin_1562_new').AsInteger:=getv('prin_1562_new')+getv('prin_failure_1562');

    fieldbyname('prin_1562_rall_old').AsInteger:=getv('prin_1562_rall')+getv('prin_failure_rall_1562')-
                                                 getv('prin_1562_rall_new');


    fieldbyname('prin_1562_all').AsInteger:=getv('prin_1562_new')+getv('prin_1562_rall_old')+getv('prin_1562_rall_new');{суммируем че в 1 колонку возвраты не показываем}

    fieldbyname('prin_all').AsInteger:=fieldbyname('prin_1562_new').AsInteger+
               fieldbyname('prin_1562_rall_old').AsInteger+getv('prin_1562_rall_new')+
                                       getv('prin_zhit');
    fieldbyname('1562_vip_tek_new').AsInteger:=getv('1562_vip_tek_new')+getv('vip_tek_failure_1562');
    fieldbyname('1562_vip_tek_rall').AsInteger:=getv('1562_vip_tek_rall')+getv('vip_tek_failure_rall_1562');


    fieldbyname('vip_per_1562').AsInteger:=getv('vip_per_1562')+getv('vip_per_failure_1562');
    fieldbyname('1562_vip_per_rall').AsInteger:=getv('1562_vip_per_rall')+getv('vip_per_failure_rall_1562');

    fieldbyname('1562_vipall_rall').AsInteger:=getv('1562_vip_tek_rall')+
                                               getv('1562_vip_per_rall');

    fieldbyname('vip_per_rall_1562').AsInteger:=getv('1562_vipall_rall')+getv('vip_per_1562');

    fieldbyname('vip_nar_all').AsInteger:=getv('vip_per_nar')+getv('vip_tek_nar');
    if  getv('prin_nar')>0 then
     fieldbyname('percent_n').AsFloat:=100*(getv('vip_tek_nar')+getv('vip_per_nar'))/getv('prin_nar')
    else
     fieldbyname('percent_n').AsFloat:=0;
    fieldbyname('prin_all_1562').AsInteger:=getv('prin_1562_new')+getv('prin_1562_rall_new')+getv('prin_1562_rall_old');
    fieldbyname('vip_zhit_all').AsInteger:=getv('vip_tek_zhit')+getv('vip_per_zhit');
    fieldbyname('vip_all_1562').AsInteger:=getv('1562_vipall_rall')+getv('1562_vip_tek_new')+getv('vip_per_1562');
    fieldbyname('vip_tek_all').AsInteger:=getv('1562_vip_tek_new')+getv('vip_tek_zhit');
    fieldbyname('vip_per_all').AsInteger:=getv('1562_vipall_rall')+getv('vip_per_1562')
                                          +getv('vip_per_zhit');

    fieldbyname('ost_zayv').AsInteger:=getv('ost_1562')+getv('ost_zhit');




   Post;
  end;

end;
{запомним только те поля которые показываем пользователю}
procedure Tdm_RepSvodVed_vds_new.InitSnapShotMgr_new;
const
  ARR_FIELD: array [0..25] of string=( 'id_reg',
'Region',
'prin_1562_all',
'prin_zhit',
'prin_all',
'prin_nar',
'prin_nar_leak',
'1562_vip_tek_new',
'vip_per_rall_1562',
'vip_tek_zhit',
'vip_per_zhit',
'vip_tek_all',
'vip_per_all',
'vip_tek_nar',
'vip_per_nar',
'vip_nar_all',
'vip_nar_leak',
'col_dep',
'percent_n',
'ost_1562',
'ost_zhit',
'ost_zayv',
'ost_nar',
'ost_nar_leak',
'ods_prin',
'ods_vip'
);


var
  sn_dset: TSnShotDset;
  i: integer;
  sv_name:string;
begin    {поменять  SnapShotType 'SVODVEDVDS_2' - }
   { case f_org of
     ns:sv_name:='SVODVEDNS_2';
     vds:sv_name:='SVODVEDVDS_2';
    end;
    F_SnapShotMgr.SnapShotType:=sv_name;}

    F_SnapShotMgr.SnapShotType:='SVODVEDVDS_2';
    sn_dset:=F_SnapShotMgr.AddSNShotDset(md_CountByReg_new);
    for i:=low(ARR_FIELD) to high(ARR_FIELD) do
      sn_dset.FieldNameList.Add(ARR_FIELD[i]);
end;


procedure Tdm_RepSvodVed_vds_new.LoadSnapShot(dt: TDate);
begin
  F_SnapShotMgr.SnapShotDate:=dt;
  F_SnapShotMgr.LoadSnapShot;
  F_CurSnapDt := dt;
  F_SnapUser:= F_SnapShotMgr.CurUser;
  InitIDByReg;
  AfterLoad();
  {$IFDEF FROMSNAPSHOT}
  GetLastOst(dt);
  GetLastPrin(dt);
  //CalcVsegoZaSmenu;
  {$ENDIF}
end;

function Tdm_RepSvodVed_vds_new.DoSnapShot:boolean;
begin
  //F_SnapShotMgr.SnapShotDate:=F_Dt;
  Result:=false;
  try
  F_SnapShotMgr.SnapShotDate:=F_CurSnapDt;
  F_SnapShotMgr.DoSnapShot;
  F_SnapUser := DM_RightsManager.CurrentUserName;
  if tran.Active then tran.Commit;
  except on e:exception do
  exit;
  end;
  Result:=true;
//SaveXML;
end;

procedure Tdm_RepSvodVed_vds_new.InitCountByReg;
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
  md_CountByReg_new.FieldByName('region').AsString:='С 01.01.'+F_BEG_YEAR;
  md_CountByReg_new.Post;
end;

function Tdm_RepSvodVed_vds_new.PrepareDisconSumInfo(percent: integer): boolean;

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

function Tdm_RepSvodVed_vds_new.GetDisconCount(id_discon: integer): integer;
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

function Tdm_RepSvodVed_vds_new.GetOfficialName(id: integer): string;
begin
  MyOpenIBDS(dset_tmp, 'select name from s_officials where id='+IntToStr(id));
  Result:=trim(dset_tmp.FieldByName('name').AsString);
  dset_tmp.Close;
end;


function Tdm_RepSvodVed_vds_new.PrepareDiscon(percent: integer): boolean;
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


    md_Discon.FieldByName('discontype').AsString:=str;      {не нужен для наружки}



    if _dc < 0 then _dc := 0;
//    md_Discon.FieldByName('DaysCount').AsInteger:=trunc(F_Dt)-trunc(dset_tmp.FieldByName('dttm_discon').AsDateTime);
    md_Discon.FieldByName('DaysCount').AsInteger:= _dc;

    md_Discon.Post;

    dset_tmp.Next;
  end;

  dset_tmp.Close;

  Result:=true;
end;

procedure Tdm_RepSvodVed_vds_new.InitIDByReg;
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
  md_CountByReg_new.First;
  while not dset_tmp.Eof do
  begin
    md_CountByReg_new.Edit;
    md_CountByReg_new.FieldByName('id_reg').AsInteger:=dset_tmp.FieldByName('id').AsInteger;
    md_CountByReg_new.Post;
    md_CountByReg_new.Next;
    dset_tmp.Next;
  end;

  md_CountByReg_new.Edit;
  md_CountByReg_new.FieldByName('id_reg').AsInteger:=-1;
  md_CountByReg_new.Post;
 // tmp_sump := md_CountByReg_new.FieldByName('sum_prin').AsInteger;
  md_CountByReg_new.Next;


  md_CountByReg_new.Edit;
  md_CountByReg_new.FieldByName('id_reg').AsInteger:=-2;
  md_CountByReg_new.Post;
 // F_tmpSumPrinSnap:= md_CountByReg.FieldByName('sum_prin').AsInteger - tmp_sump;
 // F_tmpSumPrinSnap
end;

procedure Tdm_RepSvodVed_vds_new.LoadSnapshotDatesList(var list: TStringList);
begin
  F_SnapShotMgr.LoadSnapshotDatesList(list);
end;


procedure Tdm_RepSvodVed_vds_new.GetostZayav;
const
   SQL = ' select  sv.row_number,sf.field_name ,sv.field_value  from snshot_snapshots_vds ss'+
         ' inner join snshot_dsets_vds sd on ss.id=sd.id_snapshot'+
         ' inner join snshot_fields_vds sf on sd.id=sf.id_dset '+
         '  inner join snshot_values_vds sv on sf.id=sv.id_field '+
         ' where sf.field_name in '+
         ' (''ost_1562'') '+
         '  and ss.id_type=2 and ss.dt= '+
         '   (select max(ss1.dt) from snshot_snapshots_vds ss1 '+
         '    where ss1.id_type=2 and ss1.dt<''%s'' )'+
         '    order by 1' ;
MSQL = ' select id_rayon, count(*) '+
       ' from DateTime_KhNew_Select_vw '+
       ' where  DateOurRequest>=''%s'' '+
       '  and state<=1'+
       ' group  by id_rayon';
var dt:string;
    i: integer;
function gv(field:string):integer;
begin
Result:=  md_CountByReg_new.FieldByName(field).AsInteger;
end;
function gvt(field:string):integer;
begin
 if   dset_tmp.fieldbyname(field).IsNull then
  Result:=0
 else
   Result:= dset_tmp.fieldbyname(field).AsInteger;

end;

begin

md_CountByReg_new.First;
while not md_CountByReg_new.Eof do
begin
 md_CountByReg_new.Edit;
 md_CountByReg_new.FieldByName('ost_1562').AsInteger:=gv('prin_all_1562')-gv('vip_all_1562');
 //md_CountByReg_new.FieldByName('ost_zhit').AsInteger:=gv('prin_zhit')-gv('vip_zhit_all');
 md_CountByReg_new.Post;
 md_CountByReg_new.Next;

end;

dt:=FormatDateTime('dd.mm.yyyy', F_dt);
MyOpenIBDS(dset_tmp,Format(SQL,[dt]));
dset_tmp.First;
if not dset_tmp.IsEmpty then
begin
 md_CountByReg_new.First;
 while not dset_tmp.Eof do
 begin
  md_CountByReg_new.Edit;


  while (md_CountByReg_new.RecNo=dset_tmp.FieldByName('row_number').AsInteger)
        and (not dset_tmp.Eof) do
   begin
     md_CountByReg_new.fieldbyname(dset_tmp.fieldbyname('field_name').AsString).AsInteger:=
          gv(dset_tmp.fieldbyname('field_name').AsString)+
         gvt('field_value');
    dset_tmp.next;
  end ;
  md_CountByReg_new.Post;
  md_CountByReg_new.Next;
 end;
end;

 md_CountByReg_new.First;
 while md_CountByReg_new.FieldByName('id_reg').AsInteger>0 do
 begin
   md_CountByReg_new.Edit;
   md_CountByReg_new.FieldByName('ost_zayv').AsInteger:=gv('ost_1562')+gv('ost_zhit');
   md_CountByReg_new.Post;
  md_CountByReg_new.Next;
 end;



 { MyOpenIBDS(dset_tmp,Format(SQL,[DateToStr(F_Dt)]));
  dset_tmp.First;
  md_CountByReg_new.First;
  while not md_CountByReg_new.Eof do begin
     md_CountByReg_new.Edit;
     md_CountByReg_new.FieldByName('ost_zayv').AsInteger:=gv('prin_zhit')+gv('prin_1562_new')-
                                                         gv('vip_tek_1562')-gv('vip_tek_zhit');
                                                         //-gv('vip_per_1562')-gv('vip_per_zhit');
    md_CountByReg_new.Post;
    md_CountByReg_new.Next;

  end;
 md_CountByReg_new.First;
  while not  dset_tmp.Eof do
  begin
   if md_CountByReg_new.RecNo=dset_tmp.FieldByName('row_number').AsInteger then
    begin
     md_CountByReg_new.Edit;
     md_CountByReg_new.FieldByName('ost_zayv').AsInteger:=dset_tmp.fieldbyname('field_value').AsInteger+
                                                          gv('ost_zayv');
     md_CountByReg_new.Post;
     md_CountByReg_new.Next;
     dset_tmp.Next;
    end
    else
     if  md_CountByReg_new.RecNo<dset_tmp.FieldByName('row_number').AsInteger then
         md_CountByReg_new.Next
     else
        dset_tmp.Next;

  end;   }
  query.Close;


end;

procedure Tdm_RepSvodVed_vds_new.FromNewYear();
const

 SQL='select ss.dt, sf.field_name, sv.field_value  from snshot_snapshots_vds ss '+
           ' inner join snshot_dsets_vds sd on ss.id=sd.id_snapshot'+
           ' inner join snshot_fields_vds sf on sd.id=sf.id_dset'+
           ' inner join snshot_values_vds sv on sf.id=sv.id_field'+
           ' where sv.row_number=11 and ss.id_type=%d and ss.dt='+
           ' (select max(ss1.dt) from snshot_snapshots_vds ss1   where  ss1.id_type=%d and  ss1.dt<''%s'')';

  ARR_FIELD: array [0..25] of string=( 'id_reg',
'Region',
'prin_1562_all',
'prin_zhit',
'prin_all',
'prin_nar',
'prin_nar_leak',
'1562_vip_tek_new',
'vip_per_rall_1562',
'vip_tek_zhit',
'vip_per_zhit',
'vip_tek_all',
'vip_per_all',
'vip_tek_nar',
'vip_per_nar',
'vip_nar_all',
'vip_nar_leak',
'col_dep',
'percent_n',
'ost_1562',
'ost_zhit',
'ost_zayv',
'ost_nar',
'ost_nar_leak',
'ods_prin',
'ods_vip'
);

function gv(field:string):integer;
begin
Result:= md_CountByReg_new.FieldByName(field).AsInteger;
end;

var val:integer;
     i:integer;
     typ_org:integer;
     text_SQL:string;
begin
typ_org:=2;
case f_Org of
 ns:typ_org:=3; //typ NS
 vds:typ_org:=2;// typ VDS
end;

MyOpenIBDS(dset_tmp,Format(SQL,[typ_org,typ_org,DateToStr(Dt)]));
dset_tmp.First;

for i:=low(ARR_FIELD) to high(ARR_FIELD) do
begin
  md_CountByReg_new.Locate('id_reg',-1,[]) ;
  val:=md_CountByReg_new.fieldbyname(ARR_FIELD[i]).AsInteger;
  md_CountByReg_new.Next;
  md_CountByReg_new.Edit;
  md_CountByReg_new.FieldByName(ARR_FIELD[i]).AsInteger:=val;
  md_CountByReg_new.Post;
end;
  md_CountByReg_new.Locate('id_reg',-2,[]) ;
if  not dset_tmp.Eof then
 for i:=low(ARR_FIELD) to high(ARR_FIELD) do
begin

   md_CountByReg_new.Edit;
 if   dset_tmp.Locate('field_name',Arr_Field[i],[]) then
 if (dset_tmp.fieldbyname('field_name').asstring <> 'ost_zayv') and
    (dset_tmp.fieldbyname('field_name').asstring <> 'ost_nar') and
    (dset_tmp.fieldbyname('field_name').asstring <> 'ost_zhit') and
    (dset_tmp.fieldbyname('field_name').asstring <> 'ost_1562') and

     not (HappyNewYear)
    then begin
    val:=dset_tmp.Lookup('field_name',ARR_FIELD[i],'field_value');
     md_CountByReg_new.FieldByName(dset_tmp.fieldbyname('field_name').asstring).AsInteger:=
     md_CountByReg_new.FieldByName(dset_tmp.fieldbyname('field_name').asstring).AsInteger+val;
    end;
 md_CountByReg_new.FieldByName('ods_prin').AsString:='';
 md_CountByReg_new.FieldByName('ods_vip').AsString:='';



     //     dset_tmp.fieldbyname('field_value').AsInteger;
 md_CountByReg_new.Post;

end;
 md_CountByReg_new.Edit;
  with md_CountByReg_new do
  begin
{    Fieldbyname('ost_1562').AsInteger:={gv('prin_1562_new')+gv('prin_1562_rall_new')+
                                       gv('prin_1562_rall_old')-
                                       (gv('1562_vip_tek_new')+gv('vip_per_1562')+gv('1562_vipall_rall'));
    Fieldbyname('ost_zhit').AsInteger:=gv('prin_zhit')-gv('vip_tek_zhit')-gv('vip_per_zhit');
    Fieldbyname('ost_zayv').AsInteger:=gv('ost_zhit')+gv('ost_1562');
}  end;

 if   md_CountByReg_new.FieldByName('prin_nar').AsInteger>0 then
 md_CountByReg_new.FieldByName('percent_n').AsFloat:=100*
     (md_CountByReg_new.FieldByName('vip_tek_nar').AsInteger+md_CountByReg_new.FieldByName('vip_per_nar').AsInteger)/
    md_CountByReg_new.FieldByName('prin_nar').AsInteger
  else
  md_CountByReg_new.FieldByName('percent_n').AsFloat:=0;
 md_CountByReg_new.FieldByName('prin_1562_all').AsInteger:=md_CountByReg_new.FieldByName('prin_1562_new').AsInteger+
                                                           md_CountByReg_new.FieldByName('vip_per_nar').AsInteger+
                                                           md_CountByReg_new.FieldByName('prin_1562_rall_new').AsInteger;

  md_CountByReg_new.FieldByName('vip_per_rall_1562').AsInteger:=md_CountByReg_new.fieldbyname('1562_vipall_rall').AsInteger+
                                                              md_CountByReg_new.fieldbyname('vip_per_1562').AsInteger;



 md_CountByReg_new.Post;
end;

procedure Tdm_RepSvodVed_vds_new.Recalc();
begin


//  md_CountByReg_new.Close;
//  md_CountByReg_new.Open;

//  InitCountByReg_new;
ClearFields;
  setMessage(GET_FIREBIRDDATA);
  AddCountForApplicant_new('ov.fk_orders_regions',F_dtBeg, F_dt_End);
  setMessage(GET_MSSQL_DATA);
  Add_from_1562(F_dtBeg, F_dt_End);


//  AddOstalos_new;


  CalMdRegion;
//  GetostZayav;
  setMessage(GET_ALLDATA);
  CalcVsegoZaSmenu_new;

  calcFromNewYearFact;
  //FromNewYear ;

//CalcVsegoZaSmenu_new;
//FromNewYear();

end;

procedure Tdm_RepSvodVed_vds_new.GetCountsForXML;
var bmark: string;
begin
    //
    bmark:=md_CountByReg_new.Bookmark;
    md_CountByReg_new.Last;
    md_CountByReg_new.Prior;
    F_OrderComingCount := md_CountByReg_new.FieldByName('prin_nar').AsInteger;
    F_ClosedOrdersCount := md_CountByReg_new.FieldByName('vip_tek_nar').AsInteger+md_CountByReg_new.FieldByName('vip_per_nar').AsInteger;
    F_NotClosedOrdersCount := md_CountByReg_new.FieldByName('ost_nar').AsInteger;
    md_CountByReg_new.Bookmark:=bmark;


end;

procedure Tdm_RepSvodVed_vds_new.SaveXML;
var Xml: IXMLDocument;
    _filename: string;
    _new, _newval: boolean;
    i: integer;
    _sdate, _list, _NodeName, _Atr: string;
    _inode: integer;



begin
    //

   _filename := AppSettings.Get_PathForXML + '\vds_to_stdisp.xml';  {изменить название}
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


procedure Tdm_RepSvodVed_vds_new.ClearFields;
var i,j:integer;
begin
 md_CountByReg_new.First;
 while not md_CountByReg_new.Eof do begin
  md_CountByReg_new.Edit;
  for i:=1 to md_CountByReg_new.FieldCount-2 do
   if  ( md_CountByReg_new.Fields[i].FieldName<>'Region')
   and (md_CountByReg_new.Fields[i].FieldName<>'ods_vip')
   and (md_CountByReg_new.Fields[i].FieldName<>'ods_prin') then
      md_CountByReg_new.FieldByName( md_CountByReg_new.Fields[i].FieldName).AsInteger:=0;
   md_CountByReg_new.Post;
    md_CountByReg_new.Next;
 end;
{ for i:=0 to md_CountByReg_new.FieldCount-1 do
  for j:=0 to md_CountByReg_new.}
end;

procedure Tdm_RepSvodVed_vds_new.AfterLoad();//заполнаяем не сохранямые поля   все поля для пользователя сохранены и ненадо перещитывать
begin
 {md_CountByReg_new.First;
 while  not md_CountByReg_new.Eof do
 begin
  md_CountByReg_new.Edit;

  md_CountByReg_new.FieldByName('prin_1562_all').AsInteger:=
  md_CountByReg_new.FieldByName('prin_1562_new').AsInteger+
  md_CountByReg_new.FieldByName('prin_1562_rall_old').AsInteger+
  md_CountByReg_new.FieldByName('prin_1562_rall_new').AsInteger ;



 md_CountByReg_new.fieldbyname('vip_per_rall_1562').AsInteger:=
  md_CountByReg_new.FieldByName('1562_vipall_rall').AsInteger+
  md_CountByReg_new.FieldByName('vip_per_1562').AsInteger;
  md_CountByReg_new.Post;
   md_CountByReg_new.Next;
  end; 
   }
end;

procedure Tdm_RepSvodVed_vds_new.calcFromNewYearFact();
var dt_beg,dt_end:TDateTime;
begin
  dt_beg := StrToDateTime('01.01.'+IntToStr(YearOf(F_Dt)));
  dt_end := F_dt+1+0.25; //дата смены след день 6:00
  setMessage(GET_DATA_YEAR+GET_FIREBIRDDATA);
  AddCountForApplicant_new('-2',dt_beg, dt_end);
  setMessage(GET_DATA_YEAR+GET_MSSQL_DATA);
   Add_from_1562(dt_beg, dt_end,-2);
  setMessage(GET_DATA_YEAR+GET_ALLDATA);
  md_CountByReg_new.Locate('id_reg',-2,[loCaseInsensitive]);
  CalcRowmdRegion();
//  setItogYearFromMSSQL();
  CopyToNewYear();



end;

procedure Tdm_RepSvodVed_vds_new.CopyToNewYear();
var i:integer;
begin
  md_HappyNewYear.Close;
  md_HappyNewYear.Open;
  md_HappyNewYear.Append;

 for i:=0 to md_CountByReg_new.FieldCount-1 do
   md_HappyNewYear.Fields[i].Value:=md_CountByReg_new.Fields[i].Value;
  md_HappyNewYear.Post;

end;


{для сообщени пользователю}
procedure Tdm_RepSvodVed_vds_new.setMessage(mes:String);
begin
 if Assigned(F_SetMessage) then
   F_SetMessage(mes);
end;


procedure Tdm_RepSvodVed_vds_new.setItogYearFromMSSQL();
  const SQL_MSMSQL = 'SELECT [opened],[state], COUNT(id) as ''count'' '+
                    ' FROM [avr_vs_request].[dbo].[DateTime_KhNew_Select_vw] '+
                    ' where [DateOurRequest] between ''%s'' and  ''%s'' '+
                    ' group by [opened], [state] order by [opened]';
         OPEND_1562 ='1562';
         OPEND_ZHIT ='По телефону';
         OPEN_OCH ='Очиствод';

  var SQL:string;
      fieldname:string;
      dt_beg,dt_end:TDateTime;
begin
 dt_beg := StrToDateTime('01.01.'+IntToStr(YearOf(F_Dt)));
 dt_end := F_dt_end+0.5;
 SQL := Format(SQL_MSMSQL,[FormatDateTime('mm.dd.yyyy',dt_beg),FormatDateTime('mm.dd.yyyy',dt_end)]);
 try
  query.Close;
  query.SQL.Text:=SQL;
  query.Open;
  query.First;
  md_CountByReg_new.Locate('id_reg',-2,[loCaseInsensitive]);

  md_CountByReg_new.Edit;
  while  not query.Eof do
  begin
   fieldname:='';
   if  query.FieldByName('opened').AsString =OPEND_1562 then
     begin
      md_CountByReg_new.FieldByName('prin_1562_all').AsInteger:=md_CountByReg_new.FieldByName('prin_1562_all').AsInteger+
      query.fieldbyname('count').AsInteger;
      if query.FieldByName('state').AsInteger = 3 then
       md_CountByReg_new.FieldByName('vip_all_1562').AsInteger:=md_CountByReg_new.FieldByName('vip_all_1562').AsInteger+
      query.fieldbyname('count').AsInteger;
     end  ;
    if query.FieldByName('opened').AsString =OPEND_ZHIT then
    begin
     md_CountByReg_new.FieldByName('prin_zhit').AsInteger:=md_CountByReg_new.FieldByName('prin_zhit').AsInteger+
     query.fieldbyname('count').AsInteger;
     if query.FieldByName('state').AsInteger = 3 then
       md_CountByReg_new.FieldByName('vip_zhit_all').AsInteger:=md_CountByReg_new.FieldByName('vip_zhit_all').AsInteger+
     query.fieldbyname('count').AsInteger;
    end;
    query.Next;
  end;
  md_CountByReg_new.FieldByName('vip_tek_all').AsInteger:= md_CountByReg_new.FieldByName('vip_zhit_all').AsInteger+
  md_CountByReg_new.FieldByName('vip_all_1562').AsInteger;
  md_CountByReg_new.Post;
 except on e:exception do
   exit;
 end;

end;



end.
