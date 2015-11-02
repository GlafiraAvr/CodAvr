unit AddPrintDModule;

interface

uses
  SysUtils, Classes, FR_Class, Forms, Windows, IBDatabase, DB,
  IBCustomDataSet, DModule, FR_DSet, FR_DBSet, RxMemDS,AvrPictersDModule,
  kbmMemTable;

type
  TPrintingDoc=(pdPropusk, pdOrder, pdOrder_vds);

  Tdm_AddPrint = class(TDataModule)
    frReport: TfrReport;
    dset: TIBDataSet;
    tran: TIBTransaction;
    frDset: TfrDBDataSet;
    dset2: TIBDataSet;
    frDset2: TfrDBDataSet;
    dset_Bolts: TIBDataSet;
    frDS_Bolts: TfrDBDataSet;
    dset_BoltsCLOSEDATE: TDateTimeField;
    dset_BoltsOPENDATE: TDateTimeField;
    dset_BoltsCLOSEPLACE: TIBStringField;
    dset_BoltsBRIGCLOSE: TIBStringField;
    dset_BoltsBRIGOPEN: TIBStringField;
    dset_BoltsTUBEDIAM: TIntegerField;
    dset_BoltsADRES: TIBStringField;
    dset_BoltsFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField;
    dset_discon_vds: TIBDataSet;
    frDSt_disc: TfrDBDataSet;
    dset_discon_vdsFK_DISCON_DISCONTYPE: TIntegerField;
    dset_discon_vdsG_ZHD: TIntegerField;
    dset_discon_vdsG_POD: TIntegerField;
    dset_discon_vdsG_STOJ: TIntegerField;
    dset_discon_vdsG_KV: TIntegerField;
    dset_discon_vdsG_ST_SP: TIntegerField;
    dset_discon_vdsDISCONTYPE: TIBStringField;
    dset_discon_vdsDATEDISCON: TDateTimeField;
    dset_discon_vdsFK_DISCON_EXECUTOR: TIntegerField;
    dset_discon_vdsEXECUTOR: TIBStringField;
    dset_discon_vdsBRIGADIR: TIBStringField;
    dset_discon_vdsDiscontype_all: TIBStringField;
    dset_discon_vdsDATECON: TDateTimeField;
    m_picters: TkbmMemTable;
    m_pictersid: TIntegerField;
    m_pictersPicter: TBlobField;
    m_pictersfilename: TStringField;
    procedure dset_BoltsBRIGOPENGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_discon_vdsCalcFields(DataSet: TDataSet);
  private
    F_PrintingDoc: TPrintingDoc;
    function LoadFromFile(short_fn: string): boolean;
    function LoadPicters(OrderID: integer):boolean;
    procedure LoadRedrawPict(str:string;num:integer;fielname:string) ;
    procedure ClearImage(mes:string);
    procedure ShowMess(s:string);
  public
    property PrintingDoc: TPrintingDoc read F_PrintingDoc write F_PrintingDoc;
    procedure Print;
    procedure PrintOrder(OrderID: integer);
    procedure PrintOrder_vds(OrderID: integer);
  end;

implementation

{$R *.dfm}

uses ApplicationSettings, HelpFunctions;

{ Tdm_AddPrint }

function Tdm_AddPrint.LoadFromFile(short_fn: string): boolean;
var
  full_fn: string;
begin
  full_fn:=AppSettings.Get_AddPrint_Dir+short_fn;

  Result:=frReport.LoadFromFile(full_fn);
  if not Result then
    Application.MessageBox(PChar('Не получается загрузить файл '+full_fn),
                            'Ошибка', MB_OK+MB_ICONERROR);
end;

procedure Tdm_AddPrint.Print;
var
  is_load: boolean;
begin
  is_load:=false;

  case F_PrintingDoc of
    pdPropusk: is_load:=LoadFromFile('Propusk.frf');
    pdOrder: is_load:=LoadFromFile('Order.frf');
    pdOrder_vds: is_load:=LoadFromFile('Order_vds.frf');
  end;

  if is_load then
  begin
    frReport.PrepareReport;

    frReport.ShowReport;
  end;
end;

procedure Tdm_AddPrint.PrintOrder(OrderID: integer);
var i:integer;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS(dset,
      ' select OrderNumber, DateComing, DateClosed, Abonent, IsPayed,' +
      ' (select orderworks from get_orderworks( o.id, 0, 1 )) WhatIsDone,' +
      ' (select orderworks from get_orderworks( o.id, 1, 0 )) What_Is_Done_In_First_Dep,' +
      ' (select disconadress from get_disconnections(o.id, 0.25)) Disconnections,' +
      ' (select name from s_Officials where id=o.fk_orders_officials) Officials,'+
      ' (select name from s_regions where id=o.fk_orders_regions) Regions,'+
      ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
      '    o.housenum, o.additionaladdress)) adres,'+
      ' (select MessageName from s_MessageTypes where id=o.fk_orders_messagetypes) MessageTypes,'+
      ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
      ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
      ' (select StartDate from Departures where (DepNumber=1) and (fk_departures_orders=o.id)) Dep1Start,'+
      ' (select b.name from brigadiers b, Departures d where (d.depnumber=1)'+
      '    and (b.id=d.fk_departures_brigadiers) and (d.fk_departures_orders=o.id)) Dep1Brig,'+
      ' (select name from s_organisations where id=o.fk_orders_organisations) organisations,'+
      ' (select min(StartDate) from Departures where (DepNumber<>1) and (fk_departures_orders=o.id)) Dep2Start,'+
      ' (select b.name from brigadiers b, Departures d where (d.depnumber=3)'+
      '    and (b.id=d.fk_departures_brigadiers) and (d.fk_departures_orders=o.id)) Dep2Brig,'+
      ' (select name from s_officials where id=o.fk_orders_officialclosed) OfficialClosed,'+
      ' (select diameter from s_Tubediameter where id=o.fk_orders_diameters) Diameters,'+
      ' (select name from s_TubeMaterial where id=o.fk_orders_tubematerial) TubeMaterial,'+
      ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
      ' (select workname from s_excavationworktypes where id=o.LastExcWrkType) excwt'+
      ' from orders o where id='+IntToStr(OrderID));

    dset_Bolts.Close;
    dset_Bolts.ParamByName('pOrderID').AsInteger:=OrderID;
    dset_Bolts.Open;

    LoadPicters(OrderID);

    if not(dset.Eof and dset.Bof) then
    begin
      F_PrintingDoc:=pdOrder;
      Print;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_AddPrint.PrintOrder)');
    end;
  end;

end;

procedure Tdm_AddPrint.dset_BoltsBRIGOPENGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if dset_Bolts.FieldByName('fk_closedbolts_brigadieropen').AsInteger=-1 then
    Text:=''
  else
    Text:=Sender.AsString;
end;


procedure Tdm_AddPrint.PrintOrder_vds(OrderID: integer);
var str:string;
begin
   if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
  str:=

    ' select o.ordernumber, (select FullOrderNum from get_fullordernum(o.ordernumber, o.fk_orders_district))  OrderNum,'+
    ' o.datecoming, o.dateclosed, o.applicantphone,'+
    ' (select substr1(works,18,500) from get_orderworks_vds( o.id, 1, 1 )) WhatIsDone_first,'+
    ' (select works from get_orderworks_vds( o.id, 2, 3 )) WhatIsDone,'+
    ' (select name from s_Officials where id=o.fk_orders_officials) Officials,'+
    ' (select name from s_regions where id=o.fk_orders_regions) Regions,'+
    ' (select adres from Get_adres_vds(o.fk_orders_streets,'+
    '          o.housenum,o.housingnum,o.porchnum,o.floornum,o.apartmentnum,o.porchkod)) adres,'+
    ' (select  trim(st.name)||'' ''||trim(ss.name)||'' кв''||trim(o.apartmentnum)'+
    '    from s_streets ss, s_streettypes st'+
    '    where ss.id=o.fk_orders_streets and ss.fk_streets_streettypes=st.id) adress1,'+
    ' (select sm.messagename  from s_messagetypes_vds sm  where (sm.id=o.fk_orders_messagetypes) ) messagetype,'+
    ' (select min(dvs.startdate) from departures_vds dvs where dvs.fk_departures_orders=o.id)  startdate,'+
    ' (select b.name from departures_vds dvs, brigadiers b  where dvs.id=(select min(dvs1.id) from departures_vds dvs1 where dvs1.fk_departures_orders=o.id )'+
    ' and b.id=dvs.fk_departures_brigadiers)   brig1,'+
    ' (select  dvs.startdate from departures_vds dvs where dvs.id='+
    '    (select min(id) from departures_vds dvs0 where dvs0.fk_departures_orders=o.id'+
    '        and dvs0.id>'+
    '          (select min(id) from departures_vds dvs1 where dvs1.fk_departures_orders=o.id))'+
    ' and  dvs.fk_departures_orders=o.id)  stardate2,'+
    ' (select max(dvs.enddate) from departures_vds dvs where dvs.fk_departures_orders=o.id)  enddate,'+
    ' (select   b.name from departures_vds dvs, brigadiers b where dvs.id= '+
    '     (select min(id) from departures_vds dvs0 where dvs0.id>'+
    '           (select min(id) from departures_vds dvs1 where dvs1.fk_departures_orders=o.id)'+
    '  and dvs0.fk_departures_orders=o.id) and  b.id=dvs.fk_departures_brigadiers'+
    '  and dvs.fk_departures_orders=o.id)  brig2,'+
    ' (select name from s_organisations where id=o.fk_orders_organisations) organisations,'+
    ' (select name from s_officials where id=o.fk_orders_officialclosed) OfficialClosed,'+
    ' (select dt.name from s_damagetype_vds dt where dt.id=o.fk_orders_damagetype) damagetype,'+
    ' (select name from brigadiers b  where b.id=o.FK_ORDERS_BRIGADIERS) brig,'+
    ' (select name  from brigadiers b, departures_vds dds where dds.id='+
    ' (select max(ID) from departures_vds dds1 where dds1.fk_departures_orders=o.id)'+
    '  and b.id=dds.fk_departures_brigadiers) brigclose,'+
    ' o.additionalinfo from orders_vds o'+
    ' where o.id='+IntToStr(OrderID);
    MyOpenIBDS(dset,str);

    if  dset_discon_vds.Active then
    dset_discon_vds.Close;
    dset_discon_vds.ParamByName('id').AsInteger:=OrderID;
    dset_discon_vds.Open;

    if not(dset.Eof and dset.Bof) then
    begin
      F_PrintingDoc:=pdOrder_vds;
      Print;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_AddPrint.PrintOrder_vds)');
    end;
  end;


end;

procedure Tdm_AddPrint.dset_discon_vdsCalcFields(DataSet: TDataSet);

begin
if not DataSet.FieldByName('DISCONTYPE').IsNull then
  DataSet.FieldByName('Discontype_all').AsString:=DataSet.FieldByName('DISCONTYPE').AsString
else
with DataSet do
begin

  FieldByName('Discontype_all').AsString:='' ;
  if  DataSet.FieldByName('g_zhd').AsInteger>0 then
   FieldByName('Discontype_all').AsString:=FieldByName('Discontype_all').AsString+'дом.-'+FieldByName('g_zhd').AsString+'; ';
  if DataSet.FieldByName('g_pod').AsInteger>0 then
   FieldByName('Discontype_all').AsString:=FieldByName('Discontype_all').AsString+'под.-'+FieldByName('g_pod').AsString+'; ';
  if DataSet.FieldByName('G_KV').AsInteger>0 then
   FieldByName('Discontype_all').AsString:=FieldByName('Discontype_all').AsString+'кв.-'+FieldByName('G_KV').AsString+'; ';
 if DataSet.FieldByName('G_STOJ').AsInteger>0 then
   FieldByName('Discontype_all').AsString:=FieldByName('Discontype_all').AsString+'стояк.-'+FieldByName('G_STOJ').AsString+'; ';
  if DataSet.FieldByName('g_st_sp').AsInteger>0 then
   FieldByName('Discontype_all').AsString:=FieldByName('Discontype_all').AsString+'сп. стояк.-'+FieldByName('g_st_sp').AsString+'; ';
end;
end;

function Tdm_AddPrint.LoadPicters(OrderID: integer): boolean;
var dm_Picters:Tdm_avrpicter;
    ntyp:integer;
begin
   dm_Picters:=Tdm_avrpicter.Create(nil);
   dm_Picters.ClearProc:= ClearImage;
   dm_picters.Showmes:=ShowMess;
   result:=false;
  try
   dm_Picters.F_ID_order:=OrderID;
   dm_Picters.Year:=GetYear(dset.fieldbyname('datecoming').AsDateTime);

   dm_Picters.Ordernumber:=dset.fieldbyname('ordernumber').AsInteger;
   if m_picters.Active then m_picters.Close;
   m_picters.Open;
   if  dm_picters.OpenDset then
   begin
     dm_Picters.OnRedraw:=LoadRedrawPict;
     for ntyp:=1 to 4 do
     begin

      m_picters.Append;
      m_picters.FieldByName('id').AsInteger:=ntyp;
      dm_Picters.SetTyp(ntyp);
      m_picters.Post;
      if m_picters.FieldByName('filename').AsString='' then
         m_picters.Delete;
      while not dm_Picters.mem.Eof do
      begin
       m_picters.Append;
       m_picters.FieldByName('id').AsInteger:=dm_Picters.f_typ;
       dm_Picters.mem.Next;
       m_picters.Post;
       if m_picters.FieldByName('filename').AsString='' then
         m_picters.Delete;

      end;
     end;
     result:=true;
   end;
   finally
     dm_Picters.free;
   end;

end;

procedure Tdm_AddPrint.LoadRedrawPict(str: string; num: integer;
  fielname: string);
begin
  if FileExists(str) then
  begin

    if m_picters.State = dsInsert then
    begin
      m_picters.FieldByName('filename').AsString:=str;
      TBlobField(m_picters.FieldByName('Picter')).LoadFromFile(str);
     
    end;
  end;
end;

procedure Tdm_AddPrint.ClearImage(mes:string);
begin
///
end;

 procedure Tdm_AddPrint.ShowMess(s:string);
 begin
// Showmessage(s);
 end;


end.
