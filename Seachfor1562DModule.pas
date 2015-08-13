unit Seachfor1562DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, IBCustomDataSet, DB, RxMemDS, IBDatabase,
  FR_Class,UniversalSearch2DModule;

type



  TPRegionRec=^TRegionRec;
  Tdm_Seachfor1562 = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TRxMemoryData;
    ResultDsetid: TIntegerField;
    ResultDsetDateComing: TDateField;
    ResultDsetFlowSpeed: TFloatField;
    ResultDsetRegions: TStringField;
    ResultDsetDamagePlace: TStringField;
    ResultDsetDamageType: TStringField;
    ResultDsetDiameter: TIntegerField;
    ResultDsetLeak: TFloatField;
    ResultDsetAdres: TStringField;
    ResultDsetid_region: TIntegerField;
    ResultDsetptr_add_info: TIntegerField;
    ResultDsetwhatisdone: TStringField;
    ResultDsetDateClosed: TDateField;
    ResultDsetHouseType: TIntegerField;
    ResultDsetHouseNum: TStringField;
    ResultDsetStreetID: TIntegerField;
    ResultDsetAddAddr: TStringField;
    ResultDsetAomTypeOfAvar: TIntegerField;
    ResultDsetisclosed: TIntegerField;
    ResultDsetsDateClosed: TStringField;
    dset: TIBDataSet;
    dset_number: TIBDataSet;
    result1562: TRxMemoryData;
    ResultDsetOrderNumber: TStringField;
    ResultDsetMessageTypes: TStringField;
    procedure FillResultDset;
    procedure FillResultDset_vds;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
      F_Condition: string;
    F_SortType: TSortType;
    F_IsAscSort: boolean;
    F_IsCalcLeak: boolean;
    F_strStartDate: string;
    F_strFinishedDate: string;
    F_RecordCount: integer;
    F_RegionList: TList;

    F_APP:integer;
    F_Sort_Column:string;
    F_regions:string; // если активен поиск по району передаем район
    procedure ClearRegionList;
    procedure FillRegionList;
   // procedure SetSortType(Value: TSortType);

    { Private declarations }
  public

    property Condition: string read F_Condition write F_Condition;
 //  property SortType: TSortType read F_SortType write SetSortType;
    property  SortCulumn:string read F_Sort_Column write F_Sort_Column;
    property IsCalcLeak: boolean read F_IsCalcLeak write F_IsCalcLeak;
    property strStartDate: string read F_strStartDate write F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate write F_strFinishedDate;
    property IsAscSort: boolean read F_IsAscSort write F_IsAscSort;
    property _APP:integer write F_APP;


    function PrepareDset: boolean;
    procedure GetOrderNumber(id_1562:integer; var id_order,is_closed:integer; var   id_number:string; var f_AddExcav:integer);
    function GetRecordCount: integer;
    procedure StartTransaction;
    procedure StopTransaction;
    { Public declarations }
    property Regions:string write F_regions;
  end;

var
  dm_Seachfor1562: Tdm_Seachfor1562;



implementation

 uses HelpFunctions, AomComClientDModule;
{$R *.dfm}


procedure Tdm_Seachfor1562.FillResultDset;
  function GetSortCondition: string;
  var
    s: string;
  begin
    if F_IsAscSort then s:=' asc'
    else s:=' desc';
     if F_Sort_Column='' then
       result:= 'order by adres ,DamagePlace'
      else
       result:='order by '+F_Sort_Column+' '+s;

    {case F_SortType of
      stOrderNumberAndDatecoming:
        Result:=' order by OrderNumber '+s+', DateComing ,DamagePlace';
      stRegions:
        Result:=' order by 5 ,6'+s;
      stAdres:
        Result:=' order by 6,9 '+s;
      else Result:='';
    end; }
  end;
var
  leak_cond: string;
  i, progress_shag: integer;
begin
  ResetProgressFields;
  progress_shag:=GetProgressShagLength(100, F_RecordCount);

  ResultDset.Close;
  ResultDset.Open;



  MyOpenIBDS(dset,
    ' select id, OrderNumber, cast(DateComing as Date) DateComing, FlowSpeed,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
    ' (select diameter from s_TubeDiameter where id=o.fk_orders_diameters) Diameter,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    ' o.housenum, o.additionaladdress)) adres, '+
    ' (select messagename from S_MessageTypes where id=o.fk_orders_messagetypes) MessageTypes,'+
    leak_cond+
    '  fk_orders_regions id_region,' +
  {  ' (select orderworks from get_orderworks( o.id, 0, 1 )) whatisdone,'+}
    '  cast(DateClosed as Date) DateClosed,'+
    ' o.fk_orders_housetypes HouseType, o.fk_orders_streets StreetID, o.HouseNum,'+
    ' o.additionaladdress AddAddr'+
    ' , o.IsClosed '+
    ' from orders o '+
    F_Condition+
    GetSortCondition()
    {' order by adres ,DamageType'});


  dset.First;
  while not dset.Eof do
  begin
    ResultDset.Append;
    for i:=0 to dset.FieldCount-1 do
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;

    if  (dset.FieldByName('isclosed').AsInteger = 1) then
        ResultDset.FieldByName('sdateclosed').AsString := dset.FieldByName('dateclosed').AsString
        else
        ResultDset.FieldByName('sdateclosed').AsString := '';
    ResultDset.Post;

    IncProgressStatus(progress_shag);
    dset.Next;
  end;
  dset.Close;
end;


procedure Tdm_Seachfor1562.ClearRegionList;
var
  i: integer;
begin
  for i:=0 to F_RegionList.Count-1 do
    if Assigned(F_RegionList.Items[i]) then
      Dispose(TPRegionRec(F_RegionList.Items[i]));
  F_RegionList.Clear;    
end;


procedure Tdm_Seachfor1562.FillRegionList;
var
  pReg: TPRegionRec;
  i: integer;
begin
  ClearRegionList;

  MyOpenIBDS(dset,
    ' select id, name from s_regions'+
    ' where id>-1 and activity is null'+
    ' order by name');

  dset.First;
  while not dset.Eof do
  begin
    new(pReg);
    pReg.id:=dset.FieldByName('id').AsInteger;
    pReg.name:=dset.FieldByName('name').AsString;
    pReg.dmg_count:=0;
    pReg.leak:=0;
    F_RegionList.Add(pReg);

    dset.Next;
  end;

  ResultDset.First;
  while not ResultDset.Eof do
  begin
    for i:=0 to F_RegionList.Count-1 do
    begin
      pReg:=TPRegionRec(F_RegionList.Items[i]);
      if pReg.id=ResultDset.FieldByName('id_region').AsInteger then
      begin
        ResultDset.Edit;
        ResultDset.FieldByName('ptr_add_info').AsInteger:=Integer(pReg);  
        ResultDset.Post;
        pReg.dmg_count:=pReg.dmg_count+1;
        pReg.leak:=pReg.leak+ResultDset.FieldByName('Leak').AsFloat;
        break;
      end;
    end;

    ResultDset.Next;
  end;
end;


function Tdm_Seachfor1562.GetRecordCount: integer;
begin
  MyOpenIBDS(dset, 'select count(id) kol from orders o '+F_Condition);
  Result:=dset.FieldByName('kol').AsInteger;
  dset.Close;
  F_RecordCount:=Result;
end;



function Tdm_Seachfor1562.PrepareDset: boolean;
begin
case f_App of
 2:FillResultDset;//HC
 3:FillResultDset_vds;//VDS
end;
  ;
  FillRegionList;


  Result:=true;
end;



{procedure Tdm_Seachfor1562.SetSortType(Value: TSortType);
begin
  if Value<>F_SortType then
  begin
    F_IsAscSort:=true;
    F_SortType:=Value;
  end else F_IsAscSort:=not F_IsAscSort;
end;}

procedure Tdm_Seachfor1562.StartTransaction;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_Seachfor1562.StopTransaction;
begin
  tran.Commit;
end;


procedure Tdm_Seachfor1562.GetOrderNumber(id_1562:integer; var id_order,is_closed:integer; var   id_number:string; var f_AddExcav:integer);
begin
  case f_App of
  2: MyOpenIBDS(dset_number,
           ' select  ns.id_order, o.ordernumber, o.isclosed, ns.add_excav'+
           ' from numsorders  ns, orders o where ns.id_1562='+
           IntTOStr(id_1562)+
           ' and ns.id_order=o.id');
  3: MyOpenIBDS(dset_number,
           ' select  ns.id_order,'+
           ' (select fullordernum from get_fullordernum(o.ordernumber,o.fk_orders_district)) ordernumber, o.isclosed,'+
           '  0 add_excav' +
           ' from numsorders_vds  ns, orders_vds o where ns.id_1562='+
           IntTOStr(id_1562)+
           ' and ns.id_order=o.id');
   end;

 id_order:=dset_number.FieldByName('id_order').AsInteger;
 id_number:=dset_number.FieldByName('ordernumber').AsString;
 is_closed:=dset_number.FieldByName('isclosed').AsInteger;
 f_AddExcav:=dset_number.FieldByName('add_excav').AsInteger;
end;

procedure Tdm_Seachfor1562.DataModuleCreate(Sender: TObject);
begin
  inherited;
   inherited;
  F_Condition:='';
  F_IsCalcLeak:=false;
  F_strStartDate:='';
  F_strFinishedDate:='';
  F_RegionList:=TList.Create;


end;

procedure Tdm_Seachfor1562.DataModuleDestroy(Sender: TObject);
begin
  inherited;
   ClearRegionList;
   F_RegionList.Free;

end;


procedure Tdm_Seachfor1562.FillResultDset_vds;
  function GetSortCondition: string;
  var
    s: string;
  begin
    if F_IsAscSort then s:='asc'
    else s:='desc';

    if (F_Sort_Column='') or (F_Sort_Column='DamagePlace') then
      result:=' order by adres '
    else
     result:=' order by '+F_Sort_Column+' '+s;
   { case F_SortType of
      stOrderNumberAndDatecoming:
        Result:=' order by OrderNumber '+s+', DateComing';
      stRegions:
        Result:=' order by 5 '+s;
      stAdres:
        Result:=' order by 7 '+s;
      else Result:='';
    end;}
  end;
var
  i, progress_shag: integer;
begin
  ResetProgressFields;
  progress_shag:=GetProgressShagLength(100, F_RecordCount);

  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS(dset,
//    ' select id, OrderNumber, DateComing, DateClosed,'+
//    ' o.OrderNumber FullOrderNum,'+
    ' select id, (select FullOrderNum from get_fullordernum(o.OrderNumber, o.fk_orders_district)) OrderNumber, DateComing, '+
    ' (select messagename from S_MessageTypes_vds where id=o.fk_orders_messagetypes) MessageTypes ,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_DamageType_vds where id=o.fk_orders_damagetype) DamageType,'+
    ' (select adres from get_adres_vds(o.fk_orders_streets, o.housenum,'+
    '     o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) adres,'+
    ' fk_orders_regions id_region'+
    ' from orders_vds o '+
    F_Condition+
    GetSortCondition());


  dset.First;
  while not dset.Eof do
  begin
    ResultDset.Append;
    for i:=0 to dset.FieldCount-1 do
   //   if   dset.Fields[i].FieldName='DateClosed' then
     //       ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=DateToStr()
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].AsString;
    ResultDset.Post;

    IncProgressStatus(progress_shag);
    dset.Next;
  end;
  dset.Close;
end;

end.
