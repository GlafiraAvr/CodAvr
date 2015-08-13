unit WorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, WorkDModule, Grids, DBGridEh, ExtCtrls, DBCtrls, StdCtrls,
  Buttons, ComCtrls;

type
  TDsetAction = (daInsert, daEdit);
  TActivePage = (apWork, apMater);
  TChangeDsetEvent = procedure (_DsetAction: TDsetAction) of object;
  TChangeViewDetailEvent = procedure ( _ActivePage: TActivePage; _ShowMode: TShowMode ) of object;

  Tfrm_Work = class(TForm)
    ds_BWork: TDataSource;
    Panel1: TPanel;
    dbg_BWork: TDBGridEh;
    pnl_WrkMat: TPanel;
    pc_Details: TPageControl;
    ts_Work: TTabSheet;
    ts_Mater: TTabSheet;
    dbg_Work: TDBGridEh;
    dbg_Mater: TDBGridEh;
    pnl_EditWrkAndMat: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btn_DelBWork: TBitBtn;
    btn_AddBWork: TBitBtn;
    btn_EditBWork: TBitBtn;
    btn_FastAdd: TBitBtn;
    btn_Exit: TBitBtn;
    btn_AddDetail: TBitBtn;
    btn_EditDetail: TBitBtn;
    btn_DelDetail: TBitBtn;
    Panel4: TPanel;
    ds_Work: TDataSource;
    ds_Mater: TDataSource;
    rg_DetailView: TRadioGroup;
    pnl_WorkBnts: TPanel;
    btn_RecalcWorkTime: TBitBtn;
    SB_Up: TSpeedButton;
    SB_Down: TSpeedButton;
    procedure btn_AddBWorkClick(Sender: TObject);
    procedure btn_EditBWorkClick(Sender: TObject);
    procedure dbg_BWorkDblClick(Sender: TObject);
    procedure btn_DelBWorkClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_AddDetailClick(Sender: TObject);
    procedure btn_EditDetailClick(Sender: TObject);
    procedure btn_DelDetailClick(Sender: TObject);
    procedure dbg_WorkDblClick(Sender: TObject);
    procedure rg_DetailViewClick(Sender: TObject);
    procedure btn_FastAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pc_DetailsChange(Sender: TObject);
    procedure dbg_MaterDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_WorkDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_RecalcWorkTimeClick(Sender: TObject);
    procedure SB_UpClick(Sender: TObject);
    procedure SB_DownClick(Sender: TObject);
  private
    F_ActivePage: TActivePage;
    procedure SetActivePage;
  private
    F_OnChangeBWork: TChangeDsetEvent;
    F_OnChangeWork: TChangeDsetEvent;
    F_OnChangeMater: TChangeDsetEvent;
    F_OnChangeViewDetail: TChangeViewDetailEvent;
    F_OnDelBWork: TNotifyEvent;
    F_OnDelWork: TNotifyEvent;
    F_OnDelMater: TNotifyEvent;
    F_OnFastAdd: TNotifyEvent;
    F_OnRecalcWorkTime: TNotifyEvent;
    F_OnMoveUpWork: TChangeDsetEvent;
    F_OnMoveDownWork: TChangeDsetEvent;
    F_IsReadOnly: boolean;
    procedure EditBWork;
    procedure EditWork;
    procedure EditMater;
    function GetDetailViewMode: TShowMode;
    procedure SetIsReadOnly(Value: boolean);
  public
    property OnChangeBWork: TChangeDsetEvent read F_OnChangeBWork
      write F_OnChangeBWork;
    property OnChangeWork: TChangeDsetEvent read F_OnChangeWork
      write F_OnChangeWork;
    property OnDelBWork: TNotifyEvent read F_OnDelBWork write F_OnDelBWork;
    property OnDelWork: TNotifyEvent read F_OnDelWork write F_OnDelWork;
    property OnChangeViewDetail: TChangeViewDetailEvent read F_OnChangeViewDetail
      write F_OnChangeViewDetail;
    property OnChangeMater: TChangeDsetEvent read F_OnChangeMater
      write F_OnChangeMater;
    property OnDelMater: TNotifyEvent read F_OnDelMater write F_OnDelMater;
    property OnFastAdd: TNotifyEvent read F_OnFastAdd write F_OnFastAdd;
    property OnRecalcWorkTime: TNotifyEvent read F_OnRecalcWorkTime
      write F_OnRecalcWorkTime;
    property IsReadOnly: boolean write SetIsReadOnly;
    property OnMoveUpWork: TChangeDsetEvent read F_OnMoveUpWork write F_OnMoveUpWork;
    property OnMoveDownWork: TChangeDsetEvent read F_OnMoveDownWork write F_OnMoveDownWork;
  end;

implementation

{$R *.dfm}

procedure Tfrm_Work.btn_AddBWorkClick(Sender: TObject);
begin
  if Assigned( F_OnChangeBWork) then
    F_OnChangeBwork( daInsert );
end;

procedure Tfrm_Work.btn_EditBWorkClick(Sender: TObject);
begin
  EditBWork;
end;

procedure Tfrm_Work.EditBWork;
begin
  if Assigned( F_OnChangeBWork) then
    F_OnChangeBwork( daEdit );
end;

procedure Tfrm_Work.dbg_BWorkDblClick(Sender: TObject);
begin
  if not F_IsReadOnly then
    EditBWork;
end;

procedure Tfrm_Work.btn_DelBWorkClick(Sender: TObject);
begin
  if Assigned( F_OnDelBWork ) then
    F_OnDelBWork( nil );
end;

procedure Tfrm_Work.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Work.btn_AddDetailClick(Sender: TObject);
begin
  if F_ActivePage = apWork then
  begin
    if Assigned( F_OnChangeWork ) then F_OnChangeWork( daInsert );
  end else
  begin
    if Assigned( F_OnChangeMater ) then F_OnChangeMater( daInsert );
  end;
end;

procedure Tfrm_Work.btn_EditDetailClick(Sender: TObject);
begin
  if F_ActivePage = apWork then
    EditWork
  else
    EditMater;
end;

procedure Tfrm_Work.EditWork;
begin
  if ( ( not F_IsReadOnly ) and
        ds_Work.DataSet.FieldByName( 'clc_IS_CAN_EDIT' ).AsBoolean and
        Assigned( F_OnChangeWork ) )
  then F_OnChangeWork( daEdit );
end;

procedure Tfrm_Work.btn_DelDetailClick(Sender: TObject);
begin
  if F_ActivePage = apWork then
  begin
    if ( ( not F_IsReadOnly ) and
          ds_Work.DataSet.FieldByName( 'clc_IS_CAN_EDIT' ).AsBoolean and
          Assigned( F_OnDelWork ) )
    then F_OnDelWork( nil );
  end else
  begin
    if Assigned( F_OnDelMater ) then F_OnDelMater( nil );
  end;
end;

procedure Tfrm_Work.dbg_WorkDblClick(Sender: TObject);
begin
  EditWork;
end;

function Tfrm_Work.GetDetailViewMode: TShowMode;
begin
  case rg_DetailView.ItemIndex of
    0: Result := smAll;
    1: Result := smAttached;
    2: Result := smFree;
  end;
end;

procedure Tfrm_Work.rg_DetailViewClick(Sender: TObject);
begin
  if Assigned( F_OnChangeViewDetail ) then
    F_OnChangeViewDetail( F_ActivePage, GetDetailViewMode );
end;

procedure Tfrm_Work.btn_FastAddClick(Sender: TObject);
begin
  if Assigned( F_OnFastAdd ) then
    F_OnFastAdd( Sender );
end;

procedure Tfrm_Work.SetActivePage;
begin
  case pc_Details.ActivePage.Tag of
    1: F_ActivePage := apWork;
    2: F_ActivePage := apMater;
  end;
end;

procedure Tfrm_Work.FormShow(Sender: TObject);
begin
  SetActivePage;

end;

procedure Tfrm_Work.pc_DetailsChange(Sender: TObject);
begin
  SetActivePage;
end;

procedure Tfrm_Work.EditMater;
begin
  if Assigned( F_OnChangeMater ) then
    F_OnChangeMater( daEdit );
end;

procedure Tfrm_Work.dbg_MaterDblClick(Sender: TObject);
begin
  if not F_IsReadOnly then
    EditMater;
end;

procedure Tfrm_Work.FormCreate(Sender: TObject);
begin
  SetIsReadOnly( false );
end;

procedure Tfrm_Work.SetIsReadOnly(Value: boolean);
var
  _val: boolean;
begin
  F_IsReadOnly := Value;

  _val := not Value;

  btn_AddBWork.Enabled := _val;
  btn_EditBWork.Enabled := _val;
  btn_DelBWork.Enabled := _val;

  btn_AddDetail.Enabled := _val;
  btn_EditDetail.Enabled := _val;
  btn_DelDetail.Enabled := _val;

  btn_FastAdd.Enabled := _val;
  btn_RecalcWorkTime.Enabled := _val;
end;

procedure Tfrm_Work.dbg_WorkDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with (Sender as TDBGridEh) do
  begin
    if not ds_Work.DataSet.FieldByName( 'clc_IS_CAN_EDIT' ).AsBoolean then
      Canvas.Brush.Color := clGrayText
    else
      Canvas.Brush.Color := clWindow;


    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_Work.btn_RecalcWorkTimeClick(Sender: TObject);
begin
  if ( not F_IsReadOnly ) and
     Assigned( F_OnRecalcWorkTime )
  then
  begin
    F_OnRecalcWorkTime( nil );
  end;
end;

procedure Tfrm_Work.SB_UpClick(Sender: TObject);
begin
//
 if ( not F_IsReadOnly ) and
  Assigned( F_OnMoveUpWork )
  then
   F_OnMoveUpWork( daEdit );
end;

procedure Tfrm_Work.SB_DownClick(Sender: TObject);
begin
//
 if ( not F_IsReadOnly ) and
 Assigned( F_OnMoveDownWork )
  then
   F_OnMoveDownWork( daEdit );
end;

end.
