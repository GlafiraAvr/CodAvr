unit ReportManager;

interface

uses
  RootReportDModule, FR_DSet, DBTables, MemTable, IBSQL, ProgressForm, FR_DBSet,
  DB, IBCustomDataSet, IBDatabase, Classes, FR_Class, SysUtils, Dialogs, Graphics, 
  DModule, Controls, AVR_Report, FrPreviewForm, CustomReport, RxMemDS;


type
  TReportName=(rnOpenOrderSearch, rnCloseOrderSearch, rnAllOrderSearch);

  TDM_ReportManager = class(Tdm_RootReport)
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
    function CreateReport(AReportName: TReportName): TCustomReport;
  public
    procedure ShowReport(ReportName: TReportName);
  end;

implementation

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
    F_Report.RecordCountDset:=dset_RecordCount;
    F_Report.Report:=frReport;
    F_Report.ProgressIndic:=pind_Load;
    frDBDataSet.DataSet:= F_Report.TRmem;

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


function TDM_ReportManager.CreateReport(
  AReportName: TReportName): TCustomReport;
begin
  case AReportName of
    rnOpenOrderSearch: begin Result:=TOpenOrderSearch.Create; Result.TRmem:=RxMemoryOpend  end;//Поиск незакрытых нарядов за период
    rnCloseOrderSearch:  begin Result:=TCloseOrderSearch.Create;  Result.TRmem:=RxMemoryClosed end;//Поиск закрытых нарядов за период
    rnAllOrderSearch: begin Result:=TAllOrderSearch.Create; Result.TRmem:=RxMemoryAll end;//Поиск всех нарядов за период
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

end.
