unit SPlanWorkDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, IBDatabase, DB,
  IBCustomDataSet, RxMemDS, FR_DSet, FR_DBSet,WaitProcessForm;

type
  Tdm_SPlanWork = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    dset_main: TIBDataSet;
    tran: TIBTransaction;
    dset_workers: TIBDataSet;
    dset_equipment: TIBDataSet;
    dset_planworks: TIBDataSet;
    md_table: TRxMemoryData;
    md_tableordernumber: TIntegerField;
    md_tableBrig: TStringField;
    md_tableWorkkers: TStringField;
    md_tablestart: TDateTimeField;
    md_tableend: TDateTimeField;
    md_tableequipments: TStringField;
    md_tableadress: TStringField;
    md_tableLocality: TStringField;
    md_tablePlanWorks: TStringField;
    frDBDataSet: TfrDBDataSet;
    md_tableREgion: TStringField;
    md_tableadditionalinfo: TStringField;
    md_tablefact_end: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    F_Date:TDate;
    F_Region_ID:integer;
    F_Wait:Tfrm_WaitProcess;
    procedure startTRansaction();
  public
    { Public declarations }
    property _Date:TDate write F_Date;
    property Region_ID:integer write F_Region_ID;
    function PrepareDsets():boolean;
  end;

  const sQL_SEL=' select sr.name region,dd.id, o.ordernumber, br.name brigadier, dd.planstartdate stratdate  ,dd.planenddate endDate, '+
                ' ( select ADRES from get_adres(o.fk_orders_housetypes, o.fk_orders_streets,o.housenum,o.additionaladdress)) adress, '+
                '    sd.name locality, dd.endDate fact_end, dd.additionalinfo '+
                '    from departures dd  inner join orders o on dd.fk_departures_orders=o.id '+
                '    join s_damagelocality sd on sd.id=o.fk_orders_damagelocality '+
                '    join s_regions  sr on dd.fk_departures_region_brig=sr.id '+
                '    join brigadiers br on br.id=dd.fk_departures_brigadiers '+
                '    where  dd.planstartdate>:d1 and dd.planstartdate<:d1+1  %s'+
                '   union '+
                '  select  sr.full_name region,dd.id,0, br.name brigadier, dd.planstartdate stratdate  ,dd.planenddate endDate, '+
                '  ( select ADRES from get_adres(dd.fk_deparure_housetypes,dd.fk_deparure_id_street,dd.housenum,dd.addadres)) adress, '+
                '     sd.name locality ,dd.endDate fact_end, dd.additionalinfo '+
                '     from departures dd join s_damagelocality sd on dd.fk_departures_damagelocality=sd.id '+
                '     join all_regions sr on sr.id =dd.fk_departure_regions '+
                '      join brigadiers br on br.id=dd.fk_departures_brigadiers '+
                '      where  dd.planstartdate>:d1 and dd.planstartdate<:d1+1 %s'+
                '  order by    1    ';

var
  dm_SPlanWork: Tdm_SPlanWork;

implementation

{$R *.dfm}
uses Helpfunctions, StringConsts;

procedure  Tdm_SPlanWork.startTRansaction;
begin
 if tran.InTransaction then
   tran.Commit;
 tran.StartTransaction;
end;

procedure Tdm_SPlanWork.DataModuleCreate(Sender: TObject);
begin
  inherited;
  startTRansaction;
  F_wait:=Tfrm_WaitProcess.create(nil);
end;

function  Tdm_SPlanWork.PrepareDsets():boolean;

const add_reg1='and dd.fk_departures_region_brig=:id_reg';//' and o.fk_orders_regions=:id_reg ';
     add_reg2=' and dd.fk_departure_regions=:id_reg ';

var dep_id:integer;
function getData(dset:TIBDataSet):string;
var s_res:string;
begin
    s_res:='';
    if dset.Active then
    dset.Close;
    dset.ParamByName('dep_id').AsInteger:=dep_id;
    dset.Open;
    while not dset.Eof do begin
    if trim(dset.fieldbyname('name').AsString)='' then
    begin
     if  dset.FindField('typ_name')<>nil then
       if dset.fieldbyname('typ_name').AsString<>'' then
           s_res:=s_res+','+#13+trim(dset.fieldbyname('typ_name').asstring);
     end
     else
       s_res:=s_res+','+#13+trim(dset.fieldbyname('name').asstring);
     if dset.FindField('diameter')<>nil then
      if dset.FieldByName('diameter').AsInteger>0 then
       s_res:=s_res+' d='+dset.FieldByName('diameter').AsString+'мм';
     dset.Next;
    end;
   dset.Close;
   delete(s_res,1,2);
   Result:=s_res;
end;


begin

Result:=false;
F_wait.Show;
try
 Result:=false;
 if dset_main.Active then
 dset_main.Close;
 if F_Region_ID>0 then begin
   dset_main.SelectSQL.Text:=Format(sQL_SEL,[add_reg1,add_reg2]);
   dset_main.ParamByName('id_reg').AsInteger:=F_Region_ID;
 end
 else
  dset_main.SelectSQL.Text:=Format(sQL_SEL,[' ',' ']);

 dset_main.ParamByName('d1').AsDate:=F_Date;

 dset_main.Open;
 dset_main.First;
 if md_table.Active then
   md_table.Close;
 md_table.Open;
 while not dset_main.Eof do
 begin
  dep_id:= dset_main.fieldbyname('id').asinteger;
  with md_table do begin
    Append;
    fieldbyname('Region').AsString:=dset_main.fieldbyname('region').AsString;
    fieldbyname('ordernumber').AsString:=dset_main.fieldbyname('ordernumber').AsString;
    fieldbyname('Brig').AsString:=trim(dset_main.fieldbyname('BRIGADIER').AsString);
    fieldbyname('Start').AsDateTime:=dset_main.fieldbyname('STRATDATE').AsDateTime;
    fieldbyname('End').AsDateTime:=dset_main.fieldbyname('endDate').AsDateTime;
    if not (trim(dset_main.fieldbyname('adress').AsString)='') then
     Fieldbyname('adress').AsString:=dset_main.fieldbyname('adress').asstring
    else
  {   if  not dset_main.fieldbyname('adress_dep').IsNull then
       Fieldbyname('adress').AsString:=dset_main.fieldbyname('adress_dep').asstring
     else                                                                          }
        Fieldbyname('adress').AsString:='';

    if  not dset_main.fieldbyname('Locality').IsNull then
     fieldbyname('Locality').AsString:=dset_main.fieldbyname('locality').asstring
    else
      if not dset_main.fieldbyname('Locality_dep').IsNull then
       fieldbyname('Locality').AsString:=dset_main.fieldbyname('locality_dep').asstring
      else
       fieldbyname('Locality').AsString:='';

    fieldbyname('Workkers').AsString:=getdata(dset_workers);
    fieldbyname('equipments').AsString:=GetData(dset_equipment);
    fieldbyname('PlanWorks').AsString:=getData(dset_planworks);
    if not dset_main.fieldbyname('fact_end').IsNull then
    begin
     fieldbyname('fact_end').AsString:='Заверш.этапа '+DateTimeFormat('hh:mm',dset_main.fieldbyname('fact_end').AsDateTime)+';';
     fieldbyname('ADDITIONALINFO').AsString:=dset_main.fieldbyname('ADDITIONALINFO').AsString;
    end;
    Post;
  end;
   dset_main.Next;
 end;
 Result:=true;
 F_wait.Close;
except on e:exception do
begin
Application.MessageBox(PChar('Ошибка формирования данных сводка планируемых работ'+#13+e.Message),gc_strDispAVR,mb_Ok+MB_IconError);
F_wait.Close;
end;
end;
end;

procedure Tdm_SPlanWork.DataModuleDestroy(Sender: TObject);
begin
  inherited;
if md_table.Active then md_table.Close;
if dset_main.Active then dset_main.Close;
if dset_equipment.Active then dset_equipment.Close;
if dset_workers.Active then dset_workers.Close;
if dset_planworks.Active then dset_planworks.Close;
  F_wait.free;
end;

end.
