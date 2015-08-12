unit AomComClientDModule;

interface

uses
  SysUtils, Classes, Forms, Windows, AomClientManagerUnit, AomComTypesUnit,
  AvarOnMapConst, DModule, DB, IBCustomDataSet, IBDatabase, HideShowAppUnit,
  ObjListUnit;

const
  SELECT_TEMPLATE=
    ' select o.id, o.OrderNumber, o.DateComing, o.DateClosed,'+
    ' o.fk_orders_housetypes HouseType, o.fk_orders_streets StreetID,'+
    ' o.HouseNum House, o.AdditionalAddress DopAddr, sr.name Region,'+
    ' sdp.name mesto_povrezhd, smt.MessageName xar_povrezhd,'+
    ' std.diameter diam'+
    ' from orders o'+
    '     left join s_Regions sr on (sr.id=o.fk_orders_regions)'+
    '     left join s_DamagePlace sdp on (sdp.id=o.fk_orders_damageplace)'+
    '     left join s_damagelocality sdl on (sdl.id=o.fk_orders_damagelocality)'+
    '     left join s_MessageTypes smt on (smt.id=o.fk_orders_messagetypes)'+
    '     left join s_tubediameter std on (std.id=o.fk_orders_diameters)'+
    ' where %s';

  RAON_CHAR: char=' ';

type
  TOnChangeMapWorkState=procedure (IsMapWork: boolean) of object;
  TOnChangeTypeOfAvar = procedure (TypeOfAvarItemRec: TTypeOfAvarItemRec) of object;

  TDM_AomComClient = class(TDataModule)
    AomClientManager: TAomClientManager;
    tran_sel: TIBTransaction;
    dset_sel: TIBDataSet;
    dset_tmp: TIBDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure AomClientManagerEndLoad(Sender: TObject);
    procedure AomClientManagerChangeTypeOfAvar(ASender: TObject;
      TypeOfAvarItemRec: TTypeOfAvarItemRec);
    procedure AomClientManagerShow(Sender: TObject);
    procedure AomClientManagerHide(Sender: TObject);
    procedure AomClientManagerAskAvarInfo(ASender: TObject;
      AvarID: Integer; out AvarInfo: TAvarInfoRec);
  private
    F_OnChangeMapWorkState: TOnChangeMapWorkState;
    F_IsMapWork: boolean;
    F_OnChangeTypeOfAvar: TOnChangeTypeOfAvar;
    F_HideShowAppUnit: THideShowAppUnit;
    F_ScreenShotParamsRec: TScreenShotParamsRec;
    procedure SetIsMapWork(Value: boolean);
    procedure FillAvrInfoRec(_DataSet: TDataSet; var _AvrInfoRec: TAvarInfoRec);
    procedure FillAvrInfoRecByOrderID(OrderID: integer; var _AvrInfoRec: TAvarInfoRec);
  public
    procedure ConnectToAom;
    procedure DisconnectFromAom;
    procedure SendAvarInfoToAom(OrderID: integer);
    property OnChangeMapWorkState: TOnChangeMapWorkState
      read F_OnChangeMapWorkState write F_OnChangeMapWorkState;
    property IsMapWork: boolean read F_IsMapWork;
    property OnChangeTypeOfAvar: TOnChangeTypeOfAvar
      read F_OnChangeTypeOfAvar write F_OnChangeTypeOfAvar;
    function ConvertTypeOfAvarToStr(_AomTypeOfAvar: TAomTypeOfAvar): string;
    procedure GetAomTypeOfAvarByOrderID(_OrderID: integer; var _TypeOfAvar: TAomTypeOfAvar;
      var _StrTypeOfAvar: string);
    procedure FillAddrRec(_HouseType, _StreetID: integer; _HouseNum, _AddAddr: string;
      var _AddrRec: TAddrRec);
    property ScreenShotParamsRec: TScreenShotParamsRec read F_ScreenShotParamsRec
      write F_ScreenShotParamsRec;
    procedure ScreenShotFromMap;
  end;

function EncodeAomID(_OrderNumber: integer; _DateComing: TDateTime): integer;

var
  DM_AomComClient: TDM_AomComClient;

implementation

{$R *.dfm}

uses StringConsts, HelpFunctions, DateUtils, RightsManagerDModule, AppGUIDS;


function EncodeAomID(_OrderNumber: integer;
  _DateComing: TDateTime): integer;
begin
  Result:=EncodeId(0, RAON_CHAR, tatVoda, _OrderNumber, _DateComing);
end;

{ TDM_AomComClient }

procedure TDM_AomComClient.SetIsMapWork(Value: boolean);
begin
  F_IsMapWork:=Value;

  if Assigned(F_OnChangeMapWorkState) then
    OnChangeMapWorkState(Value);
end;

procedure TDM_AomComClient.ConnectToAom;
var
  _acir: TAomClientInfoRec;
  _let_work: boolean;
begin
  { false - означает, что будет подключаться к уже зарегистрированному ком-серверу
  аварий на карте. Если true, то сначала зарегистирует в папке \AvarOnMap его, а потом
  уже запустит его и подключится }
  AomClientManager.Connect(false);
  //
  _acir.Name := 'avr_khar_ib';
  _acir.Caption := 'Диспетчер АВР (Харьков)';
  _acir.ReadOnlyMode := not DM_RightsManager.IsCurrentUserCanEditForm( AVRONMAP_EDIT );
  //
  AomClientManager.StartSession( _acir, _let_work );
  if not _let_work then
  { это означает, что у сервера уже есть один клиент,
  а больше для него не позволительно }
    Application.MessageBox('К серверу аварий на карте уже подключен клиент',
      gc_strDispAVR, MB_OK+MB_ICONERROR);
end;

procedure TDM_AomComClient.DisconnectFromAom;
begin
{  AomClientManager.StopSession;
  AomClientManager.Disconnect;
  SetIsMapWork(false);}
end;

procedure TDM_AomComClient.DataModuleDestroy(Sender: TObject);
begin
  AomClientManager.StopSession;
  F_HideShowAppUnit.Free;
end;

procedure TDM_AomComClient.DataModuleCreate(Sender: TObject);
begin
  F_IsMapWork:=false;
  F_OnChangeTypeOfAvar:=nil;
  F_HideShowAppUnit:=THideShowAppUnit.Create;
end;

procedure TDM_AomComClient.AomClientManagerEndLoad(Sender: TObject);
begin
  SetIsMapWork(true);
end;

procedure TDM_AomComClient.SendAvarInfoToAom(OrderID: integer);
var
  _ai: TAvarInfoRec;
begin
  FillAvrInfoRecByOrderID(OrderID, _ai);
  AomClientManager.SendAvarInfo(_ai, 300);
end;


procedure TDM_AomComClient.FillAvrInfoRec(_DataSet: TDataSet;
  var _AvrInfoRec: TAvarInfoRec);
begin
  with _DataSet, _AvrInfoRec do
  begin
    id_avar:=EncodeAomID(FieldByName('OrderNumber').AsInteger, FieldByName('DateComing').AsDateTime);
    raon_char := Ord(RAON_CHAR);
    attach := atatVoda;
    year := YearOf(FieldByName('DateComing').AsDateTime);
    dt_begin := FieldByName('DateComing').AsDateTime;
    dt_end := FieldByName('DateClosed').AsDateTime;
    region := '';
    rayon := trim(FieldByName('Region').AsString);
    //
    FillAddrRec(FieldByName('HouseType').AsInteger,
                FieldByName('StreetID').AsInteger,
                FieldByName('House').AsString,
                FieldByName('DopAddr').AsString,
                AddrRec);
    //
    xar_povrezhd := trim(FieldByName('xar_povrezhd').AsString);
    mesto_povrezhd := trim(FieldByName('mesto_povrezhd').AsString);
    diam := FieldByName('diam').AsInteger;
  end;
end;

procedure TDM_AomComClient.AomClientManagerChangeTypeOfAvar(
  ASender: TObject; TypeOfAvarItemRec: TTypeOfAvarItemRec);
begin
  if Assigned(F_OnChangeTypeOfAvar) then
    F_OnChangeTypeOfAvar(TypeOfAvarItemRec);
end;

function TDM_AomComClient.ConvertTypeOfAvarToStr(
  _AomTypeOfAvar: TAomTypeOfAvar): string;
var
  _s1: string;
begin
  case _AomTypeOfAvar of
    atoaNull: _s1 := '-';
    atoaBezAddr: _s1 := 'без адреса';
    atoaPredv: _s1 := 'предварительная';
    atoaRazm: _s1 := 'размеченная';
  end;
  Result:=_s1;
end;

procedure TDM_AomComClient.FillAvrInfoRecByOrderID(OrderID: integer;
  var _AvrInfoRec: TAvarInfoRec);
begin
  if tran_sel.InTransaction then
    tran_sel.Rollback;
  tran_sel.StartTransaction;
  try
    //
    MyOpenIBDS(dset_sel,Format(SELECT_TEMPLATE, ['o.ID='+IntToStr(OrderID)]));
    FillAvrInfoRec(dset_sel, _AvrInfoRec);
    //
    tran_sel.Commit;
  except
    on E: Exception do
    begin
      tran_sel.Rollback;
      raise Exception.Create(E.Message+'(TDM_AomComClient.FillAvrInfoRecByOrderID)');
    end;
  end;
end;

procedure TDM_AomComClient.GetAomTypeOfAvarByOrderID(_OrderID: integer;
  var _TypeOfAvar: TAomTypeOfAvar; var _StrTypeOfAvar: string);
var
  _air: TAvarInfoRec;
  _lst: TList;
  _lst_obj: TObjList;
  _toai: TTypeOfAvarItemClass;
begin
  _StrTypeOfAvar := 'нет на карте';
  _TypeOfAvar := atoaNull;
  FillAvrInfoRecByOrderID(_OrderID, _air);
  if (_air.id_avar>0) then
  begin
    _lst := TList.Create;
    _lst_obj := TObjList.Create;
    try
      _lst.Add( pointer(_air.id_avar) );
      AomClientManager.AskTypesOfAvars( _lst, _lst_obj );
      if (_lst_obj.Count>0) then
      begin
        _toai := _lst_obj[0];
        _TypeOfAvar := _toai.item.TypeOfAvar;
        _StrTypeOfAvar := ConvertTypeOfAvarToStr(_TypeOfAvar);
      end;
    finally
      _lst.Free;
      _lst_obj.Free;
    end;
  end;
end;

procedure TDM_AomComClient.AomClientManagerShow(Sender: TObject);
begin
  F_HideShowAppUnit.Show(false);
end;

procedure TDM_AomComClient.AomClientManagerHide(Sender: TObject);
begin
  F_HideShowAppUnit.CollectInfo(ExtractFileName(ParamStr(0)));
  F_HideShowAppUnit.Hide;
end;


procedure TDM_AomComClient.FillAddrRec(_HouseType, _StreetID: integer;
  _HouseNum, _AddAddr: string; var _AddrRec: TAddrRec);
//
  procedure GetUl(id_ul: integer; var Ul: string; var VidUl: string);
  begin
    MyOpenIBDS(dset_tmp,
      ' select ss.name Ul, sst.name VidUl'+
      ' from s_streets ss'+
      ' left join s_streettypes sst'+
      ' on (sst.id=ss.fk_streets_streettypes)'+
      ' where ss.id='+IntToStr(id_ul));
    Ul := trim(dset_tmp.FieldByName('Ul').AsString);
    VidUl := trim(dset_tmp.FieldByName('VidUl').AsString);
    dset_tmp.Close;
  end;
begin
  _HouseNum:=trim(_HouseNum);
  _AddAddr:=trim(_AddAddr);

  GetUl(_StreetID, _AddrRec.Ul1, _AddrRec.VidUl1);
  _AddrRec.DopAddr:=trim(_AddAddr);

  case _HouseType of
    0: // Улица, номер дома
      begin
        _AddrRec.TypeOfAddr := tofaSimple;
        _AddrRec.House := trim(_HouseNum);
        _AddrRec.Ul2 := '';
        _AddrRec.VidUl2 := '';
      end;
    1: // Пересечение улиц
      begin
        _AddrRec.TypeOfAddr := tofaCrissCross;
        _AddrRec.House := '';
        GetUl(StrToInt(_HouseNum), _AddrRec.Ul2, _AddrRec.VidUl2);
      end;
    2: // Местность
      begin
        _AddrRec.TypeOfAddr := tofaMestn;
        _AddrRec.House:='';
        _AddrRec.Ul2 := '';
        _AddrRec.VidUl2 := '';
      end;
  end;
end;

procedure TDM_AomComClient.ScreenShotFromMap;
begin
  AomClientManager.ScreenShotFromMap( F_ScreenShotParamsRec );
end;

procedure TDM_AomComClient.AomClientManagerAskAvarInfo(ASender: TObject;
  AvarID: Integer; out AvarInfo: TAvarInfoRec);
var
  _OrdNum, _OrdYear: integer;
  _ch: char;
begin
  _OrdNum := DecodeOrdNum( AvarID, _ch );
  _OrdYear := DecodeOrdYear( AvarID );

  if tran_sel.InTransaction then
    tran_sel.Rollback;
  tran_sel.StartTransaction;
  try
    MyOpenIBDS( dset_sel, Format( SELECT_TEMPLATE, [
      ' extract(year from (o.DateComing))=' + IntToStr( _OrdYear ) +
      ' and (o.OrderNumber=' + IntToStr(_OrdNum) + ')' ]) );

    FillAvrInfoRec( dset_sel, AvarInfo );

    tran_sel.Commit;
  except
    on E: Exception do
    begin
      tran_sel.Rollback;
      raise Exception.Create( E.Message + '(TDM_AomComClient.AomClientManagerAskAvarInfo)' );
    end;
  end;
end;


end.
