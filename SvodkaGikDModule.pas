unit SvodkaGikDModule;

interface

uses
  SysUtils, Classes, DModule, DB, IBCustomDataSet, IBDatabase, RxMemDS, Controls,
  FR_Class, FR_DSet, FR_DBSet, HelpClasses,  NGReportBaseDModule, IBSQL,
  kbmMemTable, Variants, ADODB;

 const WithoutExcav='Без земляных работ';
type
  TDataForStDisp = record
    VodoSetiVsego, VvodyVsego, KolodtsyVsego, KolonkiVsego, LukovVsego,
    LikvidNaVodoSetyax, LikvidNaVvodax, UstanLukov,
    PostupNaVodoSetyax, PostupNaVvodax: integer;
    { Сводка ГИК }
    TechejIzZemli, TecheyIzKolodtsev, NeispravnyxKolonok: integer;
    UstanovlenoLukov: integer;

    kanal_vsego,PodtopTepSetei,NetLukov:integer;
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

  TDamageGroup=(dgLikvidVseti, dgLikvidVvody, dgUstanovLuk, dgPostupVseti,
                dgPostupVvody, dgPostupNetKrishekLukov, dgLikvidTeplSety, dgPostupTeplSety);

  Tdm_SvodkaGik = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    md_DmgByRegion: TRxMemoryData;
    md_DmgByRegionreg_name: TStringField;
    md_DmgByRegionVSeti: TIntegerField;
    md_DmgByRegionVvody: TIntegerField;
    md_DmgByRegionKolodcy: TIntegerField;
    md_DmgByRegionKolonky: TIntegerField;
    md_DmgByRegionKanal: TIntegerField;
    md_DmgByRegionPodtopTepSetei: TIntegerField;
    md_DmgByRegionLuk: TIntegerField;
    frDS_DmgByRegion: TfrDBDataSet;
    md_DmgByStreet: TRxMemoryData;
    frDS_DmgByStreet: TfrDBDataSet;
    md_DmgByStreetregion: TStringField;
    md_DmgByStreetequip: TStringField;
    md_DmgByStreetadres: TStringField;
    md_DmgByStreetgroup_name: TStringField;
    md_DmgByStreetgroup_number: TIntegerField;
    md_EquipLikvid: TRxMemoryData;
    frDS_EquipLikvid: TfrDBDataSet;
    md_EquipLikviddz_zap: TStringField;
    md_EquipLikviddz_rab: TStringField;
    md_EquipLikvidki_zap: TStringField;
    md_EquipLikvidki_rab: TStringField;
    md_EquipLikvidko_zap: TStringField;
    md_EquipLikvidko_rab: TStringField;
    md_EquipLikvidle_zap: TStringField;
    md_EquipLikvidle_rab: TStringField;
    md_EquipLikvidmo_zap: TStringField;
    md_EquipLikvidmo_rab: TStringField;
    md_EquipLikvidok_zap: TStringField;
    md_EquipLikvidok_rab: TStringField;
    md_EquipLikvidor_zap: TStringField;
    md_EquipLikvidor_rab: TStringField;
    md_EquipLikvidfr_zap: TStringField;
    md_EquipLikvidfr_rab: TStringField;
    md_EquipLikvidch_zap: TStringField;
    md_EquipLikvidch_rab: TStringField;
    md_EquipBlago_old: TRxMemoryData;
    frDS_EquipBlago: TfrDBDataSet;
    md_EquipBlago_olddz: TStringField;
    md_EquipBlago_oldki: TStringField;
    md_EquipBlago_oldko: TStringField;
    md_EquipBlago_oldle: TStringField;
    md_EquipBlago_oldmo: TStringField;
    md_EquipBlago_oldok: TStringField;
    md_EquipBlago_oldor: TStringField;
    md_EquipBlago_oldfr: TStringField;
    md_EquipBlago_oldch: TStringField;
    IBSQL: TIBSQL;
    md_DmgByRegionid_reg: TIntegerField;
    md_DmgByRegionNetLukov: TIntegerField;
    mt_Disconnections: TkbmMemTable;
    frDS_Disconnections: TfrDBDataSet;
    mt_Meteo: TkbmMemTable;
    frDS_Meteo: TfrDBDataSet;
    md_EquipBlagoForGen: TRxMemoryData;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    frDS_EquipBlagoForGen: TfrDBDataSet;
    mt_Meteomydate: TDateTimeField;
    mt_Meteomytime: TDateTimeField;
    mt_Meteotemperate: TIntegerField;
    mt_Meteotemperate_night: TIntegerField;
    mt_Meteospeed: TIntegerField;
    mt_Meteocloudsn: TStringField;
    mt_Meteoosadkin: TStringField;
    mt_Meteoshtormn: TStringField;
    mt_Meteowindn: TStringField;
    md_DmgByStreetForGen: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    frDS_DmgByStreetForGen: TfrDBDataSet;
    md_EquipBlago: TRxMemoryData;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    frDS_OpenOrdersGenDir: TfrDBDataSet;
    mt_OpenOrdersGenDir: TkbmMemTable;
    mt_OpenOrdersGenDirOrderNumber: TIntegerField;
    mt_OpenOrdersGenDirDateComing: TDateTimeField;
    mt_OpenOrdersGenDirfk_orders_regions: TIntegerField;
    mt_OpenOrdersGenDirRegions: TStringField;
    mt_OpenOrdersGenDiradres: TStringField;
    md_DmgByStreet2: TRxMemoryData;
    frDS_DmgByStreet2: TfrDBDataSet;
    md_ByRegions_six: TRxMemoryData;
    StringField36: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    frDS_byRegionsSix: TfrDBDataSet;
    md_ByRegionDeteil: TRxMemoryData;
    md_ByRegionDeteilgroup_number: TIntegerField;
    md_ByRegionDeteilgrou_name: TStringField;
    md_ByRegionDeteiladress: TStringField;
    md_ByRegionDeteilRegion: TStringField;
    frDBByRegionDeteil: TfrDBDataSet;
    md_ByRegionDeteilDATECOMING: TDateTimeField;
    ADOQ_ComingZayv: TADOQuery;
    ADODset: TADODataSet;
    md_DmgByStreetwithoutexcav: TStringField;
    md_DmgByStreet2withoutexcav: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_DmgPlaceList, F_RegList: TNameContainer;
    F_ShiftDate: TDate;
    F_ShiftNumber: integer;
    procedure FillDmgPlaceList;
    procedure FillRegList;
    function AppendGroupToDmgByStreet(group: TDamageGroup; group_name: string;
                   sel_sql: string; progress_shag: integer): boolean;
    function AppendGroupToDmgByStreet2(group: TDamageGroup; group_name: string;
                   sel_sql: string; progress_shag: integer): boolean;
    procedure GetNumAndDateShift(var num: integer; var dt: TDate);
    procedure SetClosedOrderCount;
    procedure SetDepartureCount;
    procedure SetOrderComingCount;
    procedure SetTemperature;
    procedure SetZayvComing; //поступило заявок 11.07.2013
    procedure SaveIP;

    procedure StDisp_GikPart;
    procedure StDisp_KilledDmg;
    procedure StDisp_SvodVedExc;
    procedure StDisp_ProfWork;
    procedure StDisp_Counts062;
    function SimpleOpenDset(SelSQL: string): integer;
  private
    function PrepareDmgByRegion(percent: integer): boolean;
    function PrepareDmgByStreet(percent: integer): boolean;
    function PrepareDmgByStreet2(percent: integer): boolean;
    function PrepareEquipLikvid(percent: integer): boolean;
    function PrepareEquipBlago(percent: integer): boolean;
    function PrepareHeaderInfo(percent: integer): boolean;
    function PrepareInfoForStDisp(percent: integer): boolean;
    function PrepareDisconnections(percent: integer): boolean;
    function PrepareMeteoInfo(percent: integer): boolean;
    function PrepareREP_GIK_DOP(percent: integer): boolean;
    function PrepareOpenedOrdersGenDir(percent: integer): boolean;

    function PrepareByRefionsSix(percent :integer):boolean; //31.07.2012
    function  PrepareByRegionDetail(percent: integer): boolean; //01/08/2012 glasha
    function AppendGroupToDmgByREgion(group: TDamageGroup;         //01/08/2012 glasha
                                       group_name, sel_sql: string; progress_shag: integer): boolean;

    function PrepareDmgByRegion_Six(percent: integer): boolean;
  private
    F_Dt: TDate; //Дата формирования сводки
    F_IsEquipPrint: boolean; //Экскаваторы печатать
    F_IsShiftNumberUchit: boolean;  //Учитывать номер смены
    F_OrderComingCount: integer;  //Количество поступивших заявок
    F_DepartureCount: integer;  //Количество сделанных выездов
    F_ClosedOrderCount: integer;  //Количество закрытых заявок - только ЦДП
    F_ClosedOrderAllCount: integer;  //Количество закрытых нарядов (заявок) - всех, а не только ЦДП
    F_Temperature: integer; //Температура воды
    F_IsForGen: boolean; //Для Ген. директора
    f_ZayvComing:integer; //11.07.2013
    F_DataForStDisp: TDataForStDisp;
    F_IPList:TStringList;
    F_ZayvComing1562:integer;  //  заявок 1562
    F_ZayvComingpeople:integer;//  заявок жителей

    function SaveToBase:boolean; //31.07.2012

  public
    property Dt: TDate read F_Dt write F_Dt;
    property IsEquipPrint: boolean read F_IsEquipPrint write F_IsEquipPrint;
    property IsShiftNumberUchit: boolean read F_IsShiftNumberUchit write F_IsShiftNumberUchit;
    property IsForGen: boolean read F_IsForGen write F_IsForGen;

    property OrderComingCount: integer read F_OrderComingCount;
    property DepartureCount: integer read F_DepartureCount;
    property ClosedOrderCount: integer read F_ClosedOrderCount;
    property ClosedOrderAllCount: integer read F_ClosedOrderAllCount;
    property Temperature: integer read F_Temperature;
    property DataForStDisp: TDataForStDisp read F_DataForStDisp;
    property ZayvComing:integer read f_ZayvComing; //11.07.2013
    property ZayvComing1562:integer read F_ZayvComing1562;
    property ZayvComingpeople :integer read F_ZayvComingpeople;

    function PrepareDsets: boolean;
    function Simple_PrepareDsets: boolean; //31.07.2012
    function IsLoad:boolean;
    function preparebystreetfast(progress_shag:integer):boolean; //03.08.2012

  end;


implementation

{$R *.dfm}

uses HelpFunctions, ClorDModule, SysInfo;

function Tdm_SvodkaGik.PrepareDmgByRegion(percent: integer): boolean;
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
  try
  progress_shag:=GetProgressShagLength(percent, F_RegList.Count*F_DmgPlaceList.Count);
  md_DmgByRegion.Close;
  md_DmgByRegion.Open;
  for i:=0 to F_RegList.Count-1 do
  begin
    md_DmgByRegion.Append;

    MyOpenIBDS(dset, 'select name from s_regions where id='+F_RegList.IDByIndex(i));
    md_DmgByRegion.FieldByName('reg_name').AsString:=dset.FieldByName('name').AsString;

    for j:=0 to F_DmgPlaceList.Count-1 do
    begin
      if F_IsStopProgress then exit;

      md_DmgByRegion.FieldByName('id_reg').AsInteger:=StrToInt(F_RegList.IDByIndex(i));
      MyOpenIBDS(dset,get_sel_sql(F_RegList.IDByIndex(i), F_DmgPlaceList.NameByIndex(j)));
      md_DmgByRegion.FieldByName(F_DmgPlaceList.NameByIndex(j)).AsInteger:=dset.FieldByName('kol').AsInteger;
      if AnsiCompareText(F_DmgPlaceList.NameByIndex(j), 'luk')=0 then
      begin
        MyOpenIBDS( dset, get_net_lukov_sql( F_RegList.IDByIndex(i) ) );
        md_DmgByRegion.FieldByName( 'NetLukov' ).AsInteger := dset.FieldByName( 'kol' ).AsInteger;
      end;

      IncProgressStatus(progress_shag);
    end; //end for j

    md_DmgByRegion.Post;
  end; //end for i

  Result:=true;
  except
    result:=false;
  end;
end;



function Tdm_SvodkaGik.PrepareDmgByRegion_Six(percent: integer): boolean;
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
    end else Result:=' and ((o.IsClosed=0) or  FACTDATECLOSED>='''+DateToStr(F_Dt+1)+' 6:00:01'' ) and ((o.FACTDATECOMING<='''+DateToStr(F_Dt+1)+' 6:00:00'') or (o.factdatecoming is  null))'
  end;

  function get_sel_sql( dmg_name: string): string;
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
      ' where 1=1 '+
     // ' (o.fk_orders_regions='+id_reg+')'+
      _s +
      GetAddCond(dmg_name);
  end;

  function get_net_lukov_sql(  ): string;
  begin
    Result :=
      ' select sum(HoodCount) kol' +
      ' from orders' +
      ' where ( IsClosed = 0 ) and' +
      ' ( fk_orders_damageplace = ' + F_DmgPlaceList.IDByName[ 'luk' ] + ' ) ';//and' +
 //     ' ( fk_orders_regions = ' + id_reg + ' )';
  end;

var
   j, progress_shag: integer;
begin
  {Заполняем датасет md_DmgByRegion
  Находим количество повреждений для
  для каждого района по месту повреждения}
  Result:=false;

  progress_shag:=GetProgressShagLength(percent, F_RegList.Count*F_DmgPlaceList.Count);
  md_DmgByRegion.Close;
  md_DmgByRegion.Open;
//  for i:=0 to F_RegList.Count-1 do
  begin
    md_DmgByRegion.Append;

  //  MyOpenIBDS(dset, 'select name from s_regions where id='+F_RegList.IDByIndex(i));
    md_DmgByRegion.FieldByName('reg_name').AsString:='Всего на 6:00';

    for j:=0 to F_DmgPlaceList.Count-1 do
    begin
      if F_IsStopProgress then exit;

      md_DmgByRegion.FieldByName('id_reg').AsInteger:=0;
      MyOpenIBDS(dset,get_sel_sql( F_DmgPlaceList.NameByIndex(j)));
      md_DmgByRegion.FieldByName(F_DmgPlaceList.NameByIndex(j)).AsInteger:=dset.FieldByName('kol').AsInteger;
      if AnsiCompareText(F_DmgPlaceList.NameByIndex(j), 'luk')=0 then
      begin
        MyOpenIBDS( dset, get_net_lukov_sql(  ) );
        md_DmgByRegion.FieldByName( 'NetLukov' ).AsInteger := dset.FieldByName( 'kol' ).AsInteger;
      end;

      IncProgressStatus(progress_shag);
    end; //end for j

    md_DmgByRegion.Post;
  end; //end for i

  Result:=true;
end;

procedure Tdm_SvodkaGik.DataModuleCreate(Sender: TObject);
begin
  inherited;
  GetNumAndDateShift(F_ShiftNumber, F_ShiftDate);

  F_DmgPlaceList:=TNameContainer.Create;
  F_RegList:=TNameContainer.Create;

  FillDmgPlaceList;
  FillRegList;

  F_IsForGen := false;
end;

function Tdm_SvodkaGik.PrepareDsets: boolean;
begin
  Result:=true;

  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try

    if not PrepareDmgByRegion(28) then Result:=false
    else
    if not PrepareDmgByStreet(10) then Result:=false
    else
    begin
      if F_IsEquipPrint then
      begin
        if not PrepareEquipLikvid(10) then Result:=false
        else
        if not PrepareEquipBlago(10) then Result:=false;
      end;
      if (Result) and (not PrepareHeaderInfo(4)) then Result:=false
      else
     // if not PrepareInfoForStDisp(4) then Result:=false
   //   else
      if not PrepareDisconnections(4) then Result:=false
      else
//      if not PrepareMeteoInfo(4) then Result:=false все равно не отображается
 //     else
      if not PrepareREP_GIK_DOP(4) then Result:=false;
      if F_IsForGen then
       if not PrepareOpenedOrdersGenDir(4) then Result:=false;
      if not PrepareDmgByStreet2(10) then Result:=false
      else
      if not PrepareByRefionsSix(3) then Result:=false
      else
      if not PrepareByRegionDetail(10) then REsult:=false;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      result:=false;
      raise Exception.Create(E.Message+'(Tdm_SvodkaGik.PrepareDsets)');
    end;
  end;
end;

procedure Tdm_SvodkaGik.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_DmgPlaceList.Free;
  F_RegList.Free;

  md_DmgByRegion.Close;
  md_DmgByStreet.Close;
  md_DmgByStreet2.Close;
  md_EquipLikvid.Close;
  md_EquipBlago.Close;

  md_EquipBlagoForGen.Close;
  md_DmgByStreetForGen.Close;
end;

procedure Tdm_SvodkaGik.FillDmgPlaceList;
begin
  with F_DmgPlaceList do
  begin
    IDByName['vseti']:='1';             //Водопроводные сети
    IDByName['vvody']:='2';             //Вводы
    IDByName['kolodcy']:='3';           //Колодцы
    IDByName['kolonky']:='4';           //Колонки
    IDByName['kanal']:='10';            //Прох.канал
    IDByName['PodtopTepSetei']:='31';   //Подтоп.теп.сетей скрыт теч.
    IDByName['luk']:='13';              //Установка люков
  end;
end;


function Tdm_SvodkaGik.PrepareDmgByStreet(percent: integer): boolean;
  function GetLikvidCond: string;
  begin
    {if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then}
//mv 16.08.11
      Result:=' and (o.IsClosed=1) and (o.FACTDATECLOSED>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.FACTDATECLOSED<='''+DateToStr(F_Dt+1)+' 6:00:00'')'
    {else
      Result:=' and (o.IsClosed=1) and (o.FACTDATECLOSED>='''+DateToStr(F_Dt)+ ''')'+
              ' and (o.FACTDATECLOSED<'''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumberClose='+IntToStr(F_ShiftNumber)+')'}
  end;

  function GetPostupCond: string;
  begin
   { if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
    begin}
      Result:=' and (o.FACTDATECOMING>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.FACTDATECOMING<='''+DateToStr(F_Dt+1)+' 6:00:00'')';
    {end else
    begin
      Result:=' and (o.FACTDATECOMING>='''+DateToStr(F_Dt)+''')'+
              ' and (o.FACTDATECOMING<='''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumber='+IntToStr(F_ShiftNumber)+')';
    end;}
  end;

const
  GROUP_COUNT=6;

  ADR =
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) ';

  SEL_DMG=
    ' select '+
    ' (select name from s_Regions where id=o.fk_orders_regions) region,'+
    ' (select number from equipment where id='+
//    '   (select fk_eqwork_equip from equipwork where fk_eqwork_orders=o.id)) equip,'+
    '   (select max(fk_eqwork_equip) from equipwork where fk_eqwork_orders=o.id)) equip,'+
    ' o.fk_orders_off_withoutexcav, '+
    ' %s adres'+
    ' from orders o'+
    ' where o.fk_orders_DamagePlace=%s';
var
  progress_shag: integer;
  likvid_sql, postup_sql: string;
begin
  {Заполняет датасет md_DmgByStreet}
  try

  Result:=false;

  progress_shag:=GetProgressShagLength(percent, GROUP_COUNT);
  md_DmgByStreet.Close;
  md_DmgByStreet.Open;
  md_DmgByStreetForGen.Close;
  md_DmgByStreetForGen.Open;


  likvid_sql:=SEL_DMG+GetLikvidCond+' order by 1';
  postup_sql:=SEL_DMG+GetPostupCond+' order by 1';

  if not AppendGroupToDmgByStreet(dgLikvidVseti, 'ЛИКВИДИРОВАЛИ НА В/СЕТЯХ:',
        Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['vseti'] ]), progress_shag) then exit;



  if not AppendGroupToDmgByStreet(dgLikvidVvody, 'ЛИКВИДИРОВАЛИ НА В/ВВОДАХ:',
        Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['vvody'] ]), progress_shag) then exit;

  if not AppendGroupToDmgByStreet(dgLikvidVseti, 'ЛИКВИДИРОВАЛИ СКРЫТЫЕ ТЕЧИ:',
        Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['PodtopTepSetei'] ]), progress_shag) then exit;

{  if not AppendGroupToDmgByStreet(dgUstanovLuk, 'УСТАНОВЛЕНО ЛЮКОВ:',     // 30.09.2008 by Vadim
        Format(likvid_sql, [

        // таким хитрым образом добавим количество люков по адресу
        ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',

        F_DmgPlaceList.IDByName['luk'] ]), progress_shag) then exit;
 }
  if not AppendGroupToDmgByStreet(dgPostupVseti, 'ПОСТУПИЛО НА В/СЕТЯХ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['vseti'] ]), progress_shag) then exit;

  if not AppendGroupToDmgByStreet(dgPostupVvody, 'ПОСТУПИЛО НА В/ВВОДАХ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['vvody'] ]), progress_shag) then exit;

  if not AppendGroupToDmgByStreet(dgPostupTeplSety, 'ПОСТУПИЛО СКРЫТЫЕ ТЕЧИ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['PodtopTepSetei'] ]), progress_shag) then exit;
  {
  {
  if not AppendGroupToDmgByStreet( dgPostupNetKrishekLukov, 'ПОСТУПИЛО "НЕТ КРЫШКИ ЛЮКА":',
        Format(postup_sql, [
          ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',
          F_DmgPlaceList.IDByName['luk'] + ' and o.IsClosed=0 ' ] ),
        progress_shag  ) then exit;
   }
  Result:=true;
  except
   result:=false;
  end;
end;

function Tdm_SvodkaGik.AppendGroupToDmgByStreet(group: TDamageGroup;
  group_name, sel_sql: string; progress_shag: integer): boolean;
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
    if F_IsStopProgress then exit;

    with md_DmgByStreet do
    begin
      Append;
      FieldByName('group_number').AsInteger:=ord(group);
      FieldByName('group_name').AsString:=group_name;
      FieldByName('region').AsString:=dset.FieldByName('region').AsString;
      FieldByName('equip').AsString:=dset.FieldByName('equip').AsString;
      FieldByName('adres').AsString:=dset.FieldByName('adres').AsString;
      if not dset.FieldByName('fk_orders_off_withoutexcav').IsNull then
          FieldByName('withoutexcav').AsString:=WithoutExcav
         else
          FieldByName('withoutexcav').AsString:='';

      Post;
    end; // end with
    dset.Next;
  until dset.Eof;


  with md_DmgByStreetForGen do
  begin
    dset.First;
    if dset.IsEmpty and not( group in [ dgUstanovLuk, dgPostupNetKrishekLukov ] ) then
    begin
      Append;
      FieldByName('group_number').AsInteger:=ord(group);
      FieldByName('group_name').AsString:=group_name;
      Post;
    end else
    begin
      while not dset.Eof do
      begin
        if F_IsStopProgress then exit;

        with md_DmgByStreetForGen do
        begin
          Append;
          FieldByName('group_number').AsInteger:=ord(group);
          FieldByName('group_name').AsString:=group_name;
          FieldByName('region').AsString:=dset.FieldByName('region').AsString;
          FieldByName('equip').AsString:=dset.FieldByName('equip').AsString;
          FieldByName('adres').AsString:=dset.FieldByName('adres').AsString;
          Post;
        end; // end with
        dset.Next;
      end;
    end;
  end;

  IncProgressStatus(progress_shag);

  Result:=true;
end;

function Tdm_SvodkaGik.AppendGroupToDmgByStreet2(group: TDamageGroup;
  group_name, sel_sql: string; progress_shag: integer): boolean;
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
    if F_IsStopProgress then exit;

    with md_DmgByStreet2 do
    begin
      Append;
      FieldByName('group_number').AsInteger:=ord(group);
      FieldByName('group_name').AsString:=group_name;
      FieldByName('region').AsString:=dset.FieldByName('region').AsString;
      FieldByName('equip').AsString:=dset.FieldByName('equip').AsString;
      FieldByName('adres').AsString:=dset.FieldByName('adres').AsString;
      if not dset.FieldByName('fk_orders_off_withoutexcav').IsNull then
        FieldByName('withoutexcav').AsString:=UpperCase(WithoutExcav)
      else
        FieldByName('withoutexcav').AsString:='';
      Post;
    end; // end with
    dset.Next;
  until dset.Eof;

   IncProgressStatus(progress_shag);
   Result:=true;
end;

function Tdm_SvodkaGik.PrepareDmgByStreet2(percent: integer): boolean;
  function GetLikvidCond_2: string;
  begin
   // if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
//mv 16.08.11
      Result:=' and (o.IsClosed=1)'+// and (o.DATECLOSED>='''+DateToStr(F_Dt)+' 6:00:01'')'+
             // ' and (((o.DATECLOSED<='''+DateToStr(F_Dt+1)+' 6:00:00'')'+
              ' and (o.FACTDATECLOSED>'''+DateToStr(F_Dt+1)+' 6:00:00'') '
              //' or (o.DATECLOSED>'''+DateToStr(F_Dt+1)+' 6:00:00''))'
    {else
      Result:=' and (o.IsClosed=1) and (o.DATECLOSED>='''+DateToStr(F_Dt)+ ''')'+
              ' and (o.DATECLOSED<'''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumberClose='+IntToStr(F_ShiftNumber)+')'+
              ' and (o.FACTDATECLOSED>'''+DateToStr(F_Dt+2)+' 6:00:00'')'
  }end;

  function GetPostupCond_2: string;
  begin
    //if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
    begin
      Result:=' and (o.DATECOMING>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              //' and (o.DATECOMING<='''+DateToStr(F_Dt+1)+' 6:00:00'')'+
              ' and (o.FACTDATECOMING>'''+DateToStr(F_Dt+1)+' 6:00:00'')';
    end //else
  {  begin
      Result:=' and (o.FACTDATECOMING>='''+DateToStr(F_Dt)+''')'+
              ' and (o.FACTDATECOMING<'''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumber='+IntToStr(F_ShiftNumber)+')'+
              ' and (o.FACTDATECOMING>'''+DateToStr(F_Dt+2)+' 6:00:00'')';
    end;}
  end;

const
  GROUP_COUNT=6;

  ADR =
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) ';

  SEL_DMG=
    ' select '+
    ' (select name from s_Regions where id=o.fk_orders_regions) region,'+
    ' o.DATECOMING,o.DATECLOSED, o.fk_orders_off_withoutexcav, '+
    ' (select number from equipment where id='+
//    '   (select fk_eqwork_equip from equipwork where fk_eqwork_orders=o.id)) equip,'+
    '   (select max(fk_eqwork_equip) from equipwork where fk_eqwork_orders=o.id)) equip,'+
    ' %s adres'+
    ' from orders o'+
    ' where o.fk_orders_DamagePlace=%s';
var
  progress_shag: integer;
  likvid_sql, postup_sql: string;
begin
  {Заполняет датасет md_DmgByStreet2}

  Result:=false;

  progress_shag:=GetProgressShagLength(percent, GROUP_COUNT);
  md_DmgByStreet2.Close;
  md_DmgByStreet2.Open;

  likvid_sql:=SEL_DMG+GetLikvidCond_2+' order by 1';
  postup_sql:=SEL_DMG+GetPostupCond_2+' order by 1';
  try
  if not AppendGroupToDmgByStreet2(dgLikvidVseti, 'ЛИКВИДИРОВАЛИ НА В/СЕТЯХ:',
        Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['vseti'] ]), progress_shag) then exit;

 if not AppendGroupToDmgByStreet2(dgLikvidVvody, 'ЛИКВИДИРОВАЛИ НА В/ВВОДАХ:',
       Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['vvody'] ]), progress_shag) then exit;


 if not AppendGroupToDmgByStreet2(dgLikvidTeplSety, 'ЛИКВИДИРОВАЛИ СКРЫТЫЕ ТЕЧИ:',
       Format(likvid_sql, [ ADR, F_DmgPlaceList.IDByName['PodtopTepSetei'] ]), progress_shag) then exit;

{  if not AppendGroupToDmgByStreet(dgUstanovLuk, 'УСТАНОВЛЕНО ЛЮКОВ:',     // 30.09.2008 by Vadim
        Format(likvid_sql, [

        // таким хитрым образом добавим количество люков по адресу
        ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',

        F_DmgPlaceList.IDByName['luk'] ]), progress_shag) then exit;
 }
  if not AppendGroupToDmgByStreet2(dgPostupVseti, 'ПОСТУПИЛО НА В/СЕТЯХ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['vseti'] ]), progress_shag) then exit;

  if not AppendGroupToDmgByStreet2(dgPostupVvody, 'ПОСТУПИЛО НА В/ВВОДАХ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['vvody'] ]), progress_shag) then exit;

  if not AppendGroupToDmgByStreet2(dgPostupTeplSety, 'ПОСТУПИЛО СКРЫТЫЕ ТЕЧИ:',
        Format(postup_sql, [ ADR, F_DmgPlaceList.IDByName['PodtopTepSetei'] ]), progress_shag) then exit;

  {
  if not AppendGroupToDmgByStreet( dgPostupNetKrishekLukov, 'ПОСТУПИЛО "НЕТ КРЫШКИ ЛЮКА":',
        Format(postup_sql, [
          ' cast( (' + ADR + ' || '' ('' || cast(HOODCOUNT as varchar(2)) ||  '' шт.)'' ) as varchar(250) )',
          F_DmgPlaceList.IDByName['luk'] + ' and o.IsClosed=0 ' ] ),
        progress_shag  ) then exit;
   }
  Result:=true;
  except
  result:=false;
  end;
end;

procedure Tdm_SvodkaGik.FillRegList;
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

function Tdm_SvodkaGik.PrepareEquipLikvid(percent: integer): boolean;
var
  progress_shag: integer;
  sel_zap, sel_rab: string;
///////////
  function AppendEquip(sel_sql, field_end: string; progress_shag: integer): boolean;
  var
    i: integer;
  begin
    Result:=false;
    for i:=0 to F_RegList.Count-1 do
    begin
      if F_IsStopProgress then exit;

      MyOpenIBDS(dset, Format(sel_sql, [F_RegList.IDByIndex(i)]));
      md_EquipLikvid.First;
      {
      while not dset.Eof do
      begin
        if md_EquipLikvid.Eof then
          md_EquipLikvid.Append
         else
          md_EquipLikvid.Edit;

        md_EquipLikvid.FieldByName(F_RegList.NameByIndex(i)+'_'+field_end).AsString:=
                      dset.FieldByName('equip_number').AsString;

        md_EquipLikvid.Post;
        md_EquipLikvid.Next;
        dset.Next;
      end;
      }
      repeat;
        if md_EquipLikvid.Eof then
          md_EquipLikvid.Append
         else
          md_EquipLikvid.Edit;

        if dset.FieldByName('equip_number').IsNull then
          md_EquipLikvid.FieldByName(F_RegList.NameByIndex(i)+'_'+field_end).AsString:=' '
        else
          md_EquipLikvid.FieldByName(F_RegList.NameByIndex(i)+'_'+field_end).AsString:=
                      dset.FieldByName('equip_number').AsString;

        md_EquipLikvid.Post;
        md_EquipLikvid.Next;
        dset.Next;
      until dset.Eof;

      IncProgressStatus(progress_shag);
    end; //end for i
    Result:=true;
  end;

  function GetRabCond: string;
  begin
  {  Result:=' and (ew.DateWork>='''+DateToStr(F_Dt)+' 08:00:01'')'+
            ' and (ew.DateWork<='''+DateToStr(F_Dt+1)+' 08:00:00'')';}
     REsult:=''''+DateToStr(F_Dt)+' 08:00:01'','''+DateToStr(F_Dt+1)+' 08:00:00''';
  end;

  function GetZapCond: string;
  begin
  //  Result:=' and (ep.EqDate>='''+DateToStr(F_Dt)+' 06:00'')'+  // - старая версия
  //          ' and (ep.EqDate<'''+DateToStr(F_Dt+1)+' 06:00'')';
  // mv 16.08.11
    Result:=' and (d.planstartdate >='''+DateToStr(F_Dt)+' 08:00:01'')'+  // - новая версия
            ' and (d.planenddate <='''+DateToStr(F_Dt+1)+' 08:00:00'')';

  end;
begin
  {Заполняет md_EquipLikvid}
  Result:=false;

//старая версия, теперь надо брать запланированное оборпудование из выездов
{  sel_zap:=
    ' select distinct e.number equip_number'+
    ' from equipplanned ep, equipment e'+
    ' where'+
    ' (e.id=ep.fk_equipplanned_equip)'+
    ' and (ep.fk_equipplanned_regions=%s)'+
    GetZapCond;}

 //страя версия  теперь считаем только кол-во
 { sel_zap:=      // новая версия
    ' select distinct e.number equip_number'+
    ' from  departures d, equipment e, orders o'+
    ' where (d.fk_departures_equipment = e.id)'+
    ' and (d.fk_departures_orders = o.id)'+
    ' and (o.fk_orders_regions=%s)'+
    GetZapCond;


  sel_rab:=
    //' select distinct e.number equip_number'+
    ' select e.number equip_number'+
    ' from equipwork ew, orders o, equipment e'+
    ' where'+
    ' (o.id=ew.fk_eqwork_orders)'+
    ' and (e.id=ew.fk_eqwork_equip)'+
    ' and (e.id<>-1)'+
    ' and (o.fk_orders_regions=%s)'+
    GetRabCond;
}

sel_zap:=
  ' select count (distinct e.number) equip_number'+
    ' from  departures d, equipment e, orders o'+
    ' where (d.fk_departures_equipment = e.id)'+
    ' and (d.fk_departures_orders = o.id)'+
    ' and (o.fk_orders_regions=%s)'+
    GetZapCond;

 sel_rab:=

    ' select count(distinct numbers) equip_number'+
    ' from EQUIOP_WORK_GIK(%s,' + GetRabCond+') '    +
     ' where numbers is  not  null';

  progress_shag:=GetProgressShagLength(percent, 2*F_RegList.Count);
  md_EquipLikvid.Close;
  md_EquipLikvid.Open;
  try
  if not AppendEquip(SEL_ZAP, 'zap', progress_shag) then exit;
  if not AppendEquip(SEL_RAB, 'rab', progress_shag) then exit;

  Result:=true;
  except
  result:=false;
  end;
end;

function Tdm_SvodkaGik.PrepareEquipBlago(percent: integer): boolean;

  function AppendBlago( sel_sql, field_end: string; progress_shag: integer): boolean;
  var
    i: integer;
    tmp_count: boolean;
  begin
    tmp_count:=false;
    Result:=false;

      if F_IsStopProgress then exit;

      MyOpenIBDS(dset, sel_sql);

      if (not dset.Eof) then tmp_count := true;// если true, то эту табличку показывать

      md_EquipBlago.First;
      repeat;
        if md_EquipBlago.Eof then
          md_EquipBlago.Append
         else
          md_EquipBlago.Edit;

        if dset.FieldByName('equip_number').IsNull then
          md_EquipBlago.FieldByName(field_end).AsString:=' '
        else
          md_EquipBlago.FieldByName(field_end).AsString:=
                      dset.FieldByName('equip_number').AsString;

        md_EquipBlago.Post;
        md_EquipBlago.Next;
        dset.Next;
      until dset.Eof;

      IncProgressStatus(progress_shag);

    Result:=tmp_count;
  end;

var
  i, progress_shag: integer;
  tmp_count, b_rab, b_zap: boolean;
  SEL_SQL, sel_zap, sel_rab, _reg: string;
begin
  Result:=false;
  tmp_count:= false;

 { SEL_SQL:=       - старая версия
    //' select distinct e.number equip_number'+
    ' select e.number equip_number'+
    ' from equipused eu'+
    ' left join equipment e on e.id=eu.fk_equipused_equipment'+
    ' where eu.fk_equipused_regions=%s'+
    ' and (eu.useddate>'''+DateToStr(F_Dt)+' 6:00'') and (eu.useddate<'''+DateToStr(F_Dt+1)+' 6:00'')';
  }

  SEL_SQL:=
    ' select distinct eq.number equip_number'+
    ' from excavations ex, orders o , equipment eq'+
    ' where  (o.id = ex.fk_excavations_orders) and (eq.id = ex.fk_excavations_equipment) and '+
    ' o.fk_orders_regions = %s'+
    ' and (ex.fk_excavations_equipment>0) '+
    ' and (ex.dtime>='''+DateToStr(F_Dt)+' 8:00:01'') and (ex.dtime<='''+DateToStr(F_Dt+1)+' 8:00:00'')';

//  progress_shag:=GetProgressShagLength(percent, F_RegList.Count);
  progress_shag:=GetProgressShagLength(percent, 2*F_RegList.Count);
  md_EquipBlago.Close;
  md_EquipBlago.Open;

  md_EquipBlagoForGen.Close;
  md_EquipBlagoForGen.Open;
  //frVariables['TMP_COUNT']:= 0;
  try
  for i:=0 to F_RegList.Count-1 do
  begin
    if F_IsStopProgress then exit;

      _reg := F_RegList.IDByIndex(i);

       {  ЗАПЛАНИРОВАНО  - equipused - это теперь таблица "запланированное оборудование для благоустройства" }
        sel_zap:=      // новая версия
          ' select distinct e.number equip_number'+
          ' from equipused eu'+
          ' left join equipment e on (e.id = eu.fk_equipused_equipment)'+
          ' where '+
          ' (eu.useddate >= '''+DateToStr(F_Dt)+' 08:00:01'' )'+
          ' and (eu.useddate <= '''+DateToStr(F_Dt+1)+' 08:00:00'' )'+
          ' and (eu.fk_equipused_regions='+ _reg +')';
        { //  ЗАПЛАНИРОВАНО }

       {    РАБОТАЛИ    }
         sel_rab:=
        ' select distinct e.number equip_number'+
        ' from excavations ex, orders o, equipment e '+
        ' where (ex.fk_excavations_orders = o.id)'+
        ' and (e.id = ex.fk_excavations_equipment) '+
        ' and not ( '+
        '      ex.fk_excavations_equipment in ( '+
        '          select ep.fk_equipplanned_equip '+
        '             from equipplanned ep '+
        '              where '+
        '             (ep.fk_equipplanned_regions= '+ _reg +')'+
        '              and (ep.EqDate>='''+DateToStr(F_Dt)+' 08:00:01'')'+
        '              and (ep.EqDate<='''+DateToStr(F_Dt+1)+' 08:00:00'')'+
        '          )'+
        '      )'+
        ' and not ('+
        '      ex.fk_excavations_equipment in ('+
        '          select ew.fk_eqwork_equip'+
        '             from equipwork ew, orders o'+
        '              where'+
        '              (ew.fk_eqwork_orders = o.id)'+
        '              and (o.fk_orders_regions = '+ _reg +')'+
        '              and (ew.datework>='''+DateToStr(F_Dt)+' 08:00:01'')'+
        '              and (ew.datework<='''+DateToStr(F_Dt+1)+' 08:00:00'')'+
        '          )'+
        '      )'+
        ' and not (ex.fk_excavations_equipment in (-1, 44))'+
        ' and (o.fk_orders_regions = '+ _reg +')'+
        ' and (ex.dtime >= '''+DateToStr(F_Dt)+' 08:00:01'' )'+
        ' and (ex.dtime <= '''+DateToStr(F_Dt+1)+' 08:00:00'' )';
         { //   РАБОТАЛИ    }

      b_rab := AppendBlago(SEL_ZAP, F_RegList.NameByIndex(i)+'_zap',  progress_shag);
      b_zap := AppendBlago(SEL_RAB, F_RegList.NameByIndex(i)+'_rab',  progress_shag);
      tmp_count :=  tmp_count or b_rab or b_zap;

//      if not AppendBlago(SEL_ZAP, F_RegList.NameByIndex(i)+'_zap',  progress_shag) then exit;
//      if not AppendBlago(SEL_RAB, F_RegList.NameByIndex(i)+'_rab',  progress_shag) then exit;

//    MyOpenIBDS(dset, Format(SEL_SQL, [F_RegList.IDByIndex(i)]));
   {
    while not dset.Eof do
    begin
      if md_EquipBlago.Eof then
        md_EquipBlago.Append
      else
        md_EquipBlago.Edit;

      md_EquipBlago.FieldByName(F_RegList.NameByIndex(i)).AsString:=
        dset.FieldByName('equip_number').AsString;

      md_EquipBlago.Post;
      md_EquipBlago.Next;
      dset.Next;
    end;
    }
{    md_EquipBlago.First;
    dset.First;
  if (not dset.Eof) then tmp_count := true;
    repeat;
      if md_EquipBlago.Eof then
        md_EquipBlago.Append
      else
        md_EquipBlago.Edit;

      md_EquipBlago.FieldByName(F_RegList.NameByIndex(i)).AsString:=
        dset.FieldByName('equip_number').AsString;

      md_EquipBlago.Post;
      md_EquipBlago.Next;
      dset.Next;
    until dset.Eof;

    md_EquipBlagoForGen.First;
    dset.First;

    while not dset.Eof do
    begin
      if md_EquipBlagoForGen.Eof then
        md_EquipBlagoForGen.Append
      else
        md_EquipBlagoForGen.Edit;

      md_EquipBlagoForGen.FieldByName(F_RegList.NameByIndex(i)).AsString:=
        dset.FieldByName('equip_number').AsString;

      md_EquipBlagoForGen.Post;
      md_EquipBlagoForGen.Next;
      dset.Next;
    end;


    IncProgressStatus(progress_shag); }
  end; // end for i
    if tmp_count then frVariables['TMP_COUNT']:= 1 else frVariables['TMP_COUNT']:= 0;
  Result:=true;
  except
  result:=false;
  end;
end;

procedure Tdm_SvodkaGik.GetNumAndDateShift(var num: integer; var dt: TDate);
begin
  if dset.Transaction.InTransaction then
    dset.Transaction.Rollback;
  dset.Transaction.StartTransaction;
  try
    MyOpenIBDS(dset, 'select ShiftNumber, ShiftDate from ServantTable');
    num:=dset.FieldByName('ShiftNumber').AsInteger;
    dt:=dset.FieldByName('ShiftDate').AsDateTime;

    dset.Transaction.Commit;
  except
    on E: Exception do
    begin
      dset.Transaction.Rollback;
      raise Exception.Create(E.Message+('Tdm_SvodkaGik.GetNumAndDateShift'));
    end
  end;
end;

procedure Tdm_SvodkaGik.SetOrderComingCount;
  function GetAddCond: string;
  begin
    if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
    begin
      Result:=' (o.DateComing>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.DateComing<='''+DateToStr(F_Dt+1)+' 6:00:00'')';
    end else
    begin
      Result:=' (o.DateComing>='''+DateToStr(F_Dt)+''')'+
              ' and (o.DateComing<='''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumber='+IntToStr(F_ShiftNumber)+')'
    end
  end;
begin
  MyOpenIBDS(dset, 'select count(*) kol from orders o where '+GetAddCond);
  F_OrderComingCount:=dset.FieldByName('kol').AsInteger;
end;

procedure Tdm_SvodkaGik.SetDepartureCount;
  function GetAddCond: string;
  begin
    if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
    begin
      Result:=' and (o.DateComing>='''+DateToStr(F_Dt)+' 6:00:01'')'+
              ' and (o.DateComing<='''+DateToStr(F_Dt+1)+' 6:00:00'')';
    end else
    begin
      Result:=' and (o.DateComing>='''+DateToStr(F_Dt)+''')'+
              ' and (o.DateComing<='''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumber='+IntToStr(F_ShiftNumber)+')'
    end
  end;
begin
  MyOpenIBDS(dset,
    ' select count(*) kol'+
    ' from orders o, departures d, brigadiers b'+
    ' where'+
    ' (d.fk_departures_orders=o.id)'+
    ' and (d.depnumber=1)'+
    ' and (d.fk_departures_brigadiers<>-1)'+
    ' and (d.fk_departures_brigadiers=b.id)'+
     GetAddCond);
  F_DepartureCount:=dset.FieldByName('kol').AsInteger;
end;

procedure Tdm_SvodkaGik.SetClosedOrderCount;
  function GetAddCond: string;
  begin
    if (not F_IsShiftNumberUchit) or (trunc(F_Dt)<>trunc(F_ShiftDate)) then
    begin
      Result:=' and (o.DateComing>'''+DateToStr(F_Dt)+''') and (o.DateComing<='''+DateToStr(F_Dt+1)+''')'+
              ' and (o.DateClosed>='''+DateToStr(F_Dt)+' 06:00:01'')'+
              ' and (o.DateClosed<='''+DateToStr(F_Dt+1)+' 06:00:00'')';
    end else
    begin
      Result:=' and (o.DateClosed>='''+DateToStr(F_Dt)+''')'+
              ' and (o.DateClosed<'''+DateToStr(F_Dt+2)+''')'+
              ' and (o.ShiftNumber='+IntToStr(F_ShiftNumber)+')';
    end;
  end;
begin
  MyOpenIBDS(dset,
    ' select count(*) kol'+
    ' from orders o'+
    ' left join departures d on (d.fk_departures_orders=o.id) and (d.depnumber=1)'+
    ' left join brigadiers b on (b.id=d.fk_departures_brigadiers)'+
    ' where (o.IsClosed)=1'+
       GetAddCond);

  F_ClosedOrderCount:=dset.FieldByName('kol').AsInteger;

    MyOpenIBDS(dset,
    ' select count(*) kol'+
    ' from orders o'+
    ' left join departures d on (d.fk_departures_orders=o.id) and (d.depnumber=1)'+
    ' left join brigadiers b on (b.id=d.fk_departures_brigadiers)'+
    ' where (o.IsClosed)=1'+
    ' and (o.DateClosed>='''+DateToStr(F_Dt)+' 06:00:01'')'+
              ' and (o.DateClosed<='''+DateToStr(F_Dt+1)+' 06:00:00'')');

  F_ClosedOrderAllCount:=dset.FieldByName('kol').AsInteger;

end;

function Tdm_SvodkaGik.PrepareHeaderInfo(percent: integer): boolean;
type
  TSetProc=procedure of object;
const
  SHAG_COUNT=5;
var
  progress_shag, i: integer;
  proc_arr: array [1..SHAG_COUNT] of TSetProc;
begin
  Result:=false;

  {Инициалицируем данные}
  proc_arr[1]:=SetOrderComingCount;
  proc_arr[2]:=SetDepartureCount;
  proc_arr[3]:=SetClosedOrderCount;
  proc_arr[4]:=SetTemperature;
  proc_arr[5]:=SetZayvComing; //поступило заявок 11.07.2013

  progress_shag:=GetProgressShagLength(percent, SHAG_COUNT);
  {/Инициалицируем данные}
  try
  {Заполнение}
  for i:=1 to SHAG_COUNT do
  begin
    if F_IsStopProgress then exit;
    proc_arr[i];
    IncProgressStatus(progress_shag);
  end; //end for i
  {/Заполнение}

  Result:=true;
  except
  result:=false;
  end;
end;

procedure Tdm_SvodkaGik.SetTemperature;
begin
  MyOpenIBDS(dset,
    ' select temperature from temperatures'+
    ' where cast(tempdate as Date)='''+DateToStr(F_Dt)+'''');
  F_Temperature:=dset.FieldByName('temperature').AsInteger;
end;

function Tdm_SvodkaGik.PrepareInfoForStDisp(percent: integer): boolean;
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
    kanal_vsego:=0;
    PodtopTepSetei:=0;
    NetLukov:=0;
  end;
  ArrStDispProc[1]:=StDisp_GikPart;
  ArrStDispProc[2]:=StDisp_KilledDmg;
  ArrStDispProc[3]:=StDisp_SvodVedExc;
  ArrStDispProc[4]:=StDisp_ProfWork;
  ArrStDispProc[5]:=StDisp_Counts062;
  {/Инициализация}

  progress_shag:=GetProgressShagLength(percent, SHAG_COUNT);

  for i:=low(ArrStDispProc) to High(ArrStDispProc) do
  begin
    ArrStDispProc[i];
    IncProgressStatus(progress_shag);
    if F_IsStopProgress then exit;
  end;

  Result:=true;
end;

function Tdm_SvodkaGik.PrepareREP_GIK_DOP(percent: integer): boolean;
const
  SHAG_COUNT=1;
var
  progress_shag, i: integer;
  sDT: string;
begin
  {Заполняет таблицу REP_DOP_GIK.
  Данная таблица в сводке в ГИК не используется.
  Она нужна для формирования сводки "Количество отказов"}

  progress_shag:=GetProgressShagLength(percent, SHAG_COUNT);

  sDT:=DateToStr(F_Dt);
  try

  MyExecIBSQL(IBSQL, 'delete from REP_GIK_DOP where DT='''+sDT+'''');

  md_DmgByRegion.First;
  while not md_DmgByRegion.Eof do
  begin
    for i:=0 to F_DmgPlaceList.Count-1 do
    begin
      if md_DmgByRegion.FieldByName(F_DmgPlaceList.NameByIndex(i)).AsInteger>0 then
      begin
        MyExecIBSQL(IBSQL,
          Format('insert into REP_GIK_DOP(KOL_ORDERS, DT, FK_REGIONS, FK_DMGPLACE) values(%d, ''%s'', %d, %s)',
          [md_DmgByRegion.FieldByName(F_DmgPlaceList.NameByIndex(i)).AsInteger,
          sDT,
          md_DmgByRegion.FieldByName('id_reg').AsInteger,
          F_DmgPlaceList.IDByIndex(i)]));
      end;
    end;
    md_DmgByRegion.Next;
  end;

  IncProgressStatus(progress_shag);
  Result:=true;
  except
  result:=false;
  end;
end;

procedure Tdm_SvodkaGik.StDisp_GikPart;
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

      inc(kanal_vsego, md_DmgByRegion.FieldByName('kanal').AsInteger);
      inc(PodtopTepSetei, md_DmgByRegion.FieldByName('PodtopTepSetei').AsInteger);
      inc(NetLukov, md_DmgByRegion.FieldByName('NetLukov').AsInteger);
      md_DmgByRegion.Next;
    end;
    //
    {md_DmgByStreet.First;
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
    }
    preparebystreetfast(1);
    //
    TechejIzZemli:=VodoSetiVsego+VvodyVsego;
    TecheyIzKolodtsev:=KolodtsyVsego;
    NeispravnyxKolonok:=KolonkiVsego;
    UstanovlenoLukov:=LukovVsego;
  end;
end;

procedure Tdm_SvodkaGik.StDisp_KilledDmg;
var
  sql_likvid, sql_ne_zasypano, sql_postupilo: string;
begin
  sql_likvid:=
    ' select count(*)'+
    ' from orders'+
    ' where (IsClosed=1)'+
    ' and (DateClosed>='+QuotedStr(DateToStr(F_Dt))+') and (DateClosed<='+QuotedStr(DateToStr(F_Dt+1))+')'+
    ' and (fk_orders_damageplace in (1,2))';

  sql_ne_zasypano:=sql_likvid+' and (lastexcwrktype in (2,3))';

  sql_postupilo:=
    ' select count(*)'+
    ' from orders'+
    ' where '+
    ' (DateComing>='+QuotedStr(DateToStr(F_Dt))+') and (DateComing<='+QuotedStr(DateToStr(F_Dt+1))+')'+
    ' and (fk_orders_damageplace in (1,2))';

  F_DataForStDisp.Likvidirovano:=SimpleOpenDset(sql_likvid);
  F_DataForStDisp.IzNihNeZasypano:=SimpleOpenDset(sql_ne_zasypano);
  F_DataForStDisp.IzNihZasypano:=F_DataForStDisp.Likvidirovano-F_DataForStDisp.IzNihNeZasypano;
  F_DataForStDisp.Postupilo:=SimpleOpenDset(sql_postupilo);
end;

procedure Tdm_SvodkaGik.StDisp_ProfWork;
var
  sql: string;
begin
  sql:=
    ' select count(*)'+
    ' from orders'+
    ' where'+
    ' (DateComing>='+QuotedStr(DateToStr(F_Dt))+') and (DateComing<='+QuotedStr(DateToStr(F_Dt+1))+')'+
    ' and (fk_orders_damageplace=22)';
//    ' and (fk_orders_damageplace=8)';
//    ' and (fk_orders_messagetypes in (3001, 3026))';

  F_DataForStDisp.UstanovlenoGidrantov:=SimpleOpenDset(sql);
end;

procedure Tdm_SvodkaGik.StDisp_Counts062;
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


procedure Tdm_SvodkaGik.StDisp_SvodVedExc;
var
  sql: string;
  id_region, dmg_count: integer;
begin
  sql:=
    ' select fk_orders_regions, count(id) DmgCount'+
    ' from orders'+
    ' where not (fk_orders_damagelocality in (-1, 4))'+
    ' and (DateComing>''01.01.2004'')'+
    ' and (IsClosed=1)'+
    ' and (lastexcwrktype in (2,3,9))'+
    ' and (fk_orders_damageplace in (1,2,3))'+
    ' group by fk_orders_regions'+
    ' order by 1';

  MyOpenIBDS(dset, sql);
  while not dset.Eof do
  begin
    id_region:=dset.FieldByName('fk_orders_regions').AsInteger;
    dmg_count:=dset.FieldByName('DmgCount').AsInteger;
    case id_region of
      1: F_DataForStDisp.NeZasypanoPoGorodu_Dzerzh:=dmg_count;     //ДЗЕРЖИНСКИЙ
      2: F_DataForStDisp.NeZasypanoPoGorodu_Kiev:=dmg_count;       //КИЕВСКИЙ
      3: F_DataForStDisp.NeZasypanoPoGorodu_Komintern:=dmg_count;  //КОМИНТЕРНОВСКИЙ
      4: F_DataForStDisp.NeZasypanoPoGorodu_Lenin:=dmg_count;      //ЛЕНИНСКИЙ
      5: F_DataForStDisp.NeZasypanoPoGorodu_Moskov:=dmg_count;     //МОСКОВСКИЙ
      6: F_DataForStDisp.NeZasypanoPoGorodu_Oktjabr:=dmg_count;    //ОКТЯБРЬСКИЙ
      7: F_DataForStDisp.NeZasypanoPoGorodu_Ordzhon:=dmg_count;    //ОРДЖОНИКИДЗЕВСКИЙ
      8: F_DataForStDisp.NeZasypanoPoGorodu_Frunz:=dmg_count;      //ФРУНЗЕНСКИЙ
      9: F_DataForStDisp.NeZasypanoPoGorodu_Chervon:=dmg_count;    //ЧЕРВОНОЗАВОДСКИЙ
    end;
    dset.Next;
  end;
  dset.Close;

  F_DataForStDisp.NeZasypanoPoGorodu_Vsego:=
      F_DataForStDisp.NeZasypanoPoGorodu_Dzerzh+
      F_DataForStDisp.NeZasypanoPoGorodu_Kiev+
      F_DataForStDisp.NeZasypanoPoGorodu_Komintern+
      F_DataForStDisp.NeZasypanoPoGorodu_Lenin+
      F_DataForStDisp.NeZasypanoPoGorodu_Moskov+
      F_DataForStDisp.NeZasypanoPoGorodu_Oktjabr+
      F_DataForStDisp.NeZasypanoPoGorodu_Ordzhon+
      F_DataForStDisp.NeZasypanoPoGorodu_Frunz+
      F_DataForStDisp.NeZasypanoPoGorodu_Chervon;
end;

function Tdm_SvodkaGik.SimpleOpenDset(SelSQL: string): integer;
begin
  MyOpenIBDS(dset, SelSQL);
  Result:=dset.Fields[0].AsInteger;
  dset.Close;
end;

function Tdm_SvodkaGik.PrepareDisconnections(percent: integer): boolean;
const
  SHAG_COUNT = 1;
begin
  //Result := false;
  try
  MyOpenIBDS( dset,
    ' select id, OrderNumber, DateComing,  fk_orders_regions, '+
    ' (select disconadress from get_disconnections_now(o.id, 0)) Disconnections, '+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '  o.housenum, o.additionaladdress)) adres,'+
    ' (select min(closedate) from closedbolts where fk_closedbolts_orders=o.id) CloseDate' +
    ' from orders o'+
    ' where IsClosed=0 and'+
    ' id in'+
    ' (select fk_closedbolts_orders from closedbolts'+
    ' where fk_closedbolts_orders=o.id and'+
    ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))'+
    ' order by 6,3' );

  mt_Disconnections.LoadFromDataSet( dset, [ mtcpoStructure ] );
  IncProgressStatus( GetProgressShagLength( percent, SHAG_COUNT ));

  Result := true;
  except
   result:=false;
  end;
end;

function Tdm_SvodkaGik.PrepareMeteoInfo(percent: integer): boolean;
const
  SHAG_COUNT = 1;
var
  _ClorDM: TDM_Clor;
begin
  //Result := false;

  _ClorDM := TDM_Clor.Create( nil );
  try
    if _ClorDM.ConnectToClorBase then
    begin
      _ClorDM.tran.StartTransaction;
      try
        MyOpenIBDS( _ClorDM.dset,
          ' select m.mydate, m.mytime, m.temperate, m.temperate_night,' +
          ' m.speed, c.cloudsn, so.name_r osadkin, ss.name_r shtormn, w.windn' +
          ' from meteo m' +
          ' left join wind w on w.windid = m.direction' +
          ' left join clouds c on c.cloudsid = m.clouds' +
          ' left join s_osadki so on so.id = m.osadki' +
          ' left join s_shtorm ss on ss.id = m.shtorm' +
          ' where m.mydate = ''' + DateToStr( F_Dt + 1 ) + ''' ' );

        mt_Meteo.LoadFromDataSet( _ClorDM.dset, [ mtcpoStructure ] );

        _ClorDM.tran.Commit;
      except
        on E: Exception do
        begin
          _ClorDM.tran.Rollback;
          E.Message := E.Message + 'Tdm_SvodkaGik.PrepareMeteoInfo';
          raise;
        end;
      end;
    end;
  finally
    _ClorDM.Free;
  end;

  IncProgressStatus( GetProgressShagLength( percent, SHAG_COUNT ));

  Result := true;
end;

function Tdm_SvodkaGik.PrepareOpenedOrdersGenDir(Percent: integer): boolean;
const
  SHAG_COUNT = 1;

begin
  try
  MyOpenIBDS( dset,
    ' select id, OrderNumber, DateComing,  fk_orders_regions, '+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '  o.housenum, o.additionaladdress)) adres'+
    ' from orders o'+
    ' where IsClosed=0 and o.fk_orders_organisations = 19'+
    ' order by id' );

  mt_OpenOrdersGenDir.LoadFromDataSet( dset, [ mtcpoStructure ] );
  IncProgressStatus( GetProgressShagLength( percent, SHAG_COUNT ));

  Result := true;
  except
   result:=false;
  end;
end;

function Tdm_SvodkaGik.Simple_PrepareDsets: boolean;
begin
  Result:=true;

  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  if  not IsLoad then
  try
    if not PrepareDmgByRegion_Six(50) then Result:=false
    else
    {if not PrepareDmgByStreet(25) then Result:=false
    else}
    begin
     if (Result) and (not PrepareHeaderInfo(20)) then Result:=false
      else
     if not PrepareInfoForStDisp(20) then Result:=false
   //   else
    //  if not PrepareMeteoInfo(10) then Result:=false

     else
     begin
      SaveIP();
      result:=SaveToBase;

     end
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_SvodkaGik.SimplePrepareDsets)');
    end;
  end
  else
  result:=false;
end;

function Tdm_SvodkaGik.SaveToBase:boolean;
const SQL ='insert into SVODKAGIK_SAVE'+
                           ' (DATEFORM, FIELNAME, SAVE_VALUE) values'+
                           ' (current_timestamp,''%s'',%d )';
var sdt:string;

begin
  sdt:=DateToStr(Date())+' '+TimeToStr(Time());
   Result:=true;
  if  not isLoad() then begin
 with F_DataForStDisp do
  begin
    MyExecIBSQL(IBSQL,Format(SQL,['VodoSetiVsego',VodoSetiVsego]));
    MyExecIBSQL(IBSQL,Format(SQL,['VvodyVsego',VvodyVsego]));
    MyExecIBSQL(IBSQL,Format(SQL,['KolodtsyVsego',KolodtsyVsego]));
    MyExecIBSQL(IBSQL,Format(SQL,['KolonkiVsego',KolonkiVsego]));
    MyExecIBSQL(IBSQL,Format(SQL,['LukovVsego',LukovVsego]));
    MyExecIBSQL(IBSQL,Format(SQL,['LikvidNaVodoSetyax',LikvidNaVodoSetyax]));
    MyExecIBSQL(IBSQL,Format(SQL,['LikvidNaVvodax',LikvidNaVvodax]));
    MyExecIBSQL(IBSQL,Format(SQL,['UstanLukov',UstanLukov]));
    MyExecIBSQL(IBSQL,Format(SQL,['PostupNaVodoSetyax',PostupNaVodoSetyax]));
    MyExecIBSQL(IBSQL,Format(SQL,['PostupNaVvodax',PostupNaVvodax]));

     MyExecIBSQL(IBSQL,Format(SQL,['TechejIzZemli',TechejIzZemli]));
     MyExecIBSQL(IBSQL,Format(SQL,['TecheyIzKolodtsev',TecheyIzKolodtsev]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeispravnyxKolonok',NeispravnyxKolonok]));
     MyExecIBSQL(IBSQL,Format(SQL,['UstanovlenoLukov',UstanovlenoLukov]));
     MyExecIBSQL(IBSQL,Format(SQL,['Likvidirovano',Likvidirovano]));
     MyExecIBSQL(IBSQL,Format(SQL,['IzNihZasypano',IzNihZasypano]));
     MyExecIBSQL(IBSQL,Format(SQL,['Postupilo',Postupilo]));

     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Vsego',NeZasypanoPoGorodu_Vsego]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Dzerzh',NeZasypanoPoGorodu_Dzerzh]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Komintern',   NeZasypanoPoGorodu_Komintern]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Ordzhon',NeZasypanoPoGorodu_Ordzhon]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Kiev', NeZasypanoPoGorodu_Kiev]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Moskov',NeZasypanoPoGorodu_Moskov]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Frunz',NeZasypanoPoGorodu_Frunz]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Lenin',NeZasypanoPoGorodu_Lenin]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Oktjabr', NeZasypanoPoGorodu_Oktjabr]));
     MyExecIBSQL(IBSQL,Format(SQL,['NeZasypanoPoGorodu_Chervon', NeZasypanoPoGorodu_Chervon]));


     MyExecIBSQL(IBSQL,Format(SQL,['UstanovlenoGidrantov', UstanovlenoGidrantov]));
     MyExecIBSQL(IBSQL,Format(SQL,['CountGet062', CountGet062]));
     MyExecIBSQL(IBSQL,Format(SQL,['CountClose062', CountClose062]));
     MyExecIBSQL(IBSQL,Format(SQL,['CountLeft062', CountLeft062]));

     MyExecIBSQL(IBSQL,Format(SQL,['kanal_vsego',kanal_vsego]));
     MyExecIBSQL(IBSQL,Format(SQL,['PodtopTepSetei',PodtopTepSetei]));
     MyExecIBSQL(IBSQL,Format(SQL,['NetLukov',NetLukov]));


 end;
   MyExecIBSQL(IBSQL,Format(SQL,['OrderComingCount', OrderComingCount]));
   MyExecIBSQL(IBSQL,Format(SQL,['ClosedOrderCount', ClosedOrderCount]));
   MyExecIBSQL(IBSQL,Format(SQL,[F_IPList.Text, -1]));
  end
  else  Result:=false;
end;


function Tdm_SvodkaGik.IsLoad:boolean;

begin
MyOpenIBDS(dset,'select * from SVODKAGIK_SAVE where DATEFORM>='''+DateToStr(Date())+' 6:00:01'' ');

Result:=not dset.IsEmpty;
end;

function Tdm_SvodkaGik.PrepareByRefionsSix(percent :integer):boolean; //31.07.2012

var  progress_shag:integer;
var s:integer;

begin
result:=false;;
try
 MyOpenIBDS(dset,Format('select * from SVODKAGIK_SAVE where'+
                ' DATEFORM>=''%s 06:00:01''  and'+
                ' FielName in (''VodoSetiVsego'',''VvodyVsego'','+
                ' ''KolodtsyVsego'',''KolonkiVsego'','+
                ' ''LukovVsego'',''kanal_vsego'','+
                ' ''PodtopTepSetei'',''NetLukov'')',[DateToStr(Date())]));




 if  not dset.Eof then
  with md_ByRegions_six do
  begin
   Close;
   Open;
   Append;
   dset.First ;
   while not dset.Eof  do begin
       FieldByName(dset.fieldByname('fielname').AsString).AsInteger:=dset.FieldByName('Save_Value').AsInteger;
       dset.Next;
   end;
   FieldByName('reg_name').asstring:='Всего на 6:00';
   FieldByName('id_reg').AsInteger:=0;
   Post;
 end;
 IncProgressStatus( GetProgressShagLength( percent, 1 ));

 REsult:=true;
 except
  result:=false;
 end;

end;

function  Tdm_SvodkaGik.PrepareByRegionDetail(percent: integer): boolean;


  function get_sel_sql(select, dmg_name: string): string;
	var
		_s: string;
  begin


			Result:=select;
     _s := '  (o.fk_orders_damageplace='+F_DmgPlaceList.IDByName[dmg_name]+')';

    Result:=Result+
      ' from orders o'+
      ' where'+
      _s +
     ' and (o.IsClosed=0)'+
     ' order by 3'
  end;
const GROUP_COUNT=2;
  SQL_SELECT=' select o.DATECOMING,o.DATECLOSED,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) region,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '   o.housenum, o.additionaladdress))  adress';
var progress_shag:integer;

begin
 Result:=false;
 progress_shag:=GetProgressShagLength(percent, GROUP_COUNT);
 md_ByRegionDeteil.Close;
 md_ByRegionDeteil.Open;
 try
 if not
    AppendGroupToDmgByREgion (dgLikvidVseti,'Осталось сети',
                           get_sel_sql(SQL_SELECT,'vseti'),progress_shag)
 then exit;
 if not
   AppendGroupToDmgByREgion (dgLikvidVvody,'Осталось вводы',
                           get_sel_sql(SQL_SELECT,'vvody'),progress_shag)
 then exit;
 if not
   AppendGroupToDmgByREgion (dgLikvidTeplSety,'Остались скрытые течи',
                           get_sel_sql(SQL_SELECT,'PodtopTepSetei'),progress_shag)
 then exit;


   Result:=true;
   except
    result:=false;
   end;
end;



function Tdm_SvodkaGik.AppendGroupToDmgByREgion(group: TDamageGroup;
  group_name, sel_sql: string; progress_shag: integer): boolean;
begin
  Result:=false;
  MyOpenIBDS(dset, sel_sql);
  dset.First;

  repeat
    if F_IsStopProgress then exit;

    with md_ByRegionDeteil do
    begin

      Append;
      FieldByName('group_number').AsInteger:=ord(group);
      FieldByName('group_name').AsString:=group_name;
      FieldByName('Region').AsString:=dset.FieldByName('region').AsString;
       FieldByName('DATECOMING').AsDateTime:=dset.FieldByName('DATECOMING').AsDateTime ;
      FieldByName('adress').AsString:=dset.FieldByName('adress').AsString;
      Post;
    end; // end with
    dset.Next;
  until dset.Eof;

   IncProgressStatus(progress_shag);

  Result:=true;
end;

function Tdm_SvodkaGik.preparebystreetfast(progress_shag:integer):boolean;
const SQL='select '+
' iif(o.factdatecoming>=''%s'' and o.factdatecoming<=''%s'',10,0) +'+
' iif(o.factdateclosed>=''%s'' and o.factdateclosed<=''%s'',20,0) +' +
' o.fk_orders_damageplace prisn,  count(*) Cn'+
' from orders o where ((o.factdatecoming>''%s'' and o.factdatecoming<=''%s'')'+
' or (o.factdateclosed  >''%s'' and o.factdateclosed  <=''%s'') )'+
' and o.fk_orders_damageplace in( 1,2)'+
' group by 1';
var strd1, strd2 :string;

begin

  strd1:=DateToStr(F_DT)+' 6:00:00';
  strd2:=DateToStr(F_DT+1)+' 6:00:01';
  Result:=false;
  MyOpenIBDS(dset,format(SQL,[strd1,strd2,strd1,strd2,strd1,strd2,strd1,strd2]));
 // with   F_DataForStDisp do
  begin
   dset.First;
   while  not dset.Eof do begin
    case dset.FieldByName('prisn').AsInteger of

    11: F_DataForStDisp.PostupNaVodoSetyax:=F_DataForStDisp.PostupNaVodoSetyax+dset.fieldbyname('Cn').AsInteger;

    12: F_DataForStDisp.PostupNavVodax:=F_DataForStDisp.PostupNavVodax+dset.fieldbyname('Cn').AsInteger;
    21: F_DataForStDisp.LikvidNaVodoSetyax:=F_DataForStDisp.LikvidNaVodoSetyax+dset.fieldbyname('Cn').AsInteger;

    22: F_DataForStDisp.LikvidNaVvodax:=F_DataForStDisp.LikvidNaVvodax+dset.fieldbyname('Cn').AsInteger;

    31: begin
            F_DataForStDisp.PostupNaVodoSetyax:=F_DataForStDisp.PostupNaVodoSetyax+dset.fieldbyname('Cn').AsInteger;
            F_DataForStDisp.LikvidNaVodoSetyax:=F_DataForStDisp.LikvidNaVodoSetyax+dset.fieldbyname('Cn').AsInteger;
        end;

    32: begin
            F_DataForStDisp.PostupNavVodax:=F_DataForStDisp.PostupNavVodax+dset.fieldbyname('Cn').AsInteger;
            F_DataForStDisp.LikvidNaVvodax:=F_DataForStDisp.LikvidNaVvodax+dset.fieldbyname('Cn').AsInteger;
        end;
    end ;
    dset.Next;
   end;
  end;

end;

procedure Tdm_SvodkaGik.SetZayvComing; //поступило заявок 11.07.2013
var parsstr,executstr:string;
    trunk1_1562,failure_1562,trunk_telephone,trunk2_1562 :integer;
    i:integer;
begin
 try
 if   not ADOQ_ComingZayv.Connection.Connected then
   dm_main.ConnectADO1562('','');
 parsstr:=''''+Datetimeformat('mm.dd.yyyy',F_DT)+' 6:00:00'+''' , '''+Datetimeformat('mm.dd.yyyy',F_DT+1)+' 6:00:00'+''', 0';
 executstr:='execute spCountTendersOpenedPeriod '+parsstr;
 ADOQ_ComingZayv.SQL.Text:=executstr;
 ADOQ_ComingZayv.Open;
 ADODset.Recordset:=ADOQ_ComingZayv.Recordset;
 ADODset.Last;

 trunk1_1562:=ADODset.Fieldbyname('trunk_line_1562').AsInteger;
 failure_1562:=ADODset.Fieldbyname('failure_trunk_line_1562').AsInteger;
 trunk_telephone:=ADODset.Fieldbyname('trunk_line_telephone').AsInteger;
 i:=0;
 ADODset.Recordset:=ADOQ_ComingZayv.NextRecordset(i);
 ADODset.Last;
 trunk2_1562:=ADODset.Fieldbyname('trunk_line_1562').AsInteger;
 ADOQ_ComingZayv.Close;
 f_ZayvComing:=trunk1_1562+failure_1562+trunk_telephone+trunk2_1562;
 f_ZayvComing1562:=trunk1_1562+failure_1562+trunk2_1562;
 f_ZayvComingpeople:=trunk_telephone;
 except

 end;


end;

procedure Tdm_SvodkaGik.SaveIP;
var IPList, MacList:TStringList;
i:integer;
begin
 F_IPList:=TStringList.Create;
 MacList:=TStringList.Create;
 getfindmac(MacList,F_IPList);
end;
end.
