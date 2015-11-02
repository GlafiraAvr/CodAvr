unit ngreports2;


interface
uses Classes, Controls, Variants, NGBaseReport, SvodkaGikForm, SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm,ExcavOrderTableDModule,OptBlag2Form, FrPreviewForm,
     ApplicationForSbitDmodule,ApplicationForSbitOptForm ,RightsManagerDModule,
     DateSelForm , DamageBlagObjectDModule,
     ReportAll1Dmodule,
     ZvClosedOrderDModule,OptZvCloseOrderForm  ;


 type
  TExcavOrderTable=class(TNGBaseReport)
  private
    F_DM: Tdm_ExcavOrderTable;
    F_OptFrm: Tfrm_OptBlag2;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TApplicationsForSbit = class(TNGBaseReport)
  private
   F_DM:Tdm_ApplicationForSbit;
   F_OptFrm:Tfrm_OptApplicationForSbit;
   F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure PrepareResultFormBtns;
  public
    function Execute: boolean; override;
  end;

  TDamageBlagObject = class (TNgBaseReport)
  private
   F_DM:TTdm_DamageBlagObject;
   F_optFrm:Tfrm_DateSel;
   F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure PrepareResultFormBtns;

  public
    function Execute: boolean; override;
  end;

  TReportAll1 = class (TNgBaseReport)  //Комплекс Харькковводоснабжение отчет
  private
    F_DM: Tdm_ReportAll1;
    F_optFrm: Tfrm_DateSel;
    F_previewFrm:Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrePareResultFormBtns;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


   TZvCloseOrder = class (TNgBaseReport)  //Незакрытые заявки с закрытым ордером
  private
    F_DM: Tdm_ZvClosedOrder;
    F_optFrm: Tfrm_OptZvCloseOrder;
    F_previewFrm:Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrePareResultFormBtns;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


implementation

uses helpfunctions,ApplicationSettings;

procedure TExcavOrderTable.InitFields;
begin
 F_Name := 'Таблица по ордерам';
  F_ReportFileName := 'ExcavOrderTable.frf';
end;

procedure TExcavOrderTable.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptBlag2, F_Name ) as Tfrm_OptBlag2;
  F_DM := CreateDataModule( Tdm_ExcavOrderTable ) as Tdm_ExcavOrderTable;
  //F_DM.ForGIK := false;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TExcavOrderTable.PrepareFastReport;
begin
 frVariables[ 'Begin_date']:= F_OptFrm.frame_SelDates.BeginDate;
 frVariables[ 'End_Date']:= F_OptFrm.frame_SelDates.EndDate;


end;

function  TExcavOrderTable.Execute:boolean;
begin
  Result := false;
  try
  F_OptFrm.rg_Excav.ItemIndex:=1;
  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.BegDate := F_OptFrm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_SelDates.EndDate;
    F_Dm.DopBegin:=F_OptFrm.DopBegDate;
    F_Dm.DopEnd:=F_OptFrm.DopEndDate;
    F_Dm.FinishBegin:=F_OptFrm.FinishBegDatte;
    F_Dm.FinishEnd:=F_OptFrm.FinishpEndDatte;
    F_DM.blag := F_OptFrm.rgblag;
    F_DM.GZ := F_OptFrm.GZ;
    F_DM.ASF := F_OptFrm.RGASF;
    F_DM.IDREgions:=F_OptFrm.IDREgions;
    f_Dm.without_excav:=F_OptFrm.WithoutExcav;
    F_Dm.overdude:=F_OptFrm.overd;
{    if (F_DM is Tdm_RepBlag4) then
      F_DM.ASF:=true;}
    if F_DM.PrepareDsets then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
  except
   result:=false;
  end ;
end;

procedure TApplicationsForSbit.InitFields;
begin
 F_Name := 'Заявки для сбыта';
  F_ReportFileName := 'ApplicationForSbit.frf';
end;

procedure TApplicationsForSbit.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_OptApplicationForSbit, F_Name) as Tfrm_OptApplicationForSbit;
  F_DM := CreateDataModule(  Tdm_ApplicationForSbit ) as  Tdm_ApplicationForSbit;

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TApplicationsForSbit.PrepareFastReport;
begin
 frVariables[ 'Begin_date']:= FormatdateTime('dd.mm.yyyy hh:mm',F_OptFrm.StartDate);
 frVariables[ 'End_Date']:=  FormatdateTime('dd.mm.yyyy hh:mm',F_OptFrm.EndDate);

end;

function  TApplicationsForSbit.Execute:boolean;
 var file_name,full_fn:String;
begin
  Result := false;
  try

   F_OptFrm.setDefault(Date()-7,Now());
   if F_OptFrm.ShowModal <> mrOk then exit;
   PrepareResultFormBtns;
   F_Pind.Show;
  try

    F_DM.DtBegin := F_OptFrm.StartDate;
    F_DM.DtEnd := F_OptFrm.EndDate;
    if F_DM.PrepareDsets then
    begin
       PrepareAndPrintFR( F_DM.frReport );
     if   F_PreviewFrm.ToMail then
     begin

       file_name:=trim('Applic_for_sail'+ReplaceChar(DateToStr(Date), '.', '_'))+ '.xls';
       full_fn:= AppSettings.Get_Abon_Path + file_name;
       if   F_Dm.ExportFRToExcel(F_DM.frReport, full_fn ) then
       begin

        SendByEmail( full_fn
            , 'Сводка заявок для сбыта с '+DateToStr(F_OptFrm.StartDate) +' по '+DateToStr(F_OptFrm.EndDate)            );

       end
     end;

    end;

  finally
    F_Pind.Hide;
  end;

  Result := true;
  except
   result:=false;
  end ;
end;


procedure TApplicationsForSbit.PrepareResultFormBtns;
begin
  F_PreviewFrm.bb_Mail.Visible := DM_RightsManager.IsCurrentUserDisp;
end;

{TDamageBlagObject}
 procedure TDamageBlagObject.InitFields;
 begin
  F_Name := 'Информация нарушения благоустройства';
  F_ReportFileName := 'DamageBlagObjectReport.frf';
 end;

 procedure TDamageBlagObject.CreateForms;
 begin
  F_OptFrm:=CreateOptionForm(Tfrm_DateSel, F_Name) as Tfrm_DateSel;;
  F_DM := CreateDataModule(  TTdm_DamageBlagObject ) as  TTdm_DamageBlagObject;

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
 end;

 procedure TDamageBlagObject.PrepareFastReport;
 begin
   frVariables['date']:=(F_optFrm as Tfrm_DateSel).strDate;
 end;

 procedure TDamageBlagObject.PrepareResultFormBtns;
 begin
   F_PreviewFrm.bb_Mail.Visible := DM_RightsManager.IsCurrentUserDisp;
 end;

function TDamageBlagObject.Execute: boolean;
   var file_name,full_fn:String;
begin
  Result := false;
  try

   F_OptFrm.setDate(Date()-1);
   if F_OptFrm.ShowModal <> mrOk then exit;
   PrepareResultFormBtns;
   F_Pind.Show;
  try

    F_DM.DateSmen := F_OptFrm.dp_Date.Date;

    if F_DM.PrepareDset then
    begin
       PrepareAndPrintFR( F_DM.frReport );
     if   F_PreviewFrm.ToMail then
     begin

       file_name:=trim('DamageBlagObject'+ReplaceChar(DateToStr(Date), '.', '_'))+ '.xls';
       full_fn:= AppSettings.Get_Abon_Path + file_name;

       if   F_Dm.ExportFRToExcel(F_DM.frReport, full_fn ) then
       begin

        SendByEmail( full_fn
            , 'Информация по количеству нарушений объектов благоустройства'   );

       end
     end;

    end;

  finally
    F_Pind.Hide;
  end;

  Result := true;
  except
   result:=false;
  end ;


 end;

{/TDamageBlagObject}










{ TReportAll1 }

procedure TReportAll1.CreateForms;
begin
  inherited;
  F_OptFrm:=CreateOptionForm(Tfrm_DateSel, F_Name) as Tfrm_DateSel;;
  F_DM := CreateDataModule(  Tdm_ReportAll1 ) as  Tdm_ReportAll1;

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TReportAll1.Execute: boolean;
var file_name,full_fn:string;
begin
  Result := false;
  try

   F_OptFrm.setDate(Date());
   if F_OptFrm.ShowModal <> mrOk then exit;
   PrepareResultFormBtns;
   F_Pind.Show;
  try

    F_DM.ShiftDate := F_OptFrm.dp_Date.Date;

    if F_DM.prePareDsets then
    begin
       PrepareAndPrintFR( F_DM.frReport );
     if   F_PreviewFrm.ToMail then
     begin

       file_name:=trim('ReportAllVoda'+ReplaceChar(DateToStr(Date), '.', '_'))+ '.xls';
       full_fn:= AppSettings.Get_Abon_Path + file_name;
 //      ExportFRToExcelAndSendByEmail(F_DM.frReport,full_fn, 'Комплекс "Харьковводоснабжение" отчет');
       if   F_Dm.ExportFRToExcel(F_DM.frReport, full_fn ) then
       begin
        F_DM.SaveAfterSend(file_name);
        SendByEmail( full_fn
            , 'Комплекс "Харьковводоснабжение" отчет'   );

       end
       
     end;

    end



  finally
    F_Pind.Hide;
  end;

  Result := true;
  except
   result:=false;
  end ;


end;

procedure TReportAll1.InitFields;
begin
  inherited;
  F_Name := 'Комплекс "Харьковводооканал" отчет';
  F_ReportFileName := 'ReportAll1.frf';
end;

procedure TReportAll1.PrepareFastReport;
begin
  inherited;
frVariables['ShiftDate']:=DateToStr(f_Dm.ShiftDate);
frvariables['vsego']:=F_DM.vsego;
frVariables['likvid']:=F_DM.likvid;
frVariables['postup']:=F_DM.postup;
frVariables['plan']:=F_DM.plan;
frVariables['planbrig']:=F_DM.planbrig;
frVariables['ShiftDate1']:=DateToStr(f_Dm.ShiftDate-1);
frVariables['excav']:=F_DM.planExcav;

end;

procedure TReportAll1.PrePareResultFormBtns;
begin
 F_PreviewFrm.bb_Mail.Visible := DM_RightsManager.IsCurrentUserDisp;
end;




{ TZvCloseOrder }

procedure TZvCloseOrder.CreateForms;
begin
  inherited;
  F_OptFrm:=CreateOptionForm(Tfrm_OptZvCloseOrder, F_Name) as Tfrm_OptZvCloseOrder;
  F_DM := CreateDataModule(  Tdm_ZvClosedOrder ) as  Tdm_ZvClosedOrder;

  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TZvCloseOrder.Execute: boolean;
begin
   result:=false;
   try
    if F_OptFrm.ShowModal<>mrOk then exit;
    F_Dm.dt1:=F_OptFrm.Date1;
    F_Dm.dt2:=F_OptFrm.Date2;
    F_Pind.Show;
    try
      if F_dm.prepareDsets() then
        PrepareAndPrintFR( F_DM.frReport );
    finally
     F_Pind.Hide;
    end;
    result:=true;
   except
    result:=false;
   end;
end;

procedure TZvCloseOrder.InitFields;
begin
  inherited;
  F_Name := 'Незакрытые заявки с закрытым ордером';
  F_ReportFileName := 'RepOptZvCloseOrder.frf';
end;

procedure TZvCloseOrder.PrepareFastReport;
begin
  inherited;
  frVariables['Date1']:=DateTimeToStr(F_DM.dt1);
  frVariables['Date2']:=DateTimeToStr(F_DM.dt2);

end;

procedure TZvCloseOrder.PrePareResultFormBtns;
begin

end;

end.
