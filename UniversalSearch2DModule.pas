unit UniversalSearch2DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DB, IBCustomDataSet,
  DModule, RxMemDS, FR_DSet, FR_DBSet, AomComTypesUnit, ObjListUnit;

type
  TSortType=(stOrderNumberAndDatecoming, stRegions, stAdres);

  TRegionRec=record
    id: integer;
    name: string;
    dmg_count: integer;
    leak: double;
  end;

  TPRegionRec=^TRegionRec;

  Tdm_UniversalSearch2 = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetid: TIntegerField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetFlowSpeed: TFloatField;
    ResultDsetRegions: TStringField;
    ResultDsetDamagePlace: TStringField;
    ResultDsetDamageType: TStringField;
    ResultDsetDiameter: TIntegerField;
    ResultDsetLeak: TFloatField;
    ResultDsetAdres: TStringField;
    ResultDsetid_region: TIntegerField;
    ResultDsetptr_add_info: TIntegerField;
    frDS_Result: TfrDBDataSet;
    ResultDsetwhatisdone: TStringField;
    ResultDsetDateClosed: TDateField;
    ResultDsetHouseType: TIntegerField;
    ResultDsetHouseNum: TStringField;
    ResultDsetStreetID: TIntegerField;
    ResultDsetAddAddr: TStringField;
    ResultDsetAomTypeOfAvar: TIntegerField;
    ResultDsetisclosed: TIntegerField;
    result1562: TRxMemoryData;
    dset_number: TIBDataSet;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetsDateClosed: TDateTimeField;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FillResultDset;
  private
    F_Condition: string;
    F_SortType: TSortType;
    F_IsAscSort: boolean;
    F_IsCalcLeak: boolean;
    F_strStartDate: string;
    F_strFinishedDate: string;
    F_RecordCount: integer;
    F_RegionList: TList;

    procedure FillRegionList;

    procedure ClearRegionList;
    procedure SetSortType(Value: TSortType);

  public
    property Condition: string read F_Condition write F_Condition;
    property SortType: TSortType read F_SortType write SetSortType;
    property IsCalcLeak: boolean read F_IsCalcLeak write F_IsCalcLeak;
    property strStartDate: string read F_strStartDate write F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate write F_strFinishedDate;
    property IsAscSort: boolean read F_IsAscSort write F_IsAscSort;

    function GetSumLeak: double;
    function GetRecordCount: integer;
    function PrepareDset: boolean;

    procedure FillAvarIDList( var _AvarIDList: TList );
    procedure SetAomTypeOfAvarInResultDset;

    procedure StartTransaction;
    procedure StopTransaction;
    procedure GetOrderNumber(id_1562:integer; var id_order, is_closed:integer; var   id_number:string);
  end;


implementation

{$R *.dfm}

uses HelpFunctions, AomComClientDModule;

procedure Tdm_UniversalSearch2.ClearRegionList;
var
  i: integer;
begin
  for i:=0 to F_RegionList.Count-1 do
    if Assigned(F_RegionList.Items[i]) then
      Dispose(TPRegionRec(F_RegionList.Items[i]));
  F_RegionList.Clear;    
end;

procedure Tdm_UniversalSearch2.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_Condition:='';
  F_IsCalcLeak:=false;
  F_strStartDate:='';
  F_strFinishedDate:='';
  F_RegionList:=TList.Create;
end;

procedure Tdm_UniversalSearch2.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ClearRegionList;
  F_RegionList.Free;
end;


procedure Tdm_UniversalSearch2.FillAvarIDList(var _AvarIDList: TList);
var
  _AvarID: integer;
begin
  _AvarIDList.Clear;
  with ResultDset do
  begin
    First;
    while not Eof do
    begin
      _AvarID := EncodeAomID(ResultDset.FieldByName('OrderNumber').AsInteger,
          ResultDset.FieldByName('DateComing').AsDateTime);

      _AvarIDList.Add( ptr( _AvarID ) );

      Next;
    end;
  end;
end;

procedure Tdm_UniversalSearch2.FillRegionList;
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

procedure Tdm_UniversalSearch2.FillResultDset;
  function GetSortCondition: string;
  var
    s: string;
  begin
    if F_IsAscSort then s:='asc'
    else s:='desc';

    case F_SortType of
      stOrderNumberAndDatecoming:
        Result:=' order by OrderNumber '+s+', DateComing';
      stRegions:
        Result:=' order by 5 '+s;
      stAdres:
        Result:=' order by 10 '+s;
      else Result:='';
    end;
  end;
var
  leak_cond: string;
  i, progress_shag: integer;
begin
  ResetProgressFields;
  progress_shag:=GetProgressShagLength(100, F_RecordCount);

  ResultDset.Close;
  ResultDset.Open;

  if  F_IsCalcLeak then
    leak_cond:=' (select Leak from get_leak_for_period(o.id, ''01.01.1900'', '+QuotedStr(DateToStr(Date))+')) Leak,'
  else
    leak_cond:='0 leak,';

  MyOpenIBDS(dset,
    ' select  distinct o.id, OrderNumber, DateComing, FlowSpeed,'+ {cast(DateComing as Date)}
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
    ' (select diameter from s_TubeDiameter where id=o.fk_orders_diameters) Diameter,'+
    leak_cond+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '  o.housenum, o.additionaladdress)) adres, fk_orders_regions id_region,' +
    ' (select orderworks from get_orderworks( o.id, 0, 1 )) whatisdone,'+
    '   DateClosed,'+{cast(DateClosed as Date)}
    ' o.fk_orders_housetypes HouseType, o.fk_orders_streets StreetID, o.HouseNum,'+
    ' o.additionaladdress AddAddr'+
    ' , o.IsClosed '+
    ' from orders o '+
    F_Condition+
    GetSortCondition);


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

function Tdm_UniversalSearch2.GetRecordCount: integer;
begin
  MyOpenIBDS(dset, 'select count(distinct o.id) kol from orders o '+F_Condition);
  Result:=dset.FieldByName('kol').AsInteger;
  dset.Close;
  F_RecordCount:=Result;
end;

function Tdm_UniversalSearch2.GetSumLeak: double;
begin
  Result:=0;
  ResultDset.First;
  while not ResultDset.Eof do
  begin
    Result:=Result+ResultDset.FieldByName('Leak').AsFloat;
    ResultDset.Next;
  end;
end;

function Tdm_UniversalSearch2.PrepareDset: boolean;
begin
  FillResultDset;
  FillRegionList;
{  if DM_AomCOmClient.IsMapWork then
    SetAomTypeOfAvarInResultDset;}

  Result:=true;
end;

procedure Tdm_UniversalSearch2.SetAomTypeOfAvarInResultDset;
var
  _AvarIDList: TList;
  _TypeList: TObjList;
  _id_avar, i: integer;
begin
  _AvarIDList := TList.Create;
  _TypeList := TObjList.Create;
  try
    with ResultDset do
    begin
      First;
      while not Eof do
      begin
        _id_avar:=EncodeAomID(FieldByName('OrderNumber').AsInteger, FieldByName('DateComing').AsDateTime);
        _AvarIDList.Add(pointer(_id_avar));

        ResultDset.Next;
      end;

      DM_AomComClient.AomClientManager.AskTypesOfAvars(_AvarIDList, _TypeList);

      First;
      for i:=0 to _TypeList.Count-1 do
      begin
        Edit;
        FieldByName('AomTypeOfAvar').AsInteger:=integer(TTypeOfAvarItemClass(_TypeList.Items[i]).item.TypeOfAvar);
        Post;
        //
        Next;
      end;
    end;
  finally
    _AvarIDList.Free;
    _TypeList.Free;
  end;
end;

procedure Tdm_UniversalSearch2.SetSortType(Value: TSortType);
begin
  if Value<>F_SortType then
  begin
    F_IsAscSort:=true;
    F_SortType:=Value;
  end else F_IsAscSort:=not F_IsAscSort;
end;

procedure Tdm_UniversalSearch2.StartTransaction;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_UniversalSearch2.StopTransaction;
begin
  tran.Commit;
end;


procedure Tdm_UniversalSearch2.GetOrderNumber(id_1562:integer; var id_order,is_closed:integer; var   id_number:string);
begin
 MyOpenIBDS(dset_number,
           ' select  ns.id_order, o.ordernumber, o.isclosed'+
           ' from numsorders  ns, orders o where ns.id_1562='+
           IntTOStr(id_1562)+
           ' and ns.id_order=o.id');
 id_order:=dset_number.FieldByName('id_order').AsInteger;
 id_number:=dset_number.FieldByName('ordernumber').AsString;
 is_closed:=dset_number.FieldByName('isclosed').AsInteger;
end;
end.
