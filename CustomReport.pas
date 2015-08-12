unit CustomReport;

interface

uses Windows, IBCustomDataSet, ProgressForm, FR_Class, FR_DSet, BaseResultForm,
      BaseOptionForm, aligrid, Forms, Controls, IBSQL, DB, Classes, RootReport, RxMemDS;

type
  TCustomReport=class(TRootReport)
  private
    F_MemFields: TList;
  protected
    F_Name: string;
    F_ReportFileName: string;
    F_Dset: array [0..2] of TIBDataSet;
    F_RecordCountDset: TIBDataSet;
    F_ProgressIndic: TProgressIndicator;
    F_Report: TfrReport;
    F_OptionForm: Tfrm_BaseOption;
    F_ResultForm: Tfrm_BaseResult;

    procedure SetDset(Index: integer; val: TIBDataSet);
    procedure SetMem(Index: integer; val:TRxMemoryData);

    procedure SetReport(value: TfrReport);
    function LoadReportFile: boolean;
    function ShowReport: boolean;
  protected
    function ShowOptionForm: boolean; virtual;
    function LoadData: boolean; virtual;
  protected
    procedure InitFields; virtual;
    procedure CreateForms; virtual;
    procedure PrepareResultFormHeader; virtual;
    procedure PrepareResultFormGrid; virtual;
    procedure PrepareResultFormBtns; virtual;
    procedure PrepareFastReport; virtual;
  public
    TRmem:  TRxMemoryData;
    property TRxmemos[Index: integer]: TRxMemoryData write SetMem;
    property Dset[Index: integer]: TIBDataSet write SetDset;
    property RecordCountDset: TIBDataSet write F_RecordCountDset;
    property Report: TfrReport write SetReport;
    property ProgressIndic: TProgressIndicator write F_ProgressIndic;
    constructor Create;
    destructor Destroy; override;
  public
    function Execute: boolean; virtual;
  end;


implementation

uses ApplicationSettings, BaseFrPreviewForm, FrPreviewForm, StringConsts;

constructor TCustomReport.Create;
begin
  inherited Create;

  InitFields;
  CreateForms;
end;

function TCustomReport.Execute: boolean;
begin
end;


procedure TCustomReport.SetDset(Index: integer; val: TIBDataSet);
begin
  F_Dset[Index]:=val;
end;

function TCustomReport.LoadData: boolean;
begin
end;

destructor TCustomReport.Destroy;
var
  i: integer;
begin
  F_OptionForm.Free;
  F_ResultForm.Free;
  inherited Destroy;
end;

procedure TCustomReport.PrepareResultFormBtns;
begin
end;

procedure TCustomReport.PrepareResultFormGrid;
begin
end;

procedure TCustomReport.PrepareResultFormHeader;
begin
end;

procedure TCustomReport.PrepareFastReport;
begin
end;

procedure TCustomReport.CreateForms;
begin
end;

function TCustomReport.ShowOptionForm: boolean;
begin
  if F_OptionForm.ShowModal=mrOk then
    Result:=true
  else
    Result:=false;
end;

function TCustomReport.LoadReportFile: boolean;
var
  FullReportFileName: string;
begin
  FullReportFileName:=AppSettings.Reports_Path+'\'+F_ReportFileName;
  Result:=F_Report.LoadFromFile(FullReportFileName);
  if not Result then
    Application.MessageBox(PChar('Не могу загрузить файл '+FullReportFileName),
              gc_strDispAVR, MB_OK+MB_ICONWARNING);
end;

procedure TCustomReport.InitFields;
begin
end;

function TCustomReport.ShowReport: boolean;
begin
  F_Report.PrepareReport;
  F_Report.ShowPreparedReport;
  if Assigned(F_Report.Preview) and (F_Report.Preview.Owner is Tfrm_BaseFrPreview) then
    (F_Report.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;
end;

procedure TCustomReport.SetReport(value: TfrReport);
begin
  F_Report:=value;
  if Assigned(F_Report.Preview) and (F_Report.Preview.Owner is Tfrm_FrPreview) then
    (F_Report.Preview.Owner as Tfrm_FrPreview).OnShowGraph:=nil;
end;

procedure TCustomReport.SetMem(Index: integer; val:TRxMemoryData);
begin
 TRmem:=val;
end;

end.
