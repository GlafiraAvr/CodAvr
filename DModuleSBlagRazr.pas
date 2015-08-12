unit DModuleSBlagRazr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBCustomDataSet, FR_DSet,
  FR_DBSet, DB, RxMemDS,DModule, IBSQL, IBDatabase;

type
  Tdm_SBlagRazr = class(Tdm_NGReportBase)
    md_result: TRxMemoryData;
    md_resultData: TStringField;
    md_resultnb_All: TIntegerField;
    md_resultnb_Asf: TIntegerField;
    md_resultnb_GrZone: TIntegerField;
    md_resultraz_All: TIntegerField;
    md_resultraz_Asf: TIntegerField;
    md_resultraz_GrZone: TIntegerField;
    md_resultbr_All: TIntegerField;
    md_resultbr_Asf: TIntegerField;
    md_resultbr_GrZaone: TIntegerField;
    md_resultExkav: TIntegerField;
    frDBD_md_res: TfrDBDataSet;
    dset: TIBDataSet;
    IBSQL: TIBSQL;
    tran_insert: TIBTransaction;
    md_resulttech_mag: TIntegerField;
    md_resulttech_vvod: TIntegerField;
    md_resulttech_all: TIntegerField;
    md_resultlikv_mag: TIntegerField;
    md_resultlikv_vvod: TIntegerField;
    md_resultlikv_all: TIntegerField;
    md_resultpost_mag: TIntegerField;
    md_resultpost_vvod: TIntegerField;
    md_resultpost_all: TIntegerField;
    procedure md_resultCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    F_Dt:tDate;
    F_Dt_beg,F_Dt_End:TDate;
  public
    { Public declarations }
  property _Dt:TDate write F_Dt;//дата когда формируем
  property Dt_Beg:TDate  write F_Dt_beg;
  property Dt_End:TDate  write F_Dt_end;
  function preparedata():boolean;
  function preparedsets():boolean;
  end;

var
  dm_SBlagRazr: Tdm_SBlagRazr;


implementation
 uses HelpFunctions;

{$R *.dfm}
function  Tdm_SBlagRazr.preparedsets():boolean;
const sel_SQL='select * from SVODKA_RAS_SAVE where data>=''%s'' and data<=''%s'' order by data ';
var i:integer;
    str_SQL:string;
begin
Result:=false;
md_result.Close;
md_result.Open;

str_SQL:=Format(sel_SQl,[DateToStr(F_Dt_beg),DateToStr(f_Dt_end)]);
MyOpenIBDS(dset,str_sql);
dset.First;
while  not dset.Eof do
begin
 md_result.Append;
 md_result.FieldByName('Data').AsString:=dset.fieldbyname('data').AsString;
 while (md_result.FieldByName('Data').AsString=dset.fieldbyname('data').AsString)
 and (not dset.Eof) do
 begin
   md_result.FieldByName(dset.fieldbyname('FIELDNAME').AsString).AsInteger:=dset.fieldbyname('FIELADVALUE').AsInteger;
   dset.Next;
 end  ;
 md_result.Post;
end;
Result:=true;
end;

function  Tdm_SBlagRazr.preparedata :boolean;
const
  SQL_not_blag='select count(distinct o.id) '+
               '    from orders o' +
                ' where '+
                '   o.lastexcwrktype in (2,3,9)'+
                '  and not (o.fk_orders_damagelocality in (-1, 4)) '+
                '  and (o.DateComing>''01.01.2004'') '+
  ' and o.isclosed=1 '+
 ' and o.fk_orders_damageplace in (1,2,3) ';

{  ' select count(distinct dw.fk_depworks_order) '+
           ' from departureworks dw inner join orders o on dw.fk_depworks_order=o.id '+
           ' where '+
           ' dw.fact_datetime>=''%s'' and dw.fact_datetime<=''%s'' '+
           ' and dw.fk_depworks_work in (268435481 , 268435476,1)'; }//*раскопали траншею раскопали котлован*/

  SQL_RAZ1=' select   distinct dw.fk_depworks_order '+
           ' from departureworks dw inner join orders o on dw.fk_depworks_order=o.id '+
           ' where '+
           ' dw.fk_depworks_work in (268435481 , 268435476,1) %s'+
           '    group by 1 '+
           '    having min(dw.fact_datetime)>=''%s'' '+
           '             and min(dw.fact_datetime)<=''%s'' ';

  SQL_RAZ2='select count (distinct dd.fk_departures_orders) '+
           ' from departures dd inner join departureworks dw on dw.fk_depworks_departure=dd.id '+
           ' inner join orders o on dw.fk_depworks_order=o.id '+
           ' where dw.fk_depworks_work in (268435481 , 268435476,1) and dw.fact_datetime is null '+
           ' and dd.startdate>=''%s'' and dd.startdate<=''%s'' ';

  SQL_RAZ3='select  count(distinct ex.fk_excavations_orders) '+
           ' from excavations ex, orders o where '+
           ' ex.fk_excavations_excwt  in(2,3,4,9) and'+
           ' o.id=ex.fk_excavations_orders  and'+
           '  ex.dtime>=''%s'' and' +
           '  ex.dtime<''%s'' ';

 SQL_br_GrZ=' select count(distinct o.id)'+
        ' from orders o, excavations ex '+
        ' where o.id=ex.fk_excavations_orders '+
        ' and ex.dtime>''%s'' and '+
        ' ex.dtime<''%s'''+
        ' and o.fk_orders_damagelocality=3 '+ // зеленая полоса*/
        ' and o.lastexcwrktype=6 '; ///*Спланировано*/

  SQL_br_Asf='select  count(distinct o.id) '+
             ' from orders o, excavations ex'+
             ' where o.id=ex.fk_excavations_orders'+
             ' and ex.dtime>''%s'' and'+
             ' ex.dtime<''%s'' and '+
             ' ((ex.fk_excavations_excwt in(5) '+// /*Заасфальтировано*/
             ' and o.fk_orders_damagelocality in (1,2,6,7,8)'+// /* Проезжая магистральная   Тротуар магистральный   Проезжая внутриквартальная   Тротуар внутриквартальный  Отмостка*/
             ' ) or '+
             ' ( o.fk_orders_damagelocality=5'+// /* Грунтовая дорога*/
             ' and o.lastexcwrktype in(6,11)))'; // /*Спланировано Защебенено*/))
    //19.08.2013 выбирае толькр экскаваторы а не все оборудование
   SQL_exkav=' select distinct ew.fk_eqwork_equip from equipwork ew, orders o,equipment e'+   //из оборудование кнопка в наряде
             ' where o.id=ew.fk_eqwork_orders '+
             ' and o.isclosed=1 '+
             ' and ew.datework>=''%s'' '+
             ' and ew.datework<=''%s'' '+
             ' and ew.fk_eqwork_equip not in (44)'+
             ' and e.id=ew.fk_eqwork_equip '+
             ' and e.fk_equip_typ=1 '+
             ' union '+
             ' select distinct ee.id '+
             ' from excavations ex, equipment ee where '+           //раскопки оборудование
             '      ee.id=ex.fk_excavations_equipment '+
             '       and ex.dtime>''%s'' '+
             '       and ex.dtime<''%s'' '+
             '          and ee.id>0 '+
             '        and ee.fk_equip_typ=1 '+
             ' union '+                                                               //оборудование выезды
             '   select de.fk_depequips_equip from departureequips de,equipment e '+
             '    where de.fact_datetime >=''%s'' and de.fact_datetime<=''%s'' '+
             '    and e.id=de.fk_depequips_equip '+
             '  and de.fk_depequips_equip not in (44)'+
             '  and e.fk_equip_typ=1 ';


   {'select count( distinct ex.fk_excavations_equipment) '+
             '   from excavations ex, equipment ee where '+
             '   ee.id=ex.fk_excavations_equipment '+
             '   and ex.dtime>''%s'' and '+
             ' ex.dtime<''%s'' '+
             ' and number>0';}


  ASF=' and  (o.fk_orders_damagelocality in (1, 2 ,6,7,8))';
  G_zone=' and o.fk_orders_damagelocality in (3,5)';

  SQL_tech='select count(*) from  orders o where o.fk_orders_damageplace in (%d) and o.isclosed=0';
  SQL_likv='select count(*) from orders o where o.dateclosed >=''%s'' and o.dateclosed< ''%s'' and o.fk_orders_damageplace =%d';
  SQL_post='select count(*) from orders o where o.datecoming>=''%s'' and o.datecoming< ''%s'' and o.fk_orders_damageplace =%d';

var  D1,D2:TDatetime;
    str1,str2:string;

function FromSQL(SQL:string;field_name:string=''):integer ;
var s:integer;
begin
 if dset.Active then
  dset.Close;
  dset.SelectSQL.Clear;
  dset.SelectSQL.Text:=SQL;

  dset.Open;
  if (field_name='Exkav') or (field_name='SQL_RAZ1' ) then
  begin
   Result:=0;
  s:= dset.RecordCount;
  s:=s+1;
   dset.First    ;
   while not dset.Eof do begin
   Result:=Result+1;
   dset.Next;
   end;
  end
  else
  begin
  dset.First;
   if  dset.FieldList[0].IsNull then
    REsult:=0
   else
    result:=dset.FieldList[0].AsInteger;
  end;
end;

procedure SaveToBase();
var i:integer;
   str:string;
 begin
   if tran_insert.InTransaction then
      tran_insert.Commit;
   tran_insert.StartTransaction;
   str:=DateToStr(f_Dt-1 );
   md_result.First;
   for i:=1 to md_result.FieldCount-1 do
   begin
    if  not  md_result.Fields[i].IsNull then
    begin
     IBSQL.SQL.Text:=Format('insert into Svodka_Ras_Save (data,Fieldname,Fieladvalue) values (''%s'',''%s'',%d)',
                         [str,md_result.Fields[i].FieldName,md_result.Fields[i].AsInteger] );
     IBSQL.ExecQuery;
    end;
   end;
  tran_insert.Commit;
 end;

function is_load:boolean;
begin
 MyOpenIBDS(dset,'select count(*) from  Svodka_Ras_Save where data='''+Datetostr(F_DT-1)+'''');
 Result:=dset.Fields[0].AsInteger>1 ;
end ;


begin
Result:=false;
if not is_load then begin
 md_Result.Close;
 md_Result.Open;
 md_Result.Append;

 d1:=(F_Dt-1)+StrToTime('6:00');
 d2:=(F_Dt)+StrToTime('6:00');

 str1:=DateTimeToStr(D1);
 str2:=DateTimeToStr(D2);

 md_result.FieldByName('nb_Grzone').AsInteger:=FromSQL(SQL_not_blag+G_zone);
 IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('nb_Asf').AsInteger:=FromSQL(SQL_not_blag+Asf);
  IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('raz_GrZone').AsInteger:=FromSQL(Format(SQL_RAZ1,[ G_zone,str1,str2]), 'SQL_RAZ1');
 md_result.FieldByName('raz_GrZone').AsInteger:=md_result.FieldByName('raz_GrZone').AsInteger
                                              +FromSQL(Format(SQL_RAZ2+G_zone,[str1,str2]) );
  IncProgressStatus( GetProgressShagLength( 10, 1 ));
 md_result.FieldByName('raz_Asf').AsInteger:=FromSQL(Format(SQL_RAZ1,[ Asf, str1,str2]),'SQL_RAZ1');
 md_result.FieldByName('raz_Asf').AsInteger:=md_result.FieldByName('raz_Asf').AsInteger
                                            +FromSQL(Format(SQL_RAZ2+ASF,[str1,str2]));
  IncProgressStatus( GetProgressShagLength( 10, 1 ));
 md_result.FieldByName('br_GrZone').AsInteger:=FromSQl(Format(SQL_br_GrZ,[str1,str2]));
  IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('br_Asf').AsInteger:=FromSQl(format(SQL_br_Asf,[str1,str2]));
  IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('Exkav').AsInteger:=FromSQL( Format(SQL_exkav,[str1,str2,str1,str2,str1,str2]),'Exkav');
  IncProgressStatus( GetProgressShagLength( 10, 1 ));



 md_result.FieldByName('tech_mag').AsInteger:=FromSQL(Format(SQL_tech,[1]));
 md_result.FieldByName('tech_vvod').AsInteger:=FromSQL(Format(SQL_tech,[2]));
   IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('likv_mag').AsInteger:=FromSQL(Format(SQL_likv,[str1,str2,1]));
 md_result.FieldByName('likv_vvod').AsInteger:=FromSQL(Format(SQL_likv,[str1,str2,2]));
   IncProgressStatus( GetProgressShagLength( 10, 1 ));

  md_result.FieldByName('post_mag').AsInteger:=FromSQL(Format(SQL_post,[str1,str2,1]));
 md_result.FieldByName('post_vvod').AsInteger:=FromSQL(Format(SQL_post,[str1,str2,2]));
   IncProgressStatus( GetProgressShagLength( 10, 1 ));

 md_result.FieldByName('Data').AsDateTime:=F_Dt;


 mD_result.Post;
 SaveToBase();
 IncProgressStatus( GetProgressShagLength( 20, 1 ));
 mD_result.Close;
end;
Result:=true;
end;


procedure Tdm_SBlagRazr.md_resultCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('nb_All').AsInteger:=DataSet.FieldByName('nb_Asf').AsInteger+DataSet.FieldByName('nb_GrZone').AsInteger;
  DataSet.FieldByName('raz_All').AsInteger:=DataSet.FieldByName('raz_Asf').AsInteger+DataSet.FieldByName('raz_GrZone').AsInteger;
  DataSet.FieldByName('br_All').AsInteger:=DataSet.FieldByName('br_Asf').AsInteger+DataSet.FieldByName('br_GrZone').AsInteger;
  DataSet.FieldByName('tech_All').AsInteger:=DataSet.FieldByName('tech_mag').AsInteger+DataSet.FieldByName('tech_vvod').AsInteger;
  DataSet.FieldByName('likv_All').AsInteger:=DataSet.FieldByName('likv_mag').AsInteger+DataSet.FieldByName('likv_vvod').AsInteger;
  DataSet.FieldByName('post_All').AsInteger:=DataSet.FieldByName('post_mag').AsInteger+DataSet.FieldByName('post_vvod').AsInteger;


end;

end.
