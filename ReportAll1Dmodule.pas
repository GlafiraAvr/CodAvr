unit ReportAll1Dmodule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS,DModule, IBDatabase,
  IBCustomDataSet, FR_DSet, FR_DBSet, IBSQL;

type
  Tdm_ReportAll1 = class(Tdm_NGReportBase)
    rm_Plan: TRxMemoryData;
    dset: TIBDataSet;
    tran: TIBTransaction;
    rm_PlanTwo: TRxMemoryData;
    rm_PlanTworesult: TStringField;
    rm_Planresult: TStringField;
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    IBSQL_inst: TIBSQL;
  private
    { Private declarations }
    F_ShiftDate:TDate; //Дата сверху
    F_vsego,F_likv,f_postup:integer;
    F_plan,f_planbrig:integer;
    f_likvid: integer;
    f_excav:integer;
    function PrePareTobFromBase:boolean;
    function PrepareTopAvarSit: boolean;
    function PreparePalLikv():boolean;
  public
    { Public declarations }
    function prePareDsets():boolean;

    property ShiftDate:TDate read F_ShiftDate write F_ShiftDate ;

    property vsego:integer read f_vsego;
    property postup:integer read F_postup;
    property likvid :integer read f_likv;
    property plan :integer read F_plan;
    property planbrig :integer read f_planbrig;
    property planExcav :integer read f_excav;
    function ExportFRToExcel(fr_rep: TfrReport;excel_file_name: string): boolean;
    function SaveAfterSend(file_name:string):boolean;
  end;
const
   SQL_AvarSit='select sdate, trim(FIELDNAME) FIELDNAME,FIELDVALUE from SvodAvarsit where Sdate between ''%s'' and  ''%s''';
   // Запланировано кол-во нарядов в которых выезды запланированы на смену
   SQL_Plan='select %s' +
            ' from departures dd join orders o on dd.fk_departures_orders=o.id '+
            '  where dd.planstartdate between ''%s'' and ''%s'' '+
            '   and o.fk_orders_damageplace in (1,2,24,31) '+ //вводы магистрали перекладка скрытая течь
            ' and(o.dateclosed is null or (o.dateclosed>dd.startdate) )';

   COUNT_ORDERS='count( distinct  dd.fk_departures_orders) mycount';
   // Кол-во раб-щих бригадиров кол-во разніх ,ригадиров запланированніх на пред смену
   count_brigs ='count( distinct  dd.fk_departures_brigadiers) mycount';

 //    #Дополнительно к плану работ# наряды с адресом в которыз место повр скрытая тесь или перекладка сетей и есть выезд с датой плана
   SQL_SelTable = ' select distinct o.ordernumber, '+
                  ' (select trim(adres) from '+
                  ' get_adres(o.fk_orders_housetypes,o.fk_orders_streets, o.housenum,o.additionaladdress '+
                  ' )) adres, '+
                  ' substr((name),1,1)||substr(lower(name),2,19) region, '+
                  ' o.fk_orders_damageplace '+
                  '  from orders o join departures dd on dd.fk_departures_orders=o.id '+
                  '  join s_regions  sr on sr.id=o.fk_orders_regions '+
                  ' where dd.planstartdate>''%s'' and dd.planenddate<''%s'' '+
                  ' and o.fk_orders_damageplace in (31,24)'+// --перекладка скрытая течь '+
                  ' and(o.dateclosed is null or (o.dateclosed>dd.startdate) ) '+
                  ' order by  dd.startdate ' ;
     SQL_SeLTableplan=' select distinct o.ordernumber, '+
                  ' (select trim(adres) from '+
                  ' get_adres(o.fk_orders_housetypes,o.fk_orders_streets, o.housenum,o.additionaladdress '+
                  ' )) adres, '+
                  ' substr((name),1,1)||substr(lower(name),2,19) region, '+
                  ' o.fk_orders_damageplace '+
                  '  from orders o join departures dd on dd.fk_departures_orders=o.id '+
                  '  join s_regions  sr on sr.id=o.fk_orders_regions '+
                  ' where dd.ENDDATE>''%s'' and dd.ENDDATE<''%s'' '+
                  ' and o.fk_orders_damageplace in (31,24)'+// --перекладка скрытая течь '+
                  ' and( (o.dateclosed>dd.startdate) ) '+
                  ' order by  dd.startdate ';
     SQL_SELEXCAV='select val from Svod_plan_Equip se where saveddate=''%s'' and field=''Excav'' ';


  nar='Наряд №';
  region=' район' ;

var
  dm_ReportAll1: Tdm_ReportAll1;

implementation

{$R *.dfm}

{ Tdm_ReportAll1 }
uses HelpFunctions,GlobalData,frOLEExl;

function Tdm_ReportAll1.ExportFRToExcel(fr_rep: TfrReport;
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
                                'Отчет Харьковводоканал', MB_OK+MB_ICONERROR);
    end;
  end;

end;

function Tdm_ReportAll1.prePareDsets: boolean;
begin
 result:=false;
 try
  if PrepareTopAvarSit then
    if  PrePareTobFromBase then
      if PreparePalLikv then
        result:=true;
  except on e:exception do
   begin
    if not result then
       Application.MessageBox('Отчет не сформирован!!','',MB_OK);
   end;
  end;
end;

function Tdm_ReportAll1.PreparePalLikv: boolean;
var dt1, dt2:string;
 procedure ConVertToMem(mem:TRxMemoryData);
 var resStr,reg:string;
 begin
 if mem.Active then mem.Close;
 mem.Open;
  if dset.Active then
  begin
   dset.First;
   while not dset.Eof do
   begin
    mem.Append;
    resStr:=nar;
    resStr:=resStr+dset.fieldByName('ordernumber').AsString+' '+
    trim(dset.fieldbyname('adres').AsString)+' '+'(';
    reg:=LowerCase(Trim(dset.fieldbyname('region').AsString));
    reg[1]:=UpperCase(String(reg[1]))[1];
    resStr:=resStr+reg+region;
    case dset.FieldByName('fk_orders_damageplace').AsInteger of
      31: resStr:=resStr+') скрытая течь';
      24: resStr:=resStr+') перекладка';
    end;
    mem.FieldByName('result').AsString:=resStr;
    mem.Post;
    dset.Next;

   end;

  end;
 end;
begin
dt1:=DateToStr(F_ShiftDate)+' '+g_ShiftStartTime;
dt2:=DateToStr(F_ShiftDate+1)+' '+g_ShiftStartTime ;
result:=false;
try
 MyOpenIBDS(dset,Format(SQL_SelTable,[dt1,dt2]));
 ConVertToMem(rm_Plan);
 dset.Close;
 dt1:=DateToStr(F_ShiftDate-1)+' '+g_ShiftStartTime;
 dt2:=DateToStr(F_ShiftDate)+' '+g_ShiftStartTime ;
 MyOpenIBDS(dset,Format(SQL_SeLTablePlan,[dt1,dt2]));
 ConVertToMem(rm_PlanTwo);
 dset.Close;
 result:=true;
except on e:Exception do begin
  Application.MessageBox(PChar(e.Message),'');
  result:=false;
 end;
end;
end;

function Tdm_ReportAll1.PrePareTobFromBase: boolean;
var date1, date2:String;
begin
  date1:=DateToStr(F_ShiftDate) +' '+g_ShiftStartTime ;

  date2:=DateToStr(F_ShiftDate+1)+' '+g_ShiftStartTime ;
  try
    MyOpenIBDS(dset,Format(SQL_Plan,[count_orders,date1,date2]));
    dset.First;
    F_plan:=dset.fieldbyname('mycount').AsInteger;
    dset.Close;

    MyOpenIBDS(dset,Format(SQL_Plan,[count_brigs,date1,date2]));
    dset.First;
    F_planBrig:=dset.fieldbyname('mycount').AsInteger    ;
    dset.Close;

    MyOpenIBDS(dset,Format(SQL_SELEXCAV,[DateToStr(F_ShiftDate)]));
    dset.First;
    F_Excav:=dset.fieldbyname('val').AsInteger    ;
    dset.Close;

    result:=true;
  except
  if tran.Active then
   tran.Rollback;

  end;
end;


function Tdm_ReportAll1.PrepareTopAvarSit: boolean;
var v: Variant;
begin
 try
  MyOpenIBDS(dset,Format(SQL_AvarSit,[DateToStr(F_ShiftDate-1),DateToStr(F_ShiftDate)]));
  dset.First;

  begin
    try
    v:=dset.Lookup('FIELDNAME;sdate',VarArrayOf(['vsego',F_ShiftDate]),'FIELDValue');

    f_vsego:=VarToInteger(v);

    v:=dset.Lookup('FIELDNAME;sdate',VarArrayOf(['postup',F_ShiftDate-1]),'FIELDValue');
    f_postup:=VarToInteger(v);
    v:=dset.Lookup('FIELDNAME;sdate',VarArrayOf(['vipoln',F_ShiftDate-1]),'FIELDValue');
    f_likv:=VarToInteger(v);
    dset.Close;
    result:=true;
    except on e:EVariantError do begin
      result:=false;
      //Application.ShowMessage('Format Error!!');
      dset.Close;
      end;
    end;
  end;
 except
   result:=false;
 end;

end;

function Tdm_ReportAll1.SaveAfterSend(file_name: string): boolean;
var s:string;
begin
 Result:=false;
  try

   if  tran.InTransaction then
    tran.Rollback;
   tran.StartTransaction;
   IBSQL_inst.SQL.Text:='update SENTSVEMAIL set file_name='''+file_name +''' where id=6';
   IBSQL_inst.exeCQuery;
   tran.Commit;
  Result:=true;
  except
   if tran.InTransaction then
    tran.Rollback;
  end;
end;

end.
