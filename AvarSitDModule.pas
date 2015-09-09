unit AvarSitDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,
  IBDatabase, DB, IBCustomDataSet, DModule, FR_DSet, FR_DBSet, RxMemDS, frOLEExl,
  IBSQL, ApplicationSettings
  ;

const
  id_Magist=1;
  id_vvod=2;
{  id_stoi=21;
  id_perekl=24;}
  reason_Mag='Течь из земли на магистрали d=';
  reason_Vvod='Течь из земли на вводе d=';
{  reason_stoi='Строительство ввода d=';
  reason_perekl='Перекладка сети водопровода d=';}
  ID_SV=1;

type
  Tdm_AvarSit = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    Dset: TIBDataSet;
    frDBResult: TfrDBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetordernumber: TIntegerField;
    ResultDsetRegions: TStringField;
    ResultDsetadres: TStringField;
    ResultDsetdatecoming: TDateTimeField;
    ResultDsetdateclosed: TDateTimeField;
    ResultDsetreason: TStringField;
    ResultSvod: TRxMemoryData;
    ResultSvoddata: TDateField;
    ResultSvodVsego: TIntegerField;
    ResultSvodPostup: TIntegerField;
    ResultSvodvipoln: TIntegerField;
    frDBResultSvod: TfrDBDataSet;
    IBSQL_inst: TIBSQL;
    ResultDsetwithoutExcav: TStringField;
    ResultDsetplandateregl: TStringField;
  private
    { Private declarations }
    
    F_DtBeg: TDateTime;
    postup, likv , vsego:integer;
    procedure FillResultDset;
    procedure FillResultSvodDset;
    procedure FillSvod;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    function PrepareDset: boolean;
    function ExportFRToExcel(fr_rep: TfrReport;excel_file_name: string): boolean;
    function SaveAfterSend(file_name:string):boolean;
  end;

var
  dm_AvarSit: Tdm_AvarSit;

implementation

{$R *.dfm}
uses HelpFunctions,GlobalData,DateUtils;

function Tdm_AvarSit.PrepareDset: boolean;
begin
   Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    FillResultSvodDset;
    if tran.InTransaction then
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_UseEquip.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_AvarSit.FillResultDset;
var i:integer;
function CorrectDate(dt:TDateTime):string;
var  y, m, d,hh,mm,ss,ms: word;
begin
 DecodeDateTime(dt,y, m, d,hh,mm,ss,ms);

 if (hh>0) and (mm>0) then
   result:=IntToStr(y)
 else
  result:=DateToStr(dt);
end;
begin
{
select o.ordernumber
   , (select name from s_Regions where id=o.fk_orders_regions) Regions
   , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres
   , o.datecoming
   , (select d.additionalinfo from departures d where d.fk_departures_orders = o.id and d.depnumber = 1) reason
 from orders o
 where (o.fk_orders_damageplace in (1,2))
    and (o.datecoming < '28.03.2009' )
    and ((o.dateclosed >= '26.03.2009' ) or (o.isclosed = 0))
order by 2,4
}

vsego:=0;
likv:=0;
if  ResultDset.Active then
  ResultDset.Close;
  ResultDset.Open;
  MyOpenIBDS( Dset,
    ' select o.ordernumber' +
    ' , (select name from s_Regions where id=o.fk_orders_regions) Regions' +
    ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres' +
    ' , o.datecoming,  o.dateclosed'+
    ' ,  dd.additionalinfo  reason '+
    ' , dd.plandateregl '+
    ' ,o.fk_orders_damageplace damageplace '+
    ' ,sd.DIAMETER '+
    ' ,o.FK_ORDERS_OFF_WITHOUTEXCAV '+
    '   from orders o join departures dd on (dd.fk_departures_orders = o.id and dd.depnumber = 1 ) '+

    '  left join S_TUBEDIAMETER sd on sd.id =dd.FK_DIAMETER'+
    '  where (o.fk_orders_damageplace in (1,2)) ' +
    ' and ( o.datecoming < ''' + DateToStr( F_DtBeg  ) + ' '+g_ShiftStartTime+''' )' +
    ' and (( o.dateclosed >= ''' + DateToStr( F_DtBeg -1 ) + ' 6:00'' )'+{ and '+
    ' ( o.dateclosed <= '''+ DateToStr( F_DtBeg  ) + ' '+g_ShiftStartTime+''') )' +  }
    ' or (o.isclosed = 0))' +
    ' order by 2,4' );
    dset.First;
    while  not dset.Eof do
    begin
     ResultDset.Append;
     for  i:=0 to   ResultDset.FieldCount-1 do
     begin
       if ResultDset.Fields[i].FieldName<>'withoutExcav' then
       ResultDset.Fields[i].AsVariant:=dset.fieldbyname( ResultDset.Fields[i].FieldName).AsVariant;
       if ResultDset.Fields[i].FieldName='plandateregl' then
         ResultDset.Fields[i].AsString:=CorrectDate(dset.fieldbyname( ResultDset.Fields[i].FieldName).AsDateTime);
     end;
     //установим дату закрытия если больше входной даты 8:00 то 0
      if ResultDset.Fieldbyname('dateclosed').AsDateTime>StrToDateTime(DateToStr( F_DtBeg  ) + ' '+g_ShiftStartTime)  then
        ResultDset.Fieldbyname('dateclosed').AsVariant:=null;
//     if  not dset.fieldbyname('DIAMETER').IsNull then
     case dset.FieldByName('damageplace').AsInteger of
       id_Magist:ResultDset.FieldByName('reason').AsString:=reason_Mag;
       id_vvod:ResultDset.FieldByName('reason').AsString:=reason_Vvod;
    {   id_stoi:ResultDset.FieldByName('reason').AsString:=reason_stoi;
       id_perekl:ResultDset.FieldByName('reason').AsString:=reason_perekl;}

       else  ResultDset.FieldByName('reason').AsString:='';
     end;
       if  not dset.fieldbyname('DIAMETER').IsNull then
         ResultDset.FieldByName('reason').AsString:=ResultDset.FieldByName('reason').AsString+' '+ dset.fieldbyname('DIAMETER').AsString+'мм';
    // Если  наряд закрыт  без раскопок по к фактической дате + Без земяных работ
    if   (not dset.FieldByName('FK_ORDERS_OFF_WITHOUTEXCAV').IsNull) and  ( not ResultDset.Fieldbyname('dateclosed').IsNull) then
        ResultDset.FieldByName('withoutExcav').AsString:=#13+WithoutExcav
     else
      ResultDset.FieldByName('withoutExcav').AsString:='';

     {Подщитаем для нижней таблицы}

     if not ResultDset.Fieldbyname('dateclosed').IsNull then
       likv:=likv+1
     else
      vsego :=vsego+1;
     ResultDset.Post;
     dset.Next;
    end;
end;

procedure Tdm_AvarSit.FillResultSvodDset;
var i:integer;
    strdata:string;
    curdate:TDate;
  function setstartdate():string;    //данніе 1 день месяца -1
    var year,month,day:word;
    date:TDate;
  begin
   DecodeDate(F_DtBeg,year,month,day) ;

  { if month=1 then
   begin
    month:=12;
    year:=year-1;
   end
   else
     month:=month-1;}
    date:=encodedate(year,month,1);

    resuLt:='01.'+intToStr(month)+'.'+IntToStr(year);
    resuLt:=DateToStr(date-1);

  end;
  function isdatewrite() :boolean;
  begin
   Result:=false;
   if Time()<StrToTime(g_ShiftStartTime)  then
    begin
     if F_DtBeg=Date() then
      Result:=true;
    end
   else
    if F_DtBeg=Date()+1 then
     result:=true;
  end;

  function iscanwrite() :boolean;
  begin
   if AppSettings.Get_IsSentXML='1' then
    Result:=true
   else
    result:=false;
  end;
begin
if  ResultSvod.Active then
 ResultSvod.Close;
ResultSvod.Open;
strdata:=setstartdate();

{MyOpenIBDS(dset,'select ss.dateform,ss.fielname,ss.save_value '+
                ' from svodkagik_save  ss where '+
                ' ss.dateform>'''+strdata+''' '+
                ' and ss.dateform<'''+DateToStr(F_DtBeg+2)+''' and '+
                ' ss.fielname in (''VvodyVsego'',''VodoSetiVsego'','+
                '''LikvidNaVodoSetyax'',''LikvidNaVvodax'','+
                '''PostupNaVodoSetyax'',''PostupNaVvodax'' )'+
                ' order by 1,2 ');
dset.First;
while  (not dset.Eof)and(dset.fieldbyname('dateform').AsDateTime<F_DtBeg+1) do begin
 ResultSvod.Append;
 for i:=1 to ResultSvod.FieldCount-1 do
  ResultSvod.Fields[i].Value:=0;
 curdate:=dset.fieldbyname('dateform').AsDateTime;
 ResultSvod.FieldByName('data').AsDateTime:=date;


 i:=0;
 while (not dset.Eof)  and (dset.fieldbyname('dateform').AsDateTime-curdate<1) and (i<2) do
 begin



  if dset.FieldByName('fielname').AsString[1]='V' then
     begin
     ResultSvod.FieldByName('Vsego').AsInteger:=dset.FieldByName('save_value').AsInteger+
      ResultSvod.FieldByName('Vsego').AsInteger;
     i:=i+1;
     end;
  dset.Next;
  end;


 while (not dset.Eof) and (dset.fieldbyname('dateform').AsDateTime=date) do
  dset.Next;
 curdate:=dset.fieldbyname('dateform').AsDateTime;
 i:=0;
 while (not dset.Eof)  and (dset.fieldbyname('dateform').AsDateTime-date<1)and (i<4) do
 begin


   if dset.FieldByName('fielname').AsString[1]='P' then
   begin
     ResultSvod.FieldByName('Postup').AsInteger:=dset.FieldByName('save_value').AsInteger+
     ResultSvod.FieldByName('Postup').AsInteger;
   i:=i+1;
   end;
   if dset.FieldByName('fielname').AsString[1]='L' then
   begin
    ResultSvod.FieldByName('vipoln').AsInteger:=ResultSvod.FieldByName('vipoln').AsInteger+
                                                 dset.FieldByName('save_value').AsInteger;
     i:=i+1;
   end;
   dset.Next;
 end;

 ResultSvod.Post;
end;
dset.Close; }
{ if (isdatewrite) and (iscanwrite) then //заполняет последню строчку
  FillSvod;}
 //заполняем рез таблицу
 MyOpenIBDS(dset,'select * from SVODAVARSIT where sdate>='''+strdata+''' and sdate<= '''+DateToStr(F_DtBeg-1)+''' order by SDATE');
 dset.First;
 while  not  dset.Eof do begin
  ResultSvod.Append;
  curdate:=dset.fieldbyname('sdate').AsDateTime;
  ResultSvod.FieldByName('data').asstring:=DateToStr(curdate);
  while (dset.FieldByName('sdate').AsDateTime=curdate) and  (not dset.Eof)
  do begin

   ResultSvod.FieldByName(trim(dset.fieldbyname('fieldname').AsString)).AsInteger:=dset.fieldbyname('fieldvalue').AsInteger;
   dset.Next;
  end;
  ResultSvod.Post;
 end;
 {Редактирем предпосл строку заполняем посленюю}
//if DayOf(F_DtBeg)>1 then
//begin
 ResultSvod.Edit;
 ResultSvod.FieldByName('vipoln').AsInteger:=likv;
 postup:=vsego-ResultSvod.FieldByName('vsego').AsInteger+likv;
 ResultSvod.FieldByName('postup').AsInteger:=postup;
 ResultSvod.Post;
//end;
 ResultSvod.Append;
 ResultSvod.FieldByName('data').asstring:=DateToStr(F_DtBeg);
 ResultSvod.FieldByName('vipoln').AsInteger:=0;
 ResultSvod.FieldByName('postup').AsInteger:=0;
 ResultSvod.FieldByName('vsego').AsInteger:=vsego;
 ResultSvod.Post;
  if (isdatewrite) and (iscanwrite) then //заполняет последню строчку
   FillSvod;

 dset.Close;
end;

function Tdm_AvarSit.ExportFRToExcel(fr_rep: TfrReport;
  excel_file_name: string): boolean;
var
  excel_exp: TfrOLEExcelExport;
  _c: integer;
begin
  try
    excel_exp:=TfrOLEExcelExport.Create(nil);
    try
      excel_exp.ShowDialog:=false;
      excel_exp.ShowDialog:=false;
      fr_rep.EMFPages.Count;
      fr_rep.ExportTo(excel_exp, excel_file_name);
      Result:=not fr_rep.Terminated;
    finally
      excel_exp.Free;
    end;
  except
    on E: Exception do
    begin
      Result:=false;
      Application.MessageBox('Ошибка экспорта в Excel(TRootReport.ExportFastReportToExcel)',
                                'Отключения АВР', MB_OK+MB_ICONERROR);
    end;
  end;
end;

procedure Tdm_AvarSit.FillSvod; //формируем информацию для нижней части последниюю строчку

var str:string;
begin

 //save in table
 try
 if tran.InTransaction then tran.Commit;
  tran.StartTransaction;
  IBSQL_inst.SQL.Text:=format('update or insert into  SvodAvarsit (Sdate ,fieldname ,fieldvalue  )'+
                       ' values (''%s '', ''postup'',%d) matching (Sdate,fieldname)',[DateToStr(F_dtBeg-1),postup]);
  IBSQL_inst.ExecQuery;
  IBSQL_inst.SQL.Text:=format('update or insert into  SvodAvarsit (Sdate ,fieldname ,fieldvalue  )'+
                       ' values (''%s '', ''vipoln'',%d) matching (Sdate,fieldname)',[DateToStr(F_dtBeg-1),likv]);
  IBSQL_inst.ExecQuery;
  IBSQL_inst.SQL.Text:=format('update or insert into  SvodAvarsit (Sdate ,fieldname ,fieldvalue  )'+
                       ' values (''%s '', ''vsego'',%d) matching (Sdate,fieldname)',[DateToStr(F_dtBeg),vsego]);
  IBSQL_inst.ExecQuery;
  tran.Commit;
 except
  if tran.InTransaction then
   tran.Rollback;
 end;

end;

function Tdm_AvarSit.SaveAfterSend(file_name:string):boolean;
var s:string;
begin
 Result:=false;
  try

   if  tran.InTransaction then
    tran.Rollback;
   tran.StartTransaction;
   IBSQL_inst.SQL.Text:='update SENTSVEMAIL set file_name='''+file_name +''' where id=1';
   IBSQL_inst.exeCQuery;
   tran.Commit;
  Result:=true;
  except
   if tran.InTransaction then
    tran.Rollback;
  end;
end;



end.
