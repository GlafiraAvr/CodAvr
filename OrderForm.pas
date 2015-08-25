unit OrderForm;
{$define Cansel}
{$define closeoch}
{$define sent_tel_toOch}

{
  Такой подход для организации формы ввода не обравдал себя.
  Данную форму нужно будет обязательно полностью переделать.
  Что в общем я и начал делать. Модуль с новой формой называется
  OrderNGForm. А пишу я это в связи с слабостью своей памяти относительно
  благих намерений и в качестве напоминания.
}

{
 модуль OrderNGForm используется- предок для формы  вмодуле Order1562Form
}
interface

{$I !TEST_DEFINE.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin,
  DBCtrls,DB, Mask, Menus, Spin, RXSpin,
  ToolEdit, RxLookup, RxDBComb, ImgList, IBCustomDataSet, DModule,
  IBDatabase, IBSQL, Math, SecurityBaseForm, AomComTypesUnit, OrderDModule,
  NGDepManager, NumSOBuffDModule, NumSOForm, NaledUnit, {NumSONGUnit,}CanselForm,
  workSql,NewDisconnections2,Image_main;

const
  ID_MAGISTRAL = 1;
  ID_VVOD = 2;
  ID_KOLODEC = 3;
  ID_KOLONKA = 4;
  ID_ZAGLUSH_VVOD = 5;
  ID_PEREKLAD_SET = 24;
  ID_PROFWORKS = 8;  //ПРОФРАБОТЫ
  ID_VDS = 17; //Повреждение ВДС
  ID_LUK = 13;
  ID_RABABON = 7;   //РАБ.АБОНЕНТА
  ID_CL_KOLONKA = 14;
  ID_CL_KOLODEC = 15;
  ID_SH_KOLODEC = 6;

  ID_NE_RASKOPANO = 4;

  ID_CHUGUN = 2;

  ID_DIAM_50 = 1;

  ID_PROCHIE = 5;
  ID_WASH_AFTER_CHANGE = 18;// Промывка после замены
  ID_WASH_DEAD_END = 16; // Промывка тупиков

  OBLIGATORY_CTRLS_COLOR: TColor=clYellow;

  VOC_DSET_COUNT = 0;
  ID_PODTOPTEPLSET=31; //теперь скрытые течи

  ID_Clor_KOLON=14; //ЗАХЛОР. КОЛОНКУ
  ID_CLOR_KOLOD=15;// ЗАХЛОР. КОЛОДЕЦ
  ID_DEM_KOL=20;      //ДЕМОНТАЖ КОЛОНКИ
  ID_CHANG_PG=22;           //ЗАМЕНА ПГ

type
  TOrderMode = (omInput, omEdit);

  TFixAction = (faInsert, faUpdate, faDelete, faUpdateToNull);

  TSaveAction = (saSave, saClose);

  TOrderType = (otNew, otOpen, otClose, otCloseInCurShift);

  TProcessState= (psInit, psWork);

  TOrderFieldsStack=record
    ID_FirstDepBrig: integer;
  end;

  Tfrm_Order = class(Tfrm_SecurityBase)
    Label27: TLabel;
    mem_AdditionalInfo: TMemo;
    Label11: TLabel;
    btn_NewOrder: TBitBtn;
    btn_SaveOrderData: TBitBtn;
    btn_CloseOrder: TBitBtn;
    ds_tubediameter: TDataSource;
    ds_tubematerial: TDataSource;
    ds_contorlOrgs: TDataSource;
    ds_damageplace: TDataSource;
    ds_damagelocality: TDataSource;
    ds_messagetype: TDataSource;
    ds_street2: TDataSource;
    ds_housetype: TDataSource;
    ds_street: TDataSource;
    ds_regions: TDataSource;
    ds_officialopen: TDataSource;
    ds_officialclose: TDataSource;
    GroupBox2: TGroupBox;
    btn_WhatDone: TBitBtn;
    btn_Disconnected: TBitBtn;
    btn_Equipment: TBitBtn;
    btn_Bolts: TBitBtn;
    gb_Bottom: TGroupBox;
    dbl_TubeDiameter: TRxDBLookupCombo;
    dbl_TubeMaterial: TRxDBLookupCombo;
    dbl_LastOfficial: TRxDBLookupCombo;
    btn_Exit: TBitBtn;
    chk_WithoutEquipment: TCheckBox;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    dbl_DamageType: TRxDBLookupCombo;
    dp_End: TDateEdit;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    ds_soil: TDataSource;
    ds_damagetype: TDataSource;
    dbl_Soil: TRxDBLookupCombo;
    gb_Top: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label26: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ed_Abonent: TEdit;
    cb_IsPayed: TComboBox;
    sp_FlowSpeed: TRxSpinEdit;
    dp_Start: TDateEdit;
    dbl_Damageplace: TRxDBLookupCombo;
    dbl_ControlOrgs: TRxDBLookupCombo;
    dbl_DamageLocality: TRxDBLookupCombo;
    dbl_MessageType: TRxDBLookupCombo;
    dbl_Regions: TRxDBLookupCombo;
    dbl_FirstOfficial: TRxDBLookupCombo;
    gb_Adres: TGroupBox;
    Label2: TLabel;
    Label20: TLabel;
    lbl_Street2: TLabel;
    lbl_Housenum: TLabel;
    dbl_Street2: TRxDBLookupCombo;
    dbl_Street: TRxDBLookupCombo;
    ed_Housenum: TEdit;
    ed_AddAdres: TEdit;
    btn_Excavations: TButton;
    Tr_Voc: TIBTransaction;
    sql_Order: TIBSQL;
    dbl_HouseTypes: TRxDBLookupCombo;
    dset_TopOrderFields: TIBDataSet;
    dset_BottomOrderFields: TIBDataSet;
    Tr_ModifyData: TIBTransaction;
    Tr_SelectData: TIBTransaction;
    sb_ProcessStaus: TStatusBar;
    pnl_HoodCount: TPanel;
    cb_HoodCount: TComboBox;
    Label10: TLabel;
    ed_LastExcWorkType: TEdit;
    Bevel2: TBevel;
    me_Start: TMaskEdit;
    me_End: TMaskEdit;
    lbl_Closure: TLabel;
    Label30: TLabel;
    lbl_OrderNum: TLabel;
    btn_RestoreOpenState: TBitBtn;
    btn_Print: TBitBtn;
    pnl_LeakCalc: TPanel;
    Label1: TLabel;
    Label31: TLabel;
    sp_Pressure: TRxSpinEdit;
    Label18: TLabel;
    sp_Square: TRxSpinEdit;
    pnl_LocationDepth: TPanel;
    Label16: TLabel;
    sp_LocationDepthMirror: TRxSpinEdit;
    sp_LocationDepth: TRxSpinEdit;
    btn_AvrOnMap: TBitBtn;
    pnl_AomInfo: TPanel;
    Label7: TLabel;
    lbl_AomInfo: TLabel;
    pm_Print: TPopupMenu;
    mi_PrintOrder: TMenuItem;
    mi_PrintAom: TMenuItem;
    btn_Deps: TBitBtn;
    btn_062: TBitBtn;
    sb_DateComing: TRxSpinButton;
    bt_Naled: TButton;
    dset_tmp: TIBDataSet;
    cb_Pjatihatky: TCheckBox;
    Label3: TLabel;
    dbl_DamageLocality_2: TRxDBLookupCombo;
    Label13: TLabel;
    ds_DamageLocality_2: TDataSource;
    lbl_withoutorder: TLabel;
    btn_flooding: TBitBtn;
    btn_images: TButton;
    pnl_leak2: TPanel;
    spewidthLot: TRxSpinEdit;
    speheightThread: TRxSpinEdit;
    speSpeedQ: TRxSpinEdit;
    Label17: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_CloseOrderClick(Sender: TObject);
    procedure TopCtrlChange(Sender: TObject);
    procedure BottomCtrlChange(Sender: TObject);
    procedure EntryEnter(Sender: TObject);
    procedure EntryExit(Sender: TObject);
    procedure btn_NewOrderClick(Sender: TObject);
    procedure btn_ExcavationsClick(Sender: TObject);
    procedure chk_WithoutEquipmentClick(Sender: TObject);
    procedure dbl_HouseTypesChange(Sender: TObject);
    procedure btn_SaveOrderDataClick(Sender: TObject);
    procedure btn_BoltsClick(Sender: TObject);
    procedure btn_WhatDoneClick(Sender: TObject);
    procedure btn_DisconnectedClick(Sender: TObject);
    procedure btn_EquipmentClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_RestoreOpenStateClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure sp_LocationDepthMirrorChange(Sender: TObject);
    procedure VocFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btn_AvrOnMapClick(Sender: TObject);
    procedure mi_PrintOrderClick(Sender: TObject);
    procedure mi_PrintAomClick(Sender: TObject);
    procedure btn_DepsClick(Sender: TObject);
    procedure btn_062Click(Sender: TObject);
    procedure sb_DateComingTopClick(Sender: TObject);
    procedure sb_DateComingBottomClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bt_NaledClick(Sender: TObject);
    procedure btn_floodingClick(Sender: TObject);
    procedure btn_imagesClick(Sender: TObject);
  protected
    class function GetGUID: string; override;
  private
    F_OrderID: integer;
    F_LastExcWorkTypeID: integer;
    F_ShiftNumber: integer;
    F_ShiftDate: TDate;
    F_OrderType: TOrderType;
    F_IsTopCtrlChange: boolean;
    F_IsBottomCtrlChange: boolean;
    F_IsCtrlChange: boolean;
    F_SaveAction: TSaveAction;
    F_OrderMode: TOrderMode;
    F_ProcessState: TProcessState;
    F_DefaultAddInfoForFirstDep: string;
    F_Disconnections: string;
    F_ClosedBoltsCount: integer;
    F_DisconnectedCount: integer;
    F_IsReadOnly: boolean;
    F_IsNeedShowOrderNum: boolean; //Нужно ли показывать номер сохраненного наряда
//    F_VocDsetArr: array [1..VOC_DSET_COUNT] of TIBDataSet;
    F_OrderFieldsStack: TOrderFieldsStack;
    F_AomTypeOfAvar: TAomTypeOfAvar; //Для аврий на карте
    F_OpenDep3Count: integer;
    F_Order: Tdm_Order;
    F_DepMgr: TNGDepManager;
    F_NumSOBuff: Tdm_NumSOBuff;
    F_NUM1562:integer; //это должно передавться если форма наряда создается из Order1562 если модуль запускается из Order1562 09.12.2011
    F_Cansel:boolean;//true- если наряд закрыт отказом
    frm_cansel:Tfrm_cansel1562;   // форма для отказа
    procedure LoadTopFieldsValue; //Заполняет верхние поля формы
    procedure LoadBottomFieldsValue;  //Заполняет нижние поля формы
    procedure InitOrder;  //Инициализирует наряд
    procedure InitVocDsetArr;
    function SaveOrder: boolean;
    function CloseOrder: boolean;
    function check_asf: boolean;
    function RestoreOpenState: boolean;
    procedure OpenVocDataset;  //Открываем наборы данных справочников
    function GetMaxOrderID(Transac: TIBTransaction; LastOrderID: integer): integer;  //Возвращает максимальный ID в таблице Order
    function GetLastOrderID(Transac: TIBTransaction): integer;
    procedure EnableTopCtrls(value: boolean);
    procedure EnableBottomCtrls(value: boolean);
    procedure EnableAllCtrls( value: boolean );
    procedure ResetTopCtrls;   //Сброс полей верхней части формы
    procedure ResetBottomCtrls;   //Сброс полей нижней части формы
    function IsTopDateCorrect: boolean;  //Проверяет правильность дат верхней части формы
    function IsBottomDateCorrect: boolean; //Проверяет правильность дат нижней части формы
    function IsTopDataFieldsCorrect: boolean; //Проверяет правильность заполнения полей верхней части формы
    function IsBottomDataFieldsCorrect: boolean;  //Проверяет правильность заполнения полей нижней части формы
    procedure ChangeHouseType;
    procedure ChangeEquipmentActivity;
    procedure ChangeBoltsActivity;
    procedure ChangeDmgPlaceToProfWork;
    procedure ChangeHoodCountVisible;
    procedure ChangeDefaultAddInfoForFirstDep;
    function GetEquipWorkCount: integer;
    function GetNotConnectedCount: integer;
    procedure SetLastExcWorkType;
    procedure SetShiftNumberAndDate;
    procedure SetProcessStatus(const value: string);
    procedure SetIsTopCtrlChange(value: boolean);
    procedure SetIsBottomCtrlChange(value: boolean);
    procedure SetClosedBoltsCount;
    procedure SetDisconnectedCount;
    procedure SetOrderType;
    procedure SetSaveAction(value: TSaveAction);
    function GetPossibleOrderNumber: integer;
    function TopOrderFieldsQuery(FixAction: TFixAction): string;
    function BottomOrderFieldsQuery(FixAction: TFixAction): string;
    procedure CheckAdres; //Проверяет был ли уже зарегистрирован наряд с таким адресом
    procedure CheckFlowSpeed; //Проверяет значение FlowSpeed (не должен превышать 999)
    procedure VisibleLeakCalc(Value: boolean);
    procedure ShowDeletedRowInVoc(value: boolean);
    function Save: boolean;
    function GetDefaultEquipIDForExcavation: integer;
    procedure PrepareForAom;
    procedure PrepareForDistrict;
    procedure PrintOrder;
    procedure PrintAom;
    procedure ResetForm;
    procedure SaveNumSOBuff;
    procedure SetFilterRegions;


    procedure SetDamagePlace_Filter;
    procedure SetDepartureCount();
  private
    F_DeparturesCount:integer;
    F_From1562:boolean;
    F_sqw_asf_works:real; //17.04.2014 площадь асфальта в работах
    F_sqasf_exc:real; //17.04.2014 площадь асфальта в раскопках
    procedure OnChangeTypeOfAvar(TypeOfAvarItemRec: TTypeOfAvarItemRec);
    function F_is_closed :boolean;

    function  check_works:boolean; //12.06.2013 проверяет если есть раскрпки на зоне асфальра без площади асфольтировки
  private
    F_isClosedWithoutExcav:boolean;
    function is_canClosewithoutexcav:boolean;
    function GetListNumsordersForExcav:string;//получаем список заявок для раскопок
    function   PostKap(listNumber:string):boolean; //устанавливаем статус кап ремонта
  public
    constructor Create(AOwner: TComponent; const OrderID: integer); overload;
    constructor Create(AOwner: TComponent); overload;
    property IsCtrlChange: boolean read F_IsCtrlChange;
    property AomTypeOfAvar: TAomTypeOfAvar read F_AomTypeOfAvar;
    property OrderMode: TOrderMode read F_OrderMode write F_OrderMode;
    property OrderID: integer read F_OrderID;
    property NUM1562:integer write F_NUM1562;

    property Is_closed:boolean read F_is_closed ; //23.01.2012  glasha
    property From1562:boolean read F_From1562 write F_From1562;
  end;



implementation

uses WarningForm, GlobalData,  DisconnectionsForm, NewDisconnections,
  ExcavationsForm, BoltsForm, EquipmentForm,
  HelpFunctions, HelpClasses, OrderNumberForm, OrderShortInfoForm,
  AddPrintDModule, AppGUIDS, StringConsts, AomComClientDModule, DepManager,
  AvarOnMapReport, BoltManager, RightsManagerDModule, SuborderManager, NGReportManager,QCanselForm,
  Closed1562Manager ,FloodingEditForm;


{$R *.dfm}

var
  OldColor: TColor;


procedure Tfrm_Order.ChangeEquipmentActivity();
var
  id_dmg: integer;
begin
  id_dmg:=F_order.mt_DamagePlace.FieldByName('ID').AsInteger;

  if ((F_SaveAction=saClose) or (F_OrderType in [otClose, otCloseInCurShift])) {and (not chk_WithoutEquipment.Checked)} and
      ((id_dmg = ID_VVOD) or (id_dmg = ID_MAGISTRAL) or (id_dmg = ID_ZAGLUSH_VVOD) or (id_dmg = ID_PEREKLAD_SET) or(id_dmg = ID_PODTOPTEPLSET)) then
    btn_Equipment.Enabled := true
  else
    btn_Equipment.Enabled := false;
end;

procedure Tfrm_Order.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if F_OrderType<>otClose then
  begin
    if F_IsTopCtrlChange or F_IsBottomCtrlChange then
    begin
      case ShowWarningDlg of
        raSave:
          if not SaveOrder then
          begin
            Action:=caNone;
            exit;
          end;
        raNoSave:;
      else
        begin
          Action:=caNone;
          exit;
        end;
      end; //end case
    end;
  end;

  if Tr_Voc.InTransaction then
    Tr_Voc.Commit;

  if Tr_SelectData.InTransaction then
    Tr_SelectData.Rollback;

  if Tr_ModifyData.InTransaction then
    Tr_ModifyData.Rollback;
end;


procedure Tfrm_Order.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Order.btn_CloseOrderClick(Sender: TObject);
begin
 if  F_NUM1562>0 then
 begin
    Application.MessageBox('Нужно сохранить связь наряд с заявкой!!!',
                            gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
    exit;
 end;
  if not ((F_OrderType in [otClose, otCloseInCurShift])and (F_NUM1562>0)) then
  begin
    if F_SaveAction=saSave then
    begin
      SetSaveAction(saClose);
      EnableBottomCtrls(true);
      ResetBottomCtrls;
      ActiveControl:=dbl_TubeDiameter;
    end else
    begin
      SetSaveAction(saSave);
      EnableBottomCtrls(false);
    end;
    ChangeEquipmentActivity;
    ChangeBoltsActivity;
  end;
end;

procedure Tfrm_Order.ChangeHouseTYpe;
var
  dset: TDataSet;
begin
  dset:=dbl_HouseTypes.LookupSource.DataSet;
  case dset.FieldByName('ID').AsInteger of
    0: //Улица, № дома
      begin
        ed_HouseNum.Visible:=true;
        dbl_Street2.Visible:=false;
        lbl_Housenum.Visible:=true;
        lbl_Street2.Visible:=false;
      end;
    1: //Пересечение улиц
      begin
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=true;
        lbl_Housenum.Visible:=false;
        lbl_Street2.Visible:=true;
      end;
    2: //Местность
      begin
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=false;
        lbl_Housenum.Visible:=false;
        lbl_Street2.Visible:=false;
      end;
  end;

end;


procedure Tfrm_Order.TopCtrlChange(Sender: TObject);
begin
  if F_ProcessState=psWork then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if (Sender as TRxDBLookupCombo).Tag = 111 then   //dbl_HouseTypes
      begin
        ChangeHouseType;
      end else
      if (Sender as TRxDBLookupCombo).Tag = 222 then  //dbl_DamagePlace
      begin
        ChangeEquipmentActivity;
        ChangeHoodCountVisible;
        ChangeBoltsActivity;
        ChangeDefaultAddInfoForFirstDep;

        if ( F_order.mt_DamagePlace.FieldByName('ID').AsInteger = ID_LUK ) then
          cb_HoodCount.ItemIndex := 0;
      end else
      if (Sender as TRxDBLookupCombo).Tag = 333 then  //dbl_MessageType
      begin
        ChangeDmgPlaceToProfWork;
        ChangeDefaultAddInfoForFirstDep;
      end
    end else
    if (Sender is TRxSpinEdit) then
    begin
      if (Sender as TRxSpinEdit).Tag=111 then  //sp_LocationDepth; sp_Pressure; sp_Square
        sp_FlowSpeed.Value:=0.62*3600*(sp_Square.Value/10000)*sqrt(20*max((10*sp_Pressure.Value-sp_LocationDepth.Value),0))
       else   //новіе утечки
       if (Sender as TRxSpinEdit).Tag=244 then
         if (spewidthLot.Value>0) and (speheightThread.Value>0) and (speSpeedQ.Value>0) then
           sp_FlowSpeed.Value:= 3600*spewidthLot.Value*speheightThread.Value*speSpeedQ.Value;
    end else
    if (Sender is TMaskEdit) then
      HelpFunctions.CorrectTimeEdit(Sender as TMaskEdit);



    SetIsTopCtrlChange(true);
    F_IsCtrlChange:=true;
    btn_SaveOrderData.Enabled:=true;
  end;
end;

procedure Tfrm_Order.EntryEnter(Sender: TObject);
const
  NEXT_POLE='; кл. Tab-перехода к след. полю';
begin
  //OldColor:=(Sender as TControl).Color;

  if Sender is TRXDBLookupCombo then
  begin
    OldColor:=(Sender as TRXDBLookupCombo).color;
    (Sender as TRXDBLookupCombo).color := clLime;
    SetProcessStatus('Выберите значение из списка'+NEXT_POLE);
  end else
  if Sender is TEdit then
  begin
     OldColor:=(Sender as TEdit).Color;
     (Sender as TEdit).Color :=  clLime;
     SetProcessStatus('Введите значение'+NEXT_POLE);
  end else
  if Sender is TRxSpinEdit then
  begin
     OldColor:=(Sender as TRxSpinEdit).Color;
     (Sender as TRxSpinEdit).Color :=clLime;
     SetProcessStatus('Введите значение'+NEXT_POLE);
  end else
  if Sender is TComboBox then
  begin
     OldColor:=(Sender as TComboBox).Color;
     (Sender as TComboBox).Color :=  clLime;
     SetProcessStatus('Выберите значение из списка'+NEXT_POLE);
  end else
  if Sender is TMaskEdit then
  begin
    OldColor:=(sender as TMaskEdit).Color;
    (sender as TMaskEdit).Color := clLime;
    SetProcessStatus('Введите время'+NEXT_POLE);
  end else
  if Sender is TDateEdit then
  begin
    OldColor:=(sender as TDateEdit).Color;
    (sender as TDateEdit).Color := clLime;
    SetProcessStatus('Введите дату'+NEXT_POLE);
  end;
  if (Sender is TRxSpinEdit) then
  if (Sender as TRxSpinEdit).Tag = 11111 //Скорость утечки автомат
   then
    if (spewidthLot.Value>0) and (speheightThread.Value>0 )and(speSpeedQ.Value>0) then
    begin
      Application.MessageBox('Скорость утечки исправить нельзя если указаны "Ширина лотка", "Высота потока воды", "Скорость"!! Исправте значения Ширина лотка", "Высота потока воды", "Скорость"!',
                            gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
       spewidthLot.SetFocus    ;
    end;
end;

procedure Tfrm_Order.EntryExit(Sender: TObject);
var
  IsAdr: boolean;
begin
  IsAdr:=false;

  if Sender is TRXDBLookupCombo then
  begin
    (Sender as TRXDBLookupCombo).color := OldColor;
    IsAdr:=((Sender as TRXDBLookupCombo).Tag=11111);
  end else
  if Sender is TEdit then
  begin
    (Sender as TEdit).Color :=  OldColor;
    IsAdr:=((Sender as TEdit).Tag=11111);
  end else
  if Sender is TRxSpinEdit then
  begin
     (Sender as TRxSpinEdit).Color := OldColor;
     if (Sender as TRxSpinEdit).Tag=11111 then //sp_FlowSpeed
        CheckFlowSpeed;
  end else
  if Sender is TComboBox then
     (Sender as TComboBox).Color :=  OldColor else
  if Sender is TMaskEdit then
  begin
    (sender as TMaskEdit).Color := OldColor;
    if (sender as TMaskEdit).Tag=22222 then  //me_End
      ActiveControl:=btn_SaveOrderData;
  end else
  if Sender is TDateEdit then
    (sender as TDAteEdit).Color := OldColor;

  if IsAdr then CheckAdres;

  SetProcessStatus('');
end;


procedure Tfrm_Order.btn_NewOrderClick(Sender: TObject);
var
  //IsWasNew: boolean;
  _IsNeedShowOrderNum: boolean;
begin
  //IsWasNew:=(F_OrderType=otNew);
  _IsNeedShowOrderNum := F_IsNeedShowOrderNum;

  if F_OrderType<>otClose then
    if Save then
    begin
      InitOrder;
      //if IsWasNew then
      if _IsNeedShowOrderNum then
        ShowOrderNumber('НС'+lbl_OrderNum.Caption);
    end else exit;

    //if Tr_Voc.InTransaction then
    //  Tr_Voc.Commit;

    F_OrderID:=-1;
    ResetForm;
    me_Start.SetFocus;
end;


procedure Tfrm_Order.btn_ExcavationsClick(Sender: TObject);
var
  IsReadOnly: boolean;
  frm_Exc: Tfrm_Excavations;
  _RegionID: integer;
  listNumbers:string;
begin
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;

{
  if F_OrderType=otNew then
  begin
    Application.MessageBox('Прежде необходимо зарегистрировать наряд',
                            gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
    exit;
  end;
}

  //IsReadOnly:=((F_OrderType=otClose) or (F_OrderType=otCloseInCurShift));
  IsReadOnly:=false;
  _RegionID := F_Order.mt_regions.FieldByName('ID').AsInteger;
  frm_Exc:=Tfrm_Excavations.Create(Application, F_OrderID, _RegionID, IsReadOnly);

  // сообщим форме, о текущем бригадире, ливквидирующем аварию
  frm_Exc.CurrentBrigCloseFromOrder := F_DepMgr.DepData.GetBrigIDFromLastDep( F_OrderID );

// frm_Exc.IsCanAddNewRec:=(F_SaveAction=saClose);  // - теперь они хотят вводить раскопки в открытых нарядах by Vadim 11.02.2011
  frm_Exc.DamageLoc:=F_order.mt_DamageLocality.FieldByName('ID').AsInteger;
  frm_Exc.IDOfficial:=g_IDOfficial;
  frm_Exc.IDOfficialPost:=DM_Main.GetIDOfficialPost(g_IDOfficial);
  frm_Exc.IDEquip:=GetDefaultEquipIDForExcavation;
  //список заявок с раскопкой
  if not F_NumSOBuff.IsDataLoad then
  begin

     F_NumSOBuff.OrderID := F_OrderID;
     F_NumSOBuff.id_disp :=  g_IDOfficial;
     F_NumSOBuff.OrderClosed:=((F_OrderType=otClose) or (F_OrderType=otCloseInCurShift) );
     F_NumSOBuff.for_vds:=0;
//{$IFNDEF spisok1562}
//  F_NumSOBuff.IsReadOnly := ( F_IsReadOnly);
  if not F_NumSOBuff.IsDataLoad then
    F_NumSOBuff.LoadData;
    end;
  listNumbers:=GetListNumsordersForExcav();
  frm_Exc.ListNumsorders:=listNumbers;

  frm_Exc.ShowModal;
  SetLastExcWorkType;

  //вопросы кап ремонт
  if frm_Exc.WasChanged then
  begin
   PostKap(listNumbers);
   F_NumSOBuff.SaveData;
 end;



  SelectNext(ActiveControl, true, true);
 
end;

procedure Tfrm_Order.chk_WithoutEquipmentClick(Sender: TObject);
begin
   ChangeEquipmentActivity;
end;


constructor Tfrm_Order.Create(AOwner: TComponent; const OrderID: integer);
begin
  F_NUM1562:=-1;
  F_OrderID:=OrderID;
  if OrderID=-1 then
    F_OrderMode:=omInput
  else
    F_OrderMode:=omEdit;

  inherited Create(AOwner);
end;

constructor Tfrm_Order.Create(AOwner: TComponent);
begin
  Create(AOwner, -1);
end;


procedure Tfrm_Order.OpenVocDataset;
var
  i: integer;
begin
  if Tr_Voc.InTransaction then
    Tr_Voc.Rollback;
  Tr_Voc.StartTransaction;

 { for i:=low(F_VocDsetArr) to high(F_VocDsetArr) do
    F_VocDsetArr[i].Open;}
    F_order.OpenVoks;
end;

procedure Tfrm_Order.EnableTopCtrls(value: boolean);
var
  _IsDtComingActive: boolean;
begin
  dbl_FirstOfficial.Enabled:=false;

  _IsDtComingActive := ( value and F_Order.IsCanEditDateComing( F_ShiftNumber, F_ShiftDate ) );
  dp_Start.Enabled := _IsDtComingActive;
  sb_DateComing.Enabled := _IsDtComingActive;
  me_Start.Enabled := _IsDtComingActive;

  dbl_Regions.Enabled:=value;
  dbl_HouseTypes.Enabled:=value;
  ed_AddAdres.Enabled:=value;
  dbl_Street.Enabled:=value;
  dbl_Street2.Enabled:=value;
  ed_Housenum.Enabled:=value;
  dbl_MessageType.Enabled:=value;
  ed_Abonent.Enabled:=value;
  cb_IsPayed.Enabled:=value;
  dbl_DamageLocality.Enabled:=value;
  dbl_DamageLocality_2.Enabled:=value;
  dbl_Damageplace.Enabled:=value;
  dbl_ControlOrgs.Enabled:=value;
  cb_HoodCount.Enabled:=value;
  sp_FlowSpeed.Enabled:=value;

  sp_LocationDepth.Enabled:=value;
  sp_Square.Enabled:=value;
  sp_Pressure.Enabled:=value;



  EnableLblOnGroupBox(gb_Top, value); // не проставляет checkbox
  cb_Pjatihatky.Enabled:=value;
  EnableLblOnGroupBox(gb_Adres, value);
  EnableLblOnPanel(pnl_LeakCalc, value);
  EnableLblOnPanel(pnl_leak2, value); //2015 новая утечка

  spewidthLot.Enabled:=value;
  speheightThread.Enabled:=value;
  speSpeedQ.Enabled:=value;

  EnableLblOnPanel(pnl_HoodCount, value);
end;

procedure Tfrm_Order.EnableBottomCtrls(value: boolean);
begin
  dbl_LastOfficial.Enabled:=false;

  chk_WithoutEquipment.Enabled:=value;
  dbl_TubeDiameter.Enabled:=value;
  dbl_Soil.Enabled:=value;
  dbl_TubeMaterial.Enabled:=value;
  dbl_DamageType.Enabled:=value;
  dp_End.Enabled:=value;// Glasha 21.05.2012
  me_End.Enabled:=value;
  sp_LocationDepthMirror.Enabled:=value;

  EnableLblOnGroupBox(gb_Bottom, value);
  lbl_Closure.Enabled:=true;

  EnableLblOnPanel(pnl_LocationDepth, value);
end;



procedure Tfrm_Order.ResetTopCtrls;
var
  TekDateTime: TDateTime;
begin
  TekDateTime := CrazyNow;

  //dp_Start.Date:=F_ShiftDate;
  dp_Start.Date := TekDateTime;
  me_Start.Text := FormatDateTime('hh:mm', TekDateTime);

  //lbl_OrderNum.Caption:='';
  lbl_OrderNum.Caption:=IntToStr(GetPossibleOrderNumber);

  //ResetDBL(dbl_FirstOfficial);
  FixDBLValue(g_IDOfficial, dbl_FirstOfficial);

  ResetDBL(dbl_Regions);

  f_order.mt_HouseType.First;
//  dset_HouseType.First;
  dbl_HouseTypes.DisplayValue:=f_order.mt_HouseType.FieldByName('name').AsString;

  ed_AddAdres.Text:='';
  ResetDBL(dbl_Street);
  ResetDBL(dbl_Street2);
  ed_HouseNum.Text:='';
  ResetDBL(dbl_MessageType);
  ed_Abonent.Text:='';
  cb_IsPayed.ItemIndex:=0;
  ResetDBL(dbl_DamageLocality);
  ResetDBL(dbl_DamagePlace);
  ResetDBL(dbl_DamageLocality_2);
  ResetDBL(dbl_ControlOrgs);
  sp_LocationDepth.Value:=0;
  sp_LocationDepth.Tag:=111;
  sp_FlowSpeed.Value:=0;

  sp_Pressure.Value:=0;
  sp_Square.Value:=0;
end;

procedure Tfrm_Order.ResetBottomCtrls;
var
  TekDateTime: TDateTime;
  _i: integer;
begin
 // TekDateTime := F_DepMgr.DepData.GetEndDateFromLastDep( F_OrderID );
 // if TekDateTime = 0 then
    TekDateTime := Now();    //glasha 31.05.2012 CrazyNow

  dp_End.Date:=TekDateTime;
  me_End.Text:=FormatDateTime('hh:mm', TekDateTime);

{
  if F_OrderMode=omEdit then
  begin
    ResetDBL(dbl_BrigClose);
    dbl_BrigClose.DisplayValue:='';
  end else
    FixDBLValue(dset_BrigOpen.FieldByName('ID').AsInteger, dbl_BrigClose);
}

  {NEED_MOD
  if not LoadDep2FieldValue then
  begin
    dp_Second.Date:=TekDateTime;
    me_Second.Text:=FormatDateTime('hh:mm', TekDateTime);

    if F_OrderMode=omEdit then
    begin
      ResetDBL(dbl_BrigClose);
      dbl_BrigClose.DisplayValue:='';
    end else
      FixDBLValue(dset_BrigOpen.FieldByName('ID').AsInteger, dbl_BrigClose);
  end;
  }

  chk_WithoutEquipment.Checked:=false;
  FixDBLValue(g_IDOfficial, dbl_LastOfficial);
  _i :=F_order.mt_officials_close.FieldByName('ID').AsInteger;


  if (F_order.mt_DamagePlace.FieldByName('ID').AsInteger in [ID_KOLONKA, ID_CL_KOLONKA, ID_CL_KOLODEC, ID_SH_KOLODEC])
    //or (dset_DamagePlace.FieldByName('ID').AsInteger=)
    then
  begin
    FixDBLValue(ID_CHUGUN, dbl_TubeMaterial);
    FixDBLValue(ID_DIAM_50, dbl_TubeDiameter);
    FixDBLValue(ID_PROCHIE, dbl_DamageType);
  end else
  begin
    ResetDBL(dbl_TubeMaterial);
    ResetDBL(dbl_TubeDiameter);
    ResetDBL(dbl_DamageType);
  end;
  ResetDBL(dbl_Soil);
end;

function Tfrm_Order.IsTopDateCorrect: boolean;
  function IsDateComingRight( _dt: TDateTime ): boolean;
  var
    _dt_beg, _dt_end: TDateTime;
    _msg: string;
  begin
  // mv 16.08.11
    _dt_beg := StrToDateTime( DateToStr( F_ShiftDate ) + ' ' + '08:00:00' );
    _dt_end := StrToDateTime( DateToStr( F_ShiftDate + 1 ) + ' ' + '08:00:01' );

    if ( _dt > _dt_beg ) and ( _dt < _dt_end ) then
    begin
      Result := true;
    end else
    begin
      Result := false;
      _msg := Format( 'Дата\время поступления должны быть больше чем' + #13 +
                      '%s и меньше чем %s', [ DateTimeToStr( _dt_beg ), DateTimeToStr( _dt_end ) ] );
      Application.MessageBox( PChar( _msg ), gc_strDispAVR, MB_OK+MB_ICONERROR);
    end;
  end;
var
  StartDate: string;
begin
  Result := false;

  StartDate := dp_Start.Text + ' ' + me_Start.Text;

  if not IsDateCorrect(StartDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты поступления',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if F_Order.IsCanEditDateComing( F_ShiftNumber, F_ShiftDate ) then
    if not IsDateComingRight( StrToDateTime( StartDate ) ) then
      exit;

  if IsDateLess(DateTimeToStr(Now), StartDate) then
  begin
    Application.MessageBox('Дата поступления не может быть больше текущей',
                            gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;

  Result:=true;
end;

function Tfrm_Order.IsBottomDateCorrect: boolean;
var
  EndDate, StartDate, ShiftEndDT, ShiftStartDT: string;
  _dt: TDateTime;
begin
  Result:=false;

  StartDate:=dp_Start.Text+' '+me_Start.Text;
  EndDate:=dp_End.Text+' '+me_End.Text;
  ShiftStartDT := datetostr( F_ShiftDate )+ ' 08:00';  
  ShiftEndDT := datetostr( F_ShiftDate + 1)+ ' 08:00';
  if not IsDateCorrect(EndDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты закрытия наряда',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if IsDateLess(DateTimeToStr(Now), EndDate) then
  begin
    Application.MessageBox('Дата закрытия заявки не может быть больше текущей',
                            gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;

  if IsDateLess( EndDate, StartDate ) then
  begin
    Application.MessageBox('Дата закрытия заявки не может быть больше даты поступления',
                            gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;

  _dt := F_DepMgr.DepData.GetEndDateFromLastDep( F_OrderID );
  if ( _dt > 0 ) and ( StrToDateTime( EndDate ) < _dt ) then
  begin
    Application.MessageBox('Дата закрытия заявки не может быть меньше ' +
                           'даты окончания работ у последнего выезда',
                            gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;

  if ( StrToDateTime( EndDate ) < StrToDateTime( ShiftStartDT ) )
     or (  StrToDateTime( EndDate ) >= StrToDateTime( ShiftEndDT ) ) then
  begin
    Application.MessageBox('Дата закрытия заявки не соответствует ' +
                           ' дате текущей смены',
                            gc_strDispAVR,MB_OK+MB_ICONERROR);
    exit;
  end;
  Result:=true;
end;


function Tfrm_Order.IsTopDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_FirstOfficial) then
  begin
    ActiveControl:=dbl_FirstOfficial;
    SetProcessStatus('Введите диспетчера, принявшего заявку');
    exit;
  end;

  if IsDBLEmpty(dbl_Regions) then
  begin
    ActiveControl:=dbl_Regions;
    SetProcessStatus('Введите район');
    exit;
  end;

  if IsDBLEmpty(dbl_Street) then
  begin
    ActiveControl:=dbl_Street;
    SetProcessStatus('Введите наименование улицы');
    exit;
  end;

  if (F_order.mt_housetype.FieldByName('ID').AsInteger=0) and
      (trim(ed_HouseNum.Text)='')  then
  begin
    ActiveControl:=ed_HouseNum;
    SetProcessStatus('Введите номер дома');
    exit;
  end;

  if (F_order.mt_housetype.FieldByName('ID').AsInteger=1) and
      (IsDBLEmpty(dbl_Street2)) then
  begin
    ActiveControl:=dbl_Street2;
    SetProcessStatus('Введите наименование 2-ой улицы');
    exit;
  end;

  if IsDBLEmpty(dbl_MessageType) then
  begin
    ActiveControl:=dbl_MessageType;
    SetProcessStatus('Введите о чем заявлено');
    exit;
  end;

{
  if IsDBLEmpty(dbl_DamageLocality) then
  begin
    ActiveControl:=dbl_DamageLocality;
    ProcessStatus:='Введите местность повреждения';
    exit;
  end;
}

  if IsDBLEmpty(dbl_DamagePlace) then
  begin
    ActiveControl:=dbl_DamagePlace;
    SetProcessStatus('Введите место повреждения');
    exit;
  end;


  if cb_IsPayed.ItemIndex<0 then
  begin
    ActiveControl:=cb_IsPayed;
    exit;
  end;


  {
  if (F_SaveAction=saSave) and (dset_DamagePlace.FieldByName('ID').AsInteger=ID_PROFWORKS) then
  begin
    ActiveControl:=btn_CloseOrder;
    SetProcessStatus('Закройте наряд профработами!!!');
    Application.MessageBox('Закройте наряд профработами!!!',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;
  }


  if ( F_order.mt_DamagePlace.FieldByName( 'ID' ).AsInteger in
     [ ID_MAGISTRAL, ID_VVOD, ID_KOLODEC, ID_KOLONKA  ,ID_PODTOPTEPLSET , ID_PEREKLAD_SET]) and
     ( IsDBLEmpty( dbl_DamageLocality ) ) then
  begin
    ActiveControl := dbl_DamageLocality;
    SetProcessStatus( 'Введите местность повреждения' );
    exit;
  end;

  Result:=true;
end;

function Tfrm_Order.IsBottomDataFieldsCorrect: boolean;
var
  val_int: integer;
  mes:string;
  _frmQ:Tfrm_QCansel;
begin
  Result:=false;

  if IsDBLEmpty(dbl_LastOfficial) then
  begin
    ActiveControl:=dbl_LastOfficial;
    SetProcessStatus('Введите диспетчера, закрывшего наряд');
    exit;
  end;

{
  if IsDBLEmpty(dbl_Soil) then
  begin
    ActiveControl:=dbl_Soil;
    ProcessStatus:='Введите грунт';
    exit;
  end;
}
  { MV 11.02.2013}

  if not(F_order.mt_DamagePlace.FieldByName('CHACK_DIAM').IsNull){((F_order.mt_DamagePlace.FieldByName('ID').AsInteger in [ID_PROFWORKS, ID_VDS, ID_LUK, ID_RABABON,
     ID_WASH_AFTER_CHANGE, ID_WASH_DEAD_END])
     or ((F_order.mt_DamagePlace.FieldByName('ID').AsInteger >=25) {and (F_order.mt_DamagePlace.FieldByName('ID').AsInteger<=41)))}

      then
  begin
    if IsDBLEmpty(dbl_TubeDiameter) then
    begin
    //  ActiveControl:=dbl_TubeDiameter;
      SetProcessStatus('Введите диаметр трубы');
//       ActiveControl:=dbl_TubeDiameter;
   //    dbl_TubeDiameter.SetFocus;
      exit;
    end;

    if IsDBLEmpty(dbl_TubeMaterial) then
    begin
   //   ActiveControl:=dbl_TubeMaterial;
      SetProcessStatus('Введите материал трубы');
      exit;
    end;

    if IsDBLEmpty(dbl_DamageType) then
    begin
    //  ActiveControl:=dbl_DamageType;
      SetProcessStatus('Введите вид повреждения');
      exit;
    end;
  end;


  if F_DisconnectedCount > 0 then
  begin
    ActiveControl:=btn_Disconnected;
    SetProcessStatus(Format('Есть активные отключения (%d шт.)',[F_ClosedBoltsCount]));
    exit;
  end;


  if F_ClosedBoltsCount>0 then
  begin
    ActiveControl:=btn_Bolts;
    SetProcessStatus(Format('Откройте задвижку (%d шт.)',[F_ClosedBoltsCount]));
    exit;
  end;



  if F_OpenDep3Count > 0 then
  begin
    ActiveControl:=btn_Deps;
    SetProcessStatus(Format('Имеются незакрытые выезды (%d шт.)',[F_OpenDep3Count]));
    exit;
  end;

  if is_canClosewithoutexcav then
   begin
    _frmQ:=Tfrm_QCansel.Create(nil);
    _frmQ.PreaPare('','Закрыть наряд с раскопкой?','С раскопкой','Без раскопки',2);
     case _frmQ.ShowModal of
      mrno: F_isClosedWithoutExcav:=true;
      mrcancel: begin
                 SetProcessStatus('Отменено порльзователем');
                 exit;
               end;
    end;
   end;

  {Оборудование}
   val_int:=GetEquipWorkCount;
  if  not F_isClosedWithoutExcav then
  begin

  if (val_int<=0) and (not chk_WithoutEquipment.Checked)
      and (F_order.mt_DamagePlace.FieldByName('ID').AsInteger in [ID_MAGISTRAL, ID_VVOD ,ID_PEREKLAD_SET,ID_PODTOPTEPLSET]) then
  begin
    btn_Equipment.Enabled:=true;
    ActiveControl:=btn_Equipment;
    SetProcessStatus('Введите оборудование');
    exit;
  end;
  end;

  if (val_int>0) and (not F_order.mt_DamagePlace.FieldByName('ID').AsInteger
        in [ID_MAGISTRAL, ID_VVOD, ID_ZAGLUSH_VVOD, ID_PEREKLAD_SET,ID_PODTOPTEPLSET]) then
  begin
    btn_Equipment.Enabled:=true;
    ActiveControl:=btn_Equipment;
    SetProcessStatus('Уберите оборудование');
    Application.MessageBox('Уберите оборудование !!!', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;
  {Оборудование}

  if ( GetNotConnectedCount > 0 ) then
  begin
    btn_Disconnected.Enabled:=true;
    ActiveControl:=btn_Disconnected;
    SetProcessStatus('Имеются неподключённые дома');
    exit;
  end;

  if not F_isClosedWithoutExcav then
   if (F_LastExcWorkTypeID=ID_NE_RASKOPANO)
      and (F_order.mt_DamagePlace.FieldByName('ID').AsInteger in [ID_MAGISTRAL, ID_VVOD , ID_PEREKLAD_SET,ID_PODTOPTEPLSET]) then
  begin
    btn_Excavations.Enabled:=true;
    ActiveControl:=btn_Excavations;
    SetProcessStatus('Введите работы по благоустройству');
    exit;
  end;

  if F_DepMgr.DepData.IsHasDepWithoutEndDate( F_OrderID ) then
  begin
   if ( DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID ) then
            ActiveControl := btn_WhatDone
      else
            ActiveControl := btn_Deps;
    SetProcessStatus('На форме "Что сделано" не указана дата окончания работ' );
    exit;
  end;

  if (( F_DepMgr.DepData.GetBrigIDFromLastDep( F_OrderID )=-1)
  or (F_DepMgr.DepData.GetDetLastDepAddinf(F_OrderID)='')
  )
   and (F_NumSOBuff.GetAllNumSO <>'') then ///glasha 16.02.2012
  if not F_DepMgr.DepData.IsSentWorks(F_OrderID) then begin
   if ( DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID ) then
            ActiveControl := btn_WhatDone
      else
            ActiveControl := btn_Deps;
    SetProcessStatus('В последнем выезде нет дополнительной информации или нет работ отсылаемых в 1562.' );
    exit;
  end;


  Result:=true;
end;


function Tfrm_Order.GetMaxOrderID(Transac: TIBTransaction; LastOrderID: integer): integer;
var
  dset: TIBDataSet;
begin
  dset:=TIBDataSet.Create(nil);
  try
    dset.Transaction:=Transac;
    MyOpenSQL(dset, 'select max(ID) as ID from orders where ID>'+IntToStr(LastOrderID));
    if dset.Eof and dset.Bof then
      Result:=-1
    else
      Result:=dset.FieldByName('ID').AsInteger;
    dset.Close;
  finally
    dset.Free;
  end;
end;


procedure Tfrm_Order.dbl_HouseTypesChange(Sender: TObject);
var
  dset: TDataSet;
begin
  dset:=(Sender as TRxDBLookupCombo).LookupSource.DataSet;
  case dset.FieldByName('ID').AsInteger of
    0: //Улица, № дома
      begin
        ed_HouseNum.Visible:=true;
        dbl_Street2.Visible:=false;
        lbl_Housenum.Visible:=true;
        lbl_Street2.Visible:=false;
      end;
    1: //Пересечение улиц
      begin
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=true;
        lbl_Housenum.Visible:=false;
        lbl_Street2.Visible:=true;
      end;
    2: //Местность
      begin
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=false;
        lbl_Housenum.Visible:=false;
        lbl_Street2.Visible:=false;
      end;
  end;
end;

procedure Tfrm_Order.BottomCtrlChange(Sender: TObject);
begin
  if F_ProcessState=psWork then
  begin
    {
    if (Sender is TRxDBLookupCombo) then
    begin
      if (Sender as TRxDBLookupCombo).Tag=777 then //dbl_BrigClose
      begin
      end;
    end;
    }
    if (Sender is TMaskEdit) then
      HelpFunctions.CorrectTimeEdit(Sender as TMaskEdit);

    SetIsBottomCtrlChange(true);
    F_IsCtrlChange:=true;
    btn_SaveOrderData.Enabled:=true;
  end;
end;


procedure Tfrm_Order.btn_SaveOrderDataClick(Sender: TObject);
var
  //IsWasNew: boolean;
   _062_list: string;
  _IsNeedShowOrderNum: boolean;
  SaveAction: TSaveAction;
begin
  if (F_OrderType=otClose)or(F_OrderType=otCloseInCurShift) then
  begin
    SaveNumSOBuff;
    InitOrder;
    exit;
  end;




  if not F_NumSOBuff.IsDataLoad then
    begin
      F_NumSOBuff.OrderID := F_OrderID;
      F_NumSOBuff.LoadData;
    end;

  _062_list :=  F_NumSOBuff.GetAllNumSO ;

  if (F_SaveAction=saSave)
     and (F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_PROFWORKS)
      and (_062_list<>'')
      and (not F_Cansel)
      and (F_DefaultAddInfoForFirstDep ='') then
  begin
    ActiveControl:=btn_CloseOrder;
    SetProcessStatus('Закройте наряд профработами!!!');
    Application.MessageBox('Закройте наряд профработами!!!',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  //IsWasNew:=(F_OrderType=otNew);
  _IsNeedShowOrderNum := F_IsNeedShowOrderNum;
  SaveAction:=F_SaveAction;

  if Save then
  begin
    InitOrder;
    //if IsWasNew then
    if _IsNeedShowOrderNum then
      ShowOrderNumber('НС'+lbl_OrderNum.Caption);

    if (F_OrderMode=omEdit) or (F_NUM1562>0)
    then
      begin
        if (F_NUM1562>0) then
        Application.MessageBox('Нужно сохранить связь наряд с заявкой!!!',
                            gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
        if MessageBox(
          handle,
          'Наряд сохранён. Выйти из формы наряда?',
          'Диспетчер АВР :: Сохранение наряда',
          MB_YESNO or MB_ICONQUESTION
        ) = ID_YES then close;
      end
    else
      begin
        if not(F_order.mt_DamagePlace.FieldByName('ID').AsInteger in [ID_MAGISTRAL,ID_VVOD, ID_PEREKLAD_SET, ID_PODTOPTEPLSET]) then
        begin
      //    btn_NewOrderClick(nil) // - REMed by Vadim 06.09.2010
        end else
        begin
          if SaveAction=saClose then
      //      btn_NewOrderClick(nil)
        end;
      end;
  end;

end;

procedure Tfrm_Order.InitOrder;
begin
  F_ProcessState:=psInit;
  F_Order.ResetFields;
  F_isClosedWithoutExcav:=false;
  case F_OrderType of
    otNew:
      begin
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(false);
        ResetTopCtrls;
        ResetBottomCtrls;
        F_Disconnections:='';
        btn_CloseOrder.Enabled:=true;
        btn_RestoreOpenState.Visible:=false;
        btn_Print.Visible:=false;
        SetSaveAction(saSave);
        VisibleLeakCalc(true);
        lbl_Closure.Caption:='';
        Caption:='Ввод наряда';
        F_IsNeedShowOrderNum := true;

      end; // end otNew
    otOpen:
      begin
        LoadTopFieldsValue;
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(false);
        btn_CloseOrder.Enabled:=true;
        btn_RestoreOpenState.Visible:=false;
        btn_Print.Visible:=true;
        ActiveControl:=btn_CloseOrder;
        SetSaveAction(saSave);
        VisibleLeakCalc(false);
        lbl_Closure.Caption:='';
        Caption:='Просмотр и редактирование наряда';
        F_IsNeedShowOrderNum := false;

      end; // end otOpen
    otClose:
      begin
        LoadTopFieldsValue;
        LoadBottomFieldsValue;
        ShowDeletedRowInVoc(true);
        EnableTopCtrls(false);
        EnableBottomCtrls(false);
        btn_CloseOrder.Enabled:=false;
        btn_RestoreOpenState.Visible:=false;
        btn_Print.Visible:=true;
        if btn_NewOrder.Visible then
          ActiveControl:=btn_NewOrder;
        SetSaveAction(saClose);
        VisibleLeakCalc(false);
        lbl_Closure.Caption:='Наряд закрыт';
        Caption:='Просмотр наряда';
        F_IsNeedShowOrderNum := false;

      end;  //end otClose;
    otCloseInCurShift: //наряд закрытый в текущую смену
      begin
        LoadTopFieldsValue;
        LoadBottomFieldsValue;
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(true);
        btn_CloseOrder.Enabled:=false;
        btn_RestoreOpenState.Visible:=true;
        btn_Print.Visible:=true;
        SetSaveAction(saClose);
        VisibleLeakCalc(false);
        lbl_Closure.Caption:='Наряд закрыт';
        Caption:='Просмотр наряда';
        F_IsNeedShowOrderNum := false;
      
      end;
  end; //end case
  SetDisconnectedCount;
  SetClosedBoltsCount;
  SetLastExcWorkType;
  SetDepartureCount();
  ChangeDefaultAddInfoForFirstDep;
  btn_SaveOrderData.Enabled:=false;
  btn_NewOrder.Visible:=(F_OrderMode=omInput);

  F_ProcessState:=psWork;
  /////////////////////////

  {Зависят от F_ProcessState}
  ChangeHouseType;
  ChangeBoltsActivity;
  ChangeEquipmentActivity;
  ChangeHoodCountVisible;
  //ChangeDmgPlaceToProfWork;  //не надо!
  {/Зависят от F_ProcessState}

  SetIsTopCtrlChange(false);
  SetIsBottomCtrlChange(false);
  ////////////////////////////
  ////////////////////////////
  ////////////////////////////
  {Права пользователя}


  if F_OrderType = otNew then
    begin
    SetFilterRegions;
    end
  else
    if not IsCurrentUserCanEdit then
    begin
      SetProcessStatus('У вас недостаточно прав для редактирования данной формы');
      F_IsReadOnly:=true;
    end else
     if not IsCurrentDistrictCanAccessRegion(F_order.mt_regions.FieldByName('ID').AsInteger) then
      begin
       SetProcessStatus('Вы не можете редактировать данный район');
       F_IsReadOnly:=true;
      end
     else
     F_IsReadOnly:=false;

   if F_IsReadOnly then EnableAllCtrls( false );
  {/Права пользователя}


  SetDamagePlace_Filter

end;

procedure Tfrm_Order.SetFilterRegions;
var _f:integer;
     _s:string;
     _id: integer;
begin
      //
      _f := 0;
      _s := '';
    F_order.mt_regions.First;
      while not F_order.mt_regions.Eof do
      begin
       _id := F_order.mt_regions.FieldByName('id').AsInteger;
       if IsCurrentDistrictCanAccessRegion(_id) then
        begin
        {  if (_s = '') then _s := _s  + IntToStr(_id)
          else
          _s := _s + ',' + IntToStr(_id);}
          if (_s='') then _s:=_s+'id='+IntToStr(_id)
          else
           _s:=_s+'or id='+IntToStr(_id);

        end
        else
        inc(_f);
       F_order.mt_regions.Next;
      end;
//    if (_f > 0) then  dset_Regions.Filter := 'id in ('+ _s + ')';
  //  _s := ' where id in( '+ _s +')';
  //  _s := 'select id, name, activity '+
  //  ' from s_regions '+ _s +
  //  ' order by name ';
//    dset_Regions.SelectSQL.Text := _s;
//    dset_Regions.Filtered := (_f > 0);
//    dset_Regions.Refresh;
    f_order.mt_regions.filter:=_s;
    f_order.mt_regions.Filtered:=true;
    f_order.mt_regions.Close;
    f_order.mt_regions.Open;



end;

procedure Tfrm_Order.EnableAllCtrls( value: boolean );
begin
    EnableTopCtrls(value);
    EnableBottomCtrls(value);
    btn_CloseOrder.Enabled:=value;
    btn_SaveOrderData.Enabled:=value;
    btn_RestoreOpenState.Enabled:=value;
    btn_NewOrder.Enabled:=value;
end;

function Tfrm_Order.SaveOrder: boolean;
var
  last_order_id: integer;
begin
  Result:=false;

  Cursor:=crHourGlass;
  SetProcessStatus('Сохранение наряда');

  if (not IsTopDateCorrect) or (not IsTopDataFieldsCorrect) then
    exit;

  sql_Order.Transaction.StartTransaction;
  try
    case F_OrderType of
      otNew:
        begin
          last_order_id:=GetLastOrderID(sql_Order.Transaction);
          MyExecSQL(sql_Order, TopOrderFieldsQuery(faInsert));
          F_OrderID:=GetMaxOrderID(sql_Order.Transaction, last_order_id);
          MyExecSQL(sql_Order,
            Format('update orders set ShiftNumber=%d where ID=%d', [F_ShiftNumber, F_OrderID]));
        end;
      otOpen:
        begin
          if F_IsTopCtrlChange then
            MyExecSQL(sql_Order, TopOrderFieldsQuery(faUpdate));
        end;
    end; // end case
  except
    on E:Exception do
    begin
      Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
      sql_Order.Transaction.Rollback;
      Cursor:=crDefault;
      beep;
      exit;
    end;
  end;
  sql_Order.Transaction.Commit;

  SaveNumSOBuff;

  SetProcessStatus('Наряд сохранен');
  Cursor:=crDefault;
  SetOrderType;
  F_IsNeedShowOrderNum := true;

  Result:=true;
end;

function Tfrm_Order.CloseOrder: boolean;
var
  _062_list,_062_listv,list_1562:string;
  list_tel:TStringList;
  List_Och:TStringList;
  SList_1562:TStringList;
  t_Cansel:integer;
  ManClosed:TManClosed1562;
  mes:string;
  _frmQ:Tfrm_QCansel;
  F_checkworks:boolean;
  F_check_asf:boolean;
begin

try
 Enabled:=false;
  Result:=false;

  SetProcessStatus('Закрытие наряда');
  SaveNumSOBuff;
  {if is_canClosewithoutexcav then
   begin
    _frmQ:=Tfrm_QCansel.Create(nil);
    _frmQ.PreaPare('','Закрыть наряд с раскопкой?','С раскопкой','Без раскопки');
    case _frmQ.ShowModal of
     mrno: F_isClosedWithoutExcav:=true;
     mrcancel: begin
                SetProcessStatus('Отменено порльзователем');
                exit;
              end;
    end;
  //  F_isClosedWithoutExcav:=(_frmQ.ShowModal=mrNo);

   end;        }

  if (not IsTopDateCorrect) or (not IsTopDataFieldsCorrect) or
      (not IsBottomDateCorrect) or (not IsBottomDataFieldsCorrect) then
    exit;


  if F_SaveAction = saClose then
  begin
    if not F_NumSOBuff.IsDataLoad then
    begin
      F_NumSOBuff.OrderID := F_OrderID;
      F_NumSOBuff.LoadData;
    end;

    _062_list :=  F_NumSOBuff.GetAllNumSO ;
   { _062_listv := F_NumSOBuff.GetAllNumSOViw;
    list_1562:= F_NumSOBuff.GetAllNumSO_1562;
    list_tel:=F_NumSOBuff.GetAllIDSOList_1562tel;
    list_Och:=F_NumSOBuff.GetAllIDSOList_1562Och;
    SList_1562:=F_NumSOBuff.GetAllIDSOList_1562;

    if _062_listv<>'' then begin
      Application.MessageBox( PChar( _062_listv ), 'Список заявок 15-62',
        MB_OK + MB_ICONINFORMATION );

    end; }

  end;
 F_checkworks:=check_works;
  F_check_asf:=check_asf;

 if (F_order.mt_DamageLocality.FieldByName('ID').AsInteger in [3,5]) then //ззеленая зона грунтовая дорога
  if  (F_sqw_asf_works>0) or (F_sqasf_exc>0 ) then
   begin
     Application.MessageBox('Нельзя закрыть наряд с данной местностью повреждения с асфальтировкой!!',gc_strDispAVR, MB_OK+MB_ICONERROR);
     SetProcessStatus('Нельзя закрыть наряд с данной местностью повреждения с асфальтировкой!!');
     dbl_DamageLocality.SetFocus;
     exit;
   end;


 if not  F_isClosedWithoutExcav then
  if F_check_asf then
    if Application.MessageBox('Вы уверены, что хотите закрыть наряд c данной местностью повреждения, но без асфальтировки?',
                gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES then
      exit;

  if not  F_isClosedWithoutExcav then
  if  not F_checkworks then
  begin
     Application.MessageBox('Нельзя закрыть наряд c данной местностью повреждения, с раскопками без площади асфальта !',
                gc_strDispAVR, MB_OK+MB_ICONWARNING) ;
      SetProcessStatus('Нельзя закрыть наряд c данной местностью повреждения, с раскопками без площади асфальта');
      btn_WhatDone.SetFocus;
      exit;
  end;
  if F_DeparturesCount = 0 then
   begin
    Application.MessageBox('Нельзя закрыть наряд без выездов !',
                gc_strDispAVR, MB_OK+MB_ICONWARNING) ;
      SetProcessStatus('Нельзя закрыть наряд без выездов !');
      btn_WhatDone.SetFocus;
      exit;
   end;
  if F_OrderType in [otNew, otOpen] then
    if Application.MessageBox('Вы уверены, что хотите закрыть наряд?',
                gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES then
      exit;
 try
// {$ifdef Cansel}
{  if ((F_SaveAction=saClose) and  ( list_1562<>''))
//  {$ifdef sent_tel_toOch }
{      or (list_tel.count>0)
      or (list_och.Count>0)
      or  (Slist_1562.Count>0)
//  {$endif}
{  then
  begin
  t_Cansel:=ClosedCansel();
   if t_Cansel=-1  then begin
    SetProcessStatus('Закрытие наряда отменено пользователем');
    exit;
   end;
  end;
 {$endif}
 try
 try
 ManClosed:=TManClosed1562.Create(1,F_orderID,_062_list,lbl_OrderNum.Caption,StrToDateTime( dp_Start.Text + ' ' + me_Start.Text ));  //2-вдс 1-нс
  case    ManClosed.QuestionClosed1562(mes) of
  -1:  begin

         SetProcessStatus(mes);
         exit;
       end;
   0: begin

         SetProcessStatus('Ошибка при закрытие наряда. Наряд не закрыт');
         exit;
      end
  end;

   sql_Order.Transaction.StartTransaction;
   if F_IsTopCtrlChange then
      MyExecSQL(sql_Order, TopOrderFieldsQuery(faUpdate));

    //if F_IsBottomCtrlChange then
   MyExecSQL(sql_Order, BottomOrderFieldsQuery(faUpdate));

   MyExecSQL(sql_Order, Format('update orders set IsClosed=1, ShiftNumberClose=%d where id=%d',
      [F_ShiftNumber, F_OrderID]));
   ManClosed.doClosed1562;



  except on e:exception do
   raise e;
    end;
  finally
    ManClosed.free;
 //   F_NumSOBuff.LoadData;
  end;
{   if (_062_list<>'') then
   if  (not F_Cansel) then
     MyExecSQL(sql_Order, Format('update numsorders set state_inner=3,state_outer=1 where state_inner=1 and  id_order= %d',[F_OrderID]));

   if F_Cansel then
   begin

    if t_Cansel=1 then
    if assigned(frm_cansel) then
    begin
       frm_cansel.ID1562:=SList_1562;
       frm_cansel.SaveDate(Import_Denied);
       frm_cansel.ID1562:=List_och;
       frm_cansel.SaveDate(Import_Denied);
       MyExecSQL(sql_Order, Format('update numsorders set state_inner=3,state_outer=1 where id_order= %d and state_inner=1 and  trim(recived_from)=''По телефону'' ',[F_OrderID]));
       frm_Cansel.Free;
       F_Cansel:=false;
    end;
   if t_Cansel=2 then
   begin
     frm_cansel.ID1562:=SList_1562;
       frm_cansel.SaveDate(Import_Denied);
       frm_cansel.ID1562:=List_och;
       frm_cansel.SaveDate(RallBack1562);
       frm_cansel.ID1562:=List_tel;
       frm_cansel.SaveDate(TelRequestInOch);
   end;

  end;
 }

  except
    sql_order.Transaction.Rollback;
     SetProcessStatus('Ошибка при закрытии наряда. Наряд не закрыт');
    exit;
  end;
  sql_Order.Transaction.Commit;

 // SaveNumSOBuff;

  SetProcessStatus('Наряд закрыт');

  SetOrderType;
  Result:=true;
 finally
   Cursor:=crDefault;
   Enabled:=true;
 end;
end;


procedure Tfrm_Order.LoadBottomFieldsValue;
begin
  dset_BottomOrderFields.Transaction.StartTransaction;
  try
    dset_BottomOrderFields.ParamByName('pID').AsInteger:=F_OrderID;
    dset_BottomOrderFields.Open;

    with dset_BottomOrderFields do
    begin
      {Данные берутся из таблицы Orders}
      Chk_WithoutEquipment.Checked:=boolean(FieldByName('WithoutEquipment').AsInteger);
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALCLOSED').AsInteger, dbl_LastOfficial); //Диспетчер, закрывший заявку
      FixDBLValue(FieldByName('FK_ORDERS_DIAMETERS').AsInteger, dbl_TubeDiameter);  //Диаметр трубы
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALCLOSED').AsInteger, dbl_LastOfficial);
      FixDBLValue(FieldByName('FK_ORDERS_SOIL').AsInteger, dbl_Soil);   //Грунт
      FixDBLValue(FieldByName('FK_ORDERS_TUBEMATERIAL').AsInteger, dbl_TubeMaterial);  //Материал трубы
      FixDBLValue(FieldByName('FK_ORDERS_DAMAGETYPE').AsInteger, dbl_DamageType);  //Вид повреждения
      dp_End.Date:=FieldByName('DateClosed').AsDateTime;  //Дата закрытия заявки
      me_End.Text:=FormatDateTime('hh:mm', FieldByName('DateClosed').AsDateTime);  //Время закрытия заявки
      lbl_withoutorder.Visible:= not (FieldByName('fk_orders_Off_WithoutExcav').isnull);
      {/Данные берутся из таблицы Orders}
    end; // end with
  finally
    dset_BottomOrderFields.Transaction.Commit;
  end;
end;

procedure Tfrm_Order.LoadTopFieldsValue;
begin
  dset_TopOrderFields.Transaction.StartTransaction;
  try
    dset_TopOrderFields.ParamByName('pID').AsInteger:=F_OrderID;
    dset_TopOrderFields.Open;
    with dset_TopOrderFields do
    begin
      {Данные берутся из таблицы Orders}
      lbl_OrderNum.Caption:=FieldByName('OrderNumber').AsString; //Номер наряда
      dp_Start.Date:=FieldByName('DateComing').AsDateTime; //Дата поступления
      me_Start.Text:=FormatDateTime('hh:mm', FieldByName('DateComing').AsDateTime); //Время поступления
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALS').AsInteger, dbl_FirstOfficial); //Диспетчер, принявший заявку
      FixDBLValue(FieldByName('FK_ORDERS_REGIONS').AsInteger, dbl_Regions); //Район
      FixDBLValue(FieldByName('FK_ORDERS_HOUSETYPES').AsInteger, dbl_HouseTypes); //Тип адреса
      ed_AddAdres.Text:=Trim(FieldByName('AdditionalAddress').AsString); //Дополнительный адрес
      FixDBLValue(FieldByName('FK_ORDERS_STREETS').AsInteger, dbl_Street); //Улица
      if FieldByName('FK_ORDERS_HOUSETYPES').AsInteger=0 then
        ed_HouseNum.Text:=trim(FieldByName('HouseNum').AsString); //Номер дома
      if FieldByName('FK_ORDERS_HOUSETYPES').AsInteger=1 then
        FixDBLValue(StrToInt(Trim(FieldByName('HouseNum').AsString)), dbl_Street2); //Вторая улица
      FixDBLValue(FieldByName('FK_ORDERS_MESSAGETYPES').AsInteger, dbl_MessageType); //О чем заявлено
      ed_Abonent.Text:=Trim(FieldByName('Abonent').AsString); //Абонент
      cb_IsPayed.ItemIndex:=FieldByName('IsPayed').AsInteger; //Платный
      FixDBLValue(FieldByName('FK_ORDERS_DAMAGELOCALITY').AsInteger, dbl_DamageLocality); //Местность повреждения
      FixDBLValue(FieldByName('FK_ORDERS_DAMAGEPLACE').AsInteger, dbl_Damageplace); //Место повреждения
      FixDBLValue(FieldByName('FK_ORDERS_ORGANISATIONS').AsInteger, dbl_ControlOrgs);  //Заявка на контроле
      sp_LocationDepth.Value:=FieldByName('LocationDepth').AsFloat;  //Глубина заложения
      sp_LocationDepthMirror.Value:=FieldByName('LocationDepth').AsFloat;
      sp_FlowSpeed.Value:=FieldByName('FlowSpeed').AsFloat;  //Q
//      sp_Naled.Value := FieldByName('Naled_Square').AsFloat; // Наледь
      sp_Square.Value:=FieldByName('Square').AsFloat;    //Площадь
      sp_Pressure.Value:=FieldByName('Pressure').AsFloat;    //Давление
      F_Disconnections:=trim(FieldbyName('Disconnections').AsString);  //Отключения
      spewidthLot.value:=fieldbyname('widthLot').asFloat;
      speheightThread.Value:=FieldByName('heightThread').asFloat;
      speSpeedQ.Value:=FieldByName('SpeedQ').asFloat;//новые утечки шириина высоты скорость
      if not FieldByName('HoodCount').IsNull then
        cb_HoodCount.ItemIndex:=FieldByName('HoodCount').AsInteger - 1;

      if not FieldByName('IS_PJATIHATKY').IsNull then
         cb_Pjatihatky.Checked := ( FieldByName('IS_PJATIHATKY').AsInteger = 1 );
      FixDBLValue(FieldByName('FK_ORDERS_ADD_DAMAGELOCALITY').AsInteger, dbl_DAMAGELOCALITY_2); //Место повреждения 11.03.2013
//      IS_PJATIHATKY
      F_Order.Edit;
      F_Order.FieldByName( 'DateComing' ).AsDateTime := FieldByName( 'DateComing' ).AsDateTime;
      F_Order.FieldByName( 'ShiftNumber' ).AsInteger := FieldByName( 'ShiftNumber' ).AsInteger;
      F_Order.FieldByName( 'RegionID' ).AsInteger := FieldByName('FK_ORDERS_REGIONS').AsInteger;

      F_Order.Post;

      {/Данные берутся из таблицы Orders}
    end; // end with
  finally
    dset_TopOrderFields.Transaction.Commit;
  end;
end;



procedure Tfrm_Order.btn_BoltsClick(Sender: TObject);
var
  frm_Bolts:Tfrm_Bolts;
  _IsReadOnly: boolean;
  _BoltMan: TBoltManager;
  _CurrentBrigClose: integer;
  _RegionID: integer;
begin
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;

  _IsReadOnly:=(F_OrderType=otClose);
  // сообщим форме, о текущем бригадире, ливквидирующем аварию
  _CurrentBrigClose  := F_DepMgr.DepData.GetBrigIDFromLastDep( F_OrderID );
  _RegionID := F_order.mt_regions.FieldByName('ID').AsInteger;


  frm_Bolts:=TFrm_Bolts.Create(nil, F_OrderID, _RegionID, _IsReadOnly);
  frm_Bolts.CurrentBrigCloseFromOrder := _CurrentBrigClose;
  {
  if dset_BrigOpen.FieldByName('ID').AsInteger<>-1 then
    frm_Bolts.FirstDepDTTM:=trunc(dp_FirstDep.Date)+StrToTime(me_FirstDep.Text);
  }
  frm_Bolts.ShowModal;


  {Новая версия задвижек. Начнут использоваться,
  когда будет вводиться информация на районах}
  (*
  _BoltMan := TBoltManager.Create( dset_Regions.FieldByName('ID').AsInteger );
  try
    _BoltMan.OrderID := F_OrderID;
    _BoltMan.IsReadOnly := _IsReadOnly;
    _BoltMan.CurrentBrigCloseFromOrder := _CurrentBrigClose;
    _BoltMan.OfficialPostID := DM_Main.GetIDOfficialPost( g_IDOfficial );
    {
    if dset_BrigOpen.FieldByName('ID').AsInteger<>-1 then
      _BoltMan.FirstDepDTTM:=trunc(dp_FirstDep.Date)+StrToTime(me_FirstDep.Text);
    }
    _BoltMan.Show;
  finally
    _BoltMan.Free;
  end;
*)
  {/}

  SetClosedBoltsCount;
  SelectNext(ActiveControl, true, true);
end;

function Tfrm_Order.TopOrderFieldsQuery(FixAction: TFixAction): string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['DateComing']:=DateTime2Str(dp_Start.Date,StrToTime(me_Start.Text));
      ValueByFieldName['FK_ORDERS_OFFICIALS']:=  F_Order.mt_officials_open.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_REGIONS']:=F_Order.mt_regions.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_HOUSETYPES']:=F_order.mt_housetype.FieldByName('ID').AsString;
      ValueByFieldName['ADDITIONALADDRESS']:=QuotedStr(ed_AddAdres.Text);
      ValueByFieldName['FK_ORDERS_STREETS']:=F_Order.mt_street.FieldByName('ID').AsString;
      if F_order.mt_housetype.FieldByName('ID').AsInteger=0 then
        ValueByFieldName['HouseNum']:=QuotedStr(ed_HouseNum.Text);
      if F_order.mt_housetype.FieldByName('ID').AsInteger=1 then
        ValueByFieldName['HouseNum']:=QuotedStr(F_order.mt_street2.FieldByName('ID').AsString);
      ValueByFieldName['FK_ORDERS_MESSAGETYPES']:=F_order.mt_messagetype.FieldByName('ID').AsString;
      ValueByFieldName['Abonent']:=QuotedStr(ed_Abonent.Text);
      ValueByFieldName['IsPayed']:=IntToStr(cb_IsPayed.ItemIndex);
      ValueByFieldName['FK_ORDERS_DAMAGELOCALITY']:=F_order.mt_DamageLocality.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_ADD_DAMAGELOCALITY']:=F_order.mt_DamageLocality_2.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_DAMAGEPLACE']:=F_order.mt_DamagePlace.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_ORGANISATIONS']:=F_order.mt_organisation.FieldByName('ID').AsString;
      ValueByFieldName['LocationDepth']:=FixFloatStr(sp_LocationDepth.Text);
      ValueByFieldName['FlowSpeed']:=FixFloatStr(sp_FlowSpeed.Text);

      //Новіе утечки
      ValueByFieldName['widthLot']:=FixFloatStr(spewidthLot.Text);
      ValueByFieldName['heightThread']:=FixFloatStr(speheightThread.Text);
      ValueByFieldName['SpeedQ']:=FixFloatStr(speSpeedQ.Text);

//      ValueByFieldName['Naled_Square']:=FixFloatStr(sp_Naled.Text);
      ValueByFieldName['Square']:=FixFloatStr(sp_Square.Text);
      ValueByFieldName['Pressure']:=FixFloatStr(sp_PRessure.Text);
      ValueByFieldName['Disconnections']:=QuotedStr(F_Disconnections);

      if FixAction=faInsert then
        ValueByFieldName['FACTDATECOMING']:=''''+DateToStr(now())+' '+TimeToStr(now())+'''';//25.03.12



      if ( F_order.mt_DamagePlace.FieldByName('ID').AsInteger = ID_LUK {установка люков} )
      then ValueByFieldName['HoodCount']:=IntToStr(cb_HoodCount.ItemIndex + 1)
      else ValueByFieldName['HoodCount'] := '0';

      if (cb_Pjatihatky.Checked) then ValueByFieldName['IS_PJATIHATKY'] := '1'
          else ValueByFieldName['IS_PJATIHATKY'] := '0';

      TableName:='orders';
      Condition:='id='+IntToStr(F_OrderID);

      case FixAction of
        faInsert: Result:=GenInsertQuery;
        faUpdate: Result:=GenUpdateQuery;
      end;
    finally
      Free;
    end;
  end;
end;

function Tfrm_Order.BottomOrderFieldsQuery(FixAction: TFixAction): string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['WithoutEquipment']:=IntToStr(Integer(chk_WithoutEquipment.Checked));
      ValueByFieldName['FK_ORDERS_OFFICIALCLOSED']:=F_order.mt_officials_close.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_DIAMETERS']:=F_order.mt_tubediametr.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_SOIL']:=F_order.mt_soil.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_TUBEMATERIAL']:=F_order.md_tubemater.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_DAMAGETYPE']:=F_order.mt_Damagetype.FieldByName('ID').AsString;
      ValueByFieldName['DateClosed']:=DateTime2Str(dp_End.Date,StrToTime(me_End.Text));

      ValueByFieldName['FACTDATECLOSED']:=''''+DateToStr(now())+' '+TimeToStr(now())+'''';//25.03.12

      if  F_isClosedWithoutExcav then
       begin
          ValueByFieldName['fk_orders_Off_WithoutExcav']:=F_order.mt_officials_close.FieldByName('ID').AsString;
          ValueByFieldName['DateTime_withoutExcav']:=''''+DateToStr(now())+' '+TimeToStr(now())+'''';
       end

       else
        begin
          ValueByFieldName['fk_orders_Off_WithoutExcav']:='null';
          ValueByFieldName['DateTime_withoutExcav']:='null';
       end;

      TableName:='orders';
      Condition:='id='+IntToStr(F_OrderID);

      case FixAction of
        faInsert: Result:=GenInsertQuery;
        faUpdate: Result:=GenUpdateQuery;
        faUpdateToNull: Result:=GenUpdateToNullQuery;
      end;
    finally
      Free;
    end;
  end;
end;

procedure Tfrm_Order.btn_WhatDoneClick(Sender: TObject);
var
  _IsReadOnly: boolean;
  _RegionID: integer;
  visoutOrder:boolean;
begin
{
  frm_WhatDone := Tfrm_WhatDone.Create(Application, 'Что сделано?', wdtWhatDone );
  try
    frm_WhatDone.ResultString := F_WhatIsDone;
    frm_WhatDone.ReadOnlyFrm := ((F_OrderType=otClose) or F_IsReadOnly);
    frm_WhatDone.ShowModal;
    if F_WhatIsDone <> frm_WhatDone.ResultString then
    begin
      F_WhatIsDone := frm_WhatDone.ResultString;
      if ( Length(F_WhatIsDone)>WHAT_DONE_LENGTH ) then
      begin
        F_WhatIsDone := Copy(F_WhatIsDone, 1, WHAT_DONE_LENGTH);
      end;
      TopCtrlChange(nil);
    end;
  finally
    frm_WhatDone.Free();
  end;
}


  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;
  //
  //
  //
{Проверим существование наряда }
   visoutOrder:=(F_order.mt_DamagePlace.FieldByName('ID').asinteger>=1000 );
 // _IsReadOnly := ( F_OrderType = otClose ); {пока откроем почему не знаю}
//  _IsReadOnly:=false;
  //_RegionID := F_Order.FieldByName( 'RegionID' ).AsInteger;

  _RegionID := F_order.mt_regions.FieldByName( 'id' ).AsInteger;

  F_DepMgr.DepData.OrderID := F_OrderID;
  F_DepMgr.DepData.DefaultAddInfoForFirstDep := F_DefaultAddInfoForFirstDep;
  F_DepMgr.DepData.DefaultBrigID := F_OrderFieldsStack.ID_FirstDepBrig;
  F_DepMgr.DepData.OrderDateComing := StrToDateTime( dp_Start.Text + ' ' + me_Start.Text );
  F_DepMgr.DepData.CurShiftDate := F_ShiftDate;
  F_DepMgr.DepData.OrderNumber:=lbl_OrderNum.Caption;
  F_DepMgr.Execute( etReg, _IsReadOnly, _RegionID,visoutOrder );
  F_NumSOBuff.OrderID:=F_OrderID;
  F_NumSOBuff.LoadData;
  F_OrderFieldsStack.ID_FirstDepBrig := F_DepMgr.DepData.GetBrigIDFromFirstDep( F_OrderID );
  SetDepartureCount();
  SelectNext(ActiveControl, true, true);
end;

procedure Tfrm_Order.btn_DisconnectedClick(Sender: TObject);
var
  frm_Disconnections:Tfrm_DisconNew;//Tfrm_Disconnection;
  _IsReadOnly: boolean;
  _RegionID: integer;
  new:boolean;
   frm_Disconnections2:Tfrm_DisconNew2;
begin
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;

  _IsReadOnly:=(F_OrderType=otClose);
 {  Переходим на новую форму отключения}
  new:=false;
  if dset_tmp.Active then dset_tmp.close;
  MYOPeNIBDS(dset_tmp,'select id, isnew new from  DISCONNECTIONS where fk_id_order='+IntTOStr(F_OrderID));
  if  dset_tmp.IsEmpty then
   new:=true
  else
   if dset_tmp.FieldByName('new').AsInteger=1 then
    new:=true;
  if new then
  begin
     _RegionID := F_Order.mt_regions.FieldByName('ID').AsInteger;
    frm_Disconnections2 := Tfrm_DisconNew2.Create(nil, F_OrderID, _RegionID, _IsReadOnly);
    try

    frm_Disconnections2.OrderID := F_OrderID;
    frm_Disconnections2.RayonS := dbl_regions.Text;
    frm_Disconnections2.ReadOnlyFrm := ((F_OrderType=otClose) or F_IsReadOnly);
    frm_Disconnections2.ResultString := F_Disconnections;
    frm_Disconnections2.DateShift := F_ShiftDate;
    frm_Disconnections2.IDREgion:=F_order.mt_regions.fieldbyname('id').AsInteger ;
    frm_Disconnections2.ShowModal;
    if F_Disconnections <> frm_Disconnections2.ResultString then
    begin
      F_Disconnections := frm_Disconnections2.ResultString;
      if Length(F_Disconnections)>255 then
      begin
        F_Disconnections := Copy(F_Disconnections, 0, 255);
      end;
      TopCtrlChange(nil);
    end;
  finally
    frm_Disconnections2.Free();
  end;
  end
  else
  begin
  _RegionID := F_order.mt_regions.FieldByName('ID').AsInteger;
  frm_Disconnections := Tfrm_DisconNew.Create(nil, F_OrderID, _RegionID, _IsReadOnly);

  try
    frm_Disconnections.OrderID := F_OrderID;
    frm_Disconnections.RayonS := dbl_regions.Text;
    frm_Disconnections.ReadOnlyFrm := ((F_OrderType=otClose) or F_IsReadOnly);
    frm_Disconnections.ResultString := F_Disconnections;
    frm_Disconnections.DateShift := F_ShiftDate;
    frm_Disconnections.ShowModal;
    if F_Disconnections <> frm_Disconnections.ResultString then
    begin
      F_Disconnections := frm_Disconnections.ResultString;
      if Length(F_Disconnections)>255 then
      begin
        F_Disconnections := Copy(F_Disconnections, 0, 255);
      end;
      TopCtrlChange(nil);
    end;
  finally
    frm_Disconnections.Free();
  end;
  end;
  SetDisconnectedCount;
  SelectNext(ActiveControl, true, true);
end;

procedure Tfrm_Order.btn_EquipmentClick(Sender: TObject);
var
  frm_Equip: Tfrm_Equipment;
begin
  frm_Equip:=Tfrm_Equipment.Create(Application);
  try
    frm_Equip.ReadOnlyFrm:=((F_OrderType=otClose) or F_IsReadOnly);
    frm_Equip.RegionID:=F_order.mt_regions.FieldByName('ID').AsInteger;
    frm_Equip.OrderID:=F_OrderID;
    frm_Equip.ShowModal;

    if frm_Equip.IsChange then
      TopCtrlChange(nil);
  finally
    frm_Equip.Free;
  end;

  SelectNext(ActiveControl, true, true);
end;

procedure Tfrm_Order.ChangeBoltsActivity;
begin
  {MV 11.02.2013}
  if ((F_order.mt_messagetype.FieldByName('S_MT_CATEGORY_ID').AsInteger=4)
  or (F_order.mt_messagetype.FieldByName('ID').AsInteger<=0))
  and ((F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_PROFWORKS)
      or (F_order.mt_DamagePlace.FieldByName('ID').AsInteger= 25)
      or (F_order.mt_DamagePlace.FieldByName('ID').AsInteger =26)
      or (F_order.mt_DamagePlace.FieldByName('ID').AsInteger= 29)
      or (F_order.mt_DamagePlace.FieldByName('ID').AsInteger= 30)
      or (F_order.mt_DamagePlace.FieldByName('ID').AsInteger= 35))
  then
    btn_Bolts.Enabled:=false
  else
    btn_Bolts.Enabled:=true;
end;

procedure Tfrm_Order.ChangeDmgPlaceToProfWork;
var _id: integer;
begin
{сделано криво, т.к. влом мне сегодня мудрить со справочниками
  и возможностью в программе задавать соответствие между S_MESSAGETYPES и S_DamagePlace
  , так что будем надеяться, что больше не придётся добавлять таких сответсвий}
  _id := F_order.mt_messagetype.FieldByName('ID').AsInteger;
  case _id of
   3000 : if F_order.mt_DamagePlace.Locate('ID', ID_CL_KOLODEC, []) then
          dbl_DamagePlace.DisplayValue:=F_order.mt_DamagePlace.FieldByName('name').AsString;
   3024 : if F_order.mt_DamagePlace.Locate('ID', ID_CL_KOLONKA, []) then
          dbl_DamagePlace.DisplayValue:=F_order.mt_DamagePlace.FieldByName('name').AsString;
  else
        if F_order.mt_messagetype.FieldByName('S_MT_CATEGORY_ID').AsInteger=4 then
        begin
          if F_order.mt_DamagePlace.Locate('ID', ID_PROFWORKS, []) then
            dbl_DamagePlace.DisplayValue:=F_order.mt_DamagePlace.FieldByName('name').AsString;
        end
        else ResetDBL(dbl_DamagePlace);
  end;

end;

{  ID_CL_KOLONKA = 14; = 3024
  ID_CL_KOLODEC = 15; = 3000}

procedure Tfrm_Order.SetProcessStatus(const value: string);
begin
  if not F_IsReadOnly then
    sb_ProcessStaus.SimpleText:=value;
end;

procedure Tfrm_Order.ChangeHoodCountVisible;
begin
{
  if ( dset_DamagePlace.FieldByName( 'ID' ).AsInteger <> ID_LUK )
     and ( F_OrderType in [ otNew, otOpen ] ) then
    pnl_HoodCount.Visible := false
  else
    pnl_HoodCount.Visible := true;
}

  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger = ID_LUK then //Установка люков
    pnl_HoodCount.Visible:=true
  else
    pnl_HoodCount.Visible:=false;
end;

procedure Tfrm_Order.SetIsTopCtrlChange(value: boolean);
begin
  F_IsTopCtrlChange:=value;
  if value then
    SetProcessStatus('Изменения не сохранены')
  else
    SetProcessStatus('');
end;

procedure Tfrm_Order.SetIsBottomCtrlChange(value: boolean);
begin
  F_IsBottomCtrlChange:=value;
  if value then
    SetProcessStatus('Изменения не сохранены')
  else
    SetProcessStatus('');
end;

procedure Tfrm_Order.SetDisconnectedCount;
var
  dset: TIBDataSet;
begin
  F_DisconnectedCount:= 0;
  if F_OrderID > 0 then
  begin
    dset:= TIBDataSet.Create(nil);
    try
      dset.Transaction:=Tr_SelectData;
      dset.Transaction.StartTransaction;
      try
        MyOpenSQL(dset, Format(
          ' select count(*) kol'+
          ' from Disconnections'+
          ' where (FK_ID_ORDER=%d)'+
          ' and (FK_DISCON_BRIG_CONNECT=-1 or'+
          '     FK_DISCON_BRIG_CONNECT is null)', [F_OrderID]));
        F_DisconnectedCount:=dset.FieldByName('kol').AsInteger;
      finally
        dset.Transaction.Commit;
      end;
    finally
      dset.Free;
    end;
  end;
//////////////////////////////////////////
  if F_DisconnectedCount > 0 then
  begin
    // btn_Bolts.Caption:='Задвижка откл.';
     btn_Disconnected.Font.Color:=clBlue;
  end else
  begin
   //  btn_Bolts.Caption:='Задвижки';
     btn_Disconnected.Font.Color:=clWindowText;
  end;
end;

procedure Tfrm_Order.SetClosedBoltsCount;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*) kol'+
        ' from ClosedBolts'+
        ' where (fk_ClosedBolts_Orders=%d)'+
        ' and (fk_closedbolts_brigadieropen=-1 or'+
        '     fk_closedbolts_brigadieropen is null)', [F_OrderID]));
      F_ClosedBoltsCount:=dset.FieldByName('kol').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
//////////////////////////////////////////
  if F_ClosedBoltsCount>0 then
  begin
     btn_Bolts.Caption:='Задвижка откл.';
     btn_Bolts.Font.Color:=clBlue;
  end else
  begin
     btn_Bolts.Caption:='Задвижки';
     btn_Bolts.Font.Color:=clWindowText;
  end;
end;

procedure Tfrm_Order.SetOrderType;
var
  dset: TIBDataSet;
  dt: TDate;
  sh: integer;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format('select IsClosed, DateClosed, ShiftNumberClose from orders where id=%d',[F_OrderID]));
      if not(dset.Eof and dset.Bof) then
      begin
        case dset.FieldByName('IsClosed').AsInteger of
          0:
            begin
              F_OrderType:=otOpen;
            end;
          1:
            begin
              dt:=trunc(dset.FieldByName('DateClosed').AsDateTime);
              sh:=dset.FieldByName('ShiftNumberClose').AsInteger;
              if (sh=F_ShiftNumber) and ((dt=trunc(F_ShiftDate)) or (dt=trunc(F_ShiftDate)+1)) then
                F_OrderType:=otCloseInCurShift
              else
                F_OrderType:=otClose;
            end;
        else F_OrderType:=otNew;
        end;
      end else
        F_OrderType:=otNew;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order.SetSaveAction(value: TSaveAction);
begin
  F_SaveAction:=value;
  if value=saSave then
    btn_CloseOrder.Caption:='Закрыть наряд'
  else
    btn_CloseOrder.Caption:='Отм.закр.наряда';
end;

procedure Tfrm_Order.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_Order.CheckAdres;
var
  dset: TIBDataSet;
  frm: Tfrm_OrderShortInfo;
  HouseNumCond: string;
begin
  if F_order.mt_street.FieldByName('ID').AsInteger<>-1 then
  begin
    dset:= TIBDataSet.Create(nil);
    try
      dset.Transaction:=Tr_SelectData;
      dset.Transaction.StartTransaction;
      try
        case F_order.mt_housetype.FieldByName('ID').AsInteger of
          0: HouseNumCond:=' and (housenum='+QuotedStr(trim(ed_Housenum.Text))+')';
          1: HouseNumCond:=' and (housenum='+QuotedStr(F_order.mt_street2.FieldByName('ID').AsString)+')';
          else HouseNumCond:='';
        end;

        MyOpenSQL(dset,
          ' select OrderNumber, DateComing,' +
          ' (select orderworks from get_orderworks( o.id, 0, 1 )) WhatIsDone'+
          ' from orders o'+
          ' where (IsClosed=0)'+
          ' and (fk_orders_streets='+F_order.mt_street.FieldByName('ID').AsString+')'+
          ' and (fk_orders_housetypes='+F_order.mt_housetype.FieldByName('ID').AsString+')'+
          HouseNumCond);

        if not (dset.Eof and dset.Bof) then
        begin
          frm:=Tfrm_OrderShortInfo.Create(nil);
          try
            frm.OrderNumber:=dset.FieldByName('OrderNumber').AsInteger;
            frm.DateComing:=dset.FieldByName('DateComing').AsDateTime;
            frm.WhatIsDone:=dset.FieldByName('WhatIsDone').AsString;
            frm.ShowModal;
          finally
            frm.Free
          end;
        end;
      finally
        dset.Transaction.Commit;
      end;
    finally
      dset.Free;
    end;
  end;
end;

function Tfrm_Order.GetEquipWorkCount: integer;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*) kol'+
        ' from EquipWork'+
        ' where fk_eqwork_orders=%d', [F_OrderID]));

      Result:=dset.FieldByName('kol').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

function Tfrm_Order.GetNotConnectedCount: integer;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*) kol'+
        ' from Disconnections'+
        ' where fk_id_order=%d and (FK_DISCON_BRIG_CONNECT is null)'
        , [F_OrderID]));

      Result:=dset.FieldByName('kol').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;


procedure Tfrm_Order.SetLastExcWorkType;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset,Format(' select wt.workname, o.lastexcwrktype'+
        ' from orders o, s_excavationworktypes wt'+
        ' where o.id=%d'+
        ' and o.lastexcwrktype=wt.id', [F_OrderID]));

      if dset.FieldByName('WorkName').IsNull then
      begin
        F_LastExcWorkTypeID:=ID_NE_RASKOPANO;
        ed_LastExcWorkType.Text:='Не раскопано';;
      end else
      begin
        F_LastExcWorkTypeID:=dset.FieldByName('lastexcwrktype').AsInteger;
        ed_LastExcWorkType.Text:=dset.FieldByName('WorkName').AsString;
      end;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order.SetShiftNumberAndDate;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, 'select ShiftNumber, ShiftDate from ServantTable');
      F_ShiftNumber:=dset.FieldByName('ShiftNumber').AsInteger;
      F_ShiftDate:=dset.FieldByName('ShiftDate').AsDateTime;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order.btn_RestoreOpenStateClick(Sender: TObject);
begin
  if F_OrderType=otCloseInCurShift then
  begin
    if Application.MessageBox('Вы уверены в том, что хотите выпонить возврат?',
      gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if RestoreOpenState then
        InitOrder;
    end;
  end;
end;

function Tfrm_Order.RestoreOpenState: boolean;
begin
  Result:=false;

  SetProcessStatus('Выполнение возврата...');

  sql_Order.Transaction.StartTransaction;
  try
    MyExecSQL(sql_Order, BottomOrderFieldsQuery(faUpdateToNull));
    MyExecSQL(sql_Order, Format('update orders set IsClosed=0 where id=%d',[F_OrderID]));
    MyExecSQL(sql_Order, Format('delete from EquipWork where fk_eqwork_orders=%d',[F_OrderID]));
  except
    sql_order.Transaction.Rollback;
    SetProcessStatus('Ошибка при выполнении возврата');
    exit;
  end;
  sql_Order.Transaction.Commit;
  SetProcessStatus('Возврат выполнен');
  SetOrderType;
  Result:=true;
end;

procedure Tfrm_Order.btn_PrintClick(Sender: TObject);
var
  _scrPoint: TPoint;
begin
{
  if DM_AomComClient.IsMapWork then
  begin
    _scrPoint:=btn_Print.ClientToScreen(Point((btn_Print.Width div 2), (btn_Print.Height div 2)));
    pm_Print.Popup(_scrPoint.X, _scrPoint.Y);
  end else PrintOrder;
}

{
  if DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID then
    PrintOrder
  else
    PrintAom;
}

{  if ( DM_RightsManager.CurrentDistrictID <> CDP_DISTRICT_ID) or DM_AomComClient.IsMapWork then
    PrintAom
  else}
    PrintOrder;
end;

procedure Tfrm_Order.VisibleLeakCalc(Value: boolean);
begin
  pnl_LeakCalc.BevelOuter:=bvNone;
  pnl_LeakCalc.Visible:=Value;
  pnl_LocationDepth.BevelOuter:=bvNone;
  pnl_LocationDepth.Visible:=not Value;
end;

procedure Tfrm_Order.sp_LocationDepthMirrorChange(Sender: TObject);
begin
  sp_LocationDepth.Tag:=0;
  sp_LocationDepth.Value:=sp_LocationDepthMirror.Value;
end;

class function Tfrm_Order.GetGUID: string;
begin
  Result:=ORDERFORMGUID;
end;

procedure Tfrm_Order.VocFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FieldByName('Activity').IsNull then
    Accept:=true
  else
    Accept:=false;
end;

procedure Tfrm_Order.ShowDeletedRowInVoc(value: boolean);
var
  i: integer;
begin
{  for i:=low(F_VocDsetArr) to high(F_VocDsetArr) do
    F_VocDsetArr[i].Filtered:=not value;}
end;

procedure Tfrm_Order.InitVocDsetArr;
begin
//  F_VocDsetArr[1]:=dset_Officialopen;
//  F_VocDsetArr[1]:=dset_Regions;
//  F_VocDsetArr[3]:=dset_Street;
//  F_VocDsetArr[1]:=dset_HouseType;
//  F_VocDsetArr[1]:=dset_Street2;
//  F_VocDsetArr[1]:=dset_MessageType;
//  F_VocDsetArr[1]:=dset_DamageLocality;
//  F_VocDsetArr[1]:=dset_DamagePlace;
//  F_VocDsetArr[1]:=dset_ControlOrgs;
//  F_VocDsetArr[1]:=dset_TubeMaterial;
//  F_VocDsetArr[1]:=dset_TubeDiametr;
//  F_VocDsetArr[1]:=dset_OfficialClose;
//  F_VocDsetArr[1]:=dset_Soil;
//  F_VocDsetArr[1]:=dset_DamageType;
end;

function Tfrm_Order.GetPossibleOrderNumber: integer;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, 'select last_ordernum from get_last_ordernum');
      Result:=dset.FieldByName('last_ordernum').AsInteger+1;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order.ChangeDefaultAddInfoForFirstDep;
begin
  F_DefaultAddInfoForFirstDep := '';
  if F_order.mt_messagetype.FieldByName('S_MT_CATEGORY_ID').AsInteger=4 then
    F_DefaultAddInfoForFirstDep:=F_order.mt_messagetype.FieldByName('Name').AsString;
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_MAGISTRAL then
    F_DefaultAddInfoForFirstDep:='Течь из земли на магистрали d=';
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_PEREKLAD_SET then
    F_DefaultAddInfoForFirstDep:='Перекладка сетей водопровода d=';
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_VVOD then
    F_DefaultAddInfoForFirstDep:='Течь из земли на вводе d=';
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_KOLONKA then
    F_DefaultAddInfoForFirstDep:='Не работает колонка';
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_KOLODEC then
    F_DefaultAddInfoForFirstDep:='Течь из колодца на магистрали d=';
  if F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_CL_KOLONKA then
    F_DefaultAddInfoForFirstDep:='Отключить колонку до проведения санитарно-оздоровительных работ';
end;

function Tfrm_Order.Save: boolean;
begin
  if F_SaveAction=saClose then
  begin
    if F_OrderType=otNew then
    begin
      Result:=SaveOrder;
      if Result then
        Result:=CloseOrder;
    end else
    begin
      Result:=CloseOrder;
    end;
  end else Result:=SaveOrder;

end;

procedure Tfrm_Order.FormCreate(Sender: TObject);
begin
  F_Order := Tdm_Order.Create( nil );
 // F_062_spisok := 0;
  F_DepMgr := TNGDepManager.Create;
  F_NumSOBuff := Tdm_NumSOBuff.Create( nil );
  inherited;
  F_OrderFieldsStack.ID_FirstDepBrig := -1;
  F_IsCtrlChange := false;
  //
  InitVocDsetArr;
  OpenVocDataset;

  ResetForm;
  PrepareForAom;
  PrepareForDistrict;
  F_From1562:=false;
  F_Cansel:=false;
end;

function Tfrm_Order.GetDefaultEquipIDForExcavation: integer;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select FK_EQWORK_EQUIP id_equip'+
        ' from EquipWork'+
        ' where fk_eqwork_orders=%d', [F_OrderID]));

      if dset.FieldByName('id_equip').AsInteger>0 then
        Result:=dset.FieldByName('id_equip').AsInteger
      else
        Result:=-1;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
end;

function Tfrm_Order.GetLastOrderID(Transac: TIBTransaction): integer;
var
  dset: TIBDataSet;
begin
  dset:=TIBDataSet.Create(nil);
  try
    dset.Transaction:=Transac;
    MyOpenSQL(dset, 'select last_orderid from get_last_orderid');
    if dset.Eof and dset.Bof then
      Result:=-1
    else
      Result:=dset.FieldByName('last_orderid').AsInteger;
    dset.Close;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order.CheckFlowSpeed;
begin
  if sp_FlowSpeed.Value>9999 then
  begin
    Application.MessageBox('Скорость утечки не может превышать 9999 м3/ч',
      gc_strDispAVR, MB_OK+MB_ICONERROR);
    sp_FlowSpeed.SetFocus;
  end else
  begin
    if sp_FlowSpeed.Value>=100 then
      if Application.MessageBox('Вы уверены в правильности ввода скорости утечки?',
        gc_strDispAvr, MB_YESNO+MB_ICONQUESTION)<>ID_Yes then
        spewidthLot.SetFocus;
  end;
end;

procedure Tfrm_Order.btn_AvrOnMapClick(Sender: TObject);
begin
{  if F_OrderType<>otNew then
    DM_AomComClient.SendAvarInfoToAom(F_OrderID)
  else}
    Application.MessageBox('Прежде необходимо зарегистрировать наряд',
      gc_strDispAVR, MB_OK+MB_ICONINFORMATION);  
end;

procedure Tfrm_Order.PrepareForAom;
var
  _s: string;
begin
  btn_AvrOnMap.Visible:=false;//DM_AomComCLient.IsMapWork;
  pnl_AomInfo.Visible:=false;//DM_AomComClient.IsMapWork;
{  if DM_AomComClient.IsMapWork then
  begin
    DM_AomComClient.OnChangeTypeOfAvar:=OnChangeTypeOfAvar;
    DM_AomComClient.GetAomTypeOfAvarByOrderID(F_OrderID, F_AomTypeOfAvar, _s);
    lbl_AomInfo.Caption:=_s;
  end;}
end;

procedure Tfrm_Order.OnChangeTypeOfAvar(TypeOfAvarItemRec: TTypeOfAvarItemRec);
begin
  F_AomTypeOfAvar:=TypeOfAvarItemRec.TypeOfAvar;
//  lbl_AomInfo.Caption:=DM_AomComClient.ConvertTypeOfAvarToStr(TypeOfAvarItemRec.TypeOfAvar);
end;

procedure Tfrm_Order.PrintOrder;
var
  dm: Tdm_AddPrint;
begin
  dm:=Tdm_AddPrint.Create(nil);
  try
    dm.PrintOrder(F_OrderID);
  finally
    dm.Free;
  end;
end;

procedure Tfrm_Order.mi_PrintOrderClick(Sender: TObject);
begin
  PrintOrder;
end;

procedure Tfrm_Order.PrintAom;
var
  _IsNeedScrShots: boolean;
 
begin
  if F_OrderType=otNew then
  begin
    Application.MessageBox('Прежде необходимо зарегистрировать наряд',
      gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
    exit;
  end;

  _IsNeedScrShots := false;

  {if DM_AomComClient.IsMapWork then
  begin
    _IsNeedScrShots := true;

    if (F_AomTypeOfAvar=atoaNull) then
    begin
      Application.MessageBox('Заявка еще не размечалась. ' + #13#10 +
        'Для продолжения печати необходимо перейти в "Аварии на карте"' + #13#10 +
        'и сделать предварительную разметку этой аварии.',
        gc_strDispAVR, MB_OK or MB_ICONINFORMATION);
      exit;
    end;

    if F_AomTypeOfAvar = atoaBezAddr then
    begin
      if Application.MessageBox( 'Авария имеет тип "без адреса". Продолжить печать заявки без фрагмента карты?',
        'Диспетчер АВР', MB_YESNO or MB_ICONQUESTION) <> ID_YES then
        exit;
      _IsNeedScrShots := false;
    end;
  end;
 }
  {_AOMRep := TAvarOnMapReport.Create;
  try
    _AOMRep.OrderID := F_OrderID;
    _AOMRep.IsNeedScreenShots := _IsNeedScrShots;
    _AOMRep.Execute;
  finally
    _AOMRep.Free;
  end;}
end;

procedure Tfrm_Order.mi_PrintAomClick(Sender: TObject);
begin
  PrintAom;
end;

procedure Tfrm_Order.ResetForm;
begin
//  InitVocDsetArr;
//  OpenVocDataset;
  SetShiftNumberAndDate;
  SetOrderType;
  F_Order.SetDopFileterDL(ord(F_ordertype));
  InitOrder;
end;

procedure Tfrm_Order.btn_DepsClick(Sender: TObject);
var

  _IsReadOnly: boolean;
  _RegionID: integer;
begin
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;
  //
  //


                                
 // _IsReadOnly := ( F_OrderType = otClose );   {пока отключим}
 // _IsReadOnly := false;
  //_RegionID := F_Order.FieldByName( 'RegionID' ).AsInteger;
  _RegionID := F_order.mt_regions.FieldByName( 'id' ).AsInteger;

  F_DepMgr.DepData.OrderID := F_OrderID;
  F_DepMgr.DepData.CurShiftDate := F_ShiftDate;
  F_DepMgr.DepData.OrderDateComing := StrToDateTime( dp_Start.Text + ' ' + me_Start.Text );
  F_DepMgr.Execute( etREG, _IsReadOnly, _RegionID );
end;

procedure Tfrm_Order.btn_062Click(Sender: TObject);
var
//  _SOMgr: TSuborderManager;
 // _frmNG: TNumSONGForm;
  _frm: Tfrm_NumSO;
  _reg: integer;
begin
//NEED_MOD

  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;
{$IFDEF spisok1562}

 { _frmNG := TNumSONGForm.Create(nil);
  try
    _frmNG.OrderID :=  OrderID;

     _frmNG.Show1562;
    _frmNG.ShowModal;
  except
    on E:exception do
    begin
       _frmNG.free;
       raise Exception.Create( E.Message + 'Tfrm_Main.Show1562' );
    end;
  end;

{  _SOMgr := TSuborderManager.Create;
  try
    _SOMgr.OrderID := F_OrderID;
    _SOMgr.IsReadOnly := ( F_OrderType = otClose );

   // if dset_BrigClose.FieldByName('id').AsInteger <> -1 then
   //   _SOMgr.OrderFields.IDBrig := dset_BrigClose.FieldByName('id').AsInteger;
    if dset_OfficialClose.FieldByName('id').AsInteger <> -1 then
      _SOMgr.OrderFields.IDDisp := dset_OfficialClose.FieldByName('id').AsInteger;
    if dp_End.Date <> 0 then
      _SOMgr.OrderFields.DTTMEnd :=  StrToDateTime( DateToStr( dp_End.Date ) + ' ' +me_End.Text );
   // if dset_Street.FieldByName('id').AsInteger <> -1 then
   //   _SOMgr.OrderFields.IDStreet := dset_Street.FieldByName('id').AsInteger;
   // if ( dset_HouseType.FieldByName('id').AsInteger = 0 ) and (trim( ed_HouseNum.Text ) <> '' ) then
   //   _SOMgr.OrderFields.HouseNum := ed_HouseNum.Text;

    _SOMgr.AddFieldToGrid( 'NUM1562', '^ №'+#13+'наряда 1562', 0);
    _SOMgr.AddFieldToGrid( 'DATATIME', 'Дата'+#13+'поступления', 40);
    _SOMgr.AddFieldToGrid( 'Region', '^Район', -10);
//    _SOMgr.AddFieldToGrid( 'Adres', '^Адрес', 10);
    _SOMgr.AddFieldToGrid( 'street_name', '^Улица',30);
    _SOMgr.AddFieldToGrid( 'house', 'Дом', -10);
    _SOMgr.AddFieldToGrid( 'appartment', 'Квартира',10);
    _SOMgr.AddFieldToGrid( 'phone', 'Телефон',10);
    _SOMgr.AddFieldToGrid( 'PLACE', 'Место'+#13+'повреждения',0);
    _SOMgr.AddFieldToGrid( 'abonent', 'Абонент',50);
    _SOMgr.AddFieldToGrid( 'about', 'О чём заявлено',50);
    _SOMgr.AddFieldToGrid( 'works', 'Работы',50);
    _SOMgr.AddFieldToGrid( 'status', 'Статус',10);
    _SOMgr.AddFieldToGrid( 'ordernumber', '№ наряда',10);


    _SOMgr.ShowGridFrm;
  finally
    _SOMgr.Free;
  end;      }
{$endif}

  F_NumSOBuff.OrderID := F_OrderID;
  F_NumSOBuff.id_disp :=  g_IDOfficial;
  F_NumSOBuff.OrderClosed:=((F_OrderType=otClose) or (F_OrderType=otCloseInCurShift) );
  F_NumSOBuff.for_vds:=0;
  F_NumSOBuff.OrderNumber:=lbl_OrderNum.Caption;
  F_NumSOBuff.DateOrder:=f_order.mt_OrderDateComing.AsDateTime;
//{$IFNDEF spisok1562}
//  F_NumSOBuff.IsReadOnly := ( F_IsReadOnly);
  if not F_NumSOBuff.IsDataLoad then
    F_NumSOBuff.LoadData;
  F_NumSOBuff.SaveToStack;

  _frm := Tfrm_NumSO.Create( nil, F_NumSOBuff );
  try
     _reg := F_order.mt_regions.FieldByName('ID').AsInteger;
    _frm.RO := (F_IsReadOnly  or (not IsCurrentDistrictCanAccessRegion(_reg)) ) ;
    if _frm.ShowModal = mrOk then
      TopCtrlChange( nil )
    else
      F_NumSOBuff.LoadFromStack;
  finally
    _frm.Free;
  end;
// {$endif}


{  _RM := TNGReportManager.Create;
  try
    _rm.ShowReportFromOrder(rnSearch1562);
  finally
    _RM.Free;
  end;
 }
  SelectNext(ActiveControl, true, true);
end;

procedure Tfrm_Order.sb_DateComingTopClick(Sender: TObject);
begin
  dp_Start.Date := F_ShiftDate + 1;
end;

procedure Tfrm_Order.sb_DateComingBottomClick(Sender: TObject);
begin
  dp_Start.Date := F_ShiftDate;
end;

procedure Tfrm_Order.FormDestroy(Sender: TObject);
begin
  inherited;
  F_Order.Free;
  F_DepMgr.Free;
  F_NumSOBuff.Free;
end;

procedure Tfrm_Order.PrepareForDistrict;
var
  _IsCDP: boolean;
begin
  _IsCDP := ( DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID );
  btn_WhatDone.Visible := _IsCDP;
  btn_Deps.Visible := not _IsCDP; 
end;

procedure Tfrm_Order.SaveNumSOBuff;
begin
  F_NumSOBuff.OrderID := F_OrderID;
  F_NumSOBuff.OrderNumber:=lbl_OrderNum.Caption;
  F_NumSOBuff.DateOrder:=f_order.mt_OrderDateComing.AsDateTime;
  F_NumSOBuff.SaveData;
  F_NumSOBuff.ResetBuff;
end;

procedure Tfrm_Order.bt_NaledClick(Sender: TObject);
 var _frm : Tfrm_Naled;
     _reg: integer;
begin
//

  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;


   _frm := Tfrm_Naled.Create(nil);
   try
     //
   _reg := F_order.mt_regions.FieldByName('ID').AsInteger;
   _frm.isReadOnly := ({(F_OrderType=otClose) or }(not IsCurrentUserCanEdit)
                          or (not IsCurrentDistrictCanAccessRegion(_reg)));
     _frm.OrderID := F_OrderID;

      _frm.OpenDTTM :=  dp_Start.Date + StrToTime(me_Start.Text);
    if _frm.ShowModal = mrOk then
      TopCtrlChange( nil )
   finally
   _frm.Free;
   end;
end;

function Tfrm_Order.check_asf: boolean;
var
 _res: boolean;
 _sql: string;
begin
    //
 _res := false;



      if  dset_tmp.Active then  dset_tmp.Close;

      _sql := 'select max(e.square) msquare from excavations e ' +
        ' where (e.fk_excavations_orders = '+ IntToStr( F_OrderID ) +') ' +
        ' and ( fk_excavations_excwt = 5 )';

       dset_tmp.SelectSQL.Clear;
       dset_tmp.SelectSQL.Add(_sql);
       dset_tmp.Open;
       F_sqasf_exc:=dset_tmp.fieldbyname('msquare').asfloat;
     if (F_order.mt_DamageLocality.FieldByName('ID').AsInteger in [1,2,6,7,10]) then
       if (dset_tmp.Eof) or (dset_tmp.FieldByName('msquare').AsInteger = 0)
        then _res := true;
       dset_tmp.Close;
    

  Result := _res;
end;


function  Tfrm_Order.check_works:boolean;
var _sql:string;
begin
result:=true;

      if  dset_tmp.Active then  dset_tmp.Close;
      _sql:='select sw.id_workkind,sum(dw.square_asf) sum_asf,sum(dw.exc_length) sum_length from departureworks dw '+
           ' left join s_works sw on sw.id=dw.fk_depworks_work '+
           '  where dw.fk_depworks_order= '+IntToStr( F_OrderID )+
           '  and sw.id_workkind=1'+
           ' group by 1';
       dset_tmp.SelectSQL.Clear;
       dset_tmp.SelectSQL.Add(_sql);
       dset_tmp.Open;
       result:=true;
       if not dset_tmp.Eof then
        begin
          dset_tmp.First;
          F_sqw_asf_works:=dset_tmp.fieldbyname('sum_asf').AsFloat;

          if (F_order.mt_DamageLocality.FieldByName('ID').AsInteger in [1,2,6,7,10]) then
            while not dset_tmp.Eof do
           begin
           if (dset_tmp.fieldbyname('sum_asf').AsFloat=0 )and
              (dset_tmp.fieldbyname('sum_length').AsFloat>0) then
              begin
               result:=false;
              end;
           dset_tmp.Next;
           end;

        end;

end;

function Tfrm_Order.F_is_closed :boolean; //23.01.2012 Glasha
  begin
   if  (F_OrderType=otClose)or(F_OrderType=otCloseInCurShift) then
     result:=true
    else
     result:=false;
  end;



procedure Tfrm_Order.SetDamagePlace_Filter;
var id_d:integer;
DateComing:TDateTime;
t:TTime;
td:TDateTime;
begin
id_d:=F_order.mt_DamagePlace.FieldByName('ID').AsInteger;
DateComing:=dp_Start.Date+StrToTime(me_Start.Text);
t:=StrToTime('5:00');
td:=now();
if (F_OrderType=OtOpen) and
(not ((DateComing>F_ShiftDate+StrToTime('8:00'))and(DateComing<F_ShiftDate+1+StrToTime('5:45'))
       and
       (Now()<F_ShiftDate+1+StrToTime('5:45') )
     )) then
if ((F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_MAGISTRAL ) or
     (F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_VVOD) or
     (F_order.mt_DamagePlace.FieldByName('ID').AsInteger=ID_PODTOPTEPLSET) )
      then
begin
 F_order.mt_DamagePlace.Filter:='id=1 or id=2 or id='+IntToStr(ID_PODTOPTEPLSET);
 F_order.mt_DamagePlace.Filtered:=true;
 FixDBLValue(id_d, dbl_Damageplace); //Место повреждения
end
else
begin
 F_order.mt_DamagePlace.Filter:='id<>1 and id<>2 and id<>'+IntToStr(ID_PODTOPTEPLSET);
 F_order.mt_DamagePlace.Filtered:=true;
 FixDBLValue(id_d, dbl_Damageplace); //Место повреждения
end;

end;

function  Tfrm_Order.is_canClosewithoutexcav:boolean;
var id:integer;
begin
 if not (F_order.mt_Damageplace.FieldByName('id').AsInteger in [ID_MAGISTRAL, ID_VVOD,ID_PODTOPTEPLSET ]) then
   begin
    result:=false;
    exit;
   end;
 result:=true;
 MyOpenIbds(dset_tmp,Format('select count(*) from excavations e '+
                        ' where e.fk_excavations_orders=%d',[F_orderID]));
 dset_tmp.First;
 if dset_tmp.Fields[0].AsInteger>0 then
     begin
      result:=false;

      exit;
     end;
 MyOpenIbds(dset_tmp,Format('select count(*) from departureworks dw  '+
                             ' where dw.fk_depworks_order=%d '+
                             ' and  dw.fk_depworks_work=1',[F_orderID]));
 dset_tmp.first;
 if dset_tmp.Fields[0].AsInteger>0 then
   begin
    result:=false;
    exit;
   end;

end;
procedure Tfrm_Order.btn_floodingClick(Sender: TObject);
var frm_Flood: Tfrm_Flooding;
begin
  inherited;
  if F_OrderType = otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if not SaveOrder then exit;
    end else
    begin
      SelectNext(ActiveControl, true, true);
      exit;
    end;
  end;
  
   frm_Flood:=Tfrm_Flooding.Create(self);
   frm_Flood.Order_Id:=F_orderID;
   frm_Flood.PreadOnly:=((F_OrderType=otClose) or F_IsReadOnly);
   frm_Flood.ShowModal;
   frm_Flood.Free;
end;

function Tfrm_Order.GetListNumsordersForExcav:string; //получаем список заявок для раскопок
begin
if (F_NumSOBuff<>nil) then
 //if F_is_closed then
    result:=F_NumSOBuff.GetForExcavform()
  else
    result:='';
end;

function   Tfrm_Order.PostKap(listNumber:string):boolean;
var frmQuestion:Tfrm_QCansel;
begin
result:=false;
 if listNumber<>'' then
 begin
   frmQuestion:=Tfrm_QCansel.Create(self);
   frmQuestion.PreaPare('Закрытие заявок кап-ремонт','Вернули заявки из кап-ремонта?'+#13+listNumber,'Да','Нет',1,false);
   if  frmQuestion.ShowModal=mrYes then
     result:=F_NumSOBuff.SetStateKap(1) //made вернули
   else
     begin
      frmQuestion.PreaPare('Закрытие заявок кап-ремонт','Отложить возврт из кап-ремонта?'+#13+listNumber,'Да','Нет',1,false);
      if  frmQuestion.ShowModal=mrYes then
       result:=F_NumSOBuff.SetStateKap(3) //will make
      else
       result:=F_NumSOBuff.SetStateKap(4) // not make

     end

 end

end;


procedure Tfrm_Order.btn_imagesClick(Sender: TObject);
var   frm_picters: Tfrm_picters;
begin
  inherited;
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    if not SaveOrder then exit;
  end;     

  try
     frm_picters:= Tfrm_picters.Create(self);
     try
       frm_picters.Order_id:=F_OrderID;
       frm_picters.OrderNumber:=StrToInt( lbl_OrderNum.Caption);
       frm_picters.Year:=GetYear(dp_Start.Date);
       frm_picters._ReadOnly:=F_IsReadOnly;

       frm_picters.ShowModal;
     finally
       frm_picters.Free;
     end;
  except on e:exception do
   Application.MessageBox('Изображения ошибка!',gc_strDispAVR,MB_OK+MB_ICONERROR);

  end;
end;

 procedure Tfrm_Order.SetDepartureCount();
 var
  dset: TIBDataSet;
begin
  F_DeparturesCount:= 0;
  if F_OrderID > 0 then
  begin
    dset:= TIBDataSet.Create(nil);
    try
      dset.Transaction:=Tr_SelectData;
      dset.Transaction.StartTransaction;
      try
        MyOpenSQL(dset, Format(
          ' select count(*) kol'+
          ' from departures '+
          ' where (fk_departures_orders=%d)', [F_OrderID]));
        F_DeparturesCount:=dset.FieldByName('kol').AsInteger;
      finally
        dset.Transaction.Commit;
      end;
    finally
      dset.Free;
    end;
  end;



 end;

end.



