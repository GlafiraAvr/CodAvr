unit DModuleRSvodved;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, IBCustomDataSet, FR_DSet, FR_DBSet, DB,
  RxMemDS, FR_Class,DModule, IBDatabase;

type
  Tdm_RSvodved = class(Tdm_NGReportBase)
    md_res: TRxMemoryData;
    frDBD_dm_res: TfrDBDataSet;
    dset: TIBDataSet;
    md_resid_reg: TIntegerField;
    md_resRegion: TStringField;
    md_resabonenet: TStringField;
    md_rescol_1562: TIntegerField;
    md_rescol_zhit: TIntegerField;
    md_resadress: TStringField;
    md_resAPPLICANTPHONE: TStringField;
    md_resMessage: TStringField;
    md_resadditionalinfo: TStringField;
    md_resbrig: TStringField;
    md_resexcutwork: TStringField;
    tran: TIBTransaction;
    md_resordernumber: TStringField;
    md_res_ns: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField11: TStringField;
    frDBD_md_res_ns: TfrDBDataSet;
    md_resDateComing: TDateTimeField;
    md_resDATECLOSED: TDateTimeField;
    md_res_nsDateComing: TDateTimeField;
    md_res_nsDATECLOSED: TDateTimeField;
  private
    { Private declarations }

    function set_closed():string;
    function set_datetime():string;
    function get_organisation():string;
    function get_damage_place():string;
    function get_message_type():string;

  public
    { Public declarations }
    BegDate:TDateTime;
    EndDate:TDateTime;
    Regions_id:string;
    typ:integer;
    Orgs_id:string;
    ns_vds:integer;
    DamPlace_ID:string;
    function PrepareDsets_vds():boolean;
    function PrepareDsets_ns():boolean;

  end;

const
 SQL_vds=' select distinct  ov.fk_orders_regions id_reg,   '+
      ' (select FULLORDERNUM from get_fullordernum(ov.ordernumber, ov.fk_orders_district)) ordernumber,'+
      ' ov.applicantfio,'+
      ' ov.datecoming,'+
      ' ov.dateclosed,'+
      ' ov.additionalinfo,'+
      ' (select name from s_regions sr where sr.id=ov.fk_orders_regions) region,'+
      ' (select ADRES from get_adres_vds(ov.fk_orders_streets,ov.housenum,ov.housingnum,ov.porchnum,'+
      '                            ov.floornum, ov.apartmentnum,ov.porchkod)) adress,'+
      ' ov.applicantphone,'+
      ' (select MESSAGENAME from s_messagetypes_vds  sm where sm.id=ov.fk_orders_messagetypes) message,'+
      ' (select name from brigadiers b where  b.id=(select id_brig from GET_MASTER_VDS(ov.id)) ) brig ,'+
     ' (select count(*) from numsorders_vds ns where ns.id_order=ov.id and ns.number<>0 and ns.id_1562 is not null and state_inner=1 and trim(recived_from)=''1562'') col_1562, '+
     ' (select count(*) from numsorders_vds ns where ns.id_order=ov.id and trim(ns.recived_from)in (''По телефону'',''Очиствод'') and ns.id_1562 is not null and state_inner=1 ) col_zhit, '+
      '  (select WORKS from get_works_why_not_vds(ov.id)) excut_work'+
      '  from orders_vds ov  '+
      '  where   ' +
      '  fk_orders_regions in %s'+
      ' order by 1';
SQL_ns='select distinct  o.fk_orders_regions id_reg,    '+
       ' o.ordernumber, '+
       '  o.abonent applicantphone,'+
       '  '''' applicantfio, '+
       '  o.datecoming, '+
       '  o.dateclosed, '+
       '  (select WORKS from get_works_why_not(1,o.id,0)) additionalinfo, '+
       '         (select name from s_regions sr where sr.id=o.fk_orders_regions) region, '+
       '         (select ADRES from  get_adres(o.FK_ORDERS_HOUSETYPES,o.fk_orders_streets,o.housenum,o.additionaladdress) ) '+
       '  adress, '+
       ' (select MESSAGENAME from s_messagetypes  sm where sm.id=o.fk_orders_messagetypes) message, '+
       ' (select name from brigadiers b where  b.id=(select id_brig from GET_MASTER(o.id))  ) brig ,'+
       ' (select count(*) from numsorders ns where ns.id_order=o.id and ns.number<>0 and ns.id_1562 is not null and state_inner=1 and trim(recived_from)=''1562'') col_1562, '+
       ' (select count(*) from numsorders ns where ns.id_order=o.id and trim(ns.recived_from)in (''По телефону'',''Очиствод'') and ns.id_1562 is not null and state_inner=1 ) col_zhit, '+
       ' (select WORKS from get_works_why_not(3,o.id,1)) excut_work '+
       '  from orders o '+
       '  where  '+
       '   fk_orders_regions in %s'+
       '  order by   1';

var
  dm_RSvodved: Tdm_RSvodved;

implementation
uses HelpFunctions;

{$R *.dfm}
function Tdm_RSvodved.set_closed():string;
begin
 case typ of
  1:Result:=' and isclosed=0';
  2:Result:=' and isclosed=1';
  3:Result:='';
 end;
end;

function Tdm_RSvodved.set_datetime():string;
begin
 REsult:=' and datecoming>='''+FormatDateTime('dd.mm.yyyy hh:mm:ss',BegDate)+''''+
         ' and datecoming<=''' +FormatDateTime('dd.mm.yyyy hh:mm:ss',EndDate)+'''';
end;

function Tdm_RSvodved.get_organisation():string;
begin
 if  Orgs_id<>'' then
 Result:=' and FK_ORDERS_ORGANISATIONS in '+ Orgs_id
 else
  Result:='';
end;

function Tdm_RSvodved.PrepareDsets_vds():boolean;
var SQL:string;
i:integer;
begin
Result:=false;

 SQL:=format(SQL_vds, [Regions_id+set_datetime()+set_closed()+get_organisation()+get_message_type()]);
MyOpenIBDS(dset,SQL);
 md_res.Close;
 md_res.Open;
 dset.First;
 while  not dset.Eof do begin
  md_res.Append;

  for i:=0 to dset.FieldCount-1 do
    if (VarType(dset.Fields[i].AsVariant)=varDate)
      or (dset.Fields[i].FieldName ='DATECLOSED') then
    md_res.FieldByName(dset.Fields[i].FieldName).AsDateTime:=dset.Fields[i].asdatetime//formatDatetime('dd.mm.yyyy hh:mm',dset.Fields[i].asdatetime)
    else
   md_res.FieldByName(dset.Fields[i].FieldName).AsString:=dset.Fields[i].AsString;
  md_res.Post;
  dset.Next;
 end;

Result:=true;

end;

function Tdm_RSvodved.PrepareDsets_ns():boolean;
var SQL:string;
i:integer;
begin
Result:=false;

 SQL:=format(SQL_ns, [Regions_id+set_datetime()+set_closed()+get_organisation()+get_damage_place()]);
MyOpenIBDS(dset,SQL);
 md_res_ns.Close;
 md_res_ns.Open;
 dset.First;
 while  not dset.Eof do begin

    md_res_ns.Append;
  for i:=0 to dset.FieldCount-1 do
   if (VarType(dset.Fields[i].AsVariant)=varDate)  then
    md_res_ns.FieldByName(dset.Fields[i].FieldName).AsDateTime:=dset.Fields[i].asdatetime//formatDatetime('dd.mm.yyyy hh:mm',dset.Fields[i].asdatetime)
    else
   md_res_ns.FieldByName(dset.Fields[i].FieldName).AsString:=dset.Fields[i].AsString;
  md_res_ns.Post;
  dset.Next;
 end;

Result:=true;

end;

function Tdm_RSvodved.get_damage_place():string;
begin
 if  DamPlace_ID<>'' then
  result := ' and o.FK_ORDERS_DAMAGEPLACE in '+DamPlace_ID
 else
  result :='';
end;

function Tdm_RSvodved.get_message_type():string;
begin
  if  DamPlace_ID<>'' then
  result := ' and ov.fk_orders_messagetypes  in '+DamPlace_ID
 else
  result :='';

end;

end.
