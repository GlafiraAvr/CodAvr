unit VeiwSent1562DModule;

interface

uses
  SysUtils, Classes, IBDatabase, kbmMemTable, DB, IBCustomDataSet,Forms,Windows,
  ADODB,DModule, IBSQL,GlobalData, Variants;

type
   systems=(ns,vds);
   from=(_1562,tel,Och);
   typ_Form =(before_Closed,default);

  Tdm_Closed1562View = class(TDataModule)
    dset: TIBDataSet;
    mt_table: TkbmMemTable;
    IBTran: TIBTransaction;
    mt_tableid: TIntegerField;
    ADOQry: TADOQuery;
    mt_tableour_number: TIntegerField;
    mt_tableabpnenet: TStringField;
    mt_tablephone: TStringField;
    mt_tableRegion: TStringField;
    mt_tableadress: TStringField;
    mt_tableabour: TStringField;
    mt_tablechek: TBooleanField;
    mt_tablenumber: TIntegerField;
    mt_tableopened: TStringField;
    mt_tableopened_typ: TIntegerField;
    IBSQL: TIBSQL;
    dset_ClosedInfo: TIBDataSet;
    mt_tableid_officials: TIntegerField;
    mt_tableis_phome: TBooleanField;
    mt_tableadd_excav: TBooleanField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    F_table:string;
    F_typ:systems;
    F_orderID:integer;
    F_List_1562:TStringList;
    F_List_tel:TStringList;
    F_List_och:TStringList;
    F_ClosedInfo:string;

    F_excav:boolean;//27.11.2013 с раскопкой для заявок с раскопками при закр наряда такие заявки не закрываем закр отдельно!
    F_caprem:boolean; //14.07.2014  в кап ремонт
    procedure SetTyp(typ:systems);
    function setClosedInfo():string;
  public
    { Public declarations }
      F_typForm:typ_Form;
    function PrepareData(F_order:integer;typ:systems;_Excav:boolean=false):integer;
    procedure DoSent();
    function FindId(number:integer;year:integer):boolean;
    property List_1562:TStringList read F_List_1562 write F_List_1562;
    property List_tel:TStringList read F_List_tel write F_List_tel;
    property List_Och:TStringList read F_List_Och write F_List_Och;
    procedure SetClose(From:From; id_dep: integer=-1);
    property Typ:systems write SetTyp;
    procedure CommitAll;
    property CloseInfo:string read F_ClosedInfo;
     function SetPhone():integer; {1-Разрешить закрытие 0 нет} //glasha 04.03.2013
     property OrderID:integer write F_orderID;
    public
     ExccavInfo:string;
     function getClosed_List:string;
	 property Excav:boolean write F_excav;
   property CapRem:boolean write   F_caprem;


end;
const dset_SEL_SQL ='select ns.id, ns.id_order, ns.number, ns.date_our_request, '+
                    ' ns.id_1562, ns.number_our_request, ns.date_recive_request,'+
                    ' ns.recived_from, ns.id_officials, ns.dateprin, '+
                    ' ns.why_not, ns.add_info, so.name disp'+
                    ' from numsorders ns '+
                    ' join s_officials so on so.id=ns.id_officials'+
                    'where ns.date_our_request>:d1 and ns.date_our_request<:d2';


var
  DataModule  : Tdm_Closed1562View;

implementation

{$R *.dfm}


procedure Tdm_Closed1562View.DataModuleDestroy(Sender: TObject);
begin
 if mt_table.Active then
   mt_table.Close;
 if dset.Active then dset.Close;
end;

function Tdm_Closed1562View.setClosedInfo():string;
 function isadd_Excav():integer;
 begin
  if F_excav then
    result:=1
  else
    result:=0;


 end;
var int_typ:integer;
begin
case F_typ of
 ns: int_typ:=0;
 vds: int_typ:=1;
end;
  dset_ClosedInfo.SelectSQL.Text:=Format('select about from SENTTO_1562_1(%d,%d)',
  [F_OrderID,int_typ,isadd_Excav]);
  dset_ClosedInfo.Open;
  f_ClosedInfo:=dset_ClosedInfo.fieldbyname('about').AsString;
  dset_ClosedInfo.Close;
end;

function Tdm_Closed1562View.PrepareData(F_order:integer;typ:systems;_Excav:boolean):integer;

 function formAdress(val:string;add_str:string=''):string;
 begin
  Result:='';
  if trim(val)<>'' then
   Result:=Result+add_str+trim(val)+' ';
 end;

 function  checkexcav():string;
 begin
 if  F_typ=vds then
 begin
  result:='';
  exit;
 end;

  if F_excav then
   Result:=' and add_excav=1'
  else
   if F_typForm=before_Closed then
      result:=' and  add_excav is null'
    else
       result:='';//;add_excav is null';
 end;
 function addexc():string ;
 begin
  if F_typ=vds then
 begin
  result:='0';
  exit;
 end
 else result:='';
 end;

 function add_Cap_rem:string;
 begin
 result :='';
 if typ=ns then
  if f_caprem then
   result :=  ' and number>0 ';
 end;

 function add_Cap_remMsSQL:string;
 begin
 result :='';
 if typ=ns then
  if f_caprem then
   result :=  'and NumberReceivedRequest > 0';
 end;

var sel_SQL,sel_msSQL,id_1562:string;

   //  ts:integer;
     about:string;
     V:variant;

begin
//  typ:=ns;
  f_orderId:=F_order;
Result:=0;
 F_typ:=typ;
 F_excav:=_Excav;
 sel_msSQL:='select id, NumberReceivedRequest  number_1562, '+
               ' [NumberOurRequest] our_number, '+
               ' [abonent], '+
               ' [phone], '+
               ' [rayon_name] Region,'+
               ' [s_types_name] str_type,'+
               ' [name_street] street,'+
               ' [HOUSE] ,'+
               ' [APPARTMENT],'+
               ' [NumberFloor], '+
               ' [Podesd], ' +
               ' [about],'+
               ' [opened]'+
               ' from DateTime_KhNew_Select_vw where id in (%s)  and state=1 ';
  sel_SQL:=format('select id_1562 ,number number_1562,number_our_request our_number, '+
            'abonent,phone,adress,about,RECIVED_FROM opened,ID_OFFICIALS_PHONED id_officials,'+
            ' %s add_excav   from ',[addexc()]);
 case F_typ of
  ns: begin
       sel_SQL:=sel_SQL+Format('numsorders where id_order=%d and state_inner=1  %s %s order by 1',[F_order,checkexcav, add_Cap_rem]);
      end;
  vds:sel_SQL:=sel_SQL+Format('numsorders_vds where id_order=%d and state_inner=1  %s order by 1',[F_order,checkexcav]);
 end;
 try

   dset.SelectSQL.Text:=sel_SQL;
   dset.Open;
   dset.First ;
   id_1562:='';
   if mt_table.Active then
     mt_table.Close;
   mt_table.Open;
   while  not dset.Eof do
   begin
    with mt_table do begin
    Append;

    Fieldbyname('id').AsInteger:=dset.fieldbyname('id_1562').AsInteger;
    Fieldbyname('about').AsString:=trim(dset.fieldbyname('about').AsString);
    Fieldbyname('number').AsString:=trim(dset.fieldbyname('number_1562').AsString);
    Fieldbyname('opened').AsString:=trim(dset.fieldbyname('opened').AsString);
    Fieldbyname('our_number').AsString:=dset.fieldbyname('our_number').AsString;
    Fieldbyname('add_excav').AsBoolean:=(dset.fieldbyname('add_excav').AsInteger=1);
    end;
    if length(trim(dset.FieldByName('our_number').AsString))>0 then
    begin
      with mt_table do begin

        Fieldbyname('abonent').Asstring:=trim(dset.fieldbyname('abonent').asstring);
        Fieldbyname('phone').AsString:=trim(dset.fieldbyname('phone').asstring);
        Fieldbyname('adress').AsString:=trim(dset.fieldbyname('adress').AsString);

      end;
    end
    else
      id_1562:=id_1562+','+dset.fieldbyname('id_1562').AsString;
    mt_table.Fieldbyname('id_officials').AsInteger:=dset.fieldbyname('id_officials').Asinteger;
    mt_table.Fieldbyname('chek').AsBoolean:= dset.Fieldbyname('id_officials').AsInteger>0;
    dset.Next;
    mt_table.Post;
   end;
   delete(id_1562,1,1);
 if  not dset.IsEmpty then
  if not F_Excav then
     setClosedInfo();



 except on e:exception do
 begin
  e.Message:='не открылось  dset FierBird'+#13+e.Message;
   raise e;
   exit;
 end;
 end;

 if (dset.IsEmpty)or (trim(id_1562)='' )  then
 else
 try
   mt_table.First;
   ADOQry.SQL.Text:=Format(sel_msSQL,[id_1562]);
   ADOQry.Open;
   ADOQry.First;
   while  not mt_table.Eof do
    begin
     while ( not mt_table.FieldByName('number').IsNull)and( not mt_table.Eof) do
     begin
       mt_table.Next;

     end;
     if mt_table.Eof then break;


   //while not ADOQry.Eof do
     mt_table.Edit;
    // mt_table.FieldByName('id').AsInteger:=ADOQry.FieldByName('id').asinteger;
     ADOQry.Locate('id',mt_table.FieldByName('id').asstring,[loCaseInsensitive]	);
     mt_table.FieldByName('our_number').AsInteger:=ADOQry.FieldByName('our_number').asinteger;
     mt_table.FieldByName('number').AsInteger:=ADOQry.FieldByName('number_1562').asinteger;
     mt_table.FieldByName('abonent').AsString:=ADOQry.FieldByName('abonent').asstring;
     mt_table.FieldByName('phone').AsString:=ADOQry.FieldByName('phone').asstring;
     mt_table.FieldbyName('Region').AsString:=ADOQry.FieldByName('Region').asstring;

     mt_table.FieldByName('opened').AsString:=ADOQry.FieldByName('opened').asstring;
     about:='';
     with  ADOQry do begin
      about:=about+formAdress(FieldByName('str_type').AsString);
      about:=about+formAdress(FieldByName('street').AsString);
      about:=about+formAdress(FieldByName('HOUSE').AsString ,'д.');
      about:=about+formAdress(FieldByName('APPARTMENT').AsString, 'кв.');
      about:=about+formAdress(FieldByName('Podesd').AsString, 'под.');
      about:=about+formAdress(FieldByName('NumberFloor').AsString, 'эт.');

     end;
     mt_table.FieldByName('adress').AsString:=about;
     mt_table.FieldByName('about').AsString:=ADOQry.fieldByname('about').AsString;
   //  V:=dset.Lookup('id_1562',VarArrayOf([ mt_table.FieldByName('id').AsInteger]),'ID_OFFICIALS_phonED'); //glasha 04.03.2013
    { if not (VarType(V) in [varNull]) then
       begin
        mt_table.FieldByName('id_officials').asinteger:=V;
        if V>0 then
        mt_table.FieldByName('chek').AsBoolean:=true;
       end
     else
       begin
        mt_table.FieldByName('id_officials').asinteger:=0;
        mt_table.FieldByName('chek').AsBoolean:=false;
       end;
     }
  //   mt_table.FieldByName('chek').AsBoolean:=false;
     mt_table.Post;
     AdoQry.Next;

   end;

 except  on e:exception do
  begin
  e.Message:='не открылось  dset'+#13+e.Message;
   raise e;
   exit;
  end;
 end;
 Result:=mt_table.RecordCount;

end;

procedure   Tdm_Closed1562View.DoSent();
var s:string;
begin
 if not assigned(F_List_1562) then
    F_List_1562:=TStringList.Create;
 if not assigned(F_List_tel) then
    F_List_tel:=TStringList.Create;
  if not assigned(F_List_och) then
    F_List_och:=TStringList.Create;
    F_List_1562.Clear;
    F_List_tel.Clear;
    F_List_Och.Clear;
 with mt_table do begin
  First;
  while not Eof do begin
  if F_caprem then
  begin
   if  (FieldByName('number').AsInteger>0)  then
     if (FieldByName('Chek').AsBoolean) then
        F_List_1562.Add(Fieldbyname('id').AsString);
  end
  else
  if (FieldByName('Chek').AsBoolean) or( F_typForm=before_Closed) then
   begin
   if F_excav=FieldByName('add_excav').AsBoolean then
   begin
    if trim(FieldByName('opened').AsString)='1562' then
        F_List_1562.Add(Fieldbyname('id').AsString);
    if not F_caprem then
    begin
    if trim(FieldByName('opened').AsString)='По телефону' then
      F_List_tel.Add(Fieldbyname('id').AsString);
    if trim(FieldByName('opened').AsString)='Очиствод' then
      F_List_Och.Add(Fieldbyname('id').AsString)
    end;
    {s:=Format('Отправим заявку № %s id=%s',[Fieldbyname('our_number').AsString,Fieldbyname('id').AsString]);
    Application.MessageBox(PAnsiChar(s),'Информация',mb_Ok);}
   end;
   end;
   Next;
  end;
 end;
end;

function Tdm_Closed1562View.FindId(number:integer;year:integer):boolean;
begin
Result:=false;
try
 dset.SelectSQL.Text:=Format('select id from orders where ordernumber=%d and datecoming>=''01.01.%d''',[number,year]);
 dset.Open;
 if  not dset.fieldbyname('id').IsNull then
 begin
  f_orderID:=dset.fieldbyname('id').AsInteger;
   Result:=true;
 end
 else
  begin
    Application.MessageBox('Наряда с таким номером нет!!','Error',MB_OK);
    REsult:=false;
  end
except on e:exception do begin
 Raise e;
 exit;
 end;
end;

end;

procedure Tdm_Closed1562View.SetClose(From:From;  id_dep: integer=-1);
function strClosedDep():string ;
begin
 result := '';
 if F_caprem then
 if  id_dep>0 then
   case  F_typ of
    ns: result :=Format( 'update departures set closedcaprem=1 where id=%d',[id_dep]);
    vds:result := '';
  end;

end;

 function getdep():string;
 begin


  if id_dep>0 then
   Result:=' , fk_id_dep='+IntTOStr(id_dep)
  else
   Result:='';

 end;
const UPD_SQL='update %s set state_inner=3 , state_outer=1,'+
' id_Officials_Closed=%d, DateClosed=''%s'' %s where id_1562 in(%s)';
var List:TStringList;
    i:integer;
    s:string;
    sql:string;
begin
case From of
 _1562:List:=F_List_1562;
 tel:List:=F_List_tel;
 Och:List:=F_List_och;
end;
 s:='';
 for i:=0 to List.Count-1 do
  s:=s+','+List[i];
 delete(s,1,1);
 try
 if trim(s)<>'' then
 begin
  if  not IBTran.InTransaction then
       IBTran.StartTransaction;
  IBSQL.SQL.Text:=Format(UPD_SQL,[F_table,g_IDOfficial,DateTimeToStr(Now()),getdep,s]);
  IBSQL.ExecQuery;
  sql:= strClosedDep();
  if sql<>'' then
    begin
     IBSQL.SQL.Text:=sql;
     IBSQL.ExecQuery;
    end;
 end;
 except on e:exception do
 begin
   IBTran.Rollback;
   E.Message:='Не прошла запиcь в нашу базу при закрытии заявок! '+#13+E.Message;
   Raise e;
 end;
 end;
end;

procedure Tdm_Closed1562View.SetTyp(typ:systems);
begin
  F_typ:=typ;
  case  typ of
    ns:F_table:='numsorders';
    vds:F_table:='numsorders_vds';
  end;
end;

procedure Tdm_Closed1562View.CommitAll;
begin
 if IBTran.InTransaction then
   IBTran.Commit;
end;

procedure Tdm_Closed1562View.DataModuleCreate(Sender: TObject);
begin
F_typForm:=default;
F_caprem:=false;
end;

function Tdm_Closed1562View.SetPhone():integer; {1-Разрешить закрытие 0 нет} //glasha 04.03.2013
var SQL:string;
begin

SQL:=Format('update %s set ID_OFFICIALS_phonED=%d where id_1562=:id',[F_table,g_IDOfficial]);
 iBSQL.SQL.Text:=SQL;
 Result:=1;
try
try
 if  not IBTran.InTransaction then
       IBTran.StartTransaction;

mt_table.First;
while not mt_table.Eof do
 begin
  if (length(trim(mt_table.FieldByName('our_number').AsString))>=1) and (mt_table.FieldByName('id').AsInteger>0)   then
   if  not mt_table.FieldByName('chek').AsBoolean then
   begin
    if not F_caprem then
    Result:=0;
   end
   else
   begin
     IBSQL.ParamByName('id').AsInteger:=mt_table.fieldByName('id').AsInteger;
     IBSQL.ExecQuery;
   end;
   mt_table.Next;
 end;

except
Result:=-1;
if IBTran.InTransaction then
IBTran.Rollback;
end;
finally
 if IBTran.InTransaction then
  IBTran.Commit;
end;

end;


function Tdm_Closed1562View.getClosed_List:string;
var str:string;
begin
 str:='';
 if not F_excav then
	dset.SelectSQL.Text:='select id_1562 from '+F_table+' where id_order='+IntTOStr(F_orderID)+
                      ' and state_inner=1 and add_excav is null '
 else
	dset.SelectSQL.Text:='select id_1562 from '+F_table+' where id_order='+IntTOStr(F_orderID)+
                      ' and state_inner=1 and add_excav =1 ';
 dset.Open;
 dset.First;
 while not dset.Eof do
 begin
  str:=','+dset.fieldbyname('id_1562').asstring;
  dset.next;
 end;
 if str<>'' then
 delete (str,1,1);
  result:=str;
end;

end.
