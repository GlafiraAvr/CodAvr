unit DepFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGDepDModule, StdCtrls, Buttons, DB, Menus, RxLookup, DBCtrlsEh,
  Mask, ToolEdit, RXDBCtrl, DBCtrls, ComCtrls, mpTabControl, ExtCtrls;

type
  TTabType = (ttExist, ttNew);

  TEnabledDepBtns=record
    EnabledPost,
    EnabledCancel: boolean;
  end;

  TChangeEnabledDepBtnsEvent = procedure( _EnabledDepBtns: TEnabledDepBtns ) of object;
 

  Tframe_Dep = class(TFrame)
    tc_Deps: TmpTabControl;
    Label1: TLabel;
    gb_BegWork: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    dbt_DispOpen: TDBText;
    Label6: TLabel;
    de_BegDate: TDBDateEdit;
    te_BegTime: TDBDateTimeEditEh;
    gb_EndWork: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    dbt_DispClose: TDBText;
    Label7: TLabel;
    de_EndDate: TDBDateEdit;
    te_EndTime: TDBDateTimeEditEh;
    dbl_Brig: TRxDBLookupCombo;
    pm_Deps: TPopupMenu;
    mi_DelDep: TMenuItem;
    ds_Dep: TDataSource;
    ds_BrigAtt: TDataSource;
    mem_AddInfo: TDBMemo;
    Label8: TLabel;
    dbt_RecInfo: TDBText;
    ds_MessType: TDataSource;
    dbl_MessType: TRxDBLookupCombo;
    gb_PlanWork: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    de_PBegDate: TDBDateEdit;
    de_PBegTime: TDBDateTimeEditEh;
    de_PEndDate: TDBDateEdit;
    de_PEndTime: TDBDateTimeEditEh;
    Label11: TLabel;
    dbl_Equipment: TRxDBLookupCombo;
    ds_equipment: TDataSource;
    cb_PLAN: TCheckBox;
    Label12: TLabel;
    dbt_Plan: TDBText;
    gb_empting: TGroupBox;
    dbn_empting: TDBNumberEditEh;
    ds_equipment_do: TDataSource;
    gb_Diameter: TGroupBox;
    dbl_Diameter: TRxDBLookupCombo;
    ds_diameter: TDataSource;
    dbe_ReplPlan: TDBDateEdit;
    lbl_DateRegl: TLabel;
    dbl_Region_brig: TRxDBLookupCombo;
    ds_RegionID_brig: TDataSource;
    pnl_closeExcav: TPanel;
    Label13: TLabel;
    btn_Close1562: TButton;
    dbm_ClosedExcavInfo: TDBMemo;
    de_dateclose_info: TDBDateEdit;
    Label14: TLabel;
    pnl_closedCapRem: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    btn_caprem1562: TButton;
    dbm_CAPREM_CLOSEDINFO: TDBMemo;
    db_Date_CapRem: TDBDateEdit;
    Label17: TLabel;
    Label18: TLabel;
    procedure tc_DepsChange(Sender: TObject);
    procedure mi_DelDepClick(Sender: TObject);
    procedure pm_DepsPopup(Sender: TObject);
    procedure tc_DepsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dbl_BrigEnter(Sender: TObject);
    procedure dbl_BrigExit(Sender: TObject);
    procedure te_BegTimeChange(Sender: TObject);
    procedure de_EndDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure de_PlanEndDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbl_MessTypeChange(Sender: TObject);
    procedure cb_PLANClick(Sender: TObject);
    procedure de_PBegDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbn_emptingChange(Sender: TObject);
    procedure dbl_DiameterChange(Sender: TObject);
    procedure dbe_ReplPlanChange(Sender: TObject);
    procedure dbl_BrigChange(Sender: TObject);
    procedure dbl_Region_brigChange(Sender: TObject);
    procedure btn_Close1562Click(Sender: TObject);
    procedure dbm_ClosedExcavInfoChange(Sender: TObject);
    procedure btn_caprem1562Click(Sender: TObject);
    procedure dbm_CAPREM_CLOSEDINFOChange(Sender: TObject);
  private
    F_DepData: Tdm_NGDep;
    F_OnChangeEnabledDepBtns: TChangeEnabledDepBtnsEvent;
    F_ChangeRegl:boolean;
    F_Change_other:boolean;
    F_Change_Excab_info:boolean;

    F_Change_caprem:boolean;
    procedure AttachCtrlsAndEvents;
    procedure BuildEnableForDepBtns;
    procedure BuildEnableForCtrls;
    procedure SetDepTabIndex;

  private
    procedure AfterDepDsetOpenHandler(DataSet: TDataSet);
    procedure InputDepFieldChangeHandler(Sender: TField);
  public
    procedure Init( _DepData: Tdm_NGDep );
    function DepPost: boolean;
    procedure DepCancel;
    function DepDelete: boolean;
    property OnChangeEnabledDepBtns: TChangeEnabledDepBtnsEvent
      read F_OnChangeEnabledDepBtns write F_OnChangeEnabledDepBtns;
  end;

implementation

{$R *.dfm}

uses HelpFunctions,StrUtils,StringConsts;

{ Tframe_Dep }

procedure Tframe_Dep.AfterDepDsetOpenHandler(DataSet: TDataSet);
var
  i, _DepNum: integer;
  _TabCap: string;
begin
  tc_Deps.Tabs.Clear;

 // F_DepData.IsHasFirstDep := false;

  DataSet.DisableControls;
  try
    i := 2;
    DataSet.First;
    while not DataSet.Eof do
    begin
      _DepNum := DataSet.FieldByName( 'DepNumber' ).AsInteger;

      if _DepNum = 1 then
        begin
          _TabCap := 'Первичный';
//          F_DepData.IsHasFirstDep := true;
        end
      else
      begin
        _TabCap := 'N' + IntToStr(i);
        i := i + 1;
      end;

      tc_Deps.Tabs.AddObject( _TabCap, ptr( Ord( ttExist ) ) );
      DataSet.Next;
    end;

    if not F_DepData.IsReadOnly then
      tc_Deps.Tabs.AddObject( '<Новый>', ptr( Ord( ttNew ) ) );
  finally
    DataSet.EnableControls;
  end;
  //
  SetDepTabIndex;
  //
  BuildEnableForDepBtns;
  BuildEnableForCtrls;

  pnl_closeExcav.Visible:=F_depData.CanReadExcav;
  btn_Close1562.Enabled:=F_depData.CanAddExcavInfo;
  dbm_ClosedExcavInfo.ReadOnly:=not F_depData.CanAddExcavInfo;
  de_dateclose_info.ReadOnly:=not F_depData.CanAddExcavInfo;

  pnl_closedCapRem.Visible:=F_depData.CanReadCapRem;
  btn_caprem1562.Enabled:=F_DepData.CanAddCapRemInfo;
  dbm_CAPREM_CLOSEDINFO.ReadOnly:= not F_DepData.CanAddCapRemInfo;
  db_Date_Caprem.ReadOnly:= not F_DepData.CanAddCapRemInfo;
end;

procedure Tframe_Dep.AttachCtrlsAndEvents;
begin
  F_DepData.OnAfterDepDsetOpen := AfterDepDsetOpenHandler;
  F_DepData.OnInputDepFieldChange := InputDepFieldChangeHandler;
  ds_Dep.DataSet := F_DepData.dset_Dep;
  ds_BrigAtt.DataSet := F_DepData.mem_BrigAtt;
end;

procedure Tframe_Dep.BuildEnableForDepBtns;
var
  _enab: boolean;
  _EnBtns: TEnabledDepBtns;
begin
  {
  _enab := ( ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) and
             ( F_DepData.IsInputDepFieldChange ) and
             ( not F_DepData.IsReadOnly ) );
  }

  _enab := ( ( F_DepData.dset_Dep.State in [ dsInsert, dsEdit ] ) and
             ( F_DepData.IsInputDepFieldChange ) and
             ( not F_DepData.IsReadOnly ) );

  _EnBtns.EnabledPost := ( _enab and  F_DepData.IsCanEditCurrentDep );
  _EnBtns.EnabledCancel := _enab;

  if Assigned( F_OnChangeEnabledDepBtns ) then
    F_OnChangeEnabledDepBtns( _EnBtns );
end;

procedure Tframe_Dep.DepCancel;
begin
  if ds_Dep.DataSet.State in [ dsInsert, dsEdit ] then
  begin
    ds_Dep.DataSet.Cancel;
    BuildEnableForDepBtns;
    SetDepTabIndex;
    F_ChangeRegl:=false;
    F_Change_other:=false;
    F_Change_Excab_info:=false;
    F_Change_Caprem:=false;
  end;
end;

function Tframe_Dep.DepPost: boolean;
var
  _ErrMsg: string;
  _ErrMsg2:string;
  _DepField: TDepField;
  _DepClosedInfo:TDepExcavCloseField;
  dopost:boolean;
  n :integer;
begin

 n:=tc_Deps.TabIndex;
 Result := true;
 dopost:=false;
 if ds_Dep.DataSet.State in [ dsInsert, dsEdit ]
  then
  begin

    if F_DepData.IsFieldsValueCorrect( _ErrMsg, _DepField ) then
     dopost:=true
    else
     if (not F_Change_other) then
     begin
      if  ( F_ChangeRegl)  then
      if F_DepData.IsFieldsdatereglCorrect(_ErrMsg)  then
       dopost:=true
      else
      if F_DepData.dset_Dep.FieldByName('DepNumber').AsInteger>1 then
          _DepField:=dfDiam
       else
          _DepField:=dfDateRegl;
     end;
    if (ds_Dep.DataSet.State in [dsEdit])and(not dopost) then
    begin
     if (F_Change_Excab_info)  then
     begin
      if  F_DepData.ExcavFieldCorrect(_DepClosedInfo) then
      begin
       if  F_DepData.PostAddExcav(_ErrMsg) then
       begin
        BuildEnableForDepBtns;
        tc_Deps.TabIndex:=n;
        F_ChangeRegl:=false;
        F_Change_other:=false;
        F_Change_Excab_info:=false;
       end;
      end
    else
     begin
      case  _DepClosedInfo of
        dfInfo:  dbm_ClosedExcavInfo.SetFocus;
        dfClosedDate:  de_dateclose_info.SetFocus;
      end;
      exit;
     end;
    end;
   if (f_Change_Caprem) then
   if  F_DepData.ExcavFieldCorrect(_DepClosedInfo,'CAPREP_CLOSEDINFO','CAPREM_DATE','в кап ремонт') then
    begin
     if  F_DepData.PostAddExcav(_ErrMsg,'CAPREP_CLOSEDINFO', 'CAPREM_DATE',  ' Сохранена только  инфлрмация  в кап ремонт') then
     begin
      BuildEnableForDepBtns;
      tc_Deps.TabIndex:=n;
      F_ChangeRegl:=false;
      F_Change_other:=false;
       F_Change_caprem:=false;
     end;
    end
    else
    case  _DepClosedInfo of
      dfInfo:  dbm_CAPREM_CLOSEDINFO.SetFocus;
      dfClosedDate:  db_Date_CapRem.SetFocus;
    end;
     exit;
   end;


   if dopost then
    begin
      ds_Dep.DataSet.Post;
      // вот тут вставим добавление в equipplanned; by Vadim 24_04_2009
      F_DepData.AddPlanTOEquipplanned;
      BuildEnableForDepBtns;
      F_ChangeRegl:=false;
      F_Change_other:=false;
      F_Change_Excab_info:=false;
      F_Change_caprem := false;
    end else
    begin
      Result := false;
      //

      case _DepField of
        dfStartDate: de_BegDate.SetFocus;
        dfEndDate: de_EndDate.SetFocus;
        dfBrig: dbl_Brig.SetFocus;
        dfPlanEndDate: de_PEndDate.SetFocus;
        dfDateRegl:dbe_ReplPlan.SetFocus;
        dfDiam:dbl_Diameter.SetFocus;
        dfdate_closed_info: de_dateclose_info.SetFocus;
      end;
    end;

  end;
end;

procedure Tframe_Dep.InputDepFieldChangeHandler(Sender: TField);
begin
  BuildEnableForDepBtns;
end;

procedure Tframe_Dep.SetDepTabIndex;
begin
  if ds_Dep.DataSet.RecordCount > 0 then
    tc_Deps.TabIndex := ds_Dep.DataSet.RecNo - 1
  else
    tc_Deps.TabIndex := 0;
end;

procedure Tframe_Dep.tc_DepsChange(Sender: TObject);
begin
  if integer(tc_Deps.Tabs.Objects[ tc_Deps.TabIndex ]) = Ord( ttNew ) then
    ds_Dep.DataSet.Append
  else
    ds_Dep.DataSet.RecNo := tc_Deps.TabIndex + 1;

  BuildEnableForDepBtns;
  BuildEnableForCtrls;

  tc_Deps.SetFocus;
end;

procedure Tframe_Dep.mi_DelDepClick(Sender: TObject);
begin
  DepDelete;
end;

procedure Tframe_Dep.pm_DepsPopup(Sender: TObject);
begin
  mi_DelDep.Enabled :=  ( ( integer(tc_Deps.Tabs.Objects[ tc_Deps.TabIndex ]) <> Ord( ttNew ) ) and
                          ( not F_DepData.IsReadOnly ) and
                          ( F_DepData.IsCanDelCurrentDep ) );
end;

procedure Tframe_Dep.tc_DepsChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  _s: string;
begin
  if ( ds_Dep.DataSet.State <> dsBrowse ) then
    if F_DepData.IsInputDepFieldChange then
    begin
      AllowChange := false;
      _s := 'Сохраните или отмените изменения для вкладки "' + tc_Deps.Tabs.Strings[ tc_Deps.TabIndex ] + '"';
      Application.MessageBox( PChar( _s ), 'Выезды', MB_OK + MB_ICONWARNING );
    end else DepCancel;
end;

procedure Tframe_Dep.Init( _DepData: Tdm_NGDep );
begin
  F_DepData := _DepData;
  AttachCtrlsAndEvents;
  F_ChangeRegl:=false;
  F_Change_other:=false;
  F_Change_Excab_info:=false;
   F_Change_caprem:=false;
end;

procedure Tframe_Dep.dbl_BrigEnter(Sender: TObject);
begin
  F_DepData.mem_BrigAtt.Filtered := true;
end;

procedure Tframe_Dep.dbl_BrigExit(Sender: TObject);
begin
  F_DepData.mem_BrigAtt.Filtered := false;
end;

procedure Tframe_Dep.te_BegTimeChange(Sender: TObject);
begin
  if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
  begin
    F_DepData.SetIsInputDepFieldChange(true);
   F_Change_other:=true;
  end
end;

procedure Tframe_Dep.BuildEnableForCtrls;
var
  _en: boolean;
begin
  _en := ( ( not F_DepData.IsReadOnly ) and F_DepData.IsCanEditCurrentDep );

  de_BegDate.Enabled := _en;
  te_BegTime.Enabled := _en;
  de_EndDate.Enabled := _en;
  te_EndTime.Enabled := _en;

  dbl_Brig.Enabled := _en;
  dbl_MessType.Enabled:=_en;
  dbn_empting.Enabled:=_en;

  //mem_AddInfo.Enabled := _en;
  mem_AddInfo.ReadOnly := not _en;
  de_PBegDate.Enabled:=_en;
  de_PBegTime.Enabled:=_en;
  de_PEndDate.Enabled:=_en;
  de_PEndTime.Enabled:=_en;
  dbl_Equipment.Enabled:=_en;
  dbl_Diameter.Enabled:=_en;
  dbe_ReplPlan.Enabled:=_en;

  dbe_ReplPlan.Visible:=(tc_Deps.TabIndex=0);
  lbl_DateRegl.Visible:=(tc_Deps.TabIndex=0);

 {возможность корректировать заявки с расклпками закрытие}
 dbm_ClosedExcavInfo.ReadOnly:=not _en;

 {возможность корректировать заявки кап ремонт закрытие}
 dbm_CAPREM_CLOSEDINFO.ReadOnly:=not _en;
end;


procedure Tframe_Dep.de_EndDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( Key = VK_CONTROL ) or
    ( ( Key = VK_RETURN ) and ( ssCtrl in Shift ) ) then
    ds_Dep.DataSet.FieldByName( 'EndDate' ).AsDateTime := CrazyNow;
end;

procedure Tframe_Dep.de_PlanEndDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( Key = VK_CONTROL ) or
    ( ( Key = VK_RETURN ) and ( ssCtrl in Shift ) ) then
    ds_Dep.DataSet.FieldByName( 'PlanEndDate' ).AsDateTime := CrazyNow;
end;


function Tframe_Dep.DepDelete: boolean;
begin
  Result := false;

  if ( integer(tc_Deps.Tabs.Objects[ tc_Deps.TabIndex ]) <> Ord( ttNew ) ) and
     ( F_DepData.IsCanDelCurrentDep ) then
    if Application.MessageBox( 'Вы уверены, что хотите удалить выезд?',
      'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES then
    begin
      ds_Dep.DataSet.Delete;
      Result := true;
    end;
end;

procedure Tframe_Dep.dbl_MessTypeChange(Sender: TObject);
var
    _s : string;
begin
 //
 _s :=  mem_AddInfo.DataSource.DataSet.FieldByName('ADDITIONALINFO').AsString;
 _s:= _s + dbl_MessType.Text;
 if mem_AddInfo.DataSource.DataSet.State <> dsEdit then  mem_AddInfo.DataSource.DataSet.Edit;
 mem_AddInfo.DataSource.DataSet.FieldByName('ADDITIONALINFO').AsString := _s;
end;

procedure Tframe_Dep.cb_PLANClick(Sender: TObject);
var c,i:integer;
begin
  //   чё-то не работает :( ,ну и хрен с ним ... всё равно не понадобилось :)
  c := gb_PlanWork.DockClientCount;
  for i := 0 to c-1 do
  begin
   if not gb_PlanWork.DockClients[i].ClassNameIs('TLabel') then
     gb_PlanWork.DockClients[i].Enabled := cb_PLAN.Checked;

  end;

end;

procedure Tframe_Dep.de_PBegDateKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{
 if (key=vk_f5)
      and (de_BegDate.DataSource.DataSet.State in [dsInsert, dsEdit])
      and (de_BegDate.DataSource.DataSet.FieldByName('PLANSTARTDATE').IsNull) then
     de_BegDate.DataSource.DataSet.FieldByName('PLANSTARTDATE').AsDateTime := Now;
     }
end;

procedure Tframe_Dep.dbn_emptingChange(Sender: TObject);
begin
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
  begin
    F_DepData.SetIsInputDepFieldChange(true);
  F_Change_other:=true;
 end
end;

procedure Tframe_Dep.dbl_DiameterChange(Sender: TObject);
var p,p1:integer;
str:string;
begin

str:=mem_AddInfo.Text;
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
  begin
    F_DepData.SetIsInputDepFieldChange(true);
      F_ChangeRegl:=true;
  end;
{p:=pos ('d=' , str);
p1:=posex('мм',str,p);

if p1>0 then begin
 while str[p1-1]<>'='  do
  begin
   delete(str,p1-1,1);
   p1:=p1-1;
  end ;
  delete(str,p1,2);
end;

if p>0 then
begin
 insert(trim(dbl_Diameter.Text)+'мм', str,p+2);
 mem_AddInfo.DataSource.DataSet.FieldByName(mem_AddInfo.DataField).AsString:=str;
 end
}

end;

procedure Tframe_Dep.dbe_ReplPlanChange(Sender: TObject);
begin
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
   begin
    F_DepData.SetIsInputDepFieldChange(true);
   F_ChangeRegl:=true;
  end
end;

procedure Tframe_Dep.dbl_BrigChange(Sender: TObject);
begin
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
 begin
    F_DepData.SetIsInputDepFieldChange(true);
   F_Change_other:=true;
 end
end;

procedure Tframe_Dep.dbl_Region_brigChange(Sender: TObject);
begin


F_DepData.REgionBrig:=ds_RegionID_brig.DataSet.FieldByName('id').AsInteger;

if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
 begin
    F_DepData.SetIsInputDepFieldChange(true);
    F_Change_other:=true;
 end
end;

procedure Tframe_Dep.btn_Close1562Click(Sender: TObject);
var mes:string;
corField,cortime:boolean;
begin

if F_DepData.Closed1562(corField,cortime) then
begin
 Application.MessageBox('Заявки 1562 с раскопками закрыты !',gc_strDispAVR,MB_OK);
 btn_Close1562.Enabled:=false;

end
else
begin
 if   corfield then
  dbm_ClosedExcavInfo.SetFocus;
 if  cortime then
  de_dateclose_info.SetFocus;
end;


end;

procedure Tframe_Dep.dbm_ClosedExcavInfoChange(Sender: TObject);
begin
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
  begin
    F_DepData.SetIsInputDepFieldChange(true);
      F_Change_Excab_info:=true;
  end;
end;

procedure Tframe_Dep.btn_caprem1562Click(Sender: TObject);
var mes:string;
corField,cortime:boolean;
begin

if F_DepData.Closed1562(corField,cortime,cap_rem,'CAPREP_CLOSEDINFO','CAPREM_DATE') then
begin
 Application.MessageBox('Заявки 1562  в кап ремонт закрыты !',gc_strDispAVR,MB_OK);
 
 btn_caprem1562.Enabled:=F_DepData.CanAddCapRemInfo;
end
else
begin
 if   corfield then
  dbm_CAPREM_CLOSEDINFO.SetFocus;
 if  cortime then
  db_Date_CapRem.SetFocus;
 Application.MessageBox('Заявки 1562  в кап ремонт  не закрыты !',gc_strDispAVR,MB_OK); 
 end;
end;

procedure Tframe_Dep.dbm_CAPREM_CLOSEDINFOChange(Sender: TObject);
begin
if Visible and ( ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
  begin
    F_DepData.SetIsInputDepFieldChange(true);
      F_Change_caprem:=true;
  end;


end;

end.
