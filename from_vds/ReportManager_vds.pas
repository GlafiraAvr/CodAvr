unit ReportManager_vds;

interface

uses
  RootReportDModule, FR_DSet, DBTables, MemTable, IBSQL, ProgressForm, FR_DBSet,
  DB, IBCustomDataSet, IBDatabase, Classes, FR_Class, SysUtils, Dialogs, Graphics, 
  DModule, Controls, AVR_Report_vds, FrPreviewForm, CustomReport, RxMemDS;


type
  TReportNameVds=(rnOpenOrderSearch_vds, rnCloseOrderSearch_vds, rnAllOrderSearch_vds);

  TDM_ReportManager_vds = class(Tdm_RootReport)
    frReport: TfrReport;
    Transac: TIBTransaction;
    dset_tmp: TIBDataSet;
    frDBDataSet: TfrDBDataSet;
    dset_tmp2: TIBDataSet;
    dset_RecordCount: TIBDataSet;
    frDBDataSet2: TfrDBDataSet;
    pind_Load: TProgressIndicator;
    RxMemoryClosed: TRxMemoryData;
    RxMemoryAll: TRxMemoryData;
    RxMemoryOpend: TRxMemoryData;
    RxMemoryClosedid: TIntegerField;
    RxMemoryClosedDateComing: TStringField;
    RxMemoryClosedDateClosed: TStringField;
    RxMemoryClosedFullOrderNum: TStringField;
    RxMemoryClosedRegions: TStringField;
    RxMemoryClosedadres: TStringField;
    RxMemoryOpendFullOrderNum: TStringField;
    RxMemoryOpendDateComing: TStringField;
    RxMemoryOpendid: TIntegerField;
    RxMemoryOpendRegions: TStringField;
    RxMemoryOpendadres: TStringField;
    RxMemoryOpenddistrict: TStringField;
    RxMemoryAllid: TIntegerField;
    RxMemoryAllFullorderNum: TStringField;
    RxMemoryAllDateComing: TStringField;
    RxMemoryAllRegions: TStringField;
    RxMemoryAlladres: TStringField;
    RxMemoryAllisClosed: TStringField;
    RxMemoryAllMainGr: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Report: TCustomReport;
    F_frPreviewForm: Tfrm_FrPreview;
    function CreateReport(AReportName:  TReportNameVds): TCustomReport;
  public
    procedure ShowReport(ReportName: TReportNameVds);
  end;

implementation
uses RightsManagerDModule;

{$R *.dfm}

procedure TDM_ReportManager_vds.ShowReport(ReportName: TReportNameVDS);
var
  IsExecuteOk: boolean;
begin
  F_Report:=CreateReport(ReportName);

  try
    {Инициализация}
    F_Report.Dset[0]:=dset_tmp;
    F_Report.Dset[1]:=dset_tmp2;
    F_Report.RecordCountDset:=dset_RecordCount;
    F_Report.Report:=frReport;
    F_Report.ProgressIndic:=pind_Load;

    frDBDataSet.DataSet:= F_Report.TRmem;
    //вставим отчет
     DM_RightsManager.AddReportName(F_Report.ClassName);
   //F_ReportTRxMemor

    //
    {/Инициализация}

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


function TDM_ReportManager_vds.CreateReport(
  AReportName: TReportNameVDS): TCustomReport;
begin
  case AReportName of
    rnOpenOrderSearch_vds: begin Result:=TOpenOrderSearch_vds.Create; Result.TRmem:=RxMemoryOpend  end;//Поиск незакрытых нарядов за период
    rnCloseOrderSearch_vds:  begin Result:=TCloseOrderSearch_vds.Create;  Result.TRmem:=RxMemoryClosed end;//Поиск закрытых нарядов за период
    rnAllOrderSearch_vds: begin Result:=TAllOrderSearch_vds.Create; Result.TRmem:=RxMemoryAll end;//Поиск всех нарядов за период
  end; //end case
end;

procedure TDM_ReportManager_vds.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_frPreviewForm:=Tfrm_FrPreview.Create(nil, frReport);
  frReport.Preview:=F_frPreviewForm.frPreview;
end;

procedure TDM_ReportManager_vds.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  F_frPreviewForm.Free;
end;

end.
