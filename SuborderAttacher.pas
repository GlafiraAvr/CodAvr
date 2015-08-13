unit SuborderAttacher;

interface

uses OrderState, HelpClasses, SOAttacheDModule, SOAttachForm, Controls, SysUtils,
      Forms, Windows;

type
  TSuborderAttacher = class
  private
    F_IsCleanAttachListAfterAttach: boolean;
    F_AttachedSuborderList: TAttachList;
    F_AttachedToCacheList: TAttachList;
    F_DM: Tdm_SOAttacher;
    F_AttachFrm: Tfrm_SOAttach;
    procedure AttachCtrlsAndEvents;
    procedure OnSearchOrderHandler( Sender: TObject );
    procedure OnAddSelOrdersToCacheHandler( Sender: TObject );
    procedure OnAttachToValueFromCacheHandler( Sender: TObject );
    procedure OnClearCacheHandler( Sender: TObject );
    procedure OnNewOrderHandler( Sender: TObject );
    procedure IsAttachedToCache( _id_order: integer; var _IsAttached: boolean );
    procedure ChangeAttacheToCacheState( _id_order: integer );
    procedure AttachSubordersToOrder( _OrderID: integer );
  public
    property IsCleanAttachListAfterAttach: boolean read F_IsCleanAttachListAfterAttach
      write F_IsCleanAttachListAfterAttach;
    property AttachedSuborderList: TAttachList read F_AttachedSuborderList
      write F_AttachedSuborderList;
    function Attach: boolean;
    constructor Create;
    destructor Destroy;
  end;

implementation

uses MiniSearchOptForm, SOASearchResultForm, OrderForm, shiftnumform, TemperatureForm;

{ TSuborderAttacher }

function TSuborderAttacher.Attach: boolean;
begin
  Result := ( F_AttachFrm.ShowModal = mrOK );
end;

procedure TSuborderAttacher.AttachCtrlsAndEvents;
begin
  F_AttachFrm.OnSearchOrder := OnSearchOrderHandler;
  F_AttachFrm.ds_Cache.DataSet := F_DM.mt_OrderCache;
  F_AttachFrm.OnAttachToValueFromCache := OnAttachToValueFromCacheHandler;
  F_AttachFrm.OnClearCache := OnClearCacheHandler;
  F_AttachFrm.OnNewOrder := OnNewOrderHandler;
end;

procedure TSuborderAttacher.AttachSubordersToOrder(_OrderID: integer);
begin
  if _OrderID <> -1 then
  begin
    F_DM.AttachSubordersToOrder( F_AttachedSuborderList, _OrderID );
    F_AttachFrm.ModalResult := mrOK;
    Application.MessageBox( 'Привязка к наряду успешно завершина!',
      'Внимание', MB_OK + MB_ICONINFORMATION );
  end;
end;

procedure TSuborderAttacher.ChangeAttacheToCacheState(_id_order: integer);
begin
  F_AttachedToCacheList.ChangeAttachState( _id_order );
end;

constructor TSuborderAttacher.Create;
begin
  inherited Create;
  F_AttachedToCacheList := TAttachList.Create;
  F_DM := Tdm_SOAttacher.Create( nil );
  F_AttachFrm := Tfrm_SOAttach.Create( nil );

  AttachCtrlsAndEvents;
end;

destructor TSuborderAttacher.Destroy;
begin
  F_AttachedToCacheList.Free;
  F_DM.Free;
  F_AttachFrm.Free;
  inherited Destroy;
end;

procedure TSuborderAttacher.IsAttachedToCache(_id_order: integer; var _IsAttached: boolean);
begin
  _IsAttached := F_AttachedToCacheList.IsAttached( _id_order );
end;

procedure TSuborderAttacher.OnAddSelOrdersToCacheHandler(Sender: TObject);
const
  ERR_MSG =
    'Вы не выбрали ни одной записи. Для выбора нужно зажать' + #13#10 +
    'клавишу "Shift" и щелкнуть по необходимой записи левой' + #13#10 +
    'кнопкой мыши!';
begin
  if F_AttachedToCacheList.Count = 0 then
  begin
    Application.MessageBox( ERR_MSG, 'Внимание', MB_OK + MB_ICONWARNING );
    exit;
  end;

  F_DM.AddOrderListToCache( F_AttachedToCacheList );
  F_AttachedToCacheList.Clear;
end;

procedure TSuborderAttacher.OnAttachToValueFromCacheHandler(
  Sender: TObject);
begin
  AttachSubordersToOrder( F_DM.GetOrderIDfromCacheDset );
end;

procedure TSuborderAttacher.OnClearCacheHandler(Sender: TObject);
begin
  F_DM.ClearCache;
end;

procedure TSuborderAttacher.OnNewOrderHandler(Sender: TObject);
var
  frm_Order: Tfrm_Order;
begin
  if not(IsNeedToChangeShift or IsNeedToInputTemper) then
  begin
    frm_Order:=Tfrm_Order.Create(Application); //Новый наряд
    try
      frm_Order.OrderMode := omEdit;
      frm_Order.ShowModal;

      AttachSubordersToOrder( frm_Order.OrderID );
    finally
      frm_Order.Free;
    end;
  end;
end;

procedure TSuborderAttacher.OnSearchOrderHandler(Sender: TObject);
var
  _MSFrm: Tfrm_MiniSearchOpt;
  _ResFrm: Tfrm_SOASearchRes;
  _IsSearch: boolean;
begin
  _MSFrm := Tfrm_MiniSearchOpt.Create( nil, 'Поиск наряда' );
  try
    if _MSFrm.ShowModal = mrOk then
    begin
      F_DM.SearchOpt.DT_Begin := _MSFrm.frame_Dates.BeginDate;
      F_DM.SearchOpt.DT_End := _MSFrm.frame_Dates.EndDate;
      F_DM.SearchOpt.RegionsID := _MSFrm.frame_RegSel.ItemSelecter.SelItemList.ItemsID;
      F_DM.SearchOpt.StreetsID := _MSFrm.frame_StreetSel.ItemSelecter.SelItemList.ItemsID;
      F_DM.SearchOpt.DmgPlacesID := _MSFrm.frame_DmgPlaceSel.ItemSelecter.SelItemList.ItemsID;
      _IsSearch := true;
    end else _IsSearch := false;
  finally
    _MSFrm.Free;
  end;

  if _IsSearch then
  begin
    F_DM.StartSearchTran;
    try
      F_DM.Search;

      _ResFrm := Tfrm_SOASearchRes.Create( nil );
      try
        F_AttachedToCacheList.OnChangeAttachCount := nil;
        F_AttachedToCacheList.Clear;
        F_AttachedToCacheList.OnChangeAttachCount := _ResFrm.OnChangeAttachedToCacheCountHandler;
        _ResFrm.ds_Search.DataSet := F_DM.dset_Search;
        _ResFrm.IsAttachedToCache := IsAttachedToCache;
        _ResFrm.ChangeAttachToCacheState := ChangeAttacheToCacheState;
        _ResFrm.OnAddSelOrdersToCache := OnAddSelOrdersToCacheHandler;
        if _ResFrm.ShowModal = mrOk then
          AttachSubordersToOrder( F_DM.GetOrderIDfromSearchDset );
      finally
        _ResFrm.Free;
      end;

      F_DM.CommitSearchTran;
    except
      on E: Exception do
      begin
        F_DM.RollbackSearchTran;
        raise Exception.Create( E.Message + '(TSuborderAttacher.OnSearchOrderHandler)' );
      end;
    end;
  end;
end;

end.
