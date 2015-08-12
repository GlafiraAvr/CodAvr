unit AVR_Analysis;

interface

uses SysUtils, Graphics ,Controls, IBCustomDataSet, BaseOptionForm,
      BaseResultForm, FR_Class, FR_DSet, GlobalData, Dialogs, Aligrid,
      Classes, ExcelWorksForm, ProgressForm, Chart, TeenGine, CustomReport,
      Analysis_HelpClasses;

type

  TBaseAnalysis=class(TCustomReport)
  protected
    F_frUDS: TfrUserDataset;
    F_NumRow: integer;
  protected
    procedure ResetResultForm; virtual;
  public
    property frUDS: TfrUserDataset write F_frUDS;
  public
    function Execute: boolean; override;  
  end;

  TAnNoWorkingKol=class(TBaseAnalysis)
  private
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnRegionDamageCount=class(TBaseAnalysis)
  private
    F_RegionList: TList;
    procedure ClearRegionList;

    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TAnDmgWithTemper=class(TBaseAnalysis)
  private
    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: Tobject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnLeakPeriod=class(TBaseAnalysis)
  private
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnLeakDmgPlace=class(TBaseAnalysis)
  private
    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnLeakDmgLoc=class(TBaseAnalysis)
  private
    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnLeakDiam=class(TBaseAnalysis)
  private
    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnLeakDays=class(TBaseAnalysis)
  private
    F_RegionList: TList;
    procedure CleareRegionList;
    procedure ExcelClick(Sender: TObject);
    procedure GraphClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TAnLeakTime=class(TBaseAnalysis)
  private
    F_Dates: TStringList;
    procedure ExcelClick(Sender: TObject);
    procedure GraphClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormBtns; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TAnBrigDep=class(TBaseAnalysis)
  private
    procedure ExcelClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnComingClosedEquip=class(TBaseAnalysis)
  private
    procedure GraphClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnDmgPeriod=class(TBaseAnalysis)
  private
    procedure GraphClick(sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnEquipUse=class(TBaseAnalysis)
  private
    procedure PrintClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
    procedure GraphClick(Sender: TObject);
    procedure OnFirst(Sender: TObject);
    procedure OnNext(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  end;

  TAnSearchAdres=class(TBaseAnalysis)
  private
    F_AdresList: TList;

    function DateCaption(dt1, dt2, DmgCount: string): string;
    procedure ClearAdresList;

    procedure OrderClick(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure ExcelClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareResultFormGrid; override;
    procedure CreateForms; override;
    function LoadData: boolean; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;


implementation

uses DModule, AVR_Report, AnalysisViewForm, DatesSelForm, PeriodCloseRegDmgSelForm,
      RegionDamageCount, DmgChartForm, MiniUniversalSelForm, UnChartForm,
      HelpFunctions, AnLeakOptSelForm, AnLeakLocSelForm, AnLeakDiamSelForm,
      LeakDiamChartForm, AnLeakDaysSelForm,
      AnLeakTimeSelForm, AnBrigDepSelForm, AnDateDmgEquipSelForm,
      ComingClosedEquipChartForm, PeriodRegDmgDiamSelForm, WaitProcessForm;

{ TBaseAnalysis }

function TBaseAnalysis.Execute: boolean;
var
  frm_Wait: Tfrm_WaitProcess;
  is_load_data: boolean;
begin
  Result:=false;

  if not ShowOptionForm then exit;

  frm_Wait:=Tfrm_WaitProcess.Create(nil);
  try
    frm_Wait.Show;

    ResetResultForm;
    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
    is_load_data:=LoadData;

    frm_Wait.Hide;
  finally
    frm_Wait.Free;
  end;


  if is_load_data then
  begin
    if F_ResultForm is Tfrm_AnalysisView then
      (F_ResultForm as Tfrm_AnalysisView).Grid.AdjustColWidths;
    F_ResultForm.ShowModal;
  end;

  Result:=true;
end;

procedure TBaseAnalysis.ResetResultForm;
begin
  if F_ResultForm is Tfrm_AnalysisView then
    (F_ResultForm as Tfrm_AnalysisView).ResetForm;
end;

{ TAnNoWorkingKol }

procedure TAnNoWorkingKol.CreateForms;
begin
  F_OptionForm:=Tfrm_DatesSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnNoWorkingKol.InitFields;
begin
  F_Name:='Кол-во неработающих колонок за период';
  F_ReportFileName:='an_NoWorkingKol.frf';
end;

function TAnNoWorkingKol.LoadData: boolean;
var
  SelSQL: string;
  dt_begin, dt_end, dt_b, dt_e: TDate;
  i, j, k: integer;
begin
  Result:=false;

  with F_OptionForm as Tfrm_DatesSel do
  begin
    dt_begin:=dp_Date1.Date;
    dt_end:=dp_Date2.Date;
  end;

  SelSQL:=Format( ' select DateComing, DateClosed'+
                  ' from orders o '+
                  ' where fk_orders_DamagePlace=4'+
                  ' and DateComing<=''%s'' and (DateClosed>=''%s'' or DateClosed is null)',
                  [DateToStr(dt_end), DateToStr(dt_begin)]);

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    for i:=0 to Grid.RowCount-2 do
      Grid.Cells[0, i+1]:=DateToStr(dt_begin+i);

    MyOpenSQL(F_Dset[0], SelSQL);
    while not F_Dset[0].Eof do
    begin
      dt_b:=trunc(F_Dset[0].FieldByName('DateComing').AsDateTime);
      dt_e:=trunc(F_Dset[0].FieldByName('DateClosed').AsDateTime);

      {Не работало}
      i:=trunc(dt_b-dt_begin)+1;
      if dt_e=0 then j:=Grid.RowCount-1
      else j:=trunc(dt_e-dt_begin)+1;
      for k:=i+1 to j do
      if (k>0) and (k<Grid.RowCount) then
        Grid.Cells[1,k]:=IntToStr(StrToIntDef(Grid.Cells[1,k],0)+1);
      {/Не работало}

      {Поступило}
      if (dt_b>=dt_begin) and (dt_b<=dt_end) then
      begin
        i:=trunc(dt_b-dt_begin)+1;
        Grid.Cells[2,i]:=IntToStr(StrToIntDef(Grid.Cells[2,i],0)+1);
      end;
      {/Поступило}

      {Отремонтировано}
      if (dt_e>=dt_begin) and (dt_e<=dt_end) then
      begin
        i:=trunc(dt_e-dt_begin)+1;
        Grid.Cells[3,i]:=IntToStr(StrToIntDef(Grid.Cells[3,i],0)+1);
      end;
      {/Отремонтировано}

      {Отремонтировано в тот же день}
      if (dt_e=dt_b) and (dt_e>=dt_begin) and (dt_e<=dt_end) then
      begin
        i:=trunc(dt_e-dt_begin)+1;
        Grid.Cells[4,i]:=IntToStr(StrToIntDef(Grid.Cells[4,i],0)+1);
      end;
      {/Отремонтировано в тот же день}

      F_Dset[0].Next;
    end; //end while
    F_Dset[0].Close;
  end; //end with

  Result:=true;
end;


procedure TAnNoWorkingKol.OnFirst(Sender: TObject);
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Date']:=Grid.Cells[0, F_NumRow];
    frVariables['NoWorking']:=Grid.Cells[1, F_NumRow];
    frVariables['Coming']:=Grid.Cells[2, F_NumRow];
    frVariables['Repair']:=Grid.Cells[3, F_NumRow];
    frVariables['RepairNow']:=Grid.Cells[4, F_NumRow];
  end;
end;

procedure TAnNoWorkingKol.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnNoWorkingKol.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintClick;  //Процедура печати
  end;  //end with
end;

procedure TAnNoWorkingKol.PrepareResultFormGrid;
var
  dt_begin, dt_end: TDate;
begin
  with F_OptionForm as Tfrm_DatesSel do
  begin
    dt_begin:=dp_Date1.Date;
    dt_end:=dp_Date2.Date;
  end;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=5;
    Grid.RowCount:=trunc(dt_end)-trunc(dt_begin)+2;
    Grid.FixedCols:=0;
    Grid.FixedRows:=1;
    //Grid.RowFont[0].Style:=[fsBold];
    Grid.CellFont[0,0].Style:=[fsBold];
    Grid.CellFont[1,0].Style:=[fsBold];
    Grid.CellFont[2,0].Style:=[fsBold];
    Grid.CellFont[3,0].Style:=[fsBold];
    Grid.CellFont[4,0].Style:=[fsBold];

    Grid.Cells[0,0]:='Дата смены';
    Grid.Cells[1,0]:='Неработающих';
    Grid.Cells[2,0]:='Поступивших';
    Grid.Cells[3,0]:='Отремантировано';
    Grid.Cells[4,0]:='Отремантировано в тот же день';

    Grid.AdjustColWidths;
  end;  //end with
end;

procedure TAnNoWorkingKol.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_DatesSel) do
  begin
    CenterLabel:='Количество неработающих колонок за период'+#13+
                  Format('с %s по %s ',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
  end;  //end with
end;

procedure TAnNoWorkingKol.PrintClick(Sender: TObject);
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
  end;

  F_NumRow:=1;
  ShowReport;
end;

{ TAnRegionDamageCount }

procedure TAnRegionDamageCount.ClearRegionList;
var
  i: integer;
begin
  for i:=0 to F_RegionList.Count-1 do
    Dispose(F_RegionList.Items[i]);
  F_RegionList.Clear;
end;

constructor TAnRegionDamageCount.Create;
begin
  inherited Create;
  F_RegionList:=TList.Create;
end;

procedure TAnRegionDamageCount.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodCloseRegDmgSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).btn_Regions.Visible:=false;

  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

destructor TAnRegionDamageCount.Destroy;
begin
  ClearRegionList;
  F_RegionList.Free;

  inherited Destroy;
end;

procedure TAnRegionDamageCount.ExcelClick(Sender: TObject);
var
  Title: string;
  p: integer;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  p:=pos(#13, Title);
  if p<>0 then Title[p]:=' ';

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnRegionDamageCount.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_DmgChart;
begin
  frm_Chart:=Tfrm_DmgChart.Create(nil, (F_ResultForm as Tfrm_AnalysisView).CenterLabel,
                                  F_RegionList);
  frm_Chart.ShowModal;
end;

procedure TAnRegionDamageCount.InitFields;
begin
  F_Name:='Анализ кол-ва повреждений по всем районам';
  F_ReportFileName:='an_RegionDamageCount.frf';
end;

function TAnRegionDamageCount.LoadData: boolean;
var
  pRegDmg, pTotDmg: TPRegDmg;
  CountSQL: string;
  i, j, row: integer;

  function DmgCalc(id_Reg, id_Dmg: integer): integer;
  begin
    MyOpenSQL(F_Dset[1], Format(CountSQL, [id_Reg, id_Dmg]));
    Result:=F_Dset[1].FieldByName('count').AsInteger;
    F_Dset[1].Close;
  end;

  function Percent(Chis, Znam: integer): string;
  begin
    if Znam=0 then
      Result:='0'
    else
      Result:=FormatFloat('0.##',(Chis/Znam)*100)
  end;

begin
  Result:=false;

  CountSQL:=' select count(id)'+
            ' from orders o'+
            (F_OptionForm as Tfrm_PeriodCloseRegDmgSel).ResultCondition+
            ' and IsClosed=1'+
            ' and fk_orders_regions=%d'+
            ' and fk_orders_damagetype=%d';

  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    MyOpenSQL(F_Dset[0],' select id, name from s_Regions'+
                        ' where (id>0) and (activity is null) order by name');

    New(pTotDmg);
    for i:=1 to 5 do
      pTotDmg.RegDmgArr[i]:=0;
    pTotDmg.Total:=0;
    pTotDmg.Name:='ИТОГО ПО ГОРОДУ';

    ClearRegionList;
    while not F_Dset[0].Eof do
    begin
      New(pRegDmg);
      pRegDmg.Total:=0;
      for i:=1 to 5 do
      begin
        pRegDmg.Name:=F_Dset[0].FieldByName('name').AsString;
        pRegDmg.RegDmgArr[i]:=DmgCalc(F_Dset[0].FieldByName('id').AsInteger, i);
        pRegDmg.Total:=pRegDmg.Total+pRegDmg.RegDmgArr[i];
        pTotDmg.RegDmgArr[i]:=pTotDmg.RegDmgArr[i]+pRegDmg.RegDmgArr[i];
        pTotDmg.Total:=pTotDmg.Total+pRegDmg.RegDmgArr[i];
      end;
      F_RegionList.Add(pRegDmg);
      F_Dset[0].Next;
    end;  // end while
    F_Dset[0].Close;
    F_RegionList.Add(pTotDmg);

    Grid.RowCount:=(2*F_RegionList.Count)+1;
    Grid.ColorRow[Grid.RowCount-2]:=clYellow;

    for i:=1 to F_RegionList.Count do
    begin
      row:=2*i-1;
      pRegDmg:=(F_RegionList.Items[i-1]);

      Grid.Cells[0, row]:=pRegDmg.Name;
      Grid.Cells[0, row+1]:='В ПРОЦЕНТАХ';

      for j:=1 to 5 do
      begin
        Grid.Cells[j, row]:=IntToStr(pRegDmg.RegDmgArr[j]);
        Grid.Cells[j, row+1]:=Percent(pRegDmg.RegDmgArr[j], pRegDmg.Total);
      end;
      Grid.Cells[6, row]:=IntToStr(pRegDmg.Total);
      Grid.Cells[7, row]:=Percent(pRegDmg.Total,pTotDmg.Total);

      Grid.ColorRow[row+1]:=clSilver;
      Grid.ColorCell[6, row]:=clLime;
      Grid.ColorCell[7, row]:=clLime;
    end;
  end; // end with

  Result:=true;
end;

procedure TAnRegionDamageCount.OnFirst(Sender: TObject);
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    for i:=0 to 7 do
      frVariables['Col'+IntToStr(i)]:=Grid.Cells[i, F_NumRow];
  end;
end;

procedure TAnRegionDamageCount.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnRegionDamageCount.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Print.OnClick:=PrintClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Graph.OnClick:=GraphClick;
  end; // end with
end;

procedure TAnRegionDamageCount.PrepareResultFormGrid;
var
  i: integer;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    Grid.ColCount:=8;
    Grid.RowCount:=2;
    Grid.FixedCols:=0;
    Grid.FixedRows:=1;

    Grid.Cells[0,0]:='Район';
    Grid.Cells[1,0]:='Трещина'; //id=1
    Grid.Cells[2,0]:='Перелом'; //id=2
    Grid.Cells[3,0]:='Стык соед.';   //id=3
    Grid.Cells[4,0]:='Свищь';  //id=4
    Grid.Cells[5,0]:='Прочие';  //id=5
    Grid.Cells[6,0]:='Итого';
    Grid.Cells[7,0]:='Итого в %';

    //Grid.RowFont[0].Style:=[fsBold];
    for i:=0 to 7 do
    begin
      Grid.CellFont[i,0].Style:=[fsBold];
      Grid.AlignCell[i,0]:=alCenter;
    end;
  end; // end with
end;

procedure TAnRegionDamageCount.PrepareResultFormHeader;
  function DateCaption(dt1, dt2: string): string;
  begin
    Result:='Аварии на в/сетях г.Харькова'+#13+'за';
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
var
  fOp: Tfrm_PeriodCloseRegDmgSel;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    fOp:=F_OptionForm as Tfrm_PeriodCloseRegDmgSel;
    CenterLabel:=DateCaption(fOp.strStartDate, fOp.strFinishedDate);
    LeftLabel:='Место повреждения: '+fOp.strDamagePlace;
  end; // end with
end;

procedure TAnRegionDamageCount.PrintClick(Sender: TObject);
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    frVariables['DamagePlace']:=(F_OptionForm as Tfrm_PeriodCloseRegDmgSel).strDamagePlace;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;

    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
  end;

  F_NumRow:=1;

  ShowReport;
end;

{ TAnDmgWithTemper }

procedure TAnDmgWithTemper.CreateForms;
begin
  F_OptionForm:=Tfrm_MiniUniversalSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnDmgWithTemper.ExcelClick(Sender: TObject);
var
  Title: string;
  p: integer;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  p:=pos(#13, Title);
  if p<>0 then Title[p]:=' ';

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnDmgWithTemper.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  i: integer;
  dt1, dt2: string;
begin
  frm_Chart:=Tfrm_Chart.Create(nil, 'График рез. анализа повреждений за период');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView),
       (F_OptionForm as Tfrm_MiniUniversalSel)  do
  begin
    {Заголовок диаграммы}
    dt1:=DateToStr((F_OptionForm as Tfrm_MiniUniversalSel).dp_Date1.Date);
    dt2:=DateToStr((F_OptionForm as Tfrm_MiniUniversalSel).dp_Date2.Date);

    Title.Text.Clear;
    Title.Text.Add('Количество повреждений за период с '+dt1+' по '+dt2);
    Title.Text.Add('Район:'+strRegions+'; Место повреждения:'+strDamagePlace+';');
    Title.Text.Add('Местность повреждения:'+strDamageLocality+'; Вид повреждения:'+strDamageType+';');
    Title.Text.Add('Диаметр трубы:'+strTubeDiameter+'; Материал трубы:'+strTubeMaterial);
    {/Заголовок диаграммы}

    BottomAxis.LabelsAngle:=90;
    Legend.Visible:=true;
    Legend.Alignment:=laBottom;

    AddChartSeries(stLine);
    ChartSeries[0].SeriesColor:=clRed;
    ChartSeries[0].Title:='Кол-во пост.';

    AddChartSeries(stLine);
    ChartSeries[1].SeriesColor:=clGreen;
    ChartSeries[1].Title:='Кол-во ликв.';

    if Grid.ColCount>4 then  //если есть столбец температуры
    begin
      AddChartSeries(stLine);
      ChartSeries[2].SeriesColor:=clBlue;
      ChartSeries[2].Title:='Тем-ра';
    end;

    for i:=1 to Grid.RowCount-1 do
    begin
      ChartSeries[0].Add(StrToFloat(Grid.Cells[2, i]), Grid.Cells[1,i]);
      ChartSeries[1].Add(StrToFloat(Grid.Cells[3, i]), Grid.Cells[1,i]);
      if Grid.ColCount>4 then
        ChartSeries[2].Add(StrToFloat(Grid.Cells[4, i]), Grid.Cells[1,i]);
    end;
  end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnDmgWithTemper.InitFields;
begin
  F_Name:='Анализ повреждений за период с температурой';
  F_ReportFileName:='an_DmgWithTemper.frf';
end;

function TAnDmgWithTemper.LoadData: boolean;
var
  ComingSQL, ClosedSQL, TemperSQL: string;
  dt, dt1, dt2: TDate;
  i: integer;
  IsWithTemper: boolean;
begin
  Result:=false;

  with F_OptionForm as Tfrm_MiniUniversalSel do
  begin
    ComingSQL:= ' select count(*) ComingCount'+
                ' from orders o'+
                ResultCondition+
                ' and DateComing>''%s'' '+
                ' and DateComing<=''%s'' ';

    ClosedSQL:= 'select count(*) ClosedCount'+
                ' from orders o'+
                ResultCondition+
                ' and IsClosed=1'+
                ' and DateClosed>''%s'' '+
                ' and DateClosed<=''%s'' ';

    TemperSQL:= ' select temperature'+
                ' from temperatures'+
                ' where TempDate=''%s'' ';

    dt1:=dp_Date1.Date;
    dt2:=dp_Date2.Date;

    IsWithTemper:=chb_WithTemper.Checked;
  end;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    F_ProgressIndic.Max:=trunc(dt2-dt1);
    F_ProgressIndic.Position:=0;
    F_ProgressIndic.Show;

    dt:=dt1;

    while dt<=dt2 do
    begin
      Grid.Cells[0, Grid.RowCount-1]:=IntToStr(Grid.RowCount-1);

      Grid.Cells[1, Grid.RowCount-1]:=DateToStr(dt);

      MyOpenSQL(F_Dset[0], Format(ComingSQL, [DateToStr(dt), DateToStr(dt+1)]));
      Grid.Cells[2, Grid.RowCount-1]:=F_Dset[0].FieldByName('ComingCount').AsString;

      MyOpenSQL(F_Dset[0], Format(ClosedSQL, [DateToStr(dt), DateToStr(dt+1)]));
      Grid.Cells[3, Grid.RowCount-1]:=F_Dset[0].FieldByName('ClosedCount').AsString;

      if IsWithTemper then
      begin
        MyOpenSQL(F_Dset[0], Format(TemperSQL, [DateToStr(dt)]));
        if F_Dset[0].FieldByName('Temperature').IsNull then
          Grid.Cells[4, Grid.RowCount-1]:='0'
        else
          Grid.Cells[4, Grid.RowCount-1]:=F_Dset[0].FieldByName('Temperature').AsString;
      end;

      Grid.RowCount:=Grid.RowCount+1;
      dt:=dt+1;
      F_ProgressIndic.Position:=F_ProgressIndic.Position+1;
    end; //end while
    F_Dset[0].Close;
    Grid.RowCount:=Grid.RowCount-1;
    F_ProgressIndic.Hide;
  end; //end with

  Result:=true;
end;

procedure TAnDmgWithTemper.OnFirst(Sender: TObject);
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Date']:=Grid.Cells[1, F_NumRow];
    frVariables['Coming']:=Grid.Cells[2, F_NumRow];
    frVariables['Closed']:=Grid.Cells[3, F_NumRow];
    frVariables['Temper']:=Grid.Cells[4, F_NumRow];
  end;
end;

procedure TAnDmgWithTemper.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnDmgWithTemper.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
  end; //end with
end;

procedure TAnDmgWithTemper.PrepareResultFormGrid;
var
  i: integer;
begin
  with (F_OptionForm as Tfrm_MiniUniversalSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    if chb_WithTemper.Checked then
    begin
      Grid.ColCount:=5;
      Grid.Cells[4,0]:='Тем-ра';
    end else
      Grid.ColCount:=4;

    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.FixedCols:=0;

    Grid.Cells[0,0]:='№ п/п';
    Grid.Cells[1,0]:='Дата пост.';
    Grid.Cells[2,0]:='Кол-во пост.';
    Grid.Cells[3,0]:='Кол-во ликв.';

    for i:=0 to Grid.ColCount-1 do
      Grid.CellFont[i, 0].Style:=[fsBold];
  end; //end with
end;

procedure TAnDmgWithTemper.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_MiniUniversalSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:='Количество повреждений за период'+#13+
                      'c '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date);

    LeftLabel:='Район: '+strRegions+#13+
                    'Место повреждения: '+strDamagePlace+#13+
                    'Местность повреждения: '+strDamageLocality+#13+
                    'Вид повреждения: '+strDamageType+#13+
                    'Диаметер трубы: '+strTubeDiameter+#13+
                    'Материал трубы: '+strTubeMaterial;
  end; //end with
end;

procedure TAnDmgWithTemper.PrintClick(Sender: Tobject);
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;
    if Grid.ColCount<5 then   //если не отображается столбец с температурой
    begin
      F_Report.FindObject('mem_TemperTitle').Visible:=false;
      F_Report.FindObject('mem_Temper').Visible:=false;
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; //end with

  ShowReport;
end;

{ TAnLeakPeriod }

procedure TAnLeakPeriod.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakOptSel.Create(nil,'Утечка воды на водосетях', ptSmena);
end;

procedure TAnLeakPeriod.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnLeakPeriod.InitFields;
begin
  F_Name:='Анализ утечек за период №2';
  F_ReportFileName:='an_LeakPeriod.frf';
end;

function TAnLeakPeriod.LoadData: boolean;
var
  fOpt: Tfrm_AnLeakOptSel;
  strStartDate, strFinishedDate: string;
  RegionsID, DamagePlaceID: string;
  RegionsSQL, LeakSQL: string;
  id_reg, dmg_count, sum_dmg_count, i: integer;
  leak, sum_leak: double;
begin
  Result:=false;

  fOpt:=(F_OptionForm as Tfrm_AnLeakOptSel);
  strStartDate:=fOpt.strStartDate;
  strFinishedDate:=fOpt.strFinishedDate;

  RegionsID:=fOpt.Regions;
  DamagePlaceID:=fOpt.DamagePlace;

  RegionsSQL:='select id, name from s_regions where id>-1 and activity is null';
  if RegionsID<>'' then
    RegionsSQL:=RegionsSQL+' and id in'+RegionsID;
  RegionsSQL:=RegionsSQL+' order by name';

  if DamagePlaceID<>'' then
    DamagePlaceID:=' and fk_orders_damageplace in'+DamagePlaceID;

  LeakSQL:= ' select id,'+
            ' (select Leak from get_leak_for_period(o.id, '+QuotedStr(strStartDate)+', '+QuotedStr(strFinishedDate)+')) Leak'+
            ' from orders o'+
            ' where fk_orders_regions=%d'+
            DamagePlaceID+
            ' and (DateComing<'''+strFinishedDate+''')'+
            ' and (DateClosed>='''+strStartDate+''' or DateClosed is null)'+
            ' and (FlowSpeed>0)';

  /////////////////////////////////////////////////////////////////////////////

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=4;
    Grid.RowCount:=2;
    Grid.FixedCols:=0;
    Grid.FixedRows:=1;

    Grid.Cells[0, 0]:='Район';
    Grid.Cells[1, 0]:='Кол-во повреждений';
    Grid.Cells[2, 0]:='Утечка, м3';
    Grid.Cells[3, 0]:='% утечки';

    for i:=0 to 3 do
      Grid.CellFont[i, 0].Style:=[fsBold];

    sum_dmg_count:=0;
    sum_leak:=0;
    MyOpenSQL(F_Dset[0], RegionsSQL);
    while not F_Dset[0].Eof do
    begin
      leak:=0;
      dmg_count:=0;
      id_reg:=F_Dset[0].FieldByName('id').AsInteger;
      MyOpenSQL(F_Dset[1], Format(LeakSQL,[id_reg]));
      while not F_Dset[1].Eof do
      begin
        leak:=leak+F_Dset[1].FieldByName('leak').AsFloat;
        inc(dmg_count);
        F_Dset[1].Next;
      end; //end while not dset_tmp2.eof

      Grid.Cells[0, Grid.RowCount-1]:=F_Dset[0].FieldByName('name').AsString;
      Grid.Cells[1, Grid.RowCount-1]:=IntToStr(dmg_count);
      Grid.Cells[2, Grid.RowCount-1]:=FloatToStr(leak);

      Grid.RowCount:=Grid.RowCount+1;

      sum_dmg_count:=sum_dmg_count+dmg_count;
      sum_leak:=sum_leak+leak;
      F_Dset[0].Next;
    end; //end while not dset_tmp1.eof
    F_Dset[0].Close;
    F_Dset[1].Close;

    for i:=1 to Grid.RowCount-2 do
    begin
      leak:=StrToFloat(Grid.Cells[2, i]);
      Grid.Cells[3, i]:=FormatFloat('0.##', (leak/sum_leak)*100);
    end;

    Grid.RowCount:=Grid.RowCount+1;
    Grid.Cells[0, Grid.RowCount-1]:='Итого:';
    Grid.Cells[1, Grid.RowCount-1]:=IntToStr(sum_dmg_count);
    Grid.Cells[2, Grid.RowCount-1]:=FloatToStr(sum_leak);
    Grid.Cells[3, Grid.RowCount-1]:='100';

  end; // end with

  Result:=true;
end;

procedure TAnLeakPeriod.OnFirst(Sender: TObject);
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Regions']:=Grid.Cells[0, F_NumRow];
    frVariables['DamageCount']:=Grid.Cells[1, F_NumRow];
    frVariables['Leak']:=Grid.Cells[2, F_NumRow];
    frVariables['LeakPerc']:=Grid.Cells[3, F_NumRow];
  end;
end;

procedure TAnLeakPeriod.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnLeakPeriod.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
  end; //end with
end;

procedure TAnLeakPeriod.PrepareResultFormGrid;
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=4;
    Grid.RowCount:=2;
    Grid.FixedCols:=0;
    Grid.FixedRows:=1;

    Grid.Cells[0, 0]:='Район';
    Grid.Cells[1, 0]:='Кол-во повреждений';
    Grid.Cells[2, 0]:='Утечка, м3';
    Grid.Cells[3, 0]:='% утечки';

    for i:=0 to 3 do
      Grid.CellFont[i, 0].Style:=[fsBold];
  end; //end with
end;

procedure TAnLeakPeriod.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnLeakOptSel) do
  begin
    CenterLabel:='Утечка за период с '+strStartDate+' по '+strFinishedDate;
  end; //end with
end;

procedure TAnLeakPeriod.PrintClick(Sender: TObject);
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end;

  ShowReport;
end;

{ TAnLeakDmgPlace }

procedure TAnLeakDmgPlace.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakOptSel.Create(nil, 'Анализ ликв. течей по месту повреждения', ptSutki);
end;

procedure TAnLeakDmgPlace.ExcelClick(Sender: Tobject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnLeakDmgPlace.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  i, j: integer;
begin
  frm_Chart:=Tfrm_Chart.Create(nil, 'График рез. анализа ликв. течей по месту повреждения');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    Title.Text.Clear;
    Title.Text.Add('Анализ количества по видам повреждений по всем районам');
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    for i:=1 to Grid.ColCount-1 do
    begin
      AddChartSeries(stBar);
      ChartSeries[i-1].Title:=Grid.Cells[i,0];
      ChartSeries[i-1].Marks.Style:=smsValue;
      ChartSeries[i-1].Marks.Transparent:=true;
      ChartSeries[i-1].Marks.Frame.Visible:=false;
    end;
    {/Добавляем серии}

    for i:=1 to Grid.ColCount-1 do
    begin
      for j:=1 to Grid.RowCount-2 do
      begin
        ChartSeries[i-1].Add(StrToFloat(Grid.Cells[i,j]), copy(Grid.Cells[0, j],1,4));
      end; //end for j
    end; //end for i

  end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnLeakDmgPlace.InitFields;
begin
  F_Name:='Анализ ликв. течей по месту повреждения';
  F_ReportFileName:='an_LeakDmgPlace.frf';
end;

function TAnLeakDmgPlace.LoadData: boolean;
var
  fOp: Tfrm_AnLeakOptSel;
  RegionsID, DamagePlaceID: string;
  RegionsSQL, DamagePlaceSQL, DmgCountSQL: string;
  id_reg, id_dmg, col, i, j, itogo: integer;
  IsFirstRec: boolean;
begin
  Result:=false;

  fOp:=(F_OptionForm as Tfrm_AnLeakOptSel);

  RegionsID:=fOp.Regions;
  DamagePlaceID:=fOp.DamagePlace;

  RegionsSQL:='select id, name from s_regions where id>-1 and activity is null';
  if RegionsID<>'' then
    RegionsSQL:=RegionsSQL+' and id in'+RegionsID;
  RegionsSQL:=RegionsSQL+' order by name';

  DamagePlaceSQL:='select id, name from s_DamagePlace where id>-1 and activity is null';
  if DamagePlaceID<>'' then
    DamagePlaceSQL:=DamagePlaceSQL+' and id in'+DamagePlaceID;
  DamagePlaceSQL:=DamagePlaceSQL+' order by name';

  DmgCountSQL:= ' select count(*) DmgCount'+
                ' from orders o '+
                ' where IsClosed=1'+
                ' and fk_orders_regions=%d'+
                ' and fk_orders_damageplace=%d'+
                ' and DateClosed>='''+DateToStr(fOp.dp_Date1.Date)+''''+
                ' and DateClosed<'''+DateToStr(fOp.dp_Date2.Date+1)+'''';

  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    Grid.ColCount:=1;;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.FixedCols:=0;

    Grid.Cells[0,0]:='РАЙОН';

    {Заполнение основных данных по районам}
    IsFirstRec:=true;
    MyOpenSQL(F_Dset[0], RegionsSQL);
    MyOpenSQL(F_Dset[1], DamagePlaceSQL);
    F_Dset[0].First;
    while not F_Dset[0].Eof do //Regions
    begin
      Grid.Cells[0, Grid.RowCount-1]:=trim(F_Dset[0].FieldByName('name').AsString);
      id_reg:=F_Dset[0].FieldByName('id').AsInteger;
      col:=1;
      F_Dset[1].First;
      while not F_Dset[1].Eof do //DamagePlace
      begin
        if IsFirstRec then
        begin
          Grid.ColCount:=Grid.ColCount+1;
          Grid.Cells[col, 0]:=F_Dset[1].FieldByName('name').AsString;
        end;

        id_dmg:=F_Dset[1].FieldByName('id').AsInteger;
        MyOpenSQL(F_Dset[2], Format(DmgCountSQL,[id_reg, id_dmg]));
        Grid.Cells[col, Grid.RowCount-1]:=F_Dset[2].FieldByName('DmgCount').AsString;
        inc(col);
        F_Dset[1].Next;
      end;

      IsFirstRec:=false;
      Grid.RowCount:=Grid.RowCount+1;
      F_Dset[0].Next;
    end;
    F_Dset[0].Close;
    F_Dset[1].Close;
    F_Dset[2].Close;
    {/Заполнение основных данных по районам}

    {Формированеие итого}
    Grid.Cells[0, Grid.RowCount-1]:='ВСЕГО';
    for i:=1 to Grid.ColCount-1 do
    begin
      itogo:=0;
      for j:=1 to Grid.RowCount-2 do
        itogo:=itogo+StrToInt(Grid.Cells[i,j]);
      Grid.Cells[i, Grid.RowCount-1]:=IntToStr(itogo);
    end;
    {/Формированеие итого}

    {Окраска таблицы}
    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.ColorCol[0]:=clAqua;
    {/Окраска таблицы}

    {Выравнивние таблицы}
    for i:=1 to Grid.ColCount-1 do
      for j:=0 to Grid.RowCount-1 do
        Grid.AlignCell[i,j]:=alCenter;
    {Выравнивние таблицы}

  end; // end with

  Result:=true;
end;

procedure TAnLeakDmgPlace.OnFirst(Sender: TObject);
var
  i:integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    for i:=0 to Grid.ColCount-1 do
      frVariables['ColVal'+IntToStr(i)]:=Grid.Cells[i, F_NumRow];
  end;
end;

procedure TAnLeakDmgPlace.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnLeakDmgPlace.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
  end;  //end with
end;

procedure TAnLeakDmgPlace.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnLeakOptSel) do
  begin
    CenterLabel:=Format('Анализ количества повреждений'+#13+'по месту повреждения'+#13+
                        'с %s по %s',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
    LeftLabel:= 'Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end;  //end with
end;

procedure TAnLeakDmgPlace.PrintClick(Sender: TObject);
var
  i: integer;
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;
    for i:=0 to Grid.ColCount-1 do
    begin
      F_Report.FindObject('mem_ColName'+IntToStr(i)).Visible:=true;
      F_Report.FindObject('mem_ColVal'+IntToStr(i)).Visible:=true;

      frVariables['ColName'+IntToStr(i)]:=trim(Grid.Cells[i, 0]);
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnLeakDmgLoc }

procedure TAnLeakDmgLoc.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakLocSel.Create(nil, 'Анализ кол-ва ликв. повреждений');
end;

procedure TAnLeakDmgLoc.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnLeakDmgLoc.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  i, j: integer;
begin
  frm_Chart:=Tfrm_Chart.Create(nil, 'График рез. анализа ликв. течей по местности повреждения');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    Title.Text.Clear;
    Title.Text.Add('Анализ кол-ва ликв. поврежедний по местности повреждения');
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    for i:=1 to Grid.ColCount-1 do
    begin
      AddChartSeries(stBar);
      ChartSeries[i-1].Title:=Grid.Cells[i,0];
      ChartSeries[i-1].Marks.Style:=smsValue;
      ChartSeries[i-1].Marks.Transparent:=true;
      ChartSeries[i-1].Marks.Frame.Visible:=false;
    end;
    {/Добавляем серии}

    for i:=1 to Grid.ColCount-1 do
    begin
      for j:=1 to Grid.RowCount-2 do
      begin
        ChartSeries[i-1].Add(StrToFloat(Grid.Cells[i,j]), copy(Grid.Cells[0, j],1,4));
      end; //end for j
    end; //end for i

  end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnLeakDmgLoc.InitFields;
begin
  F_Name:='Анализ кол-ва ликв. поврежедений по местности поврежедения';
  F_ReportFileName:='an_LeakDmgLoc.frf';
end;

function TAnLeakDmgLoc.LoadData: boolean;
var
  fOp: Tfrm_AnLeakLocSel;
  StartDate, FinishedDate: TDate;
  strRegions, strDamagePlace: string;
  RegionsID, DamagePlaceID, DamageLocalityID: string;
  RegionsSQL, DamagePlaceSQL, DamageLocalitySQL, DmgCountSQL: string;
  IsFirstRec: boolean;
  id_reg, id_dmg, col, i, j, itogo: integer;
begin
  Result:=false;

  fOp:=(F_OptionForm as Tfrm_AnLeakLocSel);

  RegionsID:=fOp.Regions;
  DamagePlaceID:=fOp.DamagePlace;
  DamageLocalityID:=fOp.DamageLocality;


  RegionsSQL:='select id, name from s_regions where id>-1 and activity is null';
  if RegionsID<>'' then
    RegionsSQL:=RegionsSQL+' and id in'+RegionsID;
  RegionsSQL:=RegionsSQL+' order by name';

  DamageLocalitySQL:='select id, name from s_DamageLocality where id>-1 and activity is null';
  if DamageLocalityID<>'' then
    DamageLocalitySQL:=DamageLocalitySQL+' and id in'+DamageLocalityID;
  DamageLocalitySQL:=DamageLocalitySQL+' order by name';

  if DamagePlaceID<>'' then
    DamagePlaceSQL:=' and fk_orders_damageplace in'+DamagePlaceID
  else
    DamagePlaceSQL:='';

  DmgCountSQL:= ' select count(*) DmgCount'+
                ' from orders o '+
                ' where IsClosed=1'+
                ' and fk_orders_regions=%d'+
                ' and fk_orders_damagelocality=%d'+
                ' and DateClosed>='''+DateToStr(fOp.dp_Date1.Date)+''''+
                ' and DateClosed<'''+DateToStr(fOp.dp_Date2.Date+1)+''''+
                DamagePlaceSQL;

///////////////////////////////////
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=1;;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.FixedCols:=0;

    Grid.Cells[0,0]:='Район';

    {Заполнение основных данных по районам}
    IsFirstRec:=true;
    MyOpenSQL(F_Dset[0], RegionsSQL);
    MyOpenSQL(F_Dset[1], DamageLocalitySQL);
    F_Dset[0].First;
    while not F_Dset[0].Eof do //Regions
    begin
      Grid.Cells[0, Grid.RowCount-1]:=trim(F_Dset[0].FieldByName('name').AsString);
      id_reg:=F_Dset[0].FieldByName('id').AsInteger;
      col:=1;
      F_Dset[1].First;
      while not F_Dset[1].Eof do //DamageLocality
      begin
        if IsFirstRec then
        begin
          Grid.ColCount:=Grid.ColCount+1;
          Grid.Cells[col, 0]:=trim(F_Dset[1].FieldByName('name').AsString);
        end;

        id_dmg:=F_Dset[1].FieldByName('id').AsInteger;
        MyOpenSQL(F_Dset[2], Format(DmgCountSQL,[id_reg, id_dmg]));
        Grid.Cells[col, Grid.RowCount-1]:=F_Dset[2].FieldByName('DmgCount').AsString;
        inc(col);
        F_Dset[1].Next;
      end;

      IsFirstRec:=false;
      Grid.RowCount:=Grid.RowCount+1;
      F_Dset[0].Next;
    end;
    F_Dset[0].Close;
    F_Dset[1].Close;
    F_Dset[2].Close;
    {/Заполнение основных данных по районам}

    {Формированеие итого}
    Grid.Cells[0, Grid.RowCount-1]:='ВСЕГО';
    for i:=1 to Grid.ColCount-1 do
    begin
      itogo:=0;
      for j:=1 to Grid.RowCount-2 do
        itogo:=itogo+StrToInt(Grid.Cells[i,j]);
      Grid.Cells[i, Grid.RowCount-1]:=IntToStr(itogo);
    end;
    {/Формированеие итого}

    {Окраска таблицы}
    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.ColorCol[0]:=clAqua;
    {/Окраска таблицы}

    {Выравнивние таблицы}
    for i:=1 to Grid.ColCount-1 do
      for j:=0 to Grid.RowCount-1 do
        Grid.AlignCell[i,j]:=alCenter;
    {/Выравнивние таблицы}
  end; // end with

  Result:=true;
end;

procedure TAnLeakDmgLoc.OnFirst(Sender: TObject);
var
  i:integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    for i:=0 to Grid.ColCount-1 do
      frVariables['ColVal'+IntToStr(i)]:=Grid.Cells[i, F_NumRow];
  end;
end;

procedure TAnLeakDmgLoc.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnLeakDmgLoc.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
  end;
end;


procedure TAnLeakDmgLoc.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnLeakLocSel) do
  begin
    CenterLabel:=Format('Анализ количества повреждений'+#13+'по местности повреждения'+#13+
                        'с %s по %s',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
    LeftLabel:= 'Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end;
end;

procedure TAnLeakDmgLoc.PrintClick(Sender: TObject);
var
  i: integer;
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;
    for i:=0 to Grid.ColCount-1 do
    begin
      F_Report.FindObject('mem_ColName'+IntToStr(i)).Visible:=true;
      F_Report.FindObject('mem_ColVal'+IntToStr(i)).Visible:=true;

      frVariables['ColName'+IntToStr(i)]:=trim(Grid.Cells[i, 0]);
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnLeakDiam }

procedure TAnLeakDiam.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakDiamSel.Create(nil, F_Name);
end;

procedure TAnLeakDiam.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnLeakDiam.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_LeakDiamChart;
  i,j, SerCount: integer;
begin
  frm_Chart:=Tfrm_LeakDiamChart.Create(nil, 'Графики рез. анализа кол-ва ликв. течей по диаметрам');


  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    Title.Text.Clear;
    Title.Text.Add(ReplaceChar(CenterLabel, #13, ' '));
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    for i:=1 to Grid.ColCount-3 do
    begin
      AddChartSeries(stBar);
      ChartSeries[i-1].Title:=Grid.Cells[i,0];
      ChartSeries[i-1].Marks.Style:=smsValue;
      ChartSeries[i-1].Marks.Transparent:=true;
      ChartSeries[i-1].Marks.Frame.Visible:=false;
    end;

    AddChartSeries(stBar);
    SerCount:=ChartSeriesCount;
    ChartSeries[SerCount-1].Title:='';
    ChartSeries[SerCount-1].Marks.Style:=smsValue;
    ChartSeries[SerCount-1].Marks.Transparent:=true;
    ChartSeries[SerCount-1].Marks.Frame.Visible:=false;
    {/Добавляем серии}

    {Загрузка данных}
    for i:=1 to Grid.ColCount-3 do
    begin
      for j:=1 to Grid.RowCount-3 do
      begin
        ChartSeries[i-1].Add(StrToFloat(Grid.Cells[i,j]), Grid.Cells[0, j]);
      end; //end for j
    end; //end for i

    for j:=1 to Grid.RowCount-3 do
      ChartSeries[SerCount-1].Add(StrToFloat(Grid.Cells[Grid.ColCount-1, j]), Grid.Cells[0,j]);
    {/Загрузка данных}

    btn_countClick(nil);
  end; // end with

  frm_Chart.ShowModal;
end;

procedure TAnLeakDiam.InitFields;
begin
  F_Name:='Анализ кол-ва ликв. повреждений по диаметрам';
  F_ReportFileName:='an_LeakDiam.frf';
end;

function TAnLeakDiam.LoadData: boolean;
var
  fOp: Tfrm_AnLeakDiamSel;
  RegionsID, DamagePlaceID, TubeDiameterID, DamageTypeID: string;
  RegionsSQL, TubeDiameterSQL: string;
  DamagePlaceSQL, DamageTypeSQL, DmgCountSQL: string;
  IsFirstRec: boolean;
  id_diam, id_dmg, col, i, j, itogo, sum_itogo: integer;
begin
  Result:=false;

  fOp:=(F_OptionForm as Tfrm_AnLeakDiamSel);

  RegionsID:=fOp.Regions;
  DamagePlaceID:=fOp.DamagePlace;
  TubeDiameterID:=fOp.TubeDiameter;
  DamageTypeID:=fOp.DamageType;

  TubeDiameterSQL:='select id, Diameter name from s_tubediameter where id>-1 and activity is null';
  if TubeDiameterID<>'' then
    TubeDiameterSQL:=TubeDiameterSQL+' and id in'+TubeDiameterID;
  TubeDiameterSQL:=TubeDiameterSQL+' order by diameter';

  DamageTypeSQL:='select id, Name from s_DamageType where id>-1 and activity is null';
  if DamageTypeID<>'' then
    DamageTypeSQL:=DamageTypeSQL+' and id in'+DamageTypeID;
  DamageTypeSQL:=DamageTypeSQL+' order by name';

  if RegionsID<>'' then
    RegionsSQL:=' and fk_orders_regions in'+RegionsID
  else
    RegionsSQL:='';

  if DamagePlaceID<>'' then
    DamagePlaceSQL:=' and fk_orders_damageplace in'+DamagePlaceID
  else
    DamagePlaceSQL:='';

  DmgCountSQL:= ' select count(*) DmgCount'+
                ' from orders o '+
                ' where IsClosed=1'+
                ' and fk_orders_diameters=%d'+
                ' and fk_orders_damagetype=%d'+
                ' and DateClosed>='''+DateToStr(fOp.dp_Date1.Date)+''''+
                ' and DateClosed<'''+DateToStr(fOp.dp_Date2.Date+1)+''''+
                RegionsSQL+
                DamagePlaceSQL;

///////////////////////////////////
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    Grid.ColCount:=1;;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.FixedCols:=0;

    Grid.Cells[0,0]:='Диаметер';

    {Заполнение основных данных по районам}
    IsFirstRec:=true;
    MyOpenSQL(F_Dset[0], TubeDiameterSQL);
    MyOpenSQL(F_Dset[1], DamageTypeSQL);
    F_Dset[0].First;
    while not F_Dset[0].Eof do //TubeDiameter
    begin
      Grid.Cells[0, Grid.RowCount-1]:=trim(F_Dset[0].FieldByName('name').AsString);
      id_diam:=F_Dset[0].FieldByName('id').AsInteger;
      col:=1;
      F_Dset[1].First;
      while not F_Dset[1].Eof do //DamageType
      begin
        if IsFirstRec then
        begin
          Grid.ColCount:=Grid.ColCount+1;
          Grid.Cells[col, 0]:=F_Dset[1].FieldByName('name').AsString;
        end;

        id_dmg:=F_Dset[1].FieldByName('id').AsInteger;
        MyOpenSQL(F_Dset[2], Format(DmgCountSQL,[id_diam, id_dmg]));
        Grid.Cells[col, Grid.RowCount-1]:=F_Dset[2].FieldByName('DmgCount').AsString;
        inc(col);
        F_Dset[1].Next;
      end;

      IsFirstRec:=false;
      Grid.RowCount:=Grid.RowCount+1;
      F_Dset[0].Next;
    end;
    F_Dset[0].Close;
    F_Dset[1].Close;
    F_Dset[2].Close;
    {/Заполнение основных данных по районам}

    {Формированеие итого по столбцам}
    Grid.Cells[0, Grid.RowCount-1]:='ВСЕГО';
    for i:=1 to Grid.ColCount-1 do
    begin
      itogo:=0;
      for j:=1 to Grid.RowCount-2 do
        itogo:=itogo+StrToInt(Grid.Cells[i,j]);
      Grid.Cells[i, Grid.RowCount-1]:=IntToStr(itogo);
    end;
    {/Формированеие итого по столбцам}

    {Формирования итого по строкам}
    Grid.ColCount:=Grid.ColCount+1;
    Grid.Cells[Grid.ColCount-1, 0]:='ВСЕГО';
    for j:=1 to Grid.RowCount-1 do
    begin
      itogo:=0;
      for i:=1 to Grid.ColCount-2 do
        itogo:=itogo+StrToInt(Grid.Cells[i,j]);
      Grid.Cells[Grid.ColCount-1, j]:=IntToStr(itogo);
    end;
    {/Формирования итого по строкам}

    sum_itogo:=StrToInt(Grid.Cells[Grid.ColCount-1, Grid.RowCount-1]);

    {Формирование итого по столбцам в процентах}
     Grid.RowCount:=Grid.RowCount+1;
     Grid.Cells[0, Grid.RowCount-1]:='В проц.';
     for i:=1 to Grid.ColCount-2 do
     begin
        itogo:=StrToInt(Grid.Cells[i, Grid.RowCount-2]);
        if sum_itogo<>0 then
          Grid.Cells[i, Grid.RowCount-1]:=FormatFloat('0.##', (itogo/sum_itogo)*100)
        else
          Grid.Cells[i, Grid.RowCount-1]:='0';
     end;
    {/Формирование итого по столбцам в процентах}

    
    {Формированеие итого по строкам в процентах}
    Grid.ColCount:=Grid.ColCount+1;
    Grid.Cells[Grid.ColCount-1, 0]:='В проц.';
    for i:=1 to Grid.RowCount-3 do
    begin
      itogo:=StrToInt(Grid.Cells[Grid.ColCount-2, i]);
      if sum_itogo<>0 then
        Grid.Cells[Grid.ColCount-1, i]:=FormatFloat('0.##', (itogo/sum_itogo)*100)
      else
        Grid.Cells[Grid.ColCount-1, i]:='0';
    end;
    {/Формированеие итого по строкам в процентах}


    {Окраска таблицы}
    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.ColorRow[Grid.RowCount-2]:=clYellow;
    Grid.ColorCol[Grid.ColCount-1]:=clYellow;
    Grid.ColorCol[Grid.ColCount-2]:=clYellow;

    Grid.ColorCol[0]:=clAqua;
    {/Окраска таблицы}

    {Выравнивние таблицы}
    for i:=1 to Grid.ColCount-1 do
      for j:=0 to Grid.RowCount-1 do
        Grid.AlignCell[i,j]:=alCenter;
    {Выравнивние таблицы}
  end; // end with

  Result:=true;
end;

procedure TAnLeakDiam.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
    //btn_Print.OnClick:=_LeakDiam_PrintClick;
  end;
end;


procedure TAnLeakDiam.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnLeakDiamSel) do
  begin
    CenterLabel:=Format('Анализ количества повреждений'+#13+'по диаметру'+#13+
                        'с %s по %s',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
    LeftLabel:= 'Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end;
end;

procedure TAnLeakDiam.PrintClick(Sender: TObject);
var
  i: integer;
begin
{
  if not LoadReport('an_LeakDiam.frf') then exit;

  with F_ResultForm as frm_AnalysisView do
  begin
    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;
    for i:=0 to Grid.ColCount-1 do
    begin
      F_Report.FindObject('mem_ColName'+IntToStr(i)).Visible:=true;
      F_Report.FindObject('mem_ColVal'+IntToStr(i)).Visible:=true;

      frVariables['ColName'+IntToStr(i)]:=trim(Grid.Cells[i, 0]);
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
  //  F_frUDS.OnFirst:=OnFirst;
  //  F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  F_Report.PrepareReport;
  F_Report.ShowPreparedReport;
}
end;

{ TAnLeakDays }

procedure TAnLeakDays.CleareRegionList;
var
  i: integer;
begin
  for i:=0 to F_RegionList.Count-1 do
    dispose(F_RegionList.Items[i]);
  F_RegionList.Clear;
end;

constructor TAnLeakDays.Create;
begin
  inherited Create;
  F_RegionList:=TList.Create;
end;

procedure TAnLeakDays.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakDaysSel.Create(nil);
end;

destructor TAnLeakDays.Destroy;
begin
  CleareRegionList;
  inherited Destroy;
end;

procedure TAnLeakDays.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  Title:=ReplaceChar(ReplaceChar(Title, #13, ' '),#10,' ');
  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;


procedure TAnLeakDays.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  i, j: integer;
  dt1, dt2: string;
begin
  dt1:=DateToStr((F_OptionForm as Tfrm_AnLeakDaysSel).dp_Date1.Date);
  dt2:=DateToStr((F_OptionForm as Tfrm_AnLeakDaysSel).dp_Date2.Date+1);

  frm_Chart:=Tfrm_Chart.Create(nil, 'Графики рез. анализа сроков ликвидации повреждений');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    Title.Text.Clear;
    Title.Text.Add('Диаграмма сроков ликвидации повреждений за период с '+dt1+' по '+dt2);
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    for i:=1 to Grid.ColCount-1 do
    begin
      AddChartSeries(stBar);
      ChartSeries[i-1].Title:=copy(trim(Grid.Cells[i,0]),1,4);
      ChartSeries[i-1].Marks.Style:=smsValue;
      ChartSeries[i-1].Marks.Transparent:=true;
      ChartSeries[i-1].Marks.Frame.Visible:=false;
    end;
    {/Добавляем серии}

    for i:=1 to Grid.ColCount-1 do
    begin
      for j:=1 to Grid.RowCount-4 do
      begin
        ChartSeries[i-1].Add(StrToFloat(Grid.Cells[i,j]), copy(Grid.Cells[0, j],1,4));
      end; //end for j
    end; //end for i

  end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnLeakDays.InitFields;
begin
  F_Name:='Анализ сроков ликвидации повреждений';
  F_ReportFileName:='an_LeakDays.frf';
end;

function TAnLeakDays.LoadData: boolean;
var
  DmgCountSQL: string;
  RegionsSQL, DamagePlaceSQL: string;
  i, j: integer;
  beg_kol, end_kol, kol, id_reg, col, itogo: integer;
  dmg_count, tot_dmg_count: integer;

  pReg: TPLeakDays_Reg;
begin
  Result:=false;

  with F_OptionForm as Tfrm_AnLeakDaysSel do
  begin
    RegionsSQL:='select id, name from s_Regions where id>-1 and activity is null';
    if Regions<>'' then
      RegionsSQL:=RegionsSQL+' and id in'+Regions;
    RegionsSQL:=RegionsSQL+' order by name';

    if DamagePlace<>'' then
      DamagePlaceSQL:=' and fk_orders_damageplace in'+DamagePlace
    else
      DamagePlaceSQL:='';

    DmgCountSQL:= ' select count(*) DmgCount'+
                  ' from orders o '+
                  ' where IsClosed=1'+
                  ' and cast(cast(DateClosed as Date)-cast(DateComing as Date) as integer)=%d'+
                  ' and fk_orders_regions=%d'+
                  ' and DateClosed>='''+DateToStr(dp_Date1.Date)+''''+
                  ' and DateClosed<'''+DateToStr(dp_Date2.Date+1)+''''+
                  DamagePlaceSQL;

    beg_kol:=trunc(sp_begin.Value);
    end_kol:=trunc(sp_end.Value);
  end; //end with F_OptionForm

  {Загрузка основных данных}
  kol:=end_kol-beg_kol+1;
  CleareRegionList;
  MyOpenSQL(F_Dset[0], RegionsSQL);
  while not F_Dset[0].Eof do
  begin
    New(pReg);
    SetLength(pReg.DmgCount, kol);
    pReg.TotalDmgCount:=0;
    pReg.RegName:=F_Dset[0].FieldByName('name').AsString;
    id_reg:=F_Dset[0].FieldByName('ID').AsInteger;
    for i:=beg_kol to end_kol do
    begin
      MyOpenSQL(F_Dset[1], Format(DmgCountSQL, [i, id_reg]));
      dmg_count:=F_Dset[1].FieldByName('DmgCount').AsInteger;
      pReg.DmgCount[i-beg_kol]:=dmg_count;
      pReg.TotalDmgCount:=pReg.TotalDmgCount+dmg_count;
    end;
    F_RegionList.Add(pReg);
    F_Dset[0].Next;
  end;

  tot_dmg_count:=0;
  for i:=0 to F_RegionList.Count-1 do
  begin
    pReg:=TPLeakDays_Reg(F_RegionList.Items[i]);
    tot_dmg_count:=tot_dmg_count+pReg.TotalDmgCount;
  end;
  {/Загрузка основных данных}

  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.RowCount:=kol+4;
    Grid.ColCount:=2*F_RegionList.Count+3;
    Grid.FixedRows:=1;
    Grid.FixedCols:=0;

    {Шапка и боковуха таблицы}
    Grid.Cells[0,0]:='Кол-во дней';
    Grid.Cells[Grid.ColCount-2, 0]:='ВСЕГО';
    Grid.Cells[Grid.ColCount-1, 0]:='По городу';
    Grid.Cells[0, Grid.RowCount-2]:='ВСЕГО';
    Grid.Cells[0, Grid.RowCount-1]:='ВСЕГО,%';

    for i:=0 to F_RegionList.Count-1 do
    begin
      pReg:=TPLeakDays_Reg(F_RegionList.Items[i]);
      Grid.Cells[2*i+1, 0]:=pReg.RegName;
      Grid.Cells[2*i+2, 0]:='  %  ';
    end;

    for i:=beg_kol to end_kol do
      Grid.Cells[0, i-beg_kol+1]:=IntToStr(i);

    Grid.ColorRow[Grid.RowCount-2]:=clYellow;
    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.ColorCol[0]:=clAqua;
    {/Шапка и боковуха таблицы}


    {Основные данные}
    for i:=0 to F_RegionList.Count-1 do
    begin
      pReg:=TPLeakDays_Reg(F_RegionList.Items[i]);
      for j:=0 to kol-1 do
      begin
        Grid.Cells[2*i+1, j+1]:=IntToStr(pReg.DmgCount[j]);
        if pReg.TotalDmgCount<>0 then
          Grid.Cells[2*i+2, j+1]:=FormatFloat('0.#',(pReg.DmgCount[j]/pReg.TotalDmgCount)*100)
        else
          Grid.Cells[2*i+2, j+1]:='0';
      end;  // end for j
    end; // end for i
    {/Основные данные}

    {Всего по районам (столбцам)}
    for i:=0 to F_RegionList.Count-1 do
    begin
      pReg:=TPLeakDays_Reg(F_RegionList.Items[i]);
      Grid.Cells[2*i+1, Grid.RowCount-2]:=IntToStr(pReg.TotalDmgCount);
      if tot_dmg_count<>0 then
        Grid.Cells[2*i+1, Grid.RowCount-1]:=FormatFloat('0.#', (pReg.TotalDmgCount/tot_dmg_count)*100)
      else
        Grid.Cells[2*i+1, Grid.RowCount-1]:='0';
    end;
    {/Всего по районам (столбцам)}

    {Всего по строкам}
    for i:=0 to kol-1 do
    begin
      dmg_count:=0;
      for j:=0 to F_RegionList.Count-1 do
      begin
        pReg:=TPLeakDays_Reg(F_RegionList.Items[j]);
        dmg_count:=dmg_count+pReg.DmgCount[i];
      end;
      Grid.Cells[Grid.ColCount-2, i+1]:=IntToStr(dmg_count);
      if tot_dmg_count<>0 then
        Grid.Cells[Grid.ColCount-1, i+1]:=FormatFloat('0.#', (dmg_count/tot_dmg_count)*100)
      else
        Grid.Cells[Grid.ColCount-1, i+1]:='0';
    end;
    {/Всего по строкам}

    Grid.Cells[Grid.ColCount-2, Grid.RowCount-2]:=IntToStr(tot_dmg_count);
  end; //end with F_ResultForm

  Result:=true;
end;

procedure TAnLeakDays.OnFirst(Sender: TObject);
var
  i, row: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    row:=0;
    for i:=0 to Grid.RowCount-1 do
      if i<>Grid.RowCount-3 then
      begin
        frVariables['ColVal'+IntToStr(row)]:=Grid.Cells[F_NumRow,i];
        inc(row);
      end;
  end;
end;

procedure TAnLeakDays.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnLeakDays.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
  end; //end with
end;

procedure TAnLeakDays.PrepareResultFormGrid;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.Alignment:=alCenter;
  end; //end with
end;

procedure TAnLeakDays.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_AnLeakDaysSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=Format('Повреждения на в/сетях города'+#13+
                        'с %s по %s',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
    LeftLabel:= 'Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end; //end with
end;

procedure TAnLeakDays.PrintClick(Sender: TObject);
var
  i, row: integer;
begin
  if not LoadReportFile then exit;

  with (F_ResultForm as Tfrm_AnalysisView),
      (F_OptionForm as Tfrm_AnLeakDaysSel) do
  begin
    if Grid.RowCount>14 then exit;

    frVariables['Caption']:=Format('Анализ сроков ликвидации повреждений по дням'+#13+
                            'с %s по %s',[DateToStr(dp_Date1.Date), DateToStr(dp_Date2.Date)]);
    frVariables['AddCaption']:=LeftLabel;

    row:=0;
    for i:=0 to Grid.RowCount-1 do
    begin
      if i<>Grid.RowCount-3 then
      begin
        F_Report.FindObject('mem_ColName'+IntToStr(row)).Visible:=true;
        F_Report.FindObject('mem_ColVal'+IntToStr(row)).Visible:=true;

        frVariables['ColName'+IntToStr(row)]:=trim(Grid.Cells[0, i]);
        inc(row);
      end;
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.ColCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnLeakTime }

constructor TAnLeakTime.Create;
begin
  inherited Create;
  F_Dates:=TStringList.Create;
end;

procedure TAnLeakTime.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
  F_OptionForm:=Tfrm_AnLeakTimeSel.Create(nil, F_Name);
end;

destructor TAnLeakTime.Destroy;
begin
  F_Dates.Free;
  inherited Destroy;
end;

procedure TAnLeakTime.ExcelClick(Sender: TObject);
begin
  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(F_Name);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnLeakTime.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_LeakDiamChart;
  i,j, SerCount: integer;
  dt1, dt2: string;
begin
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
end;

procedure TAnLeakTime.InitFields;
begin
  F_Name:='Анализ кол-ва повреждений по времени поступления';
  F_ReportFileName:='an_LeakTime.frf';
end;

function TAnLeakTime.LoadData: boolean;
  function MyStrToInt(str: string): integer;
  begin
    if trim(str)='' then Result:=0
    else Result:=StrToInt(str);
  end;

  function MyInc(str: string): string;
  var
    i: integer;
  begin
    i:=MyStrToInt(str);
    inc(i);
    Result:=IntToStr(i);
  end;

  function EqualInt(val: integer): string;
  var
    space:string;
  begin
    if val<10 then space:='  '
    else           space:='   ';
    Result:='  '+IntToStr(val)+space;
  end;

var
  ResultSQL: string;
  i,j: integer;
  dt: TDate;
  hour, min, sec, msec: word;
  dmg_count, tot_dmg_count: integer;
begin
  Result:=false;

  with F_OptionForm as Tfrm_AnLeakTimeSel do
  begin
    ResultSQL:= ' select DateComing from orders o'+
                ' where IsClosed=1'+
                ' and DateComing>=''%s'''+
                ' and DateComing<''%s''';

    if Regions<>'' then ResultSQL:=ResultSQL+' and fk_orders_regions in'+Regions;
    if DamagePlace<>'' then ResultSQL:=ResultSQL+' and fk_orders_damageplace in'+DamagePlace;

    F_Dates.Clear;
    for i:=0 to chl_Dates.Count-1 do
      if chl_Dates.Checked[i] then
        F_Dates.Add(chl_Dates.Items[i]);

  end; //end F_OptionForm


  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=27;
    Grid.FixedCols:=0;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;

    {Шапка таблицы}
    Grid.Cells[0,0]:='Дата\часы';
    Grid.Cells[Grid.ColCount-2, 0]:='ВСЕГО';
    Grid.Cells[Grid.ColCount-1, 0]:='В проц.';
    for i:=0 to 23 do
      Grid.Cells[i+1,0]:=EqualInt(i);
    {/Шапка таблицы}

    {Заполнение основных данных}
    tot_dmg_count:=0;
    for i:=0 to F_Dates.Count-1 do
    begin
      Grid.Cells[0, Grid.RowCount-1]:=F_Dates.Strings[i];
      dt:=StrToDate(F_Dates.Strings[i]);
      MyOpenSQL(F_Dset[0], Format(ResultSQL,[DateToStr(dt), DateToStr(dt+1)]));
      while not F_Dset[0].Eof do
      begin
        DecodeTime(F_Dset[0].FieldByName('DateComing').AsDateTime, hour, min, sec, msec);
        Grid.Cells[hour+1, Grid.RowCount-1]:=MyInc(Grid.Cells[hour+1, Grid.RowCount-1]);
        inc(tot_dmg_count);
        F_Dset[0].Next;
      end; //end while
      F_Dset[0].Close;
      Grid.RowCount:=Grid.RowCount+1;
    end; // end for i
    Grid.RowCount:=Grid.RowCount+1;
    {/Заполнение основных данных}

    Grid.Cells[Grid.ColCount-2, Grid.RowCount-2]:=IntToStr(tot_dmg_count);

    {Формирование ВСЕГО по столбцам}
    Grid.Cells[0, Grid.RowCount-2]:='ВСЕГО';
    Grid.Cells[0, Grid.RowCount-1]:='В проц.';
    for i:=1 to Grid.ColCount-3 do
    begin
      dmg_count:=0;
      for j:=1 to Grid.RowCount-3 do
        dmg_count:=dmg_count+MyStrToInt(Grid.Cells[i,j]);
      Grid.Cells[i, Grid.RowCount-2]:=IntToStr(dmg_count);
      if tot_dmg_count<>0 then
        Grid.Cells[i, Grid.RowCount-1]:=FormatFloat('0.#',(dmg_count/tot_dmg_count)*100)
      else
        Grid.Cells[i, Grid.RowCount-1]:='0';
    end; //end for i
    {/Формирование ВСЕГО по столбцам}

    {Формирование ВСЕГО по строкам}
    for i:=1 to Grid.RowCount-3 do
    begin
      dmg_count:=0;
      for j:=1 to Grid.ColCount-3 do
        dmg_count:=dmg_count+MyStrToInt(Grid.Cells[j,i]);
      Grid.Cells[Grid.ColCount-2, i]:=IntToStr(dmg_count);
      if tot_dmg_count<>0 then
        Grid.Cells[Grid.ColCount-1, i]:=FormatFloat('0.#',(dmg_count/tot_dmg_count)*100)
      else
        Grid.Cells[Grid.ColCount-1, i]:='0';
    end; //end for i
    {/Формирование ВСЕГО по строкам}

    {Раскраска таблицы}
    Grid.ColorRow[Grid.RowCount-2]:=clYellow;
    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.ColorCol[Grid.ColCount-2]:=clYellow;
    Grid.ColorCol[Grid.ColCount-1]:=clYellow;
    Grid.ColorCol[0]:=clAqua;
    {/Раскраска таблицы}
  end;  // end with  F_ResultForm

  Result:=true
end;

procedure TAnLeakTime.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Excel.OnClick:=ExcelClick;
    btn_Graph.OnClick:=GraphClick;
  end;  // end with
end;

{ TAnBrigDep }
procedure TAnBrigDep.CreateForms;
begin
  F_OptionForm:=Tfrm_AnBrigDepSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnBrigDep.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  Title:=ReplaceChar(Title, #13, ' ');

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnBrigDep.InitFields;
begin
  F_Name:='Анализ выездов бригад с выполнением работ';
  F_ReportFileName:='an_BrigDep.frf';
end;

function TAnBrigDep.LoadData: boolean;
const
  PG_HEADER=777;
  PG_DATA=778;
  PG_FOOTER=779;
var
  ResultSQL: string;
  RegionsSQL, BrigadiersSQL, DamageTypeSQL: string;
  TempReg, TempBrig: string;
  i, dep_count1, dep_count2, tot_dep_count1, tot_dep_count2: integer;
begin
  Result:=false;

  with F_OptionForm as Tfrm_AnBrigDepSel do
  begin
    if Regions<>'' then RegionsSQL:=' and o.fk_orders_regions in'+Regions
    else RegionsSQL:='';

    if Brigadiers<>'' then BrigadiersSQL:=' and d.fk_departures_brigadiers in'+Brigadiers
    else BrigadiersSQL:='';

    if DamageType<>'' then DamageTypeSQL:=' and o.fk_orders_damagetype in'+DamageType
    else DamageTypeSQL:='';

    ResultSQL:= ' select sr.name reg_name, b.name brig_name, count(*) dep_count, 1 usl'+
                ' from orders o'+
                ' left join departures d'+
                ' on d.fk_departures_orders=o.id, brigadiers b, s_regions sr'+
                ' where d.depnumber=1'+
                ' and d.fk_departures_brigadiers=b.id and d.fk_departures_brigadiers>0'+
                ' and o.fk_orders_regions=sr.id'+
                RegionsSQL+BrigadiersSQL+DamageTypeSQL+
                ' and DateComing>='''+DateToStr(dp_Date1.Date)+''' and DateComing<'''+DateToStr(dp_Date2.Date+1)+''''+
                ' group by sr.name, b.name'+
                ' union all'+
                ' select sr.name reg_name, b.name brig_name, count(*) dep_count, 2 usl'+
                ' from orders o'+
                ' left join departures d'+
                ' on d.fk_departures_orders=o.id,'+
                ' brigadiers b, s_regions sr'+
                ' where d.depnumber=1'+
                ' and d.fk_departures_brigadiers=b.id and d.fk_departures_brigadiers>0'+
                ' and o.fk_orders_regions=sr.id'+
                ' and ('+
                '     cast(o.datecoming as date)=cast(o.dateclosed as date)'+
                '     or ('+
                '         cast(o.datecoming as date)=cast(o.dateclosed as date)+1'+
                '         and cast(o.dateclosed as time)<''8:00:00'''+
                '         )'+
                '     )'+
                RegionsSQL+BrigadiersSQL+DamageTypeSQL+
                ' and DateComing>='''+DateToStr(dp_Date1.Date)+''' and DateComing<'''+DateToStr(dp_Date2.Date+1)+''''+
                ' group by sr.name, b.name'+
                ' order by 1, 2';
  end;  //end with F_OptionForm

  with F_ResultForm as Tfrm_AnalysisView do
  begin


    TempReg:='';
    MyOpenSQL(F_Dset[0], ResultSQL);
    while not F_Dset[0].Eof do
    begin
      {Заголовок района}
      if TempReg<>NameCase(F_Dset[0].FieldByName('reg_name').AsString) then
      begin
        if TempReg<>'' then Grid.RowCount:=Grid.RowCount+1;
        TempReg:=NameCase(F_Dset[0].FieldByName('reg_name').AsString);
        TempBrig:='';

        Grid.Cells[0, Grid.RowCount-1]:=TempReg+' район';
        Grid.Rows[Grid.RowCount-1].Objects[0]:=ptr(PG_HEADER);
        Grid.ColorRow[Grid.RowCount-1]:=clSkyBlue;
      end;
      {/Заголовок района}

      {Фамилия бригадира}
      if TempBrig<>trim(F_Dset[0].FieldByName('brig_name').AsString) then
      begin
        TempBrig:=trim(F_Dset[0].FieldByName('brig_name').AsString);
        Grid.RowCount:=Grid.RowCount+1;
        Grid.Cells[0, Grid.RowCount-1]:=TempBrig;
      end;
      {/Фамилия бригадира}

      {Кол-во выездов}
      if F_Dset[0].FieldByName('usl').AsInteger=1 then
      begin
        Grid.Cells[1, Grid.RowCount-1]:=F_Dset[0].FieldByName('dep_count').AsString;
        Grid.Cells[2, Grid.RowCount-1]:='0';
      end else Grid.Cells[2, Grid.RowCount-1]:=F_Dset[0].FieldByName('dep_count').AsString;
      Grid.Rows[Grid.RowCount-1].Objects[0]:=ptr(PG_DATA);
      {/Кол-во выездов}

      F_Dset[0].Next;
    end; //end while
    F_Dset[0].Close;

{-----Формирование итого-----}

    {Добавление доп. строк}
    i:=1;
    while i<Grid.RowCount do
    begin
      if Assigned(Grid.Rows[i].Objects[0]) and (integer(Grid.Rows[i].Objects[0])=PG_HEADER) then
      begin
        if i<>1 then
        begin
          Grid.InsertRow(i);
          Grid.InsertRow(i);
          Grid.Rows[i].Objects[0]:=ptr(PG_FOOTER);
          inc(i,2);
        end;
      end;

      if i=Grid.RowCount-1 then
      begin
        Grid.RowCount:=Grid.RowCount+2;
        Grid.Rows[Grid.RowCount-2].Objects[0]:=ptr(PG_FOOTER);
        inc(i,2);
      end;
      inc(i);
    end;
    {/Добавление доп. строк}

    {Итого по районам}
    tot_dep_count1:=0;
    tot_dep_count2:=0;
    for i:=1 to Grid.RowCount-1 do
    begin
      if Assigned(Grid.Rows[i].Objects[0]) then
      begin
        case integer(Grid.Rows[i].Objects[0]) of
          PG_HEADER:
            begin
              dep_count1:=0;
              dep_count2:=0;
            end;
          PG_DATA:
            begin
              dep_count1:=dep_count1+StrToInt(Grid.Cells[1, i]);
              dep_count2:=dep_count2+StrToInt(Grid.Cells[2, i]);
            end;
          PG_FOOTER:
            begin
              tot_dep_count1:=tot_dep_count1+dep_count1;
              tot_dep_count2:=tot_dep_count2+dep_count2;

              Grid.Cells[0, i]:='Итого по району:';
              Grid.Cells[1, i]:=IntToStr(dep_count1);
              Grid.Cells[2, i]:=IntToStr(dep_count2);
              if dep_count1<>0 then
                Grid.Cells[3, i]:=FormatFloat('0.#', (dep_count2/dep_count1)*100)+' %';
              Grid.ColorRow[i]:=clYellow;
            end;
        end; // end case
      end;  // end if Assigned
    end;  // end for i
    {/Итого по районам}

    {Общее ИТОГО}
    Grid.RowCount:=Grid.RowCount+1;
    Grid.Cells[0, Grid.RowCount-1]:='ИТОГО ПО РАЙОНАМ:';
    Grid.Cells[1, Grid.RowCount-1]:=IntToStr(tot_dep_count1);
    Grid.Cells[2, Grid.RowCount-1]:=IntToStr(tot_dep_count2);
    if tot_dep_count1<>0 then
      Grid.Cells[3, Grid.RowCount-1]:=FormatFloat('0.#', (tot_dep_count2/tot_dep_count1)*100)+' %';
    Grid.ColorRow[Grid.RowCount-1]:=clMoneyGreen;
    {/Общее ИТОГО}

{/----Формирование итого----}

  end; // with F_ResultForm

  Result:=true;
end;

procedure TAnBrigDep.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Excel.OnClick:=ExcelClick;
  end; //end with
end;

procedure TAnBrigDep.PrepareResultFormGrid;
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=4;
    Grid.FixedCols:=0;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;

    Grid.RowHeights[0]:=Grid.DefaultRowHeight*2;
    for i:=0 to grid.ColCount-1 do
    begin
      Grid.AlignCell[i, 0]:=alCenter;
      Grid.CellFont[i, 0].Style:=[fsBold];
    end;

    Grid.Cells[0,0]:='Бригадир';
    Grid.Cells[1,0]:='   Кол-во   '+#13+'   выездов   ';
    Grid.Cells[2,0]:='Кол-во ликв.'+#13+'в ту же смену';
    Grid.Cells[3,0]:='% ликвидиро-'+#13+'   ванных    ';
  end; //end with
end;

procedure TAnBrigDep.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnBrigDepSel) do
  begin
    CenterLabel:= 'Повреждения на в/сетях города'+#13+
                  'с '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date);
    LeftLabel:= 'Район: '+strRegions+#13+
                'Бригадир: '+strBrigadiers+#13+
                'Вид повреждения: '+strDamageType;
  end; //end with
end;

{ TAnComingClosedEquip }

procedure TAnComingClosedEquip.CreateForms;
begin
  F_OptionForm:=Tfrm_AnDateDmgEquipSel.Create(nil, F_Name);
  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnComingClosedEquip.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  Title:=ReplaceChar(Title, #13, ' ');

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnComingClosedEquip.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_ComingClosedEquipChart;
  dt1, dt2: string;
  i,j: integer;
begin
  frm_Chart:=Tfrm_ComingClosedEquipChart.Create(nil, 'График рез. анализа поступивших, ликвидированных и раб. оборудов.');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    dt1:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date1.Date);
    dt2:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date2.Date);

    Title.Text.Clear;
    Title.Text.Add('График поступивших, ликвидированных повреждений');
    Title.Text.Add('и количество экскаваторов');
    Title.Text.Add(Format('за период с %s по %s',[dt1, dt2]));
    {/Заголовок диаграммы}

    Legend.Visible:=true;

    {Добавляем серии}
    AddChartSeries(stBar);
    ChartSeries[0].SeriesColor:=clRed;
    ChartSeries[0].Title:='Пост';

    AddChartSeries(stBar);
    ChartSeries[1].SeriesColor:=clGreen;
    ChartSeries[1].Title:='Ликв';

    AddChartSeries(stBar);
    ChartSeries[2].SeriesColor:=clBlue;
    ChartSeries[2].Title:='Кол.маш.';

    if (F_OptionForm as Tfrm_AnDateDmgEquipSel).chk_EquipPlanned.Checked then
    begin
      AddChartSeries(stBar);
      ChartSeries[3].SeriesColor:=clAqua;
      ChartSeries[3].Title:='Запл.об.';
    end;

    {/Добавляем серии}

    {Добавляем значения}
    for i:=0 to frm_Chart.ChartSeriesCount-1 do
    begin
      ChartSeries[i].Marks.Style:=smsValue;
      ChartSeries[i].Marks.Transparent:=true;
      ChartSeries[i].Marks.Frame.Visible:=false;
      for j:=1 to Grid.RowCount-1 do
        ChartSeries[i].Add(StrToFloat(Grid.Cells[i+1, j]), copy(Grid.Cells[0, j],1,5)+'.');
    end;
    {/Добавляем значения}
    end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnComingClosedEquip.InitFields;
begin
  F_Name:='Анализ поступивших, ликвидированных и раб. оборудов.';
  F_ReportFileName:='an_ComingClosedEquip.frf';
end;

function TAnComingClosedEquip.LoadData: boolean;
var
  RegionsSQL, DamagePlaceSQL: string;
  ComingCountSQL, ClosedCountSQL: string;
  WorkEquipSQL, PlannedEquipSQL: string;
  dt1, dt2: string;
  id_reg: integer;
  IsEquipPlanned: boolean;
  tmp, ClosedCount, i, j: integer;
begin
  Result:=false;
  with F_OptionForm as Tfrm_AnDateDmgEquipSel do
  begin
    IsEquipPlanned:=chk_EquipPlanned.Checked;

    dt1:=DateToStr(dp_Date1.Date);
    dt2:=DateToStr(dp_Date2.Date+1);


    RegionsSQL:='select id, name from s_regions where id>-1 and activity is null';
    if Regions<>'' then
      RegionsSQL:=RegionsSQL+' and id in'+Regions;

    if DamagePlace<>'' then
      DamagePlaceSQL:=' and fk_orders_DamagePlace in'+DamagePlace
    else
      DamagePlaceSQL:='';

    ComingCountSQL:=
      ' select count(*) ComingCount'+
      ' from orders o '+
      ' where DateComing>'''+dt1+''' and DateComing<='''+dt2+''''+
      ' and fk_orders_regions=%d'+
      DamagePlaceSQL;

    ClosedCountSQL:=
      ' select count(*) ClosedCount'+
      ' from orders o '+
      ' where DateClosed>'''+dt1+''' and DateClosed<='''+dt2+''''+
      ' and IsClosed=1'+
      ' and fk_orders_regions=%d'+
      DamagePlaceSQL;

{
    WorkEquipSQL:=
      ' select count(distinct fk_eqwork_equip) as WorkEquipCount'+
      ' from equipwork ew, orders o'+
      ' where o.id=ew.fk_eqwork_orders'+
      ' and (ew.DateWork>'''+dt1+''')'+
      ' and (ew.DateWork<='''+dt2+''')'+
      ' and (o.fk_orders_regions=%d)';
}
    WorkEquipSQL:=
      ' select distinct cast(ew.datework as Date), ew.fk_eqwork_equip'+
      ' from equipwork ew, orders o'+
      ' where'+
      ' o.id=ew.fk_eqwork_orders'+
      ' and (ew.DateWork>'''+dt1+''')'+
      ' and (ew.DateWork<='''+dt2+''')'+
      ' and (o.fk_orders_regions=%d)'+
      ' group by ew.datework, ew.fk_eqwork_equip';

    PlannedEquipSQL:=
      ' select count(*) PlannedEquipCount'+
      ' from equipplanned'+
      ' where eqdate>='''+dt1+''' and eqdate<'''+dt2+''''+
      ' and fk_equipplanned_regions=%d';

  end; // end with F_OptionForm


  with F_ResultForm as Tfrm_AnalysisView do
  begin
    MyOpenSQL(F_Dset[0], RegionsSQL);
    while not F_Dset[0].Eof do
    begin
      id_reg:=F_Dset[0].FieldByName('id').AsInteger;
      Grid.Cells[0, Grid.RowCount-1]:=F_Dset[0].FieldByName('name').AsString;

      {Количество поступивших}
      MyOpenSQL(F_Dset[1], Format(ComingCountSQL, [id_reg]));
      Grid.Cells[1, Grid.RowCount-1]:=F_Dset[1].FieldByName('ComingCount').AsString;
      {/Количество поступивших}

      {Количество закрытых}
      MyOpenSQL(F_Dset[1], Format(ClosedCountSQL, [id_reg]));
      ClosedCount:=F_Dset[1].FieldByName('ClosedCount').AsInteger;
      Grid.Cells[2, Grid.RowCount-1]:=IntToStr(ClosedCount);
      {/Количество закрытых}

      {Кол-во раб. оборудования}
      MyOpenSQL(F_Dset[1], Format(WorkEquipSQL, [id_reg]));
      //Grid.Cells[3, Grid.RowCount-1]:=F_Dset[1].FieldByName('WorkEquipCount').AsString;
      F_Dset[1].Last;
      Grid.Cells[3, Grid.RowCount-1]:=IntToStr(F_Dset[1].RecordCount);
      {/Кол-во раб. оборудования}

      {К Л/Р}
      tmp:=StrToInt(Grid.Cells[3, Grid.RowCount-1]);
      if tmp<>0 then
      begin
        Grid.Cells[5, Grid.RowCount-1]:=FormatFloat('0.##', ClosedCount/tmp);
      end else Grid.Cells[5, Grid.RowCount-1]:='0';
      {/К Л/Р}

      if IsEquipPlanned then
      begin
        MyOpenSQL(F_Dset[1], Format(PlannedEquipSQL,[id_reg]));
        tmp:=F_Dset[1].FieldByName('PlannedEquipCount').AsInteger;
        Grid.Cells[4, Grid.RowCount-1]:=IntToStr(tmp);
        if tmp<>0 then Grid.Cells[6, Grid.RowCount-1]:=FormatFloat('0.##', ClosedCount/tmp)
        else Grid.Cells[6, Grid.RowCount-1]:='0';
      end else
      begin
        //Прячем колонки (пустые колонки не отображаются)
        Grid.Cells[4, 0]:='';
        Grid.Cells[6, 0]:='';
      end;
      Grid.RowCount:=Grid.RowCount+1;
      F_Dset[0].Next;
    end; //end while
    F_Dset[0].Close;
    F_Dset[1].Close;

    //////////////////////////////////////////////////////
    {Подбиваем итого}
    if Grid.RowCount<4 then
    begin
      Grid.RowCount:=Grid.RowCount-1;
    end else
    begin
      Grid.Cells[0, Grid.RowCount-1]:='ВСЕГО';

      for i:=1 to 3 do
      begin
        tmp:=0;
        for j:=1 to Grid.RowCount-2 do
          tmp:=tmp+StrToInt(Grid.Cells[i, j]);
        Grid.Cells[i, Grid.RowCount-1]:=IntToStr(tmp);
      end;

      ClosedCount:=StrToInt(Grid.cells[2, Grid.RowCount-1]);

      tmp:=StrToInt(Grid.Cells[3, Grid.RowCount-1]);
      if tmp<>0 then
      begin
        Grid.Cells[5, Grid.RowCount-1]:=FormatFloat('0.##', ClosedCount/tmp);
      end else Grid.Cells[5, Grid.RowCount-1]:='0';

      if IsEquipPlanned then
      begin
        tmp:=0;
        for i:=1 to Grid.RowCount-2 do
          tmp:=tmp+StrToInt(Grid.Cells[4, i]);
        Grid.Cells[4, Grid.RowCount-1]:=IntToStr(tmp);

        if tmp<>0 then Grid.Cells[6,Grid.RowCount-1]:=FormatFloat('0.##', ClosedCount/tmp)
        else Grid.Cells[6, Grid.RowCount-1]:='0';
      end;

    end;
    {/Подбиваем итого}
    //////////////////////////////////////////////////////

  end; //end F_ResultForm


  Result:=true;
end;

procedure TAnComingClosedEquip.OnFirst(Sender: Tobject);
var
  i, col: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    col:=0;
    for i:=0 to Grid.ColCount-1 do
    begin
      if Grid.ColWidths[i]>0 then
      begin
        frVariables['ColVal'+IntToStr(col)]:=trim(Grid.Cells[i,F_NumRow]);
        inc(col);
      end;
    end;
  end; //end with
end;

procedure TAnComingClosedEquip.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnComingClosedEquip.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Excel.OnClick:=ExcelClick;
    btn_Print.OnClick:=PrintClick;
    btn_Graph.OnClick:=GraphClick;
  end;
end;

procedure TAnComingClosedEquip.PrepareResultFormGrid;
var
  i: integer;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.ColCount:=7;
    Grid.FixedCols:=0;

    for i:=1 to Grid.ColCount-1 do
      Grid.AlignCol[i]:=alCenter;

    Grid.Cells[0,0]:='Район';
    Grid.Cells[1,0]:='Поступило';
    Grid.Cells[2,0]:='Ликвидировано';
    Grid.Cells[3,0]:='Кол.раб.экск.';
    Grid.Cells[4,0]:='Кол.запл.экск.';
    Grid.Cells[5,0]:='К. Л/Р';
    Grid.Cells[6,0]:='К. Л/З';
  end;
end;

procedure TAnComingClosedEquip.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnDateDmgEquipSel) do
  begin
    CenterLabel:='Количество поступивших и ликвидированных повреждений'+#13+
                 'и количество работавших экскаваторов'+#13+
                  'за период с '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date);
  end;
end;

procedure TAnComingClosedEquip.PrintClick(Sender: TObject);
var
  i, col: integer;
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin

    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;

    col:=0;
    for i:=0 to Grid.ColCount-1 do
    begin
      if Grid.ColWidths[i]>0 then
      begin
        F_Report.FindObject('mem_ColName'+IntToStr(col)).Visible:=true;
        F_Report.FindObject('mem_ColVal'+IntToStr(col)).Visible:=true;

        frVariables['ColName'+IntToStr(col)]:=trim(Grid.Cells[i,0]);
        inc(col);
      end;
    end;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnDmgPeriod }

procedure TAnDmgPeriod.CreateForms;
begin
  F_OptionForm:=Tfrm_AnDateDmgEquipSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_AnDateDmgEquipSel).chk_EquipPlanned.Visible:=false;

  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnDmgPeriod.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  Title:=ReplaceChar(Title, #13, ' ');

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnDmgPeriod.GraphClick(sender: TObject);
var
  frm_Chart: Tfrm_Chart;
  dt1, dt2: string;
  i,j: integer;
begin
  frm_Chart:=Tfrm_Chart.Create(nil, 'График рез. анализа повреждений за период');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    dt1:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date1.Date);
    dt2:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date2.Date);

    Title.Text.Clear;
    Title.Text.Add('График поступивших, ликвидированных повреждений');
    Title.Text.Add('и количество машиносмен');
    Title.Text.Add(Format('за период с %s по %s',[dt1, dt2]));
    {/Заголовок диаграммы}

    Legend.Visible:=true;
    BottomAxis.LabelsAngle:=90;

    {Добавляем серии}
    AddChartSeries(stBar);
    ChartSeries[0].SeriesColor:=clRed;
    ChartSeries[0].Title:='Пост';

    AddChartSeries(stBar);
    ChartSeries[1].SeriesColor:=clGreen;
    ChartSeries[1].Title:='Ликв';

    AddChartSeries(stBar);
    ChartSeries[2].SeriesColor:=clBlue;
    ChartSeries[2].Title:='Кол.маш.';
    {/Добавляем серии}

    {Добавляем значения}
    for i:=0 to 2 do
    begin
      ChartSeries[i].Marks.Visible:=false;
      for j:=1 to Grid.RowCount-2 do
        ChartSeries[i].Add(StrToFloat(Grid.Cells[i+1, j]), Grid.Cells[0, j]);
    end;
    {/Добавляем значения}
    end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnDmgPeriod.InitFields;
begin
  F_Name:='Анализ повреждений за период';
  F_ReportFileName:='an_DmgPeriod.frf';
end;

function TAnDmgPeriod.LoadData: boolean;
  function Koef(str_chis, str_znam: string): string;
  var
    chis, znam: integer;
  begin
    chis:=StrToInt(str_chis);
    znam:=StrToInt(str_znam);
    if znam<>0 then
      Result:=FormatFloat('0.##', chis/znam)
    else
      Result:='0';
  end;
var
  RegionsSQL, DamagePlaceSQL: string;
  ComingCountSQL, ClosedCountSQL: string;
  WorkEquipSQL: string;
  dt1, dt2: TDate;
  i, dt_count, sum_coming, sum_closed, sum_equip: integer;
begin
  Result:=false;
  with F_OptionForm as Tfrm_AnDateDmgEquipSel do
  begin
    dt1:=dp_Date1.Date;
    dt2:=dp_Date2.Date;

    if Regions<>'' then
      RegionsSQL:=' and fk_orders_regions in'+Regions
    else
      RegionsSQL:='';

    if DamagePlace<>'' then
      DamagePlaceSQL:=' and fk_orders_DamagePlace in'+DamagePlace
    else
      DamagePlaceSQL:='';

    ComingCountSQL:=
      ' select count(*) ComingCount'+
      ' from orders o '+
      ' where DateComing>''%s'' and DateComing<=''%s'''+
      RegionsSQL+
      DamagePlaceSQL;

    ClosedCountSQL:=
      ' select count(*) ClosedCount'+
      ' from orders o '+
      ' where DateClosed>''%s'' and DateClosed<=''%s'''+
      ' and IsClosed=1'+
      RegionsSQL+
      DamagePlaceSQL;

{
    WorkEquipSQL:=
      ' select count(distinct fk_orders_equipments) WorkEquipCount'+
      ' from orders'+
      ' where fk_orders_equipments<>-1'+
      ' and IsClosed=1'+
      ' and DateClosed>''%s'' and DateClosed<=''%s'''+
      RegionsSQL+
      DamagePlaceSQL;
}

    WorkEquipSQL:=
      ' select count(distinct fk_eqwork_equip) as WorkEquipCount'+
      ' from equipwork ew, orders o'+
      ' where o.id=ew.fk_eqwork_orders'+
      ' and (ew.DateWork>''%s'')'+
      ' and (ew.DateWork<=''%s'')'+
      RegionsSQL+
      DamagePlaceSQL;

  end; // end with F_OptionForm


  with F_ResultForm as Tfrm_AnalysisView do
  begin
    sum_coming:=0;
    sum_closed:=0;
    sum_equip:=0;

    dt_count:=trunc(dt2-dt1)+1;
    Grid.RowCount:=dt_count+2;

    for i:=0 to dt_count-1 do
    begin
      Grid.Cells[0, i+1]:=DateToStr(dt1+i);

      MyOpenSQL(F_Dset[0], Format(ComingCountSQL, [DateToStr(dt1+i), DateToStr(dt1+i+1)]));
      Grid.Cells[1, i+1]:=F_Dset[0].FieldByName('ComingCount').AsString;
      sum_coming:=sum_coming+F_Dset[0].FieldByName('ComingCount').AsInteger;

      MyOpenSQL(F_Dset[0], Format(ClosedCountSQL, [DateToStr(dt1+i), DateToStr(dt1+i+1)]));
      Grid.Cells[2, i+1]:=F_Dset[0].FieldByName('ClosedCount').AsString;
      sum_closed:=sum_closed+F_Dset[0].FieldByName('ClosedCount').AsInteger;

      MyOpenSQL(F_Dset[0], Format(WorkEquipSQL, [DateToStr(dt1+i), DateToStr(dt1+i+1)]));
      Grid.Cells[3, i+1]:=F_Dset[0].FieldByName('WorkEquipCount').AsString;
      sum_equip:=sum_equip+F_Dset[0].FieldByName('WorkEquipCount').AsInteger;

      Grid.Cells[4, i+1]:=Koef(Grid.Cells[2, i+1], Grid.Cells[3, i+1]);
    end; // end for i
    F_Dset[0].Close;

    i:=dt_count+1;
    Grid.ColorRow[i]:=clYellow;
    Grid.Cells[0, i]:=Format('Итого: %d дней',[dt_count]);
    Grid.Cells[1, i]:=IntToStr(sum_coming);
    Grid.Cells[2, i]:=IntToStr(sum_closed);
    Grid.Cells[3, i]:=IntToStr(sum_equip);
    Grid.Cells[4, i]:=Koef(Grid.Cells[2, i], Grid.Cells[3, i]);
  end; //end F_ResultForm

  Result:=true;
end;

procedure TAnDmgPeriod.OnFirst(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to 4 do
    frVariables['ColVal'+IntToStr(i)]:=(F_ResultForm as Tfrm_AnalysisView).Grid.Cells[i, F_NumRow];
end;

procedure TAnDmgPeriod.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnDmgPeriod.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintClick;
    btn_Excel.OnClick:=ExcelClick;
    btn_Graph.OnClick:=GraphClick;
  end; // end with
end;

procedure TAnDmgPeriod.PrepareResultFormGrid;
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.ColCount:=5;
    Grid.FixedCols:=0;

    for i:=1 to Grid.ColCount-1 do
      Grid.AlignCol[i]:=alCenter;

    Grid.Cells[0,0]:='Дата';
    Grid.Cells[1,0]:='Поступило';
    Grid.Cells[2,0]:='Ликвидировано';
    Grid.Cells[3,0]:='Кол. машиносмен';
    Grid.Cells[4,0]:='Коэф.';
  end; // end with
end;

procedure TAnDmgPeriod.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnDateDmgEquipSel) do
  begin
    CenterLabel:= 'Количество поступивших и ликвидированных повреждений за период'+#13+
                  'c '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date)+#13+
                  'по предприятию "Харьковводосеть"';
    LeftLabel:= 'Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end; // end with
end;

procedure TAnDmgPeriod.PrintClick(Sender: TObject);
var
  i: integer;
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin

    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnEquipUse }

procedure TAnEquipUse.CreateForms;
begin
  F_OptionForm:=Tfrm_AnDateDmgEquipSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_AnDateDmgEquipSel).chk_EquipPlanned.Visible:=false;

  F_ResultForm:=Tfrm_AnalysisView.Create(nil);
end;

procedure TAnEquipUse.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
  Title:=ReplaceChar(Title, #13, ' ');

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnEquipUse.GraphClick(Sender: TObject);
var
  frm_Chart: Tfrm_ComingClosedEquipChart;
  dt1, dt2: string;
  i,j: integer;
begin
  frm_Chart:=Tfrm_ComingClosedEquipChart.Create(nil, 'График рез. анализа запл. и раб. оборудования');
  with frm_Chart, frm_Chart.Chart, (F_ResultForm as Tfrm_AnalysisView) do
  begin
    {Заголовок диаграммы}
    dt1:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date1.Date);
    dt2:=DateToStr((F_OptionForm as Tfrm_AnDateDmgEquipSel).dp_Date2.Date);

    Title.Text.Clear;
    Title.Text.Add('График количества запл. и раб. оборудования');
    Title.Text.Add(Format('за период с %s по %s',[dt1, dt2]));
    {/Заголовок диаграммы}

    Legend.Visible:=true;
    BottomAxis.LabelsAngle:=90;

    {Добавляем серии}
    AddChartSeries(stBar);
    ChartSeries[0].SeriesColor:=clRed;
    ChartSeries[0].Title:='Запл.об.';

    AddChartSeries(stBar);
    ChartSeries[1].SeriesColor:=clGreen;
    ChartSeries[1].Title:='Раб.об.';
    {/Добавляем серии}

    {Добавляем значения}
    for i:=0 to 1 do
    begin
      ChartSeries[i].Marks.Style:=smsValue;
      ChartSeries[i].Marks.Transparent:=true;
      ChartSeries[i].Marks.Frame.Visible:=false;
      for j:=1 to Grid.RowCount-1 do
        ChartSeries[i].Add(StrToFloat(Grid.Cells[i+1, j]), Grid.Cells[0, j]);
    end;
    {/Добавляем значения}
    end; //end with
  frm_Chart.ShowModal;
end;

procedure TAnEquipUse.InitFields;
begin
  F_Name:='Анализ использования оборудования за период';
  F_ReportFileName:='an_EquipUse.frf';
end;

function TAnEquipUse.LoadData: boolean;
var
  WorkEquipSQL, PlannedEquipSQL: string;
  DamagePlaceSQL, Reg_wrk_SQL, Reg_pln_SQL: string;
  dt1, dt2: TDate;
  i,dt_count, sum_wrk, sum_pln: integer;
begin
  Result:=false;

  with F_OptionForm as Tfrm_AnDateDmgEquipSel do
  begin
    dt1:=dp_Date1.Date;
    dt2:=dp_Date2.Date;

    if DamagePlace<>'' then
      DamagePlaceSQL:=' and fk_orders_DamagePlace in'+DamagePlace
    else
      DamagePlaceSQL:='';

    if Regions<>'' then
    begin
      Reg_wrk_SQL:=' and fk_orders_regions in'+Regions;
      Reg_pln_SQL:=' and fk_equipplanned_regions in'+Regions;
    end else
    begin
      Reg_wrk_SQL:='';
      Reg_pln_SQL:='';
    end;

{
    WorkEquipSQL:=
      ' select count(distinct fk_orders_equipments) WorkEquipCount'+
      ' from orders'+
      ' where fk_orders_equipments<>-1'+
      ' and IsClosed=1'+
      ' and DateClosed>''%s'' and DateClosed<=''%s'''+
      Reg_wrk_SQL+
      DamagePlaceSQL;
}

    WorkEquipSQL:=
      ' select count(distinct fk_eqwork_equip) as WorkEquipCount'+
      ' from equipwork ew, orders o'+
      ' where o.id=ew.fk_eqwork_orders'+
      ' and (ew.DateWork>''%s'')'+
      ' and (ew.DateWork<=''%s'')'+
      Reg_wrk_SQL+
      DamagePlaceSQL;

    PlannedEquipSQL:=
      ' select count(distinct fk_equipplanned_equip) PlannedEquipCount'+
      ' from equipplanned'+
      ' where eqdate>=''%s'' and eqdate<''%s'''+
      Reg_pln_SQL;
  end; // end with F_OptionForm


  with F_ResultForm as Tfrm_AnalysisView do
  begin
    sum_pln:=0;
    sum_wrk:=0;
    dt_count:=trunc(dt2-dt1)+1;
    Grid.RowCount:=dt_count+2;

    for i:=0 to dt_count-1 do
    begin
      Grid.Cells[0, i+1]:=DateToStr(dt1+i);

      MyOpenSQL(F_Dset[0], Format(PlannedEquipSQL, [DateToStr(dt1+i), DateToStr(dt1+i+1)]));
      Grid.Cells[1, i+1]:=F_Dset[0].FieldByName('PlannedEquipCount').AsString;
      sum_pln:=sum_pln+F_Dset[0].FieldByName('PlannedEquipCount').AsInteger;

      MyOpenSQL(F_Dset[0], Format(WorkEquipSQL, [DateToStr(dt1+i), DateToStr(dt1+i+1)]));
      Grid.Cells[2, i+1]:=F_Dset[0].FieldByName('WorkEquipCount').AsString;
      sum_wrk:=sum_wrk+F_Dset[0].FieldByName('WorkEquipCount').AsInteger;

    end; //end for i
    F_Dset[0].Close;

    Grid.ColorRow[Grid.RowCount-1]:=clYellow;
    Grid.Cells[0, Grid.RowCount-1]:='Итого: '+IntToStr(dt_count);
    Grid.Cells[1, Grid.RowCount-1]:=IntToStr(sum_pln);
    Grid.Cells[2, Grid.RowCount-1]:=IntToStr(sum_wrk);
  end; //end F_ResultForm


  Result:=true;
end;

procedure TAnEquipUse.OnFirst(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to 2 do
    frVariables['ColVal'+IntToStr(i)]:=(F_ResultForm as Tfrm_AnalysisView).Grid.Cells[i, F_NumRow];
end;

procedure TAnEquipUse.OnNext(Sender: TObject);
begin
  inc(F_NumRow);
  OnFirst(Sender);
end;

procedure TAnEquipUse.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Print.OnClick:=PrintClick;
    btn_Graph.OnClick:=GraphClick;
    btn_Excel.OnClick:=ExcelClick;
  end; //end with
end;

procedure TAnEquipUse.PrepareResultFormGrid;
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.RowCount:=2;
    Grid.FixedRows:=1;
    Grid.ColCount:=3;
    Grid.FixedCols:=0;

    for i:=1 to Grid.ColCount-1 do
      Grid.AlignCol[i]:=alCenter;

    Grid.Cells[0, 0]:='Дата';
    Grid.Cells[1, 0]:='Запл.обор. ';
    Grid.Cells[2, 0]:='Работ.обор.';
  end; //end with
end;

procedure TAnEquipUse.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_AnDateDmgEquipSel) do
  begin
    CenterLabel:='Количество запл. и работ. оборудования за период'+#13+
                  'с '+DateToStr(dp_Date1.Date)+' по '+DateToStr(dp_Date2.Date);
    LeftLabel:='Район: '+strRegions+#13+
                'Место повреждения: '+strDamagePlace;
  end; //end with
end;

procedure TAnEquipUse.PrintClick(Sender: TObject);
var
  i: integer;
begin
  if not LoadReportFile then exit;

  with F_ResultForm as Tfrm_AnalysisView do
  begin

    frVariables['Caption']:=CenterLabel;
    frVariables['AddCaption']:=LeftLabel;

    F_frUDS.RangeEnd:=reCount;
    F_frUDS.RangeEndCount:=Grid.RowCount-1;
    F_frUDS.OnFirst:=OnFirst;
    F_frUDS.OnNext:=OnNext;
    F_NumRow:=1;
  end; // and with

  ShowReport;
end;

{ TAnSearchAdres }

procedure TAnSearchAdres.ClearAdresList;
var
  i: integer;
begin
  for i:=0 to F_AdresList.Count-1 do
    if Assigned(F_AdresList.Items[i]) then
      Dispose(F_AdresList.Items[i]);

  F_AdresList.Clear;    
end;

constructor TAnSearchAdres.Create;
begin
  inherited Create;
  F_AdresList:=TList.Create;
end;

procedure TAnSearchAdres.CreateForms;
begin
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, F_Name);

  F_OptionForm:=Tfrm_PeriodRegDmgDiamSel.Create(nil, F_Name);
  (F_OptionForm as Tfrm_PeriodRegDmgDiamSel).ShortTableName:='o'; //Важно!!!
end;

function TAnSearchAdres.DateCaption(dt1, dt2, DmgCount: string): string;
begin
  Result:='Список адресов повреждений на водопроволных сетях'+
            #13+'больше '+DmgCount+' за';
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

destructor TAnSearchAdres.Destroy;
begin
  ClearAdresList;
  inherited Destroy;
end;

procedure TAnSearchAdres.ExcelClick(Sender: TObject);
var
  Title: string;
begin
  Title:=ReplaceChar((F_ResultForm as Tfrm_AnalysisView).CenterLabel,#13,' ');

  with TExcelWorks.Create do
  begin
    try
      Close;
      SetWSName('Результаты анализа');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid((F_ResultForm as Tfrm_AnalysisView).Grid);
    finally
      Free;
    end;
  end;
end;

procedure TAnSearchAdres.InitFields;
begin
  F_Name:='Поиск адресов больше определенного кол-ва';
  F_ReportFileName:='an_SearchAdres.frf';
end;

function TAnSearchAdres.LoadData: boolean;
var
  SelSQL, DamageCount, SortType: string;
  pAdr: TPShortAdres;
begin
  Result:=false;

  with F_OptionForm as Tfrm_PeriodRegDmgDiamSel do
  begin
    DamageCount:=FloatToStr(sp_DamageCount.Value);

    if cb_SortType.ItemIndex=0 then SortType:='asc'
    else SortType:='desc';

    SelSQL:=' select count(*) DamageCount, o.fk_orders_housetypes, o.fk_orders_streets, o.housenum,'+
            '''                                                                                                  '' adres'+
            ' from orders o'+
            ResultCondition+
            ' and o.fk_orders_housetypes in(0,1)'+
            ' group by o.fk_orders_housetypes, o.fk_orders_streets, o.housenum'+
            ' having  count(*)>='+DamageCount+
            ' order by 1 '+SortType;
  end; //end with F_OptionForm

  ClearAdresList;
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    {Задаем адрес}
    F_Dset[0].CachedUpdates:=true;
    F_Dset[0].ModifySQL.Clear;
    F_Dset[0].ModifySQL.Add('update orders set OrderNumber=:OrderNmber where id=:id');
    MyOpenSQL(F_Dset[0], SelSQL);
    F_Dset[0].First;
    while not F_Dset[0].Eof do
    begin
      F_Dset[0].Edit;
      F_Dset[0].FieldByName('Adres').AsString:=
        DM_Main.GetAdres( F_Dset[0].FieldByName('fk_orders_housetypes').AsInteger,
                          F_Dset[0].FieldByName('fk_orders_streets').AsInteger,
                          F_Dset[0].FieldByName('housenum').AsString);
      F_Dset[0].Next;
    end;
    {/Задаем адрес}

    F_Dset[0].First;
    while not F_Dset[0].Eof do
    begin
      Grid.Cells[0, Grid.RowCount-1]:=IntToStr(F_Dset[0].RecNo);
      Grid.Cells[1, Grid.RowCount-1]:=F_Dset[0].FieldByName('Adres').AsString;
      Grid.Cells[2, Grid.RowCount-1]:=F_Dset[0].FieldByName('DamageCount').AsString;

      new(pAdr);
      pAdr.id_housetype:=F_Dset[0].FieldByName('fk_orders_housetypes').AsInteger;
      pAdr.id_street:=F_Dset[0].FieldByName('fk_orders_streets').AsInteger;
      pAdr.HouseNum:=F_Dset[0].FieldByName('HouseNum').AsString;
      F_AdresList.Add(pAdr);
      Grid.Rows[Grid.RowCount-1].Objects[0]:=pointer(pAdr);

      Grid.RowCount:=Grid.RowCount+1;
      F_Dset[0].Next;
    end;
    Grid.RowCount:=Grid.RowCount-1;
  end;  //end F_ResultForm

  Result:=true;
end;

procedure TAnSearchAdres.OrderClick(Sender: TObject);
var
  pAdr: TPShortAdres;
  PodRep: TSearchAdres_PodRep;
begin
  with F_ResultForm as Tfrm_AnalysisView do
    if Assigned(Grid.Objects[0, Grid.Row]) then
      pAdr:=TPShortAdres(Grid.Objects[0, Grid.Row]);

  PodRep:=TSearchAdres_PodRep.Create;
  try
    PodRep.Dset[0]:=F_Dset[1];
    PodRep.Report:=F_Report;
    PodRep.ProgressIndic:=F_ProgressIndic;

    PodRep.ID_HouseType:=pAdr.id_housetype;
    PodRep.ID_Street:=pAdr.id_street;
    PodRep.HouseNum:=pAdr.HouseNum;
    PodRep.AdditionalCondition:=(F_OptionForm as Tfrm_PeriodRegDmgDiamSel).ResultCondition;

    PodRep.Execute;
  finally
    PodRep.Free;
  end;
end;

procedure TAnSearchAdres.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderClick;
    btn_Order.Caption:='Поиск';  
    btn_Print.OnClick:=PrintClick;
    btn_Excel.OnClick:=ExcelClick;
  end;
end;

procedure TAnSearchAdres.PrepareResultFormGrid;
var
  i: integer;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    Grid.ColCount:=3;
    Grid.FixedCols:=0;
    Grid.RowCount:=2;
    Grid.FixedRows:=1;

    Grid.RowHeights[0]:=2*Grid.RowHeights[0];
    for i:=0 to 2 do
    begin
      Grid.CellFont[i, 0].Style:=[fsBold];
      Grid.AlignCell[i, 0]:=alCenter;
    end;
    Grid.AlignCol[0]:=alCenter;
    Grid.AlignCol[2]:=alCenter;

    Grid.Cells[1,0]:='Адрес';
    Grid.Cells[2,0]:='Количество'+#13+'повреждений';
  end;
end;

procedure TAnSearchAdres.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgDiamSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate,strFinishedDate, FloatToStr(sp_DamageCount.Value));
    LeftLabel:='Районы: '+strRegions+
              #13+'Место пореждения: '+strDamagePlace+
              #13+'Местность повреждения: '+strDamageLocality+
              #13+'Диаметер: '+strTubeDiameter+
              #13+'Материал трубы: '+strTubeMaterial;
  end;
end;

procedure TAnSearchAdres.PrintClick(Sender: TObject);
begin
  with F_OptionForm as Tfrm_PeriodRegDmgDiamSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate, FloatToStr(sp_DamageCount.Value));
    frVariables['Regions']:='Районы: '+strRegions;
    frVariables['DamagePlace']:='Место повреждения: '+strDamagePlace;
    frVariables['TubeDiameter']:='Диаметер: '+strTubeDiameter;
    frVariables['DamageLocality']:='Местность повреждения: '+strTubeDiameter;
    frVariables['TubeMaterial']:='Материал трубы: '+strTubeMaterial;


  end;

  if not LoadReportFile then exit;
  ShowReport;
end;

end.
