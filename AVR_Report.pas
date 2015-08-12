unit AVR_Report;

interface

uses Windows, SysUtils, DB, IBCustomDataSet, FR_Class, FR_DSet, BaseResultForm,
      BaseOptionForm, Forms, GridViewBuilder, Controls, aligrid, ProgressForm,
      Graphics, Classes, CustomReport, Chart, TeenGine, WaitProcessForm,
      DateUtils, MemTable, FrPreviewForm, Variants;

const Region_Count=9 ;

type
  TProce=function (reportName,filename:string):boolean of object;

  TBaseReport=class(TCustomReport)
  protected
    F_RecordCount: integer;
    F_GridViewBuilder: TGridViewBuilder;
    function GetRecordCount: integer;
    procedure ChangeProgreccIndicator(LoadRecCount: integer);
    procedure OrderBtnClick(Sender: TObject); virtual;
    procedure PrintBtnClick(Sender: TObject); virtual;
    procedure ExcelBtnClick(Sender: TObject);
    procedure GraphBtnClick(Sender: TObject); virtual;
    function GetResultFormGrid: TStringAlignGrid;
    procedure ClearDsets;
  protected
    function LoadData: boolean; override;
  protected
    procedure PrepareDsets; virtual;
  public
    destructor Destroy; override;
  public
    function Execute: boolean; override;
  end;

  TOpenOrderSearch=class(TBaseReport)
  private
    procedure BoltStatusCellShow(ShowValue: variant; var Res: string);
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TCloseOrderSearch=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TAllOrderSearch=class(TBaseReport)
  private
    procedure BoltStatusCellShow(ShowValue: variant; var Res: string);
    function DateCaption(dt1, dt2: string): string;
    procedure IsClosedGroupHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TSvodVed=class(TBaseReport)
  protected
    F_PrintDate: TDate;
  protected
    procedure PrepareDmgPlaceHeader(DataSet: TDataSet; var OutRow: TStringList; IsNameCase: boolean);
    procedure OnF5KeyDown(Sender: TObject);
    procedure OnDmgPlaceHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnOrgCellShow(ShowValue: variant; var Res: string);
    procedure OnPlanCellShow(ShowValue: variant; var Res: string);    
    procedure OnBoltStatusCellShow(ShowValue: variant; var Res: string);
    procedure OnFlowSpeedCellShow(ShowValue: variant; var Res: string);
    procedure OnNumDaysShow(ShowValue: variant; var Res: string);
  protected
    procedure PrintBtnClick(Sender: TObject); override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
    function SentRegsMail():boolean ; virtual;
 protected
 procedure OnShowDate(ShowValue: variant; var Res: string);

  public
    constructor Create;    
  end;

  TSvodVed2=class(TSvodVed)
  protected
    procedure OnRegHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnDmgPlaceHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    function prepareCond():string; virtual;
  end;


  {сводвед для отсылки}
  TSvodVed_sent=class(TSvodVed2)
  protected
    procedure InitFields; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareFastReport;   override;
  public
    add_sent:TProce;
    constructor Create;
    function Execute: boolean;   override;

  private
   Cut_Id_reg:integer;
   function prepareCond():string;  override;
  function SentRegsMail:boolean ; override;
  end;

  {сводная ведомость повреждений}
  TSvodVedDamage = class(TSvodVed2)
  protected
   procedure InitFields; override;
   function prepareCond():string ; override;
   procedure CreateForms; override;
   procedure PrepareResultFormHeader; override;
  public
   constructor Create;
  end;

  TSvodVed2Land = class(TSvodVed2) //Сводвед 2, только в альбомном режиме
  protected
    procedure InitFields; override;
  public
    constructor Create;
  end;


  // та же сводная ведомость, только добавлено между районами по 2 пустых строчки
  // и надо убрать колонку с номером по району
  TSvodVed3 = class(TSvodVed)
  protected
    procedure InitFields; override;
  public
    constructor Create;
  end;

  TSvodVed_smena=class(TSvodVed)
  protected
    procedure PrintBtnClick(Sender: TObject); override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareFastReport; override;
  end;

  TClosedBoltsAdres=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TClosedBolts=class(TBaseReport)
  private
    F_IsShowed: boolean;  
  protected
    function ShowOptionForm: boolean; override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TKilledDamage=class(TBaseReport)
  protected
    function DateCaption(dt1, dt2: string): string;
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegGroupFooterCaption(DataSet: TDataSet;
                AggregateValueArr: array of double;var OutRow: TStringList);
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
          AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnCellShow(ShowValue: variant; var Res: string);
  protected
    function LoadData: boolean;override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  public
    destructor Destroy; override;
  end;

  TKilledDamage_vodoset=class(TKilledDamage)
  protected
    procedure InitFields; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormGrid; override;
  end;

  TPayedOrders=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TKilledDamage_director=class(TBaseReport)
  private
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnSoilCellShow(ShowValue: variant; var Res: string);
    procedure OnCellShow(ShowValue: variant; var Res: string);
    procedure OnQCellShow(ShowValue: variant; var Res: string);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TSvodSES=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegGroupFooterCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TClosedOrders=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnNumCellShow(ShowValue: variant; var Res: string);
    procedure OnStrCellShow(ShowValue: variant; var Res: string);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TSpravkaAbon=class(TBaseReport)
  private
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure PrintBtnClick(Sender: TObject); override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TSvodVed_excav=class(TBaseReport)
  protected
    procedure OnDmgPlaceHeaderCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegHeaderCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnDaysCountCellShow(ShowValue: variant; var Res: string);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TProfWorkType=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TSvodVed_OutstandWork=class(TSvodVed_excav)
  protected
    procedure InitFields; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareFastReport; override;
  end;

  TBlagState=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
    procedure OnRegHeaderCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    function LoadData: boolean; override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  public
    destructor Destroy; override;
  end;

  TSearchAdres_PodRep=class(TBaseReport)
  private
    F_IsShowed: boolean;
    F_ID_HouseType: integer;
    F_ID_Street: integer;
    F_HouseNum: string;
    F_AdditionalCondition: string;
  protected
    function ShowOptionForm: boolean; override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  public
    property ID_Street: integer write F_ID_street;
    property ID_HouseType: integer write F_ID_HouseType;
    property HouseNum: string write F_HouseNum;
    property AdditionalCondition: string write F_AdditionalCondition;
  end;

  TLongOrder=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: TDate; DayCount: integer): string;
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TAnalysisLeak=class(TBaseReport)
  private
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegGroupFooterCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnValCellShow(ShowValue: variant; var Res: string);
    procedure OnStrCellShow(ShowValue: variant; var Res: string);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TAnalysisEquipWork=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: TDate): string;
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    function AdditionalCondition: string;
  protected
    procedure GraphBtnClick(Sender: TObject); override;
    procedure OrderBtnClick(Sender: TObject); override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TAnalysisEquipWork_PodRep=class(TBaseReport)
  private
    F_IsShowed: boolean;

    F_EqNumber: string;
    F_EqID: integer;
    F_AdditionalCondition: string;
    F_dt_begin: TDate;
    F_dt_end: TDate;

    function DateCaption: string;
  protected
    function ShowOptionForm: boolean; override;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  public
    property EqNumber: string read F_EqNumber write F_EqNumber;
    property EqID: integer read F_EqID write F_EqID;
    property dt_begin: TDate read F_dt_begin write F_dt_begin;
    property dt_end: TDate read F_dt_end write F_dt_end;
    property AdditionalCondition: string read F_AdditionalCondition
                                    write F_AdditionalCondition;
  end;

  TInstallHatch=class(TBaseReport)
  private
    procedure OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
                  AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;


  TGlavUpr=class(TBaseReport)
  private
    F_NADO_FROM_DATE: string;
    function GenFileName(var AFileName: string): boolean;
    function GenExcelDirName(var ExcelDirName: string): boolean;
  protected
    procedure InitFields; override;
    procedure PrepareDsets; override;
    procedure PrepareFastReport; override;
    function LoadData: boolean; override;
  public
    function Execute: boolean; override;
  end;


  THideLeak=class(TBaseReport)
  private
    procedure OnMainGroupFooterCaption(DataSet: TDataSet;
          AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegGroupHeaderCaption(DataSet: TDataSet;
          AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;



implementation

uses HelpFunctions, AnalysisViewForm, PeriodRegDmgSelForm, GlobalData,
    Buttons, OrderForm, ExcelWorksForm, UniversalSearchForm, PeriodRegDmgAdresForm,
    PeriodCloseRegDmgSelForm, DateDmgSelForm, PeriodCloseDmgExcSelForm,
    SmenaRegDmgSelForm, DateSelForm, PeriodMsgSelForm, PeriodRegBlagSelForm,
    PeriodRegDmgDiamSelForm, PeriodRegPlaceTypeSel, PeriodTimeRegDmgSelForm,
    PeriodRegSelForm, UnChartForm, ChartMarkForm, BaseFrPreviewForm, ztvZip,
    ApplicationSettings, RightsManagerDModule, SvodVedPrintDateForm, ShiftNumForm,
    OrderInfoForm, StringConsts;


{ TBaseReport }

function TBaseReport.Execute: boolean;
begin
  Result:=false;

  if not ShowOptionForm then exit;

  ClearDsets;
  PrepareDsets;
  F_RecordCount:=GetRecordCount;

  if F_RecordCount=0 then
  begin
    Application.MessageBox('Записей удовлетворяющих условию запроса не найдено.',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if F_RecordCount>0 then
      if Application.MessageBox(PChar(Format('Найдено %d записей. Показать?', [F_RecordCount])),
                            gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES	then exit;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;

    LoadData;

    F_ResultForm.ShowModal;
  end;

  Result:=true;
end;


function TBaseReport.GetRecordCount: integer;
begin
  Result:=-1;

  if not Assigned(F_RecordCountDset) then exit;
  if trim(F_RecordCountDset.SelectSQL.Text)='' then exit;

  try
    F_RecordCountDset.Open;
    Result:=F_RecordCountDset.Fields[0].AsInteger;
  except
    F_RecordCountDset.Close;
  end;
end;

procedure TBaseReport.PrepareDsets;
begin
end;

function TBaseReport.LoadData: boolean;
begin
  F_ProgressIndic.Show;

  if F_RecordCount>0 then
  begin
    F_ProgressIndic.Max:=F_RecordCount;
    F_GridViewBuilder.OnLoadRecordCount:=ChangeProgreccIndicator;
  end;
  F_GridViewBuilder.BuildGridView;

  F_ProgressIndic.Hide;
end;

destructor TBaseReport.Destroy;
begin
  F_GridViewBuilder.Free;
  inherited Destroy;
end;



procedure TBaseReport.ChangeProgreccIndicator(LoadRecCount: integer);
begin
  F_ProgressIndic.Position:=LoadRecCount;
end;

procedure TBaseReport.GraphBtnClick(Sender: TObject);
begin
//
end;

procedure TBaseReport.OrderBtnClick(Sender: TObject);
var
  OrderID: integer;
  frm_Order: Tfrm_Order;
  Grid: TStringAlignGrid;
begin
  F_ResultForm.StartWait;
  try
    try
      Grid:=GetResultFormGrid;
      if Assigned(Grid) then
      begin
        if Assigned(Grid.Objects[0, Grid.Row]) then
        begin
          OrderID:=integer(Grid.Objects[0, Grid.Row]);
          frm_Order:=Tfrm_Order.Create(nil, OrderID);
          F_ResultForm.StopWait;
          try
            frm_Order.ShowModal;
            if frm_Order.IsCtrlChange then
              Grid.RowFont[Grid.Row].Color:=clRed;
          finally
            frm_Order.Free;
          end;
        end;
      end;
    except
      F_ResultForm.StopWait;
      raise;
    end;
  finally
    F_ResultForm.StopWait;  
  end;    
end;

procedure TBaseReport.PrintBtnClick(Sender: TObject);
begin
  if not LoadReportFile then exit;
  PrepareFastReport;

  ShowReport;
end;

procedure TBaseReport.ExcelBtnClick(Sender: TObject);
var
  Grid: TStringAlignGrid;
  Title: string;
  CentrLbl, LeftLbl: string;
begin
  Grid:=GetResultFormGrid;
  if not Assigned(Grid) then exit;

  //Только для случая, когда ResultForm - это Tfrm_AnalysiView
  if (F_ResultForm is Tfrm_AnalysisView) then
  begin
    CentrLbl:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
    LeftLbl:=(F_ResultForm as Tfrm_AnalysisView).LeftLabel;
  end else exit;

  with TExcelWorks.Create do
  begin
    try
      Title:=ReplaceChar(CentrLbl, #13, ' ');
      if trim(Title)<>'' then Title:=Title+';';
      Title:=Title+ReplaceChar(LeftLbl, #13, ';');

      Close;
      SetWSName('Результаты поиска');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid(Grid);
    finally
      Free;
    end;
  end;
end;

function TBaseReport.GetResultFormGrid: TStringAlignGrid;
var
  i: integer;
begin
  for i:=0 to F_ResultForm.ComponentCount-1 do
    if (F_ResultForm.Components[i] is TStringAlignGrid) then
    begin
      Result:=(F_ResultForm.Components[i] as TStringAlignGrid);
      break;
    end;
end;

procedure TBaseReport.ClearDsets;
  procedure ClearDS(ds: TIBDataSet);
  begin
    if Assigned(ds) then
    begin
      ds.Close;
      ds.SelectSQL.Clear;
    end;
  end;
var
  i: integer;
begin
  ClearDS(F_RecordCountDset);

  for i:=low(F_Dset) to High(F_Dset) do
    ClearDS(F_Dset[i]);
end;

{ TOpenOrderSearch }

procedure TOpenOrderSearch.BoltStatusCellShow(ShowValue: variant;
  var Res: string);
var
  val:integer;
begin
  val:=VarToInteger(ShowValue);
  if val=0 then
    Res:=''
  else
    Res:='Пер: '+IntToStr(val);
end;
                            
procedure TOpenOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск незакрытых нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Просмотр незакрытых нарядов');
end;

function TOpenOrderSearch.DateCaption(dt1, dt2: string): string;
begin
  Result:='Поиск незакрытых нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TOpenOrderSearch.InitFields;
begin
  F_Name:='Поиск незакрытых нарядов за период';
  F_ReportFileName:='OpenOrderSearch.frf';
end;

procedure TOpenOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL :=' select id, OrderNumber, cast(DateComing as Date) DateComing, '+
           ' cast((current_timestamp-DateComing) as integer) NumDays, '+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+

           ' (select count(id) from closedbolts'+
           ' where fk_closedbolts_orders=o.id and'+
           ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null))) BoltStatus,'+

           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres'+
           ' from orders o '+
           (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
           ' and IsClosed=0 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsClosed=0';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TOpenOrderSearch.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TOpenOrderSearch.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TOpenOrderSearch.PrepareResultFormGrid;
var
  col: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);

    col:=AddColumnToGridViewBuilder(F_GridViewBuilder, 'BoltStatus', 'Откл.', alLeft);
    col.OnShowColumnCell:=BoltStatusCellShow;

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamagePlace', 'Характер'+#13+'повреждения', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'NumDays', 'Количество'+#13+'дней', alCenter);

    IsNumberRecord:=true;
  end;
end;

procedure TOpenOrderSearch.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+StrRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

{ TCloseOrderSearch }

procedure TCloseOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск закрытых нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Просмотр закрытых нарядов');
end;

function TCloseOrderSearch.DateCaption(dt1, dt2: string): string;
begin
  Result:='Поиск закрытых нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TCloseOrderSearch.InitFields;
begin
  F_Name:='Поиск закрытых нарядов за период';
  F_ReportFileName:='CloseOrderSearch.frf';
end;

procedure TCloseOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin

  SelSQL := ' select id, OrderNumber, cast(DateComing as Date) DateComing, cast(DateClosed as Date) DateClosed, '+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres'+
           ' from orders o '+
           (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
           ' and IsClosed=1 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsClosed=1';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TCloseOrderSearch.PrepareFastReport;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TCloseOrderSearch.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TCloseOrderSearch.PrepareResultFormGrid;
var
  col: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'закрытия', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamagePlace', 'Характер'+#13+'повреждения', alLeft);

    IsNumberRecord:=true;
  end;
end;

procedure TCloseOrderSearch.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+StrRegions+#13+
              'Места повреждения: '+strDamagePlace;
  end;
end;

{ TAllOrderSearch }

procedure TAllOrderSearch.BoltStatusCellShow(ShowValue: variant;
  var Res: string);
var
  val:integer;
begin
  val:=VarToInteger(ShowValue);

  if val=0 then
    Res:=''
  else
    Res:='Пер: '+IntToStr(val);
end;

procedure TAllOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск всех нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Поиск всех нарядов');
end;

function TAllOrderSearch.DateCaption(dt1, dt2: string): string;
begin
  Result:='Поиск всех нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TAllOrderSearch.InitFields;
begin
  F_Name:='Поиск всех нарядов за период';
  F_ReportFileName:='AllOrderSearch.frf';
end;

procedure TAllOrderSearch.IsClosedGroupHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  with OutRow do
  begin
    Add('');
    Add('');
    Add('');
    Add('');
    Add('');
    if DataSet.FieldByName('IsClosed').AsInteger=0 then
      Add('ОТКРЫТЫЕ ЗАЯВКИ')
    else
      Add('ЗАКРЫТЕ ЗАЯВКИ');
  end;
end;

procedure TAllOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL :=' select id, OrderNumber, cast(DateComing as Date) DateComing, IsClosed, '+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+

           ' (select count(id) from closedbolts'+
           ' where fk_closedbolts_orders=o.id and'+
           ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null))) BoltStatus,'+

           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres, 1 MainGr '+
           ' from orders o '+
           (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
           ' order by IsClosed, DateComing';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TAllOrderSearch.PrepareFastReport;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TAllOrderSearch.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TAllOrderSearch.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IDFieldName:='ID';

  AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
  AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
  AddColToGVB(F_GridViewBuilder, 'Regions', 'Район', alLeft);
  AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
  AddColToGVB(F_GridViewBuilder, 'BoltStatus', 'Откл.', alLeft, BoltStatusCellShow);
  AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);

  group:=F_GridViewBuilder.AddGroup('MainGr');
  group.GroupHeader.Visible:=false;
  group.GroupFooter.Visible:=false;
  group.IsNumberRecordInGroup:=true;

  group:=F_GridViewBuilder.AddGroup('IsClosed');
  group.GroupHeader.Visible:=true;
  group.GroupHeader.OnShowCaption:=IsClosedGroupHeaderCaption;
  group.GroupHeader.Font.Style:=[fsBold];
  group.GroupHeader.Alignment:=alCenter;
  group.GroupFooter.Visible:=false;
  group.GroupHeader.Color:=clAqua;
  group.IsNumberRecordInGroup:=true;
end;

procedure TAllOrderSearch.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+StrRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

{ TSvodVed }

constructor TSvodVed.Create;
begin
  inherited;
  FLetSendByEmail := TRUE;
end;

procedure TSvodVed.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, F_Name);
  with (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    dp_Coming1.Visible:=false;
    dp_Coming2.Visible:=false;
    lbl_DateComing1.Visible:=false;
    lbl_DateComing2.Visible:=false;
    chk_IsShort.Visible:=true;
    chk_IsMiddle.Visible:=true;
  end;
end;

procedure TSvodVed.InitFields;
begin
  F_Name:='Сводная ведомость основная';
  F_ReportFileName:='SvodVed.frf';
end;

procedure TSvodVed.OnBoltStatusCellShow(ShowValue: variant;
  var Res: string);
var
  val: integer;
begin
  val:=VarToInteger(ShowValue);
  if val<>0 then
    Res:='Откл'
  else
    Res:='';
end;

procedure TSvodVed.OnDmgPlaceHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  PrepareDmgPlaceHeader(DataSet, OutRow, false);
end;

procedure TSvodVed.OnF5KeyDown(Sender: TObject);
var
  OrderID: integer;
  Grid: TStringAlignGrid;
  frm_OrderInfo: Tfrm_OrderInfo;
begin
  Grid:=GetResultFormGrid;
  if not Assigned(Grid) then exit;

  if Assigned(Grid.Objects[0, Grid.Row]) then
  begin
    OrderID:=integer(Grid.Objects[0, Grid.Row]);

    frm_OrderInfo:=Tfrm_OrderInfo.Create(nil, OrderID);
    try
      frm_OrderInfo.ShowModal;
    finally
      frm_OrderInfo.Free;
    end;
  end;
end;

procedure TSvodVed.OnFlowSpeedCellShow(ShowValue: variant;
  var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  if val=0 then
    Res:=''
  else
    Res:=FormatFloat('0.##', val);
end;

procedure TSvodVed.OnNumDaysShow(ShowValue: variant; var Res: string);
var
  _val: integer;
begin
  _val := VarToInteger( ShowValue );
  if _val < 0 then Res := '0';
end;

procedure TSvodVed.OnPlanCellShow(ShowValue: variant; var Res: string);
var
  _val: integer;
begin
  _val := VarToInteger( ShowValue );

  if _val > 0 then Res := '+'
              else Res := '';
end;


procedure TSvodVed.OnOrgCellShow(ShowValue: variant; var Res: string);
const
  O62 = '18';
  not_control = '-1';
var
  _val: String;
  p:integer;
  part:string;
begin
  {_val := VarToString( ShowValue );
  p:=pos('*',_val);
  part = copy(_val,1,(pos('*',_val)-1);
  delete(_val,1,p);
  if (part <> O62) and (part <> not_control ) then result = '*'
  else
   begin

   end
  if _val <> -1 then
  begin
    if _val = O62 then Res := '+'
    else Res := '';
  end else Res := '';
  if _val<-1 then
   Res:='К';
   }
   res := VarToString( ShowValue );
end;


procedure TSvodVed.OnShowDate(ShowValue: variant; var Res: string);
begin
  if  VarIsNull(ShowValue)    then
   Res:= ' '
  else
   res :=DateTimeFormat('dd.mm.yy',( tDate(ShowValue)));
end     ;


procedure TSvodVed.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;



procedure TSvodVed.PrepareDmgPlaceHeader(DataSet: TDataSet;
  var OutRow: TStringList; IsNameCase: boolean);
var
  i: integer;
  pFunc: function (const S: string): string;
begin
  if IsNameCase then
    pFunc:=NameCase
  else
    pFunc:=AnsiUpperCase;

  for i:=1 to 4 do
    OutRow.Add('');

  case DataSet.FieldByName('fk_orders_damageplace').AsInteger of
    1: OutRow.Add(pFunc('НА ВОДОПРОВОДНЫХ СЕТЯХ'));
    2: OutRow.Add(pFunc('НА ВОДОПРОВОДНЫХ ВВОДАХ'));
    3: OutRow.Add(pFunc('В СМОТРОВЫХ КОЛОДЦАХ'));
    4: OutRow.Add(pFunc('НА ВОДОРАЗБОРНЫХ КОЛОНКАХ'));
    6: OutRow.Add(pFunc('НА ШАХТНЫХ КОЛОДЦАХ'));
    7: OutRow.Add(pFunc('АБОНЕНТОВ НЕ СОСТОЯЩИХ НА БАЛАНСЕ ПРЕДПРИЯТИЯ'));
    13: OutRow.Add(pFunc('НЕТ КРЫШЕК ЛЮКОВ НА СМОТРОВЫХ КОЛОДЦАХ'));
    else OutRow.Add(pFunc(trim(DataSet.FieldByName('DamagePlace').AsString)));
  end; //end case;
end;

procedure TSvodVed.PrepareDsets;
var
  SelSQL, CountSQL: string;
  NumShift: integer;
  DateShift: TDate;
  strDateShift: string;
 
begin
  GetShiftsNumAndDate(NumShift, DateShift);

  if DateShift=0 then
    strDateShift:=DateToStr(Date)
  else
    strDateShift:=DateToStr(DateShift);
  SelSQL :=' select o.id, OrderNumber, cast(DateComing as Date) DateComing, FlowSpeed, '+
           ' fk_orders_damageplace, fk_orders_regions,'+
           ' (select result from svod_ved_control_org(o.id))  fk_orders_organisations , '+
           ' cast((cast('+QuotedStr(strDateShift)+' as Date)-cast(DateComing as Date)) as integer) NumDays,'+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
           ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres, '+

           ' (select count(id) from closedbolts'+
           ' where fk_closedbolts_orders=o.id and'+
           ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null))) BoltStatus,'+

           ' 1 MainGr,'+
           ' (select max(d.PLANDATEREGL) from departures d where d.FK_DEPARTURES_ORDERS = o.id) reglDate '+
           ' from orders o '+//* left join departures dd on dd.FK_DEPARTURES_ORDERS=o.id '+
           (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
           ' and IsClosed=0  order by 5, 9, 3';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsClosed=0';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSvodVed.PrepareFastReport;
var
  AddSQL: string;
begin
  {Дополнительный запрос}
{  AddSQL:=' select id, OrderNumber, DateComing, Disconnections, fk_orders_regions, '+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '  o.housenum, o.additionaladdress)) adres '+
          ' from orders o'+
          (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
          ' and IsClosed=0 and'+
          ' id in'+
          ' (select fk_closedbolts_orders from closedbolts'+
          ' where fk_closedbolts_orders=o.id and'+
          ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))'+
          ' order by 6,3';
 }

  AddSQL:=' select id, OrderNumber, DateComing,  fk_orders_regions, '+
          ' (select disconadress from get_disconnections_now(o.id, 0)) Disconnections, '+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '  o.housenum, o.additionaladdress)) adres '+
          ' from orders o'+
          (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
          '  and FK_ORDERS_DAMAGEPLACE <>8' + //and FK_ORDERS_DAMAGEPLACE<>4
          ' and IsClosed=0 and'+
          ' ((select dttm_con from get_disconnections_now(o.id, 0)) is null) and'+
          ' id in'+
          ' (select fk_closedbolts_orders from closedbolts'+
          ' where fk_closedbolts_orders=o.id and'+
          ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))'+
          ' order by 6,3';


  AddSelSQLToDset(F_Dset[1], AddSQL);
  F_Dset[1].Open;

  {/Дополнительный запрос}

  frVariables['PrintDate']:=DateToStr(F_PrintDate);
end;

procedure TSvodVed.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    OnF5KeyDown:=self.OnF5KeyDown;
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TSvodVed.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                      (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);

    column:=AddColumnToGridViewBuilder(F_GridViewBuilder, 'fk_orders_organisations', 'Кон.', alCenter);
    column.OnShowColumnCell:=OnOrgCellShow;

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);

    column:=AddColumnToGridViewBuilder(F_GridViewBuilder, 'BoltStatus', 'Состояние'+#13+'задвижки', alLeft);
    column.OnShowColumnCell:=OnBoltStatusCellShow;

    column:=AddColumnToGridViewBuilder(F_GridViewBuilder, 'FlowSpeed', 'Q', alCenter);
    column.OnShowColumnCell:=OnFlowSpeedCellShow;

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);

    //AddColumnToGridViewBuilder(F_GridViewBuilder, 'NumDays', 'Количество'+#13+'дней', alCenter);
    AddColToGVB( F_GridViewBuilder, 'NumDays', 'Количество'+#13+'дней', alCenter, OnNumDaysShow );

    AddColToGVB( F_GridViewBuilder, 'ReglDate', 'Дата'+#13+'план', alCenter , OnShowDate );


    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=AddGroup('fk_orders_damageplace');
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.OnShowCaption:=OnDmgPlaceHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clGrayText;
    group.GroupHeader.OnShowCaption:=OnRegHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
  end; //end with
end;

procedure TSvodVed.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводная ведомость повреждений на '+DateToStr(Date);
    LeftLabel:='Районы: '+strRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

procedure TSvodVed.PrintBtnClick(Sender: TObject);
var
  frm_Date: Tfrm_SvodVedPrintDate;
  file_name: string;
  num_shift: integer;
  date_shift: TDate;
  shot_fname:string;
begin
  if DM_RightsManager.IsCurrentUserDisp then
  begin
    GetShiftsNumAndDate(num_shift, date_shift);
    F_PrintDate:=date_shift;
  end else F_PrintDate:=Date;

  frm_Date:=Tfrm_SvodVedPrintDate.Create(nil);
  try
    frm_Date.Dt:=F_PrintDate;
    if frm_Date.ShowModal=mrOk then
    begin
      F_PrintDate:=frm_Date.Dt;
      if (ClassName='TSvodVed_sent') and (DM_RightsManager.IsCurrentUserDisp) then
      begin
        (F_Report.Preview.Owner as Tfrm_FrPreview).NeedAsk:=true;
         (F_Report.Preview.Owner as Tfrm_FrPreview).bb_Mail.Visible:=true;
       end;
      inherited;

      if ( DM_RightsManager.IsCurrentUserDisp ) and ( FLetSendByEmail or  (F_Report.Preview.Owner as Tfrm_FrPreview).ToMail)
      then
      begin
        {Отправка по почте}
        {
        file_name:=trim(AppSettings.Get_Abon_Path+
                    'svod_ved_'+ReplaceChar(DateToStr(Date), '.', '_'));
        }
         if classname<>'TSvodVed_sent' then
         begin
          shot_fname:='svod_ved_';
           file_name := trim( AppSettings.Get_Abon_Path ) + shot_fname +
                      FormatDateTime( 'dd_mm_yyyy', F_PrintDate )+
                      '(' + FormatDateTime( 'ddmmyy_hhmm', Now ) + ')';
      {  if classname='TSvodVed_sent' then
        begin
          if ExportFastReportToExcel( F_Report, file_name )  then
        SendByEmail( ZipFile(file_name)
            , 'Ведомость аварийных ситуаций на водопроводных сетях г. Харькова на '+DateToStr(Date));


        end
        else }
         ExportFRToRTFAndSendByEmail(F_Report, file_name, F_Name);
        {/Отправка по почте}
        end;
        SentRegsMail;
      end;
    end;
  finally
    frm_Date.Free;
  end;
end;

function TSvodVed.SentRegsMail():boolean ;
  begin
   result:=false;
  end;

{ TClosedBoltsAdres }

procedure TClosedBoltsAdres.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodRegDmgAdresSel.Create(nil, 'Сводка перек. задвижек по району и адресу аварии');
  (F_OptionForm as Tfrm_PeriodRegDmgAdresSel).ShortTableName:='o';
end;

function TClosedBoltsAdres.DateCaption(dt1, dt2: string): string;
begin
  Result:='Сводка по перекрытым задвижкам'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TClosedBoltsAdres.InitFields;
begin
  F_Name:='Сводка по перекрытым задвижкам(выбор адреса)';
//  if (F_OptionForm as Tfrm_PeriodRegDmgAdresSel)._typ =1 then
  // F_ReportFileName:='ClosedBoltsAdres1.frf'
 // else
   F_ReportFileName:='ClosedBoltsAdres.frf';
end;

procedure TClosedBoltsAdres.PrepareDsets;
var
  SelSQL, CountSQL, CondSQL: string;
begin
  CondSQL := ' and b.fk_closedbolts_orders=o.id';
 if   (F_OptionForm as Tfrm_PeriodRegDmgAdresSel)._typ =0 then
    CondSQL:= CondSQL+' and (b.fk_closedbolts_brigadieropen=-1 or b.fk_closedbolts_brigadieropen is null)';


{  CondSQL := ' and b.fk_closedbolts_orders=o.id'+
             ' and (b.fk_closedbolts_brigadieropen=-1 or b.fk_closedbolts_brigadieropen is null)';}
             //будем выбирать все задвижки за период не зависимо закрытые иои нет

  SelSQL:=' select o.id, o.OrderNumber, cast(b.closedate as Date) CloseDate,'+
          ' cast(b.opendate as Date) OpenDate,' +
          ' (select name from brigadiers where id=b.fk_closedbolts_brigadiersclose) BrigadierClose,'+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+

          ' (select adres from Get_adres(b.fk_closedbolts_housetype,'+
          ' b.fk_closedbolts_streets, b.housenum, b.additionaladdress)) BoltAdres,'+

          ' (select adres from Get_adres(o.fk_orders_housetypes,'+
          ' o.fk_orders_streets, o.housenum, o.additionaladdress)) AvarAdres'+

          ' from orders o, closedbolts b'+
          (F_OptionForm as Tfrm_PeriodRegDmgAdresSel).ResultCondition+
          CondSQL+
          ' order by CloseDate';

  CountSQL:='select count(o.id) RecordCount from orders o, closedbolts b '+
          (F_OptionForm as Tfrm_PeriodRegDmgAdresSel).ResultCondition+
          CondSQL;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TClosedBoltsAdres.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgAdresSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
  end;
end;

procedure TClosedBoltsAdres.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TClosedBoltsAdres.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IDFieldName:='ID';
  F_GridViewBuilder.IsNumberRecord:=true;

  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'CloseDate', 'Дата'+#13+'закрытия', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'BrigadierClose', 'Кто'+#13+'закрыл', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'BoltAdres', 'Адрес'+#13+'задвижки', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'AvarAdres', 'Адрес'+#13+'аварии', alLeft);


  if (F_OptionForm as Tfrm_PeriodRegDmgAdresSel)._typ =1 then
  begin
   AddColumnToGridViewBuilder(F_GridViewBuilder, 'OpenDate', 'Дата'+#13+'открытия', alCenter);
   F_ReportFileName:='ClosedBoltsAdres1.frf';
  end;

  //подсовываем дркгой файл репорта

end;

procedure TClosedBoltsAdres.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgAdresSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
  end;
end;

{ TClosedBolts }
procedure TClosedBolts.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TClosedBolts.InitFields;
begin
  F_Name:='Сводка по перекрытым задвижкам';
  F_ReportFileName:='ClosedBolts.frf';
  F_IsShowed:=false;
end;

procedure TClosedBolts.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=' select o.id, o.OrderNumber, cast(o.DateComing as Date) DateComing, cast(b.closedate as Date) CloseDate,'+
          ' (select name from brigadiers where id=b.fk_closedbolts_brigadiersclose) BrigadierClose,'+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select diameter from s_Tubediameter where id=b.fk_closedbolts_tubediam) Diameters,'+

          ' (select adres from Get_adres(b.fk_closedbolts_housetype,'+
          ' b.fk_closedbolts_streets, b.housenum, b.additionaladdress)) BoltAdres'+

          ' from orders o, closedbolts b'+
          ' where b.fk_closedbolts_orders=o.id'+
          ' and (b.fk_closedbolts_brigadieropen=-1 or b.fk_closedbolts_brigadieropen is null)'+
          ' order by DateComing';

  CountSQL:=' select count(o.id) RecordCount'+
            ' from orders o, closedbolts b '+
            ' where b.fk_closedbolts_orders=o.id'+
            ' and (b.fk_closedbolts_brigadieropen=-1 or b.fk_closedbolts_brigadieropen is null)';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TClosedBolts.PrepareFastReport;
begin
  //frVariables['Caption']:='Сводка по перекрытым задвижкам на '+;
end;

procedure TClosedBolts.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TClosedBolts.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IsNumberRecord:=true;
  F_GridViewBuilder.IDFieldName:='ID';

  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'BoltAdres', 'Адрес'+#13+'задвижки', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Diameters', 'Диам.', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'CloseDate', 'Дата'+#13+'закрытия', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'BrigadierClose', 'Ответственный', alLeft);
end;

procedure TClosedBolts.PrepareResultFormHeader;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    CenterLabel:='Сводка по перекрытым задвижкам на '+DateToStr(Date);
  end;
end;

function TClosedBolts.ShowOptionForm: boolean;
begin
  if F_IsShowed then
    Result:=false
  else
    Result:=true;

  F_IsShowed:=true;
end;

{ TKilledDamage }

procedure TKilledDamage.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodCloseRegDmgSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ShortTableName:='o';
end;

function TKilledDamage.DateCaption(dt1, dt2: string): string;
begin
  Result:='Ведомость ликвидированных повреждений'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

destructor TKilledDamage.Destroy;
begin
  F_Dset[0].Close;
  F_Dset[0].CachedUpdates:=false;
  F_Dset[0].ModifySQL.Clear;
  inherited Destroy;
end;

procedure TKilledDamage.InitFields;
begin
  F_Name:='Сводка по ликвидированным повреждениям';
  F_ReportFileName:='KilledDamage.frf';
end;

function TKilledDamage.LoadData: boolean;
begin
  F_ProgressIndic.Max:=F_RecordCount;
  F_ProgressIndic.Show;

  with F_Dset[0] do
  begin
    //
    {Меняем только КЭШ, базу не трогаем}
    CachedUpdates:=true;
    ModifySQL.Clear;
    ModifySQL.Add('update orders set OrderNumber=:OrderNmber where id=:id');
    //
    Open;
    First;
    while not Eof do
    begin
      Edit;
      case FieldByName('fk_orders_damagetype').AsInteger of
        1: FieldByName('Treshina').AsInteger:=1;
        2: FieldByName('Perelom').AsInteger:=1;
        3: FieldByName('StSoed').AsInteger:=1;
        4: FieldByName('Svish').AsInteger:=1;
        5: FieldByName('Prochee').AsInteger:=1;
      end; //end case
      //if FieldByName('excwt').IsNull then
      //  FieldByName('excwt').AsString:='Не раскопано';
      if not FieldByName('fk_orders_off_withoutexcav').IsNull then
       
         FieldByName('Excwt').AsString:=WithoutExcav;
      Next;
      F_ProgressIndic.Position:=F_ProgressIndic.Position+1;
    end;
  end; //end with

  F_GridViewBuilder.BuildGridView;

  F_ProgressIndic.Hide;
end;

procedure TKilledDamage.OnCellShow(ShowValue: variant; var Res: string);
begin
  if VarToInteger(ShowValue)=0 then
    Res:='';
end;

procedure TKilledDamage.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add('');

  OutRow.Add('ВСЕГО ПО РАЙОНАМ: '+FloatToStr(AggregateValueArr[0]));

  for i:=1 to 4 do
    OutRow.Add('');

  for i:=1 to 5 do
    OutRow.Add(FloatToStr(AggregateValueArr[i]));
end;

procedure TKilledDamage.OnRegGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add('');

 OutRow.Add('Всего по району: '+FloatToStr(AggregateValueArr[0]));

  for i:=1 to 4 do
    OutRow.Add('');

  for i:=1 to 5 do
    OutRow.Add(FloatToStr(AggregateValueArr[i]));
end;

procedure TKilledDamage.OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add('');
  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;

procedure TKilledDamage.PrepareDsets;
var
  SelSQL, CountSQL, CondSQL: string;
begin
  CondSQL:= ' and IsClosed=1 and o.fk_orders_damagetype=d.id and'+
            ' o.fk_orders_damagetype<>-1 and o.fk_orders_damageplace<7';

  SelSQL := ' select o.id, o.OrderNumber,  o.fk_orders_off_withoutexcav, '+
            '    cast(o.DateComing as Date) DateComing,'+
            ' cast(o.DateClosed as Date) DateClosed, d.name DamageType,'+
            ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
            ' o.fk_orders_regions, o.fk_orders_damagetype, 1 MainGroup,'+
            ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
            ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
            ' (select diameter from s_Tubediameter where id=o.fk_orders_diameters) Diameters,'+

            ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
            '     o.housenum, o.additionaladdress)) adres,'+

            ' (select workname from s_excavationworktypes where id=o.LastExcWrkType) excwt,'+
{
            ' (select workname from s_excavationworktypes where id='+
            '     (select fk_excavations_excwt from excavations where fk_excavations_orders=o.id'+
            '         and id=(select max(id) from excavations where fk_excavations_orders=o.id)'+
            '     )'+
            ' ) excwt,'+
}
            ' (select number from equipment where id='+
            '     (select fk_eqwork_equip from equipwork'+
            '      where fk_eqwork_orders=o.id and'+
            '      id=(select min(id) from equipwork where fk_eqwork_orders=o.id)'+
            '     )'+
            ' )equipment,'+
            ' 0 Treshina, 0 Perelom, 0 stsoed, 0 svish, 0 prochee,'+
            ' (select square from excavations where id='+
            '      ('+
//            '      select last_excav_id from get_last_excav_id_for_order(o.id)' +
            '      select max(id) from excavations where fk_excavations_orders=o.id'+
            '      )'+
            ' ) square'+
            ' from orders o, s_damagetype d'+
            (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
            CondSQL+
            ' order by 7,2';

  CountSQL:='select count(o.id) RecordCount from orders o, s_damagetype d'+
            (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
            CondSQL;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TKilledDamage.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodCloseRegDmgSel do
  begin
    frVariables['Caption']:=ReplaceChar(DateCaption(strStartDate, strFinishedDate), #13, ' ');
    frVariables['RegionCaption']:='Районы: '+strRegions;
    frVariables['DamageCaption']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TKilledDamage.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TKilledDamage.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Diameters', 'Диаметер', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'ликвидации', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Treshina', 'Трещина', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Perelom', 'Перелом', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'StSoed', 'Ст.соед.', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Svish', 'Свищ', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Prochee', 'Прочие', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Excwt', 'Раск./засып.', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Equipment', 'Раб.'+#13+'оборудование', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Square', 'м2', alCenter, OnCellShow);

    group:=AddGroup('MainGroup');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clAqua;
    group.GroupFooter.Alignment:=alCenter;
    group.AddAggregateField(atCount, 'fk_orders_regions');
    group.AddAggregateField(atSum, 'Treshina');
    group.AddAggregateField(atSum, 'Perelom');
    group.AddAggregateField(atSum, 'StSoed');
    group.AddAggregateField(atSum, 'Svish');
    group.AddAggregateField(atSum, 'Prochee');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.AddAggregateField(atCount, 'fk_orders_regions');
    group.AddAggregateField(atSum, 'Treshina');
    group.AddAggregateField(atSum, 'Perelom');
    group.AddAggregateField(atSum, 'StSoed');
    group.AddAggregateField(atSum, 'Svish');
    group.AddAggregateField(atSum, 'Prochee');
    group.GroupFooter.OnShowCaption:=OnRegGroupFooterCaption;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clGrayText;
    group.GroupFooter.Alignment:=alCenter;
  end; // end with
end;

procedure TKilledDamage.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodCloseRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+strRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

{ TKilledDamage_vodoset }

procedure TKilledDamage_vodoset.InitFields;
begin
  F_Name:='Сводка по ликвидированным повреждениям(водосеть)';
  F_ReportFileName:='KilledDamage_vodoset.frf';
end;

procedure TKilledDamage_vodoset.PrepareDsets;
var
  SelSQL, CountSQL, CondSQL: string;
begin
  CondSQL:= ' and IsClosed=1 and o.fk_orders_damagetype=d.id and'+
            ' o.fk_orders_damagetype<>-1 and o.fk_orders_damageplace<7';

  SelSQL := ' select o.id, o.OrderNumber, DateClosed, d.name DamageType,'+
            ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
            ' o.fk_orders_regions, o.fk_orders_damagetype, 1 MainGroup, fk_orders_off_withoutexcav,'+
            ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
            ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
            ' (select diameter from s_Tubediameter where id=o.fk_orders_diameters) Diameters,'+
            ' (select min(StartDate) from departures where depnumber<>1 and fk_departures_orders=o.id) StartDate,'+
            ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
            '      o.housenum, o.additionaladdress)) adres,'+
            '  0 Treshina, 0 Perelom, 0 stsoed, 0 svish, 0 prochee,'+
            '  ''0'' excwt'+
            ' from orders o, s_damagetype d'+
            (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
            CondSQL+
            ' order by 5,2';

  CountSQL:='select count(o.id) RecordCount from orders o, s_damagetype d'+
            (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
            CondSQL;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TKilledDamage_vodoset.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Diameters', 'Диаметер', alCenter);
    AddColToGVB(F_GridViewBuilder, 'StartDate', 'Дата/время'+#13+'начала работ', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата/время'+#13+'окон. работ', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Treshina', 'Трещина', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Perelom', 'Перелом', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'StSoed', 'Ст.соед.', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Svish', 'Свищ', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'Prochee', 'Прочие', alCenter, OnCellShow);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность'+#13+'повреждения', alLeft);


    group:=AddGroup('MainGroup');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clAqua;
    group.GroupFooter.Alignment:=alCenter;
    group.AddAggregateField(atCount, 'fk_orders_regions');
    group.AddAggregateField(atSum, 'Treshina');
    group.AddAggregateField(atSum, 'Perelom');
    group.AddAggregateField(atSum, 'StSoed');
    group.AddAggregateField(atSum, 'Svish');
    group.AddAggregateField(atSum, 'Prochee');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.AddAggregateField(atCount, 'fk_orders_regions');
    group.AddAggregateField(atSum, 'Treshina');
    group.AddAggregateField(atSum, 'Perelom');
    group.AddAggregateField(atSum, 'StSoed');
    group.AddAggregateField(atSum, 'Svish');
    group.AddAggregateField(atSum, 'Prochee');
    group.GroupFooter.OnShowCaption:=OnRegGroupFooterCaption;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clGrayText;
    group.GroupFooter.Alignment:=alCenter;
  end; // end with
end;

{ TPayedOrders }

procedure TPayedOrders.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск платных нарядов');
  (F_OptionForm as Tfrm_PeriodRegDmgSel).btn_DamagePlace.Visible:=false;
end;

function TPayedOrders.DateCaption(dt1, dt2: string): string;
begin
  Result:='Сводка о работах абонента'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TPayedOrders.InitFields;
begin
  F_Name:='Сводка платных нарядов';
  F_ReportFileName:='PayedOrders.frf';
end;

procedure TPayedOrders.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL := ' select id, OrderNumber, cast(DateComing as Date) DateComing, Abonent,' +
            ' (select orderworks from get_orderworks( o.id, 0, 1 )) WhatIsDone,'+
            ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
            ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
            ' (select adres from Get_adres(o.fk_orders_housetypes,'+
            '     o.fk_orders_streets, o.housenum, o.additionaladdress)) adres'+
            ' from orders o'+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsPayed=1 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsPayed=1';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TPayedOrders.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+strRegions;
  end;
end;

procedure TPayedOrders.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TPayedOrders.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                    (F_ResultForm as Tfrm_AnalysisView).Grid);

  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район');
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес');
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения');
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Abonent', 'Абонент');
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'WhatIsDone', 'Что сделано');
end;

procedure TPayedOrders.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+StrRegions;
  end;
end;

{ TKilledDamage_director }

procedure TKilledDamage_director.CreateForms;
begin
  F_OptionForm:=Tfrm_DateDmgSel.Create(nil);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TKilledDamage_director.InitFields;
begin
  F_Name:='Сводка по ликвид. повреждениям для Ген. директора';
  F_ReportFileName:='KilledDamage_director.frf';
end;

procedure TKilledDamage_director.OnCellShow(ShowValue: variant;
  var Res: string);
begin
  if VarToInteger(ShowValue)=0 then
    Res:='';
end;

procedure TKilledDamage_director.OnQCellShow(ShowValue: variant;
  var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  Res:=FormatFloat('0.##', val);
end;

procedure TKilledDamage_director.OnRegGroupHeaderCaptionShow(
  DataSet: TDataSet; AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;

procedure TKilledDamage_director.OnSoilCellShow(ShowValue: variant;
  var Res: string);
begin
  if AnsiUpperCase(trim(VarToString(ShowValue)))='<ПУСТО>' then
    Res:='';
end;

procedure TKilledDamage_director.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=' select id, OrderNumber, cast(DateComing as Date) DateComing, cast(DateClosed as Date) DateClosed,'+
          ' LocationDepth, FlowSpeed, fk_orders_regions,' +
          ' (select orderworks from get_orderworks( o.id, 0, 1 )) whatisdone,'+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
          ' (select diameter from s_Tubediameter where id=o.fk_orders_diameters) Diameters,'+
          ' (select name from s_Soil where id=o.fk_orders_soil) Soil,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '          o.housenum, o.additionaladdress)) adres, 1 MainGr'+
          ' from orders o'+
          (F_OptionForm as Tfrm_DateDmgSel).ResultCondition+
          ' and IsClosed=1 order by 9,2';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_DateDmgSel).ResultCondition+
            ' and IsClosed=1';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TKilledDamage_director.PrepareFastReport;
begin
  with (F_OptionForm as Tfrm_DateDmgSel) do
  begin
    frVariables['Caption']:='Сводка ликвидированных повреждений для '+
                            'генерального директора ТПО "Харьковкоммунпромвод" за '+strDate;
    frVariables['DamagePlace']:='Место повреждения: '+strDamagePlace;
  end;
end;

procedure TKilledDamage_director.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TKilledDamage_director.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                            (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Diameters', 'Диаметер', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'ликвидации', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Soil', 'Грунт', alLeft, OnSoilCellShow);
    AddColToGVB(F_GridViewBuilder, 'FlowSpeed', 'Q', alCenter, OnQCellShow);
    AddColToGVB(F_GridViewBuilder, 'LocationDepth', 'Глубина'+#13+'заложения', alCenter, OnCellShow);

    group:=AddGroup('MainGr');
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;
    group.IsNumberRecordInGroup:=true;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.Color:=clGrayText;
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
  end; //end with
end;

procedure TKilledDamage_director.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_DateDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводная ведомость по ликв. повреждениям'+#13+'за '+strDate;
    Leftlabel:='Место повреждения: '+strDamagePlace;
  end;
end;

{ TSvodSES }

procedure TSvodSES.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodCloseRegDmgSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TSvodSES.DateCaption(dt1, dt2: string): string;
begin
  Result:='Сводная ведомость для СЭС'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TSvodSES.InitFields;
begin
  F_Name:='Сводка в СЭС';
  F_ReportFileName:='SvodSES.frf';
end;

procedure TSvodSES.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add(''); OutRow.Add('');
  OutRow.Add('ВСЕГО ПО РАЙОНАМ: '+FloatToStr(AggregateValueArr[0]));
end;

procedure TSvodSES.OnRegGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add(''); OutRow.Add('');
  OutRow.Add('Всего по району: '+FloatToStr(AggregateValueArr[0]));
end;

procedure TSvodSES.OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add(''); OutRow.Add('');
  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;

procedure TSvodSES.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  //Запрос был изменен при добавлении формы "Выездов"
  SelSQL:=
    ' select id, fk_orders_regions,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select cast(min(startdate) as date) from departures where fk_departures_orders=o.id and depnumber<>1) StartDate,'+
    ' (select cast(max(enddate) as date) from departures where fk_departures_orders=o.id) EndDate,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres, 1 MainGr'+
    ' from orders o'+
    (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
    ' and IsClosed=1 and fk_orders_damageplace<7 order by 3,5,6';

  CountSQL:=
    'select count(id) RecordCount from orders o '+
    (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
    ' and IsClosed=1 and fk_orders_damageplace<7';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSvodSES.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodCloseRegDmgSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TSvodSES.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TSvodSES.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                        (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'StartDate', 'Дата начала'+#13+'ликвидации', alCenter);
    AddColToGVB(F_GridViewBuilder, 'EndDate', 'Дата окончания'+#13+'ликвидации', alCenter);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.AddAggregateField(atCount, 'MainGr');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clAqua;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clGrayText;
    group.AddAggregateField(atCount, 'fk_orders_regions');
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
    group.GroupFooter.OnShowCaption:=OnRegGroupFooterCaption;
  end;
end;

procedure TSvodSES.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodCloseRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+StrRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

{ TClosedOrders }

procedure TClosedOrders.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodCloseDmgExcSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_PeriodCloseDmgExcSel).ShortTableName:='o';

  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TClosedOrders.DateCaption(dt1, dt2: string): string;
begin
  Result:='Ведомость закрытых нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TClosedOrders.OnNumCellShow(ShowValue: variant; var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  if VarToFloat(ShowValue)=0 then
    Res:=''
  else
    Res:=FormatFloat('0.##', val);
end;

procedure TClosedOrders.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('Итого:');
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure TClosedOrders.OnStrCellShow(ShowValue: variant; var Res: string);
begin
  if AnsiUpperCase(trim(VarToString(ShowValue)))='<ПУСТО>' then
    Res:='';  
end;

procedure TClosedOrders.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=' select id, OrderNumber, DateComing, DateClosed,'+
          ' LocationDepth, FlowSpeed, 1 MainGr, '+
          ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
          ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
          ' (select name from s_TubeMaterial where id=o.fk_orders_tubematerial) TubeMaterial,'+
          ' (select diameter from s_Tubediameter where id=o.fk_orders_diameters) Diameters,'+
          ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
          ' (select name from s_Soil where id=o.fk_orders_soil) Soil,'+
          ' (select workname from s_excavationworktypes where id=o.LastExcWrkType) excwt,'+
{
          ' (select workname from s_excavationworktypes where id='+
          '     (select fk_excavations_excwt from excavations where fk_excavations_orders=o.id'+
          '         and id=(select max(id) from excavations where fk_excavations_orders=o.id)'+
          '     )'+
          ' ) excwt,'+
}
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '     o.housenum, o.additionaladdress)) adres'+
          ' from orders o'+
          (F_OptionForm as Tfrm_PeriodCloseDmgExcSel).ResultCondition+
          ' and IsClosed=1 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders o'+
            (F_OptionForm as Tfrm_PeriodCloseDmgExcSel).ResultCondition+
            ' and IsClosed=1';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TClosedOrders.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата/время'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата/время'+#13+'ликвидации', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'FlowSpeed', 'Утечка,'+#13+'м3', alCenter, OnNumCellShow);
    AddColToGVB(F_GridViewBuilder, 'Diameters', 'Диаметер', alCenter, OnNumCellShow);
    AddColToGVB(F_GridViewBuilder, 'LocationDepth', 'Глубина'+#13+'заложения', alCenter, OnNumCellShow);
    AddColToGVB(F_GridViewBuilder, 'Soil', 'Грунт', alLeft, OnStrCellShow);
    AddColToGVB(F_GridViewBuilder, 'TubeMaterial', 'Материал'+#13+'трубы', alLeft, OnStrCellShow);
    AddColToGVB(F_GridViewBuilder, 'DamageType', 'Тип'+#13+'повреждения', alLeft, OnStrCellShow);
    AddColToGVB(F_GridViewBuilder, 'ExcWt', 'Раскопка', alLeft);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.AddAggregateField(atCount, 'MainGr');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;
    group.GroupFooter.Color:=clYellow;
    group.GroupFooter.Font.Style:=[fsBold];
  end; //end
end;

procedure TClosedOrders.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodCloseDmgExcSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    Leftlabel:='Места повреждения: '+strDamagePlace+#13+
                'Типы раскопок: '+strExcWorkType;
  end;
end;

procedure TClosedOrders.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TClosedOrders.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodCloseDmgExcSel do
  begin
    frVariables['Caption']:=ReplaceChar(DateCaption(strStartDate, strFinishedDate),#13,' ');
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
    frVariables['ExcWorkType']:='Типы раскопок: '+strExcWorkType;
  end;
end;

procedure TClosedOrders.InitFields;
begin
  F_Name:='Ведомость закрытых нарядов';
  F_ReportFileName:='ClosedOrders.frf';
end;

{ TSvodVed_smena }

procedure TSvodVed_smena.CreateForms;
begin
  F_OptionForm:=Tfrm_SmenaRegDmgSel.Create(nil);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TSvodVed_smena.InitFields;
begin
  F_Name:='Сводная ведомость за смену';
  F_ReportFileName:='SvodVed_smena.frf';
end;

procedure TSvodVed_smena.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL :=' select id, OrderNumber, cast(DateComing as Date) DateComing, FlowSpeed, '+
           ' fk_orders_damageplace, fk_orders_regions,'+
           ' (select result from svod_ved_control_org(o.id)) fk_orders_organisations , '+
           ' cast(current_timestamp-DateComing as integer) NumDays, '+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
           ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres, '+

           ' (select count(id) from closedbolts'+
           ' where fk_closedbolts_orders=o.id and'+
           ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null))) BoltStatus,'+

           ' 1 MainGr ,'+
            ' (select max(d.PLANDATEREGL) from departures d where d.FK_DEPARTURES_ORDERS = o.id) reglDate '+
           ' from orders o '+
           (F_OptionForm as Tfrm_SmenaRegDmgSel).ResultCondition+
           ' order by 10, 9, 2 ';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_SmenaRegDmgSel).ResultCondition;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;


procedure TSvodVed_smena.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_SmenaRegDmgSel do
  begin
    frVariables['Caption']:='Сводная ведомость повреждений за '+strDate;
    frVariables['Regions']:='Районы: '+strRegions;
    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
end;

procedure TSvodVed_smena.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_SmenaRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводная ведомость повреждений'+#13+'за '+strDate;
    LeftLabel:='Районы: '+strRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

procedure TSvodVed_smena.PrintBtnClick(Sender: TObject);
begin
  if not LoadReportFile then exit;
  PrepareFastReport;

  ShowReport;
end;

{ TSpravkaAbon }

procedure TSpravkaAbon.CreateForms;
begin
  F_OptionForm:=Tfrm_DateSel.Create(nil);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TSpravkaAbon.InitFields;
begin
  F_Name:='Справка в Абонентный отдел';
  F_ReportFileName:='SpravkaAbon.frf';
end;

procedure TSpravkaAbon.OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('');
  OutRow.Add('');
  OutRow.Add(NameCase(DataSet.FieldByName('regions').AsString)+' район');
end;

procedure TSpravkaAbon.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL := ' select id, cast(DateComing as Date) DateComing,' +
            ' (select orderworks from get_orderworks( o.id, 0, 1 )) WhatIsDone, fk_orders_regions,'+
            ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
            ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
            '     o.housenum, o.additionaladdress)) adres, 1 MainGr'+
            ' from orders o'+
            (F_OptionForm as Tfrm_DateSel).ResultCondition+
            ' and IsClosed=0 and fk_orders_damageplace=7'+
            ' order by 5,2';

  CountSQL:='select count(id) RecordCount from orders o '+
            (F_OptionForm as Tfrm_DateSel).ResultCondition+
            ' and IsClosed=0 and fk_orders_damageplace=7';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSpravkaAbon.PrepareFastReport;
var
  SelSQL: string;
begin
  with (F_OptionForm as Tfrm_DateSel) do
  begin
    {Дополнительный запрос}
{    SelSQL := ' select id, OrderNumber, cast(DateComing as Date) DateComing, Disconnections, fk_orders_regions, '+
              ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
              ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
              '  o.housenum, o.additionaladdress)) adres '+
              ' from orders o'+
              ResultCondition+
              ' and IsClosed=0 and'+
              ' id in'+
              ' (select fk_closedbolts_orders from closedbolts'+
              ' where fk_closedbolts_orders=o.id and'+
              ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))'+
              ' order by 6,3';
    AddSelSQLToDset(F_Dset[1], SelSQL);
    F_Dset[1].Open;
    }
    {/Дополнительный запрос}

    SelSQL := ' select id, OrderNumber, cast(DateComing as Date) DateComing, fk_orders_regions, '+
              ' (select disconadress from get_disconnections(o.id, 0)) Disconnections, '+
              ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
              ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
              '  o.housenum, o.additionaladdress)) adres '+
              ' from orders o'+
              ResultCondition+
              ' and IsClosed=0 and'+
              ' id in'+
              ' (select fk_closedbolts_orders from closedbolts'+
              ' where fk_closedbolts_orders=o.id and'+
              ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))'+
              ' order by 6,3';
    AddSelSQLToDset(F_Dset[1], SelSQL);
    F_Dset[1].Open;

    frVariables['Caption']:='СПРАВКА В АБОНЕНТНЫЙ ОТДЕЛ';
    frVariables['DisconnectCaption']:='Сводка отключений на '+strDate;
    frVariables['DamageCaption']:='Справка о повреждениях на водопроводных сетях на '+strDate;
  end;
end;

procedure TSpravkaAbon.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TSpravkaAbon.PrepareResultFormGrid;
var
  group: TGroup;
  _col: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);
  with F_GridViewBuilder do
  begin
    AddColumntoGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления');
    AddColumntoGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес');
    _col := AddColumntoGridViewBuilder(F_GridViewBuilder, 'WhatIsDone', 'Характер'+#13+'повреждения');
    _col.DisplayWidth := 50;

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=AddGroup('fk_orders_regions');
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clGrayText;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
  end;
end;

procedure TSpravkaAbon.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_DateSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Справка о повреждениях на водопроводных сетх'+#13+
                  'на '+strDate;
  end;
end;

procedure TSpravkaAbon.PrintBtnClick(Sender: TObject);
var
  file_name: string;
begin
  inherited;
  if DM_RightsManager.IsCurrentUserDisp then
  begin
  {Отправка по почте}
    //if Application.MessageBox('Отправить сформированную ведомость по почте?',
    //    PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                  'sprav_'+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRToRTFAndSendByEmail(F_Report, file_name, F_Name);
    end;
  {/Отправка по почте}
  end;
end;

{ TSvodVed_excav }

procedure TSvodVed_excav.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, F_Name);
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    dp_Coming1.Visible:=false;
    dp_Coming2.Visible:=false;
    lbl_DateComing1.Visible:=false;
    lbl_DateComing2.Visible:=false;
    btn_DamagePlace.Visible:=false;
    ShortTableName:='o';
  end;
end;

procedure TSvodVed_excav.InitFields;
begin
  F_Name:='Сводная ведомость по разрытию';
  F_ReportFileName:='SvodVed_excav.frf';
end;

procedure TSvodVed_excav.OnDaysCountCellShow(ShowValue: variant;
  var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  if val=0 then
    Res:='';
end;

procedure TSvodVed_excav.OnDmgPlaceHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  case DataSet.FieldByName('fk_orders_damageplace').AsInteger of
    1: OutRow.Add('НА ВОДОПРОВОДНЫХ СЕТЯХ');
    2: OutRow.Add('НА ВОДОПРОВОДНЫХ ВВОДАХ');
    3: OutRow.Add('В КОЛОДЦАХ');{ СМОТРОВЫХ }
    4: OutRow.Add('НА ВОДОРАЗБОРНЫХ КОЛОНКАХ');
    6: OutRow.Add('НА ШАХТНЫХ КОЛОДЦАХ');
    7: OutRow.Add('АБОНЕНТОВ НЕСТОЯЩИХ НА БАЛАНСЕ ОБЪЕДИНЕНИЯ');
    else OutRow.Add(AnsiUpperCase(trim(DataSet.FieldByName('DamagePlace').AsString)));
  end; //end case;
end;

procedure TSvodVed_excav.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;

procedure TSvodVed_excav.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=
    ' select  o.id, o.OrderNumber, cast(o.DateComing as Date) DateComing,'+
    ' cast(o.DateClosed as Date) DateClosed,o.fk_orders_regions, o.fk_orders_damageplace,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_damageplace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
    ' (select name from s_TubeMaterial where id=o.fk_orders_tubematerial) TubeMaterial,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres, exc.DTime ExcDate,'+
    ' excinfo.AdditionalInfo,'+
    ' (select workname from s_excavationworktypes where id=exc.fk_excavations_excwt) ExcWt,'+
    ' cast((current_timestamp-exc.dtime) as integer) NumDays,'+
    ' exc_plan.dtime exc_plan_dtime, exc_plan.square exc_square,'+
    ' (select name from brigadiers where id=exc_plan.fk_excavations_brigadiers) exc_brig,'+
    ' 1 MainGr'+
    ' from orders o'+
    ' left join excavations exc'+
    ' on ('+
    '     exc.fk_excavations_orders=o.id'+
    '     and exc.id=(select last_excav_id from get_last_excav_id_for_order(o.id))'+
    '     )'+
    ' left join excavationsinfo excinfo on excinfo.fk_excinfo_orders=o.id'+
    ' left join excavations exc_plan' +
    ' on (' +
    '     exc_plan.fk_excavations_orders=o.id' +
    '     and exc_plan.fk_excavations_excwt=10' +
    '     )' +
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' and o.isclosed=1'+
    ' and o.fk_orders_damageplace in (1,2,3)'+
    ' and o.fk_orders_damagelocality<>4'+
    ' and o.LastExcWrkType in (2,3,9)'+
    ' and o.datecoming>''01.01.2004'''+
    ' order by 6, 7, 3';

  CountSQL:=
    ' select count(o.id) RecordCount'+
    ' from orders o'+
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' and o.isclosed=1'+
    ' and o.fk_orders_damageplace in (1,2,3)'+
    ' and o.fk_orders_damagelocality<>4'+
    ' and o.LastExcWrkType in (2,3,9)'+
    ' and o.datecoming>''01.01.2004''';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSvodVed_excav.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    frVariables['Caption']:='Сводная ведомость по разрытию после ликвидации повреждений на '+DateToStr(Date);
    frVariables['Regions']:='Районы: '+strRegions;
  end;
end;

procedure TSvodVed_excav.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TSvodVed_excav.PrepareResultFormGrid;
var
  _group: TGroup;
  _col: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder := TGridViewBuilder.Create(F_Dset[0],
                         (F_ResultForm as Tfrm_AnalysisView).Grid);
  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB( F_GridViewBuilder, 'DateComing', 'Дата' + #13 + 'поступления', alCenter );
    AddColToGVB( F_GridViewBuilder, 'OrderNumber', '№' + #13 + 'наряда', alCenter );
    AddColToGVB( F_GridViewBuilder, 'Adres', 'Адрес', alLeft );
    AddColToGVB( F_GridViewBuilder, 'DateClosed', 'Дата' + #13 + 'ликвидации', alCenter );
    AddColToGVB( F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft );
    AddColToGVB( F_GridViewBuilder, 'ExcDate','Дата и время' + #13 + 'раскопки', alCenter );
    AddColToGVB( F_GridViewBuilder, 'ExcWt', 'Раскопка', alLeft );
    AddColToGVB( F_GridViewBuilder, 'NumDays', 'Количество' + #13 + 'дней', alCenter, OnDaysCountCellShow );

    _col := AddColToGVB( F_GridViewBuilder, 'AdditionalInfo', 'Дополнительная' + #13 + 'информация', alLeft );
    _col.DisplayWidth := 40;

    AddColToGVB( F_GridViewBuilder, 'exc_plan_dtime', 'Планируемая' + #13 + 'дата планировки', alCenter );
    AddColToGVB( F_GridViewBuilder, 'exc_square', 'Площадь' + #13 + 'разрытия', alCenter );
    AddColToGVB( F_GridViewBuilder, 'exc_brig', 'ФИО ответ. лица', alLeft );

    _group := AddGroup( 'MainGr' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupHeader.Visible := false;
    _group.GroupFooter.Visible := false;

    _group := AddGroup( 'fk_orders_damageplace' );
    _group.GroupHeader.Visible := true;
    _group.GroupFooter.Visible := false;
    _group.GroupHeader.Color := clAqua;
    _group.GroupHeader.OnShowCaption := OnDmgPlaceHeaderCaption;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.Alignment := alCenter;

    _group := AddGroup( 'fk_orders_regions' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupHeader.Visible := true;
    _group.GroupFooter.Visible := false;
    _group.GroupHeader.Color := clGrayText;
    _group.GroupHeader.OnShowCaption := OnRegHeaderCaption;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.Alignment := alCenter;
  end; //end with
end;

procedure TSvodVed_excav.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводная ведомость по разрытию после ликвидации повреждений'+#13+
                   'на '+DateToStr(Date);
    LeftLabel:='Районы: '+strRegions;
  end;
end;
{/TSvodVed_excav}


{ TProfWorkType }

procedure TProfWorkType.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodMsgSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TProfWorkType.DateCaption(dt1, dt2: string): string;
begin
  Result:='Сводка о видах пофработ'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TProfWorkType.InitFields;
begin
  F_Name:='Сводка о видах профработ';
  F_ReportFileName:='ProfWorkType.frf';
end;

procedure TProfWorkType.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=' select o.id, o.OrderNumber, cast(o.DateComing as Date) DateComing,'+
          ' (select MessageName from s_messagetypes where id=o.fk_orders_messagetypes) MessageTypes,'+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '     o.housenum, o.additionaladdress)) adres'+
          ' from orders o'+
          ' left join s_messagetypes sm on (sm.id=o.fk_orders_messagetypes)' +
          (F_OptionForm as Tfrm_PeriodMsgSel).ResultCondition+
          ' and (o.IsClosed=1) and (o.fk_orders_DamagePlace=8)'+
          ' and (sm.S_MT_CATEGORY_ID=4)'+
          ' order by 3, 2';

  CountSQL:=' select count(o.id) RecordCount'+
            ' from orders o'+
            ' left join s_messagetypes sm on (sm.id=o.fk_orders_messagetypes)' +            
            (F_OptionForm as Tfrm_PeriodMsgSel).ResultCondition+
            ' and (o.IsClosed=1) and (o.fk_orders_DamagePlace=8)'+
            ' and (sm.S_MT_CATEGORY_ID=4)';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TProfWorkType.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodMsgSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
  end;
end;

procedure TProfWorkType.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
    //btn_Order.OnClick:=OrderBtnClick;
  end;
end;

procedure TProfWorkType.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                            (F_ResultForm as Tfrm_AnalysisView).Grid);

  //F_GridViewBuilder.IsNumberRecord:=true;
  //F_GridViewBuilder.IDFieldName:='ID';
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'повреждения', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Regions', 'Район', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'MessageTypes', 'Вид'+#13+'профработ', alLeft);

end;

procedure TProfWorkType.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodMsgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
  end;
end;

{ TSvodVed_OutstandWork }

procedure TSvodVed_OutstandWork.InitFields;
begin
  F_Name:='Сводная ведомость невыполненых работ по обратной засыпке';
  F_ReportFileName:='SvodVed_OutstandWork.frf';
end;

procedure TSvodVed_OutstandWork.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=
    ' select  o.id, o.OrderNumber, cast(o.DateComing as Date) DateComing,'+
    ' cast(o.DateClosed as Date) DateClosed,o.fk_orders_regions, o.fk_orders_damageplace,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_damageplace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
    ' (select name from s_TubeMaterial where id=o.fk_orders_tubematerial) TubeMaterial,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres, exc.DTime ExcDate,'+
    ' excinfo.AdditionalInfo,'+
    ' (select workname from s_excavationworktypes where id=exc.fk_excavations_excwt) ExcWt,'+
    ' cast((current_timestamp-exc.dtime) as integer) NumDays,'+
    ' 1 MainGr'+
    ' from orders o'+
    ' left join excavations exc'+
    ' on ('+
    '     exc.fk_excavations_orders=o.id'+
    '     and exc.id=(select last_excav_id from get_last_excav_id_for_order(o.id))'+
//    '     and exc.id=(select max(id) from excavations where fk_excavations_orders=o.id)'+
    '     )'+
    ' left join excavationsinfo excinfo on excinfo.fk_excinfo_orders=o.id'+
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' and o.isclosed=1'+
    ' and o.fk_orders_damageplace in (1,2)'+
    ' and o.fk_orders_damagelocality<>4'+
    ' and o.LastExcWrkType in (3,9)'+
    ' and o.datecoming>''01.01.2004'''+
    ' order by 8, 7, 3';

  CountSQL:=
    ' select count(o.id) RecordCount'+
    ' from orders o'+
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' and o.isclosed=1'+
    ' and o.fk_orders_damageplace in (1,2)'+
    ' and o.fk_orders_damagelocality<>4'+
    ' and o.LastExcWrkType in (3,9)'+
    ' and o.datecoming>''01.01.2004''';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSvodVed_OutstandWork.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    frVariables['Caption']:='Сводная ведомость невыполненных работ по обратной засыпке на '+DateToStr(Date);
    frVariables['Regions']:='Районы: '+strRegions;
  end;
end;

procedure TSvodVed_OutstandWork.PrepareResultFormGrid;
var
  _group: TGroup;
  _col: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder := TGridViewBuilder.Create(F_Dset[0],
                         (F_ResultForm as Tfrm_AnalysisView).Grid);
  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB( F_GridViewBuilder, 'DateComing', 'Дата' + #13 + 'поступления', alCenter );
    AddColToGVB( F_GridViewBuilder, 'OrderNumber', '№' + #13 + 'наряда', alCenter );
    AddColToGVB( F_GridViewBuilder, 'Adres', 'Адрес', alLeft );
    AddColToGVB( F_GridViewBuilder, 'DateClosed', 'Дата' + #13 + 'ликвидации', alCenter );
    AddColToGVB( F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft );
    AddColToGVB( F_GridViewBuilder, 'ExcDate','Дата и время' + #13 + 'раскопки', alCenter );
    AddColToGVB( F_GridViewBuilder, 'ExcWt', 'Раскопка', alLeft );
    AddColToGVB( F_GridViewBuilder, 'NumDays', 'Количество' + #13 + 'дней', alCenter, OnDaysCountCellShow );

    _col := AddColToGVB( F_GridViewBuilder, 'AdditionalInfo', 'Дополнительная' + #13 + 'информация', alLeft );
    _col.DisplayWidth := 40;

    _group := AddGroup( 'MainGr' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupHeader.Visible := false;
    _group.GroupFooter.Visible := false;

    _group := AddGroup( 'fk_orders_damageplace' );
    _group.GroupHeader.Visible := true;
    _group.GroupFooter.Visible := false;
    _group.GroupHeader.Color := clAqua;
    _group.GroupHeader.OnShowCaption := OnDmgPlaceHeaderCaption;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.Alignment := alCenter;

    _group := AddGroup( 'fk_orders_regions' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupHeader.Visible := true;
    _group.GroupFooter.Visible := false;
    _group.GroupHeader.Color := clGrayText;
    _group.GroupHeader.OnShowCaption := OnRegHeaderCaption;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.Alignment := alCenter;
  end; //end with
end;

procedure TSvodVed_OutstandWork.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводная ведомость невыполненных работ по обратной засыпке'+
                  #13+'на '+DateToStr(Date);
    LeftLabel:='Районы: '+strRegions;
  end;
end;

{ TBlagState }

procedure TBlagState.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegBlagSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_PeriodRegBlagSel).ShortTableName:='o';

  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TBlagState.DateCaption(dt1, dt2: string): string;
begin
  Result:='Сводная ведомость состояния благоустройств при ликвидации повреждений'+#13+' за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

destructor TBlagState.Destroy;
begin
  F_Dset[0].Close;
  F_Dset[0].CachedUpdates:=false;
  F_Dset[0].ModifySQL.Clear;
  inherited Destroy;
end;

procedure TBlagState.InitFields;
begin
  F_Name:='Ведомость состояния благоустройств';
  F_ReportFileName:='BlagState.frf';
end;

function TBlagState.LoadData: boolean;
const
  ExcSQL= ' select DTime, Square, fk_excavations_excwt,'+
          ' (select workname from s_excavationworktypes where id=Exc.fk_excavations_excwt) excwt,'+
          ' (select rtrim(name)||'' №''||cast(number as char(3)) from equipment where id=Exc.fk_excavations_equipment) Equip'+
          ' from Excavations Exc'+
          ' where fk_excavations_excwt in (1,5,6,7,8,11)'+
          ' and fk_excavations_orders=%s '+
          ' order by DTime';
begin
  F_ProgressIndic.Max:=F_RecordCount;
  F_ProgressIndic.Show;

  {Меняем только КЭШ, базу не трогаем}
  F_Dset[0].CachedUpdates:=true;
  F_Dset[0].ModifySQL.Clear;
  F_Dset[0].ModifySQL.Add('update orders set OrderNumber=:OrderNmber where id=:id');

  {Считаем}
  with F_Dset[0] do
  begin
    Open;
    First;
    while not Eof do
    begin
      Edit;
      //
      //MyOpenSQL(F_Dset[1], Format(ExcSQL, [FieldByName('ID').AsString]));
      F_Dset[1].Close;
      F_Dset[1].SelectSQL.Clear;
      F_Dset[1].SelectSQL.Add(Format(ExcSQL, [FieldByName('ID').AsString]));
      F_Dset[1].Open;
      //
      while not F_Dset[1].Eof do
      begin
        case F_Dset[1].FieldByName('fk_excavations_excwt').AsInteger of
          1: //Засыпано
          begin
            FieldByName('FillingDate').AsString:=DateToStr(F_Dset[1].FieldByName('DTime').AsDateTime);
            FieldByName('Equip').AsString:=F_Dset[1].FieldByName('Equip').AsString;
          end;
          5: //Заасфальтировано
          begin
            FieldByName('AsphaltDate').AsString:=DateToStr(F_Dset[1].FieldByName('DTime').AsDateTime);
            FieldByName('Exec').AsString:=FormatFloat('0.##', F_Dset[1].FieldByName('Square').AsFloat);
          end;
          6: //Спланировано
          begin
            FieldByName('PlanishDate').AsString:=DateToStr(F_Dset[1].FieldByName('DTime').AsDateTime);
          end;
          7, 11: //Передано в КДЭП  // а теперь и Защебенено // by Vadim 09.01.2009
          begin
            FieldByName('Declar').AsString:=FormatFloat('0.##', F_Dset[1].FieldByName('Square').AsFloat);
            FieldByName('DeclarDate').AsString:=DateToStr(F_Dset[1].FieldByName('DTime').AsDateTime);
          end;
          8: //Оплачено
          begin
            FieldByName('Paid').AsString:=FormatFloat('0.##', F_Dset[1].FieldByName('Square').AsFloat);
            FieldByName('PaidDate').AsString:=DateToStr(F_Dset[1].FieldByName('DTime').asDateTime);
          end;
        end; //end case
        F_Dset[1].Next;
      end; //while not F_Dset[1].Eof
      F_Dset[1].Close;
      Next;
      F_ProgressIndic.Position:=F_ProgressIndic.Position+1;
    end; //while not Eof
  end; // end with F_Dset[0]
  {/Считаем}


  F_GridViewBuilder.BuildGridView;
  F_ProgressIndic.Hide;
end;

procedure TBlagState.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('regions').AsString)+' район');
end;

procedure TBlagState.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=' select id, OrderNumber, cast(DateClosed as Date) DateClosed, fk_orders_regions,'+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '     o.housenum, o.additionaladdress)) adres,'+
          ' ''                                     '' FillingDate,'+
          ' ''                                     '' Equip,'+
          ' ''                                     '' PlanishDate,'+
          ' ''                                     '' AsphaltDate,'+
          ' ''                                     '' Declar,'+
          ' ''                                     '' Exec,'+
          ' ''                                     '' Paid,'+
          ' ''                                     '' DeclarDate,'+
          ' ''                                     '' PaidDate,'+
          ' 1 MainGr'+
          ' from orders o'+
          (F_OptionForm as Tfrm_PeriodRegBlagSel).ResultCondition+
          ' and isClosed=1'+
          ' and fk_Orders_DamageLocality<>4'+
          ' and DateComing>=''01.01.2004'''+
          ' and fk_Orders_DamagePlace in (1,2)'+
          ' order by 5, 6, 2';

  CountSQL:=' select count(o.id) RecordCount'+
            ' from orders o'+
            (F_OptionForm as Tfrm_PeriodRegBlagSel).ResultCondition+
            ' and isClosed=1'+
            ' and fk_Orders_DamageLocality<>4'+
            ' and DateComing>=''01.01.2004'''+
            ' and fk_Orders_DamagePlace in (1,2)';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TBlagState.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegBlagSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+strRegions;
  end;
end;

procedure TBlagState.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;  
  end;
end;

procedure TBlagState.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                      (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    F_GridViewBuilder.IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'ликвидации', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft);
    AddColToGVB(F_GridViewBuilder, 'FillingDate', 'Засыпка', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Equip', 'Механизм', alLeft);
    AddColToGVB(F_GridViewBuilder, 'PlanishDate', 'Планировка', alCenter);
    AddColToGVB(F_GridViewBuilder, 'AsphaltDate', 'Заасфальтирован', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Declar', 'Заявл.,'+#13+'м2', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Exec', 'Вып.,'+#13+'м2', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Paid', 'Опл.,'+#13+'м2', alCenter);

    group:=AddGroup('MainGr');
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;
    group.IsNumberRecordInGroup:=true;

    group:=AddGroup('fk_orders_regions');
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnRegHeaderCaption;
  end; //end with
end;

procedure TBlagState.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegBlagSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
    LeftLabel:='Районы: '+strRegions;
  end;
end;

{ TSearchAdres_PodRep }

procedure TSearchAdres_PodRep.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_ResultForm.Width:=F_ResultForm.Width-40;
  F_ResultForm.Height:=F_ResultForm.Height-40;
  F_ResultForm.Top:=F_ResultForm.Top+20;
  F_ResultForm.Left:=F_ResultForm.Left+20;
end;

procedure TSearchAdres_PodRep.InitFields;
begin
  F_Name:='Просмотр адресов результатов анализа';
  F_ReportFileName:='SearchAdres_PodRep.frf';
end;

procedure TSearchAdres_PodRep.PrepareDsets;
var
  SelSQL: string;
begin
  SelSQL:=' select o.id, o.OrderNumber, cast(o.DateComing as Date) DateComing,'+
          ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '     o.housenum, o.additionaladdress)) adres'+
          ' from orders o'+
          F_AdditionalCondition+
          ' and o.fk_orders_housetypes='+IntToStr(F_ID_HouseType)+
          ' and o.fk_orders_streets='+IntToStr(F_ID_street)+
          ' and o.housenum='+QuotedStr(F_HouseNum)+
          ' order by o.datecoming';

  AddSelSQLToDset(F_Dset[0], SelSQL);
end;

procedure TSearchAdres_PodRep.PrepareFastReport;
begin
//
end;

procedure TSearchAdres_PodRep.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TSearchAdres_PodRep.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IDFieldName:='ID';
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing','Дата'+#13+'сообщения', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber','№'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres','Адрес', alLeft);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamagePlace','Место'+#13+'повреждения', alLeft);
end;

function TSearchAdres_PodRep.ShowOptionForm: boolean;
begin
  if F_IsShowed then
    Result:=false
  else
    Result:=true;

  F_IsShowed:=true;
end;

{ TLongOrder }

procedure TLongOrder.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegPlaceTypeSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

function TLongOrder.DateCaption(dt1, dt2: TDate; DayCount: integer): string;
begin
  Result:='Наряды длительностью выполнения более '+IntToStr(DayCount)+' дней'+
          #13+'за';
  if (dt1=0) and (dt2=0) then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>0 then Result:=Result+' c '+DateToStr(dt1);
    if dt2<>0 then Result:=Result+' по '+DateToStr(dt2);
  end;
  Result:=Result+#13+'по предприятию "Харьковводосеть"';
end;

procedure TLongOrder.InitFields;
begin
  F_Name:='Анализ повр. длит. больше заданного';
  F_ReportFileName:='LongOrder.frf';
end;

procedure TLongOrder.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('Итого:');
  OutRow.Add(FloatToStr(AggregateValueArr[0])+' дней');
  OutRow.Add(FloatToStr(AggregateValueArr[1])+' дней');
  OutRow.Add(FloatToStr(AggregateValueArr[2]));
end;

procedure TLongOrder.PrepareDsets;
var
  RegionsSQL, DamagePlaceSQL, DamageTypeSQL: string;
  SelSQL, CountSQL: string;
  dt1, dt2: string;
  DayCount: string;
begin
  with F_OptionForm as Tfrm_PeriodRegPlaceTypeSel do
  begin
    if RegionsID<>'' then
      RegionsSQL:=' and fk_orders_regions in'+RegionsID
    else
      RegionsSQL:='';

    if DamagePlaceID<>'' then
      DamagePlaceSQL:=' and fk_orders_damageplace in'+DamagePlaceID
    else
      DamagePlaceSQL:='';

    if DamageTypeID<>'' then
      DamageTypeSQL:=' and fk_orders_damagetype in'+DamageTypeID
    else
      DamageTypeSQL:='';

    DayCount:=IntToStr(sp_DayCount.AsInteger);
    dt1:=DateToStr(dp_Date1.Date);
    dt2:=DateToStr(dp_Date2.Date+1);
  end;  // end with F_OptonForm



  SelSQL:=' select id, OrderNumber,'+
          ' cast(DateComing as Date) DateComing, cast(DateClosed as Date) DateClosed,'+
          ' (cast(cast(DateClosed as Date)-cast(DateComing as Date) as integer)-'+DayCount+') DayCount,'+
          ' cast(cast(DateClosed as Date)-cast(DateComing as Date) as integer) DayLeakCount,'+
          ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
          ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '     o.housenum, o.additionaladdress)) adres, 1 MainGroup'+
          ' from orders o'+
          ' where IsClosed=1'+
          ' and DateComing>'''+dt1+''' and DateComing<='''+dt2+''''+
          RegionsSQL+DamagePlaceSQL+DamageTypeSQL+
          ' and cast(cast(DateClosed as Date)-cast(DateComing as Date) as integer)>'+DayCount+
          ' order by DateComing';

  CountSQL:=' select count(*) RecordCount'+
            ' from orders o'+
            ' where IsClosed=1'+
            ' and DateComing>'''+dt1+''' and DateComing<='''+dt2+''''+
            RegionsSQL+DamagePlaceSQL+DamageTypeSQL+
            ' and cast(cast(DateClosed as Date)-cast(DateComing as Date) as integer)>'+DayCount;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TLongOrder.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegPlaceTypeSel do
  begin
    frVariables['Caption']:=DateCaption(dp_Date1.Date, dp_Date2.Date, sp_DayCount.AsInteger);
  end;
end;

procedure TLongOrder.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TLongOrder.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                      (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DayCount', 'Количество'+#13+'дней', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DayLeakCount', 'Длит.'+#13+'течи', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'окончания', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DamageType', 'Характер'+#13+'повреждения', alLeft);

    group:=AddGroup('MainGroup');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.AddAggregateField(atSum, 'DayCount');
    group.AddAggregateField(atSum, 'DayLeakCount');
    group.AddAggregateField(atCount, 'OrderNumber');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;
    group.GroupFooter.Color:=clYellow;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Alignment:=alCenter;
  end;
end;

procedure TLongOrder.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegPlaceTypeSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(dp_Date1.Date, dp_Date2.Date, sp_DayCount.AsInteger);
  end;
end;

{ TAnalysisLeak }

procedure TAnalysisLeak.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodTimeRegDmgSel.Create(nil,F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TAnalysisLeak.InitFields;
begin
  F_Name:='Анализ утечек за период';
  F_ReportFileName:='AnalysisLeak.frf';
end;

procedure TAnalysisLeak.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add('ВСЕГО ПО РАЙОНАМ:');
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure TAnalysisLeak.OnRegGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add('Всего по району:');
  OutRow.Add(FormatFloat('0.##', AggregateValueArr[0]));
end;

procedure TAnalysisLeak.OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('regions').AsString)+' район');  
end;

procedure TAnalysisLeak.OnStrCellShow(ShowValue: variant; var Res: string);
var
  s: string;
begin
  s:=AnsiUpperCase(VarToString(ShowValue));
  if pos('ПУСТО',s)<>0 then
    Res:='';
end;

procedure TAnalysisLeak.OnValCellShow(ShowValue: variant; var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  if val=0 then
    Res:=''
  else
    Res:=FormatFloat('0.##', val);
end;

procedure TAnalysisLeak.PrepareDsets;
var
  dt1, dt2: string;
  SelSQL, CountSQL: string;
begin
  with F_OptionForm as Tfrm_PeriodTimeRegDmgSel do
  begin
    dt1:=DateToStr(dp_Date1.Date)+' 8:00';
    dt2:=DateToStr(dp_Date2.Date)+' 8:00';

    SelSQL:=' select id, OrderNumber, cast(DateComing as Date) DateComing,'+
            ' cast(DateClosed as Date) DateClosed, FlowSpeed,'+
            ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
            ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
            ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
            ' (select adres from Get_adres(o.fk_orders_housetypes,'+
            '     o.fk_orders_streets, o.housenum, o.additionaladdress)) adres,'+
            ' (select Leak from get_leak_for_period(o.id, '+QuotedStr(dt1)+', '+QuotedStr(dt2)+')) Leak,'+
            ' fk_orders_regions, 1 MainGr'+
            ' from orders o'+
            ResultCondition+
            ' and (DateComing<'''+dt2+''')'+
            ' and (DateClosed>='''+dt1+''' or DateClosed is null)'+
            ' and (FlowSpeed>0)'+
            ' order by 6, 3';

    CountSQL:=' select count(*) RecordCount'+
              ' from orders o'+
              ResultCondition+
              ' and (DateComing<'''+dt2+''')'+
              ' and (DateClosed>='''+dt1+''' or DateClosed is null)'+
              ' and (FlowSpeed>0)';
  end; //end with F_OptionForm

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TAnalysisLeak.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodTimeRegDmgSel do
  begin
    frVariables['Caption']:='Анализ утечек за период с '+DateToStr(dp_Date1.Date)+' 8:00'+
                ' по '+DateToStr(dp_Date2.Date)+' 8:00';
    frVariables['Regions']:='Район: '+strRegions;
    frVariables['DamagePlace']:='Место повреждения: '+strDamagePlace;
  end;
end;

procedure TAnalysisLeak.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TAnalysisLeak.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                              (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Leak', 'Ут.'+#13+'(м3)', alCenter, OnValCellShow);
    AddColToGVB(F_GridViewBuilder, 'FlowSpeed', 'Ут.'+#13+'(м3 в час)', alCenter, OnValCellShow);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'окончания', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DamageType', 'Вид'+#13+'повреждения', alLeft, OnStrCellShow);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.AddAggregateField(atSum, 'Leak');
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Color:=clAqua;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Alignment:=alCenter;
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.AddAggregateField(atSum, 'Leak');
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Color:=clYellow;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Alignment:=alCenter;
    group.GroupFooter.OnShowCaption:=OnRegGroupFooterCaption;
  end;
end;

procedure TAnalysisLeak.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodTimeRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Анализ утечек'+#13+'за период с '+DateToStr(dp_Date1.Date)+' 8:00'+
                  ' по '+DateToStr(dp_Date2.Date)+' 8:00';
    LeftLabel:='Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end;
end;

{ TAnalysisEquipWork }

procedure TAnalysisEquipWork.GraphBtnClick(Sender: TObject);
  procedure ChartTitle(StrList: TStrings; dt1, dt2: TDate);
  var
    s: string;
  begin
    s:='за';
    if (dt1=0) and (dt2=0) then
    begin
      s:=s+' весь период'
    end else
    begin
      s:=s+' период ';
      if dt1<>0 then s:=s+' c '+DateToStr(dt1);
      if dt2<>0 then s:=s+' по '+DateToStr(dt2);
    end;

    StrList.Clear;
    StrList.Add('График работы экскаваторов при ликвидации повреждений');
    StrList.Add(s);
  end;
var
 // frm_Chart: Tfrm_LeakDiamChart;
 // i,j, SerCount: integer;
  dt1, dt2: string;
  frm_Chart: Tfrm_ChartMark;

begin
  frm_Chart:=Tfrm_ChartMark.Create(nil, 'График рез. анализа работы экскаваторов при ликв. повр.');
  with frm_Chart, frm_Chart.Chart, (F_OptionForm as Tfrm_PeriodRegSel) do
  begin
    {Заголовок диаграммы}
    ChartTitle(Title.Text, dp_Date1.Date, dp_Date2.Date);
    {/Заголовок диаграммы}

    {Добавляем серии}
    AddChartSeries(stBar);
    ChartSeries[0].Marks.Style:=smsValue;
    ChartSeries[0].Marks.Transparent:=true;
    ChartSeries[0].Marks.Frame.Visible:=false;
    {/Добавляем серии}

    Chart.LeftAxis.Title.Caption:='Кол-во ликвидированных повреждений';
    Chart.BottomAxis.Title.Caption:='Номер экскаватора';


    {Загрузка данных}
    F_Dset[0].First;
    while not F_Dset[0].Eof do
    begin
      ChartSeries[0].Add(F_Dset[0].FieldByName('LocCount').AsFloat,
                            F_Dset[0].FieldByName('Number').AsString);
      F_Dset[0].Next;
    end;
    {/Загрузка данных}
  end; //end with

  frm_Chart.ShowModal;


  (*
  dt1:=DateToStr((F_OptionForm as Tfrm_AnLeakTimeSel).dp_Date1.Date);
  dt2:=DateToStr((F_OptionForm as Tfrm_AnLeakTimeSel).dp_Date2.Date);

  frm_Chart:=Tfrm_LeakDiamChart.Create(nil, 'График рез. анализа по дате и времени поступления');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    Title.Text.Clear;
    Title.Text.Add('Анализ кол-ва пост. повреждений на водопроводной сети по часам суток' );
    Title.Text.Add('c '+dt1+' по '+dt2);
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    AddChartSeries(stBar);
    ChartSeries[0].Marks.Style:=smsValue;

    AddChartSeries(stBar);
    ChartSeries[1].Marks.Style:=smsValue;
    {/Добавляем серии}

    {Загрузка данных}
    for i:=0 to 1 do
      for j:=1 to Grid.ColCount-3 do
        ChartSeries[i].Add(StrToFloat(Grid.Cells[j, Grid.RowCount-2+i]), Grid.Cells[j, 0]);
    {/Загрузка данных}

    btn_countClick(nil);
  end; // end with

  frm_Chart.ShowModal;
*)
end;

procedure TAnalysisEquipWork.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  (F_ResultForm as Tfrm_AnalysisView).btn_Order.Caption:='Поиск';
end;

function TAnalysisEquipWork.DateCaption(dt1, dt2: TDate): string;
begin
  Result:='Работа экскаваторов'+#13+'за';
  if (dt1=0) and (dt2=0) then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>0 then Result:=Result+' c '+DateToStr(dt1);
    if dt2<>0 then Result:=Result+' по '+DateToStr(dt2);
  end;
end;

procedure TAnalysisEquipWork.InitFields;
begin
  F_Name:='Анализ работы экскаваторов при ликв. повр.';
  F_ReportFileName:='AnalysisEquipWork.frf';
end;

procedure TAnalysisEquipWork.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('Итого: '+FloatToStr(AggregateValueArr[0]));
  OutRow.Add(FloatToStr(AggregateValueArr[1]));
end;

procedure TAnalysisEquipWork.PrepareDsets;
var
  SelSQL: string;
begin
{
  SelSQL:=
    ' select count(*) LocCount, e.Number, e.id, 1 MainGr'+
    ' from orders o'+
    ' left join equipment e on e.id=o.fk_orders_equipments'+
    ' where o.fk_orders_equipments<>-1'+
    ' and o.isclosed=1'+
    AdditionalCondition+
    ' group by e.number, e.id'+
    ' order by e.number';
}

  SelSQL:=
    ' select count(*) LocCount, e.Number, e.id, 1 MainGr'+
    ' from orders o, equipment e, equipwork ew'+
    ' where'+
    ' ew.fk_eqwork_orders=o.id'+
    ' and ew.fk_eqwork_equip=e.id'+
    ' and o.isclosed=1'+
    AdditionalCondition+
    ' group by e.number, e.id'+
    ' order by e.number';

  AddSelSQLToDset(F_Dset[0], SelSQL);
end;

procedure TAnalysisEquipWork.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegSel do
  begin
    frVariables['Caption']:=DateCaption(dp_Date1.Date, dp_Date2.Date);
    frVariables['Regions']:='Район: '+strRegions;
  end;
end;

procedure TAnalysisEquipWork.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintBtnClick;
    btn_Order.OnClick:=OrderBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
    btn_Graph.OnClick:=GraphBtnClick;  
  end;
end;

procedure TAnalysisEquipWork.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                    (F_ResultForm as Tfrm_AnalysisView).Grid);
  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Number', '№'+#13+'экскаватора', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'LocCount','Ликвидировано'+#13+'повреждений', alCenter);

    group:=AddGroup('MainGr');
    group.AddAggregateField(atCount, 'Number');
    group.AddAggregateField(atSum, 'LocCount');
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Color:=clYellow;
    group.GroupFooter.Alignment:=alCenter;
  end; //end with
end;

procedure TAnalysisEquipWork.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(dp_Date1.Date, dp_Date2.Date);
    LeftLabel:='Район: '+strRegions;
  end;
end;

procedure TAnalysisEquipWork.OrderBtnClick(Sender: TObject);
var
  Grid: TStringAlignGrid;
  PodRep:TAnalysisEquipWork_PodRep;
begin
  Grid:=GetResultFormGrid;
  if not Assigned(Grid) then exit;

  if not Assigned(Grid.Objects[0, Grid.Row]) then exit;

  PodRep:=TAnalysisEquipWork_PodRep.Create;
  try
    PodRep.Dset[0]:=F_Dset[1];
    PodRep.RecordCountDset:=F_Dset[2];

    PodRep.ProgressIndic:=F_ProgressIndic;
    PodRep.Report:=F_Report;

    PodRep.EqNumber:=Grid.Cells[0, Grid.Row];
    PodRep.EqID:=integer(Grid.Objects[0, Grid.Row]);
    PodRep.dt_begin:=(F_OptionForm as Tfrm_PeriodRegSel).dp_Date1.Date;
    PodRep.dt_end:=(F_OptionForm as Tfrm_PeriodRegSel).dp_Date2.Date;
    PodRep.AdditionalCondition:=AdditionalCondition;

    PodRep.Execute;
  finally
    PodRep.Free;
  end;
end;

function TAnalysisEquipWork.AdditionalCondition: string;
var
  DatesSQL, RegionsSQL: string;
begin
  with F_OptionForm as Tfrm_PeriodRegSel do
  begin
    {DatesSQL}
    DatesSQL:='';
    if dp_Date1.Date<>0 then
      DatesSQL:=' and o.DateClosed>'''+DateToStr(dp_Date1.Date)+'''';

    if dp_Date2.Date<>0 then
      DatesSQL:=DatesSQL+' and o.DateClosed<='''+DateToStr(dp_Date2.Date+1)+''''
    else
      DatesSQL:=DatesSQL+' and o.DateClosed<='''+DateToStr(Date+1)+'''';
    {/DatesSQL}

    {RegionsSQL}
    if RegionsID<>'' then
      RegionsSQL:=' and fk_orders_regions in'+RegionsID
    else
      RegionsSQL:='';
    {/RegionsSQL}
  end; //end with F_OptionForm

  Result:=DatesSQL+RegionsSQL;
end;

{ TAnalysisEquipWork_PodRep }

procedure TAnalysisEquipWork_PodRep.CreateForms;
const
  SDVIG=30;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Left:=left+SDVIG;
    top:=top+SDVIG;

    Height:=Height-SDVIG;
    Width:=Width-SDVIG;
  end;
end;

function TAnalysisEquipWork_PodRep.DateCaption: string;
begin
  Result:='Список повреждений, ликвидированных экс. №'+F_EqNumber+
          #13+'за';
  if (F_dt_begin=0) and (F_dt_end=0) then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if F_dt_begin<>0 then Result:=Result+' c '+DateToStr(F_dt_begin);
    if F_dt_end<>0 then Result:=Result+' по '+DateToStr(F_dt_end);
  end;
end;

procedure TAnalysisEquipWork_PodRep.InitFields;
begin
  F_Name:='Список адресов';
  F_ReportFileName:='AnalysisEquipWork_PodRep.frf';
end;

procedure TAnalysisEquipWork_PodRep.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL:=
    ' select cast(o.DateComing as Date) DateComing, o.OrderNumber, o.ID, '+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres'+
    ' from orders o, equipwork ew'+
    ' where'+
    ' ew.fk_eqwork_orders=o.id'+
    ' and ew.fk_eqwork_equip='+IntToStr(F_EqID)+
    ' and o.isclosed=1'+
    F_AdditionalCondition+
    ' order by o.DateComing';

  CountSQL:=
    ' select count(*)'+
    ' from orders o, equipwork ew'+
    ' where'+
    ' ew.fk_eqwork_orders=o.id'+
    ' and ew.fk_eqwork_equip='+IntToStr(F_EqID)+
    ' and o.isclosed=1'+
    F_AdditionalCondition;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TAnalysisEquipWork_PodRep.PrepareFastReport;
begin
  frVariables['Caption']:=DateCaption;
end;

procedure TAnalysisEquipWork_PodRep.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Excel.OnClick:=ExcelBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TAnalysisEquipWork_PodRep.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IDFieldName:='ID';
  F_GridViewBuilder.IsNumberRecord:=true;
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', 'Номер'+#13+'наряда', alCenter);
  AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
end;

procedure TAnalysisEquipWork_PodRep.PrepareResultFormHeader;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    CenterLabel:=DateCaption;
  end;
end;

function TAnalysisEquipWork_PodRep.ShowOptionForm: boolean;
begin
  if F_IsShowed then
    Result:=false
  else
    Result:=true;

  F_IsShowed:=true;
end;

{ TInstallHatch }

procedure TInstallHatch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure TInstallHatch.InitFields;
begin
  F_Name:='Сводка установок крышек люка';
  F_ReportFileName:='InstallHatch.frf';
end;

procedure TInstallHatch.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add('ИТОГО:');
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure TInstallHatch.OnRegGroupHeaderCaptionShow(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('Regions').AsString)+' РАЙОН');
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure TInstallHatch.PrepareDsets;
var
  strDt1, strDt2, strRegionsID: string;
  SelSQL, CountSQL, _hoodCount: string;
begin
  with F_OptionForm as Tfrm_PeriodRegSel do
  begin
    strDt1:=DateToStr(dp_Date1.Date);
    strDt2:=DateToStr(dp_Date2.Date);

    if RegionsID<>'' then
      strRegionsID:=' and fk_orders_regions in'+RegionsID
    else
      strRegionsID:='';

   _hoodCount := ' iif( O.HOODCOUNT > (select coalesce( sum(DW.quantity),count(DW.ID)) from DEPARTUREWORKS DW where DW.FK_DEPWORKS_ORDER = O.ID and DW.FK_DEPWORKS_WORK = 268435465) , O.HOODCOUNT ' +
                 ' , (select coalesce( sum(DW.quantity),count(DW.ID)) from DEPARTUREWORKS DW where DW.FK_DEPWORKS_ORDER = O.ID and DW.FK_DEPWORKS_WORK = 268435465)) HOODCOUNT ';

    SelSQL:=
      ' select o.ID, o.OrderNumber, cast(o.DateComing as Date) DateComing, '+ _hoodCount +
      ', o.fk_Orders_regions,'+
      ' (select sr.name from s_regions sr where sr.id=o.fk_orders_regions) Regions,'+
      ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
      '     o.housenum, o.additionaladdress)) adres, 1 MainGr, cast(o.DateClosed as Date) DateClosed'+
      ' from orders o'+
      ' where (o.IsClosed=1) and (o.fk_orders_damageplace=13) '+
      strRegionsID+
      ' and cast(o.DateClosed as Date)>='''+strDt1+''''+
      ' and cast(o.DateClosed as Date)<='''+strDt2+''''+
      ' order by 5, 2';

    CountSQL:=
      ' select count(*) RecordCount'+
      ' from orders o'+
      ' where (o.IsClosed=1) and (o.fk_orders_damageplace=13) '+
      strRegionsID+
      ' and cast(o.DateClosed as Date)>='''+strDt1+''''+
      ' and cast(o.DateClosed as Date)<='''+strDt2+'''';

    AddSelSQLToDset(F_Dset[0], SelSQL);
    AddSelSQLToDset(F_RecordCountDset, CountSQL);
  end; //end with F_OptionForm
end;

procedure TInstallHatch.PrepareFastReport;
begin
  with F_OptionForm as Tfrm_PeriodRegSel do
  begin
    frVariables['Caption']:='Сводка установки крышек люка'+#13+
                  'за период с '+DateToStr(dp_Date1.Date)+
                ' по '+DateToStr(dp_Date2.Date);
    frVariables['Regions']:='Район: '+strRegions;
  end;
end;

procedure TInstallHatch.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TInstallHatch.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);
  with F_GridViewBuilder do
  begin
    F_GridViewBuilder.IDFieldName:='ID';

    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'HoodCount', 'Количество'+#13+'люков', alLeft);
    AddColumnToGridViewBuilder(F_GridViewBuilder, 'DateClosed', 'Дата'+#13+'закрытия', alCenter);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.AddAggregateField(atSum, 'HoodCount');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;
    group.GroupFooter.Font.Style:=[fsBold];

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.AddAggregateField(atSum, 'HoodCount');
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaptionShow;
    group.GroupHeader.Font.Style:=[fsBold];
  end;
end;

procedure TInstallHatch.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводка установки крышек люка'+#13+
                  'на водопроводных сетях г.Харькова с '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date);
    LeftLabel:='Район: '+strRegions;
  end;
end;

{ TGlavUpr }
function TGlavUpr.Execute: boolean;
var
  file_name: string;
begin
  Result:=false;

  if Application.MessageBox('Сформировать сводку для главного управления города?',
      gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES	 then exit;

  InitFields;
  PrepareDsets;
  LoadData;

  if not LoadReportFile then exit;

  PrepareFastReport;

  F_Report.PrepareReport;

  if DM_RightsManager.IsCurrentUserDisp then
    if GenFileName(file_name) then
      ExportFRToExcelAndSendByEmail(F_Report, file_name,
        'Информация состояния по разрытиям по КП КТП "ВОДА" на ' + DateToStr(Date));

  {Показать отчет}
  F_Report.ShowPreparedReport;
  if Assigned(F_Report.Preview) and (F_Report.Preview.Owner is Tfrm_BaseFrPreview) then
    (F_Report.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;
  {/Показать отчет}
end;

function TGlavUpr.GenExcelDirName(var ExcelDirName: string): boolean;
var
  current_dir: string;
begin
  Result:=false;

  current_dir:=ExtractFilePath(ParamStr(0));
  ExcelDirName:=current_dir+'excel';
  if not DirectoryExists(ExcelDirName) then
    if not CreateDir(ExcelDirName) then
    begin
      Application.MessageBox(PChar('Ошибка при создании папки'+ExcelDirName),
                               gc_strDispAVR, MB_OK+MB_ICONERROR);
      exit;
    end;

  Result:=true;
end;

function TGlavUpr.GenFileName(var AFileName: string): boolean;
  function GenCurrTimeStamp():string;
    function Add1Zero(value:string):string;
      begin
        result:=value;
        if length(value)=1 then result:='0'+value;
      end;
  var _ndt:TDateTime;
  begin
    _ndt:=now;
    result:=IntToStr(YearOf(_ndt))+'-'+Add1Zero(IntToStr(MonthOf(_ndt)))+'-'+Add1Zero(IntToStr(DayOf(_ndt)))+
      '#'+Add1Zero(IntToStr(HourOf(_ndt)))+'-'+Add1Zero(IntToStr(MinuteOf(_ndt)))+'-'+Add1Zero(IntToStr(SecondOf(_ndt)));
  end;
var
  excel_dir: string;
begin
  Result:=false;

  if not GenExcelDirName(excel_dir) then exit;
  AFileName:=excel_dir+'\uprcity--('+GenCurrTimeStamp()+')';

  Result:=true;
end;

procedure TGlavUpr.InitFields;
begin
  F_Name:='Сводка для главного упраления города';
  F_ReportFileName:='GlavUpr.frf';
  F_NADO_FROM_DATE:='01.05.2006';
  //F_NADO_FROM_DATE:='01.12.2006';
end;

function TGlavUpr.LoadData: boolean;
var
  frm_Wait: Tfrm_WaitProcess;
begin
  frm_Wait:=Tfrm_WaitProcess.Create(nil);
  try
    frm_Wait.Show;
    F_Dset[0].Open;
    frm_Wait.Hide;
  finally
    frm_Wait.Free;
  end;
end;

procedure TGlavUpr.PrepareDsets;
begin
  AddSelSQLToDset(F_Dset[0], 'select * from rep_glav_upr('''+F_NADO_FROM_DATE+''')');
end;

procedure TGlavUpr.PrepareFastReport;
begin
    frVariables['DT']:=DateToStr(date);
end;

{ THideLeak }

procedure THideLeak.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);
end;

procedure THideLeak.InitFields;
begin
  F_Name:='Сводка скрытых утечек';
  F_ReportFileName:='HideLeak.frf';
end;

procedure THideLeak.OnMainGroupFooterCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add('ИТОГО:');
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure THideLeak.OnRegGroupHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(trim(DataSet.FieldByName('regions').AsString));
  OutRow.Add(FloatToStr(AggregateValueArr[0]));
end;

procedure THideLeak.PrepareDsets;
var
  SelSQL, CountSQL: string;
  add_cond: string;
begin
  with (F_OptionForm as Tfrm_PeriodRegSel) do
  begin
    if RegionsID<>'' then
      add_cond:=' and o.fk_orders_regions in'+RegionsID
    else
      add_cond:='';


    SelSQL:=
      ' select id, OrderNumber, cast(DateComing as Date) DateComing, fk_orders_regions,'+
      ' (select name from s_regions where id=o.fk_orders_regions) regions,'+
      ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
      '     o.housenum, o.additionaladdress)) adres,'+
      ' o.hoodcount, 1 MainGr'+
      ' from orders o'+
      ' where'+
      ' o.fk_orders_damageplace in (1,2)'+
      ' and o.flowspeed=0'+
      add_cond+
      ' and o.DateComing>'''+DateToStr(dp_Date1.Date)+''''+
      ' and o.DateComing<='''+DateToStr(dp_Date2.Date+1)+''''+
      ' order by 5,3';

    CountSQL:=
      ' select count(*) RecordCount'+
      ' from orders o'+
      ' where'+
      ' o.fk_orders_damageplace in (1,2)'+
      ' and o.flowspeed=0'+
      add_cond+
      ' and o.DateComing>'''+DateToStr(dp_Date1.Date)+''''+
      ' and o.DateComing<='''+DateToStr(dp_Date2.Date+1)+'''';
  end;  //end with

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure THideLeak.PrepareFastReport;
begin
  with (F_OptionForm as Tfrm_PeriodRegSel) do
  begin
    frVariables['dt_beg']:=DateToStr(dp_Date1.Date);
    frVariables['dt_end']:=DateToStr(dp_Date2.Date);
    frVAriables['regions']:=strRegions;
  end;
end;

procedure THideLeak.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure THideLeak.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                          (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    F_GridViewBuilder.IDFieldName:='id';

    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'OrderNumber', 'Номер'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'HoodCount', 'Количество', alCenter);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.Alignment:=alCenter;
    group.AddAggregateField(atSum, 'HoodCount');
    group.GroupFooter.OnShowCaption:=OnMainGroupFooterCaption;

    group:=AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
    group.AddAggregateField(atSum, 'HoodCount');
    group.GroupHeader.OnShowCaption:=OnRegGroupHeaderCaption;
  end; // end with
end;

procedure THideLeak.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Сводка скрытых утечек'+#13+
      'На водопроводных сетях г.Харькова с '+DateToStr(dp_Date1.Date)+
      ' по '+DateToStr(dp_Date2.Date);
    LeftLabel:='Район: '+strRegions;
  end;
end;

{ TSvodVed2 }

procedure TSvodVed2.InitFields;
begin
  F_Name:='Сводка для диспетчеров';
  F_ReportFileName:='SvodVed2.frf';
  FLetSendByEmail := true;
end;


procedure TSvodVed2.OnDmgPlaceHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  PrepareDmgPlaceHeader(DataSet, OutRow, true);
end;

procedure TSvodVed2.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(AnsiUpperCase(trim(DataSet.FieldByName('Regions').AsString))+' РАЙОН');
end;

procedure TSvodVed2.PrepareDsets;
var
  SelSQL, CountSQL, ResCond: string;
  NumShift: integer;
  DateShift: TDate;
  strDateShift: string;

begin
  GetShiftsNumAndDate(NumShift, DateShift);

  if DateShift=0 then
    strDateShift:=DateToStr(Date)
  else
    strDateShift:=DateToStr(DateShift);

  ResCond:=prepareCond();
  if ResCond='' then
   ResCond := (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition;


  {if ClassName='TSvodVed_sent'  then
     ResCond:=' where o.fk_orders_damageplace in (1,2,3) ';}

  SelSQL :=' select id, OrderNumber, cast(DateComing as Date) DateComing, FlowSpeed, '+
           ' fk_orders_damageplace, fk_orders_regions,'+
           '  (select result from svod_ved_control_org(o.id)) fk_orders_organisations,'+
           ' cast((cast('+QuotedStr(strDateShift)+' as Date)-cast(DateComing as Date)) as integer) NumDays,'+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
           ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres, '+
           ' (select count(id) from closedbolts'+
           ' where fk_closedbolts_orders=o.id and'+
           ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null))) BoltStatus,'+
           ' (select count(fk_departures_equipment) from departures where fk_departures_orders = o.id '+
           ' and (planstartdate <= ''' + formatdatetime('dd.mm.yyyy',Date+1) +' 08:00:00''  and  planenddate >= ''' + strDateShift + ' 08:00:00'' ) '+
           ' ) ColPlan, '+
           ' 1 MainGr,'+
           ' (select  first(1) trim(f.about) from flooding f where f.fk_id_order=o.id ) flooding, '+
           ' (select max(d.PLANDATEREGL) from departures d where d.FK_DEPARTURES_ORDERS = o.id) reglDate '+

           ' from orders o '+
            ResCond +
           ' and IsClosed=0 order by 9, 5, 3';

  CountSQL:='select count(id) RecordCount from orders o '+
            ResCond+
            ' and IsClosed=0';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TSvodVed2.PrepareResultFormGrid;
var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                      (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'fk_orders_organisations', 'Кон.', alCenter, OnOrgCellShow);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'BoltStatus', 'Состояние'+#13+'задвижки', alLeft, OnBoltStatusCellShow);
    AddColToGVB(F_GridViewBuilder, 'FlowSpeed', 'Q', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft);
    AddColToGVB(F_GridViewBuilder, 'flooding', 'Заливает', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'NumDays', 'Количество'+#13+'дней', alCenter, OnNumDaysShow );
    AddColToGVB(F_GridViewBuilder, 'ColPlan', 'План', alCenter, OnPlanCellShow);
    AddColToGVB(F_GridViewBuilder, 'reglDate', 'Дата'+#13+'план.', alCenter, OnShowDate );

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=AddGroup('fk_orders_regions');
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.OnShowCaption:=OnRegHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;

    group:=AddGroup('fk_orders_damageplace');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clMoneyGreen;
    group.GroupHeader.OnShowCaption:=OnDmgPlaceHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
  end; //end with
end;

procedure TSvodVed2.PrepareResultFormHeader;
var cn:string;
begin
 cn:=classname;
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    if pos('sent',cn)>0 then
      CenterLabel:= 'Ведомость аварийных ситуаций на водопроводных сетях г. Харькова по состоянию на'+DateToStr(Date)
    else
      CenterLabel:='Сводная ведомость для диспетчеров на '+DateToStr(Date);
    LeftLabel:='Районы: '+strRegions+#13+
                'Места повреждения: '+strDamagePlace;
  end;
end;

  function TSvodVed2.prepareCond():string;
  begin
   Result:='';
  end;



{TSvodVedDamage}

constructor TSvodVedDamage.Create;
begin
  inherited;
  FLetSendByEmail := FALSE;
end;

procedure TSvodVedDamage.InitFields;
begin
  F_Name:='Сводная ведомость повреждений';
  F_ReportFileName:='SvodVedDamage.frf';

end;

procedure TSvodVedDamage.PrepareResultFormHeader;
var cn:string;
begin
 cn:=classname;
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin

    CenterLabel:='Сводная ведомость для диспетчеров на '+DateToStr(Date);
    LeftLabel:='Районы: '+strRegions;
  end;
end;

function TSvodVedDamage.prepareCond():string;
begin

   Result:=(F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition +' and '+
            'fk_orders_damageplace in (1,2,3,4,7,13,14)';
end;

procedure TSvodVedDamage.CreateForms;
begin
 inherited;
 (F_OptionForm as Tfrm_PeriodRegDmgSel).chk_IsShort.Visible:=false;
 (F_OptionForm as Tfrm_PeriodRegDmgSel).chk_IsMiddle.Visible:=false;
 (F_OptionForm as Tfrm_PeriodRegDmgSel).btn_DamagePlace.Visible:=false;
end;

{T/TSvodVedDamage}

{ TSvodVed2Land }

constructor TSvodVed2Land.Create;
begin
  inherited;
  FLetSendByEmail := FALSE;
end;

procedure TSvodVed2Land.InitFields;
begin
  F_Name:='Сводная ведомость для диспетчеров водосети';
  F_ReportFileName:='SvodVed2Land.frf';
end;

{ TSvodVed3 }

constructor TSvodVed3.Create;
begin
  inherited;
  FLetSendByEmail := FALSE;
end;

procedure TSvodVed3.InitFields;
begin
  F_Name:='Сводная ведомость для диспетчеров водосети (2 экз.)';
  F_ReportFileName:='SvodVed3.frf';
end;


{TSvodVed_sent}
procedure TSvodVed_sent.InitFields;
begin
 F_Name:='Ведомость аварийных ситуаций на водопроводных сетях г. Харькова на '+DateToStr(Date);
 F_ReportFileName:='SvodVed_sent.frf';
end;

procedure TSvodVed_sent.PrepareResultFormGrid;

 var
  group: TGroup;
  column: TGBColumn;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                      (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'OrderNumber', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'fk_orders_organisations', 'Кон.', alCenter, OnOrgCellShow);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);
    AddColToGVB(F_GridViewBuilder, 'BoltStatus', 'Состояние'+#13+'задвижки', alLeft, OnBoltStatusCellShow);
  //  AddColToGVB(F_GridViewBuilder, 'FlowSpeed', 'Q', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GridViewBuilder, 'DamageLocality', 'Местность', alLeft);
    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата'+#13+'поступления', alCenter);
   // AddColToGVB(F_GridViewBuilder, 'NumDays', 'Количество'+#13+'дней', alCenter, OnNumDaysShow );
   // AddColToGVB(F_GridViewBuilder, 'ColPlan', 'План', alCenter, OnPlanCellShow);

    group:=AddGroup('MainGr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=AddGroup('fk_orders_regions');
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.OnShowCaption:=OnRegHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;

    group:=AddGroup('fk_orders_damageplace');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Color:=clMoneyGreen;
    group.GroupHeader.OnShowCaption:=OnDmgPlaceHeaderCaption;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Alignment:=alCenter;
  end; //end with
end;

constructor TSvodVed_sent.Create;
begin
 inherited;
  FLetSendByEmail := FALSE;
  Cut_Id_reg:=-1;
end;

function TSvodVed_sent.Execute: boolean;
begin
  Result:=false;

//  if not ShowOptionForm then exit;

  ClearDsets;
  PrepareDsets;
  F_RecordCount:=GetRecordCount;

  if F_RecordCount=0 then
  begin
    Application.MessageBox('Записей удовлетворяющих условию запроса не найдено.',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if F_RecordCount>0 then
      if Application.MessageBox(PChar(Format('Найдено %d записей. Показать?', [F_RecordCount])),
                            gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES	then exit;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;

    LoadData;

    F_ResultForm.ShowModal;
  end;

  Result:=false;
end;

procedure TSvodVed_sent.PrepareFastReport;
begin
   frVariables['PrintDate']:=DateToStr(F_PrintDate);
end;


function TSvodVed_sent.prepareCond():string;
begin
 Result:= ' where o.fk_orders_damageplace in (1,2,3) ';

  if (Cut_Id_reg>0 ) then
   Result:=result+ ' and o.fk_orders_regions='+IntTOStr(Cut_Id_reg);

end;

function TSvodVed_sent.SentRegsMail:boolean ;
 procedure EMailPrint();
var
  file_name, shot_fname: string;

  begin
    {Отправка по почте}

    begin
     shot_fname:='avar_svod_';
     file_name := trim( AppSettings.Get_Abon_Path ) + shot_fname +
                      FormatDateTime( 'dd_mm_yyyy', F_PrintDate )+
                      '(' + FormatDateTime( 'ddmmyy_hhmm', Now ) + ')';
    ExportFRToRTFAndSendByEmail(F_Report, file_name, F_Name);
    if assigned(add_sent) then
      add_sent(shot_fname,shot_fname +'('+
                      FormatDateTime( 'dd_mm_yyyy', F_PrintDate )+').xls');
    end;
    {/Отправка по почте}
end;

procedure EMailPrintReg(fn: string; _RegID: integer);
var
  file_name: string;
  begin
    {Отправка по почте}

    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    fn+ReplaceChar(DateToStr(Date), '.', '_')+'.rtf');

    if ExportFastReportToRTF( F_Report, file_name )  then
        SendByEmail( ZipFile(file_name)
            , 'Ведомость аварийных ситуаций на водопроводных сетях г. Харькова на '+DateToStr(Date)
            , _RegID );

    end;
    {/Отправка по почте}
end;

 var
  file_name:string;
  i:integer;
  Region:string;
begin
try
 (F_ResultForm as Tfrm_AnalysisView).pnl_Wait.Caption:='Идет отсылка по почте!';
 (F_ResultForm as Tfrm_AnalysisView).pnl_Wait.Visible:=true;
result:=false;
  try
   EMailPrint();
   for i:=1 to Region_Count do  {9 районов}
   begin
   Cut_Id_reg:=i;
    if not LoadReportFile then
    begin
         result:=false;
         exit;
    end;
    ClearDsets;
    PrepareDsets;
    F_RecordCount:=GetRecordCount;
    if F_RecordCount>0 then
    begin
      F_Dset[0].Open;
      if F_Dset[0].FindField('Regions')<>nil then
      begin
        Region:=trim(F_Dset[0].fieldbyname('Regions').AsString);
        Delete(Region,length(Region)-1,2);
        Region:=Region+'ОГО района ';
      end;

      PrepareFastReport;
      frVariables['Region']:=REgion;
      F_Report.PrepareReport;


      file_name:='avar_svod_'+IntToStr(Cut_Id_reg);
      EMailPrintReg(file_name,Cut_Id_reg);
    end;

   end;
  except
  on e:exception do
    begin
       Result:=false;
       Application.MessageBox('Отпрвка по районам Ведомость аварийных ситуаций','Ошибка',MB_OK+MB_ICONERROR);
       EXIT;
     end;
  end;
  finally
    Cut_Id_reg:=0;
    Result:=true;
    ClearDsets;
    PrepareDsets;
    F_Dset[0].Open;
    frVariables['Region']:='';
  (F_ResultForm as Tfrm_AnalysisView).pnl_Wait.Visible:=false;
  end;
end;
{/TSvodVed_sent}
end.
