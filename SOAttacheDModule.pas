unit SOAttacheDModule;

interface

uses
  SysUtils, Classes, DB, kbmMemTable,  DModule, IBDatabase, IBCustomDataSet,
  HelpClasses, IBSQL;


const
  SEL_ORDER =
    ' select o.id, o.ordernumber,' +
    ' o.datecoming, o.dateclosed,' +
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,' +
    '     o.housenum, o.additionaladdress)) adres,' +
    ' sreg.name region,' +
    ' sdp.name DmgPlace' +
    ' from orders o' +
    ' left join s_regions sreg on sreg.id = o.fk_orders_regions' +
    ' left join s_damageplace sdp on sdp.id = o.fk_orders_damageplace' +
    ' where %s' +
    ' order by DateComing';

type
  TSearchOpt=class
  private
    F_DT_Begin,
    F_DT_End: TDateTime;
    F_RegionsID,
    F_StreetsID,
    F_DmgPlacesID: string;
  public
    property DT_Begin: TDateTime read F_DT_Begin write F_DT_Begin;
    property DT_End: TDateTime read F_DT_End write F_DT_End;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property StreetsID: string read F_StreetsID write F_StreetsID;
    property DmgPlacesID: string read F_DmgPlacesID write F_DmgPlacesID;
  end;

  Tdm_SOAttacher = class(TDataModule)
    mt_OrderCache: TkbmMemTable;
    tr_Search: TIBTransaction;
    dset_Search: TIBDataSet;
    dset_tmp: TIBDataSet;
    tr_tmp: TIBTransaction;
    mt_OrderCacheid: TIntegerField;
    mt_OrderCacheOrderNumber: TIntegerField;
    mt_OrderCacheDateComing: TDateTimeField;
    mt_OrderCacheDateClosed: TDateTimeField;
    mt_OrderCacheAdres: TStringField;
    mt_OrderCacheregion: TStringField;
    mt_OrderCacheDmgPlace: TStringField;
    IBSQL: TIBSQL;
    tr_Exec: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    F_SearchOpt: TSearchOpt;
    procedure _InsertCurrentRowInDsetToCache( _dset: TDataSet );
    function GetSearchOpt: TSearchOpt;
    function GetSearchCond: string;
  public
    property SearchOpt: TSearchOpt read GetSearchOpt write F_SearchOpt;
    procedure Search;
    procedure StartSearchTran;
    procedure CommitSearchTran;
    procedure RollbackSearchTran;
    procedure AddOrderToCache( _id_order: integer );
    procedure AddOrderListToCache( _OrderList: TList );
    procedure ClearCache;
    procedure AttachSubordersToOrder( _AttachList: TList; _OrderID: integer );
    function GetOrderIDfromSearchDset: integer;
    function GetOrderIDfromCacheDset: integer;
  end;


implementation

{$R *.dfm}

{ Tdm_SOAttacher }

uses HelpFunctions;


function Tdm_SOAttacher.GetSearchOpt: TSearchOpt;
begin
  if not Assigned( F_SearchOpt ) then
    F_SearchOpt := TSearchOpt.Create;
  Result := F_SearchOpt;
end;

procedure Tdm_SOAttacher.DataModuleDestroy(Sender: TObject);
begin
  F_SearchOpt.Free;
end;

procedure Tdm_SOAttacher.Search;
const
  SEL_SQL =
    ' select o.id, o.ordernumber,' +
    ' o.datecoming, o.dateclosed,' +
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,' +
    '     o.housenum, o.additionaladdress)) adres,' +
    ' sreg.name region,' +
    ' sdp.name DmgPlace' +
    ' from orders o' +
    ' left join s_regions sreg on sreg.id = o.fk_orders_regions' +
    ' left join s_damageplace sdp on sdp.id = o.fk_orders_damageplace' +
    ' where %s' +
    ' order by DateComing desc';
var
  _sql: string;
begin
  _sql := Format( SEL_SQL, [ GetSearchCond ] );
  MyOpenIBDS( dset_Search, _sql );
end;

procedure Tdm_SOAttacher.CommitSearchTran;
begin
  tr_Search.Commit;
end;

procedure Tdm_SOAttacher.RollbackSearchTran;
begin
  tr_Search.Rollback;
end;

procedure Tdm_SOAttacher.StartSearchTran;
begin
  if tr_Search.InTransaction then tr_Search.Rollback;
  tr_Search.StartTransaction;
end;

function Tdm_SOAttacher.GetSearchCond: string;
var
  _ConGen: TQueryConditionGenerator;
begin
  _ConGen := TQueryConditionGenerator.Create;
  try
    _ConGen.AddField( 0, 'o.fk_orders_regions in (%s)', F_SearchOpt.RegionsID );
    _ConGen.AddField( 0, 'o.fk_orders_streets in (%s)', F_SearchOpt.StreetsID );
    _ConGen.AddField( 0, 'o.fk_orders_damageplace in (%s)', F_SearchOpt.DmgPlacesID );
    Result := '(DateComing > ''' + DateToStr( F_SearchOpt.DT_Begin )  + ''')' +
              ' and (DateComing <= ''' + DateToStr( F_SearchOpt.DT_End + 1 ) + ''')' +
              _ConGen.GenConditon;
  finally
    _ConGen.Free;
  end;
end;

procedure Tdm_SOAttacher.AddOrderToCache(_id_order: integer);
begin
  if tr_tmp.InTransaction then tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp, Format( SEL_ORDER, [ 'o.id = ' + IntToStr( _id_order ) ] ) );
    if not dset_tmp.Eof then
      _InsertCurrentRowInDsetToCache( dset_tmp );

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_SOAttacher.AddOrderToCache)' );
    end;
  end;
end;

procedure Tdm_SOAttacher.AddOrderListToCache(_OrderList: TList);
var
  _cond: string;
  i: integer;
begin
  if _OrderList.Count <=0 then exit;

  _cond := '';
  for i:=0 to _OrderList.Count -1 do
    _cond := _cond + ',' + IntToStr( integer( _OrderList.Items[i] ) );
  Delete( _cond, 1 , 1 );
  _cond := 'o.id in (' +_cond + ')';

  if tr_tmp.InTransaction then tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp, Format( SEL_ORDER, [ _cond ] ) );
    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      _InsertCurrentRowInDsetToCache( dset_tmp );
      dset_tmp.Next;
    end;
    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_SOAttacher.AddOrderListToCache)' );
    end;
  end;
end;

procedure Tdm_SOAttacher._InsertCurrentRowInDsetToCache(_dset: TDataSet);
begin
  if mt_OrderCache.Locate( 'id', _dset.FieldByName( 'id' ).AsInteger, [] ) then
    mt_OrderCache.Delete;

  with mt_OrderCache do
  begin
    First;
    Insert;
    FieldByName( 'id' ).AsInteger := _dset.FieldByName( 'id' ).AsInteger;
    FieldByName( 'OrderNumber' ).AsInteger := _dset.FieldByName( 'OrderNumber' ).AsInteger;
    FieldByName( 'DateComing' ).AsDateTime := _dset.FieldByName( 'DateComing' ).AsDateTime;
    if not _dset.FieldByName( 'DateClosed' ).IsNull then
      FieldByName( 'DateClosed' ).AsDateTime := _dset.FieldByName( 'DateClosed' ).AsDateTime;
    FieldByName( 'Region' ).AsString := _dset.FieldByName( 'Region' ).AsString;
    FieldByName( 'Adres' ).AsString := _dset.FieldByName( 'Adres' ).AsString;
    FieldByName( 'DmgPlace' ).AsString := _dset.FieldByName( 'DmgPlace' ).AsString;
    Post;
  end;
end;

procedure Tdm_SOAttacher.DataModuleCreate(Sender: TObject);
begin
  ClearCache;
end;

procedure Tdm_SOAttacher.ClearCache;
begin
  mt_OrderCache.Close;
  mt_OrderCache.Open;
end;

procedure Tdm_SOAttacher.AttachSubordersToOrder(_AttachList: TList;
  _OrderID: integer);
var
  _IDs: string;
  i: integer;
begin
  if _OrderID <= 0 then exit;

  _IDs := '';
  for i:=0 to _AttachList.Count -1 do
    _IDs := _IDs + ',' + IntToStr( integer( _AttachList.Items[i] ) );
  Delete( _IDs, 1 , 1 );

  if tr_exec.InTransaction then tr_exec.Rollback;
  tr_exec.StartTransaction;
  try
    MyExecIBSQL( IBSQL,
      ' update suborders set id_order=' + IntToStr( _OrderID ) +
      ' where id in (' + _IDs + ')' );
    tr_exec.Commit;
  except
    on E: Exception do
    begin
      tr_exec.Rollback;
      raise Exception.Create( E.Message + '(Tdm_SOAttacher.AttachSubordersToOrder)' );
    end;
  end;

  AddOrderToCache( _OrderID );
end;

function Tdm_SOAttacher.GetOrderIDfromSearchDset: integer;
begin
  if dset_Search.IsEmpty then
    Result := -1
  else
    Result := dset_Search.FieldByName( 'id' ).AsInteger;
end;

function Tdm_SOAttacher.GetOrderIDfromCacheDset: integer;
begin
  if mt_OrderCache.IsEmpty then
    Result := -1
  else
    Result := mt_OrderCache.FieldByName( 'id' ).AsInteger;
end;

end.
