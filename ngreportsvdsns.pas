unit ngreportsvdsns;

interface
uses NGBaseReport,RepSvodVedDModule_vds_new,ResSvodVedForm_vds_new,FrPreviewForm,
NGREports_vds, FR_Class,SysUtils,GlobalData,Controls,WaitProcessForm,HelpFunctions,
OptGetToDoNar,GetToDoNarDMobule,RightsManagerDModule;

type
  TSvodVed_1562ns=class(TSvodVed_vds_2)  {такаяя же rfr SvodVed_vds2}
  private

  protected

    procedure InitFields; override;
    procedure PrepareFastReport; override;


   public
    function Execute: boolean; override;
  end;

  TGetToDoNar=class(TNGBaseReport)  {}
  private
  F_dt_begin, F_dt_end:tDateTime;
    F_OptForm:Tfrm_OptGetToDoNar;
    F_PreviewFrm: Tfrm_FrPreview;
    f_dm:Tdm_GetToDoNar;
     frm_w:Tfrm_WaitProcess;
  protected
    PROCEDURE InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute:boolean ; override;
  end;


implementation

 procedure TSvodVed_1562ns.InitFields;
 begin
   F_Name:='Сводная ведомость 2';
  F_ReportFileName:='SvodVedNSasVDS_2.frf'
 end;

 procedure  TSvodVed_1562ns.PrepareFastReport;
 begin
  frVariables['dt']:=DateToStr(F_DtPrint);
  frVariables['disp']:=F_DM.GetOfficialName(g_IDOfficial);
  frVariables['SnapUser']:=F_DM.SnapUser;
  frVariables['Orgs']:='"НС"' ;
  frVariables['dt_end']:=DateTimeToStr(F_DM.DT_End) ;
   frVariables['dt_beg']:=DateTimeToStr(F_DM.DT_beg) ;



 end;

function TSvodVed_1562ns.Execute:boolean;
 function HappyNewYear(snDate: TDate): boolean;
  var
     _Year_today, _Year_yesterday:string;
  begin
     //
      _Year_yesterday := formatdatetime('yyyy', snDate-1);
      _Year_today := formatdatetime('yyyy', snDate);
      result := _Year_yesterday <> _Year_today;
  end;
   var fl:boolean;

begin
  Result:=false;
  F_OptFrm.frame_SelRegion.Visible:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;


   F_DM.PSetMessage:=frm_w.setMessage;
  try
   F_DM.Dt:=F_OptFrm.Dt;
   F_DM.DT_Beg:=F_OptFrm.Dt+StrToTime('6:00:01');
   F_DM.DT_End:=F_OptFrm.Dt+1+StrToTime('6:00:00');
   F_dm.tip:=0;
   F_DM.Org:=ns;

  F_DM.RegionsID:='';//F_OptFrm.RegionsID;
  MyOpenIBDS(F_DM.dset_tmp,
    ' select count(dt)'+
    ' from SNSHOT_SNAPSHOTS_vds'+
    ' where (dt = '''+ DateToStr(F_DM.Dt) +''') and id_type=3');
  F_DM.dset_tmp.First;
 { if F_DM.dset_tmp.FieldByName('count').AsInteger = 0 then
        F_ResFrm.btn_SnapShot.Enabled := true
        else F_ResFrm.btn_SnapShot.Enabled := false;}
  F_DM.dset_tmp.Close;

  F_DtPrint := F_OptFrm.Dt;
  F_Dm.HappyNewYear:=HappyNewYear(F_OptFrm.Dt);
 // frm_w:=Tfrm_WaitProcess.Create(nil);
  frm_w.show;

 // frm_w.Hide;

  if   F_DM.PrepareDsets_new  then
  begin
     frm_w.hide;
    if F_OptFrm.IsShowPreview then
    begin
      PrepareResultFormBtns;
      if F_ResFrm.ShowModal=mrOK then
        PrepareAndPrintFR(F_DM.frReport);
    end
    else
      PrepareAndPrintFR(F_DM.frReport);
  end;
  finally
     frm_w.hide;
  end;

  Result:=true;

 end;








{ TGetToDoNar }

procedure TGetToDoNar.CreateForms;
begin
  inherited;
  F_DM:=CreateDataModule(Tdm_GetToDoNar) as Tdm_GetToDoNar;
  F_OptForm :=CreateOptionForm(Tfrm_OptGetToDoNar, F_Name) as Tfrm_OptGetToDoNar;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
  frm_w:=Tfrm_WaitProcess.Create(nil);
end;

function TGetToDoNar.Execute: boolean;

begin
   Result:=false;

   if F_optForm.ShowModal<>mrOk then exit;
   try
   frm_w.Show;
   F_dt_begin:=F_optForm.frame_SelDatePeriod1.de_Begin.Date;
   F_dt_end:=F_optForm.frame_SelDatePeriod1.de_End.Date;
   F_dm.Dt_begin:=f_dt_begin;
   F_dm.Dt_end:=F_dt_end;
   F_dm.Table:=F_optForm.selSystem;
   if F_dm.PrePareDset then
       PrepareAndPrintFR(F_DM.frReport);
    Result:=true;   
   finally
     frm_w.Hide;
   end;


end;

procedure TGetToDoNar.InitFields;
begin
  inherited;
  f_name:='Информация о принятых и выполненных нарядах';
  F_ReportFileName:='from_VDS\RepGetToDoNar.frf';
end;

procedure TGetToDoNar.PrepareFastReport;
begin
  inherited;
  frVariables['dt_begin']:=FormatDateTime('dd.mm.yyyy',F_dt_begin);
  frVariables['dt_end']:=FormatDateTime('dd.mm.yyyy',F_dt_end);
  frVariables['disp_name']:=DM_RightsManager.CurrentUserName;
  frVariables['System']:=F_optForm.systemName;
  frVariables['dt_print']:=FormatDateTime('dd.mm.yyyy hh:mm ',Now());

end;

end.
