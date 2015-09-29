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
    rnSvodkaGik:           Result := TSvodkaGik.Create;                   //Сводка в ГИК
    rnUtechkiNaVodoseti:   Result := TUtechkiNaVodoseti.Create;           //Утечка воды на водопроводных сетях
    rnVAbonBezVody:        Result := TVAbonBezVody.Create;                //Сводка в абонентный отдел без воды
    rnNODSBezVody:         Result := TNODSBezVody.Create;                 //Сводка без воды начальнику ОДС
    rnUniversalSearch2:    Result := TUniversalSearch2.Create;            //Произвольный поиск
    rnSvodVedLukAndPG:     Result := TSvodVedLukAndPG.Create;             //Ведомость заявок по установке люков и замены пож. гидрантов
    rnNeedAsfalt:          Result := TNeedAsfalt.Create;                  //Ведомость по благоустройству в ГИК
    rnGorSES:              Result := TGorSES.Create;                      //Сводка в ГорСЭС
    rnTrudoZatrat:         Result := TTrudoZatrat.Create;                 //Сводка трудозатрат
    rnVipolNaryad:         Result := TVipolNaryad.Create;                 //Наряды выполненных работ
    rnNetBar:              Result := TNetBar.Create;                      //Сводка вскрытия сети
    rnSvodExcav:           Result := TSvodExcav.Create;                   //Сводка по разрытию
    rnBlagItog:            Result := TBlagItog.Create;                    //Итоговая таблица по благоустройству
    rnSvodka062:           Result := TSvodka062.Create;                   //Сводка по работе с заявками ВДС
    rnBlag2:               Result := TBlag2.Create;                       //Сводка по благоустройству в ГИК №2
    rnBlag3:               Result := TBlag3.Create;                       //Сводка по благоустройству в ГИК №3
    rnPlanDep:             Result := TPlanDep.Create ;                    //План проведения работ
    rnPlanDenial:          Result := TPlanDenial.Create ;                 //невыполненные работы
    rnUseEquip:            Result := TUseEquip.Create ;                   //Использования механизмов при благоустройстве
    rnAvarSit:             Result := TAvarSit.Create ;                    //Информация по аварийным ситуациям
    rnDisconnectKPVoda:    Result := TDisconKPVoda.Create ;               //Сводка отключений  КП ''Харьковводоканал ''
    rnSearch1562:          Result := TSearch1562.Create;                  //Поиск 1562
    rnBlagPodr:            Result := TBlagPodr.Create;                    //Сводка по благоустройству подрядчиками
    rnNaled:               Result := TNaledRep.Create;                    //Сводка по наледи
    rnAVRDisconn:          Result := TAVRDisconnections.Create;           //Отключения в ДКХ
    rnSheben:              Result := TSheben.Create;                      //Сводка выполнения щебенения
    rnPovrRegion:          Result := TPovrRegion.Create;                  //Сводка для Октябрьского РИК
    rnRazrtDep:            Result := TRazrtDep.Create;                    //Сводка по местам разрытия
    rnBlag3GIK:            Result := TBlag3GIK.Create;                    //Сводка по благоустройству в для Кадыгроба
    rnInfBlag:             Result := TInfBlag.Create;                     //Информация по благоустройству
    rnObrZas:              Result := TObrZas.Create;                      //Сводка адресов обратной засыпки
    rnRSvodved:            result:=TRSvoVed.Create;                //Расширенная сводная ведомость
    rnblagRasr:            REsult:=TblagRasr.Create;               //Сводная ведомость по благоустройству разрытий при ликвидации повреждений в системе водоснабжения
    rnPlanTexnik:          REsult:=TsTexnik.Create;                //Сводка задействованной техники при проведении АВР
    rnSPlanWorks:          REsult:=TSPlan_Work.Create;             //План проведения работ по районам
    rnSvPoZayav:           REsult:=TSvPoZayvkam.Create;            //Сводка по заявкам наружные сети
    rnBlagSvod:            REsult:=TBlagSvod.Create;             //График по благоустройству
    rnSodVed_1562ns:       REsult:=TSvodVed_1562ns.Create;             //Сводная ведомость НС с заявками
    rnRepGreenSpring:      REsult:= TRepGreenSpring.Create;      //Сводка "Зеленая весна"
    rnDisconSite:          Result:=TDisconSite.Create;           //Сводка отключений на сайт
    rnREport1321:          Result:=TReport1321.Create;           //Еженедедьный отчет 13.2.1
    rnReport13192:         Result:=TReport13192.Create;           //Еженедедьный отчет 13.19.2
    rnExcavOrderTable:     Result:=TExcavOrderTable.Create;       //Таблица по ордерам
    rnApplicationForSbit:  Result:=TApplicationsForSbit.Create;  //Сводка заявок для сбыта
    rnTDamageBlagObject:   Result:=TDamageBlagObject.Create; //Информация по нарушению благоустройства
    rnGetToDoNar       :   Result:=TGetToDoNar.Create;        //Информация о принятых и выполненных нарядах
    rnAllReport1       :   Result:=TReportAll1.Create;       //Комплекс Харькковводоснабжение отчет
    rnOptZvCloseOrder :    Result:=TZvCloseOrder.Create;     //Незакрытые заявки с закрытым ордером

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
     //вставим отчет
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
