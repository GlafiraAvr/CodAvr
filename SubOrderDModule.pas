unit SubOrderDModule;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet, kbmMemTable,
  GlobalVocCacheDModule;

type
  TSubOrderShowMode = ( smAllWithoutChecking, smAllWithChecking, smOnlyChecked, smCheckedAndFree );

  TOrderFields=class
  private
    F_IDBrig,
    F_IDDisp: integer;
    F_DTTMEnd: TDateTime;
    //
    F_IDStreet: integer;
    F_HouseNum: string;
  public
    property IDBrig: integer read F_IDBrig write F_IDBrig;
    property IDDisp: integer read F_IDDisp write F_IDDisp;
    property DTTMEnd: TDateTime read F_DTTMEnd write F_DTTMEnd;
    //
    property IDStreet: integer read F_IDStreet write F_IDStreet;
    property HouseNum: string read F_HouseNum write F_HouseNum;
    //
    constructor Create;
  end;

  TOnError = procedure ( _ErrorMsg: string ) of object;
  TOnCheckAlien = procedure(var Accept: boolean) of object;

  Tdm_SubOrder = class(TDataModule)
    dset_Main: TIBDataSet;
    tran: TIBTransaction;
    dset_MainID: TIntegerField;
    dset_MainDTTM_BEGIN: TDateTimeField;
    dset_MainID_STREET: TIntegerField;
    dset_MainHOUSE_NUM: TIBStringField;
    dset_MainAPARTMENT_NUM: TIBStringField;
    dset_MainID_SUBORDERMSG: TIntegerField;
    dset_MainID_OFFICIAL_CLOSED: TIntegerField;
    dset_MainID_BRIG: TIntegerField;
    dset_MainDTTM_END: TDateTimeField;
    dset_MainID_ORDER: TIntegerField;
    dset_MainID_SUBORDERABON: TIntegerField;
    mt_Street: TkbmMemTable;
    dset_MainlpSTREET: TStringField;
    mt_Msg: TkbmMemTable;
    mt_Abon: TkbmMemTable;
    mt_Offic: TkbmMemTable;
    mt_Brig: TkbmMemTable;
    dset_MainlpMSG: TStringField;
    dset_MainlpABON: TStringField;
    dset_MainlpOFFIC: TStringField;
    dset_MainlpBRIG: TStringField;
    mt_bool: TkbmMemTable;
    mt_boolid: TIntegerField;
    mt_boolvalue: TBooleanField;
    dset_MainIS_CHECKED: TIntegerField;
    dset_Mainlp_IsChecked: TBooleanField;
    dset_MainADDRESS: TStringField;
    dset_MainIsALIEN: TBooleanField;
    dset_MainclcOrderNumber: TIntegerField;
    dset_OrderNumber: TIBDataSet;
    dset_MainID_REGION: TIntegerField;
    mt_Region: TkbmMemTable;
    dset_MainlpREGION: TStringField;
    dset_MainPHONE_NUM: TStringField;
    dset_MainADD_INFO: TStringField;
    procedure dset_MainAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dset_MainCalcFields(DataSet: TDataSet);
    procedure dset_MainAfterCancel(DataSet: TDataSet);
  private
    F_OrderID: integer;
    F_OrderFields: TOrderFields;
    F_OnError: TOnError;
    F_OnCheckAlien: TOnCheckAlien;
    F_IsInsert: boolean;
    procedure InitMt_bool;
    procedure Error( _ErrorMsg: string );
    function IsFieldValuesCorrect: boolean;
    procedure LoadOrderFieldValues;
  public
    procedure StartTransaction;
    procedure RollBackTransaction;
    procedure CommitTransaction;
    property OrderID: integer read F_OrderID write F_OrderID;
    procedure ReopenMainDset( _ShowMode: TSubOrderShowMode );
    property OrderFields: TOrderFields read F_OrderFields write F_OrderFields;
    property OnError: TOnError read F_OnError write F_OnError;
    property OnCheckAlien: TOnCheckAlien read F_OnCheckAlien write F_OnCheckAlien;
    procedure Refresh( _AttachList: TList );
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_SubOrder }

procedure Tdm_SubOrder.CommitTransaction;
begin
  if tran.InTransaction then tran.Commit;
end;

procedure Tdm_SubOrder.RollBackTransaction;
begin
  if tran.InTransaction then tran.Rollback;
end;

procedure Tdm_SubOrder.StartTransaction;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_SubOrder.ReopenMainDset( _ShowMode: TSubOrderShowMode );
  function _get_sql(_s1, _s2: string): string;
  const
    SEL_SQL =
    ' select id, Num1562, Datatime '+
    ', PHONE, street_name, house, appartment, nfloor, podesd, kodpodesd '+
    ', PLACE, ABONENT, REGION, kodclass, ABOUT, WORKS, STATUS, AVAR, REGL '+
    ', sp.fk_spisok1562_rayon, sp.fk_spisok1562_sreet, FK_SPISOK1562_ORDER '+
    ', avr_ordernumber ordernumber '+
    ', is_closed '+
    ' %s' +
    ' from spisok1562 sp '+
    ' %s';
     {
      ' select so.id, so.dttm_begin,' +
      ' so.id_street, so.house_num, so.apartment_num,' +
      ' so.id_subordermsg, so.id_official_closed,' +
      ' so.id_brig, so.dttm_end, so.id_order, so.id_suborderabon,' +
      ' so.id_region, so.phone_num, so.add_info,' +
      ' ss.name street,' +
      ' %s' +
      ' from suborders so' +
      ' left join s_streets ss on so.id_street = ss.id' +
      ' %s';
      }

  begin
    Result := Format( SEL_SQL, [_s1, _s2] );
  end;
var
  _sel, _ref, _s: string;
begin
  case _ShowMode of
    smAllWithoutChecking:
      begin
        _s := '0 is_checked';
        _sel := _get_sql( _s, 'order by so.dttm_begin desc, ss.name, so.house_num' );
        _ref := _get_sql( _s, 'where so.id = :id' );
      end;
    smAllWithChecking:
      begin
        _s := '( select is_checked from is_suborder_checked(so.id, ' + IntToStr( F_OrderID ) + ') ) is_checked';
        _sel := _get_sql( _s, 'order by so.dttm_begin desc, ss.name, so.house_num' );
        _ref := _get_sql( _s, 'where so.id = :id' );
      end;
    smOnlyChecked:
      begin
        _s := '( select is_checked from is_suborder_checked(so.id, ' + IntToStr( F_OrderID ) + ') ) is_checked';
        _sel := _get_sql( _s,
          ' where ( select is_checked from is_suborder_checked(so.id, ' + IntToStr( F_OrderID ) + ') ) <> 0' +
          ' order by so.dttm_begin desc, ss.name, so.house_num' );
        _ref := _get_sql( _s, 'where so.id = :id' );
      end;
    smCheckedAndFree:
      begin
        _s := '( select is_checked from is_suborder_checked(so.id, ' + IntToStr( F_OrderID ) + ') ) is_checked';
        _sel := _get_sql( _s,
          ' where (so.id_order is null) or (so.id_order=-1) or (so.id_order =' + IntToStr( F_OrderID ) + ')' +
          ' order by so.dttm_begin desc, ss.name, so.house_num' );
        _ref := _get_sql( _s, 'where so.id = :id' );
      end;
  end;

  dset_Main.Close;
  dset_Main.SelectSQL.Text := _sel;
  dset_Main.RefreshSQL.Text := _ref;
  dset_Main.Open;
end;

procedure Tdm_SubOrder.dset_MainAfterPost(DataSet: TDataSet);
begin
  if tran.InTransaction then tran.CommitRetaining;

  if F_IsInsert then
  begin
    dset_Main.Close;
    dset_Main.Open;
    F_IsInsert := false;
  end else
    DataSet.Refresh;
end;

procedure Tdm_SubOrder.DataModuleCreate(Sender: TObject);
begin
  F_OrderID := -1;
  F_IsInsert := false;
  F_OrderFields := TOrderFields.Create;
  InitMt_bool;
end;

procedure Tdm_SubOrder.InitMt_bool;
begin
  mt_bool.Close;
  mt_bool.Open;
  mt_bool.Append;
  mt_bool.FieldByName( 'id' ).AsInteger := 0;
  mt_bool.FieldByName( 'value' ).AsBoolean := false;
  mt_bool.Post;
  mt_bool.Append;
  mt_bool.FieldByName( 'id' ).AsInteger := -1;
  mt_bool.FieldByName( 'value' ).AsBoolean := true;
  mt_bool.Post;
end;

procedure Tdm_SubOrder.dset_MainAfterInsert(DataSet: TDataSet);
begin
  F_IsInsert := true;

  if F_OrderID <> -1 then
  begin
    DataSet.FieldByName( 'id_order' ).AsInteger := F_OrderID;
    DataSet.FieldByName( 'lp_IsChecked' ).AsBoolean := true;
  end else
  begin
    DataSet.FieldByName( 'lp_IsChecked' ).AsBoolean := false;
  end;

  DataSet.FieldByName( 'dttm_begin' ).AsDateTime := Now;
  LoadOrderFieldValues;
end;

procedure Tdm_SubOrder.dset_MainAfterEdit(DataSet: TDataSet);
begin
  if F_OrderID <> -1 then
    DataSet.FieldByName( 'id_order' ).AsInteger := F_OrderID;
end;

procedure Tdm_SubOrder.LoadOrderFieldValues;
begin
  if dset_Main.State = dsBrowse then  dset_Main.Edit;

  with F_OrderFields do
  begin
    if IDBrig <> -1 then
      dset_Main.FieldByName( 'id_brig' ).AsInteger := IDBrig;
    if IDDisp <> -1 then
      dset_Main.FieldByName( 'id_official_closed' ).AsInteger := IDDisp;
    if DTTMEnd <> 0 then
      dset_Main.FieldByName( 'dttm_end' ).AsDateTime := DTTMEnd;
    if IDStreet <> -1 then
      dset_Main.FieldByName( 'id_street' ).AsInteger := IDStreet;
    if HouseNum <> '' then
      dset_Main.FieldByName( 'house_num' ).AsString := HouseNum;
  end;
end;

procedure Tdm_SubOrder.Error(_ErrorMsg: string);
begin
  if Assigned( F_OnError ) then
    F_OnError( _ErrorMsg );
end;

function Tdm_SubOrder.IsFieldValuesCorrect: boolean;
  function _IsErr( _Field: TField): boolean;
  begin
    Result := ( _Field.IsNull ) or ( _Field.AsInteger = -1 );
  end;

  procedure _Err( _msg: string );
  begin
    Error( _msg );
    IsFieldValuesCorrect := false;
  end;
begin
  Result := true;

  with dset_Main do
  begin
    if FieldByName( 'dttm_begin' ).IsNull then
      _Err( 'Необходимо заполнить дату и время поступления' ) else
    if _IsErr( FieldByName( 'id_street' ) ) then
      _Err( 'Необходимо выбрать улицу' ) else
    if trim( FieldByName('house_num').AsString ) = '' then
      _Err( 'Необходимо ввести номер дома' );
  end;
end;

procedure Tdm_SubOrder.DataModuleDestroy(Sender: TObject);
begin
  F_OrderFields.Free;
end;

procedure Tdm_SubOrder.Refresh(_AttachList: TList);
var
  _bmark: string;
  i: integer;
  _so_id: integer;
begin
  dset_Main.DisableControls;
  try
    _bmark := dset_Main.Bookmark;
    for i:=0 to _AttachList.Count-1 do
    begin
      _so_id := integer( _AttachList.Items[i] );
      if dset_Main.Locate( 'ID', _so_id, [] ) then
        dset_Main.Refresh;
    end;
  finally
    dset_Main.EnableControls;
  end;
end;


{ TOrderFields }

constructor TOrderFields.Create;
begin
  F_IDBrig := -1;
  F_IDDisp := -1;
  F_DTTMEnd := 0;

  F_IDStreet := -1;
  F_HouseNum := '';
end;

procedure Tdm_SubOrder.dset_MainCalcFields(DataSet: TDataSet);
var
  _street, _h_num, _a_num: string;
begin
  ////
  _street := trim( dset_Main.FieldByName( 'lpSTREET' ).AsString );
  _h_num := trim( dset_Main.FieldByName( 'HOUSE_NUM' ).AsString );
  _a_num := trim( dset_Main.FieldByName( 'APARTMENT_NUM' ).AsString );
  if _h_num <> '' then
    _h_num := ', ' + _h_num;
  if _a_num <> '' then
    _a_num := ', кв.' + _a_num;
  DataSet.FieldByName( 'ADDRESS' ).AsString := _street + _h_num + _a_num;
  ////
  DataSet.FieldByName( 'IsALIEN' ).AsBoolean :=
    ( not DataSet.FieldByName( 'id_order' ).IsNull ) and
    ( DataSet.FieldByName( 'id_order' ).AsInteger <> -1 ) and
    ( DataSet.FieldByName( 'id_order' ).AsInteger <> F_OrderID );
  ////
  dset_OrderNumber.Close;
  dset_OrderNumber.ParamByName( 'pOrderID' ).AsInteger := DataSet.FieldByName( 'id_order' ).AsInteger;
  dset_OrderNumber.Open;
  if dset_OrderNumber.FieldByName( 'OrderNumber' ).IsNull then
    DataSet.FieldByName( 'clcOrderNumber' ).Clear
  else
    DataSet.FieldByName( 'clcOrderNumber' ).AsInteger := dset_OrderNumber.FieldByName( 'OrderNumber' ).AsInteger;
end;

procedure Tdm_SubOrder.dset_MainAfterCancel(DataSet: TDataSet);
begin
  F_IsInsert := false;
end;

end.
