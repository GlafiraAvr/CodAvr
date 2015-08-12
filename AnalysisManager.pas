unit AnalysisManager;

interface

uses
  RootReportDModule, SysUtils, Classes, ProgressForm, IBDatabase, DB, IBCustomDataSet, DModule,
  FR_DSet, FR_Class, AVR_Analysis, FR_DBSet, FrPreviewForm;

type

  TAnalysisName=(anNoWorkingKol, anRegionDamageCount, anDmgWithTemper,
                  anLeakPeriod, anLeakDmgPlace, anLeakDmgLoc, anLeakDiam,
                  anLeakDays, anLeakTime, anBrigDep, anComingClosedEquip,
                  anDmgPeriod, anEquipUse, anSearchAdres);

  TDM_AnalysisManager = class(Tdm_RootReport)
    dset_tmp1: TIBDataSet;
    Transac: TIBTransaction;
    frUDS_tmp: TfrUserDataset;
    frReport: TfrReport;
    dset_tmp2: TIBDataSet;
    dset_tmp3: TIBDataSet;
    pind_Load: TProgressIndicator;
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Analysis: TBaseAnalysis;
    F_frPreviewForm: Tfrm_FrPreview;
    function CreateAnalysis(AnalysisName: TAnalysisName): TBaseAnalysis;
  public
    procedure ShowAnalysis(AnalysisName: TAnalysisName);
  end;


implementation

{$R *.dfm}

{ TDM_AnalysisManager }

function TDM_AnalysisManager.CreateAnalysis(
  AnalysisName: TAnalysisName): TBaseAnalysis;
begin
  case AnalysisName of
    anNoWorkingKol: Result:=TAnNoWorkingKol.Create; //Кол-во неработающих колонок за период
    anRegionDamageCount: Result:=TAnRegionDamageCount.Create; //Анализ кол-ва повреждений по всем районам
    anDmgWithTemper: Result:=TAnDmgWithTemper.Create; //Анализ повреждений за период с температурой
    anLeakPeriod: Result:=TAnLeakPeriod.Create; //Анализ утечек за период №2
    anLeakDmgPlace: Result:=TAnLeakDmgPlace.Create; //Анализ ликв. течей по месту повреждения
    anLeakDmgLoc: Result:=TAnLeakDmgLoc.Create; //Анализ кол-ва ликв. поврежедений по местности поврежедения
    anLeakDiam: Result:=TAnLeakDiam.Create; //Анализ кол-ва ликв. повреждений по диаметрам
    anLeakDays: Result:=TAnLeakDays.Create; //Анализ сроков ликвидации повреждений
    anLeakTime: Result:=TAnLeakTime.Create; //Анализ кол-ва повреждений по времени поступления
    anBrigDep: Result:=TAnBrigDep.Create; //Анализ выездов бригад с выполнением работ
    anComingClosedEquip: Result:=TAnComingClosedEquip.Create; //Анализ поступивших, ликвидированных и раб. оборудов.
    anDmgPeriod: Result:=TAnDmgPeriod.Create; //Анализ повреждений за период
    anEquipUse: Result:=TAnEquipUse.Create; //Анализ использования оборудования за период
    anSearchAdres: Result:=TAnSearchAdres.Create; //Поиск адресов больше определенного кол-ва
  end; //end case
end;

procedure TDM_AnalysisManager.ShowAnalysis(AnalysisName: TAnalysisName);
var
  IsExecuteOk: boolean;
begin
  F_Analysis:=CreateAnalysis(AnalysisName);
  try
    {Инициализация}
    F_Analysis.Dset[0]:=dset_tmp1;
    F_Analysis.Dset[1]:=dset_tmp2;
    F_Analysis.Dset[2]:=dset_tmp3;
    F_Analysis.Report:=frReport;
    F_Analysis.frUDS:=frUDS_tmp;
    F_Analysis.ProgressIndic:=pind_Load;
    {/Инициализация}

    repeat
      if Transac.InTransaction then
        Transac.Rollback;
      Transac.StartTransaction;
      try
        IsExecuteOk:=F_Analysis.Execute;
      finally
        Transac.Commit;
      end;
    until not IsExecuteOk;
  finally
    F_Analysis.Free;
  end;
end;

procedure TDM_AnalysisManager.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_frPreviewForm:=Tfrm_FrPreview.Create(nil, frReport);
  frReport.Preview:=F_frPreviewForm.frPreview;
end;

procedure TDM_AnalysisManager.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_frPreviewForm.Free;
end;

end.
