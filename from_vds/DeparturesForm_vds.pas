unit DeparturesForm_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrlsEh, StdCtrls, Mask, ToolEdit, RXDBCtrl,
  RxLookup, DModule, IBDatabase, DB, IBCustomDataSet, BaseGridForm, Grids,
  DBGrids, Buttons, DBCtrls, ExtCtrls, IBSQL;


type
  Tfrm_Departures = class(Tfrm_BaseGrid)
    TabC: TTabControl;
    de_Start: TDBDateEdit;
    de_End: TDBDateEdit;
    dbl_Brig: TRxDBLookupCombo;
    te_Start: TDBDateTimeEditEh;
    te_End: TDBDateTimeEditEh;
    dset_Brig: TIBDataSet;
    ds_Brig: TDataSource;
    dset_mainID: TIntegerField;
    dset_mainSTARTDATE: TDateTimeField;
    dset_mainENDDATE: TDateTimeField;
    dset_mainFK_DEPARTURES_BRIGADIERS: TIntegerField;
    dset_mainFK_DEPARTURES_OFFICIALSOPEN: TIntegerField;
    dset_mainFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField;
    dset_mainADDITIONALINFO: TIBStringField;
    dset_mainFK_DEPARTURES_ORDERS: TIntegerField;
    mem_AddInfo: TDBMemo;
    DBT_OffOpen: TDBText;
    DBT_OffClose: TDBText;
    dset_mainOFFOPEN: TIBStringField;
    dset_mainOFFCLOSE: TIBStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ed_WorkersCount: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    dset_mainWORKERSCOUNT: TIntegerField;
    btn_WorkAndMater: TBitBtn;
    dset_mainBRIG: TIBStringField;
    dset_tmp: TIBDataSet;
    IBSQL: TIBSQL;
    btn_Workers: TBitBtn;
    btn_numsclose: TBitBtn;
    dset_Nums1562: TIBDataSet;
    tran_1562: TIBTransaction;
    IBSQ_1562: TIBSQL;
    GroupBox1: TGroupBox;
    btn_planEquip: TBitBtn;
    btn_planworkmat: TBitBtn;
    gb_Plan: TGroupBox;
    dset_mainPLANSTARTDATE: TDateTimeField;
    dset_mainPLANENDDATE: TDateTimeField;
    dset_mainOFFPLAN: TIBStringField;
    DBE_StartPlan: TDBDateEdit;
    DBDE_EndPlan: TDBDateEdit;
    DBT_strartplan: TDBDateTimeEditEh;
    DBDTEndPlan: TDBDateTimeEditEh;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBT_OffPLan: TDBText;
    dset_mainFK_DEPARTURES_OFFISIALSPLAN: TIntegerField;

    procedure btn_InsertClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure dset_mainAfterOpen(DataSet: TDataSet);
    procedure dset_mainAfterDelete(DataSet: TDataSet);
    procedure TabCChange(Sender: TObject);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
    procedure dbg_MainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_WorkAndMaterClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure TabCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dset_mainBeforeDelete(DataSet: TDataSet);
    procedure btn_WorkersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_numscloseClick(Sender: TObject);
    procedure dset_mainAfterInsert(DataSet: TDataSet);
    procedure btn_planEquipClick(Sender: TObject);
    procedure btn_planworkmatClick(Sender: TObject);
    procedure dset_mainBeforePost(DataSet: TDataSet);
  protected
    class function GetGUID: string; override;
  protected
    procedure InitVocDsetList; override;
    procedure EnableCtrls(value: boolean); override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    F_RecordCount: integer;
    F_IsWorkAndMaterExists: boolean;
    F_IsWorkersExists: boolean;

    Nums1562,nums1562_view:string;
    F_ShiftDate:tDateTime;
    procedure SetIsWorkAndMaterExists;
    procedure SetIsWorkersExists;
    procedure SetRecordCount(value: integer);
    procedure SetNums1562();
    procedure Enabled_closed1562();
  private
    F_IDOfficials: integer;
    F_Region:integer;
    function IsInCurShift( _DT: TDateTime): boolean;
    function IntShift( _DT: TDateTime):integer;
    procedure SetInCurShift();
  public
    property IDOfficials: integer read F_IDOfficials write F_IDOfficials;
    property ShiftDate:TDateTime read F_ShiftDate write F_ShiftDate;
    property regionID:integer  write F_region;
  end;


implementation

{$R *.dfm}

uses WorkAndMaterForm_vds, HelpFunctions, DepWorkersForm, AppGUIDS,StringConsts,
DepPlanWorkManager, DepPlanChangManager,Math,GlobalData;

{ Tfrm_Departures }


procedure Tfrm_Departures.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  de_Start.Enabled:=value;
  te_Start.Enabled:=value;
  de_End.Enabled:=value;
  te_End.Enabled:=value;
  dbl_brig.Enabled:=value;
  mem_AddInfo.ReadOnly:=not value;
  //Enabled:=value;
  ed_WorkersCount.Enabled:=value;
end;

procedure Tfrm_Departures.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_Departures_orders').AsInteger:=F_OrderID;
  dset_Main.FieldByName('fk_departures_OfficialsOpen').AsInteger:=F_IDOfficials;

  TabC.Tabs.Add('Новый');
  TabC.TabIndex:=TabC.Tabs.Count-1;
end;

function Tfrm_Departures.IsDateCorrect: boolean;
begin
  Result:=false;

  if dset_Main.FieldByName('StartDate').IsNull then
  begin
    ProcessStatus:='Введите дату и время начала работ';
    ActiveControl:=de_Start;
    exit;
  end;

 { if dset_Main.FieldByName('StartDate').AsDateTime>Now then
  begin
    ProcessStatus:='Дата и время начала работ не могут быть больше текущих';
    ActiveControl:=te_Start;
    exit;
  end;
 }
  if (not dset_Main.FieldByName('EndDate').IsNull)
    and (dset_Main.FieldByName('EndDate').AsDateTime>Now) then
  begin
    ProcessStatus:='Дата и время окончания работ не могут быть больше текущих';
    ActiveControl:=te_End;
    exit;
  end;

  if (not dset_Main.FieldByName('EndDate').IsNull)
  and (dset_Main.FieldByName('EndDate').AsDateTime<dset_Main.FieldByName('StartDate').AsDateTime) then
  begin
    ProcessStatus:='Дата начала работ не может быть больше даты конца работ';
    ActiveControl:=de_End;
    exit;
  end;

   if ( not dset_Main.FieldByName( 'StartDate' ).IsNull ) and
   ( (IntShift(dset_Main.FieldByName( 'StartDate' ).AsDateTime)>2) or
   (IntShift(dset_Main.FieldByName( 'StartDate' ).AsDateTime)<=0))then
  begin
    ProcessStatus:='Дата начала работ должна быть в пределах ТЕКУЩЕЙ и СЛЕДУЮЩЕЙ СМЕН! ';
     ActiveControl:=te_Start;
    exit;
  end;

    if ( not dset_Main.FieldByName( 'EndDate' ).IsNull ) and
   not IsInCurShift(dset_Main.FieldByName( 'EndDate' ).AsDateTime) then
  begin
   ProcessStatus:='Дата и время окончания работ должны быть в пределах ТЕКУЩЕЙ СМЕНЫ';
    ActiveControl:=te_End;

    exit;
  end;

  if ( not dset_main.FieldByName('PLANSTARTDATE').IsNull) and
      (not dset_main.FieldByName('PLANENDDATE').IsNull) then
      if   dset_main.fieldbyname('PLANSTARTDATE').AsDateTime>
              dset_main.fieldbyname('PLANENDDATE').AsDateTime then
       begin
        ProcessStatus:='Дата  план начала работ не может быть больше план даты конца работ';
        ActiveControl:=DBDE_EndPlan;
        exit;
      end;

  if (not dset_main.FieldByName('PLANSTARTDATE').IsNull) then begin
   if (IntShift(dset_main.FieldByName('PLANSTARTDATE').asDateTime)>2)
    or
     (IntShift(dset_Main.FieldByName( 'StartDate' ).AsDateTime)<=0) then
    begin
      ProcessStatus:='Дата  план начала должна быть в пределах ТЕКУЩЕЙ и СЛЕДУЮЩЕЙ СМЕН! ';
      ActiveControl:=DBE_StartPlan;
      exit;
    end;
    
    if IntShift(dset_main.FieldByName('PLANSTARTDATE').asDateTime)<>
       IntShift(dset_Main.FieldByName( 'StartDate' ).AsDateTime) then
    begin
      ProcessStatus:='Дата начала работ и дата план начала работ должна быть в ОДНУ СМЕНУ! ';
      ActiveControl:=te_Start;
      exit;
    end;
  end;

 if (IntShift(dset_Main.FieldByName( 'StartDate' ).AsDateTime)>1) and
      (dset_main.FieldByName('PLANSTARTDATE').IsNull) then
      begin
       ProcessStatus:='Для выездов на след. смену введите дату плана! ';
       ActiveControl:=DBE_StartPlan;
        exit;
      end;


  Result:=true;
end;

function Tfrm_Departures.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Brig) then
  begin
    ActiveControl:=dbl_Brig;
    SetProcessStatus('Введите ответственного за проведение работ');
    exit;
  end;

  Result:=true;
end;

procedure Tfrm_Departures.btn_PostClick(Sender: TObject);
begin
  if not dset_Main.FieldByName('EndDate').IsNull then
    dset_Main.FieldByName('fk_departures_OfficialsClose').AsInteger:=F_IDOfficials;

  if not dset_main.FieldByName('PlanEndDate').IsNull then
    if dset_main.FieldByName('PlanStartDate').IsNull then
     if not dset_main.FieldByName('STARTDATE').IsNull then
      begin
       dset_main.FieldByName('PlanStartDate').AsDateTime:=dset_main.fieldbyname('STARTDATE').AsDateTime;
       dset_main.FieldByName('FK_DEPARTURES_OFFISIALSPLAN').AsInteger:=F_IDOfficials;
      end;

  if not dset_main.FieldByName('PlanStartDate').IsNull then
   dset_main.FieldByName('FK_DEPARTURES_OffisialsPlan').AsInteger:=F_IDOfficials;

  if dset_main.FieldByName('ADDITIONALINFO').IsNull then dset_main.FieldByName('ADDITIONALINFO').AsString:='';
  inherited btn_PostClick(Sender);
end;

procedure Tfrm_Departures.dset_mainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dset_Main.Last;
  SetRecordCount(dset_main.RecordCount);
  Enabled_closed1562;
  dset_Main.First;
end;

procedure Tfrm_Departures.dset_mainAfterDelete(DataSet: TDataSet);
begin
  inherited;
  SetRecordCount(dset_main.RecordCount);
  Enabled_closed1562;
end;

procedure Tfrm_Departures.SetRecordCount(value: integer);
var
  i: integer;
begin
  F_RecordCount:=value;

  TabC.Tabs.Clear;
  for i:=1 to F_RecordCount do
  begin
    if i=1 then
      TabC.Tabs.Add('Первичный')
    else
      TabC.Tabs.Add('N'+IntToStr(i));
  end;
  TabC.TabIndex:=dset_Main.RecNo-1;

  Caption:='Выезды - Всего выездов: '+IntToStr(F_RecordCount);
end;

procedure Tfrm_Departures.TabCChange(Sender: TObject);
begin
  inherited;
  dset_Main.RecNo:=TabC.TabIndex+1;
end;

procedure Tfrm_Departures.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  TabC.TabIndex:=dset_Main.RecNo-1;
  SetIsWorkAndMaterExists;
  SetIsWorkersExists;
  SetInCurShift;
end;

procedure Tfrm_Departures.dbg_MainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  with (Sender as TDBGrid) do
  begin
    if dset_Main.FieldByName('EndDate').IsNull then
      Canvas.Brush.Color:=clWindow
    else
      Canvas.Brush.Color:=clGrayText;
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_Departures.btn_WorkAndMaterClick(Sender: TObject);
 var
  WrkFrm: Tfrm_WorkAndMater;
begin
  inherited;

  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
    WrkFrm:=Tfrm_WorkAndMater.Create(nil, F_OrderID, dset_Main.FieldByName('ID').AsInteger, F_ReadOnly);
    try
      WrkFrm.ShowModal;
      SetIsWorkAndMaterExists;
    finally
      WrkFrm.Free
    end;
  end else
    if not F_ReadOnly then
      Application.MessageBox('Для ввода данной информации необходимо зарегистрировать выезд',
                              'Внимание', MB_OK+MB_ICONWARNING);
end;

procedure Tfrm_Departures.btn_CancelClick(Sender: TObject);
begin
  if (dset_Main.State=dsInsert) and (TabC.Tabs.Count>0) then
    TabC.Tabs.Delete(TabC.Tabs.Count-1);

  inherited btn_CancelClick(Sender);
end;

procedure Tfrm_Departures.TabCChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if dset_Main.State in [dsInsert, dsEdit] then
  begin
    AllowChange:=false;
    SetProcessStatus('Отмените или сохраните изменения');
  end else
  begin
    AllowChange:=true;
  end;
end;

procedure Tfrm_Departures.SetIsWorkAndMaterExists;
const
  ARR_SQL: array [1..3] of string=
  (
    'select count(*) kol from departurematerials where fk_usedmaterials_departure=%d',
    'select count(*) kol from departurework  where fk_depwork_departure=%d',
    'select count(*) kol from departureequipments  where fk_depequipment_departures=%d'
  );
var
  i: integer;
begin
  F_IsWorkAndMaterExists:=false;
{  if not (dset_Main.Eof and dset_Main.Bof) and
    not (dset_Main.State in [dsInsert]) then
  begin
    for i:=low(ARR_SQL) to high(ARR_SQL) do
    begin
      MyOpenIBDS(dset_tmp, Format(ARR_SQL[i], [dset_Main.FieldByName('ID').AsInteger]));
      if dset_tmp.FieldByName('kol').AsInteger>0 then
      begin
        F_IsWorkAndMaterExists:=true;
        break;
      end;
    end;
    dset_tmp.Close;
  end;

///
  if F_IsWorkAndMaterExists then
    btn_WorkAndMater.Font.Color:=clGreen
  else
    btn_WorkAndMater.Font.Color:=clBlack;}
end;

procedure Tfrm_Departures.dset_mainBeforeDelete(DataSet: TDataSet);
const
  ARR_SQL: array [1..3] of string=
  (
    'delete from departurematerials where fk_usedmaterials_departure=%d',
    'delete from departurework  where fk_depwork_departure=%d',
    'delete from departureequipments  where fk_depequipment_departures=%d'
  );
var
  i: integer;
begin
  inherited;

{  for i:=low(ARR_SQL) to High(ARR_SQL) do
    MyExecIBSQL(IBSQL, Format(ARR_SQL[i], [dset_Main.FieldByName('ID').AsInteger]));}
end;

procedure Tfrm_Departures.btn_WorkersClick(Sender: TObject);
var
  frm: Tfrm_DepWorkers;
begin
  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
    frm:=Tfrm_DepWorkers.Create(nil, F_OrderID, dset_Main.FieldByName('ID').AsInteger,
          dset_Brig.FieldByName('ID').AsInteger, F_ReadOnly,true,F_Region);
    try
      frm.ShowModal;
    finally
      frm.Free;
    end;
    SetIsWorkersExists;
  end else
    if not F_ReadOnly then
      Application.MessageBox('Для ввода данной информации необходимо зарегистрировать выезд',
                              'Внимание', MB_OK+MB_ICONWARNING);
end;

procedure Tfrm_Departures.SetIsWorkersExists;
const
  SQL='select count(*) kol from departureworkers_vds where fk_depworkers_departure=%d';
begin
  F_IsWorkersExists:=false;
  if not (dset_Main.Eof and dset_Main.Bof) and
    not (dset_Main.State in [dsInsert]) then
  begin
    MyOpenIBDS(dset_tmp, Format(SQL, [dset_Main.FieldByName('ID').AsInteger]));
    if (dset_tmp.FieldByName('kol').AsInteger>0) then
    begin
     F_IsWorkersExists:=true;
     dset_Main.Edit;
     dset_main.FieldByName('WORKERSCOUNT').AsInteger:=dset_tmp.FieldByName('kol').AsInteger;
     dset_main.Post;
    end;

    dset_tmp.Close;
  end;
///
  if F_IsWorkersExists then
    btn_Workers.Font.Color:=clGreen
  else
    btn_Workers.Font.Color:=clBlack;
end;

class function Tfrm_Departures.GetGUID: string;
begin
  Result:=DEPARTUREFORMGUID_vds;
end;

procedure Tfrm_Departures.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_Brig);
end;

procedure Tfrm_Departures.SetNums1562();
begin
Nums1562:='';
Nums1562_view:='';
try
 if   not tran_1562.InTransaction then
  tran_1562.StartTransaction;
  dset_nums1562.SelectSQL.Text:=format('select id_1562,number from numsorders_vds where id_order=%d'+
                                ' and state_avar<>'''' and state_avar is not null'+
                                '  and state_inner=1 and number<>0 ',[F_OrderID]);
  dset_nums1562.Open;
  dset_nums1562.First;
  while  not dset_nums1562.Eof do
  begin
    Nums1562:=Nums1562+dset_nums1562.fieldbyname('id_1562').asstring+', ';
    Nums1562_view:=Nums1562_view+dset_nums1562.fieldbyname('number').asstring+' ('+dset_nums1562.fieldbyname('id_1562').asstring+'), '+#13;
    dset_nums1562.Next;
  end;
  Delete(Nums1562,length(Nums1562)-1,1);
  Delete(Nums1562_view,length(Nums1562_view)-2,2);
 except on e:exception do   begin
  Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
  exit;
 end;

 end;
end;

procedure Tfrm_Departures.Enabled_closed1562();
begin
   MyOpenSql(dset_tmp,format('select count(*) from departures_vds ds'+
                         ' where  ds.fk_departures_orders=%d'+
                         ' and ds.enddate is not null',[F_Orderid]));
  if (dset_tmp.FieldByName('count').AsInteger=F_RecordCount)and (dset_main.State<>dsInsert)and (dset_main.State<>dsEdit) then
    btn_numsclose.Enabled:=((length(nums1562)>1) and  (F_RecordCount>0) and not F_ReadOnly)
  else
    btn_numsclose.Enabled:=false;

end;


procedure Tfrm_Departures.FormShow(Sender: TObject);
begin
  inherited;
 SetNums1562;
 Enabled_closed1562;
end;

procedure Tfrm_Departures.btn_numscloseClick(Sender: TObject);

begin
  inherited;
if Application.MessageBox(PChar('Вы уверены что хотите закрыть заявки '+#13+Nums1562_view),gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=ID_YES then
begin
 try

  if not tran_1562.InTransaction then
   tran_1562.StartTransaction;
  IBSQ_1562.SQL.Text:='update numsorders_vds set state_inner=3,state_outer=1  where id_1562 in ('+Nums1562+') and state_inner=1';
  IBSQ_1562.ExecQuery;
  tran_1562.Commit;
  Application.MessageBox(PChar(' Заявки  закрыты!!! '),gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
  SetNums1562;
  Enabled_closed1562;
 except on e:exception    do
 begin
  tran_1562.Rollback;
  Application.MessageBox(PChar('Ошибка !! Заявки не закрыты! '+e.Message),gc_strDispAVR, MB_OK+MB_ICONERROR);
 end;
 end;
end;
end;

procedure Tfrm_Departures.dset_mainAfterInsert(DataSet: TDataSet);
begin
  inherited;
Enabled_closed1562;
end;

function Tfrm_Departures.IsInCurShift( _DT: TDateTime): boolean;
begin
  result := (_DT >= F_ShiftDate + strtotime('08:00:00')) and ( _DT < F_ShiftDate+ 1 + strtotime('08:00:00'));
end;

function Tfrm_Departures.IntShift( _DT: TDateTime):integer;
var b:real;
begin
b:=_DT-strtotime(g_ShiftStartTime)-F_ShiftDate;
b:=floor(_DT-strtotime(g_ShiftStartTime)-F_ShiftDate)+1;
result:=floor(b);
end;

procedure Tfrm_Departures.SetInCurShift();
begin
 if IsInCurShift(dset_main.fieldbyname('StartDate').AsDateTime) then
 begin
  btn_edit.Enabled:=true;
  btn_Delete.Enabled:=true;
 end
 else
 begin
   btn_edit.Enabled:=false;
  btn_Delete.Enabled:=false;
 end;


end;
procedure Tfrm_Departures.btn_planEquipClick(Sender: TObject);
var _DepChargeMan: TDepPlanChangManager;
begin
  inherited;
  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
    _DepChargeMan:=TDepPlanChangManager.Create;
      try
      _DepChargeMan.OrderID := F_OrderID;
      _DepChargeMan.DepID :=  dset_main.fieldbyname('id').asinteger;
      _DepChargeMan.table:='EQUIP_PALN_DEPARTURE_vds';

      ///    проверка даті время віезда в тек смене
    //  if F_DepData.IsFieldsValueCorrect(Errmes,Field) then
      _DepChargeMan.IsReadOnly :=   F_ReadOnly ;
     { else
       _DepChargeMan.IsReadOnly := true;}
      ///
      _DepChargeMan.ShowCharge;
    finally
      _DepChargeMan.Free;
    end;
  end else
    if not   F_ReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );


end;

procedure Tfrm_Departures.btn_planworkmatClick(Sender: TObject);
var F_Manag: TDepPlanWorkManager;
   _DepID: integer;

begin
  inherited;
  _DepId:=dset_main.fieldbyname('id').AsInteger;
  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
   try
    F_Manag:=TDepPlanWorkManager.Create;
    F_Manag.typ:=2;// установка ns
    F_Manag._IDOrder:=F_orderId;
    F_Manag.IdDep:= _DepID;
    F_Manag.OnShow;
  finally
   F_Manag.Free;
  end
 end
else
 if not f_ReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );


end;

procedure Tfrm_Departures.dset_mainBeforePost(DataSet: TDataSet);
begin
  inherited;
if not dset_main.FieldByName('EndDate').IsNull then
   dset_main.FieldByName('fk_departures_OfficialsClose').AsInteger:=F_IDOfficials;
end;

end.
