
{$WARN DUPLICATE_CTOR_DTOR ON}

unit NGReports_vds;
//{$DEFINE FOR_NOT_MV}  //сводная ведомость ВДС проверка смены
{$define otladka}
{$define proverka}
//{$define forSave }
interface

uses Classes, Controls, NGBaseReport,  FR_Class,FR_DSet, SysUtils, ProgressForm,
     FrPreviewForm, Aligrid, DB, Graphics, AnalysisViewForm,UniversalSearchForm_vds,
     UniversalSearch2DModule_vds,GridViewBuilder, UniSearchResultForm, {OptSvodVedForm,}
     OptSvodVedFormPer_vds ,RepSvodVedDModulePer_vds,
     {RepSvodVedDModule, ResSvodVedForm,} OptRepDiscon_vds, RepDisconDModule_vds,
     ActExeWorksDModule_vds, RepOpenOrdersDModule_vds, VedUsedMatersDModule_vds, PeriodRegSelCBForm_vds,
     CalcMaterCostDModule_vds, RepClosedOrdersDModule_vds, RepCurrentRayonDModule_vds, frm_OptRegSingleUnit_vds,
     SvodkaGekDModule,frm_OptionSvodGekUnit,
     ResSvodVedForm_vds,OptSvodVedForm_vds,RepSvodVedDModule_vds, ResSvodVedForm_vds_new,RepSvodVedDModule_vds_new,
     OptSvodVedForm_vds_2, OptRSvodVed_vds, DModuleRSvodved, RepSvodPer_vdsmewDmodule,PlnanWorkVdsDModule,OptSTexnForm,
     VedNotCloseOrderDModule_vds, WaitProcessForm;

type
  TUniversalSearch2_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_UniversalSearch_vds;
    F_DM: Tdm_UniversalSearch2_vds;
    F_ResFrm: Tfrm_UniSearchResult;
    F_PreviewFrm: Tfrm_FrPreview;
    F_GVB: TGridViewBuilder;
  private
    procedure OnDamageTypeCellShow(ShowValue: variant; var Res: string);
    procedure OnGridFixedColClick(Sender: TObject; col: Integer);
    procedure OnGridClick(Sender: TObject);
    procedure OnPrintClick(Sender: TObject);
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure OnOrderClick(Sender: TObject);dynamic;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;
{$ifdef otladka}
  TSvodVed_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptSvodVed_vds;
    F_DM: Tdm_RepSvodVed_vds;
    F_PreviewFrm: Tfrm_FrPreview;
    F_ResFrm: Tfrm_ResSvodVed_vds;
    F_DtPrint : TDate;
    procedure OnSnapShotClick(Sender: TObject);
    procedure OnLoadSnapShotClick(Sender: TObject);
    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
    property DtPrint: Tdate read F_DtPrint write F_DtPrint;
  end;
{$endif}
  TSvodVedPer_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptSvodVedPer_vds;
    F_DM:Tdm_RepSvodVed_vds_new_per; //Tdm_RepSvodVedPer_vds;
    F_PreviewFrm: Tfrm_FrPreview;
//    F_ResFrm: Tfrm_ResSvodVed;
//    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;



  TRepDiscon_vds=class(TNGBaseReport)
  private
   // F_OptFrm: Tfrm_OptRepDiscon;
    F_OptFrm: Tfrm_PeriodRegSelCB_vds;
    F_DM: Tdm_RepDiscon_vds;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TActExeWorks_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptRepDiscon_vds;
    F_DM: Tdm_ActExeWorks_vds;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TRepOpenOrders_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptRepDiscon_vds;
    F_DM: Tdm_RepOpenOrders_vds;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TRepClosedOrders_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_PeriodRegSelCB_vds;
    F_DM: Tdm_RepClosedOrders_vds;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TRepRayonOrders_vds=class(TNGBaseReport)
  private
    //F_OptFrm: Tfrm_OptRepDiscon;
    F_OptFrm: Tfrm_OptRegSingle_vds;
    F_DM: Tdm_RepCurrentRayon_vds;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TVedUsedMaters_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptRepDiscon_vds;
    F_DM: Tdm_VedUsedMaters_vds;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TCalcMaterCost_vds=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptRepDiscon_vds;
    F_DM: Tdm_CalcMaterCost_vds;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    //procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

 

    //02.02.2012 by glasha

  TSvodkaGek=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptionSvodGek;
    F_DM: Tdm_SvodkaGek_vds;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  {$ifdef otladka}
  TSvodVed_vds_2=class(TNGBaseReport)
protected
    F_OptFrm: Tfrm_OptSvodVed_vds;
    //F_OptFrm: Tfrm_svod_ved_vds_2;

    F_DM: Tdm_RepSvodVed_vds_new;
    F_PreviewFrm: Tfrm_FrPreview;
    F_ResFrm: Tfrm_ResSvodVed_vds_new;
    F_DtPrint : TDate;
    frm_w:Tfrm_WaitProcess;
    procedure OnSnapShotClick(Sender: TObject);
    procedure OnLoadSnapShotClick(Sender: TObject);
    procedure PrepareResultFormBtns;

    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure OnRecalc();
    destructor  Destroy ; override;
   public
    function Execute: boolean; override;
    property DtPrint: Tdate read F_DtPrint write F_DtPrint;
  end;

   TSvodVed_vds_per_2=class(TNGBaseReport)
  private
//    F_OptFrm: Tfrm_OptSvodVed_vds;
    F_OptFrm: Tfrm_svod_ved_vds_2;

    F_DM: Tdm_RepSvodVed_vds_new;
    F_PreviewFrm: Tfrm_FrPreview;

    F_DtPrint : TDate;

  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
   public
    function Execute: boolean; override;
    property DtPrint: Tdate read F_DtPrint write F_DtPrint;
  end;


  //29.08.2012
  TRSvoVed =class (TNGBaseReport)
  private
   F_optFrm:Tfrm_OptRSvod_vds;
   f_DM:Tdm_RSvodved;
   F_PreviewFrm: Tfrm_FrPreview;
   F_dtbeg,F_dtend:tdatetime;
  protected
  procedure InitFields; override;
  procedure CreateForms; override;
  procedure PrepareFastReport; override;
  public
   function Execute:boolean; override;
  end;


  //08.01,.2013
  TPlanWorkVds=class(TNGBaseReport)
  private
   F_OptForm:Tfrm_SOptTexn;
   F_DM:Tdm_PlanWorkVds;
   F_PreviewFrm: Tfrm_FrPreview;
   f_dt:Tdate;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute:boolean; override;
  end;
{$endif}

  TVedNotCloseOrder_vds = class(TNGBaseReport)
  private
    F_PreviewFrm: Tfrm_FrPreview;
    f_dm:Tdm_VedNotCloseOrder_vds;
  protected
    PROCEDURE InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute:boolean ; override;
  end;

implementation

uses Forms, Windows, HelpFunctions, GlobalData, ListForm, shiftnumform,OrderForm_vds,
ApplicationSettings;

{ TUniversalSearch2 }

procedure TUniversalSearch2_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_UniversalSearch_vds, F_Name) as Tfrm_UniversalSearch_vds;
  F_ResFrm:=CreateResultForm(Tfrm_UniSearchResult, F_Name) as Tfrm_UniSearchResult;
  F_DM:=CreateDataModule(Tdm_UniversalSearch2_vds) as Tdm_UniversalSearch2_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TUniversalSearch2_vds.Execute: boolean;
var
  rec_count: integer;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.strStartDate:=F_OptFrm.strStartDate;
  F_DM.strFinishedDate:=F_OptFrm.strFinishedDate;
//  F_DM.IsCalcLeak:=F_OptFrm.IsCalcLeak;
  F_DM.Condition:=F_OptFrm.ResultCondition;
  F_DM.SortType:=stOrderNumberAndDatecoming;
  F_DM.IsAscSort:=true;

  rec_count:=F_DM.GetRecordCount;

  if rec_count<=0 then
  begin
    Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Произвольный поиск', MB_OK+MB_ICONINFORMATION);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Произвольный поиск', MB_YESNO+MB_ICONQUESTION)=ID_YES then
    begin
      F_Pind.Show;
      F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
      try
        F_DM.PrepareDset;
        PrepareResultFormBtns;
        PrepareResultFormGrid;
        F_ResFrm.ShowModal;
      finally
        F_GVB.Free;
      end;
      F_Pind.Hide;
    end;
  end;

  Result:=true;
end;

procedure TUniversalSearch2_vds.InitFields;
begin
  F_Name:='Произвольный поиск';
  F_Pind.CancelButton:=false;
  F_Pind.OnCancel:=nil;
  F_ReportFileName:='from_VDS\UniversalSearch2_1.frf'

end;

procedure TUniversalSearch2_vds.OnDamageTypeCellShow(ShowValue: variant;
  var Res: string);
begin
  if trim(AnsiUpperCase(VarToString(ShowValue)))='<ПУСТО>' then
    Res:='';
end;

procedure TUniversalSearch2_vds.OnGridClick(Sender: TObject);
var
  pReg: TPRegionRec;
begin
  with F_ResFrm do
  begin
    if Assigned(Grid.Objects[1, Grid.Row]) then
    begin
      pReg:=TPRegionRec(Grid.Objects[1, Grid.Row]);
      Region:=pReg.name;
      DmgCount:=pReg.dmg_count;
    end;
  end;
end;

procedure TUniversalSearch2_vds.OnGridFixedColClick(Sender: TObject;
  col: Integer);
var
  order_cond: string;
begin
  case col of
    1: F_DM.SortType:=stOrderNumberAndDatecoming;
    3: F_DM.SortType:=stRegions;
    4: F_DM.SortType:=stAdres;
  end;

  if col in [1,3,4] then
  begin
    F_Pind.Show;
    F_DM.PrepareDset;
    F_ResFrm.Grid.Visible:=false;
    F_GVB.BuildGridView;
    F_ResFrm.Grid.Visible:=true;
    F_ResFrm.Grid.ColorCell[col, 0]:=clSkyBlue;
    F_Pind.Hide;
  end;
end;

procedure TUniversalSearch2_vds.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TUniversalSearch2_vds.PrepareFastReport;
  function DateCaption(dt1, dt2: string): string;
  begin
    Result:='Произвольный поиск нарядов за';
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
begin
  frVariables['Caption']:=DateCaption(F_OptFrm.strStartDate, F_OptFrm.strFinishedDate);
end;

procedure TUniversalSearch2_vds.PrepareResultFormBtns;
begin
  F_ResFrm.Grid.OnFixedColClick:=OnGridFixedColClick;
  F_ResFrm.Grid.OnClick:=OnGridClick;
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
  F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_Print.Visible:=true;
  F_ResFrm.pnl_LeakInfo.Visible:=false;
  F_ResFrm.chk_IsPrintAddInfo.Visible:=false;
end;

procedure TUniversalSearch2_vds.PrepareResultFormGrid;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;

    AddColToGVB(F_GVB, 'OrderNumber', '^ №'+#13+'наряда', alCenter);
   // AddColToGVB(F_GVB, 'OrderNum', '^ №'+#13+'наряда', alCenter);
    AddColToGVB(F_GVB, 'DateComing', 'Дата и время'+#13+'поступления', alCenter);
    AddColTOGVB(F_GVB, 'pr_startregion', 'В'+#13+'р-те' , alCenter);
    AddColTOGVB(F_GVB, 'start_region', 'Взятие '+#13+' работы районом',alCenter);
    AddColToGVB(F_GVB, 'Regions', '^Район', alLeft);
    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'MessageTypes', 'О чем'+#13+'заявлено', alLeft);
    AddColToGVB(F_GVB, 'DamageType', 'Вид'+#13+'повреждения', alLeft, OnDamageTypeCellShow);
    AddColTOGVB(F_GVB, 'pr_endregion', 'Вып-но'+#13+'р-м' , alCenter);
   AddColTOGVB(F_GVB, 'end_region', 'Выполнение'+#13+' работы районом',alCenter);
    AddColToGVB(F_GVB, 'DateClosed', 'Дата и время'+#13+'закрытияия', alCenter);



    BuildGridView;
  end;

  F_ResFrm.Grid.ColorCell[1,0]:=clSkyBlue;
end;

procedure TUniversalSearch2_vds.OnOrderClick(Sender: TObject);
var
  _OrderID: integer;
  _frm_Order: Tfrm_Order_vds;
begin
  with F_ResFrm do
  begin
    StartWait;
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _OrderID := integer(Grid.Objects[0, Grid.Row]);
        _frm_Order := Tfrm_Order_vds.Create( nil, _OrderID );
        StopWait;
        try
          _frm_Order.ShowModal;
        //  if _frm_Order.IsCtrlChange then
          
{          if DM_AomComClient.IsMapWork then
            Grid.Cells[ 1, Grid.Row ] := NameCase( DM_AomComClient.ConvertTypeOfAvarToStr( _frm_Order.AomTypeOfAvar ) );}
        finally
          _frm_Order.Free;
        end;
      end;
    except
      StopWait;
      raise;
    end;
  end;
end;
{$ifdef otladka}
procedure TSvodVed_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptSvodVed_vds, F_Name) as Tfrm_OptSvodVed_vds;
  F_DM:=CreateDataModule(Tdm_RepSvodVed_vds) as Tdm_RepSvodVed_vds;
  F_ResFrm:=CreateResultForm(Tfrm_ResSvodVed_vds, 'Предварительный просмотр') as Tfrm_ResSvodVed_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TSvodVed_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.Dt:=F_OptFrm.Dt;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  MyOpenIBDS(F_DM.dset_tmp,
    ' select count(dt)'+
    ' from SNSHOT_SNAPSHOTS_vds'+
    ' where (dt = '''+ DateToStr(F_DM.Dt) +''')');
  F_DM.dset_tmp.First;
 { if F_DM.dset_tmp.FieldByName('count').AsInteger = 0 then
        F_ResFrm.btn_SnapShot.Enabled := true
        else F_ResFrm.btn_SnapShot.Enabled := false;}
  F_DM.dset_tmp.Close;

  F_DtPrint := F_OptFrm.Dt;

  if F_DM.PrepareDsets then
  begin
    if F_OptFrm.IsShowPreview then
    begin
      PrepareResultFormBtns;
      if F_ResFrm.ShowModal=mrOK then
        PrepareAndPrintFR(F_DM.frReport);
    end else
      PrepareAndPrintFR(F_DM.frReport);
  end;

  Result:=true;
end;

procedure TSvodVed_vds.InitFields;
begin
  F_Name:='Сводная ведомость';
  F_ReportFileName:='from_VDS\SvodVedVDS.frf'
end;

procedure TSvodVed_vds.OnLoadSnapShotClick(Sender: TObject);

  function HappyNewYear(snDate: TDate): boolean;
  var
     _Year_today, _Year_yesterday:string;
  begin
     //
      _Year_yesterday := formatdatetime('yyyy', snDate-1);
      _Year_today := formatdatetime('yyyy', snDate);
      result := _Year_yesterday <> _Year_today;
  end;

var
  frm: Tfrm_List;
  dt, DateShift: TDate;
  ii, ShiftNum: integer;
begin
  frm:=Tfrm_List.Create(nil, 'Список слепков');
  try
  //F_DM.LoadSnapShot();
    F_DM.LoadSnapshotDatesList(frm.List);
    if frm.ShowModal=mrOk then
    begin
      dt:=StrToDate(frm.SelectedValue);
      F_DtPrint := dt;
      F_DM.LoadSnapShot(dt);
      F_DM.HappyNewYear := HappyNewYear(dt);
      F_ResFrm.Caption := 'Предварительный просмотр : слепок за ' + frm.SelectedValue +
              '        ' + F_DM.SnapUser;
{$IFDEF FOR_NOT_MV}
       //проверка даты текущей смены
      if F_ResFrm.CanEdit then
      begin
      GetShiftsNumAndDate( ShiftNum, DateShift);
      if ( time < 0.417)  then      // ограничение до 10 часов утра
       begin
          ii := 1;
          if (formatdatetime('ddd', now) = 'Mon') or (formatdatetime('ddd', now) = 'Пн') then
           ii := ii + 2;
       end
       else
        ii :=0;
      if (dt < DateShift-ii) then
        F_ResFrm.btn_SnapShot.Enabled := false
        else
        F_ResFrm.btn_SnapShot.Enabled := true;
      /////проверка даты текущей смены
      end
      else
      begin
        F_ResFrm.btn_SnapShot.Enabled := false;
        F_ResFrm.DBGridEh.ReadOnly := true;
      end;
{$ENDIF}
    end;
  finally
    frm.Free;
  end;
end;

procedure TSvodVed_vds.OnSnapShotClick(Sender: TObject);
var
  DateShift: TDate;
  ShiftNum: integer;
begin
  if Application.MessageBox('Вы уверены что хотите сохранить слепок?',
    'Сохранение слепка', MB_YESNO+MB_ICONQUESTION)=IDYES then
      begin
        GetShiftsNumAndDate( ShiftNum, DateShift);
    // {$IFDEF FORMV}
     //  if F_ResFrm.CB_D.Checked then
     //{$ENDIF}
      //   F_DM.CurSnapDt := DateShift;
        F_DM.DoSnapShot;
      end;
end;

procedure TSvodVed_vds.PrepareFastReport;
begin
  frVariables['dt']:=DateToStr(F_DtPrint);
  frVariables['disp']:=F_DM.GetOfficialName(g_IDOfficial);
  frVariables['SnapUser']:=F_DM.SnapUser;
end;

procedure TSvodVed_vds.PrepareResultFormBtns;
 var  frm: Tfrm_List;
  dt, DateShift: TDate;
  ii, ShiftNum: integer;
begin
  F_ResFrm.btn_SnapShot.OnClick:=OnSnapShotClick;
  F_ResFrm.btn_LoadSnapshot.OnClick:=OnLoadSnapShotClick;
  F_ResFrm.CalcVsegoZaSmenu:=F_DM.CalcVsegoZaSmenu;

  {$IFDEF FOR_NOT_MV}
  dt:= F_OptFrm.Dt;
       //проверка даты текущей смены
      if F_ResFrm.CanEdit then
      begin
      GetShiftsNumAndDate( ShiftNum, DateShift);
      if ( time < 0.417)  then      // ограничение до 10 часов утра
       begin
          ii := 1;
          if (formatdatetime('ddd', now) = 'Mon') or (formatdatetime('ddd', now) = 'Пн') then
           ii := ii + 2;
       end
       else
        ii :=0;
      if (dt < DateShift-ii) then
        F_ResFrm.btn_SnapShot.Enabled := false
        else
        F_ResFrm.btn_SnapShot.Enabled := true;
      /////проверка даты текущей смены
      end
      else
      begin
        F_ResFrm.btn_SnapShot.Enabled := false;
        F_ResFrm.DBGridEh.ReadOnly := true;
      end;
{$ENDIF}


end;


{/TSvodVed_vds}
{TSvodVedPer_vds}
procedure TSvodVedPer_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptSvodVedPer_vds, F_Name) as Tfrm_OptSvodVedPer_vds;
  F_DM:=CreateDataModule(Tdm_RepSvodVed_vds_new_per) as Tdm_RepSvodVed_vds_new_per;
//  F_ResFrm:=CreateResultForm(Tfrm_ResSvodVed, 'Предварительный просмотр') as Tfrm_ResSvodVed;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TSvodVedPer_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;
  F_DM.Sum_062:= F_OptFrm.cb_o62.Checked;
  F_DM.Sum_Peoples:= F_OptFrm.cb_Peoples.Checked;
  F_DM.Sum_ODS:= F_OptFrm.cb_ODS.Checked;
  F_DM.DtBeg:=F_OptFrm.Dt;
  F_DM.DtEnd:=F_OptFrm.DtEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  if F_DM.PrepareDsets then
      PrepareAndPrintFR(F_DM.frReport);
  Result:=true;
end;

procedure TSvodVedPer_vds.InitFields;
begin
  F_Name:='Сводная ведомость за период';
  F_ReportFileName:='from_vds\SvodVedVDSPer.frf'
end;


procedure TSvodVedPer_vds.PrepareFastReport;
begin
  frVariables['dtBeg']:=DateToStr(F_OptFrm.Dt);
  frVariables['dtEnd']:=DateToStr(F_OptFrm.DtEnd);
  frVariables['disp']:=F_DM.GetOfficialName(g_IDOfficial);
  LoadReportFileTo(F_DM.frReport); // для обработки репорта он должен быть загружен
  F_DM.FrMemoManage;
end;


{TRepDiscon}
 procedure TRepDiscon_vds.CreateForms;
begin
  //F_OptFrm:=CreateOptionForm(Tfrm_OptRepDiscon, F_Name) as Tfrm_OptRepDiscon;
  F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSelCB_vds, F_Name) as Tfrm_PeriodRegSelCB_vds;
  F_DM:=CreateDataModule(Tdm_RepDiscon_vds) as Tdm_RepDiscon_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);  
end;

function TRepDiscon_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;


  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.NCDP:= F_OptFrm.CB.Checked;  
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  f_Dm.StreetsID:=F_OptFrm.StreetsID;
  F_DM.Init;


  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then begin
        PrepareAndPrintFR(F_DM.frReport);
        F_DM.ResultDset.Close;
      end;
    end;
  end;

  Result:=true;
end;

procedure TRepDiscon_vds.InitFields;
begin
  F_Name:='Сводка отключений по ВДС за период';
  F_ReportFileName:='from_Vds\RepDiscon.frf';
end;

procedure TRepDiscon_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
  frVariables['Regions']:=F_OptFrm.RegionsName;
  if pos('-1',F_OptFrm.RegionsName)>0 then
     frVariables['Regions']:='Все';
  frVariables['Streets']:=F_OptFrm.StreetsName;

  if F_OptFrm.CB.Checked then frVariables['dt_hr']:='Суток'
      else
      frVariables['dt_hr']:='Часов';
end;
{/TRepDiscon}


{TRepOpenOrders}
procedure TRepOpenOrders_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptRepDiscon_vds, F_Name) as Tfrm_OptRepDiscon_vds;
  F_DM:=CreateDataModule(Tdm_RepOpenOrders_vds) as Tdm_RepOpenOrders_vds;
  F_PreviewFrm:= Tfrm_FrPreview.Create(f_DM,F_DM.frReport);
end;

function TRepOpenOrders_vds.Execute: boolean;
begin
  Result:=false;
  
  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;

procedure TRepOpenOrders_vds.InitFields;
begin
  F_Name:='Сводка незакрытых нарядов';
  F_ReportFileName:='from_vds\RepOpenOrders.frf';
end;

procedure TRepOpenOrders_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
  frVariables['Caption']:='Поиск открытых нарядов';
end;

{ TRepClosedOrders }
procedure TRepClosedOrders_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSelCB_vds, F_Name) as Tfrm_PeriodRegSelCB_vds;
  F_DM:=CreateDataModule(Tdm_RepClosedOrders_vds) as Tdm_RepClosedOrders_vds;
  F_PreviewFrm:= Tfrm_FrPreview.Create(f_DM,F_DM.frReport);
end;

procedure TRepClosedOrders_vds.InitFields;
begin
  F_Name:='Сводка закрытых нарядов';
  F_ReportFileName:='from_vds\RepClosedOrders.frf';
end;

procedure TRepClosedOrders_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
  frVariables['Caption']:='Поиск закрытых нарядов';
end;

function TRepClosedOrders_vds.Execute: boolean;
begin
  Result:=false;

  F_OptFrm.CB.Caption := 'показать также незакрытые наряды';
  F_OptFrm.btn_Streets.Visible:=false;
  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.ALLChecked:=F_OptFrm.CB.Checked;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;

{ TSvodkaGek }

procedure TSvodkaGek.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptionSvodGek, F_Name) as Tfrm_OptionSvodGek;
  F_DM:=CreateDataModule(Tdm_SvodkaGek_vds) as Tdm_SvodkaGek_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TSvodkaGek.Execute: boolean;

begin
  Result:=false;


//  (F_OptFrm as Tfrm_OptionSvodGek).frame_SelRegion.Visible:=false
  if F_OptFrm.ShowModal<>mrOk then exit;
//  (F_OptFrm as Tfrm_OptRepDiscon).frame_SelRegion.Visible:=true;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
 
  //F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;


procedure TSvodkaGek.InitFields;
begin
  F_Name:='Сводная ведомость в ЖЭК';
  F_ReportFileName:='from_vds\SvodkaGek.frf';
end;

procedure TSvodkaGek.PrepareFastReport;
begin
 
  frVariables['DtBeg']:=DateTimeToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateTimeToStr(F_OptFrm.DTEnd);
end;

{ /TSvodkaGek }


procedure TActExeWorks_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptRepDiscon_vds, F_Name) as Tfrm_OptRepDiscon_vds;
  F_DM:=CreateDataModule(Tdm_ActExeWorks_vds) as Tdm_ActExeWorks_vds;
end;

function TActExeWorks_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;

procedure TActExeWorks_vds.InitFields;
begin
  F_Name:='Акт выполненных работ';
  F_ReportFileName:='from_vds\ActExeWorks.frf';
end;

procedure TActExeWorks_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
end;

{TRepRayonOrders}
procedure TRepRayonOrders_vds.InitFields;
begin

  F_Name:='Отчёт по заявкам  района';
  F_ReportFileName:='from_vds\RepRayonOrders_new.frf';
end;

procedure TRepRayonOrders_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptRegSingle_vds, F_Name) as Tfrm_OptRegSingle_vds;
 // F_OptFrm.frame_SelRegion.Visible := false;
//  F_DM:=CreateDataModule(Tdm_RepClosedOrders) as Tdm_RepClosedOrders;
  F_DM:=CreateDataModule(Tdm_RepCurrentRayon_vds) as Tdm_RepCurrentRayon_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TRepRayonOrders_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
  frVariables['ColLines']:=IntToStr(F_DM.RecordCount);
  F_DM.FillSummary(F_OptFrm.RegID);
end;

function TRepRayonOrders_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  //F_DM.RegionsID:= '(4)';// F_OptFrm.RegionsID;  // пока что только для Ленинского района:)
 // F_DM.RegionsID:= F_OptFrm.RegionsID;  // а теперь для всех районов :)
  F_DM.RegionsID := '('+ IntToStr(F_OptFrm.RegID) +')';
  F_DM.ALLChecked:=true;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
       begin
        PrepareAndPrintFR(F_DM.frReport);
       end;
    end;
  end;

  Result:=true;
end;

{ TVedUsedMaters }

procedure TVedUsedMaters_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptRepDiscon_vds, F_Name) as Tfrm_OptRepDiscon_vds;
  F_DM:=CreateDataModule(Tdm_VedUsedMaters_vds) as Tdm_VedUsedMaters_vds;
end;

function TVedUsedMaters_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;

procedure TVedUsedMaters_vds.InitFields;
begin
  F_Name:='Ведомость использованных материалов';
  F_ReportFileName:='from_vds\VedUsedMaters.frf';
end;

procedure TVedUsedMaters_vds.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.DTBeg);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.DTEnd);
end;

procedure TCalcMaterCost_vds.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptRepDiscon_vds, F_Name) as Tfrm_OptRepDiscon_vds;
  F_DM:=CreateDataModule(Tdm_CalcMaterCost_vds) as Tdm_CalcMaterCost_vds;
end;

function TCalcMaterCost_vds.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;


  F_DM.DtBeg:=F_OptFrm.DTBeg;
  F_DM.DtEnd:=F_OptFrm.DTEnd;
  F_DM.RegionsID:=F_OptFrm.RegionsID;
  F_DM.Init;

  if F_DM.RecordCount=0 then
  begin
    Application.MessageBox('Записей, удовлетворяющих условию запроса не найдено',
      PChar(F_Name), MB_OK+MB_ICONWARNING);
  end else
  begin
    if Application.MessageBox(PChar('Найдено '+IntToStr(F_DM.RecordCount)+' записей. Показать?'),
       PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      if F_DM.PrepareDset then
        PrepareAndPrintFR(F_DM.frReport);
    end;
  end;

  Result:=true;
end;

procedure TCalcMaterCost_vds.InitFields;
begin
  F_Name:='Расчет стоимости материалов';
  F_ReportFileName:='from_vds\CalcMaterCost.frf';
end;


{TRepRayonOrders}


{/TRepRayonOrders}
{$endif}

{TSvodVed_vds_2}

procedure TSvodVed_vds_2.OnSnapShotClick(Sender: TObject);
var
  DateShift: TDate;
  ShiftNum: integer;
begin
  if Application.MessageBox('Вы уверены что хотите сохранить слепок?',
    'Сохранение слепка', MB_YESNO+MB_ICONQUESTION)=IDYES then
      begin
        GetShiftsNumAndDate( ShiftNum, DateShift);
    // {$IFDEF FORMV}
     //  if F_ResFrm.CB_D.Checked then
     //{$ENDIF}
      //   F_DM.CurSnapDt := DateShift;
      if (Now()-f_Dm.DT_End<1) and ( time<0.417) then    // ограничение до 10 часов утра
      begin
        F_Dm._save:=true;
        F_Dm.Recalc;
      end;
       if F_DM.DoSnapShot then
        Application.MessageBox('Cлепoк сохранен!','Сохранение слепка', MB_OK);
      end;
    F_Dm._save:=false;  
end;


procedure TSvodVed_vds_2.OnLoadSnapShotClick(Sender: TObject);

  function HappyNewYear(snDate: TDate): boolean;
  var
     _Year_today, _Year_yesterday:string;
  begin
     //
      _Year_yesterday := formatdatetime('yyyy', snDate-1);
      _Year_today := formatdatetime('yyyy', snDate);
      result := _Year_yesterday <> _Year_today;
  end;

var
  frm: Tfrm_List;
  dt, DateShift: TDate;
  ii, ShiftNum: integer;
begin
  frm:=Tfrm_List.Create(nil, 'Список слепков');
  try
  //F_DM.LoadSnapShot();
    F_DM.LoadSnapshotDatesList(frm.List);
    if frm.ShowModal=mrOk then
    begin
      dt:=StrToDate(frm.SelectedValue);
      F_DtPrint := dt;
      F_DM.Dt:=dt;
      F_DM.DT_Beg:=Dt+StrToTime('6:00:01');
      F_DM.DT_End:=Dt+1+StrToTime('6:00:00');
      F_DM.LoadSnapShot(dt);
    //  F_DM.HappyNewYear := HappyNewYear(dt);
      F_ResFrm.Caption := 'Предварительный просмотр : слепок за ' + frm.SelectedValue +
              '        ' + F_DM.SnapUser;
{$IFDEF FOR_NOT_MV}
       //проверка даты текущей смены
      if F_ResFrm.CanEdit then
      begin
      GetShiftsNumAndDate( ShiftNum, DateShift);
      if ( time < 0.417)  then      // ограничение до 10 часов утра
       begin
          ii := 1;
          if (formatdatetime('ddd', now) = 'Mon') or (formatdatetime('ddd', now) = 'Пн') then
           ii := ii + 2;
       end
       else
        ii :=0;
      if (dt < DateShift-ii) then
        F_ResFrm.btn_SnapShot.Enabled := false
        else
        F_ResFrm.btn_SnapShot.Enabled := true;
      /////проверка даты текущей смены
      end
      else
      begin
        F_ResFrm.btn_SnapShot.Enabled := false;
        F_ResFrm.DBGridEh.ReadOnly := true;
      end;
{$ENDIF}
    end;
  finally
    frm.Free;
  end;
end;



procedure TSvodVed_vds_2.PrepareResultFormBtns;
 var  frm: Tfrm_List;
  dt, DateShift: TDate;
  ii, ShiftNum: integer;
begin
   F_ResFrm.Caption:='Предварительный просмотр '+DateToStr(f_DM.Dt);
  F_ResFrm.btn_SnapShot.OnClick:=OnSnapShotClick;
  F_ResFrm.btn_LoadSnapshot.OnClick:=OnLoadSnapShotClick;
  F_ResFrm.CalcVsegoZaSmenu:=OnRecalc;

  {$IFDEF FOR_NOT_MV}
  dt:= F_OptFrm.Dt;
       //проверка даты текущей смены
      if F_ResFrm.CanEdit then
      begin
      GetShiftsNumAndDate( ShiftNum, DateShift);
      if ( time < 0.417)  then      // ограничение до 10 часов утра
       begin
          ii := 1;
          if (formatdatetime('ddd', now) = 'Mon') or (formatdatetime('ddd', now) = 'Пн') then
           ii := ii + 2;
       end
       else
        ii :=0;
      if (dt < DateShift-ii) then
        F_ResFrm.btn_SnapShot.Enabled := false
        else
        F_ResFrm.btn_SnapShot.Enabled := true;
      /////проверка даты текущей смены
      end
      else
      begin
        F_ResFrm.btn_SnapShot.Enabled := false;
        F_ResFrm.DBGridEh.ReadOnly := true;
      end;
{$ENDIF}
{$ifdef forSave }
  if AppSettings.Get_SaveVdsSvod2<>'1' then
       F_ResFrm.btn_SnapShot.Enabled:=false;
{$endif}


end;

procedure TSvodVed_vds_2.OnRecalc();
begin
   frm_w.Show;
   try
     F_DM.Recalc;
   finally
    frm_w.Hide;
   end;
end;

procedure TSvodVed_vds_2.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptSvodVed_vds, F_Name) as Tfrm_OptSvodVed_vds;

//  F_OptFrm:=CreateOptionForm(Tfrm_svod_ved_vds_2, F_Name) as Tfrm_svod_ved_vds_2;
  F_DM:=CreateDataModule(Tdm_RepSvodVed_vds_new) as Tdm_RepSvodVed_vds_new;
  F_ResFrm:=CreateResultForm(Tfrm_ResSvodVed_vds_new, 'Предварительный просмотр') as Tfrm_ResSvodVed_vds_new;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
  frm_w:=Tfrm_WaitProcess.Create(nil);
   F_DM.PSetMessage:=frm_w.setMessage;
end;

procedure TSvodVed_vds_2.InitFields;
begin
  F_Name:='Сводная ведомость 2';
  F_ReportFileName:='from_VDS\SvodVedVDS_2.frf';

end;


function TSvodVed_vds_2.Execute: boolean;
 function HappyNewYear(snDate: TDate): boolean;
  var
     _Year_today, _Year_yesterday:string;
  begin
     //
      _Year_yesterday := formatdatetime('yyyy', snDate-1);
      _Year_today := formatdatetime('yyyy', snDate);
      result := _Year_yesterday <> _Year_today;
  end;
   var fl:boolean;
   
begin
  Result:=false;
  F_OptFrm.frame_SelRegion.Visible:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;



   F_DM.Dt:=F_OptFrm.Dt;
   F_DM.DT_Beg:=F_OptFrm.Dt+StrToTime('6:00:01');
   F_DM.DT_End:=F_OptFrm.Dt+1+StrToTime('6:00:00');
   F_dm.tip:=0;
   F_DM.Org:=vds;

  F_DM.RegionsID:='';//F_OptFrm.RegionsID;
  MyOpenIBDS(F_DM.dset_tmp,
    ' select count(dt)'+
    ' from SNSHOT_SNAPSHOTS_vds'+
    ' where (dt = '''+ DateToStr(F_DM.Dt) +''') and id_type=2');
  F_DM.dset_tmp.First;
 { if F_DM.dset_tmp.FieldByName('count').AsInteger = 0 then
        F_ResFrm.btn_SnapShot.Enabled := true
        else F_ResFrm.btn_SnapShot.Enabled := false;}
  F_DM.dset_tmp.Close;

  F_DtPrint := F_OptFrm.Dt;
  F_Dm.HappyNewYear:=HappyNewYear(F_OptFrm.Dt);

  frm_w.show;


 // frm_w.Hide;
  try
  if   F_DM.PrepareDsets_new  then
  begin
    frm_w.Hide;
    if F_OptFrm.IsShowPreview then
    begin
      PrepareResultFormBtns;
      if F_ResFrm.ShowModal=mrOK then
        PrepareAndPrintFR(F_DM.frReport);
    end
    else
      PrepareAndPrintFR(F_DM.frReport);
  end;
  finally
   frm_w.Hide;
  end;

  Result:=true;
end;

procedure TSvodVed_vds_2.PrepareFastReport;
begin

  frVariables['dt']:=DateToStr(F_DtPrint);
  frVariables['disp']:=F_DM.GetOfficialName(g_IDOfficial);
  frVariables['SnapUser']:=F_DM.SnapUser;
  frVariables['Orgs']:='"ВДС"' ;
    frVariables['dt_end']:=DateTimeToStr(F_DM.DT_End) ;
   frVariables['dt_beg']:=DateTimeToStr(F_DM.DT_beg) ;
end;

destructor  TSvodVed_vds_2.Destroy ;
begin
   frm_w.free;
   inherited;
end;
{/TSvodVed_vds_2}

{Svodved_vds_per_2}
procedure TSvodVed_vds_per_2.CreateForms;
begin
//  F_OptFrm:=CreateOptionForm(Tfrm_OptSvodVed_vds, F_Name) as Tfrm_OptSvodVed_vds;

  F_OptFrm:=CreateOptionForm(Tfrm_svod_ved_vds_2, F_Name) as Tfrm_svod_ved_vds_2;
  F_DM:=CreateDataModule(Tdm_RepSvodVed_vds_new) as Tdm_RepSvodVed_vds_new;

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TSvodVed_vds_per_2.InitFields;
begin
  F_Name:='Сводная ведомость за период';
  F_ReportFileName:='from_VDS\SvodVedVDS_3.frf'
end;

procedure TSvodVed_vds_per_2.PrepareFastReport;
begin

  frVariables['dt']:='период с'+FormatDateTime('dd.mm.yyyy hhh:mm',F_OptFrm.BegDate)+
                     ' по '+FormatDateTime('dd.mm.yyyy hhh:mm',F_OptFrm.EndDate);

  frVariables['disp']:=F_DM.GetOfficialName(g_IDOfficial);
  frVariables['SnapUser']:=F_DM.SnapUser;
end;

function TSvodVed_vds_per_2.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;
  F_DM.Dt:=F_OptFrm.BegDate;
  F_DM.DT_Beg:=F_OptFrm.BegDate;
  F_DM.DT_End:=F_OptFrm.EndDate;
  
  F_dm.tip:=2;
  F_dm.Org:=vds;
  F_DM.RegionsID:='';//F_OptFrm.RegionsID;
  MyOpenIBDS(F_DM.dset_tmp,
    ' select count(dt)'+
    ' from SNSHOT_SNAPSHOTS_vds'+
    ' where (dt = '''+ DateToStr(F_DM.Dt) +''') and id_type=2');
  F_DM.dset_tmp.First;
 { if F_DM.dset_tmp.FieldByName('count').AsInteger = 0 then
        F_ResFrm.btn_SnapShot.Enabled := true
        else F_ResFrm.btn_SnapShot.Enabled := false;}
  F_DM.dset_tmp.Close;

  F_DtPrint := F_OptFrm.Dt;

  if F_DM.PrepareDsets_new then
  begin
       PrepareAndPrintFR(F_DM.frReport);
  end;

  Result:=true;
end;


{/}

{TRSvoVed}
function TRSvoVed.execute:boolean;
begin
 Result:=false;
 if F_OptFrm.ShowModal<>mrOk then exit;

 F_DM.BegDate:=F_optFrm.BeginDateTime;
 F_DM.EndDate:=F_optFrm.EndDateTime;
 F_DM.Regions_id:=F_optFrm.F_RegionsID;
 F_DM.typ:=F_optFrm.F_Typ;
 F_DM.Orgs_id:= F_optFrm.F_organs_ID;
 F_DM.DamPlace_ID := F_optFrm.F_DamagePlace_ID;

 if F_Dm.PrepareDsets_vds then
 begin
     PrepareAndPrintFR(F_DM.frReport);
 end;
 Result:=true;
end;


procedure TRSvoVed.InitFields;
begin
  F_Name:='Расширенная сводная ведомость по ВДС';
  F_ReportFileName:='from_VDS\RSvod_ved_vds.frf'
end;

procedure TRSvoVed.CreateForms;
begin
 F_Dm:= CreateDataModule(Tdm_RSvodved) as Tdm_RSvodved;
 F_OptFrm:=CreateOptionForm(Tfrm_OptRSvod_vds, F_Name) as Tfrm_OptRSvod_vds;
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TRSvoVed.PrepareFastReport;
begin
 frVariables['PrintDateTime']:=formatdatetime('dd.mm.yyyy hh:mm',Now());
 frVariables['beg_date']:=formatdatetime('dd.mm.yyyy hh:mm', F_DM.BegDate);
 frVariables['end_date']:=formatdatetime('dd.mm.yyyy hh:mm', F_DM.EndDate);

end;
{/TRSvoVed}

//TPlanWorkVds 08.01.2013
procedure TPlanWorkVds.CreateForms;
begin
 F_DM:=CreateDataModule(Tdm_PlanWorkVds) as Tdm_PlanWorkVds;
 F_OptForm :=CreateOptionForm(Tfrm_SOptTexn, F_Name) as Tfrm_SOptTexn;
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TPlanWorkVds.InitFields;
begin
 F_Name:='Сводка по запланированным работам ВДС';
 F_ReportFileName:='from_VDS\PlanWorkMater.frf';

end;

procedure TPlanWorkVds.PrepareFastReport;
begin
frVariables['DateTime']:=F_Dt;
end;

function  TPlanWorkVds.Execute:boolean;
begin
 Result:=false;
 if F_OptForm.ShowModal<>mrOk then exit;
 F_Dt:= F_OptForm._Date;
 F_Dm._Dt:=F_Dt;
 if F_Dm.PrepareDsets then
     PrepareAndPrintFR(F_DM.frReport);
 Result:=true;
end;


{TVedNotCloseOrder_vds}
procedure TVedNotCloseOrder_vds.CreateForms;
begin
  f_Dm:=CreateDataModule(Tdm_VedNotCloseOrder_vds) as Tdm_VedNotCloseOrder_vds;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

PROCEDURE TVedNotCloseOrder_vds.InitFields;
begin
  f_name:='Сводная ведомостьн езакрытых нарядов';
  F_ReportFileName:='from_VDS\VedNotCloseOrder_vds.frf';
end;

PROCEDURE TVedNotCloseOrder_vds.PrepareFastReport;
begin
  frVariables['DatePrint']:=Date();
end;

function TVedNotCloseOrder_vds.Execute:boolean;
begin
 result:=false;
 if f_Dm.PrepareDsets then
  PrepareAndPrintFR(F_DM.frReport);
 result:=false;
end;
{/TVedNotCloseOrder_vds}

end.

