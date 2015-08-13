unit NGBaseReport;

interface

uses SysUtils, FR_Class, FR_DSet, Forms, Windows, ProgressForm, BaseOptionForm,
    NGReportBaseDModule, BaseResultForm, Aligrid, RootReport, Controls;

type
  TOptionFormClass=class of Tfrm_BaseOption;
  TNGDataModuleClass=class of Tdm_NGReportBase;
  TResultFormClass=class of Tfrm_BaseResult;

  TNGBaseReport=class(TRootReport)
  private
    procedure ShowFastReport(fr_rep: TfrReport);
  protected
    F_Name: string;
    F_ReportFileName: string;
  //  F_Pind: TProgressIndicator;
    F_OptionForm: Tfrm_BaseOption;
    F_DataModule: Tdm_NGReportBase;
    F_ResultForm: Tfrm_BaseResult;
    F_IsFromOrder: boolean;
    procedure PrepareAndPrintFR(fr_rep: TfrReport);
    function LoadAndPrintFR(fr_rep: TfrReport; prep_name: string; dt: TDate): boolean;
    procedure SavePreparedReport(_frRep: TfrReport; _PrepRepName: string; _Dt: TDate);
    procedure SaveFRToFile(fr_rep: TfrReport; file_name: string);
   // procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
    procedure OnStopProgress(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);
    function LoadReportFileTo(var fr_rep: TfrReport): boolean;
  protected
    procedure InitFields; virtual;
    procedure CreateForms; virtual;
    procedure PrepareFastReport; virtual;

  private
    function GetResultFormGrid: TStringAlignGrid;
  public
    F_Pind: TProgressIndicator;
    ns_vds:integer;//2012 glasha
    procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
    constructor Create;
    destructor Destroy; override;
    function CreateOptionForm(ClassRef: TOptionFormClass; Title: string=''): Tfrm_BaseOption;
    function CreateDataModule(ClassRef: TNGDataModuleClass): Tdm_NGReportBase;
    function CreateResultForm(ClassRef: TResultFormClass; Title: string=''): Tfrm_BaseResult;
    function Execute: boolean; virtual;
    property IsFromOrder: boolean read F_IsFromOrder write F_IsFromOrder;
  end;

implementation

uses BaseFrPreviewForm, FrPreviewForm, OrderForm, ztvZip, RGSendEmail, IniFiles,
      ApplicationSettings, Graphics, FillReportManager, StringConsts,OrderForm_vds;

constructor TNGBaseReport.Create;
begin
  inherited Create;

  {Создаем и ининциализируем pind}
  F_Pind:=TProgressIndicator.Create(nil);
  F_Pind.OnCancel:=OnStopProgress;
  F_Pind.Caption:='Идет подготовка данных';
  F_Pind.CancelCaption:='Отмена';
  {/Создаем и ининциализируем pind}

  InitFields;
  CreateForms;
  ns_vds:=1;

  if Assigned(F_DataModule) then
    F_DataModule.OnChangeProgressStatus:=OnChangeProgressStatus;
    
end;


function TNGBaseReport.CreateDataModule(ClassRef: TNGDataModuleClass): Tdm_NGReportBase;
begin
  F_DataModule:=ClassRef.Create(nil);
  Result:=F_DataModule;
end;

procedure TNGBaseReport.CreateForms;
begin
//
end;

function TNGBaseReport.CreateOptionForm(ClassRef: TOptionFormClass; Title: string=''): Tfrm_BaseOption;
begin
  F_OptionForm:=ClassRef.Create(nil, Title);
  Result:=F_OptionForm;
end;

function TNGBaseReport.CreateResultForm(ClassRef: TResultFormClass;
  Title: string): Tfrm_BaseResult;
begin
  F_ResultForm:=ClassRef.Create(nil, Title);
  Result:=F_ResultForm;
end;

destructor TNGBaseReport.Destroy;
begin
  F_Pind.Free;
  F_OptionForm.Free;
  F_DataModule.Free;
  F_ResultForm.Free;

  inherited Destroy;;
end;

function TNGBaseReport.Execute: boolean;
begin
  Result:=false;
end;

function TNGBaseReport.GetResultFormGrid: TStringAlignGrid;
var
  i: integer;
begin
  for i:=0 to F_ResultForm.ComponentCount-1 do
    if (F_ResultForm.Components[i] is TStringAlignGrid) then
    begin
      Result:=(F_ResultForm.Components[i] as TStringAlignGrid);
      break;
    end;
end;

procedure TNGBaseReport.InitFields;
begin
//
end;

function TNGBaseReport.LoadReportFileTo(var fr_rep: TfrReport): boolean;
var
  FullReportFileName: string;
begin
  FullReportFileName:=AppSettings.Reports_Path+'\'+F_ReportFileName;

  Result:=fr_rep.LoadFromFile(FullReportFileName);
  if not Result then
    Application.MessageBox(PChar('Не могу загрузить файл '+FullReportFileName),
              gc_strDispAVR, MB_OK+MB_ICONWARNING);
end;


procedure TNGBaseReport.OnChangeProgressStatus(ProgLength,
  ProgPos: integer);
begin
  F_Pind.Max:=ProgLength;
  F_Pind.Position:=ProgPos;
end;

procedure TNGBaseReport.OnOrderClick(Sender: TObject);
var
  OrderID: integer;
  frm_Order: Tfrm_Order;
  frm_order_vds: TFrm_order_vds;
  Grid: TStringAlignGrid;
begin
  F_ResultForm.StartWait;
  try
    Grid:=GetResultFormGrid;
    if Assigned(Grid) then
    begin
      if Assigned(Grid.Objects[0, Grid.Row]) then
      begin
        OrderID:=integer(Grid.Objects[0, Grid.Row]);
        if OrderID>0 then
        begin
        case  ns_vds of
         1:begin
            frm_Order:=Tfrm_Order.Create(nil, OrderID);
           end;
          2: frm_order_vds:=Tfrm_Order_vds.create(nil,OrderID);
         end;
        F_ResultForm.StopWait;
        try
        case  ns_vds of
         1:begin
            frm_Order.ShowModal;
            if frm_Order.IsCtrlChange then
             Grid.RowFont[Grid.Row].Color:=clRed;
            end;
         2:begin
            frm_Order_vds.ShowModal;
         //   if frm_Order_vds. then
             Grid.RowFont[Grid.Row].Color:=clRed;
           end;
         end;
        finally
        case ns_vds of
         1: frm_Order.Free;
         2:  frm_order_vds.Free;
        end;
        end;
       end;
      end;
    end;
  finally
    F_ResultForm.StopWait;
  end;
end;

procedure TNGBaseReport.OnStopProgress(Sender: TObject);
begin
  F_DataModule.IsStopProgress:=true;
end;

procedure TNGBaseReport.PrepareFastReport;
begin
//
end;

procedure TNGBaseReport.PrepareAndPrintFR(fr_rep: TfrReport);
begin
  if LoadReportFileTo(fr_rep) then
  begin
    PrepareFastReport;
    fr_rep.PrepareReport;
   
    ShowFastReport(fr_rep);
  end;
end;

procedure TNGBaseReport.ShowFastReport(fr_rep: TfrReport);
begin
  fr_rep.ShowPreparedReport;

  if Assigned(fr_rep.Preview) and (fr_rep.Preview.Owner is Tfrm_BaseFrPreview) then
   (fr_rep.Preview.Owner as Tfrm_BaseFrPreview).ShowModal;

end;

function TNGBaseReport.LoadAndPrintFR(fr_rep: TfrReport;
  prep_name: string; dt: TDate): boolean;
var
  _FillRepMgr: Tdm_FillReportManager;
  _FileName: string;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
  try
    _FileName:=_FillRepMgr.LoadPreparedRep(prep_name, dt);
    if trim(_FileName)<>'' then
    begin
      fr_rep.LoadPreparedReport(_FileName);
      ShowFastReport(fr_rep);
      Result:=true;
    end else Result:=false;
  finally
    _FillRepMgr.Free;
  end;
end;

procedure TNGBaseReport.SaveFRToFile(fr_rep: TfrReport; file_name: string);
begin
  fr_rep.PrepareReport;
  fr_rep.SavePreparedReport(file_name);
end;

procedure TNGBaseReport.SavePreparedReport(_frRep: TfrReport;
  _PrepRepName: string; _Dt: TDate);
var
  _FillRepMgr: Tdm_FillReportManager;
  _FileName: string;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
  try
    _FileName:=_FillRepMgr.TempDir+_PrepRepName+'.frp';
    _frRep.PrepareReport;
    _frRep.SavePreparedReport(_FileName);
    _FillRepMgr.SavePreparedReport(_PrepRepName, _Dt, _FileName);
  finally
    _FillRepMgr.Free;
  end;
end;


end.
