unit DepREGForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DepFrame, NGDepDModule, StdCtrls, Buttons, ComCtrls,
  Mask, DBCtrlsEh,DB,AdresDepNS, RxLookup, Spin, DBCtrls;

type
  Tfrm_DepREG = class(TForm)
    frame_Dep: Tframe_Dep;
    Panel1: TPanel;
    btn_DepCharge: TBitBtn;
    btn_DepEquips: TBitBtn;
    btn_DepWorkers: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Exit: TBitBtn;
    StatusBar: TStatusBar;
    Plan_Equip: TBitBtn;
    PlanWorkMat: TBitBtn;
    Gb_Plan: TGroupBox;
    Label1: TLabel;
    dbn_Brigada: TDBNumberEditEh;
    btn_Adress: TBitBtn;
    Pnl_year: TPanel;
    spe_year: TSpinEdit;
    Label2: TLabel;
    dbl_region: TRxDBLookupCombo;
    DataSource1: TDataSource;
    ds_Region: TDataSource;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_DepChargeClick(Sender: TObject);
    procedure btn_DepEquipsClick(Sender: TObject);
    procedure btn_DepWorkersClick(Sender: TObject);
    procedure Plan_EquipClick(Sender: TObject);
    procedure PlanWorkMatClick(Sender: TObject);
    procedure dbn_BrigadaChange(Sender: TObject);
    procedure btn_AdressClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spe_yearChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frame_Depbtn_Close1562Click(Sender: TObject);
    procedure frame_Depbtn_caprem1562Click(Sender: TObject);
  private
    F_DepData: Tdm_NGDep;
    frm_Adres: Tfrm_AdresDep;
    procedure OnDepShowMsgHandler( _Msg: string );
    procedure OnChangeEnabledDepBtnsHandler( _EnabledDepBtns: TEnabledDepBtns );
  public
    constructor Create( AOwner: TComponent; _DepData: Tdm_NGDep );
  end;


implementation

{$R *.dfm}

uses WorkManager, DepChargeManager, DepWorkersForm, DepPlanChangManager,DepPlanWorkManager
,HelpFunctions,Closed1562Manager;


{ Tfrm_DepREG }

constructor Tfrm_DepREG.Create(AOwner: TComponent; _DepData: Tdm_NGDep);
begin
  inherited Create( nil );
  F_DepData := _DepData;
  F_DepData.OnShowMsg := OnDepShowMsgHandler;

  frame_Dep.Init( _DepData );
  frame_Dep.OnChangeEnabledDepBtns := OnChangeEnabledDepBtnsHandler;
  frm_Adres:=Tfrm_AdresDep.Create(nil);
  frm_Adres.ds_main.DataSet:=F_DepData.dset_Dep;
  frm_Adres.ds_street.DataSet:=F_DepData.mem_streets;
  frm_Adres.ds_street_2.DataSet:=F_DepData.mem_street_2;
  frm_adres.ds_locality.DataSet:=F_DepData.dset_Locality;
//  frm_Adres.ds_housetype.DataSet:=F_DepData.mem_Housetype;
end;

procedure Tfrm_DepREG.OnChangeEnabledDepBtnsHandler(
  _EnabledDepBtns: TEnabledDepBtns);
begin
  btn_Post.Enabled := _EnabledDepBtns.EnabledPost;
  btn_Cancel.Enabled := _EnabledDepBtns.EnabledCancel;
end;

procedure Tfrm_DepREG.OnDepShowMsgHandler(_Msg: string);
begin
  StatusBar.SimpleText := _Msg;
end;

procedure Tfrm_DepREG.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DepREG.btn_PostClick(Sender: TObject);
begin
if pnl_year.Visible then
 if GetYear(frame_Dep.de_BegDate.Date)<>spe_year.Value
  then
  begin
   OnDepShowMsgHandler('дата не сответствует выбранному году!!');
   exit;
  end ;
frame_Dep.DepPost;
end;

procedure Tfrm_DepREG.btn_CancelClick(Sender: TObject);
begin
  frame_Dep.DepCancel;
end;

procedure Tfrm_DepREG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if btn_Post.Enabled then
  begin
    Action := caNone;
    Application.MessageBox( 'Сохраните или отмените изменения!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end;
end;

procedure Tfrm_DepREG.btn_DepChargeClick(Sender: TObject);
var
  _WrkMgr: TWorkManager;
  _DepID: integer;
begin
  _DepID := F_DepData.CurrentDepID;

  if _DepID > 0 then
  begin
    _WrkMgr := TWorkManager.Create;
    try
      _WrkMgr.OrderID := F_DepData.OrderID;
      _WrkMgr.DepID := _DepID;
      _WrkMgr.WorkDate := F_DepData.CurrentStartDate;
      _WrkMgr.IsReadOnly := F_DepData.IsReadOnly;
      _WrkMgr.Execute;
        if   F_DepData.IsReadOnly then
         dbn_Brigada.Enabled:=false
         else   dbn_Brigada.Enabled:=true;
    finally
      _WrkMgr.Free;
    end;
  end else
    if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );
end;

procedure Tfrm_DepREG.btn_DepEquipsClick(Sender: TObject);
var
  _DepChargeMan: TDepChargeManager;
  _DepID: integer;
begin
  _DepID := F_DepData.CurrentDepID;

  if _DepID > 0 then
  begin
    _DepChargeMan := TDepChargeManager.Create;
    try
      _DepChargeMan.OrderID := F_DepData.OrderID;
      _DepChargeMan.DepID := _DepID;
      _DepChargeMan.IsReadOnly := F_DepData.IsReadOnly;
      _DepChargeMan.ShowCharge;
    finally
      _DepChargeMan.Free;
    end;
  end else
    if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );
end;

procedure Tfrm_DepREG.btn_DepWorkersClick(Sender: TObject);
var
  _DepID: integer;
  _DWF: Tfrm_DepWorkers;
  mr:integer;
begin
  _DepID := F_DepData.CurrentDepID;

  if _DepID > 0 then
  begin
    _DWF := Tfrm_DepWorkers.Create(
      nil,
      F_DepData.OrderID,
      _DepID,
      F_DepData.CurrentBrigID,
      F_DepData.IsReadOnly,false,F_DepData.dset_Dep.fieldbyname('fk_departures_region_brig').AsInteger); //дла ВДС, № района
     //  _DWF.frame.REgion_ID:=F_DepData.REgionID;
     _DWF.frame.REgion_ID:=F_DepData.dset_Dep.fieldbyname('fk_departures_region_brig').AsInteger;

    try
     _DWF.frame.btn_AddTeam.Visible:=false;
     mr:=_DWF.ShowModal;
     if mr=mrOk then
     begin
       dbn_Brigada.Text:=IntToStr(_DWF.frame.PeopleCount);
       frame_Dep.DepPost;
      end;

    finally
      _DWF.Free;
    end;
  end else
    if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );

end;

procedure Tfrm_DepREG.Plan_EquipClick(Sender: TObject);
var
  _DepChargeMan: TDepPlanChangManager;
  _DepID: integer;
  Errmes:string;
  Field:TDepField;
begin
   _DepID := F_DepData.CurrentDepID;

  if _DepID > 0 then
  begin
    _DepChargeMan := TDepPlanChangManager.Create;
    try
      _DepChargeMan.OrderID := F_DepData.OrderID;
      _DepChargeMan.DepID := _DepID;
      _DepChargeMan.table:='EQUIP_PALN_DEPARTURE';

      ///    проверка даті время віезда в тек смене
   //   if F_DepData.IsFieldsValueCorrect(Errmes,Field) then
      _DepChargeMan.IsReadOnly := F_DepData.IsReadOnly ;
     { else
       _DepChargeMan.IsReadOnly := true;}
      ///
      _DepChargeMan.ShowCharge;
    finally
      _DepChargeMan.Free;
    end;
  end else
    if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );



end;

procedure Tfrm_DepREG.PlanWorkMatClick(Sender: TObject);
var F_Manag: TDepPlanWorkManager;
   _DepID: integer;
begin

 _DepID := F_DepData.CurrentDepID;
 if  _DepID>=0 then
 try
  F_Manag:=TDepPlanWorkManager.Create;
  F_Manag.typ:=1;// установка ns
  F_Manag._IDOrder:=F_DepData.OrderID;
  F_Manag.IdDep:= _DepID;
  F_Manag.frm_Dep.IsReadOnly:=F_DepData.IsReadOnly;
  F_Manag.OnShow;
 finally
  F_Manag.Free;
end
else
 if not F_DepData.IsReadOnly then
      Application.MessageBox( 'Для ввода данной информации необходимо зарегистрировать выезд',
        'Выезды', MB_OK + MB_ICONWARNING );
end;

procedure Tfrm_DepREG.dbn_BrigadaChange(Sender: TObject);
begin
if Visible and (Frame_Dep.ds_Dep.DataSet.State in [ dsInsert, dsEdit ] ) then
    F_DepData.SetIsInputDepFieldChange(true);
end;

procedure Tfrm_DepREG.btn_AdressClick(Sender: TObject);
var s:string;
begin

 s:=F_DepData.dset_Dep.FieldByName('STARTDATE').AsString;
  frm_Adres.IsREadOnly:=F_DepData.IsReadOnly;

 if  not (Frame_Dep.ds_Dep.DataSet.State in [dsEdit,dsInsert]) then Frame_Dep.ds_Dep.DataSet.Edit;
 if frm_Adres.ShowModal =mrOk then
  if (Frame_Dep.ds_Dep.State in [dsEdit]) and
  ( not  btn_Post.Enabled) then
  Frame_Dep.DepPost;
end;

procedure Tfrm_DepREG.FormDestroy(Sender: TObject);
begin
frm_Adres.Free;
end;

procedure Tfrm_DepREG.spe_yearChange(Sender: TObject);
begin
if F_DepData.WithoutOrder then
F_DepData.ChangeYear(spe_Year.Value);
end;

procedure Tfrm_DepREG.FormShow(Sender: TObject);
begin
   spe_year.MaxValue:=GetYear(Now());
   spe_year.MinValue:=spe_year.MaxValue-5;
   dbn_Brigada.Enabled:= not F_DepData.IsReadOnly;

end;

procedure Tfrm_DepREG.frame_Depbtn_Close1562Click(Sender: TObject);
begin
  frame_Dep.btn_Close1562Click(Sender);

end;

procedure Tfrm_DepREG.frame_Depbtn_caprem1562Click(Sender: TObject);
begin
  frame_Dep.btn_caprem1562Click(Sender);

end;

end.
