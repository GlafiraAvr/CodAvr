unit ReportManager;

interface

uses
  RootReportDModule, FR_DSet, IBSQL, ProgressForm, FR_DBSet,
  DB, IBCustomDataSet, IBDatabase, Classes, FR_Class, SysUtils, Dialogs, Graphics,
  DModule, Controls, AVR_Report, IB_Reports, FrPreviewForm, CustomReport,
  RxMemDS;


type
  TReportName=(rnOpenOrderSearch, rnCloseOrderSearch, rnAllOrderSearch, rnSvodVed, rnClosedBoltsAdres,
                rnClosedBolts, rnKilledDamage, rnKilledDamage_vodoset,
                rnPayedOrders, rnKilledDamage_director, rnSvodSES,
                rnClosedOrders, rnSvodVed_smena, rnSpravkaAbon, rnSvodVed_excav,
                rnProfWorkType, rnSvodVed_OutstandWork, rnBlagState, rnSearchAdres_PodRep,
                rnLongOrder, rnAnalysisLeak, rnAnalysisEquipWork, rnInstallHatch,
                rnGlavUpr, rnKolvoOtkazov, rnHideLeak, rnSvodVed2, rnSvodVed3, rnSheben,  rnSvodVed2Land,
                rnSvodVed_sent, rnSvodVedDamage);

  TDM_ReportManager = class(Tdm_RootReport)
    frReport: TfrReport;
    Transac: TIBTransaction;
    dset_tmp: TIBDataSet;
    frDBDataSet: TfrDBDataSet;
    dset_tmp2: TIBDataSet;
    dset_RecordCount: TIBDataSet;
    frDBDataSet2: TfrDBDataSet;
    pind_Load: TProgressIndicator;
    dset_tmp3: TIBDataSet;
    IBSQL1: TIBSQL;
    Transac_IBSQL: TIBTransaction;
    frDBDSMemory: TfrDBDataSet;
    frUDSet1: TfrUserDataset;
    mt_tmp: TRxMemoryData;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Report: TCustomReport;
    F_frPreviewForm: Tfrm_FrPreview;
    function CreateReport(AReportName: TReportName): TCustomReport;

   function add_sent(reportName,filename:string):boolean;
  public
    procedure ShowReport(ReportName: TReportName);
  end;

implementation
uses RightsManagerDModule;

{$R *.dfm}

procedure TDM_ReportManager.ShowReport(ReportName: TReportName);
var
  IsExecuteOk: boolean;
begin
  F_Report:=CreateReport(ReportName);

  try
    {�������������}
    F_Report.Dset[0]:=dset_tmp;
    F_Report.Dset[1]:=dset_tmp2;
    F_Report.Dset[2]:=dset_tmp3;
    F_Report.RecordCountDset:=dset_RecordCount;
    F_Report.Report:=frReport;
    F_Report.ProgressIndic:=pind_Load;
    if  F_Report is TSvodVed_sent then
       (F_Report as TSvodVed_sent).add_sent:=add_sent;
    case ReportName of
      rnKolvoOtkazov:
        begin
          (F_Report as TKolvoOtkazov).frUDset:=frUDSet1;
          (F_Report as TKolvoOtkazov).MemTable:=mt_tmp;
        end;
      rnSvodVed_sent:
       begin
   //     F_frPreviewForm.NeedAsk:=true;
       end;
    end; //end case
    {/�������������}
     //������� �����
      DM_RightsManager.AddReportName(F_Report.ClassName);
    repeat
      if Transac.InTransaction then
        Transac.Rollback;
      Transac.StartTransaction;
      try
        IsExecuteOk:=F_Report.Execute;
      finally
        Transac.Commit;
      end;
    until not IsExecuteOk;

  finally
    F_Report.Free;
  end;
end;


function TDM_ReportManager.CreateReport(
  AReportName: TReportName): TCustomReport;
begin
  case AReportName of
    rnOpenOrderSearch: Result:=TOpenOrderSearch.Create;                         //����� ���������� ������� �� ������
    rnCloseOrderSearch: Result:=TCloseOrderSearch.Create;                       //����� �������� ������� �� ������
    rnAllOrderSearch: Result:=TAllOrderSearch.Create;                           //����� ���� ������� �� ������
    rnSvodVed: Result:=TSvodVed.Create;                                         //������� ���������
    rnClosedBoltsAdres: Result:=TClosedBoltsAdres.Create;                       //������ �� ���������� ���������(����� ������)
    rnClosedBolts: Result:=TClosedBolts.Create;                                 //������ �� ���������� ���������
    rnKilledDamage: Result:=TKilledDamage.Create;                               //������ �� ��������������� ������������
    rnKilledDamage_vodoset: Result:=TKilledDamage_vodoset.Create;               //������ �� ��������������� ������������(��������)
    rnPayedOrders: Result:=TPayedOrders.Create;                                 //������ ������� �������
    rnKilledDamage_director: Result:=TKilledDamage_director.Create;             //
    rnSvodSES: Result:=TSvodSES.Create;                                         //������ � ���
    rnClosedOrders: Result:=TClosedOrders.Create;                               //��������� �������� �������
    rnSvodVed_smena: Result:=TSvodVed_smena.Create;                             //������� ��������� �� �����
    rnSpravkaAbon: Result:=TSpravkaAbon.Create;                                 //������� � ���������� �����
    rnSvodVed_excav: Result:=TSvodVed_excav.Create;                             //������� ��������� �� ��������
    rnProfWorkType: Result:=TProfWorkType.Create;                               //������ � ����� ���������
    rnSvodVed_OutstandWork: Result:=TSvodVed_OutstandWork.Create;               //������� ��������� ������������ ����� �� �������� �������
    rnBlagState: Result:=TBlagState.Create;                                     //��������� ��������� ��������������
    rnSearchAdres_PodRep: Result:=TSearchAdres_PodRep.Create;                   //�������� ������� ����������� �������
    rnLongOrder: Result:=TLongOrder.Create;                                     //������ ����������� ����. ������ ���������
    rnAnalysisLeak: Result:=TAnalysisLeak.Create;                               //������ ������
    rnAnalysisEquipWork: Result:=TAnalysisEquipWork.Create;                     //������ ������ ���. ��� ����. ����.
    rnInstallHatch: Result:=TInstallHatch.Create;                               //������ ��������� ������ ����
    rnGlavUpr: Result:=TGlavUpr.Create;                                         //������ � ������� ���������� ������
    rnKolvoOtkazov: Result:=TKolvoOtkazov.Create;                               //������ "���������� �������"
    rnHideLeak: Result:=THideLeak.Create;                                       //������ ������� ������
    rnSvodVed2: Result:=TSvodVed2.Create;                                       //������� ��������� �2
    rnSvodVed2Land: Result:=TSvodVed2Land.Create;                                       //������� ��������� �2
    rnSvodVed3: Result:=TSvodVed3.Create;                                       //������� ��������� �3
    rnSvodVed_sent: Result:=TSvodVed_sent.Create;                               //��������� ��������� ��������
    rnSvodVedDamage: Result:=TSvodVedDamage.Create;                             //������� ��������� �����������

  end; //end case
end;

procedure TDM_ReportManager.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_frPreviewForm:=Tfrm_FrPreview.Create(nil, frReport);
  frReport.Preview:=F_frPreviewForm.frPreview;
end;

procedure TDM_ReportManager.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_frPreviewForm.Free;
end;

function TDM_ReportManager.add_sent(reportName,filename:string):boolean;

begin
try
 if Transac_IBSQL.Active then Transac_IBSQL.Rollback ;
  Transac_IBSQL.StartTransaction;
 try
 IBSQL1.SQL.Text:=Format('update or    insert   into SENTSVEMAIL (SV_NAME,file_name,datetime) values'+
                          '  (''%s'',''%s'',''%s'') matching (SV_NAME)'
                           ,[reportName,filename,DateTimeToStr(Now)] );

 IBSQL1.ExecQuery;
 Transac_IBSQL.Commit;
 result:=true;
 except
  Transac_IBSQL.Rollback;
  result:=false;
 end;
except
 result:=false;
end;

end;

end.

