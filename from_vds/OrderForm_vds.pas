unit OrderForm_vds;
{$define Cansel}
{$define closeoch}
{$define sent_tel_toOch}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin,
  DBCtrls,DB, Mask, Menus, Spin, RXSpin,
  ToolEdit, RxLookup, RxDBComb, ImgList, IBCustomDataSet, DModule,
  IBDatabase, IBSQL, Math, SecurityBaseForm,{NumSONGUnit,}NumSOForm,NumSOBuffDModule,  CanselForm,
  WorkSQL,OrderVdsDModule,Closed1562Manager;

const
  ID_ABONENT=1;
  ADR_TAG=123;

type
  TFixAction = (faInsert, faUpdate, faDelete, faUpdateToNull);

  TSaveAction = (saSave, saClose);

  TOrderType = (otNew, otOpen, otClose, otCloseInCurShift);

  TDepartureType = (dtTop, dtBottom);


  TProcessState= (psInit, psWork);

  Tfrm_Order_vds = class(Tfrm_SecurityBase)
    Label11: TLabel;
    btn_NewOrder: TBitBtn;
    btn_SaveOrderData: TBitBtn;
    btn_CloseOrder: TBitBtn;
    ds_tubediameter: TDataSource;
    ds_contorlOrgs: TDataSource;
    ds_messagetype: TDataSource;
    ds_street: TDataSource;
    ds_regions: TDataSource;
    ds_officialopen: TDataSource;
    ds_officialclose: TDataSource;
    gb_Bottom: TGroupBox;
    dbl_TubeDiameter: TRxDBLookupCombo;
    dbl_LastOfficial: TRxDBLookupCombo;
    btn_Exit: TBitBtn;
    Label34: TLabel;
    Label35: TLabel;
    dp_End: TDateEdit;
    Label39: TLabel;
    Label40: TLabel;
    ds_damagetype: TDataSource;
    gb_Top: TGroupBox;
    Label4: TLabel;
    Label15: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dp_Start: TDateEdit;
    dbl_ControlOrgs: TRxDBLookupCombo;
    dbl_MessageType: TRxDBLookupCombo;
    dbl_Regions: TRxDBLookupCombo;
    dbl_FirstOfficial: TRxDBLookupCombo;
    dset_Regions: TIBDataSet;
    Tr_Voc: TIBTransaction;
    sql_Order: TIBSQL;
    dset_TopOrderFields: TIBDataSet;
    dset_BottomOrderFields: TIBDataSet;
    Tr_ModifyData: TIBTransaction;
    Tr_SelectData: TIBTransaction;
    sb_ProcessStaus: TStatusBar;
    me_Start: TMaskEdit;
    me_End: TMaskEdit;
    btn_RestoreOpenState: TBitBtn;
    btn_Print: TBitBtn;
    Label20: TLabel;
    dbl_Street: TRxDBLookupCombo;
    lbl_Housenum: TLabel;
    ed_Housenum: TEdit;
    Panel1: TPanel;
    Label30: TLabel;
    st_OrderNum: TStaticText;
    st_District: TStaticText;
    lbl_Closure: TLabel;
    gb_btns: TGroupBox;
    btn_Disconnected: TBitBtn;
    btn_Departures: TBitBtn;
    ds_Applicant: TDataSource;
    gb_Applicant: TGroupBox;
    dbl_Applicant: TRxDBLookupCombo;
    Label3: TLabel;
    ed_ApplicantFio: TEdit;
    ed_ApplicantPhone: TEdit;
    Label5: TLabel;
    ed_HousingNum: TEdit;
    ed_FloorNum: TEdit;
    ed_ApartmentNum: TEdit;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ds_brigadiers: TDataSource;
    ed_PorchNum: TEdit;
    Label10: TLabel;
    dbl_Brigadiers: TRxDBLookupCombo;
    lbl_Brigadiers: TLabel;
    lbl_DamageType: TLabel;
    dbl_DamageType: TRxDBLookupCombo;
    mem_AdditionalInfo: TMemo;
    Label27: TLabel;
    ed_PorchKod: TEdit;
    Label2: TLabel;
    st_from: TStaticText;
    BitBtn1: TBitBtn;
    dset_cansel: TIBDataSet;
    bt_cansel_inf: TButton;
    btn_RegionWork: TBitBtn;
    pnl_regionWork: TPanel;
    me_startwork: TMaskEdit;
    me_endwork: TMaskEdit;
    lbl_work: TLabel;
    lbl_User: TLabel;
    lbl_endwork: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VocFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_CloseOrderClick(Sender: TObject);
    procedure TopCtrlChange(Sender: TObject);
    procedure BottomCtrlChange(Sender: TObject);
    procedure EntryEnter(Sender: TObject);
    procedure EntryExit(Sender: TObject);
    procedure btn_NewOrderClick(Sender: TObject);
    procedure btn_SaveOrderDataClick(Sender: TObject);
    procedure btn_DisconnectedClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_RestoreOpenStateClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_DeparturesClick(Sender: TObject);
    procedure dp_StartChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function F_is_closed :boolean;
    procedure bt_cansel_infClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_RegionWorkClick(Sender: TObject);
  protected
    class function GetGUID: string; override;
  private
    F_OrderID: integer;

    F_OpenDepCount: integer;
    F_OpenDisconCount: integer;
    F_ShiftNumber: integer;
    F_ShiftDate: TDate;
    F_OrderType: TOrderType;
    F_IsTopCtrlChange: boolean;
    F_IsBottomCtrlChange: boolean;
    F_SaveAction: TSaveAction;
    F_ProcessState: TProcessState;
    F_IsReadOnly: boolean;
    F_NumSOBuff: Tdm_NumSOBuff; //1562
    F_DepsInfo:string;
    F_DepBrig:integer;
    F_NUM1562:integer; //это должно передавться если форма наряда создается из Order1562 если модуль запускается из Order1562 09.12.2011
    F_cansel:boolean; //true- если наряд закрыт отказом
    F_Work_sent:integer;
    frm_cansel:Tfrm_cansel1562;// форма для отказа наряда

    F_order:Tdm_order_vds;
    function SetDepCount:integer;
    procedure LoadTopFieldsValue; //Заполняет верхние поля формы
    procedure LoadBottomFieldsValue;  //Заполняет нижние поля формы
    procedure InitOrder;  //Инициализирует наряд
    function SaveOrder: boolean;
    function CloseOrder: boolean;
    function RestoreOpenState: boolean;
    procedure OpenVocDataset;  //Открываем наборы данных справочников
    function GetMaxOrderID(Transac: TIBTransaction): integer;  //Возвращает максимальный ID в таблице Order
    procedure EnableTopCtrls(value: boolean);
    procedure EnableBottomCtrls(value: boolean);
    procedure ResetTopCtrls;   //Сброс полей верхней части формы
    procedure ResetBottomCtrls;   //Сброс полей нижней части формы
    function IsTopDateCorrect: boolean;  //Проверяет правильность дат верхней части формы
    function IsBottomDateCorrect: boolean; //Проверяет правильность дат нижней части формы
    function IsTopDataFieldsCorrect: boolean; //Проверяет правильность заполнения полей верхней части формы
    function IsBottomDataFieldsCorrect: boolean;  //Проверяет правильность заполнения полей нижней части формы
    function IsAdresCorrect: boolean; //Проверяет был ли уже зарегистрирован наряд с таким адресом
    procedure SetShiftNumberAndDate;
    procedure SetProcessStatus(const value: string);
    procedure SetIsTopCtrlChange(value: boolean);
    procedure SetIsBottomCtrlChange(value: boolean);
    procedure SetOrderType;
    procedure SetSaveAction(value: TSaveAction);
    function TopOrderFieldsQuery(FixAction: TFixAction): string;
    function BottomOrderFieldsQuery(FixAction: TFixAction): string;
    procedure SetOpenDepCount;
    procedure SetOpenDisconCount;
    procedure ShowDeletedRowInVoc(value: boolean);
    procedure EnableAllCtrls( value: boolean );
    procedure SaveNumSOBuff;
    function Is_LastDep_correcr():boolean ;//проверка последнего віезда для заявок
    procedure ClearBottomCtrls(); ////Очистка полей нижней части формы


    procedure SetWorRegion();
    
    function SetCloseWorks():boolean;//выставляем по закрытию наряда дату закрытия работ
  public
    F_OrderRegionID: integer;
    property OrderID: integer read F_OrderID;
    property NUM1562:integer write F_NUM1562;
    constructor Create(AOwner: TComponent; const OrderID: integer); overload;
    constructor Create(AOwner: TComponent); overload;
  end;



implementation

uses WarningForm, GlobalData,
  HelpFunctions, HelpClasses, OrderNumberForm, OrderShortInfoForm,
  AddPrintDModule, DeparturesForm_vds, DisconForm_vds, GridViewBuilder, AliGrid,
  AppGUIDS, StringConsts, shiftnumform, RightsManagerDModule, QCanselForm, WorksRegionForm;
{$R *.dfm}

var
  OldColor: TColor;


procedure Tfrm_Order_vds.FormShow(Sender: TObject);
begin
  //OpenVocDataset;
  st_from.Caption:='ВДС';
 // InitOrder;
end;

procedure Tfrm_Order_vds.FormClose(Sender: TObject; var Action: TCloseAction);
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

  Action:=caFree;

  if Tr_Voc.InTransaction then
    Tr_Voc.Commit;

  if Tr_SelectData.InTransaction then
    Tr_SelectData.Rollback;

  if Tr_ModifyData.InTransaction then
    Tr_ModifyData.Rollback;
end;


procedure Tfrm_Order_vds.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Order_vds.btn_CloseOrderClick(Sender: TObject);
 var _062_list:string;

begin
 if  (F_NUM1562>0) then begin
  application.MessageBox('Нужно сохранить связь наряда с заявкой', gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
  exit;
 end;

  if not ((F_OrderType in [otClose, otCloseInCurShift])and (F_NUM1562>0)) then
  begin

    if F_SaveAction=saSave then
    begin
    
      SetSaveAction(saClose);
      EnableBottomCtrls(true);
      ResetBottomCtrls;
      SetIsBottomCtrlChange(true);
    end else
    begin
      SetSaveAction(saSave);
      EnableBottomCtrls(false);
      SetIsBottomCtrlChange(false);
      ClearBottomCtrls;
    end;
  end;
end;


procedure Tfrm_Order_vds.TopCtrlChange(Sender: TObject);
begin
  if F_ProcessState=psWork then
  begin
    {
    if (Sender is TRxDBLookupCombo) then
    begin
    end else
    if (Sender is TRxSpinEdit) then
    begin
    end;
    }

    SetIsTopCtrlChange(true);
    btn_SaveOrderData.Enabled:=true;
  end;
end;

procedure Tfrm_Order_vds.EntryEnter(Sender: TObject);
const
  NEXT_POLE=' и нажмите кл. Tab для перехода к следующему полю';
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
end;

procedure Tfrm_Order_vds.EntryExit(Sender: TObject);
begin

  if Sender is TRXDBLookupCombo then
    (Sender as TRXDBLookupCombo).color := OldColor else
  if Sender is TEdit then
    (Sender as TEdit).Color :=  OldColor else
  if Sender is TRxSpinEdit then
     (Sender as TRxSpinEdit).Color :=  OldColor else
  if Sender is TComboBox then
     (Sender as TComboBox).Color :=  OldColor else
  if Sender is TMaskEdit then
  begin
    if (Sender as TMaskEdit).Visible then
     begin
      (sender as TMaskEdit).Color := OldColor;
      if (sender as TMaskEdit).Tag=22222 then  //me_End
       if  (btn_SaveOrderData as TButton).Enabled then
        ActiveControl:=btn_SaveOrderData;
     end   
  end else
  if Sender is TDateEdit then
    (sender as TDAteEdit).Color := OldColor;

  SetProcessStatus('');
end;


procedure Tfrm_Order_vds.btn_NewOrderClick(Sender: TObject);
begin
  if (F_OrderType<>otClose) and (F_IsTopCtrlChange or F_IsBottomCtrlChange) then
  begin
    case ShowWarningDlg of
      raSave:
        begin
          if not SaveOrder then exit;
        end;
      raNoSave:
        begin
        end;
      raReturn:
        begin
          exit;
        end;
    end; //end case
  end;

  if Tr_Voc.InTransaction then
    Tr_Voc.Commit;

  F_OrderID:=-1;
  OpenVocDataset;
  InitOrder;

end;


constructor Tfrm_Order_vds.Create(AOwner: TComponent; const OrderID: integer);
begin

  F_OrderID:=OrderID;
  F_NUM1562:=-1;
  inherited Create(AOwner);

end;

constructor Tfrm_Order_vds.Create(AOwner: TComponent);
begin
  Create(AOwner, -1);
end;


procedure Tfrm_Order_vds.OpenVocDataset;
begin
  F_order.OpenVocs;
  if Tr_Voc.InTransaction then
    Tr_Voc.Rollback;
  Tr_Voc.StartTransaction;

//  dset_Officialopen.Open;
  dset_Regions.ParamByName('id_district').AsInteger := 1;
  dset_Regions.Open;
//  dset_Street.Open;
//  dset_MessageType.Open;
//  dset_ControlOrgs.Open;
//  dset_TubeDiametr.Open;
//  dset_OfficialClose.Open;
//  dset_DamageType.Open;
//  dset_Applicant.Open;
//  dset_Brigadiers.Open;
end;

procedure Tfrm_Order_vds.EnableTopCtrls(value: boolean);
var
  i: integer;
begin
  dbl_FirstOfficial.Enabled:=false;

  dp_Start.Enabled:=value;
  me_Start.Enabled:=value;
  dbl_Regions.Enabled:=value;
  dbl_Street.Enabled:=value;
  dbl_Brigadiers.Enabled:=value;
  ed_Housenum.Enabled:=value;
  ed_HousingNum.Enabled:=value;
  ed_PorchNum.Enabled:=value;
  ed_FloorNum.Enabled:=value;
  ed_ApartmentNum.Enabled:=value;
  ed_PorchKod.Enabled:=value;
  dbl_MessageType.Enabled:=value;
  dbl_ControlOrgs.Enabled:=value;
  dbl_Applicant.Enabled:=value;
  ed_ApplicantFio.Enabled:=value;
  ed_ApplicantPhone.Enabled:=value;
  dbl_DamageType.Enabled:=value;
  mem_AdditionalInfo.ReadOnly:= not value;

  lbl_Brigadiers.Enabled:=value;
  lbl_DamageTYpe.Enabled:=value;
  for i:=0 to gb_Top.ControlCount-1 do
    if (gb_Top.Controls[i] is TLabel) then
      (gb_Top.Controls[i] as TLabel).Enabled:=value;

  for i:=0 to gb_Applicant.ControlCount-1 do
    if (gb_Applicant.Controls[i] is TLabel) then
      (gb_Applicant.Controls[i] as TLabel).Enabled:=value;
end;

procedure Tfrm_Order_vds.EnableBottomCtrls(value: boolean);
var
  i: integer;
begin
  dbl_LastOfficial.Enabled:=false;

  dbl_TubeDiameter.Enabled:=value;
 // dp_End.Enabled:=false; //glasha 31.05.2012
//  me_End.Enabled:=false;

  for i:=0 to gb_Bottom.ControlCount-1 do
    if (gb_Bottom.Controls[i] is TLabel) then
      (gb_Bottom.Controls[i] as TLabel).Enabled:=value;
end;

procedure Tfrm_Order_vds.ResetTopCtrls;
var
  TekDateTime: TDateTime;
  _filter: string;
  _count: integer;
begin
  TekDateTime:=Now;

  dp_Start.Date:=TekDateTime;
  me_Start.Text:=FormatDateTime('hh:mm', TekDateTime);

  st_OrderNum.Caption:='';
  st_District.Caption:='';
  //ResetDBL(dbl_FirstOfficial);
  FixDBLValue(g_IDOfficial, dbl_FirstOfficial);

  {Выставляем район}
 {_filter := 'ID > 0 ';
 _count := 0;
 dset_Regions.First;
 while not dset_Regions.Eof do
   begin
    if IsCurrentDistrictHasAccesToRegion(dset_Regions.FieldByName('ID').AsInteger)
     then
       begin
       _filter := _filter + ' and ID='+ dset_Regions.FieldByName('ID').AsString;
       inc(_count);
       end;
    dset_Regions.Next;
   end;
  dbl_Regions.DropDownCount := _count;
  dset_Regions.Filter := _filter;
  dset_Regions.Filtered := true;


  dset_Regions.Last;

  if dset_Regions.RecordCount=2 then
    dbl_Regions.DisplayValue:=dset_Regions.FieldByName('name').AsString
  else}
    ResetDBL(dbl_Regions);
  {  }
  {Выставляем район}

  ResetDBL(dbl_Street);
  ResetDBL(dbl_DamageType);
  ResetDBL(dbl_Brigadiers);
  ed_HouseNum.Text:='';
  ed_HousingNum.Text:='';
  ed_PorchNum.Text:='';
  ed_FloorNum.Text:='';
  ed_ApartmentNum.Text:='';
  ed_PorchKod.Text:='';
  ResetDBL(dbl_MessageType);
  ResetDBL(dbl_ControlOrgs);
  //ResetDBL(dbl_Applicant);
  FixDBLValue(ID_ABONENT, dbl_Applicant);
  ed_ApplicantFio.Text:='';
  ed_ApplicantPhone.Text:='';
  mem_AdditionalInfo.Text:='';
end;

procedure Tfrm_Order_vds.ResetBottomCtrls;
var
  TekDateTime: TDateTime;
begin
  TekDateTime:=Now;
  dp_End.Date:=TekDateTime;
  me_End.Text:=FormatDateTime('hh:mm', TekDateTime);

  FixDBLValue(g_IDOfficial, dbl_LastOfficial);
  ResetDBL(dbl_TubeDiameter);
end;

function Tfrm_Order_vds.IsTopDateCorrect: boolean;
var
  StartDate: string;
begin
  Result:=false;

  StartDate:=dp_Start.Text+' '+me_Start.Text;

  if not IsDateCorrect(StartDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты поступления',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if IsDateLess(DateTimeToStr(Now), StartDate) then
  begin
    Application.MessageBox('Дата поступления не может быть больше текущей',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  Result:=true;
end;

function Tfrm_Order_vds.IsBottomDateCorrect: boolean;
var
  StartDate, EndDate: string;
begin
  Result:=false;

  StartDate:=dp_Start.Text+' '+me_Start.Text;
  EndDate:=dp_End.Text+' '+me_End.Text;

  if not IsDateCorrect(EndDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты закрытия наряда',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;


  if IsDateLess(DateTimeToStr(Now), EndDate) then
  begin
    Application.MessageBox('Дата закрытия заявки не может быть больше текущей',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if IsDateLess(EndDate, StartDate) then
  begin
    Application.MessageBox('Дата закрытия заявки не может быть меньше даты поступления',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;


  Result:=true;
end;


function Tfrm_Order_vds.IsTopDataFieldsCorrect: boolean;
begin
  Result:=false;

  {
  if IsDBLEmpty(dbl_FirstOfficial) then
  begin
    ActiveControl:=dbl_FirstOfficial;
    SetProcessStatus('Введите диспетчера, принявшего заявку');
    exit;
  end;
  }

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

  if IsDBLEmpty(dbl_MessageType) then
  begin
    ActiveControl:=dbl_MessageType;
    SetProcessStatus('Введите о чем заявлено');
    exit;
  end;


  if trim(ed_Housenum.Text)='' then
  begin
    ActiveControl:=ed_Housenum;
    SetProcessStatus('Введите номер дома');
    exit;
  end;
{
  if trim(ed_HousingNum.Text)='' then
  begin
    ActiveControl:=ed_HousingNum;
    SetProcessStatus('Введите корпус');
    exit;
  end;
}
{
  if trim(ed_FloorNum.Text)='' then
  begin
    ActiveControl:=ed_FloorNum;
    SetProcessStatus('Введите этаж');
    exit;
  end;
}
{
  if trim(ed_ApartmentNum.Text)='' then
  begin
    ActiveControl:=ed_ApartmentNum;
    SetProcessStatus('Введите номер квартиры');
    exit;
  end;
}
{
  if IsDBLEmpty(dbl_Applicant) then
  begin
    ActiveControl:=dbl_Applicant;
    SetProcessStatus('Введите заявителя');
    exit;
  end;
}
{
  if trim(ed_ApplicantName.Text)='' then
  begin
    ActiveControl:=ed_ApplicantName;
    SetProcessStatus('Введите наименование заявителя');
    exit;
  end;
}
{
  if trim(ed_ApplicantFio.Text)='' then
  begin
    ActiveControl:=ed_ApplicantFio;
    SetProcessStatus('Введите фамилию заявителя');
    exit;
  end;
}
{
  if trim(ed_ApplicantPhone.Text)='' then
  begin
    ActiveControl:=ed_ApplicantPhone;
    SetProcessStatus('Введите телефон заявителя');
    exit;
  end;
}

 { if not IsAdresCorrect then
  begin
    ActiveControl:=dbl_Street;
    SetProcessStatus('Введите другой адрес');
    exit;
  end;}

  Result:=true;
end;

function Tfrm_Order_vds.IsBottomDataFieldsCorrect: boolean;
var
  val_int: integer;
begin
  Result:=false;
{
  if IsDBLEmpty(dbl_LastOfficial) then
  begin
    ActiveControl:=dbl_LastOfficial;
    SetProcessStatus('Введите диспетчера, закрывшего наряд');
    exit;
  end;
}
{
  if IsDBLEmpty(dbl_TubeDiameter) then
  begin
    ActiveControl:=dbl_TubeDiameter;
    SetProcessStatus('Введите диаметр трубы');
    exit;
  end;
}

  if F_OpenDepCount>0 then
  begin
    ActiveControl:=btn_Departures;
    SetProcessStatus('У заявки имеются незакрытые выезды');
    exit;
  end;

  if F_OpenDisconCount>0 then
  begin
    ActiveControl:=btn_Disconnected;
    SetProcessStatus('У заявки имеются незакрытые отключения');
    exit;
  end;



  Result:=true;
end;


function Tfrm_Order_vds.GetMaxOrderID(Transac: TIBTransaction): integer;
var
  dset: TIBDataSet;
begin
  dset:=TIBDataSet.Create(nil);
  try
    dset.Transaction:=Transac;
    MyOpenSQL(dset, 'select ID from orders_vds where ID=gen_id(gen_orders_vds, 0)');
    if dset.Eof and dset.Bof then
      Result:=-1
    else
      Result:=dset.FieldByName('ID').AsInteger;
    dset.Close;
  finally
    dset.Free;
  end;
end;

procedure Tfrm_Order_vds.BottomCtrlChange(Sender: TObject);
begin
  if F_ProcessState=psWork then
  begin
    {
    if (Sender is TRxDBLookupCombo) then
    begin
    end;
    }
    
    SetIsBottomCtrlChange(true);
    btn_SaveOrderData.Enabled:=true;
  end;
end;


procedure Tfrm_Order_vds.btn_SaveOrderDataClick(Sender: TObject);
var
  Res, IsWasNew: boolean;
  _062_list: string;
begin

  if (F_OrderType=otClose)or(F_OrderType=otCloseInCurShift) then
  begin
    SaveNumSOBuff;
    InitOrder;
    exit;
  end;

  IsWasNew:=(F_OrderType=otNew);

   if not F_NumSOBuff.IsDataLoad then
    begin
      F_NumSOBuff.OrderID := F_OrderID;
      F_NumSOBuff.OrderNumber:=st_OrderNum.Caption+st_District.Caption;
      F_NumSOBuff.DateOrder:=dp_Start.Date+StrToTime(me_Start.Text);
      F_NumSOBuff.LoadData;
    end;

  _062_list :=  F_NumSOBuff.GetAllNumSO ;



  if (F_SaveAction=saClose)
      and (_062_list<>'')
      and ( SetDepCount=0)
       then
  begin
    ActiveControl:=btn_CloseOrder;
    SetProcessStatus('Закройте наряд выездами!!!');
    Application.MessageBox('Закройте наряд выездами!!!',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

//  SaveNumSOBuff;

  if F_SaveAction=saClose then
  begin
    if F_OrderType=otNew then
    begin
      Res:=SaveOrder;
      if Res then Res:=CloseOrder;
    end else
    begin
      Res:=CloseOrder;
    end;
  end else Res:=SaveOrder;

  if Res then
  begin
    InitOrder;
    if IsWasNew then ShowOrderNumber('ВДС '+ st_OrderNum.Caption+st_District.Caption);
    //Close;
  end;
   if  (F_NUM1562>0) and(Res)
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
end;

procedure Tfrm_Order_vds.InitOrder;
begin
  F_ProcessState:=psInit;
  SetShiftNumberAndDate;
  SetOrderType;


  case F_OrderType of
    otNew:
      begin
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(false);
        ResetTopCtrls;
        btn_CloseOrder.Enabled:=true;
        btn_RestoreOpenState.Visible:=false;
        btn_Print.Visible:=false;
        SetSaveAction(saSave);
        lbl_Closure.Caption:='Новый наряд';
        Caption:='Ввод наряда';
      end; // end otNew
    otOpen:
      begin
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(false);
        LoadTopFieldsValue;
        btn_CloseOrder.Enabled:=true;
        btn_RestoreOpenState.Visible:=false;
        //btn_Print.Visible:=true;
        ActiveControl:=btn_CloseOrder;
        SetSaveAction(saSave);
        lbl_Closure.Caption:='Наряд открыт';
        Caption:='Просмотр и редактирование наряда';

      end; // end otOpen
    otClose:
      begin
        ShowDeletedRowInVoc(true);
        EnableTopCtrls(false);
        EnableBottomCtrls(false);
        LoadTopFieldsValue;
        LoadBottomFieldsValue;
        btn_CloseOrder.Enabled:=false;
        btn_RestoreOpenState.Visible:=false;
//        btn_Print.Visible:=true;
//        ActiveControl:=btn_NewOrder;
        SetSaveAction(saClose);
        lbl_Closure.Caption:='Наряд закрыт';
        Caption:='Просмотр наряда';

      end;  //end otClose;
    otCloseInCurShift: //наряд закрытый в текущую смену
      begin
        ShowDeletedRowInVoc(false);
        EnableTopCtrls(true);
        EnableBottomCtrls(true);
        LoadTopFieldsValue;
        LoadBottomFieldsValue;
        btn_CloseOrder.Enabled:=false;
        btn_RestoreOpenState.Visible:=true;
//        btn_Print.Visible:=true;
        SetSaveAction(saClose);
        lbl_Closure.Caption:='Наряд закрыт';
        Caption:='Просмотр наряда';

      end;
  end; //end case
  SetOpenDepCount;
  SetOpenDisconCount;
  btn_SaveOrderData.Enabled:=false;
SetWorRegion;

  F_ProcessState:=psWork;
  /////////////////////////

  SetIsTopCtrlChange(false);
  SetIsBottomCtrlChange(false);

  //SetCansleled; //glasha 14.06.2012

///////////////////////////////
///////////////////////////////
///////////////////////////////

{Права пользователя}
  if F_OrderType <> otNew then
    if not IsCurrentUserCanEdit then
    begin
      SetProcessStatus('У вас недостаточно прав для редактирования данной формы');
      F_IsReadOnly:=true;
    end else
     if not IsCurrentDistrictCanAccessRegion(F_OrderRegionID) then
      begin
       SetProcessStatus('Вы не можете редактировать данный район');
       F_IsReadOnly:=true;
      end
     else
       F_IsReadOnly:=false;

   if F_IsReadOnly then
      EnableAllCtrls( false )
   {else
    begin
       dset_Regions.Close;
       dset_Regions.ParamByName('id_district').AsInteger := GetDistrictID ;
       dset_Regions.Open;
//       dbl_Regions.DropDownCount := dset_Regions.RecordCount;
    end;}
  {/Права пользователя}
  {форма заявок}


end;

procedure Tfrm_Order_vds.EnableAllCtrls( value: boolean );
begin
    EnableTopCtrls(value);
    EnableBottomCtrls(value);
    btn_CloseOrder.Enabled:=value;
    btn_SaveOrderData.Enabled:=value;
    btn_RestoreOpenState.Enabled:=value;
    btn_NewOrder.Enabled:=value;
end;


function Tfrm_Order_vds.SaveOrder: boolean;
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
          MyExecSQL(sql_Order, TopOrderFieldsQuery(faInsert));
          F_OrderID:=GetMaxOrderID(sql_Order.Transaction);
        end;
      otOpen:
        begin
          if F_IsTopCtrlChange then
          begin
            MyExecSQL(sql_Order, TopOrderFieldsQuery(faUpdate));
          end;
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
  Result:=true;
end;

function Tfrm_Order_vds.CloseOrder: boolean;
var
 _062_list,_062_listview,list_1562:String;
 list_tel:TStringList;
 List_Och:TStringList;
 SList_1562:TStringList;
 t_Cansel,i:integer;
 ls:TStringList;
 ManClosed:TManClosed1562;
 mes:string;

 begin
  Result:=false;
  F_NumSOBuff.DateOrder:=dp_Start.Date+StrToTime(me_Start.Text);
  F_NumSOBuff.OrderNumber:=st_OrderNum.Caption+st_District.Caption;
  F_NumSOBuff.SaveData;
  SetProcessStatus('Закрытие наряда');


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


    _062_list :=  F_NumSOBuff.GetAllNumSO ;   //need in this form
    if (( F_DepBrig=-1) or ((F_DepsInfo='') and (f_work_sent=0)))
     and (_062_list <>'') then ///glasha 16.02.2012
     begin
       ActiveControl := btn_Departures;
       SetProcessStatus('Введите дополнительную информацию в последнем  выезде или добавьте работы отсылаемые в 1562.' );
       exit;
     end;

  end;


  if F_OrderType in [otNew, otOpen] then
    if Application.MessageBox('Вы уверены, что хотите закрыть наряд?',
                gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES then
         exit;


  try
    SetCloseWorks();
    try
      ManClosed:=TManClosed1562.Create(2,F_orderID,_062_list,st_OrderNum.Caption+st_District.caption,
      StrToDateTime( dp_Start.Text + ' ' + me_Start.Text ));  //2-вдс 1-нс
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
        begin
          MyExecSQL(sql_Order, TopOrderFieldsQuery(faUpdate));
        end;
    //  if F_IsBottomCtrlChange then
        begin
          MyExecSQL(sql_Order, BottomOrderFieldsQuery(faUpdate));
        end;
      MyExecSQL(sql_Order, Format('update orders_vds set IsClosed=1 where id=%d',[F_OrderID]));
//
      ManClosed.doClosed1562;
    finally
      ManClosed.free;

    end;
    F_Cansel:=false;
  except
    sql_order.Transaction.Rollback;
    SetProcessStatus('Ошибка при закрытие наряда. Наряд не закрыт');
    list_tel.Free;
    exit;
  end;

  sql_Order.Transaction.Commit;
  SetProcessStatus('Наряд закрыт');
  Result:=true;
end;



procedure Tfrm_Order_vds.LoadBottomFieldsValue;
begin
  dset_BottomOrderFields.Transaction.StartTransaction;
  try
    dset_BottomOrderFields.ParamByName('pID').AsInteger:=F_OrderID;
    dset_BottomOrderFields.Open;

    with dset_BottomOrderFields do
    begin
      {Данные берутся из таблицы Orders_vds}
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALCLOSED').AsInteger, dbl_LastOfficial); //Диспетчер, закрывший заявку
      FixDBLValue(FieldByName('FK_ORDERS_DIAMETERS').AsInteger, dbl_TubeDiameter);  //Диаметр трубы
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALCLOSED').AsInteger, dbl_LastOfficial);
      dp_End.Date:=FieldByName('DateClosed').AsDateTime;  //Дата закрытия заявки
      me_End.Text:=FormatDateTime('hh:mm', FieldByName('DateClosed').AsDateTime);  //Время закрытия заявки
      {/Данные берутся из таблицы Orders_vds}
    end; // end with
  finally
    dset_BottomOrderFields.Transaction.Commit;
  end;
end;

procedure Tfrm_Order_vds.LoadTopFieldsValue;
begin
  dset_TopOrderFields.Transaction.StartTransaction;
  try
    dset_TopOrderFields.ParamByName('pID').AsInteger:=F_OrderID;
    dset_TopOrderFields.Open;
    with dset_TopOrderFields do
    begin
      {Данные берутся из таблицы Orders_vds}
      st_OrderNum.Caption:=FieldByName('OrderNumber').AsString; //Номер наряда
      st_District.Caption:=FieldByName('District').AsString;
      dp_Start.Date:=FieldByName('DateComing').AsDateTime; //Дата поступления
      me_Start.Text:=FormatDateTime('hh:mm', FieldByName('DateComing').AsDateTime); //Время поступления
      FixDBLValue(FieldByName('FK_ORDERS_OFFICIALS').AsInteger, dbl_FirstOfficial); //Диспетчер, принявший заявку
      F_OrderRegionID := FieldByName('FK_ORDERS_REGIONS').AsInteger;
      FixDBLValue(F_OrderRegionID , dbl_Regions); //Район
      FixDBLValue(FieldByName('FK_ORDERS_STREETS').AsInteger, dbl_Street); //Улица
      ed_HouseNum.Text:=trim(FieldByName('HouseNum').AsString); //Номер дома
      ed_HousingNum.Text:=trim(FieldByName('HousingNum').AsString);  //Корпус
      ed_PorchNum.Text:=trim(FieldByName('PorchNum').AsString);     // Подъезд
      ed_FloorNum.Text:=trim(FieldByName('FloorNum').AsString);    //Этаж
      ed_ApartmentNum.Text:=trim(FieldByName('ApartmentNum').AsString);  //Квартира
      ed_PorchKod.Text:=trim(FieldByName('PorchKod').AsString);   //Код подъезда
      FixDBLValue(FieldByName('FK_ORDERS_MESSAGETYPES').AsInteger, dbl_MessageType); //О чем заявлено
      FixDBLValue(FieldByName('FK_ORDERS_ORGANISATIONS').AsInteger, dbl_ControlOrgs);  //Заявка на контроле
      FixDBLValue(FieldByName('FK_ORDERS_APPLICANT').AsInteger, dbl_Applicant);  //Заявитель
      ed_ApplicantFio.Text:=trim(FieldByName('APPLICANTFIO').AsString);    //Фамилия заявителя
      ed_ApplicantPhone.Text:=trim(FieldByName('APPLICANTPHONE').AsString);  //Телефон заявителя
      FixDBLValue(FieldByName('FK_ORDERS_BRIGADIERS').AsInteger, dbl_brigadiers);     //ответственный
      FixDBLValue(FieldByName('FK_ORDERS_DAMAGETYPE').AsInteger, dbl_DamageType);  //Вид повреждения
      mem_AdditionalInfo.Text:=FieldByName('AdditionalInfo').AsString;           //Дополнительная информация
      {/Данные берутся из таблицы Orders}

    end; // end with
  finally
    dset_TopOrderFields.Transaction.Commit;
  end;
end;



function Tfrm_Order_vds.TopOrderFieldsQuery(FixAction: TFixAction): string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['DateComing']:=DateTime2Str(dp_Start.Date,StrToTime(me_Start.Text));
      ValueByFieldName['FK_ORDERS_OFFICIALS']:=F_order.mt_officials_open.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_REGIONS']:=dset_Regions.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_STREETS']:=F_order.mt_street.FieldByName('ID').AsString;
      ValueByFieldName['HouseNum']:=QuotedStr(ed_HouseNum.Text);
      ValueByFieldName['HousingNum']:=QuotedStr(ed_HousingNum.Text);
      ValueByFieldName['PorchNum']:=QuotedStr(ed_PorchNum.Text);
      ValueByFieldName['FloorNum']:=QuotedStr(ed_FloorNum.Text);
      ValueByFieldName['ApartmentNum']:=QuotedStr(ed_ApartmentNum.Text);
      ValueByFieldName['PorchKod']:=QuotedStr(ed_PorchKod.Text);
      ValueByFieldName['FK_ORDERS_MESSAGETYPES']:=F_order.mt_Message.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_ORGANISATIONS']:=F_order.mt_organisation.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_APPLICANT']:=F_order.mt_Applicant_vds.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_BRIGADIERS']:=F_order.mt_brigadiers.FieldByName('ID').AsString;
      ValueByFieldName['ApplicantFio']:=QuotedStr(ed_ApplicantFio.Text);
      ValueByFieldName['ApplicantPhone']:=QuotedStr(ed_ApplicantPhone.Text);
      ValueByFieldName['ShiftNumber']:=IntToStr(F_ShiftNumber);
      ValueByFieldName['FK_ORDERS_DAMAGETYPE']:=F_order.mt_damagetype.FieldByName('ID').AsString;
      ValueByFieldName['AdditionalInfo']:=QuotedStr(trim(mem_AdditionalInfo.Text));
      if FixAction=faInsert then
      ValueByFieldName['FK_ORDERS_DISTRICT']:=IntToStr(GetDistrictID);// '1';
      dset_Regions.FieldByName('ID').AsString;//IntToStr(GetDistrictID) ;
     // ValueByFieldName['Ns_or_vds']:=IntToStr(2);
      TableName:='orders_vds';
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

function Tfrm_Order_vds.BottomOrderFieldsQuery(FixAction: TFixAction): string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['FK_ORDERS_OFFICIALCLOSED']:=F_order.mt_official_closed.FieldByName('ID').AsString;
      ValueByFieldName['FK_ORDERS_DIAMETERS']:=F_order.mt_tubediametr.FieldByName('ID').AsString;
      ValueByFieldName['DateClosed']:=DateTime2Str(dp_End.Date,StrToTime(me_End.Text));
      ValueByFieldName['ShiftNumberClose']:=IntToStr(F_ShiftNumber);

      TableName:='orders_vds';
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

procedure Tfrm_Order_vds.btn_DisconnectedClick(Sender: TObject);
var
  frm_Discon: Tfrm_Discon;
  _RO: boolean;
  _RegionID:integer;
begin
  if F_OrderType=otNew then
  begin
    if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if SaveOrder then InitOrder
      else exit;
    end else exit;
  end;
/////////////////

 _RegionID := dset_Regions.FieldByName('ID').AsInteger;
 _RO := (F_OrderType in [otClose, otCloseInCurShift]);
        //or (not IsCurrentDistrictHasAccesToRegion(F_OrderRegionID));
  frm_Discon:= Tfrm_Discon.Create(nil, F_OrderID,_RegionID, _RO);
  // frm_Discon;
  try
    frm_Discon.IDStreet:=F_order.mt_street.FieldByName('ID').AsInteger;
    frm_Discon.HouseNum:=ed_HouseNum.Text;
    frm_Discon.HousingNum:=ed_HousingNum.Text;
    frm_Discon.PorchNum:=ed_PorchNum.Text;
    frm_Discon.FloorNum:=ed_FloorNum.Text;
    frm_Discon.ApartmentNum:=ed_ApartmentNum.Text;
    frm_Discon.ShowModal;
  finally
    frm_Discon.Free;
  end;

  SetOpenDisconCount;
  SetProcessStatus('');
end;

procedure Tfrm_Order_vds.SetProcessStatus(const value: string);
begin
  if not F_IsReadOnly then
    sb_ProcessStaus.SimpleText:=value;
end;

procedure Tfrm_Order_vds.SetIsTopCtrlChange(value: boolean);
begin
  F_IsTopCtrlChange:=value;
  if value then
    SetProcessStatus('Изменения не сохранены')
  else
    SetProcessStatus('');
end;

procedure Tfrm_Order_vds.SetIsBottomCtrlChange(value: boolean);
begin
  F_IsBottomCtrlChange:=value;
  if value then
    SetProcessStatus('Изменения не сохранены')
  else
    SetProcessStatus('');
end;

procedure Tfrm_Order_vds.SetOrderType;
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
      MyOpenSQL(dset, Format('select IsClosed, DateClosed, ShiftNumberClose from orders_vds where id=%d',[F_OrderID]));
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

procedure Tfrm_Order_vds.SetSaveAction(value: TSaveAction);
begin
  F_SaveAction:=value;
  if value=saSave then
    btn_CloseOrder.Caption:='Закрыть наряд'
  else
    btn_CloseOrder.Caption:='Отм.закр.наряда';
end;

procedure Tfrm_Order_vds.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure Tfrm_Order_vds.SetShiftNumberAndDate;
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

procedure Tfrm_Order_vds.btn_RestoreOpenStateClick(Sender: TObject);
var
  Res: boolean;
  _062_list:string;
begin
  if F_OrderType=otCloseInCurShift then
  begin
      if not F_NumSOBuff.IsDataLoad then
    begin
      F_NumSOBuff.OrderID := F_OrderID;
      F_NumSOBuff.LoadData;
    end;

    _062_list :=  F_NumSOBuff.GetAllNumSOViw ;
    if  _062_list<>'' then
      Application.MessageBox('Информация по заявкам 1562 уже ушла и изменяться не будет!',
      gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
    if Application.MessageBox('Вы уверены в том, что хотите выпонить возврат?',
      gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      Res:=RestoreOpenState;
      if Res then
        InitOrder;
    end;
  end;
end;

function Tfrm_Order_vds.RestoreOpenState: boolean;
begin
  Result:=false;

  SetProcessStatus('Выполнение возврата...');

  sql_Order.Transaction.StartTransaction;
  try
    MyExecSQL(sql_Order, BottomOrderFieldsQuery(faUpdateToNull));
    MyExecSQL(sql_Order, Format('update orders_vds set IsClosed=0 where id=%d',[F_OrderID]));
  except
    sql_order.Transaction.Rollback;
    SetProcessStatus('Ошибка при выполнении возврата');
    exit;
  end;
  sql_Order.Transaction.Commit;
  SetProcessStatus('Возврат выполнен');
  Result:=true;
end;

procedure Tfrm_Order_vds.btn_PrintClick(Sender: TObject);
var
  dm: Tdm_AddPrint;
begin
  dm:=Tdm_AddPrint.Create(nil);
  try
    dm.PrintOrder_vds(F_OrderID);
  finally
    dm.Free;
  end;
end;

procedure Tfrm_Order_vds.btn_DeparturesClick(Sender: TObject);
var
  DepFrm: Tfrm_Departures;
  _RO: boolean;
  _RegionID:integer;
begin
  if F_OrderType=otNew then
  begin
     if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if SaveOrder then InitOrder
      else exit;
    end else exit;
  end;
////////////////////////////////////////

 _RegionID := dset_Regions.FieldByName('ID').AsInteger;
 _RO := (F_OrderType = otClose);// or (not IsCurrentDistrictHasAccesToRegion(F_OrderRegionID));

  DepFrm:=Tfrm_Departures.Create(nil, F_OrderID,_RegionID, _RO );
  try
    DepFrm.IDOfficials:=g_IDOfficial;
    DepFrm.ShiftDate:=F_ShiftDate;
    DepFrm.regionID:=_RegionID;
    DepFrm.ShowModal;
  finally
    DepFrm.Free;
  end;

  SetOpenDepCount;
  SetProcessStatus('');
end;

procedure Tfrm_Order_vds.SetOpenDepCount;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*) DepCount'+
        ' from departures_vds'+
        ' where (EndDate is null)'+
        ' and (fk_departures_orders=%d)', [F_OrderID]));

      if dset.Eof and dset.Bof then
        F_OpenDepCount:=0
      else
        F_OpenDepCount:=dset.FieldByName('DepCount').AsInteger;

         MyOpenSQL(dset, Format(
         'select * ' +
         ' from departures_vds'+
         ' where'+
         ' fk_departures_orders=%d'+
         ' order by 1 desc',[F_OrderID]));
         dset.First;
         F_DepsInfo:=dset.FieldByName('additionalinfo').Asstring;
         F_DepBrig:=dset.FieldByName('fk_departures_brigadiers').Asinteger;

           MyOpenSQL(dset, Format(
           'select count(*) from departurework_vds dww'+
           ' where dww.fk_depwork_orders=%d'+
           ' and dww.sent_1562=1',[F_OrderID]));
         F_Work_sent:=dset.FieldByName('count').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;


//////////////////////////////////////////
  if F_OpenDepCount>0 then
    btn_Departures.Font.Color:=clRed
  else
    btn_Departures.Font.Color:=clBlack;
end;

function Tfrm_Order_vds.SetDepCount:integer;
var
  dset: TIBDataSet;
  count:integer;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*)  DepCount'+
        ' from departures_vds'+
        ' where (fk_departures_orders=%d)', [F_OrderID]));

      if dset.Eof and dset.Bof then
        count:=0
      else
        count:=dset.FieldByName('DepCount').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
//////////////////////////////////////////

  result:= count;
end;

procedure Tfrm_Order_vds.SetOpenDisconCount;
var
  dset: TIBDataSet;
begin
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format(
        ' select count(*) DisconCount'+
        ' from Disconnections_vds'+
        ' where'+
        ' (FK_DISCON_ORDER=%d)'+
        ' and (dttm_con is null)', [F_OrderID]));

      if dset.Eof and dset.Bof then
        F_OpenDisconCount:=0
      else
        F_OpenDisconCount:=dset.FieldByName('DisconCount').AsInteger;
    finally
      dset.Transaction.Commit;
    end;
  finally
    dset.Free;
  end;
//////////////////////////////////////////
  if F_OpenDisconCount>0 then
    btn_Disconnected.Font.Color:=clRed
  else
    btn_Disconnected.Font.Color:=clBlack;
end;

function Tfrm_Order_vds.IsAdresCorrect: boolean;
  procedure AddCond(var ResultStr: string; CondField: string; ed: TEdit);
  begin
    //if trim(ed.Text)<>'' then
    ResultStr:=ResultStr+' and ('+CondField+'='+QuotedStr(trim(ed.Text))+')';
  end;
var
  dset: TIBDataSet;
  frm: Tfrm_OrderShortInfo;
  SelSQL: string;
  GVB: TGridViewBuilder;
begin
  Result:=true;
  if (F_order.mt_street.FieldByName('ID').AsInteger<>-1) and (trim(ed_HouseNum.Text)<>'')
      {and (F_OrderType=otNew)} then
  begin
    dset:= TIBDataSet.Create(nil);
    try
      dset.Transaction:=Tr_SelectData;
      dset.Transaction.StartTransaction;
      try
        SelSQL:=
          ' select DateComing,'+
          ' ORDERNUMBER FullOrderNum'+
          ' from orders_vds o'+
          ' where (IsClosed=0) and (id<>'+IntToStr(F_OrderID)+')'+
          ' and (fk_orders_streets='+F_order.mt_street.FieldByName('ID').AsString+')'+
          ' and (HouseNum='+QuotedStr(trim(ed_Housenum.Text))+')';
        AddCond(SelSQL, 'HousingNum', ed_HousingNum);
        AddCond(SelSQL, 'PorchNum', ed_PorchNum);
        AddCond(SelSQL, 'FloorNum', ed_FloorNum);
        AddCond(SelSQL, 'ApartmentNum', ed_ApartmentNum);
        SelSQL:=SelSQL+' order by DateComing';

        MyOpenSQL(dset, SelSQL);

        if not (dset.Eof and dset.Bof) then
        begin
          frm:=Tfrm_OrderShortInfo.Create(nil);
          try
            GVB:=TGridViewBuilder.Create(dset, frm.Grid);
            try
              GVB.IsNumberRecord:=true;
              AddColToGVB(GVB, 'FullOrderNum', '№'+#13+'наряда', alCenter);
              AddColToGVB(GVB, 'DateComing', 'Дата и время'+#13+'поступления', alCenter);
              GVB.BuildGridView;
            finally
              GVB.Free;
            end;
            if frm.ShowModal<>mrOk then
              Result:=false;
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


class function Tfrm_Order_vds.GetGUID: string;
begin
  Result:=ORDERFORMGUID_vds;
end;


procedure Tfrm_Order_vds.ShowDeletedRowInVoc(value: boolean);
begin
  F_order.mt_Applicant_vds.Filtered:=not value;
  F_order.mt_brigadiers.Filtered:=not value;
  F_order.mt_officials_open.Filtered:=not value;
  dset_Regions.Filtered:=not value;
  F_order.mt_street.Filtered:=not value;
  F_order.mt_Message.Filtered:=not value;
  //dset_TubeDiametr.Filtered:=not value;
  F_order.mt_official_closed.Filtered:=not value;
  F_order.mt_damagetype.Filtered:=not value;
end;

procedure Tfrm_Order_vds.VocFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FieldByName('Activity').IsNull then
    Accept:=true
  else
    Accept:=false;
end;

procedure Tfrm_Order_vds.dp_StartChange(Sender: TObject);
var ShDt: TDate;
    ShNum: integer;
begin
  inherited;
  if F_OrderType = otNew then
  begin
   GetShiftsNumAndDate( ShNum, ShDt);
   if (dp_Start.Date < ShDt)
        or ( dp_Start.Date >= (ShDt + 2) )
        or ( (dp_Start.Date = (ShDt+1)) and (Time() > StrToTime(g_ShiftStartTime)) ) then
    begin
     Application.MessageBox('Дата не соответствует текущей смене',gc_strDispAVR, MB_OK+MB_ICONERROR);
     dp_Start.Date := Date;
    end
    else
    TopCtrlChange(Sender);
   end; 
end;



procedure Tfrm_Order_vds.BitBtn1Click(Sender: TObject);
var
//  _frmNG: TNumSONGForm;
  _frm: Tfrm_NumSO;
  _reg: integer;
begin
  inherited;
    if F_OrderType=otNew then
  begin
     if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if SaveOrder then InitOrder
      else exit;
    end else exit;
  end;
////////////////////////////////////////
  F_NumSOBuff.OrderID := F_OrderID;

  F_NumSOBuff.OrderClosed:=((F_OrderType=otClose) or (F_OrderType=otCloseInCurShift));
  F_NumSOBuff.OrderNumber:=st_OrderNum.Caption+st_District.Caption;

  F_NumSOBuff.DateOrder:=dp_Start.Date+StrToTime(me_Start.Text);
  F_NumSOBuff.id_disp:=g_IDOfficial;
//{$IFNDEF spisok1562}
//  F_NumSOBuff.IsReadOnly := ( F_IsReadOnly);
  if not F_NumSOBuff.IsDataLoad then
    F_NumSOBuff.LoadData;
  F_NumSOBuff.SaveToStack;

  _frm := Tfrm_NumSO.Create( nil, F_NumSOBuff );
  try
     _reg := dset_Regions.FieldByName('ID').AsInteger;
    _frm.RO := (F_IsReadOnly  or (not IsCurrentDistrictCanAccessRegion(_reg)));
    if _frm.ShowModal = mrOk then
      TopCtrlChange( nil )
    else
      F_NumSOBuff.LoadFromStack;
  finally
    _frm.Free;
  end;

end;

procedure Tfrm_Order_vds.FormCreate(Sender: TObject);
begin
  inherited;
F_order:= Tdm_order_vds.Create(nil);
  OpenVocDataset;
  InitOrder;
F_NumSOBuff := Tdm_NumSOBuff.Create( nil );
F_NumSOBuff.for_vds:=1;
F_cansel:=false;
end;


procedure Tfrm_Order_vds.SaveNumSOBuff;
begin
  F_NumSOBuff.OrderID := F_OrderID;
 F_NumSOBuff.OrderNumber:=st_OrderNum.Caption+st_District.Caption;
 F_NumSOBuff.DateOrder:=dp_Start.Date+StrToTime(me_Start.Text);
  F_NumSOBuff.SaveData;
  F_NumSOBuff.ResetBuff;
end;

function Tfrm_Order_vds.Is_LastDep_correcr():boolean;
var
  dset: TIBDataSet;
begin
result:=true;
  dset:= TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_SelectData;
    dset.Transaction.StartTransaction;
    try
      MyOpenSQL(dset, Format('select  dds1.additionalinfo,dds1.fk_departures_brigadiers'+
                             ' from  departures_vds dds1'+
                             ' where dds1.id=(select max(id) from departures_vds dds'+
                             ' where dds.id=%d) ' ,[F_OrderID]));
     if dset.FieldByName('additionalinfo').IsNull or   dset.FieldByName('fk_departures_brigadiers').IsNull  then
      result:=false
    except
    end;
  except
  end;

end;

function Tfrm_Order_vds.F_is_closed :boolean; //23.01.2012 Glabsha
  begin
   if  (F_OrderType=otClose)or(F_OrderType=otCloseInCurShift) then
     result:=true
    else
     result:=false;
  end;



procedure Tfrm_Order_vds.bt_cansel_infClick(Sender: TObject);
begin
  inherited;
   frm_cansel:=Tfrm_cansel1562.Create(nil,F_OrderID,'numsorders_vds',
    st_OrderNum.Caption+st_District.Caption,
    StrToDateTime( dp_Start.Text + ' ' + me_Start.Text ));
   frm_cansel.Enabled:=false;

    frm_cansel.ShowModal;
end;




procedure Tfrm_Order_vds.SetWorRegion;
 var dset:TIBDataSet;
begin
 dset:= TIBDataSet.Create(nil);
 try
  dset.Transaction:=Tr_SelectData;
  dset.Transaction.StartTransaction;
  try
   MyOpenSQL(dset, Format(
        'select  rv.id, rv.fk_id_order, '+
        '   rv.startdate,  rv.fk_id_brig, '+
        '   rv.enddate, '+
       ' (select name from BRIGADIERS so where so.id=rv.fk_id_brig) '+
       ' fk_name_user, '+
       ' (select name from s_officials so where so.id=rv.fk_id_closedused) '+
       ' fk_name_closedused '+
       '  from regions_works_vds rv '+
       '  where rv.fk_id_order=%d', [F_OrderID]));
    if dset.Eof and dset.Bof then
     begin
        btn_RegionWork.Font.Color:=clBlack;
        pnl_regionWork.Visible:=false;
     end
     else
     begin

       pnl_regionWork.Visible:=true;
       lbl_User.Caption:=dset.fieldbyname('fk_name_user').AsString;
       me_startwork.Text:=FormatDateTime('dd.mm.yy hh:mm',dset.fieldbyname('startdate').AsDateTime);
       if dset.FieldByName('enddate').IsNull then
       begin
         btn_RegionWork.Font.Color:=clRed;
         lbl_endwork.Visible:=false;
         me_endwork.Visible:=false;
       end
       else
        begin
          btn_RegionWork.Font.Color:=clBlack;
          lbl_endwork.Visible:=true;
          me_endwork.Visible:=true;
          me_endwork.Text:=FormatDateTime('dd.mm.yy hh:mm',dset.fieldbyname('enddate').AsDateTime);
        end;
      end
   finally
    dset.Transaction.Commit;
   end;
  finally
   dset.Free;
  end;
end;

procedure Tfrm_Order_vds.FormDestroy(Sender: TObject);
begin
  inherited;
F_order.Free;
F_NumSOBuff.Free;
end;

procedure Tfrm_Order_vds.btn_RegionWorkClick(Sender: TObject);
var Frm:Tfrm_WorksRegions;
    is_closed:integer;
begin
  inherited;
  inherited;
  if F_OrderType=otNew then
  begin
     if F_IsReadOnly then exit;

    if Application.MessageBox('Прежде необходимо зарегистрировать наряд. Зарегистрировать наряд?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if SaveOrder then InitOrder
      else exit;
    end else exit;
  end;
  if F_OrderType= otOpen then
     is_closed:=0
    else
     is_closed:=1;
  Frm :=Tfrm_WorksRegions.Create(Self,F_OrderID,F_OrderREgionID,is_closed);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
   end;
  SetWorRegion();
end;

function Tfrm_Order_vds.SetCloseWorks():boolean;

begin
result:=true;
try
if  (pnl_regionWork.Visible) then
 if  (me_startwork.Text<>'__.__.__ __:__') and( not lbl_endwork.Visible) then
  begin
    sql_Order.Transaction.StartTransaction;
    sql_Order.SQL.Text:=Format('update regions_works_vds set enddate=''%s'' where fk_id_order=%d',
                                [DateTimeToStr(NOW()),F_OrderID]);
    sql_Order.ExecQuery;
    sql_Order.Transaction.Commit;
 end ;
 result:=true;
except on e:exception do
  begin
    if  sql_Order.Transaction.InTransaction then
     sql_Order.Transaction.Rollback ;
    result:=false;
  end;
end;
end;

procedure Tfrm_Order_vds.ClearBottomCtrls();
begin
 FixDBLValue(-1,dbl_LastOfficial);
 dp_End.Clear;
 me_End.Clear;
end;


end.



