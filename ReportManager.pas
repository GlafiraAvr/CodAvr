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
    {Инициализация}
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
    {/Инициализация}
     //вставим отчет
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
    rnOpenOrderSearch: Result:=TOpenOrderSearch.Create;                         //Поиск незакрытых нарядов за период
    rnCloseOrderSearch: Result:=TCloseOrderSearch.Create;                       //Поиск закрытых нарядов за период
    rnAllOrderSearch: Result:=TAllOrderSearch.Create;                           //Поиск всех нарядов за период
    rnSvodVed: Result:=TSvodVed.Create;                                         //Сводная ведомость
    rnClosedBoltsAdres: Result:=TClosedBoltsAdres.Create;                       //Сводка по перекрытым задвижкам(выбор адреса)
    rnClosedBolts: Result:=TClosedBolts.Create;                                 //Сводка по перекрытым задвижкам
    rnKilledDamage: Result:=TKilledDamage.Create;                               //Сводка по ликвидированным повреждениям
    rnKilledDamage_vodoset: Result:=TKilledDamage_vodoset.Create;               //Сводка по ликвидированным повреждениям(водосеть)
    rnPayedOrders: Result:=TPayedOrders.Create;                                 //Сводка платных нарядов
    rnKilledDamage_director: Result:=TKilledDamage_director.Create;             //
    rnSvodSES: Result:=TSvodSES.Create;                                         //Сводка в СЭС
    rnClosedOrders: Result:=TClosedOrders.Create;                               //Ведомость закрытых нарядов
    rnSvodVed_smena: Result:=TSvodVed_smena.Create;                             //Сводная ведомость за смену
    rnSpravkaAbon: Result:=TSpravkaAbon.Create;                                 //Справка в Абонентный отдел
    rnSvodVed_excav: Result:=TSvodVed_excav.Create;                             //Сводная ведомость по разрытию
    rnProfWorkType: Result:=TProfWorkType.Create;                               //Сводка о видах профработ
    rnSvodVed_OutstandWork: Result:=TSvodVed_OutstandWork.Create;               //Сводная ведомость невыполненых работ по обратной засыпке
    rnBlagState: Result:=TBlagState.Create;                                     //Ведомость состояния благоустройств
    rnSearchAdres_PodRep: Result:=TSearchAdres_PodRep.Create;                   //Просмотр адресов результатов анализа
    rnLongOrder: Result:=TLongOrder.Create;                                     //Анализ повреждений длит. больше заданного
    rnAnalysisLeak: Result:=TAnalysisLeak.Create;                               //Анализ утечек
    rnAnalysisEquipWork: Result:=TAnalysisEquipWork.Create;                     //Анализ работы экс. при ликв. повр.
    rnInstallHatch: Result:=TInstallHatch.Create;                               //Сводка установки крышек люка
    rnGlavUpr: Result:=TGlavUpr.Create;                                         //Сводка в главное управление города
    rnKolvoOtkazov: Result:=TKolvoOtkazov.Create;                               //Сводка "Количество отказов"
    rnHideLeak: Result:=THideLeak.Create;                                       //Сводка скрытых утечек
    rnSvodVed2: Result:=TSvodVed2.Create;                                       //Сводная ведомость №2
    rnSvodVed2Land: Result:=TSvodVed2Land.Create;                                       //Сводная ведомость №2
    rnSvodVed3: Result:=TSvodVed3.Create;                                       //Сводная ведомость №3
    rnSvodVed_sent: Result:=TSvodVed_sent.Create;                               //Ведомость аварийных ситуация
    rnSvodVedDamage: Result:=TSvodVedDamage.Create;                             //Сводная ведомость повреждений

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

