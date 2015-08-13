unit GridFormManager;

interface

uses GridEditDModule, GridEditForm, VocCacheDModule, DB;

type
  TFormClass = class of Tfrm_GridEdit;
  TDataModuleClass = class of Tdm_GridEdit;
  TVocCacheClass= class of Tdm_VocCache;

  TGridFormManager=class
  private
    _F_Form: Tfrm_GridEdit;
    _F_DM: Tdm_GridEdit;
    _F_VocCache: Tdm_VocCache;
  protected
    F_RegionID: integer;
    F_OrderID: integer;
    F_IsReadOnly: boolean;
    procedure SetOrderID(const Value: integer);
    procedure SetIsReadOnly(const Value: boolean);
  protected
    function CreateForm(_ClassRef: TFormClass): Tfrm_GridEdit;
    function CreateDM(_ClassRef: TDataModuleClass): Tdm_GridEdit;
    function CreateVocCache(_ClassRef: TVocCacheClass): Tdm_VocCache;
  protected
    procedure CreateForms; virtual; abstract;
    procedure AttachCtrlsAndEvents; virtual; abstract;
    function GetFormGUID: string; virtual; abstract;
  protected
    procedure AfterPostAndCancelHandler(DataSet: TDataSet);
    procedure AfterInsertAndEditHandler(DataSet: TDataSet);
  public
    constructor Create(_RegionID: integer);
    property OrderID: integer read F_OrderID write SetOrderID;
    property IsReadOnly: boolean read F_IsReadOnly write SetIsReadOnly;
    destructor Destroy; override;
    function Show: boolean; virtual; 
  end;

implementation

{ TGridFormManager }

uses RightsManagerDModule;

procedure TGridFormManager.AfterInsertAndEditHandler(DataSet: TDataSet);
begin
  _F_VocCache.ShowDeletedRowInVocs( false );
end;

procedure TGridFormManager.AfterPostAndCancelHandler(DataSet: TDataSet);
begin
   _F_VocCache.ShowDeletedRowInVocs( true );
end;

constructor TGridFormManager.Create(_RegionID: integer);
begin
  inherited Create;
  F_RegionID := _RegionID;
  CreateForms;
  AttachCtrlsAndEvents;
  //
  _F_DM.OnMyAfterInsert  := AfterInsertAndEditHandler;
  _F_DM.OnMyAfterEdit := AfterInsertAndEditHandler;
  _F_DM.OnMyAfterPost := AfterPostAndCancelHandler;
  _F_DM.OnMyAfterCancel := AfterPostAndCancelHandler;
  _F_DM.OnMyAfterScroll := _F_Form.AfterScrollHandler;
  _F_DM.OnMyFieldChange := _F_Form.FieldValueChangeHandler;
end;

function TGridFormManager.CreateDM(
  _ClassRef: TDataModuleClass): Tdm_GridEdit;
begin
  _F_DM := _ClassRef.Create(nil);
  Result := _F_DM;
end;

function TGridFormManager.CreateForm(_ClassRef: TFormClass): Tfrm_GridEdit;
begin
  _F_Form := _ClassRef.Create(nil);
  Result := _F_Form;
end;

function TGridFormManager.CreateVocCache(
  _ClassRef: TVocCacheClass): Tdm_VocCache;
begin
  _F_VocCache := _ClassRef.Create(nil);
  Result := _F_VocCache;
end;

destructor TGridFormManager.Destroy;
begin
  _F_DM.Free;
  _F_Form.Free;
  _F_VocCache.Free;
  inherited Destroy;
end;

procedure TGridFormManager.SetIsReadOnly(const Value: boolean);
begin
  if  ( not DM_RightsManager.IsCurrentUserCanEditForm( GetFormGUID ) ) or
      ( not DM_RightsManager.IsCurrentDistrictHasAccesToRegion( F_RegionID ) ) then
  begin
    F_IsReadOnly := true;
    _F_Form.ConstMessage := 'У вас недостаточно прав для редактирования данной формы';
  end else
  begin
    F_IsReadOnly := false;
    _F_Form.ConstMessage := '';
  end;

  F_IsReadOnly := F_IsReadOnly or Value;

  _F_Form.IsReadOnly := F_IsReadOnly;
end;

procedure TGridFormManager.SetOrderID(const Value: integer);
begin
  F_OrderID := Value;
  _F_DM.OrderID := Value;
end;

function TGridFormManager.Show: boolean;
begin
//
end;

end.
