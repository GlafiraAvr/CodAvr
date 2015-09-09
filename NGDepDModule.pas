unit NGDepDModule;

interface

uses
  SysUtils, Classes, IBDatabase, DModule, DB, IBCustomDataSet, IBSQL,
  kbmMemTable, GlobalVocCacheDModule, IBQuery, MainForm, Controls;

type
  TDepField = (dfStartDate, dfEndDate, dfBrig, dfPlanEndDate, dfPlanStartDate, dfDateRegl,dfDiam,dfdate_closed_info,db_Date_CapRem);
  Ttype1562 = (excav, cap_rem);
  TDepExcavCloseField=(dfInfo,dfClosedDate);
  EIncorrectDepField = class(Exception)
  private
    FDepField: TDepField;
  public
    property DepField: TDepField read FDepField;
    constructor Create( const Msg: string; const DepField: TDepField);
  end;

  TShowMsgEvent = procedure( _Msg: string ) of object;

  Tdm_NGDep = class(TDataModule)
    tran: TIBTransaction;
    dset_Dep: TIBDataSet;
    dset_DepID: TIntegerField;
    dset_DepSTARTDATE: TDateTimeField;
    dset_DepENDDATE: TDateTimeField;
    dset_DepFK_DEPARTURES_BRIGADIERS: TIntegerField;
    dset_DepFK_DEPARTURES_OFFICIALSOPEN: TIntegerField;
    dset_DepFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField;
    dset_DepFK_DEPARTURES_ORDERS: TIntegerField;
    dset_DepDEPNUMBER: TSmallintField;
    dset_RebuildDepNum: TIBDataSet;
    dset_RebuildDepNumDEPNUMBER: TSmallintField;
    dset_RebuildDepNumID: TIntegerField;
    mem_BrigAtt: TkbmMemTable;
    mem_DispOpenAtt: TkbmMemTable;
    mem_DispCloseAtt: TkbmMemTable;
    mem_MessagetypesAtt: TkbmMemTable;
    dset_Deplp_Brig: TStringField;
    dset_Deplp_DispOpen: TStringField;
    dset_Deplp_DispClose: TStringField;
    dset_DepADDITIONALINFO: TIBStringField;
    tran_tmp: TIBTransaction;
    dset_tmp: TIBDataSet;
    dset_DepFK_DEPARTURES_OFFICPOST_INS: TIntegerField;
    dset_Depclc_IsCanEdit: TBooleanField;
    dset_Depclc_IsCanDel: TBooleanField;
    dset_Depclc_RecInfo: TStringField;
    mem_MessagetypesAttid: TIntegerField;
    mem_MessagetypesAttmessagename: TStringField;
    mem_MessagetypesAttS_MT_CATEGORY_ID: TSmallintField;
    dset_DepPLANSTARTDATE: TDateTimeField;
    dset_DepPLANENDDATE: TDateTimeField;
    dset_DepFK_DEPARTURES_EQUIPMENT: TIntegerField;
    mem_EquipmentAtt: TkbmMemTable;
    mem_DispPlanAtt: TkbmMemTable;
    dset_DepFK_DEPARTURES_OFFICIALSPLAN: TIntegerField;
    dset_Deplp_DispPlan: TStringField;
    ds_exectmp: TIBSQL;
    mem_LookupEquip: TkbmMemTable;
    mem_LookupEquipid: TIntegerField;
    mem_LookupEquipsnumber: TStringField;
    dset_DepEMPTING: TFloatField;
    dset_DepPLAN_PEOPLE: TIntegerField;
    dset_DepFK_DEPARURE_ID_STREET: TIntegerField;
    dset_DepFK_DEPARURE_HOUSETYPES: TIntegerField;
    dset_DepADDADRES: TIBStringField;
    dset_DepFK_DEPARTURE_REGIONS: TIntegerField;
    mem_streets: TkbmMemTable;
    dset_adress: TIBDataSet;
    mem_street_2: TkbmMemTable;
    mem_Region: TkbmMemTable;
    dset_locality: TIBDataSet;
    dset_localityID: TIntegerField;
    dset_localityNAME: TIBStringField;
    dset_localityACTIVITY: TIBStringField;
    dset_Depfk_ID_DAMAGELOCALITY: TIntegerField;
    dset_Depfk_departures_DamageLocality: TIntegerField;
    dset_Dephousenum: TStringField;
    mem_diameter: TkbmMemTable;
    dset_DepFK_DIAMETER: TIntegerField;
    dset_DepPLANDATEREGL: TDateTimeField;
    dset_DepFK_DEPARTURES_REGION_BRIG: TIntegerField;
    mem_region_brig: TkbmMemTable;
    dset_DepEXCAV_CLOSE_INFO: TIBStringField;
    dset_DepDATE_CLOSE_INFO: TDateTimeField;
    dset_DepCAPREP_CLOSEDINFO: TIBStringField;
    dset_DepCAPREM_DATE: TDateTimeField;
    tran_closwedCapRem: TIBTransaction;
    IBSQLClosedCaprem: TIBSQL;
    procedure dset_DepAfterOpen(DataSet: TDataSet);
    procedure dset_DepAfterPost(DataSet: TDataSet);
    procedure dset_DepAfterInsert(DataSet: TDataSet);
    procedure dset_DepAfterDelete(DataSet: TDataSet);
    procedure InputDepFieldChange(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_DepAfterCancel(DataSet: TDataSet);
    procedure dset_DepAfterEdit(DataSet: TDataSet);
    procedure dset_DepBeforeDelete(DataSet: TDataSet);
    procedure dset_DepBeforePost(DataSet: TDataSet);
    procedure mem_BrigAttFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure dset_DepSTARTDATEChange(Sender: TField);
    procedure dset_DepENDDATEChange(Sender: TField);
    procedure dset_DepBeforeInsert(DataSet: TDataSet);
    procedure dset_DepCalcFields(DataSet: TDataSet);
    procedure mem_MessagetypesAttFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure dset_DepPLANSTARTDATEChange(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_OrderID,
    F_DefaultOfficialID,
    F_DefaultOfficPostID,
    F_DefaultBrigID,
    F_RegionID: integer;
    F_IsReadOnly: boolean;
    F_IsInputDepFieldChange: boolean;
    F_IsNeedReopenAfterPost,
    F_IsHasFirstDep: boolean;
    F_PrevDepStartDate: TDateTime;
    F_OrderDateComing: TDateTime;
    F_CurShiftDate: TDate;
    F_DefaultAddInfoForFirstDep: string;
    F_ConstMsg: string;
    f_orderNumber:string;
    procedure OpenDepDset;
    procedure OpenVocs;
    procedure RebuildDemnumber;
    procedure CommitRetTran;
    function GetCurrentDepID: integer;
    function GetCurrentStartDate: TDateTime;
    function GetCurrentBrigID: integer;
    procedure SetIsReadOnly(const Value: boolean);
    procedure SetIsReadOnlyReg(const Value: boolean);    
    procedure Reset;
    procedure ShowMsg( _Msg: string );
  private
    F_OnAfterDepDsetOpen: TDataSetNotifyEvent;
    F_OnInputDepFieldChange: TFieldNotifyEvent;
    F_OnStartTran: TNotifyEvent;
    F_OnShowMsg: TShowMsgEvent;
    F_IsInternalMod: boolean;
    F_REgionBrig:integer;
    function IsInCurShift( _DT: TDateTime): boolean;
  private
    F_WithoutOrder:boolean;
  public
    {Для ввода после старта транзак.}
    property OrderID: integer read F_OrderID write F_OrderID;
    property DefaultAddInfoForFirstDep: string read F_DefaultAddInfoForFirstDep
      write F_DefaultAddInfoForFirstDep;
    property DefaultBrigID: integer read F_DefaultBrigID write F_DefaultBrigID;
    property OrderDateComing: TDateTime read F_OrderDateComing write F_OrderDateComing;
    property CurShiftDate: TDate read F_CurShiftDate write F_CurShiftDate;
    property OnAfterDepDsetOpen: TDataSetNotifyEvent read F_OnAfterDepDsetOpen write F_OnAfterDepDsetOpen;
    property OnInputDepFieldChange: TFieldNotifyEvent read F_OnInputDepFieldChange write F_OnInputDepFieldChange;
    property OnStartTran: TNotifyEvent read F_OnStartTran write F_OnStartTran;
    property OnShowMsg: TShowMsgEvent read F_OnShowMsg write F_OnShowMsg;
    procedure SetIsInputDepFieldChange(Value: boolean);
    procedure AddPlanTOEquipplanned;
    property OrderNumber:string write f_orderNumber;
    {/Для ввода после старта транзак.}
  public
    {Для чтения после старта транзак.}
    property IsReadOnly: boolean read F_IsReadOnly;
    property IsHasFirstDep: boolean read F_IsHasFirstDep write F_IsHasFirstDep;
    property CurrentDepID: integer read GetCurrentDepID;
    property CurrentStartDate: TDateTime read GetCurrentStartDate;
    property CurrentBrigID: integer read GetCurrentBrigID;
    property IsInputDepFieldChange: boolean read F_IsInputDepFieldChange;
    property DefaultOfficPostID: integer read F_DefaultOfficPostID;
    property REgionBrig:integer read F_REgionBrig  write F_REgionBrig;
//    property DefaultOfficialID: integer read F_DefaultOfficialID;
    function IsFieldsValueCorrect( var _ErrMsg: string; var _IncorrectField: TDepField ): boolean;
    function IsCanEditCurrentDep: boolean;
    function IsCanDelCurrentDep: boolean;
    {/Для чтения после старта транзак.}
    function IsFieldsdatereglCorrect( var _ErrMsg: string ): boolean;

  public
    procedure StartTran( _IsReadOnly: boolean; _RegionID: integer; _IsREG: boolean);
    procedure CommitTran;
    procedure RollbackTran;
  public
    {Для чтения без необходимости стартовать транзакцию}
    function GetBrigIDFromLastDep( _OrderID: integer ): integer;
    function GetBrigIDFromFirstDep( _OrderID: integer ): integer;
    function IsHasDepWithoutEndDate( _OrderID: integer ): boolean;
    function GetEndDateFromLastDep( _OrderID: integer ): TDateTime;
    function GetDetLastDepAddinf(_OrderID: integer): string; //2012
    function IsSentWorks(_orderid:integer):boolean;

    private
    procedure SetWithoutOrder(Val:boolean);
    public
     {/Для чтения без необходимости стартовать транзакцию}
    property WithoutOrder:boolean read f_WithoutOrder  write SetWithoutOrder;
    procedure ChangeYear(year:integer);
    function isReadOnlyDate():boolean;
    public
    property REgionID: integer read F_REgionID;
  private
   F_CanAddExcavInfo:boolean;
   F_CanReadExcav:boolean;
   str_1562:String;//заявки 1562 с раскопками
   str_1562_caprem:String; // заявки кап ремонт 1562
   F_CanAddCapRemInfo:boolean;
   F_CanReadCapRem:boolean;
   function getIsExcavnumber(var can_Read:boolean):boolean;
   function getIsCapRem():boolean;
  public
  property CanAddExcavInfo:boolean read  F_CanAddExcavInfo;
  property CanAddCapRemInfo :boolean read F_CanAddCapRemInfo;
  function Closed1562(var corInfo:boolean;var corDate:boolean;
                             type1562:Ttype1562 = excav;
                              fieldnameinfo:string = 'EXCAV_CLOSE_INFO';
                              fieldnamedate:string = 'date_close_info'
                              ):boolean;

  property CanReadExcav:boolean read  F_CanReadExcav;
  property CanReadCapRem:boolean read F_CanReadCapRem;
  function PostAddExcav(var _ErrMsg:string; fieldnameinf:string = 'EXCAV_CLOSE_INFO';
                                fieldnamedate:string='DATE_CLOSE_INFO';
                                rusmessage:string=' Сохранена только  инфлрмация  по благоустройству'):boolean; //Запомнить поле допинф раскопки
  public
  function ExcavFieldCorrect(var _field:TDepExcavCloseField;
                                      fieldnameinfo:string='excav_close_info';
                                      fieldnamedate:string='date_close_info';
                                      rusermess:string ='по благоустройству'):boolean;

  function setClosedCaprem():boolean;
  function IsInNextShift(_DT: TDateTime): boolean;
  function IntShift(_DT: TDateTime):integer;

  end;


implementation

{$R *.dfm}

uses RightsManagerDModule, AppGUIDS, HelpFunctions, GlobalData,Closed1562Manager,
Math;

{ Tdm_NGDep }

procedure Tdm_NGDep.CommitTran;
begin
if tran.Active then begin
  RebuildDemnumber;
  tran.Commit;
end;  
end;

procedure Tdm_NGDep.OpenDepDset;
begin
  dset_Dep.Close;
  dset_Dep.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  if (F_WithoutOrder) and (dset_Dep.ParamByName('year').asinteger=0) then
    dset_Dep.ParamByName('year').AsInteger:=GetYear(Now());
  dset_Dep.Open;


  F_IsHasFirstDep := false;
  dset_Dep.First;
  while not dset_Dep.Eof do
  begin

    if dset_Dep.FieldByName( 'DepNumber' ).AsInteger = 1 then
      F_IsHasFirstDep := true;
    dset_Dep.Next;
  end;
  //dset_Dep.Last; //Получаем все записи в локальны кеш 
end;

procedure Tdm_NGDep.RollbackTran;
begin
  if tran.InTransaction then tran.Rollback;
end;

procedure Tdm_NGDep.StartTran( _IsReadOnly: boolean; _RegionID: integer ; _IsREG: boolean);
begin
  F_RegionID := _RegionID; //1-ый!!!
  SetIsReadOnly( _IsReadOnly ); //2-ой!!!

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;

  OpenVocs;
  OpenDepDset;
  getIsExcavnumber(F_CanReadExcav); {усть ли заявки с раскопками}
  getIsCapRem();{усть ли заявки с кап ремонт}


  if _IsREG then
  begin
    SetIsReadOnlyReg( _IsReadOnly );
    OpenDepDset;
  end;

  //
  if (not F_IsReadOnly ) and
  ( dset_Dep.RecordCount < 1 ) then
    dset_Dep.Append;

  if Assigned( F_OnStartTran ) then
    F_OnStartTran( nil );
end;



procedure Tdm_NGDep.dset_DepAfterOpen(DataSet: TDataSet);
begin
  //
  if Assigned( F_OnAfterDepDsetOpen ) then
    F_OnAfterDepDsetOpen( DataSet );

  ShowMsg( '' );
end;

procedure Tdm_NGDep.dset_DepAfterPost(DataSet: TDataSet);
begin
  CommitRetTran;

  if F_IsNeedReopenAfterPost then OpenDepDset
  else dset_Dep.Refresh;
  
  F_IsInputDepFieldChange := false;

  ShowMsg( '' );
end;

procedure Tdm_NGDep.dset_DepAfterInsert(DataSet: TDataSet);
var
  _IsChange: boolean;
begin
  {Первичный выезд могут заносить только Диспетчера ЦДП.
  Первый выезд заносимый диспетчером ЦДП автоматом становится
  первичным не зависимо от того есть ли уже на данный момент
  выезды занесенные диспетчерами районных участков}

{
  dset_Dep.FieldByName( 'fk_departures_orders' ).AsInteger := F_OrderID;
  dset_Dep.FieldByName( 'StartDate' ).AsDateTime := Now;
  dset_Dep.FieldByName( 'fk_departures_officpost_ins' ).AsInteger := F_DefaultOfficPostID;

  if ( F_DefaultOfficPostID = GlobalData.DISP_CDP_POST_ID ) and ( not F_IsHasFirstDep ) then
  begin
    dset_Dep.FieldByName( 'DepNumber' ).AsInteger := 1;
    dset_Dep.FieldByName( 'AdditionalInfo' ).AsString := trim( F_DefaultAddInfoForFirstDep );
    if F_DefaultBrigID > 0 then
      dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).AsInteger := F_DefaultBrigID
    else
      SetIsInputDepFieldChange( false );
  end else
    SetIsInputDepFieldChange( false );
}

  F_IsInternalMod := true;
  try
    _IsChange := false;

    dset_Dep.FieldByName( 'fk_departures_orders' ).AsInteger := F_OrderID;
    dset_Dep.FieldByName( 'StartDate' ).AsDateTime := CrazyNow;
//    dset_Dep.FieldByName( 'PlanStartDate' ).AsDateTime := Now;
    dset_Dep.FieldByName( 'fk_departures_officpost_ins' ).AsInteger := F_DefaultOfficPostID;
    dset_dep.FieldByName('fk_departures_region_brig').AsInteger:=F_RegionId;
    F_REgionBrig:=F_RegionID;

//    if( F_DefaultOfficPostID = GlobalData.DISP_CDP_POST_ID ) then // by Vadim 14.03.2011
    if ( not F_IsHasFirstDep ) then
    begin
      dset_Dep.FieldByName( 'DepNumber' ).AsInteger := 1;
      dset_Dep.FieldByName( 'AdditionalInfo' ).AsString := trim( F_DefaultAddInfoForFirstDep );
      if F_DefaultBrigID > 0 then
      begin
        dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).AsInteger := F_DefaultBrigID;
        _IsChange := true;
      end;
    end;
    SetIsInputDepFieldChange( _IsChange );
  finally
    F_IsInternalMod := false;
  end;
  {Для выездов без наряда вставляем район}
  if f_WithoutOrder then
       dset_Dep.FieldByName('FK_DEPARTURE_REGIONS').AsInteger:=F_RegionID;

  F_IsNeedReopenAfterPost := true;
end;

procedure Tdm_NGDep.dset_DepAfterDelete(DataSet: TDataSet);
begin
  CommitRetTran;
  OpenDepDset;
  ShowMsg( '' );
end;

procedure Tdm_NGDep.InputDepFieldChange(Sender: TField);
begin
  if not F_IsInternalMod then
    SetIsInputDepFieldChange( true );
end;

procedure Tdm_NGDep.DataModuleCreate(Sender: TObject);
begin
  Reset;
  //
  F_DefaultOfficialID := GlobalData.g_IDOfficial;
  F_DefaultOfficPostID := DM_Main.GetIDOfficialPost( F_DefaultOfficialID );
end;

procedure Tdm_NGDep.dset_DepAfterCancel(DataSet: TDataSet);
begin
  F_IsInputDepFieldChange := false;
  ShowMsg( '' );
end;

procedure Tdm_NGDep.SetIsInputDepFieldChange(Value: boolean);
begin
  F_IsInputDepFieldChange := Value;
  if Assigned( F_OnInputDepFieldChange ) then
    F_OnInputDepFieldChange( nil );
end;

procedure Tdm_NGDep.RebuildDemnumber;
begin
  {
    Перестройка значений в поле DepNumber.
  Самый первый выезд получает значение 1.
  Данное значение заносится непосредственно
  во время ввода первичного выезда, и в перестройке
  не участвует. Первичный выезд нельзя удалить,
  если имеются еще выезды.
    Самый последний выезд получает DepNumber = 3.
    Все остальные выезды получают DepNumber = 2.
  }
  dset_RebuildDepNum.Close;
  dset_RebuildDepNum.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  dset_RebuildDepNum.Open;

  if not dset_RebuildDepNum.Eof then
  begin
    dset_RebuildDepNum.First;
    while not dset_RebuildDepNum.Eof do
    begin
      if dset_RebuildDepNum.FieldByName( 'DepNumber' ).AsInteger <> 2 then
      begin
        dset_RebuildDepNum.Edit;
        dset_RebuildDepNum.FieldByName( 'DepNumber' ).AsInteger := 2;
        dset_RebuildDepNum.Post;
      end;
      dset_RebuildDepNum.Next;
    end;
    dset_RebuildDepNum.Last;
    dset_RebuildDepNum.Edit;
    dset_RebuildDepNum.FieldByName( 'DepNumber' ).AsInteger := 3;
    dset_RebuildDepNum.Post;
  end;
end;

function Tdm_NGDep.IsFieldsValueCorrect(var _ErrMsg: string; var _IncorrectField: TDepField): boolean;
  procedure _Error( _Msg: string; _Field: TDepField);
  begin
    _ErrMsg := _Msg;
    _IncorrectField := _Field;
    ShowMsg( _Msg );
  end;
var
  _Now: TDateTime;
begin
  Result := false;
  _ErrMsg := '';
  _Now := Now;

  if dset_Dep.FieldByName( 'StartDate' ).AsDateTime < F_OrderDateComing then
  begin
    _Error( 'Дата начала работ не может быть меньше даты поступления заявки ' +
            DateTimeToStr( F_OrderDateComing ) + '!',
            dfStartDate );
    exit;
  end;

  if ( dset_Dep.FieldByName( 'DepNumber' ).AsInteger <> 1 ) and ( dset_Dep.State = dsInsert ) and
    ( F_PrevDepStartDate > dset_Dep.FieldByName( 'StartDate' ).AsDateTime ) then
  begin
    _Error( 'Дата начала работ у тек. выезда ' +
            'не может быть меньше чем дата начала работ у пред. выезда ('+
            DateTimeToStr( F_PrevDepStartDate )  + ')!',
            dfStartDate );
    exit;
  end;

  if not  IsInNextShift(dset_Dep.FieldByName( 'StartDate' ).AsDateTime)  then// > Date()+g_ShiftStartTime then    // меньше рачала след смены
  begin
    _Error( 'Дата начала работ  должна быть в пределах двух  смен ('+
            DateTimeToStr( F_CurShiftDate ) + ', '+DateTimeToStr( F_CurShiftDate+1 )+')!',
            dfStartDate );
    exit;
  end;

  if dset_Dep.FieldByName( 'EndDate' ).AsDateTime > _Now then
  begin
    _Error( 'Дата окончания работ не может быть больше текущей даты!',
            dfEndDate );
    exit;
  end;

  if ( not dset_Dep.FieldByName( 'EndDate' ).IsNull ) and
    ( dset_Dep.FieldByName( 'StartDate' ).AsDateTime > dset_Dep.FieldByName( 'EndDate' ).AsDateTime ) then
  begin
    _Error( 'Дата окончания работ не может быть меньше даты начала!',
            dfEndDate );
    exit;
  end;

   if ( not dset_Dep.FieldByName( 'StartDate' ).IsNull ) and
   not IsInNextShift(dset_Dep.FieldByName( 'StartDate' ).AsDateTime) then
  begin
    _Error( 'Дата начала работ должна быть в пределах ТЕКУЩЕЙ И СЛЕДУЮЩЕЙ СМЕН (' +
            DateTimeToStr( F_CurShiftDate ) + ', '+DateTimeToStr( F_CurShiftDate+1 )+')!',
            dfStartDate );
    exit;
  end;

    if ( not dset_Dep.FieldByName( 'EndDate' ).IsNull ) and
   not IsInCurShift(dset_Dep.FieldByName( 'EndDate' ).AsDateTime) then
  begin
    _Error( 'Дата окончания работ должна быть в пределах ТЕКУЩЕЙ СМЕНЫ ' +
            DateTimeToStr( F_CurShiftDate ) + '!',
            dfEndDate );
    exit;
  end;


  if ( not dset_Dep.FieldByName( 'PlanEndDate' ).IsNull ) and
    ( dset_Dep.FieldByName( 'PlanStartDate' ).AsDateTime > dset_Dep.FieldByName( 'PlanEndDate' ).AsDateTime ) then
  begin
    _Error( 'Планируемая дата окончания работ не может быть меньше планируемой даты начала!',
            dfPlanEndDate );
    exit;
  end;

  if ( not dset_Dep.FieldByName( 'PlanStartDate' ).IsNull ) and
     (dset_Dep.FieldByName( 'PlanStartDate' ).AsDateTime < F_OrderDateComing) then
  begin
    _Error( 'Планируемая дата начала работ не может быть меньше даты поступления заявки ' +
            DateTimeToStr( F_OrderDateComing ) + '!',
            dfPlanStartDate );
    exit;
  end;
  if ( not dset_Dep.FieldByName( 'PlanStartDate' ).IsNull ) and
   not IsInNextShift(dset_Dep.FieldByName( 'PlanStartDate' ).AsDateTime) then
  begin
    _Error( 'Планируемая дата начала работ должна быть в пределах ТЕКУЩЕЙ  и СЛЕДУЮЩЕЙ СМЕН (' +
            DateTimeToStr( F_CurShiftDate ) + ', '+DateTimeToStr( F_CurShiftDate+1 )+')',
            dfPlanStartDate );
    exit;
  end;

  if ( not dset_Dep.FieldByName( 'PlanEndDate' ).IsNull ) and
   not IsInNextShift(dset_Dep.FieldByName( 'PlanEndDate' ).AsDateTime) then
  begin
    _Error( 'Планируемая дата окончания работ должна быть в пределах ТЕКУЩЕЙ и СЛЕДУЮЩЕЙ СМЕН ' +
            DateTimeToStr( F_CurShiftDate  ) + '!',
           // DateTimeToStr( F_CurShiftDate  ) + ' 8:00 по '+
           // DateTimeToStr( F_CurShiftDate + 1 ) + ' 7:59)!',
            dfPlanStartDate );
    exit;
  end;
  if not (dset_dep.fieldbyname('PlanStartDate').IsNull) then
  if IntShift(dset_dep.fieldbyname('StartDate').AsDateTime)<>  //проверка смены
        IntShift(dset_dep.fieldbyname('PlanStartDate').AsDateTime) then
  begin
    _Error('Планируемая дата начала работ и дата начала работ должны быть в одну смену!',
            dfPlanStartDate);
    exit;
  end;

  if (IntShift(dset_dep.fieldbyname('StartDate').AsDateTime)>1) and
     ( dset_dep.fieldbyname('PlanStartDate').IsNull) then
   begin
     _Error('Для выездов на след. смену введите дату плана!',dfPlanStartDate);
      exit;
   end;
  {
  if dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).AsInteger < 1 then
  begin
    _Error( 'Необходимо ввести бригадира!',
            dfBrig );
    exit;
  end;
  }

  if dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).IsNull then
  begin
    _Error( 'Необходимо ввести бригадира!',
            dfBrig );
    exit;
  end;
  if dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).AsInteger<0 then
  begin
    _Error( 'Необходимо ввести бригадира!',
            dfBrig );
    exit;
  end;

  {22.05.2013}
  if  not  dset_dep.FieldByName('PLANDATEREGL').IsNull then
   if dset_dep.FieldByName('PLANDATEREGL').AsDateTime+1< dset_Dep.FieldByName( 'StartDate' ).AsDateTime
    then
    begin
     _Error('Дата регламента не может быть меньше даты начала работ',dfDateRegl );
     exit;
    end;
  {20.01.2014}
  if not dset_dep.FieldByName('date_close_info').IsNull then
  begin
    if dset_dep.FieldByName('date_close_info').AsDateTime>Date() then
    begin
     _Error('Дата закрытия не может быть больше текущей!',dfdate_closed_info);
     exit;
    end ;
    if Trunc(dset_dep.FieldByName('date_close_info').AsDateTime)<Trunc(dset_Dep.FieldByName( 'StartDate' ).AsDateTime)
    then
    begin
     _Error('Дата закрытия в кап ремонт не  может быть меньше даты начала работ!!',dfdate_closed_info);
     exit;
    end;
   end;
   if  not dset_dep.FieldByName('CAPREM_DATE').IsNull  then
   begin
    if dset_dep.FieldByName('CAPREM_DATE').AsDateTime>Date() then
    begin
      _Error('Дата закрытия в кап ремонт не может быть больше текущей!',db_Date_CapRem);
      exit;
    end ;
    if Trunc(dset_dep.FieldByName('CAPREM_DATE').AsDateTime) <Trunc(dset_Dep.FieldByName( 'StartDate' ).AsDateTime )
    then
     begin
      _Error('Дата закрытия в кап ремонт не  может быть меньше даты начала работ!!',db_Date_CapRem);
      exit;
     end;
  end;


  Result := true;
end;

procedure Tdm_NGDep.dset_DepAfterEdit(DataSet: TDataSet);
begin
  F_IsNeedReopenAfterPost := false;
end;

procedure Tdm_NGDep.dset_DepBeforeDelete(DataSet: TDataSet);
begin
  if ( dset_Dep.RecordCount > 1 ) and
    ( dset_Dep.FieldByName( 'DepNumber' ).AsInteger = 1 ) then
    raise Exception.Create( 'Нельзя удалять первичный выезд, если есть другие выезды!' );
end;

procedure Tdm_NGDep.CommitRetTran;
begin
  RebuildDemnumber;
  tran.CommitRetaining;
end;

procedure Tdm_NGDep.dset_DepBeforePost(DataSet: TDataSet);
var
  _ErrMsg: string;
  _IncorrectField: TDepField;
begin
{
  if not IsFieldsValueCorrect( _ErrMsg, _IncorrectField ) then
    raise EIncorrectDepField.Create( _ErrMsg, _IncorrectField );
}
end;

procedure Tdm_NGDep.OpenVocs;
var
  _AttList: TList;
  i, n: integer;
begin
  _AttList := TList.Create;
  try
     n := 0;
    _AttList.Add( mem_BrigAtt );
    _AttList.Add( mem_DispOpenAtt );
    _AttList.Add( mem_DispCloseAtt );
    _AttList.Add( mem_MessagetypesAtt );
    _AttList.Add( mem_EquipmentAtt );
    _AttList.Add( mem_DispPlanAtt );

    {Для ввода адреса}
    _AttList.Add( mem_streets );
    _AttList.Add( mem_street_2 );
   // _AttList.Add( mem_Locality );
  //  _AttList.Add( mem_Housetype );
    _AttList.Add( mem_Region);

     {Diameter}
      _AttList.Add(mem_Diameter);
      {region_brig)}
     _AttList.Add(mem_region_brig);


    DM_GlobalVocCache.CheckVocs( _AttList );

    for i:=0 to _AttList.Count-1 do
      TDataSet( _AttList.Items[ i ] ).Open;

    mem_EquipmentAtt.First;
   
  if not mem_LookupEquip.Active then mem_LookupEquip.Open;
  if mem_LookupEquip.RecordCount = 0 then
    while not mem_EquipmentAtt.Eof do
      begin
      if mem_EquipmentAtt.FieldByName('id_typ').AsInteger=1 then begin

        n := mem_EquipmentAtt.FieldByName('number').AsInteger;

        mem_LookupEquip.Append;
        mem_LookupEquip.FieldByName('id').AsInteger := mem_EquipmentAtt.FieldByName('id').AsInteger;
        if n = -1 then mem_LookupEquip.FieldByName('snumber').AsString := ' - '
                   else
                       mem_LookupEquip.FieldByName('snumber').AsString := mem_EquipmentAtt.FieldByName('fl_FULL_NAME').asstring;
        mem_LookupEquip.Post;
        end;
        mem_EquipmentAtt.Next;
      end;
    mem_LookupEquip.SortFields := 'snumber';
  finally
    _AttList.Free;
  end;
  dset_locality.Open;
end;

procedure Tdm_NGDep.mem_BrigAttFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FieldByName( 'activity' ).IsNull;
end;

procedure Tdm_NGDep.dset_DepSTARTDATEChange(Sender: TField);
begin
  InputDepFieldChange( Sender );

  if dset_Dep.State in [dsInsert, dsEdit] then
    dset_Dep.FieldByName('fk_departures_OfficialsOpen').AsInteger := F_DefaultOfficialID;
end;

procedure Tdm_NGDep.dset_DepENDDATEChange(Sender: TField);
begin
  InputDepFieldChange( Sender );

  if dset_Dep.State in [dsInsert, dsEdit] then
    dset_Dep.FieldByName('fk_departures_OfficialsClose').AsInteger := F_DefaultOfficialID;
end;

procedure Tdm_NGDep.dset_DepPLANSTARTDATEChange(Sender: TField);
begin
  InputDepFieldChange( Sender );

  if dset_Dep.State in [dsInsert, dsEdit] then
    dset_Dep.FieldByName('fk_departures_OfficialsPlan').AsInteger := F_DefaultOfficialID;
end;


function Tdm_NGDep.GetCurrentDepID: integer;
begin
  if dset_Dep.State <> dsInsert then
    Result := dset_Dep.FieldByName( 'id' ).AsInteger
  else
    Result := -1;
    
end;

Procedure Tdm_NGDep.SetIsReadOnly(const Value: boolean);
begin
  F_IsReadOnly := ( Value ) or
                  ( not DM_RightsManager.IsCurrentUserCanEditForm( DEPARTURESFORMGUID ) ) or
                  ( not DM_RightsManager.IsCurrentDistrictHasAccesToRegion( F_RegionID ) );

  if not DM_RightsManager.IsCurrentUserCanEditForm( DEPARTURESFORMGUID ) then
    F_ConstMsg := 'У вас недостаточно прав для редакт. выездов' else
  if not DM_RightsManager.IsCurrentDistrictHasAccesToRegion( F_RegionID ) then
    F_ConstMsg := 'Вы не можете редакт. выезды для данного района' else
    F_ConstMsg := '';
end;

Procedure Tdm_NGDep.SetIsReadOnlyReg(const Value: boolean);
var _NoFirstForREG: boolean;
begin
  _NoFirstForREG := false ;// ( not F_IsHasFirstDep ) and ( F_DefaultOfficPostID <> DISP_CDP_POST_ID );
  F_IsReadOnly := ( Value ) or
                  ( not DM_RightsManager.IsCurrentUserCanEditForm( DEPARTURESFORMGUID ) ) or
                  ( not DM_RightsManager.IsCurrentDistrictHasAccesToRegion( F_RegionID
                   ) )or
                  ( _NoFirstForREG );

  if not DM_RightsManager.IsCurrentUserCanEditForm( DEPARTURESFORMGUID ) then
    F_ConstMsg := 'У вас недостаточно прав для редакт. выездов' else
  if not DM_RightsManager.IsCurrentDistrictHasAccesToRegion( F_RegionID ) then
    F_ConstMsg := 'Вы не можете редакт. выезды для данного района' else
  if  _NoFirstForREG then
    F_ConstMsg := 'Вы не можете создавать первичный выезд' else
    F_ConstMsg := '';
end;

function Tdm_NGDep.GetCurrentStartDate: TDateTime;
begin
  Result := dset_Dep.FieldByName( 'StartDate' ).AsDateTime;
end;

function Tdm_NGDep.GetCurrentBrigID: integer;
begin
  Result := dset_Dep.FieldByName( 'fk_departures_Brigadiers' ).AsInteger;
end;

procedure Tdm_NGDep.Reset;
begin
  F_DefaultAddInfoForFirstDep := '';
  F_DefaultBrigID := -1;
  F_IsInputDepFieldChange := false;
  F_IsNeedReopenAfterPost := true;
  F_ConstMsg := '';
  F_IsInternalMod := false;
end;

function Tdm_NGDep.GetBrigIDFromLastDep(_OrderID: integer): integer;
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select fk_departures_brigadiers as BrigID' +
      ' from departures' +
      ' where ( fk_departures_orders = ' + IntToStr( _OrderID ) + ' )' +
      ' order by DepNumber asc, StartDate asc');

    if not dset_tmp.IsEmpty then
    begin
      dset_tmp.Last;
      Result := dset_tmp.FieldByName( 'BrigID' ).AsInteger
    end else
      Result := -1;

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.GetBrigIDFromLastDep)' );
    end;
  end;
end;

function Tdm_NGDep.GetBrigIDFromFirstDep(_OrderID: integer): integer;
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select fk_departures_brigadiers as BrigID' +
      ' from departures' +
      ' where ( fk_departures_orders = ' + IntToStr( _OrderID ) + ' )' +
      ' and (DepNumber = 1)');

    if not dset_tmp.Eof then
      Result := dset_tmp.FieldByName( 'BrigID' ).AsInteger
    else
      Result := -1;

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.GetBrigIDFromLastDep)' );
    end;
  end;
end;

function Tdm_NGDep.IsHasDepWithoutEndDate(_OrderID: integer): boolean;
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select count(*) kol' +
      ' from departures' +
      ' where ( fk_departures_orders = ' + IntToStr( _OrderID ) + ' ) and' +
      ' ( depnumber <> 1 ) and' +
      ' ( EndDate is null )' );


    Result := ( dset_tmp.FieldByName( 'kol' ).AsInteger > 0 );

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.IsHasDepWithoutEndDate)' );
    end;
  end;
end;


//{2012
function Tdm_NGDep.GetDetLastDepAddinf(_OrderID: integer): string;
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select additionalinfo' +
      ' from departures' +
      ' where ( fk_departures_orders = ' + IntToStr( _OrderID ) + ' ) ' +
      '  order by DepNumber asc, StartDate asc' );
  if not dset_tmp.IsEmpty then
    begin
      dset_tmp.Last;
      Result :=trim(  dset_tmp.FieldByName( 'additionalinfo' ).asstring );
    end else
      Result := '';

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.GetDetLastDepAddinf)' );
    end;
  end;
end;

//}
//2012
function  Tdm_NGDep.IsSentWorks(_orderid:integer):boolean;
begin
   if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
       ' select count(*) from'+
       ' departureworks dw'+
       ' where dw.fk_depworks_order='+
       IntTOStr(_orderid) +
       ' and dw.sent_1562=1  ');
  if not dset_tmp.IsEmpty then
           Result :=(dset_tmp.FieldByName('Count').AsInteger>0)
     else Result:=false;

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.IsSentWorks)' );
    end;
  end;
end;
//}

function Tdm_NGDep.GetEndDateFromLastDep(_OrderID: integer): TDateTime;
begin
  if tran_tmp.InTransaction then tran_tmp.Rollback;
  tran_tmp.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select EndDate' +
      ' from departures' +
      ' where ( fk_departures_orders = ' + IntToStr( _OrderID ) + ' )' +
      ' order by DepNumber asc, StartDate asc' );

    dset_tmp.Last;
    Result := dset_tmp.FieldByName( 'EndDate' ).AsDateTime;

    tran_tmp.Commit;
  except
    on E: Exception do
    begin
      tran_tmp.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NGDep.GetEndDateFromLastDep)' );
    end;
  end;
end;

procedure Tdm_NGDep.ShowMsg(_Msg: string);
begin
  if Assigned( F_OnShowMsg ) then
  begin
    if trim( F_ConstMsg ) <> '' then
      F_OnShowMsg( F_ConstMsg )
    else
      F_OnShowMsg( _Msg )
  end;
end;

function Tdm_NGDep.IsCanEditCurrentDep: boolean;
begin
  Result := ( dset_Dep.RecordCount < 1 ) or dset_Dep.FieldByName( 'clc_IsCanEdit' ).AsBoolean;
end;

function Tdm_NGDep.IsCanDelCurrentDep: boolean;
begin
  Result := dset_Dep.FieldByName( 'clc_IsCanDel' ).AsBoolean;
end;

{ EIncorrectDepField }

constructor EIncorrectDepField.Create(const Msg: string;
  const DepField: TDepField);
begin
  inherited Create( Msg );
  FDepField := DepField;
end;

procedure Tdm_NGDep.dset_DepBeforeInsert(DataSet: TDataSet);
begin
  F_PrevDepStartDate := dset_Dep.FieldByName( 'StartDate' ).AsDateTime;
 // dset_Dep.FieldByName('fk_departures_region_brig').AsInteger:=F_RegionID;
end;

procedure Tdm_NGDep.dset_DepCalcFields(DataSet: TDataSet);
var
  _IsCanEdit, _IsCanDel
  : boolean;
  _OfficPostInsID, _DepNum: integer;
begin
  _DepNum := dset_Dep.FieldByName( 'DepNumber' ).AsInteger;
  _OfficPostInsID := dset_Dep.FieldByName( 'fk_departures_officpost_ins' ).AsInteger;

  _IsCanDel := ( F_DefaultOfficPostID = _OfficPostInsID );

  if F_DefaultOfficPostID = DISP_CDP_POST_ID then //если диспетчер - диспетчер ЦДП
    _IsCanEdit := true
  else
    _IsCanEdit := ( F_DefaultOfficPostID = _OfficPostInsID );

  //

  dset_Dep.FieldByName( 'clc_IsCanEdit' ).AsBoolean := _IsCanEdit;
  dset_Dep.FieldByName( 'clc_IsCanDel' ).AsBoolean := _IsCanDel;

  if ( not _IsCanEdit ) and ( not F_IsReadOnly ) then
    dset_Dep.FieldByName( 'clc_RecInfo' ).AsString :=
      'Вы не можете корректировать данный выезд'
  else
    dset_Dep.FieldByName( 'clc_RecInfo' ).AsString := '';
end;

procedure Tdm_NGDep.mem_MessagetypesAttFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//
  //Accept := DataSet.FieldByName( 'S_MT_CATEGORY_ID' ).AsInteger = 4;
end;


function Tdm_NGDep.IsInCurShift( _DT: TDateTime): boolean;
begin
  result := (_DT >= F_CurShiftDate + strtotime(g_ShiftStartTime)) and ( _DT < F_CurShiftDate+ 1 + strtotime(g_ShiftStartTime));
end;

function Tdm_NGDep.IsInNextShift(_DT: TDateTime): boolean;
begin
  result := (_DT>= F_CurShiftDate + strtotime(g_ShiftStartTime)) and ( _DT < F_CurShiftDate+ 2 + strtotime(g_ShiftStartTime));
end;

function Tdm_NGDep.IntShift(_Dt:TDateTime):integer;
begin

  result:=floor(_DT-strtotime(g_ShiftStartTime)-F_CurShiftDate)+1;
end;

procedure Tdm_NGDep.AddPlanTOEquipplanned;
var _En, _rescount: integer;
    _dt : TDateTime;
begin
//
 if not dset_Dep.fieldbyname('FK_DEPARTURES_EQUIPMENT').IsNull then
      _en := dset_Dep.fieldbyname('FK_DEPARTURES_EQUIPMENT').AsInteger
   else _en := 0;

if _en >0 then
 begin
     if tran_tmp.InTransaction then tran_tmp.Rollback;
      tran_tmp.StartTransaction;
      try
        _dt:= dset_Dep.FieldByName('PLANSTARTDATE').AsDateTime;

        MyOpenIBDS( dset_tmp,
          ' select count(id) cid ' +
          ' from equipplanned' +
          ' where ( fk_equipplanned_regions = ' + IntToStr( F_RegionID ) + ' )' +
          ' and ( fk_equipplanned_equip = '+ IntToStr(_En) +' )'+
          ' and (eqdate >= '''+ FormatDateTime( 'dd.mm.yyyy', _dt) +''')'+
          ' and (eqdate < '''+ FormatDateTime( 'dd.mm.yyyy', _dt + 1) +''')');

        dset_tmp.First;
        _rescount := dset_tmp.FieldByName( 'cid' ).AsInteger;

        if _rescount = 0 then
        begin
          ds_exectmp.SQL.Text := ' INSERT INTO EQUIPPLANNED (EQDATE, FK_EQUIPPLANNED_EQUIP, FK_EQUIPPLANNED_REGIONS) '+
          'VALUES ('''+  FormatDateTime( 'dd.mm.yyyy',_dt) +' 18:00'', '+ IntToStr(_en) +', '+ IntToStr(F_RegionID) +'); ';
          ds_exectmp.ExecQuery;
        end;
        tran_tmp.Commit;
      except
        on E: Exception do
        begin
          tran_tmp.Rollback;
          raise Exception.Create( E.Message + '(Tdm_NGDep.AddPlanTOEquipplanned)' );
        end;
      end;
 end; //_en >0

//
end;

procedure Tdm_NGDep.SetWithoutOrder(Val:boolean);
var p:integer;
    str:string;
begin
F_WithoutOrder:=val;
if val then
begin
  p:=dset_Dep.SelectSQL.Count;
  dset_Dep.SelectSQL.Insert(p-1,'and (extract(year from d.startdate)=:year)');
// dset_Dep.ParamByName('year').AsInteger:=GetYear(Now());
  str:=dset_Dep.SelectSQL.Text;
   str:=str+' ';
   mem_Region.Filter:='id>0';
   mem_region_brig.Filter:='id>0';
end ;
end ;

procedure Tdm_NGDep.ChangeYear(year:integer);
begin
  dset_Dep.ParamByName('year').AsInteger:=year;
  OpenDepDset;

end;

function Tdm_NGDep.isReadOnlyDate():boolean;
begin
if not dset_Dep.FieldByName('STARTDATE').IsNull and
  isInCurshift(dset_Dep.FieldByName('STARTDATE').AsDateTime) then
   REsult:=false
  else
   Result:=true;
end;


procedure Tdm_NGDep.DataModuleDestroy(Sender: TObject);
begin
if dset_locality.Active then dset_locality.Close;
end;

function Tdm_NGDep.IsFieldsdatereglCorrect( var _ErrMsg: string ): boolean;
function isnotdiamempty():boolean;
begin
  if not(dset_dep.FieldByName('FK_DIAMETER').IsNull) then
   result:=(dset_dep.FieldByName('FK_DIAMETER').AsInteger>0)
  else
   result:=false;
end;
var isdiam:boolean;
begin
  if (dset_dep.FieldByName('PLANDATEREGL').IsNull) then
  begin
    if (isnotdiamempty())and ((dset_dep.FieldByName('DEPNUMBER').AsInteger=1)) then
    begin
      result:=true;

    end else
    begin
      result:=false;
      _ErrMsg:='Дату регламента удалить нельзя не указав диаметр!!';
      ShowMsg(_ErrMsg );
    end

  end
  else
  begin
   if dset_dep.FieldByName('STARTDATE').AsDateTime-1>dset_dep.FieldByName('PLANDATEREGL').AsDateTime then
    begin
     result:=false;
     _ErrMsg:='Дата регламента должна быть не меньше даты выезда!';
     ShowMsg(_ErrMsg );
    end else
     result:=true;
  end;

end;

function Tdm_NGDep.getIsExcavnumber( var can_Read:boolean):boolean; {есть ли зая\вки с раскопками}
begin
 MyOpenIBDS(dset_tmp,Format('select id_1562 ,state_inner from numsorders ns '+
                            ' where ns.id_order=%d and ns.add_excav=1  ' ,
                            [F_orderID]));
 can_Read:=false;
 str_1562:='';
 F_CanAddExcavInfo:=false;
 while not   dset_tmp.Eof do
 begin
  str_1562:=str_1562+','+dset_tmp.fieldbyname('id_1562').AsString;
  if dset_tmp.fieldbyname('state_inner').asinteger=1 then
      F_CanAddExcavInfo:=true;
  can_Read:=true;
  dset_tmp.Next;

 end;
  delete(str_1562,1,1);

end;

//закрытие заявок по благоустройству или в кап в кап ремонт
function Tdm_NGDep.Closed1562(var corInfo:boolean;var corDate:boolean;
                             type1562:Ttype1562 = excav;
                              fieldnameinfo:string = 'EXCAV_CLOSE_INFO';
                              fieldnamedate:string = 'date_close_info'
                              ):boolean;
var  CloseMan: TManClosed1562;
   mes:string;
   sent_1562:string;
   is_excav:boolean;
   can_read:boolean;

 procedure case1562();
 begin
    case  type1562 of
     excav: begin
             sent_1562:=str_1562;
             is_excav:=true;
            end;
     cap_rem: begin
               sent_1562:= str_1562_caprem;
               is_excav:=false;
              end;
    end;
 end;


begin
result:=false;
corInfo:=false;
corDate:=false;
case1562();
 if Dset_Dep.FieldByName('ENDDATE').IsNull then
 begin
    ShowMsg('Нельзя закрывать заявки в незакрытом выезде!');
    Exit;

  end;

if dset_Dep.FieldByName(fieldnamedate).IsNull then
begin
 ShowMsg('Введите дату закрытия!');
 corDate:=true;
 Exit;
end;
if dset_Dep.State=dsBrowse then
 if length(dset_Dep.FieldByName(fieldnameinfo).AsString)<2 then
 begin
   corInfo:=true;
   ShowMsg('Введите информацию для закрытия!');
  end
 else
 try
   CloseMan:=TManClosed1562.Create(1,F_OrderID,sent_1562,f_orderNumber,f_orderDateComing,is_excav,dset_dep.fieldbyname('id').asinteger);
   CloseMan.Cap_Rem:=(type1562 = cap_rem);

   CloseMan.excavCloseInfo:=dset_Dep.fieldbyname(fieldnamedate).AsString+' '+dset_Dep.fieldbyname(fieldnameinfo).AsString+' Бригадир '+dset_Dep.fieldbyname('lp_Brig').AsString;
   try
     case    CloseMan.QuestionClosed1562(mes) of
      -1:  begin
            ShowMsg(mes);
            exit;
           end;
      0: begin
             ShowMsg('Ощибка при закрытии заявок!');
             exit;
         end
   end;
   if CloseMan.doClosed1562<>1 then
     result:=false
   else
     result:=true;
   except
    Result:=false;
   end;
   if result then
     if type1562 = cap_rem then
      setClosedCaprem();
   getIsCapRem();//можно ли еще закрыть заявки кап ремонт

   getIsExcavnumber(can_read);//можно ли закрыть выезд раскопками
 finally
   CloseMan.Free;
 end
else
 ShowMsg('Необходимо сохранть информацию!');


end;


// сохранение по благоустройству или в кап ремонт
function Tdm_NGDep.PostAddExcav(var _ErrMsg:string; fieldnameinf:string = 'EXCAV_CLOSE_INFO';
                                fieldnamedate:string='DATE_CLOSE_INFO';
                                rusmessage:string=' Сохранена только  инфлрмация  по благоустройству'):boolean; //Запомнить поле допинф раскопки
var id:integer;
 begin
 result:=false;
 if tran_tmp.InTransaction then
  tran_tmp.Rollback;

 try
  tran_tmp.StartTransaction;
  id:=dset_Dep.FieldByName( 'id' ).AsInteger;
  ds_exectmp.SQL.Text:=Format('update departures set %s=''%s'' ',[fieldnameinf,
                       dset_Dep.fieldbyname(fieldnameinf).AsString]);
  if  not dset_Dep.fieldbyname(fieldnamedate).IsNull then
      ds_exectmp.SQL.Text:=ds_exectmp.SQL.Text+
                       Format(', %s =''%s'' ',[fieldnamedate,dset_Dep.fieldbyname(fieldnamedate).AsString]);

  ds_exectmp.SQL.Text:=ds_exectmp.SQL.Text+' where id='+dset_Dep.FieldByName( 'id' ).AsString;
  ds_exectmp.ExecQuery;
  tran_tmp.Commit;
  dset_Dep.Transaction.Rollback;
  dset_Dep.Transaction.StartTransaction;
  OpenDepDset;
  dset_Dep.Locate('id',id,[loCaseInsensitive]);

 result:=true;
 ShowMsg(_ErrMsg+rusmessage);
 except
  tran_tmp.Rollback;
 end;
 end;

//проверка данных закрытия   благоустройство в кап ремон
function Tdm_NGDep.ExcavFieldCorrect(var _field:TDepExcavCloseField;
                                      fieldnameinfo:string='excav_close_info';
                                      fieldnamedate:string='date_close_info';
                                      rusermess:string ='по благоустройству'):boolean;
procedure _Error(mess:string;_Infield:TDepExcavCloseField);
begin
   _field:=_Infield;
   Showmsg(mess);

end;
begin
 result:=false;
 if (not dset_dep.FieldByName(fieldnamedate).IsNull) then
 if dset_dep.FieldByName(fieldnamedate).AsDateTime>Date()  then
  begin
    _Error('Дата закрытия не может быть больше текущей!',dfClosedDate);
    exit;
  end;
{ if dset_dep.FieldByName('date_close_info').IsNull   then
   begin
     _Error('Введите датк закрытия !',dfClosedDate);
    exit;
   end;}
 if not( dset_dep.fieldbyname(fieldnameinfo).IsNull) then
 if length(trim(dset_dep.fieldbyname(fieldnameinfo).AsString))<2 then
  begin
   _Error(Format('Введите доп информацию %s!',[rusermess]),dfInfo);
   exit;
  end;
  result:=true;
end;

function Tdm_NGDep.getIsCapRem():boolean;
begin
result:= false;
 MyOpenIBDS(dset_tmp,Format('select id_1562 ,state_inner from numsorders ns '+
                            ' where ns.id_order=%d and ns.add_excav is null and number >0  ' ,
                            [F_orderID]));

 F_CanReadCapRem:=false;
 str_1562_caprem:='';
 F_CanAddCapRemInfo:=false;
 while not   dset_tmp.Eof do
 begin
  str_1562_caprem:=str_1562_caprem+','+dset_tmp.fieldbyname('id_1562').AsString;
  if dset_tmp.fieldbyname('state_inner').asinteger=1 then
      F_CanAddCapRemInfo:=true;
  F_CanReadCapRem:=true;
  dset_tmp.Next;

 end;
  delete(str_1562_caprem,1,1);

end;


function Tdm_NGDep.setClosedCaprem():boolean;
 begin
  if tran_closwedCapRem.InTransaction then
   tran_closwedCapRem.Rollback;
  tran_closwedCapRem.StartTransaction;

  result:=false;
  IBSQLClosedCaprem.SQL.Text:=format('update departures set closedCapRem=1 where id=%d',[dset_Dep.FieldByName( 'id' ).AsInteger]);
  IBSQLClosedCaprem.ExecQuery;
  result:=true;
  tran_closwedCapRem.Commit;
 end;

end.
