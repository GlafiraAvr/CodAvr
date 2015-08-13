unit GetOst1562_3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, DB, IBCustomDataSet,
  IBDatabase, RxMemDS, IBSQL, ADODB;

type
  Tdm_GetOst1562 = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    tran: TIBTransaction;
    tran_1562: TIBTransaction;
    dset_1562: TIBDataSet;
    md_result: TRxMemoryData;
    md_resultdt: TDateTimeField;
    md_resultid_region: TIntegerField;
    md_resultPlace: TStringField;
    md_resultvalue: TIntegerField;
    IBSQL: TIBSQL;
    ADOQry: TADOQuery;
    ADOQ_selOst1562: TADOQuery;
  private
    { Private declarations }
  public
  procedure prepareData();
  procedure SetSaveOpenedPeriod();
    { Public declarations }
  end;

var
  dm_GetOst1562: Tdm_GetOst1562;

implementation

{$R *.dfm}
uses HelpFunctions,GlobalData;

procedure Tdm_GetOst1562.prepareData;

const selSQL='select count(*)  from SVODKA_ost1562 where DT>''%s''';


function IsneedLoad:boolean;
 var str:string;
begin
 str:=DateToStr(Date());
  tran.StartTransaction;
  MyOpenIBDS(dset,Format(selSQL,[str]));
  if dset.Fields[0].AsInteger>0 then
   Result:=false
  else
   Result:=true;
   dset.Close;
end;



// поменяем таблица из msSQL

procedure Get_1562;
const {selSQL='select sv.dt, sv.id_place1562, sr.name, sv.val '+
             ' from svodka sv, s_region sr where sv.id_region1562=sr.id and dt>''%s''';}

selSQL = 'SELECT [dt] ,[id_region1562]  ,[id_place1562] ,[val] '+
         '   FROM [avr_vs_request].[dbo].[vwSvodka] '+
         '   where  [dt]>''%s''';
var i:integer;
    s_regions:string;
begin

 s_regions:='';
 if ADOQ_selOst1562.Active then
   ADOQ_selOst1562.Close;
 ADOQ_selOst1562.SQL.Text:=Format(selsql,[FormatDateTime('mm.dd.yyyy',Date())]);
 ADOQ_selOst1562.Open;
// MyOpenIBDS(dset_1562,Format(selSQL,[DateToStr(Date())]));
 md_result.Open;

 ADOQ_selOst1562.First;
 while not ADOQ_selOst1562.Eof do
 begin
   md_result.Append;
   md_result.FieldByName('dt').AsDateTime:=ADOQ_selOst1562.fieldbyname('dt').AsDateTime;
   md_result.FieldByName('value').AsInteger:=ADOQ_selOst1562.fieldbyname('val').AsInteger;
   case  ADOQ_selOst1562.FieldByName('id_place1562').AsInteger of
    10: md_result.FieldByName('Place').AsString:='ВДС';
    11: md_result.FieldByName('Place').AsString:='НС';
   end;
 {  MyOpenIBDS(  dset,
    'select id from s_regions where name in(upper('''
    +trim(dset_1562.fieldbyname('name').AsString)+''') )' );}
   md_result.FieldByName('id_region').AsInteger:=RigionsMatchArray[ADOQ_selOst1562.fieldbyname('id_region1562').AsInteger][1];
   md_result.Post;
   ADOQ_selOst1562.Next;
 end;
end;

procedure Insert_1562;
const insSQL='insert into SVODKA_OST1562 (dt,id_region,Place,val) values (''%s'',%d,''%s'',%d)';
begin

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  md_Result.First;
  while  not md_Result.Eof do
  begin
    MyExecIBSQL(IBSQL,Format(insSQL,[md_result.FieldByName('dt').AsString,
                                    md_result.FieldByName('id_region').AsInteger,
                                    md_result.FieldByName('Place').AsString,
                                    md_result.FieldByName('value').AsInteger ]));
     md_result.Next;
  end;
  tran.Commit;
end;

begin
{dset.SelectSQL.Clear;
dset.SelectSQL.Add(' select count(*)  from SVODKA_ost1562 where DT>''15.11.2012'' ');
dset.Open;}

{str:=DateToStr(Date());
  tran.StartTransaction;
  MyOpenIBDS(dset,Format(selSQL,[str]));
{  if dset1.Fields[0].AsInteger>0 then
   Result:=false
  else
   Result:=true;}
  // dset.Close;
if IsneedLoad  then
begin
///  StartGet;
   IncProgressStatus( GetProgressShagLength( 10, 1 ));
  Get_1562;
   IncProgressStatus( GetProgressShagLength( 40, 1 ));
//  EndGet;
   IncProgressStatus( GetProgressShagLength( 10, 1 ));
  Insert_1562;
   IncProgressStatus( GetProgressShagLength( 40, 1 ));

  md_result.Close;

end;
// SetSaveOpenedPeriod(); 
end;

procedure Tdm_GetOst1562.SetSaveOpenedPeriod();
const SQL_SQL='select add_1562 from servanttable';
      SQL_UPDATE='update servanttable  set add_1562=''%s''';
 var ds:TDateTime;
     dt1,dt2:string;
begin
 if tran.InTransaction then tran.Commit;
 tran.StartTransaction;
 ds:=0;
 dt1:=formatdatetime('mm.dd.yyyy' ,Date()-1)+' 6:00';
 dt2:=formatdatetime('mm.dd.yyyy' ,Date())+' 6:00';

 dset.SelectSQL.Clear;
 dset.SelectSQL.Add(SQL_SQL);
 dset.Open;

 if  not dset.FieldByName('add_1562').IsNull then
   ds:=dset.fieldbyname('add_1562').AsDateTime;
if ds<Date() then
 begin
   ADOQry.SQL.Text:='execute spCountTendersOpenedPeriod '''+dt1+''', '''+dt2+''' ,1';
   ADOQry.ExecSQL;
   MyExecIBSQL(IBSQL,Format(SQL_UPDATE,[formatdatetime('dd.mm.yyyy hh:mm:ss',Now())]));
 end;

 tran.Commit;

end;




end.
