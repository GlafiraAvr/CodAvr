unit NGReportManager_vds;

interface

uses NGBaseReport;

type
  TNGReportName_vds=(rnUniversalSearch2_vds, rnSvodVed_vds, rnSvodVedPer_vds, rnRepDiscon_vds, rnActExeWorks_vds,
                  rnRepOpenOrders_vds, rnRepClosedOrders_vds, rnVedUsedMaters_vds, rnCalcMaterCost_vds
                  , rnRepRayonOrders_vds,rnSvodkaGek,rnSvodVed_vds_2,rnSvodVed_vds_per_2,rnRSvodved_vds,
                  rnPlanWork_vds, rnVedNotCloseOrder_vds);

  TNGReportManager_vds=class
    function CreateReport(AReportName: TNGReportName_vds): TNGBaseReport;
  public
    procedure ShowReport(AReportName: TNGReportName_vds);
  end;

implementation

uses NGReports_vds, RightsManagerDModule;

function TNGReportManager_vds.CreateReport(
  AReportName: TNGReportName_vds): TNGBaseReport;
begin
  case AReportName of
    rnUniversalSearch2_vds: Result:=TUniversalSearch2_vds.Create; //������������ �����
    rnSvodVed_vds: Result:=TSvodVed_vds.Create;                   //������� ���������
    rnSvodVedPer_vds: Result:=TSvodVedPer_vds.Create;             //������� ��������� �� ������
    rnRepDiscon_vds: Result:=TRepDiscon_vds.Create;               //������ ���������� �� ������
    rnActExeWorks_vds: Result:=TActExeWorks_vds.Create;           //��� ����������� �����
    rnRepOpenOrders_vds: Result:=TRepOpenOrders_vds.Create;       //������ ���������� �������
    rnVedUsedMaters_vds: Result:=TVedUsedMaters_vds.Create;       //��������� ������������� ����������
    rnCalcMaterCost_vds: Result:=TCalcMaterCost_vds.Create;       //������ ��������� ����������
    rnRepClosedOrders_vds: Result:=TRepClosedOrders_vds.Create;   //������ ����������� �������
    rnRepRayonOrders_vds: Result:=TRepRayonOrders_vds.Create;   //�������� ����� ���������� ��������� (����� �� �������)
    rnSvodkaGek     : result:=TSvodkaGek.Create;       //������ � ���
    rnSvodVed_vds_2 :result:=TSvodVed_vds_2.Create;                   //������� ��������� 2
    rnSvodVed_vds_per_2 :result:=TSvodVed_vds_per_2.Create;                   //������� ��������� �� ������ 2
    rnRSvodved_vds      :result:=TRSvoVed.Create;                //����������� ������� ��������� �� ���
    rnPlanWork_vds      :result:=TPlanWorkVds.Create;            //������ �� ��������������� ������� ���
    rnVedNotCloseOrder_vds :result:=TVedNotCloseOrder_vds.Create; // ������� ��������� ���������� �������(����)
  end;
end;

procedure TNGReportManager_vds.ShowReport(AReportName: TNGReportName_vds);
var
  IsExecuteOk: boolean;
  report: TNGBaseReport;
begin
  report:=CreateReport(AReportName);
  report.ns_vds:=2;
  try
    //������� �����
    DM_RightsManager.AddReportName(report.ClassName);
    repeat
      IsExecuteOk:=report.Execute;
    until not IsExecuteOk;
  finally
    report.Free;
  end;
end;

end.
