unit SaveSvGikXMLDModule;

interface

uses
  SysUtils, Classes, IBSQL, DB, IBCustomDataSet, IBDatabase,DModule,
  RxMemDS,HelpClasses,HelpFunctions;

type

 TDamageGroup=(dgLikvidVseti, dgLikvidVvody, dgUstanovLuk, dgPostupVseti,
                dgPostupVvody, dgPostupNetKrishekLukov);

  TDataForStDisp = record
    VodoSetiVsego, VvodyVsego, KolodtsyVsego, KolonkiVsego, LukovVsego,
    LikvidNaVodoSetyax, LikvidNaVvodax, UstanLukov,
    PostupNaVodoSetyax, PostupNaVvodax: integer;
    { Сводка ГИК }
    TechejIzZemli, TecheyIzKolodtsev, NeispravnyxKolonok: integer;
    UstanovlenoLukov: integer;
    { Сводка ликвидированых повреждений (вводы, магистрали) }
    Likvidirovano, IzNihZasypano, IzNihNeZasypano, Postupilo: integer;
    { сводная ведомость по разрытию }
    NeZasypanoPoGorodu_Vsego,
    NeZasypanoPoGorodu_Dzerzh, NeZasypanoPoGorodu_Komintern,
    NeZasypanoPoGorodu_Ordzhon, NeZasypanoPoGorodu_Kiev,
    NeZasypanoPoGorodu_Moskov, NeZasypanoPoGorodu_Frunz,
    NeZasypanoPoGorodu_Lenin, NeZasypanoPoGorodu_Oktjabr,
    NeZasypanoPoGorodu_Chervon: integer;
    { За сутки профработы, в которых установлены гидранты, и еще 3 буквы }
    UstanovlenoGidrantov: integer;
    { 3 значения: поступило 062, закрыто 062, осталось 062 }
    CountGet062, CountClose062, CountLeft062: integer;
  end;


  Tdm_saveSVGikXML = class(TDataModule)
    tran: TIBTransaction;
    dset: TIBDataSet;
    IBSQL: TIBSQL;
    dset_byregions: TIBDataSet;
    dset_bystreet: TIBDataSet;
    md_DmgByRegion: TRxMemoryData;
    md_DmgByStreet: TRxMemoryData;
    md_DmgByStreetgroup_number: TIntegerField;
    md_DmgByStreetcount: TIntegerField;
    md_DmgByRegionreg_name: TStringField;
    md_DmgByRegionvseti: TIntegerField;
    md_DmgByRegionvvody: TIntegerField;
    md_DmgByRegionkolodcy: TIntegerField;
    md_DmgByRegionkolonky: TIntegerField;
    md_DmgByRegionkanal: TIntegerField;
    md_DmgByRegionPodtopTepSetei: TIntegerField;
    md_DmgByRegionluk: TIntegerField;
    md_DmgByRegionNetLukov: TIntegerField;
    md_DmgByRegionid_reg: TIntegerField;
  private

    { Private declarations }
    F_DmgPlaceList, F_RegList: TNameContainer;
    F_DataForStDisp: TDataForStDisp;
    F_Dt:TDateTime;

    procedure FillDmgPlaceList;
    procedure FillRegList;
    function PrepareInfoForStDisp(percent: integer): boolean;
    function PrepareDmgByRegion(percent: integer): boolean;
    function AppendGroupToDmgByStreet(group: TDamageGroup;sel_sql: string {progress_shag: integer}): boolean;
    function PrepareDmgByStreet(percent: integer): boolean;
    procedure StDisp_Counts062;
  public
    { Public declarations }
  end;

var
  dm_saveSVGikXML: Tdm_saveSVGikXML;

implementation

{$R *.dfm}

procedure Tdm_saveSVGikXML.FillDmgPlaceList;
begin
  with F_DmgPlaceList do
  begin
    IDByName['vseti']:='1';             //Водопроводные сети
    IDByName['vvody']:='2';             //Вводы
    IDByName['kolodcy']:='3';           //Колодцы
    IDByName['kolonky']:='4';           //Колонки
    IDByName['kanal']:='10';            //Прох.канал
    IDByName['PodtopTepSetei']:='11';   //Подтоп.теп.сетей
    IDByName['luk']:='13';              //Установка люков
  end;
end;

procedure Tdm_saveSVGikXML.FillRegList;
begin
  with F_RegList do
  begin
    IDByName['dz']:='1';   //Дзержинский
    IDByName['ki']:='2';   //Киевский
    IDByName['ko']:='3';   //Коминтерновский
    IDByName['le']:='4';   //Ленинский
    IDByName['mo']:='5';   //Московский
    IDByName['ok']:='6';   //Октябрьский
    IDByName['or']:='7';   //Орджоникидзовский
    IDByName['fr']:='8';   //Фрунзенский
    IDByName['ch']:='9';   //Червонозаводский
  end;
end;


function Tdm_saveSVGikXML.PrepareInfoForStDisp(percent: integer): boolean;
const
  SHAG_COUNT=4;
var
  progress_shag, i: integer;
  ArrStDispProc: array [1..5] of procedure of object;
begin
  Result:=false;

  {Инициализация}
  with F_DataForStDisp do
  begin
    VodoSetiVsego:=0;
    VvodyVsego:=0;
    KolodtsyVsego:=0;
    KolonkiVsego:=0;
    LukovVsego:=0;
    LikvidNaVodoSetyax:=0;
    LikvidNaVvodax:=0;
    UstanLukov:=0;
    PostupNaVodoSetyax:=0;
    PostupNaVvodax:=0;
    //
    TechejIzZemli:=0;
    TecheyIzKolodtsev:=0;
    NeispravnyxKolonok:=0;
    UstanovlenoLukov:=0;
    Likvidirovano:=0;
    IzNihZasypano:=0;
    IzNihNeZasypano:=0;
    Postupilo:=0;
    NeZasypanoPoGorodu_Vsego:=0;
    NeZasypanoPoGorodu_Dzerzh:=0;
    NeZasypanoPoGorodu_Komintern:=0;
    NeZasypanoPoGorodu_Ordzhon:=0;
    NeZasypanoPoGorodu_Kiev:=0;
    NeZasypanoPoGorodu_Moskov:=0;
    NeZasypanoPoGorodu_Frunz:=0;
    NeZasypanoPoGorodu_Lenin:=0;
    NeZasypanoPoGorodu_Oktjabr:=0;
    NeZasypanoPoGorodu_Chervon:=0;
    UstanovlenoGidrantov:=0;
    CountGet062:=0;
    CountClose062:=0;
    CountLeft062:=0;
  end;
 { ArrStDispProc[1]:=StDisp_GikPart;
  ArrStDispProc[2]:=StDisp_KilledDmg;
  ArrStDispProc[3]:=StDisp_SvodVedExc;
  ArrStDispProc[4]:=StDisp_ProfWork;
  ArrStDispProc[5]:=StDisp_Counts062;}
  {/Инициализация}

  //progress_shag:=GetProgressShagLength(percent, SHAG_COUNT);

  for i:=low(ArrStDispProc) to High(ArrStDispProc) do
  begin
    ArrStDispProc[i];
//    IncProgressStatus(progress_shag);
 //   if F_IsStopProgress then exit;
  end;
    Result:=true;
end;


function Tdm_saveSVGikXML.PrepareDmgByRegion(percent: integer): boolean;
  function GetAddCond(dmg_name: string): string;
  begin
    if AnsiCompareText(dmg_name, 'luk')=0 then
    begin
// mv 16.08
//      Result:=
//        ' and (o.DateClosed>='''+DateToStr(F_Dt)+' 6:00:00'')'+
//        ' and (o.DateClosed<'''+DateToStr(F_Dt+1)+' 6:00:00'')';
 Result:=
        ' and (o.FACTDATECLOSED>='''+DateToStr(F_Dt)+' 06:00:01'')'+
        ' and (o.FACTDATECLOSED<='''+DateToStr(F_Dt+1)+' 06:00:00'')';
    end else Result:=' and (o.IsClosed=0)'
  end;

  function get_sel_sql(id_reg, dmg_name: string): string;
	var
		_s: string;
  begin

    if AnsiCompareText(dmg_name, 'luk')=0 then
		begin
      Result:=' select sum(HoodCount) kol';
      _s := ' and ((o.fk_orders_damageplace='+F_DmgPlaceList.IDByName[dmg_name]+') or (o.hoodcount>0)) ';
		end
    	else
		begin
			Result:=' select count(*) kol';
      _s := ' and (o.fk_orders_damageplace='+F_DmgPlaceList.IDByName[dmg_name]+')';
		end;

    Result:=Result+
      ' from orders o'+
      ' where'+
      ' (o.fk_orders_regions='+id_reg+')'+
      _s +
      GetAddCond(dmg_name);
  end;

  function get_net_lukov_sql( id_reg: string ): string;
  begin
    Result :=
      ' select sum(HoodCount) kol' +
      ' from orders' +
      ' where ( IsClosed = 0 ) and' +
      ' ( fk_orders_damageplace = ' + F_DmgPlaceList.IDByName[ 'luk' ] + ' ) and' +
      ' ( fk_orders_regions = ' + id_reg + ' )';
  end;

var
  i, j, progress_shag: integer;
begin
  {Заполняем датасет md_DmgByRegion
  Находим количество повреждений для
  для каждого района по месту повреждения}
  Result:=false;

  //progress_shag:=GetProgressShagLength(percent, F_RegList.Count*F_DmgPlaceList.Count);
  md_DmgByRegion.Close;
  md_DmgByRegion.Open;
  for i:=0 to F_RegList.Count-1 do
  begin
    md_DmgByRegion.Append;

    MyOpenIBDS(dset, 'select name from s_regions where id='+F_RegList.IDByIndex(i));
    md_DmgByRegion.FieldByName('reg_name').AsString:=dset.FieldByName('name').AsString;

    for j:=0 to F_DmgPlaceList.Count-1 do
    begin
   //   if F_IsStopProgress then exit;

      md_DmgByRegion.FieldByName('id_reg').AsInteger:=StrToInt(F_RegList.IDByIndex(i));
      MyOpenIBDS(dset,get_sel_sql(F_RegList.IDByIndex(i), F_DmgPlaceList.NameByIndex(j)));
      md_DmgByRegion.FieldByName(F_DmgPlaceList.NameByIndex(j)).AsInteger:=dset.FieldByName('kol').AsInteger;
      if AnsiCompareText(F_DmgPlaceList.NameByIndex(j), 'luk')=0 then
      begin
        MyOpenIBDS( dset, get_net_lukov_sql( F_RegList.IDByIndex(i) ) );
        md_DmgByRegion.FieldByName( 'NetLukov' ).AsInteger := dset.FieldByName( 'kol' ).AsInteger;
      end;

   //   IncProgressStatus(progress_shag);
    end; //end for j

    md_DmgByRegion.Post;
  end; //end for i

  Result:=true;
end;

function Tdm_saveSVGikXML.PrepareDmgByStreet(percent: integer): boolean;
  function GetLikvidCond: string;
  begin

      Result:=' and (o.IsClosed=1) and (o.FACTDATECLOSED>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.FACTDATECLOSED<='''+DateToStr(F_Dt+1)+' 6:00:00'')'

  end;

  function GetPostupCond: string;
  begin

      Result:=' and (o.FACTDATECOMING>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.FACTDATECOMING<='''+DateToStr(F_Dt+1)+' 6:00:00'')';

  end;

const
  GROUP_COUNT=6;

  ADR =
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) ';

  SEL_DMG=
    ' select count(*)'+
    ' from orders o'+
    ' where o.fk_orders_DamagePlace=%s';
var
  progress_shag: integer;
  likvid_sql, postup_sql: string;
begin
  {Заполняет датасет md_DmgByStreet}

  Result:=false;

 // progress_shag:=GetProgressShagLength(percent, GROUP_COUNT);
  md_DmgByStreet.Close;
  md_DmgByStreet.Open;


  likvid_sql:=SEL_DMG+GetLikvidCond+' order by 1';
  postup_sql:=SEL_DMG+GetPostupCond+' order by 1';

  if not AppendGroupToDmgByStreet(dgLikvidVseti,
        Format(likvid_sql, [  F_DmgPlaceList.IDByName['vseti'] ]), {progress_shag}) then exit;

  if not AppendGroupToDmgByStreet(dgLikvidVvody,
        Format(likvid_sql, [  F_DmgPlaceList.IDByName['vvody'] ]), {progress_shag}) then exit;

{  if not AppendGroupToDmgByStreet(dgUstanovLuk, 'УСТАНОВЛЕНО ЛЮКОВ:',     // 30.09.2008 by Vadim
        Format(likvid_sql, [

        // таким хитрым образом добавим количество люков по адресу
        ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',

        F_DmgPlaceList.IDByName['luk'] ]), progress_shag) then exit;
 }
  if not AppendGroupToDmgByStreet(dgPostupVseti,
        Format(postup_sql, [  F_DmgPlaceList.IDByName['vseti'] ]), {progress_shag}) then exit;

  if not AppendGroupToDmgByStreet(dgPostupVvody,
        Format(postup_sql, [  F_DmgPlaceList.IDByName['vvody'] ]), {progress_shag}) then exit;
  {
  if not AppendGroupToDmgByStreet( dgPostupNetKrishekLukov, 'ПОСТУПИЛО "НЕТ КРЫШКИ ЛЮКА":',
        Format(postup_sql, [
          ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',
          F_DmgPlaceList.IDByName['luk'] + ' and o.IsClosed=0 ' ] ),
        progress_shag  ) then exit;
   }
  Result:=true;
end;


function Tdm_saveSVGikXML.AppendGroupToDmgByStreet(group: TDamageGroup;
   sel_sql: string{progress_shag: integer}): boolean;
begin
 Result:=false;

  MyOpenIBDS(dset, sel_sql);

(*
  while not dset.Eof do
  begin
    if F_IsStopProgress then exit;

    with md_DmgByStreet do
    begin
      Append;
      FieldByName('group_number').AsInteger:=group_number;
      FieldByName('group_name').AsString:=group_name;
      FieldByName('region').AsString:=dset.FieldByName('region').AsString;
      FieldByName('equip').AsString:=dset.FieldByName('equip').AsString;
      FieldByName('adres').AsString:=dset.FieldByName('adres').AsString;
      Post;
    end; // end with
    dset.Next;
  end;
*)


  dset.First;
  repeat
 //   if F_IsStopProgress then exit;

    with md_DmgByStreet do
    begin
      Append;
      FieldByName('group_number').AsInteger:=ord(group);
      FieldByName('count').AsInteger:=dset.FieldByName('count').asInteger;
      Post;
    end; // end with
    dset.Next;
  until dset.Eof;

  //IncProgressStatus(progress_shag);

  Result:=true;
end;

procedure Tdm_saveSVGikXML.StDisp_Counts062;
var
  sql: string;
begin
  sql:=
    ' select count(nn.number)'+
    ' from numsorders nn join orders o on (nn.id_order = o.id)'+
    ' where'+
    ' (o.datecoming>='+QuotedStr(DateToStr(F_Dt))+') and (o.datecoming <='+QuotedStr(DateToStr(F_Dt+1))+')';

  F_DataForStDisp.CountGet062:=SimpleOpenDset(sql);

  sql:=
    ' select count(nn.number)'+
    ' from numsorders nn join orders o on (nn.id_order = o.id)'+
    ' where'+
    ' (o.dateclosed>='+QuotedStr(DateToStr(F_Dt))+') and (o.dateclosed<='+QuotedStr(DateToStr(F_Dt+1))+')'+
    ' and (o.isclosed = 1)';

  F_DataForStDisp.CountClose062:=SimpleOpenDset(sql);

  sql:=
    ' select count(nn.number)'+
    ' from numsorders nn join orders o on (nn.id_order = o.id)'+
    ' where'+
    ' (o.isclosed <> 1)';

  F_DataForStDisp.CountLeft062:=SimpleOpenDset(sql);

end;

function Tdm_saveSVGikXML.SimpleOpenDset(SelSQL: string): integer;
begin
  MyOpenIBDS(dset, SelSQL);
  Result:=dset.Fields[0].AsInteger;
  dset.Close;
end;

procedure Tdm_saveSVGikXML.StDisp_GikPart;
begin
  with F_DataForStDisp do
  begin
    md_DmgByRegion.First;
    while not md_DmgByRegion.Eof do
    begin
      inc(VodoSetiVsego, md_DmgByRegion.FieldByName('Vseti').AsInteger);
      inc(VvodyVsego, md_DmgByRegion.FieldByName('Vvody').AsInteger);
      inc(KolodtsyVsego, md_DmgByRegion.FieldByName('Kolodcy').AsInteger);
      inc(KolonkiVsego, md_DmgByRegion.FieldByName('Kolonky').AsInteger);
      inc(LukovVsego, md_DmgByRegion.FieldByName('Luk').AsInteger);
      md_DmgByRegion.Next;
    end;
    //
    md_DmgByStreet.First;
    while not md_DmgByStreet.Eof do
    begin
      if trim(md_DmgByStreet.FieldByName('region').AsString)<>'' then
      begin
        case TDamageGroup(md_DmgByStreet.FieldByName('group_number').AsInteger) of
          dgLikvidVseti: inc(LikvidNaVodoSetyax);
          dgLikvidVvody: inc(LikvidNaVvodax);
          dgUstanovLuk: inc(UstanLukov);
          dgPostupVseti: inc(PostupNaVodoSetyax);
          dgPostupVvody: inc(PostupNaVvodax);
        end; //end case
      end;

      md_DmgByStreet.Next;
    end;
    //
    TechejIzZemli:=VodoSetiVsego+VvodyVsego;
    TecheyIzKolodtsev:=KolodtsyVsego;
    NeispravnyxKolonok:=KolonkiVsego;
    UstanovlenoLukov:=LukovVsego;
  end;
end;


end.
