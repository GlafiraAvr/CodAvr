unit SvPoZayvkamDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, IBCustomDataSet, DB,
  RxMemDS, IBDatabase, ADODB, FR_DSet, FR_DBSet;

type
  TZavtyp=(notprin, prin, all);
  TOrderType = (otAll, otOpen, otClose);


  Tdm_SvPoZayvkam = class(Tdm_NGReportBase)
    md_result: TRxMemoryData;
    md_resultid_1562: TIntegerField;
    md_resultnumber: TStringField;
    md_resultDateOurRequest: TStringField;
    md_resultadress: TStringField;
    md_resultabout: TStringField;
    md_resultwhy_not: TStringField;
    md_resultBrigname: TStringField;
    dset: TIBDataSet;
    md_resultregion: TStringField;
    md_resultid_region: TIntegerField;
    md_resultid_order: TIntegerField;
    tran: TIBTransaction;
    dset_region: TIBDataSet;
    md_resultgroup: TIntegerField;
    ADOQ_work: TADOQuery;
    md_resultordernumber: TStringField;
    md_resultdopfield: TIntegerField;
    dset_regionID: TIntegerField;
    dset_regionNAME: TIBStringField;
    frDBDataSet1: TfrDBDataSet;
  private
    { Private declarations }
    Regname:string;
    F_DateBeg,F_DateEnd:TDateTime;
    F_ID_Region:integer;
    F_TypeZ:integer;
    F_sort_type:integer; //0-подате 1 - по адоресам
    {0 Все
    1-Не привязанные
    2-Привязанные
    3-Не выполненные
    4-Выполненные
    5-Не вып по благ.
    6-Выполнен. по благ.
    7 Не вып авар по благ
    8 Нужно вернуть в кап ремонт
    }
    F_TypeNar:TOrderType;

    procedure SetRegion(id_reg:integer);
    procedure FromFB(id_reg:integer;FB_Cond:string);
    procedure FromMsSQL(id_reg:integer; MS_Cond:string);
    procedure OpenMsSQL(id_reg:integer; MS_Cond:string);
  public
    { Public declarations }
      F_KolZayav:integer;
    function prepareDsets():boolean;
    property _DateBeg:TDateTime write  F_DateBeg;
    property _DateEnd:TDateTime write   F_DateEnd;
    property ID_region:integer write F_ID_Region;
    property _TypeZ:integer write F_TypeZ;
    property _TypeNar:TOrderType write F_TypeNar;
    property _sort_type:integer write f_sort_type; //0-подате 1 - по адоресам
    property KolZayav:integer read F_KolZayav;
  end;

const SELMS='SELECT [ID] id_1562 '+
     '  ,[NumberOurRequest], [NumberReceivedRequest] number,'+
     '   [DateOurRequest] '+
     ' ,[HOUSE] '+
     ' ,[APPARTMENT]'+
     ' ,[NumberFloor]'+
     ' ,[Podesd]'+
     ' ,[about]'+
     ' ,[Appurtenance]'+
     ' ,[state]'+
     ' ,[id_rayon]'+
     ' ,[name_street]'+
     '  ,[s_types_name]'+
     ' ,[name_street]+[s_types_name] '+
     '  FROM [avr_vs_request].[dbo].[DateTime_KhNew_Select_vw]  where ';

var
  dm_SvPoZayvkam: Tdm_SvPoZayvkam;

implementation

{$R *.dfm}
uses HelpFunctions;

function  Tdm_SvPoZayvkam.prepareDsets:boolean;
var _progress_shag:integer;
    is_connectMsSql:boolean;
begin
if dm_main.ADOConn_1562.Connected then
   is_connectMsSql:=true
else
  begin
   dm_main.ADOConn_1562.Connected:=true;
   is_connectMsSql:=false;
  end;
with md_result do begin
  if Active then Close;
  Open;
end;
 try
  F_KolZayav:=0;
  if tran.Active then tran.Rollback;
  tran.StartTransaction;
  dset_region.Open;
  if F_ID_Region>0 then
  begin
    _progress_shag := GetProgressShagLength( 100, dset_Region.RecordCount );


    dset_region.Locate('id',F_ID_Region,[loCaseInsensitive]) ;
    Regname:=dset_region.fieldbyname('name').AsString;
    SetRegion(F_ID_Region);
    IncProgressStatus( _progress_shag );
   end
  else
  begin
    dset_region.Last;
     _progress_shag := GetProgressShagLength( 100, dset_Region.RecordCount );
    dset_region.First;

   while not dset_region.Eof do
   begin
     Regname:=dset_region.fieldbyname('name').AsString;
     SetRegion(dset_region.fieldbyname('id').asinteger);

     dset_region.Next;
     IncProgressStatus( _progress_shag );
   end;
   dset_region.Close;
  end;
  finally
   tran.Commit;
   if  not is_connectMsSql then
      dm_main.ADOConn_1562.Connected:=false;
 end;
  REsult:=true;

end;


procedure  Tdm_SvPoZayvkam.SetRegion(id_reg:integer);

var FB_Cond,MSSQL_Cond:string;
begin
 FB_Cond:=Format('ns.date_our_request >= ''%s'' and ns.date_our_request<''%s'' and  ns.id_region=%d',
  //можно добавить сотировку
 [FormatDateTime('dd.mm.yyyy hh:mm',F_DateBeg),FormatDateTime('dd.mm.yyyy hh:mm',F_DateEnd),id_reg]);
   MSSQL_Cond:=Format(' [DateOurRequest] between ''%s'' and  ''%s'' and [id_rayon]=%d and [Appurtenance]=2 ',
        [FormatDateTime('mm.dd.yyy hh:mm',F_DateBeg),FormatDateTime('mm.dd.yyy hh:mm',F_DateEnd),id_reg]);

  case  F_TypeZ of
      1 : begin FB_Cond:=FB_Cond+' and ns.id_order is null'; //Не привязанные
                MSSQL_Cond:=MSSQL_Cond+' and  [state]=0';
          end;
      3: FB_Cond:=FB_Cond+' and ns.state_inner=1 ';//Не выполненные
      4: FB_Cond:=FB_Cond+' and ns.state_inner>=2 ';//Выполненные
      5: FB_Cond:=FB_Cond+' and ns.ADD_EXCAV=1 and  ns.state_inner=1';//Не выполненные по благоустройству
      6: FB_Cond:=FB_Cond+' and ns.ADD_EXCAV=1 and  ns.state_inner>=2';// выполненные по благоустройству
      7: FB_Cond:=FB_Cond+' and ns.ADD_EXCAV=1 and  ns.state_inner=1 and trim(STATE_AVAR)=''A'' ';// выполненные по благоустройству аварийные
      8: FB_Cond:=FB_Cond+' and F_state_excav=3 '//  Нужно вернуть в кап ремонт
  end;
  if F_TypeZ>=2  then ///('Привязанные, Выполненные, Не выполненные')
   case F_TypeNar of
   // otAll :
    otOpen: FB_Cond:=FB_Cond + 'and o.isclosed=0 ';
    otClose: FB_Cond:=FB_Cond + 'and o.isclosed=1 ';
   end;
  //сортировка
  case f_sort_type of
  0:  MSSQL_Cond := MSSQL_Cond +'  order by 4';   //дата
  1:  MSSQL_Cond := MSSQL_Cond +'  order by 14'; //название улицы
  end;

  OpenMsSQL(id_reg, MSSQL_Cond);
  FromFB(id_reg,FB_Cond);

  if F_TypeZ<2 then  // Все; Не привязанные
  begin
    FromMsSQL(id_reg,MSSQL_Cond);
  end;
 if ADOQ_work.Active then ADOQ_work.Close;
end;


procedure Tdm_SvPoZayvkam.FromFB(id_reg:integer;FB_Cond:string);

 const FB_SelectAll='select ns.id_1562,ns.date_our_request, '+
                ' ns.number, ns.number_our_request,ns.dateprin, '+
                ' ns.adress, ns.id_region,ns.why_not, o.ordernumber, '+
                '  b.name brigname, ns.id_region, ns.about, o.id id_order '+
                ' from numsorders ns '+
                ' left join orders o on o.id=ns.id_order '+
                ' left join brigadiers b on b.id=ns.fk_brig where ';
       FB_SelectPriv='select ns.id_1562,ns.date_our_request, '+
                ' ns.number, ns.number_our_request,ns.dateprin, '+
                ' ns.adress, ns.id_region,ns.why_not, o.ordernumber, '+
                ' (select  b.name from brigadiers b where b.id=ns.fk_brig)   brigname,'+
                ' ns.id_region, ns.about, o.id id_order '+
                ' from numsorders ns '+
                ' inner join orders o on o.id=ns.id_order '+
                ' where ';
       FB_Selectnot='select ns.id_1562,ns.date_our_request, '+
                ' ns.number, ns.number_our_request,ns.dateprin, '+
                ' ns.adress, ns.id_region,ns.why_not, '''' ordernumber, '+
                ' (select  b.name from brigadiers b where b.id=ns.fk_brig)   brigname,'+
                ' ns.id_region, ns.about, -1 id_order '+
                ' from numsorders ns '+
                ' where ';
  function correctAdres(adres:string):string;
   var p1,part2:string;
   p_:integer;

  begin
    p_:=pos(' ',adres);
   p1:=copy(adres,1,p_-1);
   part2:=copy(adres,p_+1,length(adres));
   if pos(p1,part2)>0 then
    delete(adres,1,p_);
   result:=adres;
  end;


  var str:string;

begin
case F_TypeZ of
 0: str:=FB_SelectAll+FB_Cond;//Все
 1: str:=FB_Selectnot+FB_Cond; // Не привязанные
 2,3,4: str:=FB_SelectPriv+FB_Cond;  //Привязанные Выполненые Невыполненные
 else
  str:=FB_SelectAll+FB_Cond;
 end;

 case f_Sort_type of
 0: str:=str+' order by 2'; //по дате
 1: str:=str+' order by 6'; //адрес
 end;

 if dset.Active then dset.Close;

 MyOpenIBDS(dset,str);
 dset.First;
 with dset do begin
  while not dset.Eof do
  begin
   if ADOQ_work.Locate('id_1562',dset.fieldbyname('id_1562').AsInteger,[loCaseInsensitive]) then
   begin
   md_REsult.Append;

   md_result.FieldByName('id_1562').AsInteger:=fieldbyname('id_1562').AsInteger;
   md_Result.FieldByName('number').AsString:=fieldbyname('number_our_request').AsString+#13+'('+fieldbyname('number').AsString+')';
   md_Result.FieldByName('DateOurREquest').AsString:=FormatDateTime('dd.mm.yyyy hh:mm',fieldbyname('date_our_request').AsDateTime);
   md_Result.FieldByName('about').AsString:=fieldbyname('about').AsString;
   md_Result.FieldByName('why_not').AsString:=fieldbyname('why_not').AsString;
   md_Result.FieldByName('BrigName').AsString:=fieldbyname('brigname').AsString;
   md_Result.FieldByName('region').AsString:= Regname;
   md_Result.FieldByName('id_region').AsInteger:=id_reg;
   md_Result.FieldByName('order_number').AsString:=fieldbyname('ordernumber').AsString;
   md_Result.FieldByName('group').AsInteger:=0;
   md_Result.FieldByName('dopField').AsInteger:=0;
   md_Result.FieldByName('adress').AsString:=correctAdres(fieldbyname('adress').AsString);
   md_Result.FieldByName('id_order').AsInteger:=fieldbyname('id_order').AsInteger;
   inc(F_KolZayav);
   md_result.Post;
   end;
   Next;
  end;
  Close;
 end;
end;

procedure Tdm_SvPoZayvkam.OpenMsSQL(id_reg:integer; MS_Cond:string);
var str:string;
begin
 str:=SelMS+MS_Cond;
 if ADOQ_work.Active then ADOQ_work.Close;
 ADOQ_work.SQL.Text:=str;
 ADOQ_work.Open;

end;

procedure Tdm_SvPoZayvkam.FromMsSQL(id_reg:integer; MS_Cond:string);
   function GetAdress():string;
     function AddEl(add,value:string):string;
      var v:string;
      begin
         v:=trim(value);
         if (v<>'') and (v<>'.') and (v<>',') and (v<>',') and (v<>'.')and (v<>'-') then
         Result:=add+' '+v;
      end;
   begin
   with  ADOQ_work do
    REsult:=AddEl('',Fieldbyname('s_types_name').AsString)+AddEl('',Fieldbyname('name_street').AsString)+
           AddEl('д.',Fieldbyname('HOUSE').AsString)+
           AddEl('кв.',Fieldbyname('APPARTMENT').AsString)+
           AddEl('под.',Fieldbyname('Podesd').AsString)+
           AddEl('эт.',Fieldbyname('NumberFloor').AsString);
   end;
  function AntiDouble(_id_1562:integer):boolean;
  begin
   if  not md_Result.Locate('id_1562',_id_1562,[loCaseInsensitive]) then
    REsult:=false
   else
   begin

     REsult:=true;
     if md_Result.FieldByName('adress').AsString='' then
      begin
        md_Result.Edit;
        md_result.FieldByName('adress').AsString:=GetAdress();
        md_result.FieldByName('about').AsString:=ADOQ_work.FieldByName('about').asstring;
        md_result.Post;
        md_result.Last;
      end
   end;

  end;
var str:string;
begin

 with ADOQ_work do
 begin
   first;
   while not EOF do
   begin
    if not AntiDouble(fieldbyname('id_1562').AsInteger) then
    if fieldbyname('state').AsInteger=0 then
    begin

     md_result.Append;


     md_result.FieldByName('number').AsString:=Fieldbyname('NumberOurRequest').AsString ;
     if not  Fieldbyname('number').IsNull then
      md_result.FieldByName('number').AsString:=md_result.FieldByName('number').AsString+#13+'('+
         Fieldbyname('number').AsString+')';
     md_result.FieldByName('DateOurRequest').AsString:=FormatDateTime('dd.mm.yyyy hh:mm', Fieldbyname('DateOurRequest').asDateTime);
     md_result.FieldByName('adress').AsString:=GetAdress();
     md_result.FieldByName('about').AsString:=Fieldbyname('about').AsString;
     md_result.FieldByName('region').AsString:=Regname;
     md_result.FieldByName('id_region').AsInteger:=id_reg;
     md_result.FieldByName('group').AsInteger:=1;
     md_result.FieldByName('dopfield').AsInteger:=0;
     md_result.Post;
     inc(F_KolZayav);
    end;
    Next;
   end;
  Close; 
 end;

end;


end.
