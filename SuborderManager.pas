unit SuborderManager;

interface

uses SubOrderDModule, SubOrderForm, SubOrderGridForm, SysUtils,
    SuborderVADModule, Controls, Forms, Windows, Classes, HelpClasses,
    SuborderAttacher, Search1562DModule, Order1562Form;

type
  TSuborderManager=class
  private
//    F_DM: Tdm_SubOrder;
    F_DM: Tdm_Search1562;
//    F_SOFrm: Tfrm_SubOrder;
    F_SOFrm: Tfrm_Order1562;
    F_GridFrm: Tfrm_SubOrderGrid;
    F_VA: Tdm_SuborderVA;
  private
    F_OrderID: integer;
    F_IsReadOnly: boolean;
    F_AttachList: TAttachList;
    F_SuborderAttacher: TSuborderAttacher;
  private
    procedure OnShowSOFrmHandler( var _IsOk: boolean );
    procedure OnChangeShowModeHandler( _ShowMode: TSubOrderShowMode );
    procedure OnCheckAlienHandler( var _Accept: boolean);
    procedure OnAttachHandler(Sender: TObject);
    procedure AttachCtrlsAndEvents;
    procedure AttachCtrlsAndEventsNew;
    procedure SetOrderID(Value: integer);
    function GetOrderFields: TOrderFields;
    procedure SetOrderFields(Value: TOrderFields);
    procedure SetIsReadOnly(Value: boolean);
    procedure IsAttached( _id_suborder: integer; var _IsAttached: boolean );
    procedure ChangeAttachState( _id_suborder: integer );
  public
    constructor Create;
    destructor Destroy; override;
    property OrderID: integer read F_OrderID write SetOrderID;
    procedure ShowGridFrm;
    procedure AddFieldToGrid( _field: string; _Title: string; _len: integer );
    property OrderFields: TOrderFields read GetOrderFields
      write SetOrderFields;
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;

  end;

implementation

uses RightsManagerDModule, AppGUIDS;

{ TSuborderManager }

procedure TSuborderManager.AttachCtrlsAndEvents;
begin
 // F_DM.OnCheckAlien := OnCheckAlienHandler;

 { F_GridFrm.ds_Main.DataSet := F_DM.dset_Main;
  F_GridFrm.OnShowSOFrm := OnShowSOFrmHandler;
  F_GridFrm.OnChangeShowMode := OnChangeShowModeHandler;
  F_GridFrm.IsAttached := IsAttached;
  F_GridFrm.ChangeAttachState := ChangeAttachState;
  F_GridFrm.OnAttach := OnAttachHandler;

  F_AttachList.OnChangeAttachCount := F_GridFrm.OnChangeAttachCountHandler;

  with F_SOFrm.frame_In do
  begin
    ds_Main.DataSet := F_DM.dset_Main;

    ds_Street.DataSet := F_VA.mt_Streets;
    ds_SubOrderMsg.DataSet := F_VA.mt_Msg;
    ds_SubOrderAbon.DataSet := F_VA.mt_Abon;
    ds_Brig.DataSet := F_VA.mt_Brig;
    ds_Official.DataSet := F_VA.mt_Offic;
  end;                                   }
end;

procedure TSuborderManager.AttachCtrlsAndEventsNew;
begin
// здесь будет аттачится для Tdm_Search1562

 // F_DM.OnCheckAlien := OnCheckAlienHandler;

  F_GridFrm.ds_Main.DataSet := F_DM.ResultDset;
{  F_GridFrm.OnShowSOFrm := OnShowSOFrmHandler;
  F_GridFrm.OnChangeShowMode := OnChangeShowModeHandler;
  F_GridFrm.IsAttached := IsAttached;
  F_GridFrm.ChangeAttachState := ChangeAttachState;
  F_GridFrm.OnAttach := OnAttachHandler;
 }
  //F_AttachList.OnChangeAttachCount := F_GridFrm.OnChangeAttachCountHandler;


end;


procedure TSuborderManager.ChangeAttachState(_id_suborder: integer);
begin
  F_AttachList.ChangeAttachState( _id_suborder );
end;

constructor TSuborderManager.Create;
begin
  inherited Create;
{
  F_DM := Tdm_Suborder.Create( nil );
  F_SOFrm := Tfrm_SubOrder.Create( nil );
  F_GridFrm := Tfrm_SubOrderGrid.Create( nil );
  F_VA := Tdm_SuborderVA.Create( nil );
  AttachCtrlsAndEvents;
 }

  F_VA := Tdm_SuborderVA.Create( nil ); //???? еще не уверен в нужности этой конструкции????

  F_DM := Tdm_Search1562.Create( nil );
  F_SOFrm := Tfrm_Order1562.Create( nil );  
  F_GridFrm := Tfrm_SubOrderGrid.Create( nil );
  F_AttachList := TAttachList.Create;

  AttachCtrlsAndEventsNew;

  SetOrderID( -1 );
  SetIsReadOnly( false );
end;

destructor TSuborderManager.Destroy;
begin
  F_DM.Free;
  F_SOFrm.Free;
  F_GridFrm.Free;
  F_VA.Free;
  F_AttachList.Free;
  F_SuborderAttacher.Free;
  inherited Destroy;
end;

function TSuborderManager.GetOrderFields: TOrderFields;
begin
 /// Result := F_DM.OrderFields;
end;

procedure TSuborderManager.IsAttached(_id_suborder: integer;
  var _IsAttached: boolean);
begin
  _IsAttached := F_AttachList.IsAttached( _id_suborder );
end;

procedure TSuborderManager.OnAttachHandler(Sender: TObject);
const
  ERR_MSG =
    'Вы не выбрали ни одной записи. Для выбора нужно зажать' + #13#10 +
    'клавишу "Shift" и щелкнуть по необходимой записи левой' + #13#10 +
    'кнопкой мыши!';
begin
  if F_AttachList.Count = 0 then
  begin
    Application.MessageBox( ERR_MSG, 'Внимание', MB_OK + MB_ICONWARNING );
    exit;
  end;

  if not Assigned( F_SuborderAttacher ) then
    F_SuborderAttacher := TSuborderAttacher.Create;

  F_SuborderAttacher.AttachedSuborderList := F_AttachList;
  if F_SuborderAttacher.Attach then
  begin
   /// F_DM.Refresh( F_AttachList );
    F_AttachList.Clear;
    F_GridFrm.ShowMsg( '' );
  end;
end;

procedure TSuborderManager.OnChangeShowModeHandler(
  _ShowMode: TSubOrderShowMode);
begin
///  F_DM.ReopenMainDset( _ShowMode );
end;

procedure TSuborderManager.OnCheckAlienHandler(var _Accept: boolean);
begin
  _Accept := ( Application.MessageBox( 'Данная запись будет переназначена текущей заявке. Продолжить?',
    'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES );
end;

procedure TSuborderManager.OnShowSOFrmHandler(var _IsOk: boolean);
begin
  _IsOk := ( F_SOFrm.ShowModal = mrOk );
end;

procedure TSuborderManager.SetIsReadOnly(Value: boolean);
begin
  F_IsReadOnly := ( Value ) or (not DM_RightsManager.IsCurrentUserCanEditForm( ORDERFORMGUID ) );

  F_GridFrm.IsReadOnly := F_IsReadOnly;
///  F_SOFrm.IsReadOnly := F_IsReadOnly;
end;

procedure TSuborderManager.SetOrderFields(Value: TOrderFields);
begin
///  F_DM.OrderFields := Value;
end;

procedure TSuborderManager.SetOrderID(Value: integer);
begin
  F_OrderID := Value;
///  F_DM.OrderID := Value;

  if Value = -1 then
  begin
    F_GridFrm.IsExtended := false;
  end else
  begin
    F_GridFrm.IsExtended := true;
  end;
end;



procedure TSuborderManager.ShowGridFrm;
begin
  F_VA.AttachToGlobalVocCache;

  F_DM.StartTransaction;
  try
    if F_OrderID = -1 then
///      F_DM.ReopenMainDset( smAllWithoutChecking )
    else
      //F_DM.ReopenMainDset( smAllWithChecking );
///      F_DM.ReopenMainDset( smCheckedAndFree );

    F_DM.Condition := ''; //тут будет выборка + сортировка
    F_DM.PrepareDset;
    F_GridFrm.ShowModal;

    F_DM.CommitTransaction;
  except
    on E: Exception do
    begin
      F_DM.RollBackTransaction;
      raise Exception.Create( E.Message + '(TSuborderManager.ShowGridFrm)' );
    end;
  end;
end;

procedure TSuborderManager.AddFieldToGrid( _field: string; _Title: string; _len: integer );
begin
    //
  with F_GridFrm.Spisok1562_Frame1.Grid do
   begin
    Columns.Add;
    Columns[Columns.Count-1].FieldName := _field;
    Columns[Columns.Count-1].Title.Caption := _Title;
    Columns[Columns.Count-1].Width := _len+64;
   end;
end;

end.
