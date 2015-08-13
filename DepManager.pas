unit DepManager;

interface

uses DepsDModule,  DepartureVocCacheDModule, DepsForm, DB, DepChargeManager,
  Forms, Windows, SysUtils, GridFormManager;

type
  TDepManager=class(TGridFormManager)
  private
    F_OfficialID: integer;
    F_DM: Tdm_Deps;
    F_VocCache: Tdm_DepartureVocCache;
    F_Form: Tfrm_Deps;
    procedure SetOfficialID(const Value: integer);
  private
    procedure DepWorkBtnClickHandler(Sender: TObject);
    procedure DepWorkersBtnClickHandler(Sender: TObject);
    procedure DepEquipBtnClickHandler(Sender: TObject);
  protected
    procedure CreateForms; override;
    procedure AttachCtrlsAndEvents; override;
    function GetFormGUID: string; override;
  public
    property OfficialID: integer read F_OfficialID write SetOfficialID;
    function Show: boolean; override;
  end;


implementation

uses DepWorkersForm,  AppGUIDS, WorkManager;

{ TDepManager }

procedure TDepManager.AttachCtrlsAndEvents;
begin
  F_Form.ds_Main.DataSet := F_DM.dset_Main;
  F_Form.ds_Brig.DataSet := F_VocCache.cds_Brig;
  F_Form.OnDepWorkBtnClick := DepWorkBtnClickHandler;
  F_Form.OnDepWorkersBtnClick := DepWorkersBtnClickHandler;
  F_Form.OnDepEquipBtnClick := DepEquipBtnClickHandler;
  F_DM.OnMyAfterOpen :=F_Form.AfterOpenHandler;
end;


procedure TDepManager.CreateForms;
begin
  F_VocCache := CreateVocCache( Tdm_DepartureVocCache ) as Tdm_DepartureVocCache;
  F_DM := CreateDM( Tdm_Deps ) as Tdm_Deps;
  F_Form := CreateForm( Tfrm_Deps ) as Tfrm_Deps;
end;

procedure TDepManager.DepWorkBtnClickHandler(Sender: TObject);
var
  _WrkMgr: TWorkManager;
  _DepID: integer;
begin
  _DepID := F_DM.GetActiveDepID;

  if _DepID <> -1 then
  begin
    _WrkMgr := TWorkManager.Create;
    try
      _WrkMgr.OrderID := F_OrderID;
      _WrkMgr.DepID := _DepID;
      _WrkMgr.WorkDate := F_DM.GetActiveStartDate;
      _WrkMgr.IsReadOnly := (F_IsReadOnly) or ( not F_DM.IsCanEditCurrentRec );
      _WrkMgr.Execute;
    finally
      _WrkMgr.Free;
    end;
  end else
    Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
      'Выезды', MB_OK + MB_ICONWARNING );
end;

procedure TDepManager.DepEquipBtnClickHandler(Sender: TObject);
var
  _DepChargeMan: TDepChargeManager;
  _DepID: integer;
begin
  _DepID := F_DM.GetActiveDepID;

  if _DepID <> -1 then
  begin
    _DepChargeMan := TDepChargeManager.Create;
    try
      _DepChargeMan.OrderID := F_OrderID;;
      _DepChargeMan.DepID := _DepID;
      _DepChargeMan.IsReadOnly := (F_IsReadOnly) or ( not F_DM.IsCanEditCurrentRec );
      _DepChargeMan.ShowCharge;
    finally
      _DepChargeMan.Free;
    end;
  end else
    Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
      'Выезды', MB_OK + MB_ICONWARNING );
end;

procedure TDepManager.DepWorkersBtnClickHandler(Sender: TObject);
var
  _DepID: integer;
  _DWF: Tfrm_DepWorkers;
  _IsReadOnly: boolean;
begin
  _DepID := F_DM.GetActiveDepID;

  if _DepID <> -1 then
  begin
    _IsReadOnly := ( F_IsReadOnly ) or ( not F_DM.IsCanEditCurrentRec );
    _DWF := Tfrm_DepWorkers.Create( nil, F_OrderID, _DepID, F_DM.GetActiveBrigID, _IsReadOnly );
    try
      _DWF.ShowModal;
    finally
      _DWF.Free;
    end;
  end else
    Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
      'Выезды', MB_OK + MB_ICONWARNING );
end;


function TDepManager.GetFormGUID: string;
begin
  Result := DEPARTURESFORMGUID;
end;

procedure TDepManager.SetOfficialID(const Value: integer);
begin
  F_OfficialID := Value;
  F_DM.OfficialID := Value;
end;

function TDepManager.Show: boolean;
begin
  F_VocCache.ReopenVocDsets;
  F_DM.OpenDset;
  F_Form.ShowModal;
end;

end.
