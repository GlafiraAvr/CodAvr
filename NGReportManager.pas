unit NGReportManager;

interface

uses NGBaseReport ,ngreportsvdsns,ngreports2;

type
  TNGReportName=(rnSvodkaGik, rnUtechkiNaVodoseti, rnVAbonBezVody, rnUniversalSearch2,
    rnSvodVedLukAndPG, rnNeedAsfalt, rnGorSES, rnTrudoZatrat, rnVipolNaryad, rnNetBar,
    rnSvodExcav, rnBlagItog, rnSvodka062, rnBlag2, rnBlag3,rnPlanDep, rnPlanDenial,
    rnUseEquip, rnAvarSit, rnDisconnectKPVoda, rnSearch1562, rnBlagPodr, rnNaled,
    rnAVRDisconn, rnSheben, rnNODSBezVody, rnPovrRegion, rnRazrtDep, rnBlag3GIK, rnInfBlag, rnObrZas
    ,rnRSvodved,rnblagRasr,rnPlanTexnik,rnSPlanWorks, rnSvPoZayav,rnBlagSvod,
    rnSodVed_1562ns, rnRepGreenSpring,rnDisconSite,rnREport1321,rnReport13192,rnExcavOrderTable,
    rnApplicationForSbit, rnTDamageBlagObject, rnGetToDoNar, rnAllReport1,
    rnOptZvCloseOrder);

  TNGReportManager=class
  private
    function CreateReport(AReportName: TNGReportName): TNGBaseReport;

  public
    procedure ShowReport(AReportName: TNGReportName);
    procedure ShowReportFromOrder(AReportName: TNGReportName);
  end;

implementation

uses NGReports,MainForm,RightsManagerDModule;

function TNGReportManager.CreateReport(
  AReportName: TNGReportName): TNGBaseReport;
begin

  case AReportName of
    rnSvodkaGik:           Result := TSvodkaGik.Create;                   //������ � ���
    rnUtechkiNaVodoseti:   Result := TUtechkiNaVodoseti.Create;           //������ ���� �� ������������� �����
    rnVAbonBezVody:        Result := TVAbonBezVody.Create;                //������ � ���������� ����� ��� ����
    rnNODSBezVody:         Result := TNODSBezVody.Create;                 //������ ��� ���� ���������� ���
    rnUniversalSearch2:    Result := TUniversalSearch2.Create;            //������������ �����
    rnSvodVedLukAndPG:     Result := TSvodVedLukAndPG.Create;             //��������� ������ �� ��������� ����� � ������ ���. ���������
    rnNeedAsfalt:          Result := TNeedAsfalt.Create;                  //��������� �� ��������������� � ���
    rnGorSES:              Result := TGorSES.Create;                      //������ � ������
    rnTrudoZatrat:         Result := TTrudoZatrat.Create;                 //������ �����������
    rnVipolNaryad:         Result := TVipolNaryad.Create;                 //������ ����������� �����
    rnNetBar:              Result := TNetBar.Create;                      //������ �������� ����
    rnSvodExcav:           Result := TSvodExcav.Create;                   //������ �� ��������
    rnBlagItog:            Result := TBlagItog.Create;                    //�������� ������� �� ���������������
    rnSvodka062:           Result := TSvodka062.Create;                   //������ �� ������ � �������� ���
    rnBlag2:               Result := TBlag2.Create;                       //������ �� ��������������� � ��� �2
    rnBlag3:               Result := TBlag3.Create;                       //������ �� ��������������� � ��� �3
    rnPlanDep:             Result := TPlanDep.Create ;                    //���� ���������� �����
    rnPlanDenial:          Result := TPlanDenial.Create ;                 //������������� ������
    rnUseEquip:            Result := TUseEquip.Create ;                   //������������� ���������� ��� ���������������
    rnAvarSit:             Result := TAvarSit.Create ;                    //���������� �� ��������� ���������
    rnDisconnectKPVoda:    Result := TDisconKPVoda.Create ;               //������ ����������  �� ''���������������� ''
    rnSearch1562:          Result := TSearch1562.Create;                  //����� 1562
    rnBlagPodr:            Result := TBlagPodr.Create;                    //������ �� ��������������� ������������
    rnNaled:               Result := TNaledRep.Create;                    //������ �� ������
    rnAVRDisconn:          Result := TAVRDisconnections.Create;           //���������� � ���
    rnSheben:              Result := TSheben.Create;                      //������ ���������� ���������
    rnPovrRegion:          Result := TPovrRegion.Create;                  //������ ��� ������������ ���
    rnRazrtDep:            Result := TRazrtDep.Create;                    //������ �� ������ ��������
    rnBlag3GIK:            Result := TBlag3GIK.Create;                    //������ �� ��������������� � ��� ���������
    rnInfBlag:             Result := TInfBlag.Create;                     //���������� �� ���������������
    rnObrZas:              Result := TObrZas.Create;                      //������ ������� �������� �������
    rnRSvodved:            result:=TRSvoVed.Create;                //����������� ������� ���������
    rnblagRasr:            REsult:=TblagRasr.Create;               //������� ��������� �� ��������������� �������� ��� ���������� ����������� � ������� �������������
    rnPlanTexnik:          REsult:=TsTexnik.Create;                //������ ��������������� ������� ��� ���������� ���
    rnSPlanWorks:          REsult:=TSPlan_Work.Create;             //���� ���������� ����� �� �������
    rnSvPoZayav:           REsult:=TSvPoZayvkam.Create;            //������ �� ������� �������� ����
    rnBlagSvod:            REsult:=TBlagSvod.Create;             //������ �� ���������������
    rnSodVed_1562ns:       REsult:=TSvodVed_1562ns.Create;             //������� ��������� �� � ��������
    rnRepGreenSpring:      REsult:= TRepGreenSpring.Create;      //������ "������� �����"
    rnDisconSite:          Result:=TDisconSite.Create;           //������ ���������� �� ����
    rnREport1321:          Result:=TReport1321.Create;           //������������ ����� 13.2.1
    rnReport13192:         Result:=TReport13192.Create;           //������������ ����� 13.19.2
    rnExcavOrderTable:     Result:=TExcavOrderTable.Create;       //������� �� �������
    rnApplicationForSbit:  Result:=TApplicationsForSbit.Create;  //������ ������ ��� �����
    rnTDamageBlagObject:   Result:=TDamageBlagObject.Create; //���������� �� ��������� ���������������
    rnGetToDoNar       :   Result:=TGetToDoNar.Create;        //���������� � �������� � ����������� �������
    rnAllReport1       :   Result:=TReportAll1.Create;       //�������� ��������������������� �����
    rnOptZvCloseOrder :    Result:=TZvCloseOrder.Create;     //���������� ������ � �������� �������

    end;
end;

procedure TNGReportManager.ShowReport(AReportName: TNGReportName);
var
  IsExecuteOk: boolean;
  report: TNGBaseReport;
  istimer:boolean;
begin
  report:=CreateReport(AReportName);
  istimer:=false;
  try
     istimer:=frm_Main.Timer1.Enabled;
     if istimer then
     frm_Main.Timer1.Enabled:=false;
     //������� �����
      DM_RightsManager.AddReportName(report.ClassName);
    repeat
      report.IsFromOrder := false;
      IsExecuteOk:=report.Execute;
    until not IsExecuteOk;
  finally
    report.Free;
 if  DM_RightsManager.IsCurrentUserDisp then
  if istimer then
    frm_Main.Timer1.Enabled:=true;
  end;

end;

procedure TNGReportManager.ShowReportFromOrder(AReportName: TNGReportName);
var
  IsExecuteOk: boolean;
  report: TNGBaseReport;
begin
  report:=CreateReport(AReportName);
  try
    repeat
      report.IsFromOrder := true;
      IsExecuteOk:=report.Execute;
    until not IsExecuteOk;
  finally
    report.Free;
  end;
end;




end.
