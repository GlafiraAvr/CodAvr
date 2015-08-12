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
    anNoWorkingKol: Result:=TAnNoWorkingKol.Create; //���-�� ������������ ������� �� ������
    anRegionDamageCount: Result:=TAnRegionDamageCount.Create; //������ ���-�� ����������� �� ���� �������
    anDmgWithTemper: Result:=TAnDmgWithTemper.Create; //������ ����������� �� ������ � ������������
    anLeakPeriod: Result:=TAnLeakPeriod.Create; //������ ������ �� ������ �2
    anLeakDmgPlace: Result:=TAnLeakDmgPlace.Create; //������ ����. ����� �� ����� �����������
    anLeakDmgLoc: Result:=TAnLeakDmgLoc.Create; //������ ���-�� ����. ������������ �� ��������� ������������
    anLeakDiam: Result:=TAnLeakDiam.Create; //������ ���-�� ����. ����������� �� ���������
    anLeakDays: Result:=TAnLeakDays.Create; //������ ������ ���������� �����������
    anLeakTime: Result:=TAnLeakTime.Create; //������ ���-�� ����������� �� ������� �����������
    anBrigDep: Result:=TAnBrigDep.Create; //������ ������� ������ � ����������� �����
    anComingClosedEquip: Result:=TAnComingClosedEquip.Create; //������ �����������, ��������������� � ���. ��������.
    anDmgPeriod: Result:=TAnDmgPeriod.Create; //������ ����������� �� ������
    anEquipUse: Result:=TAnEquipUse.Create; //������ ������������� ������������ �� ������
    anSearchAdres: Result:=TAnSearchAdres.Create; //����� ������� ������ ������������� ���-��
  end; //end case
end;

procedure TDM_AnalysisManager.ShowAnalysis(AnalysisName: TAnalysisName);
var
  IsExecuteOk: boolean;
begin
  F_Analysis:=CreateAnalysis(AnalysisName);
  try
    {�������������}
    F_Analysis.Dset[0]:=dset_tmp1;
    F_Analysis.Dset[1]:=dset_tmp2;
    F_Analysis.Dset[2]:=dset_tmp3;
    F_Analysis.Report:=frReport;
    F_Analysis.frUDS:=frUDS_tmp;
    F_Analysis.ProgressIndic:=pind_Load;
    {/�������������}

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
