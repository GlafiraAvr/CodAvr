unit WorkManager;

interface

uses WorkDModule, SysUtils, WorkVocAttcherDModule, WorkForm, Controls,
      Forms, Windows;

type
  TWorkManager=class
  private
    F_OrderID: integer;
    F_DepID: integer;
    F_DM: Tdm_Work;
    F_VA: Tdm_WorkVocAttacher;
    F_Frm: Tfrm_Work;
    F_DamageLoc:integer;
    procedure SetOrderID(const Value: integer);
    procedure SetDepID(const Value: integer);
    procedure SetWorkDate(const Value: TDateTime);
    procedure AttachCtrlsAndEvents;
    procedure SetIsReadOnly(Value: boolean);
  private
    procedure OnChangeBWorkHandler(_DsetAction: TDsetAction);
    procedure OnChangeWorkHandler(_DsetAction: TDsetAction);
    procedure OnChangeMaterHandler(_DsetAction: TDsetAction);
    procedure OnDelBWorkHandler(Sender: TObject);
    procedure OnDelWorkHandler(Sender: TObject);
    procedure OnDelMaterHandler(Sender: TObject);
    procedure OnChangeViewDetailHadler( _ActivePage: TActivePage; _ShowMode: TShowMode );
    procedure OnChangeActOptHandler(_ChangeActOpt: TChangeActionOption);
    procedure OnFastAddHandler(Sender: TObject);
    procedure OnRecalcWorkTimeHandler(Sender: TObject);
    procedure OnMoveUpWorkHandler(_DsetAction: TDsetAction);
    procedure OnMoveDownWorkHandler(_DsetAction: TDsetAction);
  public
    property OrderID: integer read F_OrderID write SetOrderID;
    property DepID: integer read F_DepID write SetDepID;
    property WorkDate: TDateTime write SetWorkDate;
    property IsReadOnly: boolean write SetIsReadOnly;
    procedure Execute;
    constructor Create;
    destructor Destroy; override;
    property _DamageLoc:integer write  F_DamageLoc;
  end;

implementation

uses BWorkInsertForm, BWorkEditForm, BWorkChangeForm, BWorkDelForm,
      EditWorkForm, EditMaterForm, FastAddWorkForm, EditWorkVocDM;

{ TWorkManager }

procedure TWorkManager.AttachCtrlsAndEvents;
begin
  F_Frm.ds_BWork.DataSet := F_DM.dset_BWork;
  F_Frm.ds_Work.DataSet := F_DM.dset_Work;
  F_Frm.ds_Mater.DataSet := F_DM.dset_Mater;

  F_Frm.OnChangeBWork := OnChangeBWorkHandler;
  F_Frm.OnChangeWork := OnChangeWorkHandler;
  F_Frm.OnChangeMater := OnChangeMaterHandler;
  F_Frm.OnChangeViewDetail := OnChangeViewDetailHadler; 
  F_Frm.OnDelBWork := OnDelBWorkHandler;
  F_Frm.OnDelWork := OnDelWorkHandler;
  F_Frm.OnDelMater := OnDelMaterHandler;
  F_Frm.OnFastAdd := OnFastAddHandler;
  F_Frm.OnRecalcWorkTime := OnRecalcWorkTimeHandler;
  F_Frm.OnMoveUpWork := OnMoveUpWorkHandler;
  F_Frm.OnMoveDownWork := OnMoveDownWorkHandler;
end;

procedure TWorkManager.OnChangeBWorkHandler(_DsetAction: TDsetAction);
var
  _frm: Tfrm_BWorkChange;
begin
  if _DsetAction = daInsert then
    _frm := Tfrm_BWorkInsert.Create( nil )
  else
    _frm := Tfrm_BWorkEdit.Create( nil );

  try
    _frm.ds_BWork.DataSet := F_DM.dset_BWork;
    _frm.ds_BWorkAtt.DataSet := F_VA.mt_BWork;
    _frm.OnChangeActOpt := OnChangeActOptHandler;

    if _DsetAction = daInsert then
      F_DM.dset_BWork.Append
    else
      F_DM.dset_BWork.Edit;

    if _frm.ShowModal = mrOk then
      F_DM.dset_BWork.Post
    else
      F_DM.dset_BWork.Cancel;
  finally
    _frm.Free;
  end;
end;

constructor TWorkManager.Create;
begin
  inherited Create;
  F_DM := Tdm_Work.Create( nil );
  F_VA := Tdm_WorkVocAttacher.Create( nil );
  F_Frm := Tfrm_Work.Create( nil );

  AttachCtrlsAndEvents;
end;

destructor TWorkManager.Destroy;
begin
  F_DM.Free;
  F_VA.Free;
  F_Frm.Free;
  inherited Destroy;
end;

procedure TWorkManager.Execute;
begin
  F_VA.AttachToGlobalVocCache;

  F_DM.StartTran;
  try
    F_DM.OpenDset;
    F_Frm.ShowModal;

    F_DM.CommitTran;
  except
    on E: Exception do
    begin
      raise Exception.Create( E.Message + '(TWorkManager.Execute)' );
      F_DM.RollbackTran;
    end;
  end;
end;

procedure TWorkManager.SetDepID(const Value: integer);
begin
  F_DepID := Value;
  F_DM.DepID := Value;
end;

procedure TWorkManager.SetOrderID(const Value: integer);
begin
  F_OrderID := Value;
  F_DM.OrderID := Value;
end;

procedure TWorkManager.OnDelBWorkHandler(Sender: TObject);
var
  _frm: Tfrm_BWorkDel;
begin
  _frm := Tfrm_BWorkDel.Create( nil );
  _frm.OnChangeActOpt := OnChangeActOptHandler;
  try
    if ( _frm.ShowModal = mrOk ) and ( not F_DM.dset_BWork.IsEmpty ) then
      F_DM.dset_BWork.Delete;
  finally
    _frm.Free;
  end;
end;

procedure TWorkManager.OnChangeWorkHandler(_DsetAction: TDsetAction);
var
  _frm: Tfrm_EditWork;
  _dm: Tdm_EditWorkVoc;
  _b: pointer;
begin

  _dm := Tdm_EditWorkVoc.Create( nil );
  try
    _frm := Tfrm_EditWork.Create( nil );
    try
      _frm._DamageLoc:=F_DamageLoc; //местность повреждени€ из нар€да
      _frm.ds_Work.DataSet := F_DM.dset_Work;
      //_frm.ds_WorkAtt.DataSet := F_VA.mt_Works;
      //_frm.ds_DiamAtt.DataSet := F_VA.mt_Diam;
      _frm.ds_WorkAtt.DataSet := _dm.dset_Works;
       
      _frm.ds_DiamAtt.DataSet := _dm.dset_Diams;

      if _DsetAction = daInsert then
        F_DM.dset_Work.Insert
      else
        F_DM.dset_Work.Edit;

      if _frm.ShowModal = mrOk then
        F_DM.dset_Work.Post
      else
        F_DM.dset_Work.Cancel;

    //  F_DM.dset_Work.Refresh;

    finally
      _frm.Free;
    end;
  finally
    _dm.Free;
  end;
  // этот кусок - костыль дл€ того, чтобы отображалось значение после POST нормально
   _b:= F_DM.dset_Work.GetBookmark;
   F_DM.dset_Work.Close;
   F_DM.dset_Work.Open;
   F_DM.dset_Work.GotoBookmark(_b);

end;

procedure TWorkManager.OnDelWorkHandler(Sender: TObject);
begin
  if ( not F_DM.dset_Work.IsEmpty ) and
    ( Application.MessageBox( '¬ы уверены, что хотите удалить подработу?',
      '¬нимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES ) then
    F_DM.dset_Work.Delete;
end;

procedure TWorkManager.SetWorkDate(const Value: TDateTime);
begin
  F_DM.WorkDate := Value;
end;

procedure TWorkManager.OnChangeViewDetailHadler(_ActivePage: TActivePage;
  _ShowMode: TShowMode);
begin
  F_DM.ShowMode := _ShowMode;
end;

procedure TWorkManager.OnChangeActOptHandler(
  _ChangeActOpt: TChangeActionOption);
begin
  F_DM.ChangeActionOption := _ChangeActOpt;
end;

procedure TWorkManager.OnFastAddHandler(Sender: TObject);
var
  _frm: Tfrm_FastAddWork;
begin
  F_DM.FillFastAdd;

  _frm := Tfrm_FastAddWork.Create( nil );
  try
    _frm.ds_Main.DataSet := F_DM.md_FastAdd;

    if _frm.ShowModal = mrOk then
      F_DM.PostFastAdd;
  finally
    _frm.Free;
  end;
end;

procedure TWorkManager.OnChangeMaterHandler(_DsetAction: TDsetAction);
var
  _frm: Tfrm_EditMater;
begin
  _frm := Tfrm_EditMater.Create( nil );
  try
    _frm.ds_Mater.DataSet := F_DM.dset_Mater;
    //_frm.ds_MaterAtt.DataSet := F_DM.mt_Maters;
    //_frm.ds_DiamAtt.DataSet := F_DM.mt_Diam;
    _frm.ds_MaterAtt.DataSet := F_VA.mt_Maters;
    _frm.ds_DiamAtt.DataSet := F_VA.mt_Diam;

    if _DsetAction = daInsert then
      F_DM.dset_Mater.Append
    else
      F_DM.dset_Mater.Edit;

    if _frm.ShowModal = mrOk then
      F_DM.dset_Mater.Post
    else
      F_DM.dset_Mater.Cancel;

  finally
    _frm.Free;
  end;
end;

procedure TWorkManager.OnDelMaterHandler(Sender: TObject);
begin
  if ( not F_DM.dset_Mater.IsEmpty ) and
    ( Application.MessageBox( '¬ы уверены, что хотите удалить материал?',
      '¬нимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES ) then
    F_DM.dset_Mater.Delete;
end;

procedure TWorkManager.SetIsReadOnly(Value: boolean);
begin
  F_Frm.IsReadOnly := Value;
end;

procedure TWorkManager.OnRecalcWorkTimeHandler(Sender: TObject);
begin
  F_DM.RecalcWorkTimeForAll;
end;

procedure TWorkManager.OnMoveUpWorkHandler(_DsetAction: TDsetAction);
begin
    //

   F_DM.WorkMoveUp;
end;

procedure TWorkManager.OnMoveDownWorkHandler(_DsetAction: TDsetAction);
begin
    //

    F_DM.WorkMoveDown;

end;

end.
