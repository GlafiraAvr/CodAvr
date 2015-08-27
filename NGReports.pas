unit NGReports;

interface

uses Classes, Controls, Variants, NGBaseReport, SvodkaGikForm, SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm, UtechkiNaVodosetiOptForm,
     UtechkiNaVodosetiDModule, UtechkiNaVodosetiRes, Aligrid, DB, Graphics,
     PeriodRegSelForm, AnalysisViewForm, VAbonBezVodyDModule,
     UniDataExchUnit, DataExchInterfacesUnit, UniversalSearchForm, UniversalSearch2DModule,
     GridViewBuilder, UniSearchResultForm, DatesSelForm, SvodVedLukAndPGDModule,
     ObjListUnit, OptNeedAsfaltForm, RepNeedAsfaltDModule, RepGorSESDModule, PeriodRegSelCBForm,
     OptTrudoZatrat, RepTrudoZatratDModule, RepVipolNaryadDModule,
     OptVipolNaryadForm, OptNetBarForm, RepNetBarDModule, OptSvodExcavForm,
     RepSvodExcavDModule, OptBlagItogForm, RepBlagItogDM, ResNeedAsfaltForm, RepBlagDetailDM,
     Svodka062DModule, OptSvodka062Form, RepBlag2DModule, OptBlag2Form, DateSelForm, RepPlanDepDModule,
     RepPlanDenialDModule, UseEquipDModule, AvarSitDModule, DisconKPVoda, DateSelCBForm,
     Search1562Form, Search1562DModule, Search1562ResultForm, Search1562andOrdersResultForm
     , Order1562Form, BlagPodrDModule, NaledRepDModule , dm_AVRDisconnUnit, DisconAppUnit,
      ExcelWorksForm, dm_ShebenDModuleUnit, RepBlag3DModule, NODSBezVodyDModule, RepPovrRegionDModule,
      RepRazrtDepDModule,Grids,RXDBCtrl,RxMemDS,Seachfor1562DModule,OptInfBlag,RepInfBlagDModule,RepObrZas,OptObrZas,
      OptRSvodVed_ns, DModuleRSvodved, OptBlagRazr,  DModuleSBlagRazr,STexnikDmodule,OptSTexnForm,
      OptPlanWorkForm, SPlanWorkDModule,SvPoZayvkamDModule, OptSvPoZayvkamForm, REpBlag4DModule,
      OptPlanDepForm ,OptAvrDiscon,RepGreenSpringDModule{,RepGreenSpringDModule},ResultDisconSite,DisconSite,
      Report1321,Report1321Opt;

type

  TSvodkaGik=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_SvodkaGik;
    F_DM: Tdm_SvodkaGik;
    F_PreviewFrm: Tfrm_FrPreview;
    F_PreparedReportName,
    F_PreparedTXTReportName,
    F_PreparedReportNameForGen: string;
    F_ReportFileNameForGen,
    F_ReportFileNameForOther: string;
  private
    function Get_Report_Period(dt: TDate): string;
    procedure SaveDataForStDisp(_filename: string);
    function LoadAndPrintTXTReport(fr_rep: TfrReport; prep_name: string; dt: TDate): boolean;
    procedure ShowTXTReport(_FileName: string);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure PrePareResultFormBtns;
  public
    function Execute: boolean; override;
  //  function Execute_Save: boolean;
  end;

  TUtechkiNaVodoseti=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_UtechkiNaVodosetiOpt;
    F_DM: Tdm_UtechkiNaVodoseti;
    F_ResFrm: Tfrm_UtechkiNaVodosetiRes;
    procedure OnShowUtechkaGridFooter(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnShowPodachaCell(ShowValue: variant; var Res: string);
    procedure OnPrintClick(Sender: TObject);
  private
    procedure PrepareUtechkaGrid;
    procedure PreparePodachaGrid;
    procedure PrepareResultForm;
    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TVAbonBezVody=class(TNGBaseReport)
  private
   // F_OptFrm: Tfrm_PeriodRegSel;
    F_OptFrm: Tfrm_PeriodRegSelCB;
    F_DM: Tdm_VAbonBezVody;
    F_ResFrm: Tfrm_AnalysisView;
    F_PreviewFrm: Tfrm_FrPreview;
    procedure OnShowRegHeader(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnShowMonthHeader(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnPrintClick(Sender: TObject);
    procedure OnShowDateCell(ShowValue: variant; var Res: string);
    procedure OnShowTimeCell(ShowValue: variant; var Res: string);
  private
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

 TNODSBezVody=class(TNGBaseReport)
  private
   // F_OptFrm: Tfrm_PeriodRegSel;
    F_OptFrm: Tfrm_PeriodRegSel;
    F_DM: Tdm_NODSBezVody;
    F_ResFrm: Tfrm_AnalysisView;
    F_PreviewFrm: Tfrm_FrPreview;
    procedure OnShowRegHeader(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnShowMonthHeader(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnPrintClick(Sender: TObject);
    procedure OnShowDateCell(ShowValue: variant; var Res: string);
    procedure OnShowTimeCell(ShowValue: variant; var Res: string);
  private
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


  TAVRDisconnections=class(TNGBaseReport)
  private
   // F_OptFrm: Tfrm_PeriodRegSel;
   // F_OptFrm: Tfrm_PeriodRegSelCB;
    F_OptFrm: Tfrm_OptAvrDiscon;
    F_DM: Tdm_AVRDisconn;
    F_ResFrm: TAVRDisconnResultForm;
    F_PreviewFrm: Tfrm_FrPreview;
    procedure OnPrintClick(Sender: TObject); 
    procedure OnSaveData(Sender: TObject);
  private

 //   procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    function GetFileName(var filename :string):string; virtual;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  {Сводка отключения сайт}
  TDisconSite =class (TAVRDisconnections)
   private
    function GetFileName(var filename :string):string; override;
   protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;

  end;




  TUniversalSearch2=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_UniversalSearch;
    F_DM: Tdm_UniversalSearch2;
    F_ResFrm: Tfrm_UniSearchResult;
    F_PreviewFrm: Tfrm_FrPreview;
    F_GVB: TGridViewBuilder;
  private
    procedure OnDamageTypeCellShow(ShowValue: variant; var Res: string);
    procedure OnDiamCellShow(ShowValue: variant; var Res: string);
    procedure OnFlowSpeedCellShow(ShowValue: variant; var Res: string);

    procedure OnGridFixedColClick(Sender: TObject; col: Integer);
    procedure OnGridClick(Sender: TObject);
    procedure OnPrintClick(Sender: TObject);
    procedure OnMapClick(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);dynamic;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormAddInfo;
    procedure BuildResultGridView;
    procedure SetFilterToAom;
    procedure CancelFilterToAom;
  protected
  procedure OnAomTypeOfAvarCellShow(ShowValue: variant; var Res: string);
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSearch1562= class(TNGBaseReport)  // Это будет поиск нарядов 1562
  private
    F_OptFrm: Tfrm_Search1562;
    F_DM: Tdm_Search1562;
 //   F_ResFrm: Tfrm_Search1562Result;
    F_ResFrm: Tfrm_Search1562andOrdersResult;
    F_PreviewFrm: Tfrm_FrPreview;
    F_GVB: TGridViewBuilder;
    procedure OrderTo1562Click(Sender: TObject);
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure RefreshDset;
    procedure RefreshResult;

    procedure NextOrder1562Click(Sender: TObject); //17.11.2011

  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSearchForOrdersFromOtherClasses = class(TUniversalSearch2)
  private
  {  F_DM: Tdm_UniversalSearch2;
    F_ResFrm: Tfrm_UniSearchResult;
    F_PreviewFrm: Tfrm_FrPreview;}
    F_GVB: TGridViewBuilder;
    F_Condition: string;
    F_ShowAll: boolean;
   // F_ResFrm: Tfrm_Search1562andOrdersResult;


    procedure BuildResultGridView;
    procedure OnGridFixedColClick(Sender: TObject; col: Integer);
    procedure Onbtn_SaveClick(Sender: TObject);
  //  procedure OnGridClick(Sender: TObject);
  //  procedure OnPrintClick(Sender: TObject);
    procedure OnNewOrderClick(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormAddInfo;
    procedure RefreshDset;
    procedure PrevNextOrder1562Click(Sender: TObject;inc:integer);
    procedure Otsoed(Sender: TObject);
    procedure NextOrder1562Click(Sender: TObject);
    procedure PreviosOrder1562Click(Sender: TObject);
    procedure init1562(_TRxM:TRxMemoryData);
  protected
    procedure CreateForms; override;
  public
    F_ResFrm:Tfrm_Order1562;
    MainGrid :TCustomControl; //18.11.2011
    property Condition: string read F_Condition write F_Condition;
    property ShowAll: boolean read F_ShowAll write F_ShowAll;
    property _result1562:TRxMemoryData write init1562;
    function Execute: boolean;
    procedure onOrder1562Click(Sender: TObject);
  end;

  TSvodVedLukAndPG=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DatesSel;
    F_DM: Tdm_SvodVedLukAndPG;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TNeedAsfalt=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptNeedAsfalt;
    F_DM: Tdm_RepNeedAsfalt;
    F_PreviewFrm: Tfrm_FrPreview;
    F_ResFrm: Tfrm_ResNeedAsfalt;
    function GetCaption: string;
    procedure PrepareResultForm;
    procedure OnPrintClickHandler( Sender: TObject );
    procedure OnSelDetailHandler( _DetailInfo :TDetailInfo );
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TBlag2=class(TNGBaseReport)
  private
    F_DM: Tdm_RepBlag2;
    F_OptFrm: Tfrm_OptBlag2;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TBlag3=class(TNGBaseReport)
  private
    F_DM: Tdm_RepBlag4;
    F_OptFrm: Tfrm_OptBlag2;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


 TObrZas=class(TNGBaseReport)
  private
    F_DM: Tdm_RepObrZas;
    F_OptFrm: Tfrm_OptObrZas;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TBlag3GIK = class(TBlag3)
  private
  
  protected
    procedure CreateForms; override;
    procedure InitFields; override;
  public
  end;

  TBlagPodr=class(TNGBaseReport)
  private
    F_DM: Tdm_BlagPodr;
    F_OptFrm: Tfrm_PeriodRegSel;//Tfrm_DatesSel;
    F_PreviewFrm: Tfrm_FrPreview; //26.07.2013
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  {19.04.2012}
  TInfBlag=class(TNGBaseReport)
  private
    F_DM: Tdm_NGRepInfBlag;
    F_OptFrm: Tfrm_InfBlag;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;
  {/}

  TSheben=class(TNGBaseReport)
  private
    F_DM: Tdm_ShebenDModule;
    F_OptFrm: Tfrm_PeriodRegSel;//Tfrm_DatesSel;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TNaledRep=class(TNGBaseReport)
  private
    F_DM: Tdm_NaledRep;
    F_OptFrm: Tfrm_PeriodRegSel;//Tfrm_DatesSel;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


  TGorSES=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DatesSel;
    F_DM: Tdm_RepGorSES;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TTrudoZatrat=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptTrudoZatrat;
    F_DM: Tdm_RepTrudoZatrat;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TPlanDep=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptPlanDep;
    F_DM: Tdm_PlanDep;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TPlanDenial=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DatesSel;
    F_DM: Tdm_PlanDenial;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TUseEquip=class(TNGBaseReport)
  private
  {  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск платных нарядов');
  (F_OptionForm as Tfrm_PeriodRegDmgSel).btn_DamagePlace.Visible:=false;
}
    F_OptFrm: Tfrm_PeriodRegSel;
    F_DM: Tdm_UseEquip;
    F_PreviewFrm: Tfrm_FrPreview;
    F_ResFrm: Tfrm_AnalysisView;
    procedure PrepareResultForm;
    procedure OnPrintClick(Sender: TObject);
    procedure OnRegHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TVipolNaryad=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptVipolNaryad;
    F_DM: Tdm_RepVipolNaryad;
    function GetYearName( _DtBeg, _DtEnd: TDateTime ): string;
    function GetMonthName( _DtBeg, _DtEnd: TDateTime ): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TNetBar=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptNetBar;
    F_DM: Tdm_RepNetBar;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TSvodExcav=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptSvodExcav;
    F_ResFrm: Tfrm_AnalysisView;
    F_DM: Tdm_RepSvodExcav;
  private
    procedure OnDmgPlaceHeaderCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnRegHeaderCaption(DataSet: TDataSet;
              AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnPrintClick(Sender: TObject);
    procedure PrepareResultForm;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TBlagItog=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptBlagItog;
    F_DM: Tdm_RepBlagItog;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  //Подотчет для TNeedAsfalt и TBlagItog
  TBlagDetail=class(TNGBaseReport)
  private
    F_DM: Tdm_RepBlagDetail;
    F_ResFrm: Tfrm_AnalysisView;
    F_PreviewFrm: Tfrm_FrPreview;
    F_DetailInfo: TDetailInfo;
    F_SessionID: integer;
    F_ExcType: TExcType;
    F_StartDate,
    F_GranDate,
    F_BeginDate,
    F_EndDate: TDateTime;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    function GetCaption: string;
    procedure OnShowRegHeader(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
    procedure OnPrintClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    property DetailInfo: TDetailInfo read F_DetailInfo write F_DetailInfo;
    property ExcType: TExcType read F_ExcType write F_ExcType;
    property SessionID: integer read F_SessionID write F_SessionID;
    property StartDate: TDateTime read F_StartDate write F_StartDate;
    property GranDate: TDateTime read F_GranDate write F_GranDate;
    property BeginDate: TDateTime read F_BeginDate write F_BeginDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    function Execute: boolean; override;
  end;

  TSvodka062=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_OptSvodka062;
    F_DM: Tdm_Svodka062;
    F_ResFrm: Tfrm_AnalysisView;
    F_PreviewFrm: Tfrm_FrPreview;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure OnPrintClick(Sender: TObject);
    procedure OnClose_ZClick(Sender: TObject);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
    procedure ExcelBtnClick(Sender: TObject);
   public
    function Execute: boolean; override;
  end;

  TAvarSit=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DateSel;
    F_DM: Tdm_AvarSit;
    F_PreviewFrm: Tfrm_FrPreview;
    procedure PrepareResultFormBtns;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


  TDisconKPVoda=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DateSelCB;
    F_DM: Tdm_DisconKPVoda;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;

  TPovrRegion=class(TNGBaseReport)
  private
   // F_OptFrm: Tfrm_OptNetBar;
    F_PreviewFrm: Tfrm_FrPreview;
    F_DM: Tdm_RepPovrRegion;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;    
  public
    function Execute: boolean; override;
  end;

  TRazrtDep=class(TNGBaseReport)
  private
    F_OptFrm: Tfrm_DateSel;
    F_DM: Tdm_RazrtDep;
    F_PreviewFrm: Tfrm_FrPreview;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    function Execute: boolean; override;
  end;


   {TSearchForOrdersFromOtherClasses2 = class(TUniversalSearch2)
  private
    F_DM: Tdm_Seachfor1562;
    {F_ResFrm: Tfrm_UniSearchResult;}
   { F_PreviewFrm: Tfrm_FrPreview;}
   { F_GVB: TGridViewBuilder;
    F_Condition: string;
    F_ShowAll: boolean;
   // F_ResFrm: Tfrm_Search1562andOrdersResult;


    procedure BuildResultGridView;
    procedure OnGridFixedColClick(Sender: TObject; col: Integer);
    procedure Onbtn_SaveClick(Sender: TObject);
  //  procedure OnGridClick(Sender: TObject);
  //  procedure OnPrintClick(Sender: TObject);
    procedure OnNewOrderClick(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormAddInfo;
    procedure RefreshDset;
    procedure PrevNextOrder1562Click(Sender: TObject;inc:integer);
    procedure Otsoed(Sender: TObject);
    procedure NextOrder1562Click(Sender: TObject);
    procedure PreviosOrder1562Click(Sender: TObject);
    procedure init1562(_TRxM:TRxMemoryData);
    procedure OnRegionSelect(Sender: TObject);

  protected
    procedure CreateForms; override;
  public
    F_ResFrm:Tfrm_Order1562;
    MainGrid :TCustomControl; //18.11.2011
    property Condition: string read F_Condition write F_Condition;
    property ShowAll: boolean read F_ShowAll write F_ShowAll;
    property _result1562:TRxMemoryData write init1562;
    function Execute: boolean;
    procedure onOrder1562Click(Sender: TObject);
  end;

  }

   //29.08.2012
  TRSvoVed =class (TNGBaseReport)
  private
   F_optFrm:Tfrm_OptRSvod_ns;
   f_DM:Tdm_RSvodved;
   F_PreviewFrm: Tfrm_FrPreview;
   F_dtbeg,F_dtend:tdatetime;
  protected
  procedure InitFields; override;
  procedure CreateForms; override;
  procedure PrepareFastReport; override;
  public
   function Execute:boolean; override;
  end;

//02.10.2012
 TblagRasr=class (TNGBaseReport)
 private
  F_OptForm:Tfrm_OptBlagRazr;
  F_DM:Tdm_SBlagRazr;
  F_PreviewFrm: Tfrm_FrPreview;
  F_Dt_beg,F_dt_end:tDatetime;
 protected
 procedure InitFields ;override;
 procedure CreateForms; override;
 procedure PrepareFastReport; override;
 public
  function Execute:boolean;override;
 end;


 //18.12.2012
 TSTexnik=class (TNGBaseReport)
 private
   F_OptForm:Tfrm_SOptTexn;
   F_DM:Tdm_STexn;
   f_Dt_beg:TDate;
   F_PreviewFrm: Tfrm_FrPreview;
 protected
  procedure InitFields ;override;
  procedure CreateForms; override;
  procedure PrepareFastReport; override;
 public
  function Execute :boolean; override;
 end;

 //21.01.2013
 TSPlan_Work=class (TNGBaseReport)
  private
   f_OptForm:Tfrm_OptPlanWork;
   F_DM:Tdm_SPlanWork;
   f_Dt:TDate;
   F_PreviewFrm: Tfrm_FrPreview;
   F_Region:String;
   f_REgion_id:integer;

  protected
   procedure InitFields ;override;
   procedure CreateForms; override;
   procedure PrepareFastReport; override;
 public
  function Execute:boolean;override;
 end;

 //18.04.2013 новая сводка по заявкам
 TSvPoZayvkam=class (TNGBaseReport)
  private
   f_OptForm:Tfrm_OptSvPoZayvkam;
   F_DM:Tdm_SvPoZayvkam;
   f_Dt:TDate;
   F_PreviewFrm: Tfrm_FrPreview;
   F_ResFrm: Tfrm_AnalysisView;
   F_Region:String;
   f_REgion_id:integer;
   F_Kolz:integer;
    procedure PrepareResultFormHeader;
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure OnPrintClick(Sender: TObject);
    procedure ONShowHeaderRegion(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
   procedure ONShowHeaderGroup(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
  protected
   procedure InitFields ;override;
   procedure CreateForms; override;
   procedure PrepareFastReport; override;
 public
  function Execute:boolean;override;
 end;

{06.06.2013}
 TBlagSvod = class(TBlag3)
  private
  print_add_asf:boolean;  //22.07.2013
  print_List:boolean;     //22.07.2013
  protected
    procedure InitFields ;override;
    procedure PrepareFastReport; override;
    procedure CreateForms; override;
  public
    function Execute :boolean; override;
  end;
 {28.02.2014}

 TRepGreenSpring =class(TNGBaseReport)
 private
  F_DtCur:TDate;
  F_Dm :Tdm_RepGreenSpring;
  F_OptForm: Tfrm_OptBlag2;
  F_PreviewFrm: Tfrm_FrPreview;
 protected
   procedure  InitFields; override;
   procedure CreateForms; override;
   procedure PrepareFastreport; override;
 public
  function Execute:boolean; override;
 end;

 TReport1321=class(TNGBaseReport)
 private
  f_OptForm: Tfrm_optReport1321;
  F_Dm:Tdm_Report1321;
  F_PreviewFrm: Tfrm_FrPreview;
  F_DtBeg,F_dtEnd:TDate;
 protected
   procedure InitFields; override;
   procedure CreateForms; override;
   procedure PrepareFastreport; override;
 public
  function Execute:boolean; override;
 end;

 TReport13192=class(TReport1321)
 protected
    procedure InitFields; override;

 public
  function Execute:boolean; override;
 end;


implementation

uses ApplicationSettings, Forms, Windows, HelpFunctions, RightsManagerDModule,
      FrPrintDM, Printers, FillReportManager, AomComClientDModule, AomComTypesUnit,
      StringConsts, OrderForm, RootReport,OrderForm_vds, SelectItemForm, WaitProcessForm;

{ TSvodkaGik }

procedure TSvodkaGik.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_SvodkaGik, F_Name) as Tfrm_SvodkaGik;
  F_DM:=CreateDataModule(Tdm_SvodkaGik) as Tdm_SvodkaGik;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
  //F_PreviewFrm.PreviewButtons:=F_PreviewFrm.PreviewButtons+[pbText];
end;

function TSvodkaGik.Execute: boolean;
  procedure _LoadAndPrintReportForAll;
  begin
    if not LoadAndPrintFR(F_DM.frReport, F_PreparedReportName, F_OptFrm.dp_Date.Date) then
      if not LoadAndPrintTXTReport(F_DM.frReport, F_PreparedTXTReportName, F_OptFrm.dp_Date.Date) then
        Application.MessageBox('Сводка за заданное число не найдена!', gc_strDispAVR, MB_OK+MB_ICONERROR)
  end;
var
  _fname1, _fname2, _prep1, _prep2: string;
  is_ok:boolean;
  full_fn,file_name:string;
begin
  Result:=false;

  F_OptFrm.IsShowDopPnl:=DM_RightsManager.IsCurrentUserDisp;
  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.IsForGen := F_OptFrm.IsForGen;
  PrePareResultFormBtns;

  if not DM_RightsManager.IsCurrentUserDisp then
  begin
    if F_OptFrm.IsForGen then
    begin
      if not LoadAndPrintFR(F_DM.frReport, F_PreparedReportNameForGen, F_OptFrm.dp_Date.Date) then
        _LoadAndPrintReportForAll;
    end else
      _LoadAndPrintReportForAll;
  end else
  begin
    if F_OptFrm.IsForGen then
    begin
      _fname1 := F_ReportFileNameForGen;
      _prep1 := F_PreparedReportNameForGen;

      _fname2 := F_ReportFileNameForOther;
      _prep2 := F_PreparedReportName;
    end else
    begin
      _fname1 := F_ReportFileNameForOther;
      _prep1 := F_PreparedReportName;

      _fname2 := F_ReportFileNameForGen;
      _prep2 := F_PreparedReportNameForGen;
    end;

    if (F_OptFrm.IsReCreate) or (not LoadAndPrintFR(F_DM.frReport, _prep1, F_OptFrm.dp_Date.Date)) then
    begin
      F_Pind.Show;
      F_DM.Dt := F_OptFrm.dp_Date.Date;
      F_DM.IsEquipPrint := F_OptFrm.IsEquipPrint;
      F_DM.IsShiftNumberUchit := F_OptFrm.IsShiftNumberUchit;
      F_DM.IsForGen := F_OptFrm.IsForGen;
      is_ok:=F_DM.PrepareDsets;
      F_Pind.Hide;
      if is_ok then
      begin

      {Загрузим форму отчета первого типа, покажем и сохраним отчет}
      F_ReportFileName := _fname1;
      PrepareAndPrintFR( F_DM.frReport );
      SavePreparedReport( F_DM.frReport, _prep1, F_OptFrm.dp_Date.Date );
      {/Загрузим форму отчета первого типа, покажем и сохраним отчет}

      {Загрузим форму отчета второго типа, сформируем и сохраним отчет}
      F_ReportFileName := _fname2;
      if LoadReportFileTo( F_DM.frReport ) then
      begin
        PrepareFastReport;
        SavePreparedReport( F_DM.frReport, _prep2, F_OptFrm.dp_Date.Date );
      end;
      {/Загрузим форму отчета второго типа, сформируем и сохраним отчет}
      end
      else
        Application.MessageBox('Отчет не сохранен!!',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);

      //Сохраним данные для программы старший сменный
      //SaveDataForStDisp(AppSettings.Get_GIK_Path+'st-disp.xml'); glasha 01.08.2012

    end;
  end;
 if F_PreviewFrm.ToMail then
  begin
      F_Pind.Show;
      file_name:=trim('SvodkaGik'+ReplaceChar(DateToStr(Date), '.', '_'));
      full_fn:= AppSettings.Get_Abon_Path + file_name;
      ExportFRToExcelAndSendByEmail(F_DM.frReport,full_fn,'Сводка ГИК',false);
      F_Pind.Hide;
   end;
  Result:=true;
end;


{function TSvodkaGik.Execute_Save: boolean;
 { Pprocedure _LoadAndPrintReportForAll;
  begin
    if not LoadAndPrintFR(F_DM.frReport, F_PreparedReportName, F_OptFrm.dp_Date.Date) then
      if not LoadAndPrintTXTReport(F_DM.frReport, F_PreparedTXTReportName, F_OptFrm.dp_Date.Date) then
        Application.MessageBox('Сводка за заданное число не найдена!', gc_strDispAVR, MB_OK+MB_ICONERROR)
  end;}
{var
  _fname1, _fname2, _prep1, _prep2: string;
begin
  Result:=false;



  F_DM.IsForGen := false;



      _fname1 := F_ReportFileNameForOther;
      _prep1 := F_PreparedReportName;

      _fname2 := F_ReportFileNameForGen;
      _prep2 := F_PreparedReportNameForGen;



    begin
      F_Pind.Show;
      F_DM.Dt := Date()-1;
      F_DM.IsEquipPrint := false;
      F_DM.IsShiftNumberUchit := false;
      F_DM.IsForGen := false;
      F_DM.Simple_PrepareDsets;
      F_Pind.Hide;
      //Сохраним данные для программы старший сменный
      SaveDataForStDisp(AppSettings.Get_GIK_Path+'st-disp.xml');
    end;

  Result:=true;
end;

}

function TSvodkaGik.Get_Report_Period(dt: TDate): string;
begin
  if dt=0 then
    Result:=''
  else
    Result:='c '+DateToStr(dt)+' 6:00:01 по '+DateToStr(dt+1)+' 06:00:00';
end;

procedure TSvodkaGik.InitFields;
begin
  F_Name := 'Сводка в ГИК';

  F_ReportFileNameForOther := 'SvodkaGik.frf';
  F_ReportFileNameForGen := 'SvodkaGikForGen.frf';

  F_PreparedReportName := 'SVODKAGIK';
  F_PreparedTXTReportName := 'SVODKAGIKTXT';
  F_PreparedReportNameForGen := 'SVODKAGIKFORGEN';
end;

function TSvodkaGik.LoadAndPrintTXTReport(fr_rep: TfrReport; prep_name: string;
     dt: TDate): boolean;
var
  _FileName: string;
  _FillRepMgr: Tdm_FillReportManager;
begin
  _FillRepMgr:=Tdm_FillReportManager.Create(nil);
  try
    _FileName:=_FillRepMgr.LoadPreparedRep(prep_name, dt);
    if trim(_FileName)<>'' then
    begin
      ShowTXTReport(_FileName);
      Result:=true;
    end else Result:=false;
  finally
    _FillRepMgr.Free;
  end;
end;

procedure TSvodkaGik.PrepareFastReport;
begin
  frVariables['Period']:=Get_Report_Period(F_OptFrm.dp_Date.Date);
  frVariables['OrderComingCount']:=IntToStr(F_DM.OrderComingCount);
  frVariables['DepartureCount']:=IntToStr(F_DM.DepartureCount);
  frVariables['ClosedOrderCount']:=IntToStr(F_DM.ClosedOrderCount);
  frVariables['ClosedOrderAllCount']:=IntToStr(F_DM.ClosedOrderAllCount);  
  frVariables['Temperature']:=IntToStr(F_DM.Temperature);
  frVariables['ZayvComing']:=IntToStr(F_DM.ZayvComing);
  frVariables['ZayvComin1562']:=IntToStr(F_DM.ZayvComing1562);
  frVariables['ZayvCominpeople']:=IntToStr(F_DM.ZayvComingpeople);

end;

{ TUtechkaNaVodoseti }

procedure TUtechkiNaVodoseti.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_UtechkiNaVodosetiOpt, F_Name) as Tfrm_UtechkiNaVodosetiOpt;
  F_DM:=CreateDataModule(Tdm_UtechkiNaVodoseti) as Tdm_UtechkiNaVodoseti;
  F_ResFrm:=CreateResultForm(Tfrm_UtechkiNaVodosetiRes,
      'Просмотр результатов сводки "'+F_Name+'"') as Tfrm_UtechkiNaVodosetiRes;
end;

function TUtechkiNaVodoseti.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_Pind.Show;

  F_DM.Dt_beg:=F_OptFrm.Dt_beg;
  F_DM.Dt_end:=F_OptFrm.Dt_end;
  if F_DM.PrepareDsets then
  begin
    PrepareResultForm;
    F_ResFrm.ShowModal;
  end;

  F_Pind.Hide;

  Result:=true;
end;

procedure TUtechkiNaVodoseti.InitFields;
begin
  F_Name:='Утечка воды на водопроводных сетях';
  F_ReportFileName:='UtechkaNaVodoseti_1.frf';
end;

procedure TUtechkiNaVodoseti.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TUtechkiNaVodoseti.OnShowPodachaCell(ShowValue: variant;
  var Res: string);
var
  val: integer;
begin
  try
    val:=integer(ShowValue);
  except
    Res:='?';
  end;

  if val=-1 then Res:='?';
end;

procedure TUtechkiNaVodoseti.OnShowUtechkaGridFooter(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  OutRow.Add('Итого:');
  OutRow.Add(IntToStr(F_DM.TotalDamageCount));
  OutRow.Add(FloatToStr(F_DM.TotalEmpting));
  OutRow.Add(FloatToStr(F_DM.TotalLeak_KOl));

  OutRow.Add(FloatToStr(F_DM.TotalUtechka));
  OutRow.Add('100');
end;

procedure TUtechkiNaVodoseti.PrepareFastReport;
var
  str_podacha, str_utechka_percent: string;
begin
  if F_DM.TotalPodacha=-1 then
  begin
    str_podacha:='?';
    str_utechka_percent:='?';
  end else
  begin
    str_podacha:=FormatFloat('0.##', F_DM.TotalPodacha);
    str_utechka_percent:=FormatFloat('0.##', 100*F_DM.TotalUtechka/F_DM.TotalPodacha);
  end;

  frVariables['dt_beg']:=DateToStr(F_OptFrm.Dt_beg);
  frVariables['dt_end']:=DateToStr(F_OptFrm.Dt_end);
  frVariables['Podacha']:=str_podacha;
  frVariables['Utechka']:=FormatFloat('0.##', F_DM.TotalUtechka);
  frVariables['UtechkaPercent']:=str_utechka_percent;
  frVariables['Emting']:=FormatFloat('0.##', F_DM.TotalEmpting);
  frVariables['Utechka_kol']:=FormatFloat('0.##', F_DM.TotalLeak_KOl);


end;

procedure TUtechkiNaVodoseti.PreparePodachaGrid;
var
  gvb: TGridViewBuilder;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_Podacha, F_ResFrm.grd_Podacha);
  try
    AddColToGVB(gvb, 'Donec', 'ПУВХ "Донец"', alCenter, OnShowPodachaCell);
    AddColToGVB(gvb, 'Lednoe', 'Ледное', alCenter, OnShowPodachaCell);
    AddColToGVB(gvb, 'SAVH', 'САВХ', alCenter, OnShowPodachaCell);
    AddColToGVB(gvb, 'Itogo', 'Итого', alCenter, OnShowPodachaCell);

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TUtechkiNaVodoseti.PrepareResultForm;
var
  str_podacha, str_utechka_percent: string;
begin
  {Оформляем Grid-ы на результирующей форме}
  PreparePodachaGrid;
  PrepareUtechkaGrid;
  {/Оформляем Grid-ы на результирующей форме}

  {Оформляем информативные поля}
  if F_DM.TotalPodacha=-1 then
  begin
    str_podacha:='?';
    str_utechka_percent:='?';
  end else
  begin
    str_podacha:=FormatFloat('0.##', F_DM.TotalPodacha);
    //str_utechka_percent:=round(10000*F_DM.TotalUtechka/F_DM.TotalPodacha)/100;
    str_utechka_percent:=FormatFloat('0.##', 100*F_DM.TotalUtechka/F_DM.TotalPodacha);
  end;

  with F_ResFrm do
  begin
    strPodachaHeader:=Format('Подача воды на город в м3 с %s по %s',
                    [DateTimeToStr(F_OptFrm.Dt_beg), DateTimeToStr(F_OptFrm.Dt_end)]);
    strUtechkaHeader:=Format('Утечка за период с %s по %s',
                    [DateTimeToStr(F_OptFrm.Dt_beg), DateTimeToStr(F_OptFrm.Dt_end)]);
    strPodacha:='Подача воды: '+str_podacha+' м3';
    strUtechka:='Утечка: '+FormatFloat('0.##', F_DM.TotalUtechka)+' м3';
    strUtechkaPercent:='Процент утечки к поданной воде: '+str_utechka_percent+'%';
  end;
  {/Оформляем информативные поля}

  {Оформляем кнопки}
  PrepareResultFormBtns
  {/Оформляем кнопки}
end;

procedure TUtechkiNaVodoseti.PrepareResultFormBtns;
begin
  F_ResFrm.OnPrintClick:=OnPrintClick;
end;

procedure TUtechkiNaVodoseti.PrepareUtechkaGrid;
var
  gvb: TGridViewBuilder;
  group: TGroup;
begin
  gvb:=TGridViewBuilder.Create(F_DM.md_Utechka, F_ResFrm.grd_Utechka);
  try
    AddColToGVB(gvb, 'region', 'Район', alLeft);
    AddColToGVB(gvb, 'damage_count', 'Кол-во повреждений', alCenter);
    AddcolToGVB(gvb, 'empting', 'Опорожнение,м3' , alCenter);
    AddColToGVB(gvb, 'leak_kol','Утечка на в/колонки',alCenter);
    AddColToGVB(gvb, 'leak', 'Утечка,м3', alCenter);
    AddColToGVB(gvb, 'leak_percent', '% утечки', alCenter);

    group:=gvb.AddGroup('main_gr');
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=true;
    group.GroupFooter.Alignment:=alCenter;
    group.GroupFooter.Color:=clYellow;
    group.GroupFooter.Font.Style:=[fsBold];
    group.GroupFooter.OnShowCaption:=OnShowUtechkaGridFooter;

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TSvodkaGik.PrePareResultFormBtns;
begin
F_PreviewFrm.bb_Mail.Visible:=true;
end;

procedure TSvodkaGik.SaveDataForStDisp(_filename: string);
var
  _t: TUniDataExch;
  _vp: TNameValuePair;
  _enum: IEnumerator;
  _da: IDataAccess;
begin
  _t := TUniDataExch.Create;
  _da := _t;
  _enum := _t.Buf;
  try
    _da.SetFileName(_filename);
    _enum.Clear;
    //
    with F_DM.DataForStDisp do
    begin
      _vp.name := 'VodoSetiVsego'; _vp.value := IntToStr(VodoSetiVsego); _enum.Add(_vp);
      _vp.name := 'VvodyVsego'; _vp.value := IntToStr(VvodyVsego); _enum.Add(_vp);
      _vp.name := 'KolodtsyVsego'; _vp.value := IntToStr(KolodtsyVsego); _enum.Add(_vp);
      _vp.name := 'KolonkiVsego'; _vp.value := IntToStr(KolonkiVsego); _enum.Add(_vp);
      _vp.name := 'LikvidNaVodoSetyax'; _vp.value := IntToStr(LikvidNaVodoSetyax); _enum.Add(_vp);
      _vp.name := 'LikvidNaVvodax'; _vp.value := IntToStr(LikvidNaVvodax); _enum.Add(_vp);
      _vp.name := 'UstanLukov'; _vp.value := IntToStr(UstanLukov); _enum.Add(_vp);
      _vp.name := 'PostupNaVodoSetyax'; _vp.value := IntToStr(PostupNaVodoSetyax); _enum.Add(_vp);
      _vp.name := 'PostupNaVvodax'; _vp.value := IntToStr(PostupNaVvodax); _enum.Add(_vp);
      //
      _vp.name := 'More_TechejIzZemli'; _vp.value := IntToStr(TechejIzZemli); _enum.Add(_vp);
      _vp.name := 'More_TecheyIzKolodtsev'; _vp.value := IntToStr(TecheyIzKolodtsev); _enum.Add(_vp);
      _vp.name := 'More_NeispravnyxKolonok'; _vp.value := IntToStr(NeispravnyxKolonok); _enum.Add(_vp);
      //
      _vp.name := 'More_Likvidirovano'; _vp.value := IntToStr(Likvidirovano); _enum.Add(_vp);
      _vp.name := 'More_IzNihZasypano'; _vp.value := IntToStr(IzNihZasypano); _enum.Add(_vp);
      _vp.name := 'More_IzNihNeZasypano'; _vp.value := IntToStr(IzNihNeZasypano); _enum.Add(_vp);
      _vp.name := 'More_Postupilo'; _vp.value := IntToStr(Postupilo); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Vsego'; _vp.value := IntToStr(NeZasypanoPoGorodu_Vsego); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Dzerzh'; _vp.value := IntToStr(NeZasypanoPoGorodu_Dzerzh); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Komintern'; _vp.value := IntToStr(NeZasypanoPoGorodu_Komintern); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Ordzhon'; _vp.value := IntToStr(NeZasypanoPoGorodu_Ordzhon); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Kiev'; _vp.value := IntToStr(NeZasypanoPoGorodu_Kiev); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Moskov'; _vp.value := IntToStr(NeZasypanoPoGorodu_Moskov); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Frunz'; _vp.value := IntToStr(NeZasypanoPoGorodu_Frunz); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Lenin'; _vp.value := IntToStr(NeZasypanoPoGorodu_Lenin); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Oktjabr'; _vp.value := IntToStr(NeZasypanoPoGorodu_Oktjabr); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Chervon'; _vp.value := IntToStr(NeZasypanoPoGorodu_Chervon); _enum.Add(_vp);
      //
      _vp.name := 'More_UstanovlenoLukov'; _vp.value := IntToStr(UstanovlenoLukov); _enum.Add(_vp);
      _vp.name := 'More_UstanovlenoGidrantov'; _vp.value := IntToStr(UstanovlenoGidrantov); _enum.Add(_vp);
      _vp.name := 'More_CountGet062'; _vp.value := IntToStr(CountGet062); _enum.Add(_vp);
      _vp.name := 'More_CountClose062'; _vp.value := IntToStr(CountClose062); _enum.Add(_vp);
      _vp.name := 'More_CountLeft062'; _vp.value := IntToStr(CountLeft062); _enum.Add(_vp);
    end;
      _vp.name := 'OrderComingCount'; _vp.value := IntToStr(F_DM.OrderComingCount); _enum.Add(_vp);
      _vp.name := 'ClosedOrderCount'; _vp.value := IntToStr(F_DM.ClosedOrderCount); _enum.Add(_vp);
     // _vp.name := 'NotClosedOrderCount'; _vp.value := '0'; _enum.Add(_vp);

    //
    _da.Write(_enum, 'dt_' + DateToStr(F_OptFrm.dp_Date.Date));
    _da := nil;
    _enum := nil;
  except
    on E:Exception do
      raise Exception.Create('Ошибка при сохранении в файл '#13 + _filename +#13 +
        ' для программы "Старший сменный"' + #13 + E.Message);
  end;
end;

procedure TSvodkaGik.ShowTXTReport(_FileName: string);
  procedure ChangeCaption(AStrList: TStringList); //Nut
  var
    pstr1,pstr2:PAnsiChar;
  begin
    AStrList.Delete(0);
    AStrList.Delete(0);
    pstr1:='                         Сводная ведомость';
    pstr2:=AllocMem(Length(pstr1)+1);
    CharToOem(pstr1,pstr2);
    AStrList.Insert(0,pstr2);
    FreeMem(pstr2);
    pstr1:='                      Генеральному директору';
    pstr2:=AllocMem(Length(pstr1)+1);
    CharToOem(pstr1,pstr2);
    AStrList.Insert(1,pstr2);
    FreeMem(pstr2);
    pstr1:='                    ТПО "КП ПТП ВОДА"';
    pstr2:=AllocMem(Length(pstr1)+1);
    CharToOem(pstr1,pstr2);
    AStrList.Insert(2,pstr2);
    FreeMem(pstr2);
    pstr1:='           отказов в системе распределения воды г.ХАРЬКОВА';
    pstr2:=AllocMem(Length(pstr1)+1);
    CharToOem(pstr1,pstr2);
    AStrList.Insert(3,pstr2);
  end;
var
  DM_Print: TDM_Print;
  _strl:TStringList;
  i,l,i1, _pg_size:integer;
  _s,_s1:string;
begin
  DM_Print:=TDM_Print.Create(nil);
  _strl:=TStringList.Create;
  try
    _pg_size := DM_Print.frReport1.Pages[0].pgSize;
    DM_Print.frReport1.Pages[0].pgOr := poPortrait;
    DM_Print.frReport1.Pages[0].ChangePaper(_pg_size,2100,2970,0,poPortrait);

    _strl.LoadFromFile(_FileName);
    if F_OptFrm.IsForGen then
      ChangeCaption(_strl);
    for i:=0 to _strl.count-1 do
      begin
        _s:=_strl.strings[i]; _s1:=_strl.strings[i];
        l:=length(_s1);
        for i1:=1 to l do
          if (_s1[i1]<#32) then
            begin
              _s1[i1]:=#32;
              if i1+1<=l then
                begin
                  if (i1+2<=l) and
                    ((AnsiUpperCase(_s1[i1+1])='W') or (AnsiUpperCase(_s1[i1+1])='X'))
                  then _s1[i1+2]:=#32;
                  _s1[i1+1]:=#32;
                end;
            end;
        _strl.strings[i]:=_s1;
      end;
    //
    i := 0;
    l := _strl.Count;
    while i<l do
    begin
      if trim(_strl.strings[i])='' then
      begin
        _strl.Delete(i);
        dec(l);
      end
        else inc(i);
    end;
    //
    DM_Print.PrintStrings:=_strl;
    DM_Print.ShowReport;
  finally
    _strl.Free;
    DM_Print.Free;
  end;
end;

{TAvarSit}

procedure TAvarSit.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_DateSel, F_Name ) as Tfrm_DateSel;
  F_DM := CreateDataModule( Tdm_AvarSit ) as Tdm_AvarSit;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TAvarSit.InitFields;
begin
  F_Name := 'Информация по аварийным ситуациям';
  F_ReportFileName := 'AvarSit.frf';

end;

procedure TAvarSit.PrepareFastReport;
var sDtIn:string;
begin
  sDtIn:=DateToStr(F_OptFrm.dp_Date.Date);
  frVariables['Caption']:='Информация по аварийным ситуациям на водопроводных сетях г.Харькова по состоянию на '+
      sDtIn ;
  frvariables['dateform']:=DateToStr(F_DM.DtBeg);
end;

function TAvarSit.Execute: boolean;
var  file_name, full_fn:string;
     _Frm_Wait:Tfrm_WaitProcess;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date.Date;
    F_DM.PrepareDset;
    F_Pind.Hide;
    PrepareResultFormBtns;
    PrepareAndPrintFR( F_DM.frReport );
    if   F_PreviewFrm.ToMail then
     begin

       file_name:=trim('AVR_Sit'+ReplaceChar(DateToStr(Date), '.', '_'))+ '.xls';
       full_fn:= AppSettings.Get_Abon_Path + file_name;
       if   F_Dm.ExportFRToExcel(F_DM.frReport, full_fn ) then
       begin

        SendByEmail( full_fn
            , 'Информация по аварийным ситуациям на водопроводных сетях г.Харькова по состоянию на'+DateToStr(F_DM.DtBeg)            );
        F_Dm.SaveAfterSend(file_name);
       end
     end;
  end;
end;

procedure TAvarSit.PrepareResultFormBtns;
begin



  F_PreviewFrm.bb_Mail.Visible := DM_RightsManager.IsCurrentUserDisp; //14.06.2013
 // F_ResFrm.btSendAndSave.Caption:='Печать сводки и автоматический посыл по e-mail';
 F_PreviewFrm.NeedAsk:=true;
end;


{/TAvarSit}


{ TVAbonBezVody }

procedure TVAbonBezVody.CreateForms;
begin
 // F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSel, F_Name) as Tfrm_PeriodRegSel;
// Tfrm_PeriodRegSelCB
  F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSelCB, F_Name) as Tfrm_PeriodRegSelCB;
  F_ResFrm:=CreateResultForm(Tfrm_AnalysisView, F_Name) as Tfrm_AnalysisView;
  F_DM:=CreateDataModule(Tdm_VAbonBezVody) as Tdm_VAbonBezVody;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TVAbonBezVody.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_Pind.Show;
  F_DM.NCDP:= F_OptFrm.CB.Checked;
  F_Dm.All:=F_OptFrm.CB_ALL.Checked;
  F_DM.Dt_beg:=F_OptFrm.dp_Date1.Date;
  F_DM.Dt_end:=F_OptFrm.dp_Date2.Date;
  F_DM.strRegionsID:=F_OptFrm.RegionsID;
  F_Dm.Streets:=F_OptFrm.StreetsID;
  if F_DM.PrepareDsets then
  begin
    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
    F_ResFrm.ShowModal;
  end;

  F_Pind.Hide;

  Result:=true;
end;

procedure TVAbonBezVody.InitFields;
begin
  F_Name:='Сводка отключений в департамент "Водосбыт"';
  F_ReportFileName:='VAbonBezVodyDiscon.frf';
//  F_ReportFileName:='VAbonBezVodyNG.frf';
end;

procedure TVAbonBezVody.OnPrintClick(Sender: TObject);
var
  file_name: string;
begin
  PrepareAndPrintFR(F_DM.frReport);

  if DM_RightsManager.IsCurrentUserDisp then
  begin
    {Отправка по почте}
    //if Application.MessageBox('Отправить сформированную ведомость по почте?',
    //    PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    'bez_vody_'+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
      //ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
    end;
    {/Отправка по почте}
  end;
end;

procedure TVAbonBezVody.OnShowDateCell(ShowValue: variant;
  var Res: string);
var
  dt: TDate;
begin
 if VarIsNull(ShowValue) then Res := ''
 else
  try
    dt:=TDate(ShowValue);
    Res:=DateToStr(dt);
  except
    Res:='';
  end;
end;

procedure TVAbonBezVody.OnShowRegHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(NameCase(trim(DataSet.FieldByName('regions').AsString)));
end;

procedure TVAbonBezVody.OnShowMonthHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do OutRow.Add('');
  OutRow.Add(NameCase(trim(DataSet.FieldByName('Month').AsString)));
end;

procedure TVAbonBezVody.OnShowTimeCell(ShowValue: variant;
  var Res: string);
var
  tm: TTime;
begin

 if VarIsNull(ShowValue) then Res := ''
 else
  try
    tm:=TTime(ShowValue);
    Res:=TimeToStr(tm);
  except
    Res:='';
  end;
end;

procedure TVAbonBezVody.PrepareFastReport;
begin
  frVariables['dt_beg']:=DateToStr(F_OptFrm.dp_Date1.Date);
  frVariables['dt_end']:=DateToStr(F_OptFrm.dp_Date2.Date);
  frVariables['regions']:=F_OptFrm.strRegions;
  frVariables['streets']:=F_OptFrm.StreeetsName;
  if F_OptFrm.CB.Checked then
          begin
            frVariables['den_ch']:='Суток';
            frVariables['cb_cap']:=' отключений КП "Харьковводоканал"';
          end
            else
            begin
             frVariables['cb_cap']:=' отключений КП "Харьковводоканал" ';
//             frVariables['cb_cap']:=' в абонотдел без воды';
             frVariables['den_ch']:='Часов';
            end;
end;

procedure TVAbonBezVody.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;

  F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_Print.Caption:='Печать сводки и автоматический посыл по e-mail';
end;

procedure TVAbonBezVody.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  group: TGroup;
  col: TGBColumn;
begin
//  gvb:=TGridViewBuilder.Create(F_DM.md_res, F_ResFrm.Grid);
  gvb:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
  try
    gvb.IDFieldName:='id';

    col:=AddColToGVB(gvb, 'Disconadres', 'Адреса отключения', alLeft);
    col.DisplayWidth:=60;

    if F_OptFrm.CB.Checked then AddColToGVB(gvb, 'Hours', 'Суток'+#13+'без воды', alCenter)
        else
          AddColToGVB(gvb, 'Hours', 'Часов'+#13+'без воды', alCenter);

    AddColToGVB(gvb, 'dttm_discon', 'Дата'+#13+'откл.', alCenter, OnShowDateCell);
    AddColToGVB(gvb, 'dttm_discon', 'Время'+#13+'откл.', alCenter, OnShowTimeCell);
    AddColToGVB(gvb, 'dttm_con', 'Дата'+#13+'вкл.', alCenter, OnShowDateCell);
    AddColToGVB(gvb, 'dttm_con', 'Время'+#13+'вкл.', alCenter, OnShowTimeCell);

    AddColToGVB(gvb, 'mCount', 'Кол-во'+#13+'больше'+#13+'6 часов', alCenter);
    AddColToGVB(gvb, 'OrderNumber', 'Номер'+#13+'наряда', alCenter);
    AddColToGVB(gvb, 'Adres', 'Адрес', alLeft);
    AddColToGVB(gvb, 'DateComing', 'Дата'+#13+'поступления'+#13+'наряда', alCenter, OnShowDateCell);

    group:=gvb.AddGroup('main_gr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=gvb.AddGroup('Month');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Color:=clMoneyGreen;
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnShowMonthHeader;


    group:=gvb.AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnShowRegHeader;

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TVAbonBezVody.PrepareResultFormHeader;
begin
  if F_OptFrm.CB.Checked then F_ResFrm.Caption:='Сводка отключений по наружным  водопроводным сетям'
    else F_ResFrm.Caption:='Сводка отключений КП "Харьковводоканал" по наружным водопроводным сетям ';;
  F_ResFrm.CenterLabel:= F_ResFrm.Caption+#13+
//  F_ResFrm.CenterLabel:='Сводка в абонентный отдел без воды'+#13+
                         'за период с '+DateToStr(F_OptFrm.dp_Date1.Date)+
                         ' по '+DateToStr(F_OptFrm.dp_Date2.Date);
  F_ResFrm.LeftLabel:='Район: '+F_OptFrm.strRegions+#13+'Улицы: '+F_OptFrm.StreeetsName;
  F_ResFrm.pnl_Top.Height:=F_ResFrm.pnl_Top.Height+15;
  F_ResFrm.lbl_Left.Height:=F_ResFrm.lbl_Left.Height+15;

end;



{ TNODSBezVody }

procedure TNODSBezVody.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSel, F_Name) as Tfrm_PeriodRegSel;
  //F_OptFrm:=CreateOptionForm(Tfrm_PeriodRegSelCB, F_Name) as Tfrm_PeriodRegSelCB;
  F_ResFrm:=CreateResultForm(Tfrm_AnalysisView, F_Name) as Tfrm_AnalysisView;
  F_DM:=CreateDataModule(Tdm_NODSBezVody) as Tdm_NODSBezVody;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TNODSBezVody.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_Pind.Show;
  F_DM.NCDP := true;
  F_DM.Dt_beg:=F_OptFrm.dp_Date1.Date;
  F_DM.Dt_end:=F_OptFrm.dp_Date2.Date;
  F_DM.strRegionsID:=F_OptFrm.RegionsID;
  if F_DM.PrepareDsets then
  begin
    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
    F_ResFrm.ShowModal;
  end;

  F_Pind.Hide;

  Result:=true;
end;

procedure TNODSBezVody.InitFields;
begin
  F_Name:='Сводка отключений начальнику диспетчерской службы';
  F_ReportFileName:='NODSBezVody.frf';
end;

procedure TNODSBezVody.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TNODSBezVody.OnShowDateCell(ShowValue: variant;
  var Res: string);
var
  dt: TDate;
begin
 if VarIsNull(ShowValue) then Res := ''
 else
  try
    dt:=TDate(ShowValue);
    Res:=DateToStr(dt);
  except
    Res:='';
  end;
end;

procedure TNODSBezVody.OnShowRegHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add(NameCase(trim(DataSet.FieldByName('regions').AsString)));
end;

procedure TNODSBezVody.OnShowMonthHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 3 do OutRow.Add('');
  OutRow.Add(NameCase(trim(DataSet.FieldByName('Month').AsString)));
end;

procedure TNODSBezVody.OnShowTimeCell(ShowValue: variant;
  var Res: string);
var
  tm: TTime;
begin

 if VarIsNull(ShowValue) then Res := ''
 else
  try
    tm:=TTime(ShowValue);
    Res:=TimeToStr(tm);
  except
    Res:='';
  end;
end;

procedure TNODSBezVody.PrepareFastReport;
begin
  frVariables['dt_beg']:=DateToStr(F_OptFrm.dp_Date1.Date);
  frVariables['dt_end']:=DateToStr(F_OptFrm.dp_Date2.Date);
  frVariables['regions']:=F_OptFrm.strRegions;
  frVariables['den_ch']:='Суток';
  frVariables['cb_cap']:=' перекрытия задвижек с перечнем отключенных абонентов';// ПУВХ "Харьков"';
end;

procedure TNODSBezVody.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;

  F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_Print.Caption:='Печать сводки';
end;

procedure TNODSBezVody.PrepareResultFormGrid;
var
  gvb: TGridViewBuilder;
  group: TGroup;
  col: TGBColumn;
begin
//  gvb:=TGridViewBuilder.Create(F_DM.md_res, F_ResFrm.Grid);
  gvb:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
  try
    gvb.IDFieldName:='id';

    AddColToGVB(gvb, 'DateComing', 'Дата'+#13+'поступления', alCenter, OnShowDateCell);
    AddColToGVB(gvb, 'OrderNumber', 'Номер'+#13+'наряда', alCenter);
    AddColToGVB(gvb, 'Adres', 'Адрес места повреждения', alLeft);

    col:=AddColToGVB(gvb, 'BoltAdres', 'Адреса отключения', alLeft);
   // col.DisplayWidth:=60;

    AddColToGVB(gvb, 'diameter', 'Диаметр', alCenter);

    AddColToGVB(gvb, 's_dt_bolt_close', 'Дата/время'+#13+'закр.задв.', alCenter);
    AddColToGVB(gvb, 's_dt_bolt_open', 'Дата/время'+#13+'откр.задв.', alCenter);
//    AddColToGVB(gvb, 'Hours', 'Суток'+#13+'откл.', alCenter);
    AddColToGVB(gvb, 's_hours', 'Суток'+#13+'откл.', alCenter);
{
    AddColToGVB(gvb, 'dt_bolt_close', 'Дата'+#13+'закр.задв.', alCenter, OnShowDateCell);
    AddColToGVB(gvb, 'dt_bolt_close', 'Время'+#13+'закр.задв.', alCenter, OnShowTimeCell);
    AddColToGVB(gvb, 'dt_bolt_open', 'Дата'+#13+'откр.задв.', alCenter, OnShowDateCell);
    AddColToGVB(gvb, 'dt_bolt_open', 'Время'+#13+'откр.задв.', alCenter, OnShowTimeCell);
}
//    AddColToGVB(gvb, 'mCount', 'Кол-во'+#13+'больше 6'+#13+'часов', alCenter);

    group:=gvb.AddGroup('main_gr');
    group.IsNumberRecordInGroup:=true;
    group.GroupHeader.Visible:=false;
    group.GroupFooter.Visible:=false;

    group:=gvb.AddGroup('fk_orders_regions');
    group.IsNumberRecordInGroup:=true;
    group.GroupFooter.Visible:=false;
    group.GroupHeader.Visible:=true;
    group.GroupHeader.Font.Style:=[fsBold];
    group.GroupHeader.Color:=clAqua;
    group.GroupHeader.Alignment:=alCenter;
    group.GroupHeader.OnShowCaption:=OnShowRegHeader;

    gvb.BuildGridView;
  finally
    gvb.Free;
  end;
end;

procedure TNODSBezVody.PrepareResultFormHeader;
begin
  F_ResFrm.Caption:='Сводка отключений начальнику диспетчерской службы';
  F_ResFrm.CenterLabel:= F_ResFrm.Caption+#13+
                         'за период с '+DateToStr(F_OptFrm.dp_Date1.Date)+
                         ' по '+DateToStr(F_OptFrm.dp_Date2.Date);
  F_ResFrm.LeftLabel:='Район: '+F_OptFrm.strRegions;
end;


{ TUniversalSearch2 }

procedure TUniversalSearch2.BuildResultGridView;
var
  _ColorColNumber: integer;
begin
  F_GVB.BuildGridView;

  case F_DM.SortType of
    stOrderNumberAndDatecoming: _ColorColNumber:=2;
    stRegions: _ColorColNumber:=4;
    stAdres: _ColorColNumber:=5;
  end;
  F_ResFrm.Grid.ColorCell[_ColorColNumber, 0]:=clSkyBlue;
end;

procedure TUniversalSearch2.CancelFilterToAom;
begin
//  if DM_AomComClient.IsMapWork then DM_AomComClient.AomClientManager.CancelExternalAvarIDFilter;
end;

procedure TUniversalSearch2.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_UniversalSearch, F_Name) as Tfrm_UniversalSearch;
  F_ResFrm:=CreateResultForm(Tfrm_UniSearchResult, F_Name) as Tfrm_UniSearchResult;
  F_DM:=CreateDataModule(Tdm_UniversalSearch2) as Tdm_UniversalSearch2;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TUniversalSearch2.Execute: boolean;
var
  rec_count: integer;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.strStartDate:=F_OptFrm.strStartDate;
  F_DM.strFinishedDate:=F_OptFrm.strFinishedDate;
  F_DM.IsCalcLeak:=F_OptFrm.IsCalcLeak;
  F_DM.Condition:=F_OptFrm.ResultCondition;
  F_DM.SortType:=stOrderNumberAndDatecoming;
  F_DM.IsAscSort:=true;

  F_DM.StartTransaction;
  try
    rec_count:=F_DM.GetRecordCount;
    if rec_count<=0 then
    begin
      Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Произвольный поиск', MB_OK+MB_ICONINFORMATION);
    end else
    begin
      if Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Произвольный поиск', MB_YESNO+MB_ICONQUESTION)=ID_YES then
      begin
        F_Pind.Show;
        F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
        try
          F_DM.PrepareDset;
 //         if DM_AomComClient.IsMapWork then SetFilterToAom;
          PrepareResultFormBtns;
          PrepareResultFormGrid;
          PrepareResultFormAddInfo;
          F_ResFrm.ShowModal;
        finally
          F_GVB.Free;
        end;
        F_Pind.Hide;
      end;
    end;
  finally
    F_DM.StopTransaction;
  end;

//  if DM_AomComClient.IsMapWork then CancelFilterToAom;

  Result:=true;
end;

procedure TUniversalSearch2.InitFields;
begin
  F_Name:='Произвольный поиск';
  F_Pind.CancelButton:=false;
  F_Pind.OnCancel:=nil;
end;

procedure TUniversalSearch2.OnAomTypeOfAvarCellShow(ShowValue: variant;
  var Res: string);
begin
 {if VarIsNull(ShowValue) then Res := ''
 else
  if DM_AomComClient.IsMapWork then
    Res:=NameCase( DM_AomComClient.ConvertTypeOfAvarToStr(TAomTypeOfAvar(ShowValue)) )
  else      }
    Res:='';
end;

procedure TUniversalSearch2.OnDamageTypeCellShow(ShowValue: variant;
  var Res: string);
begin
  if trim(AnsiUpperCase(VarToString(ShowValue)))='<ПУСТО>' then
    Res:='';
end;

procedure TUniversalSearch2.OnDiamCellShow(ShowValue: variant;
  var Res: string);
begin
  if VarToFloat(ShowValue)=0 then
    Res:='';
end;

procedure TUniversalSearch2.OnFlowSpeedCellShow(ShowValue: variant;
  var Res: string);
var
  val: double;
begin
  val:=VarToFloat(ShowValue);
  if val=0 then
    Res:=''
  else
    Res:=FormatFloat('0.####', val);
end;

procedure TUniversalSearch2.OnGridClick(Sender: TObject);
var
  pReg: TPRegionRec;
begin
  with F_ResFrm do
  begin
    if Assigned(Grid.Objects[1, Grid.Row]) then
    begin
      pReg:=TPRegionRec(Grid.Objects[1, Grid.Row]);
      Region:=pReg.name;
      DmgCount:=pReg.dmg_count;
      RegionLeak:=pReg.leak;
    end;
  end;
end;

procedure TUniversalSearch2.OnGridFixedColClick(Sender: TObject;
  col: Integer);
begin
  case col of
    2: F_DM.SortType:=stOrderNumberAndDatecoming;
    4: F_DM.SortType:=stRegions;
    5: F_DM.SortType:=stAdres;
  end;

  if col in [2,4,5] then
  begin
    F_Pind.Show;
    F_ResFrm.StartWait;
    try
      F_DM.PrepareDset;
      BuildResultGridView;
    finally
      F_Pind.Hide;
      F_ResFrm.StopWait;
    end;
  end;
end;

procedure TUniversalSearch2.OnMapClick(Sender: TObject);
var
  _AvarIDAndAddrList: TObjList;
begin
 { F_ResFrm.StartWait;
  try
    _AvarIDAndAddrList:=TObjList.Create;
    try
      F_DM.FillAvarIDAndAddrList(_AvarIDAndAddrList);
      DM_AomComClient.AomClientManager.RazmetitByAvarIDAndAddr( _AvarIDAndAddrList );
      F_DM.SetAomTypeOfAvarInResultDset;
      BuildResultGridView;
    finally
      _AvarIDAndAddrList.Free;
    end;
  finally
    F_ResFrm.StopWait;
  end;}
end;

procedure TUniversalSearch2.OnOrderClick(Sender: TObject);
var
  _OrderID: integer;
  _frm_Order: Tfrm_Order;
begin
  with F_ResFrm do
  begin
    StartWait;
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _OrderID := integer(Grid.Objects[0, Grid.Row]);
        _frm_Order := Tfrm_Order.Create( nil, _OrderID );
        StopWait;
        try
          _frm_Order.ShowModal;
          if _frm_Order.IsCtrlChange then
            Grid.RowFont[ Grid.Row ].Color := clRed;
   {       if DM_AomComClient.IsMapWork then
            Grid.Cells[ 1, Grid.Row ] := NameCase( DM_AomComClient.ConvertTypeOfAvarToStr( _frm_Order.AomTypeOfAvar ) );}
        finally
          _frm_Order.Free;
        end;
      end;
    except
      StopWait;
      raise;
    end;
  end;
end;

procedure TUniversalSearch2.OnPrintClick(Sender: TObject);
begin
  if F_ResFrm.IsPrintAddInfo then F_ReportFileName:='UniversalSearch2_2.frf'
  else F_ReportFileName:='UniversalSearch2_1.frf';

  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TUniversalSearch2.PrepareFastReport;
  function DateCaption(dt1, dt2: string): string;
  begin
    Result:='Произвольный поиск нарядов за';
    if (dt1='') and (dt2='') then
    begin
      Result:=Result+' весь период'
    end else
    begin
      Result:=Result+' период ';
      if dt1<>'' then Result:=Result+' c '+dt1;
      if dt2<>'' then Result:=Result+' по '+dt2;
    end;
  end;
begin
  frVariables['Caption']:=DateCaption(F_OptFrm.strStartDate, F_OptFrm.strFinishedDate);
end;

procedure TUniversalSearch2.PrepareResultFormAddInfo;
begin
  if F_OptFrm.IsCalcLeak then
  begin
    F_ResFrm.IsShowLeakInfo:=true;
    F_ResFrm.SumLeak:=F_DM.GetSumLeak;
  end else F_ResFrm.IsShowLeakInfo:=false;
end;

procedure TUniversalSearch2.PrepareResultFormBtns;
begin
  F_ResFrm.Grid.OnFixedColClick:=OnGridFixedColClick;
  F_ResFrm.Grid.OnClick:=OnGridClick;
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
  F_ResFrm.btn_Print.OnClick:=OnPrintClick;

{  if DM_AomComClient.IsMapWork then
    F_ResFrm.btn_Map.OnClick:=OnMapClick
  else}
  
    F_ResFrm.btn_Map.OnClick:=nil;
end;

procedure TUniversalSearch2.PrepareResultFormGrid;
var
  _AomTypeOfAvarTitle: string;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;

{    if DM_AomComCLient.IsMapWork then
      _AomTypeOfAvarTitle:='Вид'+#13+'на карте'
    else}
      _AomTypeOfAvarTitle:='';

    AddColToGVB(F_GVB, 'AomTypeOfAvar', _AomTypeOfAvarTitle, alLeft, OnAomTypeOfAvarCellShow);
    AddColToGVB(F_GVB, 'OrderNumber', '^ №'+#13+'наряда', alCenter);
    AddColToGVB(F_GVB, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GVB, 'Regions', '^Район', alLeft);
    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'DamageType', 'Вид'+#13+'повреждения', alLeft, OnDamageTypeCellShow);
    AddColToGVB(F_GVB, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GVB, 'Diameter', 'Диаметер', alCenter, OnDiamCellShow);
    AddColToGVB(F_GVB, 'FlowSpeed', 'Утечка в час,'+#13+'м3', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GVB, 'Leak', 'Утечка,'+#13+'м3', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GVB, 'sDateClosed', 'Дата'+#13+'закрытия', alCenter);
  end;

  BuildResultGridView;
end;

procedure TUniversalSearch2.SetFilterToAom;
var
  _AvarIDList: TList;
begin
{  _AvarIDList := TList.Create;
  try
    F_DM.FillAvarIDList( _AvarIDList );
    DM_AomComClient.AomClientManager.SetExternalAvarIDFilter( _AvarIDList );
  finally
    _AvarIDList.Free;
  end;}
end;

{/ TUniversalSearch2}


{TSearchForOrdersFromOtherClasses}
procedure TSearchForOrdersFromOtherClasses.CreateForms;
  begin
//    F_ResFrm:=CreateResultForm(Tfrm_Search1562andOrdersResult, F_Name) as Tfrm_Search1562andOrdersResult;
    F_ResFrm:=Tfrm_Order1562.Create(nil, F_Name);
 //   F_ResFrm:=CreateResultForm(Tfrm_Search1562Result, F_Name) as Tfrm_Search1562Result;
    F_DM:=CreateDataModule(Tdm_UniversalSearch2) as Tdm_UniversalSearch2;
    F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
  end;

procedure TSearchForOrdersFromOtherClasses.BuildResultGridView;
var
  _ColorColNumber: integer;
begin
  F_GVB.BuildGridView;

  case F_DM.SortType of
    stOrderNumberAndDatecoming: _ColorColNumber:=2;
    stRegions: _ColorColNumber:=4;
    stAdres: _ColorColNumber:=5;
  end;
  F_ResFrm.Grid.ColorCell[_ColorColNumber, 0]:=clSkyBlue;
end;


procedure TSearchForOrdersFromOtherClasses.PrepareResultFormGrid;
var
  _AomTypeOfAvarTitle: string;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;

{    if DM_AomComCLient.IsMapWork then
      _AomTypeOfAvarTitle:='Вид'+#13+'на карте'
    else                                       }
      _AomTypeOfAvarTitle:='';

    AddColToGVB(F_GVB, 'AomTypeOfAvar', _AomTypeOfAvarTitle, alLeft, OnAomTypeOfAvarCellShow);
    AddColToGVB(F_GVB, 'OrderNumber', '^ №'+#13+'наряда', alCenter);
    AddColToGVB(F_GVB, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GVB, 'Regions', '^Район', alLeft);
    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'DamageType', 'Вид'+#13+'повреждения', alLeft, OnDamageTypeCellShow);
    AddColToGVB(F_GVB, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GVB, 'Diameter', 'Диаметер', alCenter, OnDiamCellShow);
    AddColToGVB(F_GVB, 'FlowSpeed', 'Утечка в час,'+#13+'м3', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GVB, 'Leak', 'Утечка,'+#13+'м3', alCenter, OnDiamCellShow);
    AddColToGVB(F_GVB, 'DateClosed', 'Дата'+#13+'закрытия', alCenter);
  end;

  BuildResultGridView;
end;


procedure TSearchForOrdersFromOtherClasses.PrepareResultFormBtns;
begin
 // F_ResFrm.Grid.OnFixedColClick:=OnGridFixedColClick;
 // F_ResFrm.Grid.OnClick:=OnGridClick;
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
 // F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_NewOrder.OnClick:=OnNewOrderClick;
  F_ResFrm.btnnext.OnClick:=NextOrder1562Click;
  F_ResFrm.btn_Previos.OnClick:=PreviosOrder1562Click;
 // F_ResFrm.Otvaz.OnClick:=Otsoed;
end;

procedure TSearchForOrdersFromOtherClasses.PrepareResultFormAddInfo;
begin
    // Надо придумать как заполнить данные на 1562
//    F_ResFrm.vle_Order1562
{    for i:=0 to dset.FieldCount-1 do
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
    F_DM.res ResultDset.Post;
 }

end;


procedure TSearchForOrdersFromOtherClasses.OnOrderClick(Sender : TObject);
var
  _OrderID,_row: integer;
  _frm_Order: Tfrm_Order;
begin
  with F_ResFrm do
  begin
   if F_ResFrm.IsLinkedChange then
    Application.MessageBox('Сохраните изменения!','АРМ АВР Сохранение изменеий',MB_OK)
    else
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _OrderID := integer(Grid.Objects[0, Grid.Row]);
        _frm_Order := Tfrm_Order.Create( nil, _OrderID );
        try
          _frm_Order.ShowModal;
          if _frm_Order.IsCtrlChange then
            Grid.RowFont[ Grid.Row ].Color := clRed;
{          if DM_AomComClient.IsMapWork then
            Grid.Cells[ 1, Grid.Row ] := NameCase( DM_AomComClient.ConvertTypeOfAvarToStr( _frm_Order.AomTypeOfAvar ) );}
          if   _OrderID=ID_ORDER  then          //glasha 23.1.2012
          begin
             vle_Order1562.FindRow('наряд', _row);
             vle_Order1562.DeleteRow(_row);

             if  _frm_Order.Is_closed then
               vle_Order1562.InsertRow( 'наряд' , 'закрыт' ,true)
             else
               vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);//glasha 23.1.2012
          end;
        finally
          _frm_Order.Free;
        end;
      end;
    except
      raise;
    end;
  end;
end;

procedure TSearchForOrdersFromOtherClasses.OnNewOrderClick(Sender: TObject);
var
  frm_Order: Tfrm_Order;
  frm_order_vds: Tfrm_Order_vds;
  nh:string;
  i:integer;
  id_o:integer;
begin
case F_ResFrm._app of
 2:  frm_Order:=Tfrm_Order.Create(Application); //Новый наряд
 3:  frm_order_vds:=Tfrm_Order_vds.Create(Application);
end;
    try
     case F_ResFrm._app of
     2:  begin
             FixDBLValue(F_ResFrm.id_Region,frm_Order.dbl_Regions);
             FixDBLValue(F_ResFrm.id_Street,frm_order.dbl_Street);
             nh:= F_ResFrm.vle_Order1562.Values['Дом'];
             frm_Order.ed_Housenum.Text:=F_ResFrm.vle_Order1562.Values['Дом'];
             frm_Order.NUM1562:=F_ResFrm.ID1562;
             frm_Order.ShowModal;
             id_o:=frm_Order.OrderID;
        end;
     3:  begin
              //F_OrderRegionID := FieldByName('FK_ORDERS_REGIONS').AsInteger;
              FixDBLValue(F_ResFrm.id_Region,frm_Order_vds.dbl_Regions); //Район
              FixDBLValue(F_ResFrm.id_Street,frm_order_vds.dbl_Street); //Улица
              frm_order_vds.ed_Housenum.Text:=F_ResFrm.vle_Order1562.Values['Дом']; //Номер дома
              frm_Order_vds.NUM1562:=F_ResFrm.ID1562;
              frm_order_vds.showModal;
              id_o:=frm_order_vds.orderid;

        end;
     end;

    finally
    case F_ResFrm._app of
      2:frm_Order.Free;
      3: frm_Order_vds.Free;
    end;
    end;
   RefreshDset;
   if     id_o>0 then
   begin
     {for i := 1 to F_ResFrm.Grid.RowCount do
      if integer(F_ResFrm.Grid.Objects[0, i])=F_ResFrm.ID_ORDER then
        F_ResFrm.grid.ColorRow[i] := clMoneyGreen;
   F_ResFrm.IsLinked:=true;
   }
   for i:=1 to   F_ResFrm.Grid.RowCount-1 do
   begin
     if Assigned(F_ResFrm.Grid.Objects[0, i] ) then
       if integer(F_ResFrm.Grid.Objects[0, i])=id_o then
         begin
            F_ResFrm.Grid.Row:=i;
            F_ResFrm.Grid.RowFont[F_ResFrm.Grid.Row ].Color := clRed;
         end;
   end;
    F_ResFrm.BitBtn1Click(nil);
    F_ResFrm.btn_Prepare.Enabled:=false;
    F_ResFrm.btn_NewOrder.Enabled:=false;
  end;
end;

procedure TSearchForOrdersFromOtherClasses.RefreshDset;
begin
    F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.PrepareDset;

    F_GVB.Free;
    F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
    PrepareResultFormGrid;
end;

procedure TSearchForOrdersFromOtherClasses.OnGridFixedColClick(Sender: TObject; col: Integer);
  begin
       //
  end;

procedure TSearchForOrdersFromOtherClasses.Onbtn_SaveClick(Sender: TObject);
begin

    //

end;

procedure TSearchForOrdersFromOtherClasses.NextOrder1562Click(Sender: TObject);
begin
PrevNextOrder1562Click(Sender,1);
end;

procedure TSearchForOrdersFromOtherClasses.PreviosOrder1562Click(Sender: TObject);
begin
PrevNextOrder1562Click(Sender,-1);
end;

procedure TSearchForOrdersFromOtherClasses.Otsoed(Sender: TObject);
var _Datatime1,_Datatime:tdatetime;
  _row:integer;
begin
//if (F_ResFrm.IsLinked) and (F_ResFrm.IsLinkedChange)  then
 ///  Application.MessageBox('С')
   F_ResFrm.ID_ORDER := -1;
   F_ResFrm.IsLinked := false;
   F_ResFrm.IsLinkedChange:=false;

   with F_ResFrm do begin
    vle_Order1562.FindRow('№наряда', _row);
    vle_Order1562.DeleteRow(_row);
    vle_Order1562.InsertRow( '№наряда' , '' ,true);
    vle_Order1562.FindRow('наряд', _row);
    vle_Order1562.DeleteRow(_row);
    vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);
 
    btn_Prepare.Enabled:=true;
   end;

    _Datatime:= F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    ShowAll := true;
    _Datatime1:=_Datatime-120;
    F_DM.Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime1)+'''  and datecoming < '''+ ///15.12.2011 отладка
                      DateTimeToStr(_Datatime + 30)+''''+'and isclosed=0';
   if F_DM.tran.InTransaction then
   F_DM.StopTransaction;
   F_DM.StartTransaction;
   F_DM.FillResultDset;
   F_GVB.BuildGridView;
end;

procedure TSearchForOrdersFromOtherClasses.init1562(_TRxM:TRxMemoryData);
begin
  F_DM.result1562:=_TRxM;
end;

procedure TSearchForOrdersFromOtherClasses.onOrder1562Click(Sender: TObject);

function FixSpaces(_s: string): string;
     var _i: integer;
     begin
      for _i := 0 to (Length(_s)-1) do
          if (_s[_i] in ['^', #$D]) then _s[_i] := ' ';
      Result := _s;
     end;

var
 _RegionID, _ID1562, Order_ID, i, _row: integer;
  _Datatime,_Datatime1: TDate;
  str:string;
begin

    if MainGrid.ClassName='TStringAlignGrid' then
    begin
     _row:=(MainGrid as TStringAlignGrid).Row;
     _ID1562 := integer((MainGrid as TStringAlignGrid).Objects[0, (MainGrid as TStringAlignGrid).Row]);
   end
   else
   begin
   _row:=(MainGrid as TRxDBGrid).Row;
   _ID1562 := StrToInt((MainGrid as TRxDBGrid).Fields[0].AsString);
  end ;
    F_DM.Result1562.Locate('ID',_ID1562,[]);
    _Datatime:= F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    ShowAll := true;
    _Datatime1:=_Datatime-120;
   { Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime1)+'''  and datecoming < '''+ ///15.12.2011 отладка
                      DateTimeToStr(_Datatime + 30)+'''';//+'and isclosed=0';
    }
     //F_SearchOrders.F_ResFrm.vle_Order1562.Values
   if MainGrid.ClassName='TStringAlignGrid' then
    for i:=1 to (MainGrid as TStringAlignGrid).ColCount-1 do
     if (F_ResFrm.vle_Order1562.RowCount>i)and (i>1) then
      F_ResFrm.vle_Order1562.Cells[2,i]:=(MainGrid as TStringAlignGrid).Cells[i,_row]
     else
      F_ResFrm.vle_Order1562.InsertRow(FixSpaces((MainGrid as TStringAlignGrid).Cells[i, 0]),(MainGrid as TStringAlignGrid).Cells[i, (MainGrid as TStringAlignGrid).Row], true)
   else
     for i:=1 to (MainGrid as TRxDBGrid).Columns.Count-1 do
      if i=11 then F_ResFrm.Memo1.Lines.Text:=(MainGrid as TRxDBGrid).Fields[i].AsString
      else
      if ((F_ResFrm.vle_Order1562.RowCount>i+1)and (i<11)) or ((i>11) and (F_ResFrm.vle_Order1562.RowCount>i))  then
       if i>11 then
            F_ResFrm.vle_Order1562.Cells[2,i-1]:=(MainGrid as TRxDBGrid).Fields[i].AsString
       else
        F_ResFrm.vle_Order1562.Cells[2,i]:=(MainGrid as TRxDBGrid).Fields[i].AsString
      else
         F_ResFrm.vle_Order1562.InsertRow(FixSpaces((MainGrid as TRxDBGrid).Columns[i].Title.Caption),(MainGrid as TRxDBGrid).Fields[i].AsString, true);

    Order_ID:= F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;


     if Order_ID>0 then
     begin
      if F_DM.Result1562.FieldByName('is_closed').AsInteger=1 then
       str:='закрыт'
      else
        str:='открыт';

     F_DM.Condition:= 'where id='+IntToStr(Order_ID);
     end
     else  begin
       str:='';
       F_DM.Condition:=F_Condition+'and isclosed=0';
     end;
  //   F_DM.Condition:=F_Condition;

   if  F_ResFrm.vle_Order1562.RowCount>=i  then
   begin
           F_ResFrm.vle_Order1562.Cells[2,i-1]:=str
   end
   else
    F_ResFrm.vle_Order1562.InsertRow(FixSpaces('Наряд'),str, true);

//    F_ResFrm.SPIS_ID := F_DM.Result1562.FieldByName('NUM1562').AsInteger;
    if F_DM.Result1562.FieldByName('ID').IsNull then
       F_ResFrm.ID1562:=-1
    else
       F_ResFrm.ID1562 := F_DM.Result1562.FieldByName('ID').AsInteger;
    F_ResFrm.ID_ORDER := F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.IsLinked := not (F_DM.Result1562.FieldByName('ID_ORDER').AsString = '');
    F_ResFrm.IsClosed := (F_DM.Result1562.FieldByName('Is_Closed').AsInteger = 1 );
    if not    F_DM.Result1562.FieldByName('NumOrder').IsNull then
               F_ResFrm.ORDERNUMBER :=F_DM.Result1562.FieldByName('NumOrder').AsString
             else
                F_ResFrm.ORDERNUMBER:='';
   // F_ResFrm.ID_MessHist := F_DM.Result1562.FieldByName('MHID').AsInteger;

    F_resFrm.OurNumber:=F_DM.Result1562.FieldByName('NumberOurRequest').asinteger;
    F_resFrm.RecivedNumber:=F_DM.Result1562.FieldByName('NumberReceivedRequest').AsInteger;
    F_resFrm.Date_Rec:=F_DM.Result1562.FieldByName('DateReceivedRequest').AsDateTime;
    F_resfrm.Date_Our:=F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    F_ResFrm.id_Region:=F_DM.Result1562.FieldByName('id_rayon').AsInteger;
    F_ResFrm.id_street:=F_DM.Result1562.FieldByName('id_street').AsInteger;
    F_ResFrm.btn_Prepare.Enabled:=(Order_ID<=0);
    F_ResFrm.btn_NewOrder.Enabled:=(Order_ID<=0);
    F_ResFrm._app:=F_DM.Result1562.FieldByName('Appurtenance').asinteger;


end;

procedure TSearchForOrdersFromOtherClasses.PrevNextOrder1562Click(Sender: TObject;inc:integer);   //17.11.2011
var
  _RegionID, _ID1562, Order_ID, i, _row: integer;
  _Datatime: TDate;
  str:string;
  cond:boolean;
begin
if F_ResFrm.IsLinkedChange then
 if Application.MessageBox(' Сохранить изменеия?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
     begin
         F_ResFrm.ActiveControl:=F_ResFrm.btn_Save;
        exit;
     end;
 if  MainGrid.ClassName='TStringAlignGrid' then
 cond := ((MainGrid as TCustomDrawGrid).Row+inc<(MainGrid as TStringAlignGrid).RowCount) and  ((MainGrid as TCustomDrawGrid).Row+inc>0 )
 else
  cond:=({(MainGrid as TRxDBGrid).f.Row+inc<(MainGrid as TRxDBGrid).r.RowCount) and } (MainGrid as TRxDBGrid).Row+inc>0 );
  if cond
 then
 begin
 // if  F_DM.Result1562.FindNext then
 // begin

    if  MainGrid.ClassName='TStringAlignGrid' then
    (MainGrid as TStringAlignGrid).Row:=(MainGrid as TStringAlignGrid).Row+inc
    else
     if inc>0 then
     F_DM.Result1562.Next
     else
      F_DM.Result1562.Prior;
     //(MainGrid as TRxDBGrid).
    onOrder1562Click(Sender);
    if F_DM.tran.InTransaction then
     F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.FillResultDset;
    F_GVB.SelFieldVal:=F_ResFrm.ORDERNUMBER;
    F_GVB.BuildGridView;
   { _row:=MainGrid.Row;
    _ID1562 := integer(MainGrid.Objects[0, MainGrid.Row]);
    F_DM.Result1562.Locate('ID',_ID1562,[]);
    _Datatime:= F_DM.Result1562.FieldByName('Datatime').AsDateTime;
    ShowAll := true;
    Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime)+''' and datecoming < '''+
                      DateTimeToStr(_Datatime + 1)+'''';
     F_DM.Condition:=F_Condition;
     //F_SearchOrders.F_ResFrm.vle_Order1562.Values
    for i:=1 to F_ResFrm.vle_Order1562.RowCount-1 do
     F_ResFrm.vle_Order1562.Cells[2,i]:=MainGrid.Cells[i,_row];

    Order_ID:= F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.SPIS_ID := F_DM.Result1562.FieldByName('ID').AsInteger;
    F_ResFrm.ID1562 := F_DM.Result1562.FieldByName('NUM1562').AsInteger;
    F_ResFrm.ID_ORDER := F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.IsLinked := not (F_DM.Result1562.FieldByName('ID_ORDER').AsString = '');
    F_ResFrm.IsClosed := (F_DM.Result1562.FieldByName('Is_Closed').AsInteger = 1 );
    F_ResFrm.ORDERNUMBER :=F_DM.Result1562.FieldByName('ORDERNUMBER').AsInteger;
    F_ResFrm.ID_MessHist := F_DM.Result1562.FieldByName('MHID').AsInteger;

    if F_DM.tran.InTransaction then
     F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.FillResultDset;
    F_GVB.BuildGridView;  }
   //BuildResultGridView;

 end;
end;

function TSearchForOrdersFromOtherClasses.Execute:boolean ;
var
  rec_count: integer;
begin
  Result:=false;

//  if F_OptFrm.ShowModal<>mrOk then exit;

//  F_DM.strStartDate:=F_OptFrm.strStartDate;
//  F_DM.strFinishedDate:=F_OptFrm.strFinishedDate;
 // F_DM.Condition:=F_Condition;
  F_DM.SortType:=stRegions;
  F_DM.IsAscSort:=true;

  F_DM.StartTransaction;
  try
    rec_count:=F_DM.GetRecordCount;
    if (not(F_ShowAll) and (rec_count<=0)) then
    begin
      Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Произвольный поиск', MB_OK+MB_ICONINFORMATION);
    end else
    begin
      if (F_ShowAll or (Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Произвольный поиск', MB_YESNO+MB_ICONQUESTION)=ID_YES)) then
      begin
        F_Pind.Show;
        //F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
        F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid, 1, F_ResFrm.ORDERNUMBER, true, clMoneyGreen);
        try
          F_DM.PrepareDset;
          PrepareResultFormBtns;
          PrepareResultFormGrid;
          //PrepareResultFormAddInfo;
          F_ResFrm.ShowModal;
        finally
          F_GVB.Free;
        end;
        F_Pind.Hide;
      end;
    end;
  finally
    F_DM.StopTransaction;
  end;
  Result:=true;
 end;


{/TSearchForOrdersFromOtherClasses}

{TSearch1562}

procedure TSearch1562.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_Search1562, F_Name) as Tfrm_Search1562;
//  F_ResFrm:=CreateResultForm(Tfrm_Search1562Result, F_Name) as Tfrm_Search1562Result;
  F_ResFrm:=CreateResultForm(Tfrm_Search1562andOrdersResult, F_Name) as Tfrm_Search1562andOrdersResult;
  F_DM:=CreateDataModule(Tdm_Search1562) as Tdm_Search1562;
 // F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;


procedure TSearch1562.InitFields;
  begin
    F_Name:='Поиск 1562';
    F_Pind.CancelButton:=false;
    F_Pind.OnCancel:=nil;
  end;

procedure TSearch1562.PrepareFastReport;
  function DateCaption(dt1, dt2: string): string;
  begin
    Result:='Поиск нарядов 1562 за';
    if (dt1='') and (dt2='') then
    begin
      Result:=Result+' весь период'
    end else
    begin
      Result:=Result+' период ';
      if dt1<>'' then Result:=Result+' c '+dt1;
      if dt2<>'' then Result:=Result+' по '+dt2;
    end;
  end;
begin
  frVariables['Caption']:='';//DateCaption(F_OptFrm.strStartDate, F_OptFrm.strFinishedDate);
end;

procedure TSearch1562.PrepareResultFormBtns;
begin
//  F_ResFrm.Grid.OnFixedColClick:=OnGridFixedColClick;
//  F_ResFrm.Grid.OnClick:=OnGridClick;
//  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
 //// F_ResFrm.btn_OrderTo1562.OnClick:=OrderTo1562Click;
 // F_ResFrm.Btn_LinkTo.OnClick := OrderTo1562Click;
//  F_ResFrm.btn_Print.OnClick:=OnPrintClick;

 //F_ResFrm.btn_Order.OnClick:= OrderTo1562Click;
 //F_ResFrm.btn_Order.Caption := 'Заявка 1562';
   F_ResFrm.btn_Order.Visible:=false;
 F_ResFrm.Btn_LinkTo.Visible := false;
 F_ResFrm.btn_Print.Visible:=false;
end;

procedure TSearch1562.PrepareResultFormGrid;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
//    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;
{
, sp.nfloor
, sp.podesd
, sp.kodpodesd
, sp.kodclass
, sp.avar
, sp.regl
, sp.fk_spisok1562_rayon
, sp.fk_spisok1562_sreet
, sp.fk_spisok1562_order
}

  {  AddColToGVB(F_GVB, 'NUM1562', '^ №'+#13+'заявки 1562', alCenter);
    AddColToGVB(F_GVB, 'DATATIME', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GVB, 'Region', '^Район', alLeft);
//    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'street_name', '^Улица', alLeft);
    AddColToGVB(F_GVB, 'house', 'Дом', alLeft);
    AddColToGVB(F_GVB, 'appartment', 'Квартира', alLeft);
    AddColToGVB(F_GVB, 'phone', 'Телефон', alLeft);
    AddColToGVB(F_GVB, 'PLACE', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GVB, 'abonent', 'Абонент', alLeft);
    AddColToGVB(F_GVB, 'about', 'О чём заявлено', alLeft);
    AddColToGVB(F_GVB, 'works', 'Работы', alLeft);
   // AddColToGVB(F_GVB, 'status', 'Статус', alLeft);
    AddColToGVB(F_GVB, 'ordernumber', '№ наряда', alLeft);
    }
    AddColToGVB(F_GVB, 'NumberOurRequest', '№ в базе'+#13+'заявок', alCenter);
    AddColToGVB(F_GVB, 'DateOurRequest', 'Дата в базе'+#13+'заявок', alLeft);
 //    AddColToGVB(F_GVB, 'AppurtenanceState', 'AppurtenanceState', alLeft);
    AddColToGVB(F_GVB, 'NumberReceivedRequest', '№созданной'+#13+'заявки', alCenter);
    AddColToGVB(F_GVB, 'DateReceivedRequest', 'Дата'+#13+'создания', alCenter);
   // AddColToGVB(F_GVB, 'AppurtenanceState', 'AppurtenanceState', alCenter);
  //  AddColToGVB(F_GVB, 'State', 'State', alCenter);
    AddColToGVB(F_GVB, 'Region','Район', alLeft);
    AddColToGVB(F_GVB, 'name_street','Улица', alLeft);
    AddColToGVB(F_GVB, 'HOUSE','Дом', alLeft);
    AddColToGVB(F_GVB, 'APPARTMENT','Кватира', alLeft);
    AddColToGVB(F_GVB, 'Place','Место', alLeft);
    AddColToGVB(F_GVB, 'opened','Откуда',alCenter);
   // AddColToGVB(F_GVB, 'ABOUT','О чем заявлено',alleft);
    //AddColToGVB(F_GVB, 'Appurtenance','Appurtenance', alLeft);
   // AddColToGVB(F_GVB, 'state_1','state_1', alLeft);
  ///   AddColToGVB(F_GVB, 'dateclosed','Дата'+#13+'закрытия',alleft);
    AddColToGVB(F_GVB, 'Number_Order','№Наряда',alleft)

  end;

 // BuildResultGridView;
   F_GVB.BuildGridView;
end;


procedure TSearch1562.OrderTo1562Click(Sender: TObject);

   function FixSpaces(_s: string): string;
     var _i: integer;
     begin
      for _i := 0 to (Length(_s)-1) do
          if (_s[_i] in ['^', #$D]) then _s[_i] := ' ';
      Result := _s;
     end;

var
  _RegionID, _ID1562, Order_ID, i, _row: integer;
  _Datatime: TDate;
  _IsExecuteOk: boolean;
  F_SearchOrders: TSearchForOrdersFromOtherClasses;
begin
     with F_ResFrm do
  begin
    StartWait;
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
       // _ID1562 := integer(Grid.Objects[0, Grid.Row]);
       // _Datatime:= Grid.CellsAsDate[2, Grid.Row];
        F_SearchOrders := TSearchForOrdersFromOtherClasses.Create;
        F_SearchOrders.F_DM.result1562:=F_DM.ResultDset;
        F_SearchOrders.MainGrid:=Grid;
        F_SearchOrders.ShowAll := true;
        F_SearchOrders.onOrder1562Click(Sender);
        StopWait;
     {   F_SearchOrders.Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime)+''' and datecoming < '''+
                      DateTimeToStr(_Datatime + 1)+'''';


        if F_DM.ResultDset.Locate('id', _ID1562, []) then
         begin
          Order_ID:= F_DM.ResultDset.FieldByName('ID_ORDER').AsInteger;
          _Datatime:= F_DM.ResultDset.FieldByName('Datatime').AsDateTime;
         // _ID1562 := F_DM.ResultDset.FieldByName('ID').AsInteger;
//          for i:=1 to F_DM.ResultDset.FieldCount-1 do
          for i:=1 to F_GVB.ColumnCount do
            begin
             // Здесь заполняем данные наряда1562 в ValueListEditor
             F_SearchOrders.F_ResFrm.vle_Order1562.InsertRow(FixSpaces(Grid.Cells[i, 0]),Grid.Cells[i, Grid.Row], true) ;
//                                        F_DM.ResultDset.Fields[i].AsString;
            end;
           F_SearchOrders.F_ResFrm.SPIS_ID := F_DM.ResultDset.FieldByName('ID').AsInteger;
           F_SearchOrders.F_ResFrm.ID1562 := F_DM.ResultDset.FieldByName('NUM1562').AsInteger;
           F_SearchOrders.F_ResFrm.ID_ORDER := F_DM.ResultDset.FieldByName('ID_ORDER').AsInteger;
           F_SearchOrders.F_ResFrm.IsLinked := not (F_DM.ResultDset.FieldByName('ID_ORDER').AsString = '');
           F_SearchOrders.F_ResFrm.IsClosed := (F_DM.ResultDset.FieldByName('Is_Closed').AsInteger = 1 );
           F_SearchOrders.F_ResFrm.ORDERNUMBER :=F_DM.ResultDset.FieldByName('ORDERNUMBER').AsInteger;
           F_SearchOrders.F_ResFrm.ID_MessHist := F_DM.ResultDset.FieldByName('MHID').AsInteger;
          // ID_MessHist
           //if F_SearchOrders.F_ResFrm.IsLinked then
           //        F_SearchOrders.F_DM.ResultDset.Locate('ID',F_DM.ResultDset.FieldByName('FK_SPISOK1562_ORDER').AsInteger, []);


         end;   }
        try
          // F_SearchOrders.F_DM.result1562:=F_DM.ResultDset;
          // F_SearchOrders.MainGrid:=Grid;
           _IsExecuteOk:= F_SearchOrders.Execute;
           _row := Grid.Row;
            RefreshDset;
           if F_SearchOrders.F_ResFrm.IsCtrlChange then Grid.RowFont[ _row ].Color := clRed;
        finally
          F_SearchOrders.Free;
        end;
      end;
    except
      StopWait;
      raise;
    end;
  end;
end;

procedure TSearch1562.NextOrder1562Click(Sender: TObject);
begin
    F_DM.ResultDset.Next;

    //


end;

procedure TSearch1562.RefreshDset;
begin
    F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.PrepareDset;

    F_GVB.Free;
    F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
    PrepareResultFormGrid;
end;

procedure TSearch1562.RefreshResult;
begin
  //
  
end;

function TSearch1562.Execute;
var rec_count: integer;
begin

  Result:=false;
if IsFromOrder then
 begin
    //

 end
 else
 begin
  if F_OptFrm.ShowModal<>mrOk then exit;

//  F_DM.strStartDate:=F_OptFrm.strStartDate;
//  F_DM.strFinishedDate:=F_OptFrm.strFinishedDate;
  F_DM.Condition:=F_OptFrm.ResultCondition;
  F_DM._isclosed.Add('1');
  F_DM.F_dt1:=F_OptFrm.dp_Coming1.Text+' '+F_OptFrm.tp_Coming1.Text;
  F_DM.F_dt2:=F_OptFrm.dp_Coming2.text+' '+F_OptFrm.tp_Coming2.Text;
  F_DM.App.Clear; F_DM.App.Add('2'); F_DM.App.Add('3');
  F_DM.ID_Region:=0;
  F_DM.RegionsList:=F_OptFrm.RegionList;
//  F_DM.SortType:=stOrderNumberAndDatecoming;
//  F_DM.IsAscSort:=true;
  end;
  F_DM.StartTransaction;
  try
  //  rec_count:=F_DM.GetRecordCount;
  //  if rec_count<=0 then
    {begin
      Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Поиск 1562', MB_OK+MB_ICONINFORMATION);
    end else}
    begin
      {if Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Поиск 1562', MB_YESNO+MB_ICONQUESTION)=ID_YES then}
      begin
        F_Pind.Show;
        F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
        try
          F_DM._isclosed.Add('1');
          F_DM.PrepareDset;
          PrepareResultFormBtns;
          PrepareResultFormGrid;
//          PrepareResultFormAddInfo;
          F_ResFrm.ShowModal;
        finally
          F_GVB.Free;
        end;
        F_Pind.Hide;
      end;
    end;
  finally
    F_DM.StopTransaction;
  end;


  Result:=false;

end;

{/TSearch1562}

{ TSvodVedLukAndPG }

procedure TSvodVedLukAndPG.CreateForms;
begin
  F_OptFrm:=CreateOptionForm(Tfrm_DatesSel, F_Name) as Tfrm_DatesSel;
  F_DM:=CreateDataModule(Tdm_SvodVedLukAndPG) as Tdm_SvodVedLukAndPG;
end;

function TSvodVedLukAndPG.Execute: boolean;
begin
  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_DM.DtBeg:=F_OptFrm.dp_Date1.Date;
  F_DM.DtEnd:=F_OptFrm.dp_Date2.Date;

  F_Pind.Show;

  if F_DM.PrepareDset then
  begin
    PrepareAndPrintFR(F_DM.frReport);
  end;

  F_Pind.Hide;

  Result:=true;
end;

procedure TSvodVedLukAndPG.InitFields;
begin
  F_Name:='Ведомость заявок по установке люков и замены пож. гидрантов';
  F_ReportFileName:='SvodVedLukAndPG.frf';
end;

procedure TSvodVedLukAndPG.PrepareFastReport;
begin
  frVariables['DtBeg']:=DateToStr(F_OptFrm.dp_Date1.Date);
  frVariables['DtEnd']:=DateToStr(F_OptFrm.dp_Date2.Date);
end;

{ TNeedAsfalt }

procedure TNeedAsfalt.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptNeedAsfalt, F_Name ) as Tfrm_OptNeedAsfalt;
  F_DM := CreateDataModule( Tdm_RepNeedAsfalt ) as Tdm_RepNeedAsfalt;
  F_ResFrm := CreateResultForm( Tfrm_ResNeedAsfalt, F_Name ) as Tfrm_ResNeedAsfalt;
  F_PreviewFrm := Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
end;

function TNeedAsfalt.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.StartDate := F_OptFrm.StartDate;
    F_DM.NeedRestoreDate := F_OptFrm.NeedRestoreDate;
    F_DM.BegDate := F_OptFrm.BegDate;
    F_DM.EndDate := F_OptFrm.EndDate;
    F_DM.ExcType := F_OptFrm.ExcType;

    if F_DM.PrepareDset then
    begin
      //PrepareAndPrintFR( F_DM.frReport );
      PrepareResultForm;
      F_ResFrm.ShowModal;
    end;

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;

function TNeedAsfalt.GetCaption: string;
begin
  if F_OptFrm.ExcType = etAsfalt then
    Result :=
      'Информация по благоустройству мест разрытий по КП "Вода" (ПУВС "Харьковводосеть"),' +
      ' требующих восстановления асфальтобетонного покрытия по состоянию' +
      ' на ' + DateToStr( F_OptFrm.EndDate ) + ' г.'
  else
    Result :=
      'Информация по благоустройству мест разрытий по КП "Вода" (ПУВС "Харьковводосеть")' +
      ' на зеленой зоне по состоянию' +
      ' на ' + DateToStr( F_OptFrm.EndDate ) + ' г.';
end;

procedure TNeedAsfalt.InitFields;
begin
  F_Name := 'Сводка по благоустройству в ГИК';
  F_ReportFileName := 'NeedAsfalt.frf';
end;

procedure TNeedAsfalt.OnPrintClickHandler(Sender: TObject);
begin
  PrepareAndPrintFR( F_DM.frReport );
end;

procedure TNeedAsfalt.OnSelDetailHandler(_DetailInfo: TDetailInfo);
var
  _rep: TBlagDetail;
begin
  _rep := TBlagDetail.Create;
  try
    _rep.SessionID := F_DM.SessionID;
    _rep.ExcType := F_OptFrm.ExcType;
    _rep.DetailInfo := _DetailInfo;
    _rep.StartDate := F_OptFrm.StartDate;
    _rep.GranDate := F_OptFrm.NeedRestoreDate;
    _rep.BeginDate := F_OptFrm.BegDate;
    _rep.EndDate := F_OptFrm.EndDate;

    _rep.Execute; 
  finally
    _rep.Free;
  end;
end;

procedure TNeedAsfalt.PrepareFastReport;
begin
  frVariables[ 'Caption' ] := GetCaption;
  frVariables[ 'StartDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.StartDate );
  frVariables[ 'GranDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.NeedRestoreDate );
  frVariables[ 'BeginDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.BegDate );
  frVariables[ 'EndDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.EndDate );
end;

procedure TNeedAsfalt.PrepareResultForm;
begin
  F_ResFrm.ds_Result.DataSet := F_DM.ResultDset;
  //
  F_ResFrm.GranDate := F_OptFrm.NeedRestoreDate;
  F_ResFrm.BeginDate := F_OptFrm.BegDate;
  F_ResFrm.EndDate := F_OptFrm.EndDate;
  F_ResFrm.Caption := GetCaption;
  //
  F_ResFrm.OnPrintClick := OnPrintClickHandler;
  F_ResFrm.OnSelDetail := OnSelDetailHandler;
end;

{ TGorSES }

procedure TGorSES.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_DatesSel, F_Name ) as Tfrm_DatesSel;
  F_DM := CreateDataModule( Tdm_RepGorSES ) as Tdm_RepGorSES;
end;

function TGorSES.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_DM.DateBegin := F_OptFrm.dp_Date1.Date;
  F_DM.DateEnd := F_OptFrm.dp_Date2.Date;
  F_Pind.Show;
  if F_DM.PrepareDset then
    PrepareAndPrintFR( F_DM.frReport );
  F_Pind.Hide;

  Result := true;
end;

procedure TGorSES.InitFields;
begin
  F_Name := 'Сводка в ГорСЭС для гл. врача';
  F_ReportFileName := 'GorSES.frf';
end;

procedure TGorSES.PrepareFastReport;
begin
  frVariables[ 'DateBegin' ] := DateToStr( F_OptFrm.dp_Date1.Date );
  frVariables[ 'DateEnd' ] := DateToStr( F_OptFrm.dp_Date2.Date );
end;

{TPlanDep}
procedure TPlanDep.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptPlanDep, F_Name ) as Tfrm_OptPlanDep;
  F_DM := CreateDataModule( Tdm_PlanDep ) as Tdm_PlanDep;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);

  F_OptFrm.dp_Date.Date := now;
 (F_OptFrm as Tfrm_OptPlanDep)._ReadOnly:=not(AppSettings.Get_IsSentXML='1');
 ( F_DM  as Tdm_PlanDep).is_Update:=AppSettings.Get_IsSentXML='1';
  if  (DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID) and DM_RightsManager.IsCurrentUserDisp then
      F_PreviewFrm.bb_Mail.Visible := true else F_PreviewFrm.bb_Mail.Visible := false;
end;

procedure TPlanDep.InitFields;
begin
  F_Name := 'Планируемые работы';
  F_ReportFileName := 'PlanDep.frf';
//  F_Pind.CancelButton := false;
end;

procedure TPlanDep.PrepareFastReport;
begin
  frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.dp_Date.Date );
  frVariables[ 'Caption' ] := 'План проведения работ по ликвидации повреждений на водопроводных сетях города'+
                           ' на ' + DateToStr(F_OptFrm.dp_Date.Date);
  frVariables[ 'captionprint' ] := 'Сформировано на печать ';
   frVariables['Excav']:=F_OptFrm._excav;
   frVariables['Tripper']:=F_OptFrm._triper;
   frVariables['Pumping']:=F_OptFrm._pumping;


end;

function TPlanDep.Execute: boolean;
// номера районов куда посылаем по почте
const arrayIDREgSent :array [1..2] of integer = (6,5);
var num_reg:integer;
    regionName:String;

procedure EMailPrint(fn: string);
var
  file_name: string;
  begin
    {Отправка по почте}
   // if Application.MessageBox('Отправить сформированную ведомость по почте?',
   //     PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    fn+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
     // ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
    end;
    {/Отправка по почте}
end;

procedure EMailPrintReg(fn: string; _RegID: integer;regionName:string);
var
  file_name: string;
  begin
    {Отправка по почте}
   // if Application.MessageBox('Отправить сформированную ведомость по почте?',
   //     PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    fn+ReplaceChar(DateToStr(Date), '.', '_')+'.rtf');

    if ExportFastReportToRTF( F_DM.frReport, file_name )  then
        SendByEmail( ZipFile(file_name)
            ,Format( 'План проведения работ по ликвидации повреждений на водопроводных сетях в %sом р-не',[regionName])
            , _RegID );

    end;
    {/Отправка по почте}
end;


begin
  F_ReportFileName:='PlanDep.frf';
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;
    F_OptFrm.dset.Close;
    F_OptFrm.tran.Rollback;
    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date.Date;
//    F_DM.DtEnd := F_OptFrm.frame_Dates.EndDate;
//    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.excav:=F_OptFrm._excav;
    F_DM.pumping:=F_OptFrm._pumping;
    F_DM.tripper:=F_OptFrm._triper;
    F_DM.RegionID := 0;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
    if F_PreviewFrm.ToMail then
    begin
    EMailPrint( 'svod_plan_' );

    // здесь будет работа по районам отдельно, пока что начнём с Октябрьского :)
    for  num_reg :=1 to High(arrayIDREgSent) do
    begin
    F_DM.RegionID := arrayIDREgSent[num_reg];
    F_DM.PrepareDset;
    F_Pind.Hide;

    F_ReportFileName := 'PlanDepReg.frf';
    frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.dp_Date.Date );
    RegionName :=StrinFirstUpperCaseLowCase(trim(F_Dm.RegionName));
    delete(RegionName,length(REgionName)-1,2);
    frVariables[ 'Caption' ] :=Format( 'План проведения работ по ликвидации повреждений на водопроводных сетях '+
                           'в %sом р-не на %s',
                           [RegionName, DateToStr(F_OptFrm.dp_Date.Date)]);
    frVariables[ 'captionprint' ] := 'Сформировано ';

    if LoadReportFileTo(F_DM.frReport) then
      begin
       F_DM.frReport.PrepareReport;
       EMailPrintReg( Format('svod_plan_%d_',[arrayIDREgSent[num_reg]]),
                       arrayIDREgSent[num_reg], RegionName );
      end;
     end;
    //
    end;
  end;
end;
{/TPlanDep}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
{TRazrtDep}
procedure TRazrtDep.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_DateSel, F_Name ) as Tfrm_DateSel;
  F_DM := CreateDataModule( Tdm_RazrtDep ) as Tdm_RazrtDep;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);

  F_OptFrm.dp_Date.Date := now;

  if  (DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID) and DM_RightsManager.IsCurrentUserDisp then
      F_PreviewFrm.bb_Mail.Visible := true else F_PreviewFrm.bb_Mail.Visible := false;
end;

procedure TRazrtDep.InitFields;
begin
  F_Name := 'Места раскопок';
  F_ReportFileName := 'RazrtDep.frf';
//  F_Pind.CancelButton := false;
end;

procedure TRazrtDep.PrepareFastReport;
begin
  frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.dp_Date.Date );
  frVariables[ 'Caption' ] := 'Сводка разрытий по КП "Харьковводоканал" '+
                           ' на ' + DateToStr(F_OptFrm.dp_Date.Date);
  frVariables[ 'captionprint' ] := 'Сформировано на печать ';
end;

function TRazrtDep.Execute: boolean;

  procedure EMailPrint(fn: string);
  var
    file_name: string;
    begin
      {Отправка по почте}
     // if Application.MessageBox('Отправить сформированную ведомость по почте?',
     //     PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
      begin
        file_name:=trim(AppSettings.Get_Abon_Path+
                      fn+ReplaceChar(DateToStr(Date), '.', '_'));

        ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
       // ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
      end;
      {/Отправка по почте}
  end;

begin
  F_OptFrm.dp_Date.Visible:=false;
  F_OptFrm.Label1.Visible:=false;
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
 end else
  begin
    Result := true;

    F_Pind.Show;
    //F_DM.DtBeg :=now;
  F_DM.DtBeg := F_OptFrm.dp_Date.Date;
//    F_DM.DtEnd := F_OptFrm.frame_Dates.EndDate;
//    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.RegionID := 0;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
    if F_PreviewFrm.ToMail then EMailPrint( 'svod_razr_' );
  end;
end;


//!!!!!!!!!!!!!!!!!!!!!!!!!!!
{/TPRazrtDep}


{TPlanDenial}
procedure TPlanDenial.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_DatesSel, F_Name ) as Tfrm_DatesSel;
  F_DM := CreateDataModule( Tdm_PlanDenial ) as Tdm_PlanDenial;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);

  F_OptFrm.dp_Date1.Date := now;
  F_OptFrm.dp_Date2.Date := now;

  if  (DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID) and DM_RightsManager.IsCurrentUserDisp then
      F_PreviewFrm.bb_Mail.Visible := true else F_PreviewFrm.bb_Mail.Visible := false;
end;

procedure TPlanDenial.InitFields;
begin
  F_Name := 'Невыполненные работы';
  F_ReportFileName := 'PlanDenial.frf';
//  F_Pind.CancelButton := false;
end;

procedure TPlanDenial.PrepareFastReport;
begin
  frVariables[ 'dt_beg'  ] := DateToStr( F_OptFrm.dp_Date1.Date );
  frVariables[ 'dt_end' ]:=DateToStr(F_OptFrm.dp_Date2.Date);
  frVariables[ 'Caption' ] := 'Невыполненные работы по ликвидации повреждений'+
                              ' на водопроводных сетях города'+#13+
                              ' за период с '+DateToStr(F_OptFrm.dp_Date1.Date)+
                              ' по '+DateToStr(F_OptFrm.dp_Date2.Date);
end;

function TPlanDenial.Execute: boolean;

procedure EMailPrint;
var
  file_name: string;
  begin
    {Отправка по почте}
   // if Application.MessageBox('Отправить сформированную ведомость по почте?',
   //     PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    'svod_plan_'+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
     // ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
    end;
    {/Отправка по почте}
end;

begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date1.Date;
    F_DM.DtEnd := F_OptFrm.dp_Date2.Date;
//    F_DM.DtEnd := F_OptFrm.frame_Dates.EndDate;
//    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
    if F_PreviewFrm.ToMail then EMailPrint;
  end;
end;


{/TPlanDenial}




{TUseEquip}

procedure TUseEquip.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_PeriodRegSel, F_Name ) as Tfrm_PeriodRegSel;
  F_OptFrm.btn_Regions.Visible := false;
  F_DM := CreateDataModule( Tdm_UseEquip ) as Tdm_UseEquip;
  F_ResFrm:=CreateResultForm( Tfrm_AnalysisView, F_Name) as Tfrm_AnalysisView;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TUseEquip.InitFields;
begin
  F_Name := 'Использования механизмов при благоустройстве';
  F_ReportFileName := 'UseEquip.frf';
end;

procedure TUseEquip.PrepareFastReport;
var sDtIn, sDtOut:string;
begin
//  frVariables['dt_beg']:=DateToStr(F_OptFrm.dp_Date1.Date);
//  frVariables['dt_end']:=DateToStr(F_OptFrm.dp_Date2.Date);
  sDtIn:=DateToStr(F_OptFrm.dp_Date1.Date);
  sDtOut:=DateToStr(F_OptFrm.dp_Date2.Date);
  frVariables['Caption']:='Сводная ведомость использования механизмов при благоустройстве за период c '+
      sDtIn + ' по ' + sDtOut;
//  frVariables['regions']:=F_OptFrm.strRegions;
end;

procedure TUseEquip.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR( F_DM.frReport );
end;

procedure TUseEquip.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('Regions').AsString)+' район');
end;


procedure TUseEquip.PrepareResultForm;
var
  _gvb: TGridViewBuilder;
  _group: TGroup;
  sDtIn, sDtOut:string;
begin
  F_ResFrm.ResetForm;

  {Готовим Grid}
  _gvb := TGridViewBuilder.Create( F_DM.ResultDset, F_ResFrm.Grid );
  try
    with _gvb do
    begin
      IDFieldName:='ID';

      AddColToGVB( _gvb, 'OrderNumber', '№'+#13+'наряда', alCenter );
      AddColToGVB( _gvb, 'DateComing', 'Дата'+#13+'поступления', alCenter );
      AddColToGVB( _gvb, 'Adres', 'Адрес', alLeft );
      AddColToGVB( _gvb, 'Equip', 'Механизм'+#13+'ликвидации', alCenter );
      AddColToGVB( _gvb, 'dtime', 'Дата выполненых'+#13+' работ ', alCenter );
      AddColToGVB( _gvb, 'ExcWt','Работа', alCenter );

      _group:=AddGroup( 'MainGr' );
      _group.IsNumberRecordInGroup := true;
      _group.GroupHeader.Visible := false;
      _group.GroupFooter.Visible := false;

      _group:=AddGroup('Regions');
      _group.IsNumberRecordInGroup := true;
      _group.GroupHeader.Visible := true;
      _group.GroupFooter.Visible := false;
      _group.GroupHeader.Color := clGrayText;
      _group.GroupHeader.OnShowCaption := OnRegHeaderCaption;
      _group.GroupHeader.Font.Style := [fsBold];
      _group.GroupHeader.Alignment := alCenter;

      _gvb.BuildGridView;
    end; //end with
  finally
    _gvb.Free;
  end;
  {/Готовим Grid}

  {Готовим заголовок}
  sDtIn:=DateToStr(F_OptFrm.dp_Date1.Date);
  sDtOut:=DateToStr(F_OptFrm.dp_Date2.Date);
  F_ResFrm.CenterLabel :=
    'Сводная ведомость использования механизмов при благоустройстве за период c '+
      sDtIn + ' по ' + sDtOut;
  {/Готовим заголовок}

  {Готовим кнопки}

  F_ResFrm.btn_Order.OnClick := OnOrderClick;
  F_ResFrm.btn_Print.OnClick := OnPrintClick;
  {/Готовим кнопки}
end;



function TUseEquip.Execute: boolean;

begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date1.Date;
    F_DM.DtEnd := F_OptFrm.dp_Date2.Date;
//    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.PrepareDset;
    PrepareResultForm;
    F_Pind.Hide;

//    PrepareAndPrintFR( F_DM.frReport );

      F_ResFrm.ShowModal;

        Result := true;

  end;
end;


{/TUseEquip}

{ TTrudoZatrat }

procedure TTrudoZatrat.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptTrudoZatrat, F_Name ) as Tfrm_OptTrudoZatrat;
  F_DM := CreateDataModule( Tdm_RepTrudoZatrat ) as Tdm_RepTrudoZatrat;
end;

function TTrudoZatrat.Execute: boolean;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.frame_Dates.BeginDate;
    F_DM.DtEnd := F_OptFrm.frame_Dates.EndDate;
    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
  end;
end;

procedure TTrudoZatrat.InitFields;
begin
  F_Name := 'Сводка трудозатрат';
  F_ReportFileName := 'TrudoZatrat.frf';
  F_Pind.CancelButton := false;
end;

procedure TTrudoZatrat.PrepareFastReport;
begin
  frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.frame_Dates.BeginDate );
  frVariables[ 'DtEnd' ] := DateToStr( F_OptFrm.frame_Dates.EndDate );
  frVariables[ 'RegionName' ] := F_OptFrm.GetRegionName;
end;

{ TVipolNaryad }

procedure TVipolNaryad.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptVipolNaryad, F_Name ) as Tfrm_OptVipolNaryad;
  F_DM := CreateDataModule( Tdm_RepVipolNaryad ) as Tdm_RepVipolNaryad;
end;

function TVipolNaryad.Execute: boolean;
var rec_count:integer;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.BeginDate := F_OptFrm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_SelDates.EndDate;
    F_DM.RegionID := F_OptFrm.GetRegionID;
    F_DM.WorkTypeID := F_OptFrm.GetWorkTypeID;
    F_DM.SortType:= F_OptFrm.GetSortType;
    rec_count:= F_DM.GetRecordCount;
    if  rec_count=0 then
     Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Наряды выполненных работ', MB_OK+MB_ICONINFORMATION)
    else
     if Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Наряды выполненных работ', MB_YESNO+MB_ICONQUESTION)=ID_YES then
          begin
              F_DM.PrepareDset;
              F_Pind.Hide;
               PrepareAndPrintFR( F_DM.frReport );
          end;
  end;
end;

function TVipolNaryad.GetMonthName(_DtBeg, _DtEnd: TDateTime): string;
var
  _Year, _MonthBeg, _MonthEnd, _Day: Word;
  _MonthArr: array[ 1..12 ] of string;
begin
  _MonthArr[ 1 ] := 'Январь';
  _MonthArr[ 2 ] := 'Февраль';
  _MonthArr[ 3 ] := 'Март';
  _MonthArr[ 4 ] := 'Апрель';
  _MonthArr[ 5 ] := 'Май';
  _MonthArr[ 6 ] := 'Июнь';
  _MonthArr[ 7 ] := 'Июль';
  _MonthArr[ 8 ] := 'Август';
  _MonthArr[ 9 ] := 'Сентябрь';
  _MonthArr[ 10 ] := 'Октябрь';
  _MonthArr[ 11 ] := 'Ноябрь';
  _MonthArr[ 12 ] := 'Декабрь';

  DecodeDate( _DtBeg, _Year, _MonthBeg, _Day );
  DecodeDate( _DtEnd, _Year, _MonthEnd, _Day );

  if _MonthBeg <> _MonthEnd then
    Result := _MonthArr[ _MonthBeg ] + '-' + _MonthArr[ _MonthEnd ]
  else
    Result := _MonthArr[ _MonthBeg ];
end;

function TVipolNaryad.GetYearName(_DtBeg, _DtEnd: TDateTime): string;
var
  _YearBeg, _YearEnd, _Month, _Day: Word;
begin
  DecodeDate( _DtBeg, _YearBeg, _Month, _Day );
  DecodeDate( _DtEnd, _YearEnd, _Month, _Day );

  if _YearBeg <> _YearEnd then
    Result := IntToStr( _YearBeg ) + '-' + IntToStr( _YearEnd )
  else
    Result := IntToStr( _YearBeg );
end;

procedure TVipolNaryad.InitFields;
begin
  F_Name := 'Наряды выполненных работ';
//  F_ReportFileName := 'VipolNaryad.frf';
  F_ReportFileName := 'VipolNaryad_p.frf';
  F_Pind.CancelButton := false;
end;

procedure TVipolNaryad.PrepareFastReport;
var
  _DtBeg, _DtEnd: TDateTime;
begin
  _DtBeg := F_OptFrm.frame_SelDates.BeginDate;
  _DtEnd := F_OptFrm.frame_SelDates.EndDate;

  frVariables[ 'YearNum' ] := GetYearName( _DtBeg, _DtEnd );
  frVariables[ 'MonthName' ] := GetMonthName( _DtBeg, _DtEnd );
  frVariables[ 'WorkType' ] := F_OptFrm.GetWorkTypeName;
  frVariables[ 'RegionName' ] := F_OptFrm.GetRegionName;
end;

{ TNetBar }

procedure TNetBar.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptNetBar, F_Name ) as Tfrm_OptNetBar;
  F_DM := CreateDataModule( Tdm_RepNetBar ) as Tdm_RepNetBar;
end;

function TNetBar.Execute: boolean;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    F_DM.DateBeg := F_OptFrm.frame_Dates.BeginDate;
    F_DM.DateEnd := F_OptFrm.frame_Dates.EndDate;

    F_Pind.Show;
    F_DM.PrepareDset;
    F_Pind.Hide;
    PrepareAndPrintFR( F_DM.frReport );

    Result := true;
  end;
end;

procedure TNetBar.InitFields;
begin
  F_Name := 'Сводка вскрытия сети';
  F_ReportFileName := 'NetBar.frf';
  F_Pind.CancelButton := false;
end;

procedure TNetBar.PrepareFastReport;
begin
  frVariables[ 'DtBeg' ] := DateToStr( F_OptFrm.frame_Dates.BeginDate );
  frVariables[ 'DtEnd' ] := DateToStr( F_OptFrm.frame_Dates.EndDate );
end;

{ TSvodExcav }

procedure TSvodExcav.CreateForms;
begin
  F_OptFrm:=CreateOptionForm( Tfrm_OptSvodExcav, F_Name) as Tfrm_OptSvodExcav;
  F_ResFrm:=CreateResultForm( Tfrm_AnalysisView, F_Name) as Tfrm_AnalysisView;
  F_DM:=CreateDataModule( Tdm_RepSvodExcav ) as Tdm_RepSvodExcav;
end;

function TSvodExcav.Execute: boolean;
begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    F_DM.BeginDate := F_OptFrm.frame_Dates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_Dates.EndDate;
    F_DM.RegItemList := F_OptFrm.frame_Region.ItemSelecter.SelItemList;
    F_DM.isFinish:=F_OptFrm.cb_IsFinish.ItemIndex;
    F_Pind.Show;
    F_DM.PrepareDset;
    PrepareResultForm;
    F_Pind.Hide;

    F_ResFrm.ShowModal;

    Result := true;
  end;
end;

procedure TSvodExcav.InitFields;
begin
  F_Name := 'Сводка по разрытию';
  F_ReportFileName := 'SvodExcav.frf';
  F_Pind.CancelButton := false;
end;

procedure TSvodExcav.OnDmgPlaceHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  case DataSet.FieldByName('id_damageplace').AsInteger of
    1: OutRow.Add('НА ВОДОПРОВОДНЫХ СЕТЯХ');
    2: OutRow.Add('НА ВОДОПРОВОДНЫХ ВВОДАХ');
    3: OutRow.Add('В СМОТРОВЫХ КОЛОДЦАХ');
    4: OutRow.Add('НА ВОДОРАЗБОРНЫХ КОЛОНКАХ');
    6: OutRow.Add('НА ШАХТНЫХ КОЛОДЦАХ');
    7: OutRow.Add('АБОНЕНТОВ НЕСТОЯЩИХ НА БАЛАНСЕ ОБЪЕДИНЕНИЯ');
    else OutRow.Add(AnsiUpperCase(trim(DataSet.FieldByName('DamagePlace').AsString)));
  end; //end case;
end;

procedure TSvodExcav.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR( F_DM.frReport );
end;

procedure TSvodExcav.OnRegHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do
    OutRow.Add('');

  OutRow.Add(NameCase(DataSet.FieldByName('Region').AsString)+' район');
end;

procedure TSvodExcav.PrepareFastReport;
begin
  frVariables[ 'BeginDate' ] := DateToStr( F_OptFrm.frame_Dates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_Dates.EndDate );
  frVariables[ 'Regions' ] := F_OptFrm.frame_Region.ItemSelecter.SelItemList.ItemsName;
end;

procedure TSvodExcav.PrepareResultForm;
var
  _gvb: TGridViewBuilder;
  _group: TGroup;
begin
  F_ResFrm.ResetForm;

  {Готовим Grid}
  _gvb := TGridViewBuilder.Create( F_DM.ResultDset, F_ResFrm.Grid );
  try
    with _gvb do
    begin
      IDFieldName:='ID';

      AddColToGVB( _gvb, 'DateComing', 'Дата'+#13+'поступления', alCenter );
      AddColToGVB( _gvb, 'OrderNumber', '№'+#13+'наряда', alCenter );
      AddColToGVB( _gvb, 'Adres', 'Адрес', alLeft );
      AddColToGVB( _gvb, 'DateClosed', 'Дата'+#13+'ликвидации', alCenter );
      AddColToGVB( _gvb, 'DamageLocality', 'Местность', alLeft );
      AddColToGVB( _gvb, 'ExcDate','Дата и время'+#13+'раскопки', alCenter );
      AddColToGVB( _gvb, 'ExcWt', 'Раскопка', alLeft );
      AddColToGVB( _gvb, 'AdditionalInfo','Дополнительная'+#13+'информация', alLeft );

      _group:=AddGroup( 'MainGr' );
      _group.IsNumberRecordInGroup := true;
      _group.GroupHeader.Visible := false;
      _group.GroupFooter.Visible := false;

      _group:=AddGroup( 'id_damageplace' );
      _group.GroupHeader.Visible := true;
      _group.GroupFooter.Visible := false;
      _group.GroupHeader.Color := clAqua;
      _group.GroupHeader.OnShowCaption := OnDmgPlaceHeaderCaption;
      _group.GroupHeader.Font.Style := [fsBold];
      _group.GroupHeader.Alignment := alCenter;

      _group:=AddGroup('id_region');
      _group.IsNumberRecordInGroup := true;
      _group.GroupHeader.Visible := true;
      _group.GroupFooter.Visible := false;
      _group.GroupHeader.Color := clGrayText;
      _group.GroupHeader.OnShowCaption := OnRegHeaderCaption;
      _group.GroupHeader.Font.Style := [fsBold];
      _group.GroupHeader.Alignment := alCenter;

      _gvb.BuildGridView;
    end; //end with
  finally
    _gvb.Free;
  end;
  {/Готовим Grid}

  {Готовим заголовок}
  F_ResFrm.CenterLabel :=
    'Сводка по разрытию за период'+#13+
    'с ' + DateToStr( F_OptFrm.frame_Dates.BeginDate ) + ' по ' + DateToStr( F_OptFrm.frame_Dates.EndDate );
  F_ResFrm.LeftLabel :=
    'Районы: ' + F_OptFrm.frame_Region.ItemSelecter.SelItemList.ItemsName;
  case F_Optfrm.cb_IsFinish.ItemIndex of
   0:F_ResFrm.LeftLabel:=F_ResFrm.LeftLabel+#13+'Раскопки:Все';
   1:F_ResFrm.LeftLabel:=F_ResFrm.LeftLabel+#13+'Раскопки:Невыполненные';
   2:F_ResFrm.LeftLabel:=F_ResFrm.LeftLabel+#13+'Раскопки:Выполненные';
  end; 
  {/Готовим заголовок}

  {Готовим кнопки}

  F_ResFrm.btn_Order.OnClick := OnOrderClick;
  F_ResFrm.btn_Print.OnClick := OnPrintClick;
  {/Готовим кнопки}
end;

{ TBlagItog }

procedure TBlagItog.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptBlagItog, F_Name ) as Tfrm_OptBlagItog;
  F_DM := CreateDataModule( Tdm_RepBlagItog ) as Tdm_RepBlagItog;
  F_PreviewFrm := Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
end;

function TBlagItog.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try
    F_DM.StartDate := F_OptFrm.StartDate;
    F_DM.BegDate := F_OptFrm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_SelDates.EndDate;

    if F_DM.PrepareDset then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;

procedure TBlagItog.InitFields;
begin
  F_Name := 'Итоговая таблица по благоустройству';
  F_ReportFileName := 'BlagItog.frf';
end;

procedure TBlagItog.PrepareFastReport;
begin
  frVariables[ 'BeginDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDate' ] := FormatDateTime( 'dd.mm.yy', F_OptFrm.frame_SelDates.EndDate );
end;

{ TBlagDetail }

procedure TBlagDetail.CreateForms;
begin
  F_DM := CreateDataModule( Tdm_RepBlagDetail ) as Tdm_RepBlagDetail;
  F_ResFrm := CreateResultForm( Tfrm_AnalysisView, F_Name ) as Tfrm_AnalysisView;
  F_PreviewFrm := Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
end;

function TBlagDetail.Execute: boolean;
begin
  F_Pind.Show;
  try
    F_DM.DetailInfo := F_DetailInfo;
    F_DM.SessionID := F_SessionID;
    F_DM.PrepareDset;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;
  finally
    F_Pind.Hide;
  end;
  F_ResFrm.ShowModal;

  Result := true;
end;

function TBlagDetail.GetCaption: string;
var
  _exc: string;
  _sBegEnd, _sBeg, _sEnd, _sGran: string;
begin
  if F_ExcType = etAsfalt then
    _exc := ', требующих восстановления а/б покрытия'
  else
    _exc := ' на зеленой зоне';

  _sBegEnd := 'c ' + FormatDateTime( 'dd.mm.yy', F_BeginDate ) + 'г. по ' + FormatDateTime( 'dd.mm.yy', F_EndDate ) + 'г.' ;
  _sBeg := 'по состоянию на ' + FormatDateTime( 'dd.mm.yy', F_BeginDate );
  _sEnd := 'по состоянию на ' + FormatDateTime( 'dd.mm.yy', F_EndDate );
  _sGran := 'по состоянию на ' + FormatDateTime( 'dd.mm.yy', F_GranDate );

  case F_DetailInfo of
    diNeedRestore:
      Result := Format( 'Необходимо благоустроить разрытий%s %s', [ _exc, _sBeg ] );
    diNeedRestoreGran:
      Result := Format( 'Необходимо благоустроить разрытий%s %s', [ _exc, _sGran ] );
    diPlanRestore:
      Result := Format( 'Планируется благоустроить разрытий%s %s', [ _exc, _sBegEnd ] );
    diRestoredPlan:
      Result := Format( 'Благоустроено по плану разрытий%s %s', [ _exc, _sBegEnd ] );
    diNewExc:
      Result := Format( 'Выполнено аварийных разрытий%s %s', [ _exc, _sBegEnd ] );
    diRestoredNoplan:
      Result := Format( 'Восстановлено аварийных и внеплановых разрытий%s %s', [ _exc, _sBegEnd ] );
    diInWork:
      Result := Format( 'Остается в наличии разрытий%s %s', [ _exc, _sEnd ] );
    diOstatGran:
      Result := Format( 'Остается в наличии разрытий%s %s', [ _exc, _sGran ] );
    diTotalRestored:
      Result := Format( 'Всего восстановлено разрытий%s %s', [ _exc, _sBegEnd ] );
  end;
end;

procedure TBlagDetail.InitFields;
begin
  F_Name := 'Детальная информация по благоустройству';
  F_ReportFileName := 'BlagDetail.frf';
  F_DetailInfo := diNull;
  F_ExcType := etNull;
  F_SessionID := -1;
end;

procedure TBlagDetail.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR( F_DM.frReport );
end;

procedure TBlagDetail.OnShowRegHeader(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
var
  i: integer;
begin
  for i:=1 to 4 do OutRow.Add('');
  OutRow.Add( NameCase( trim( DataSet.FieldByName( 'region' ).AsString ) ) );
end;

procedure TBlagDetail.PrepareFastReport;
begin
  frVariables[ 'Caption' ] := GetCaption;
  frVariables[ 'StartDate' ] := FormatDateTime( 'dd.mm.yy', F_StartDate );
end;

procedure TBlagDetail.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
  F_ResFrm.btn_Print.OnClick:=OnPrintClick;
end;

procedure TBlagDetail.PrepareResultFormGrid;
var
  _gvb: TGridViewBuilder;
  _group: TGroup;
begin
  _gvb := TGridViewBuilder.Create( F_DM.ResultDset, F_ResFrm.Grid );
  try
    _gvb.IDFieldName := 'id_order';

    AddColToGVB( _gvb, 'OrderNumber', 'Номер'+#13+'заявки', alCenter );
    AddColToGVB( _gvb, 'DateComing', 'Дата/время'+#13+'поступления', alLeft );
    AddColToGVB( _gvb, 'Adres', 'Адрес', alLeft );
    AddColToGVB( _gvb, 'DamagePlace', 'Место'+#13+'повреждения', alLeft );
    AddColToGVB( _gvb, 'DamageLocality', 'Местность'+#13+'повреждения', alLeft );
    AddColToGVB( _gvb, 'raskop_dt', 'Дата/время'+#13+'раскопки', alLeft );

    _group := _gvb.AddGroup( 'main_gr' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupHeader.Visible := false;
    _group.GroupFooter.Visible := false;

    _group := _gvb.AddGroup( 'region' );
    _group.IsNumberRecordInGroup := true;
    _group.GroupFooter.Visible := false;
    _group.GroupHeader.Visible := true;
    _group.GroupHeader.Font.Style := [fsBold];
    _group.GroupHeader.Color := clMoneyGreen;
    _group.GroupHeader.Alignment := alCenter;
    _group.GroupHeader.OnShowCaption := OnShowRegHeader;

    _gvb.BuildGridView;
  finally
    _gvb.Free;
  end;
end;

procedure TBlagDetail.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel := GetCaption;
end;

{ TSvodka062 }

procedure TSvodka062.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptSvodka062, F_Name ) as Tfrm_OptSvodka062;
  F_DM := CreateDataModule( Tdm_Svodka062 ) as Tdm_Svodka062;
  F_ResFrm := CreateResultForm( Tfrm_AnalysisView, F_Name ) as Tfrm_AnalysisView;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);         //glasha 15.07.2011
end;
  // glasha 15.07.2011
procedure TSvodka062.ExcelBtnClick(Sender: TObject);

var
  Grid: TStringAlignGrid;
  Res: TStringAlignGrid;
  Title: string;
  CentrLbl, LeftLbl: string;
  i:integer;
begin
   for i:=0 to F_ResFrm.ComponentCount-1 do
    if (F_ResFrm.Components[i] is TStringAlignGrid) then
    begin
      Res:=(F_ResFrm.Components[i] as TStringAlignGrid);
      break;
    end;
    Grid:=Res;
  if not Assigned(Grid) then exit;

  //Только для случая, когда ResultForm - это Tfrm_AnalysiView
  if (F_ResFrm is Tfrm_AnalysisView) then
  begin
    CentrLbl:=(F_ResFrm as Tfrm_AnalysisView).CenterLabel;
    LeftLbl:=(F_ResFrm as Tfrm_AnalysisView).LeftLabel;
  end else exit;

  with TExcelWorks.Create do
  begin
    try
      Title:=ReplaceChar(CentrLbl, #13, ' ');
      if trim(Title)<>'' then Title:=Title+';';
      Title:=Title+ReplaceChar(LeftLbl, #13, ';');

      Close;
      SetWSName('Результаты поиска');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid(Grid);
    finally
      Free;
    end;
  end;
end;

  //
function TSvodka062.Execute: boolean;
begin
  if F_OptFrm.ShowModal <> mrOK then
    Result := false
  else
  begin
    F_DM.BegDt := F_OptFrm.frame_SelDateTime.BeginDateTime;
    F_DM.EndDt := F_OptFrm.frame_SelDateTime.EndDateTime;
    F_DM.OrderType := F_OptFrm.GetOrderType;

    F_Pind.Show;
    try
      F_DM.PrepareDset;


      PrepareResultFormHeader;
      PrepareResultFormGrid;
      PrepareResultFormBtns;
    finally
      F_Pind.Hide;
    end;

    F_ResFrm.ShowModal;

    Result := true;
  end;
end;

procedure TSvodka062.InitFields;
begin
  F_Name := 'Сводка по работе с заявками 062 "наружные сети"';
  F_ReportFileName := 'Svodka062.frf';
  F_Pind.CancelButton:=false;
  F_Pind.OnCancel:=nil;
end;
//
procedure  TSvodka062.OnClose_ZClick(Sender: TObject);
begin
  try
   F_Pind.Show;
    //F_ResFrm.pnl_Wait.Show;
    F_DM.To1526;

   finally
    //F_ResFrm.pnl_Wait.Hide;
     F_Pind.Hide;
   F_ResFrm.btn_Close_Z.Enabled:=false;
   end;


end;
//
procedure TSvodka062.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TSvodka062.PrepareFastReport;
begin
  frVariables[ 'BegDt' ] := F_OptFrm.frame_SelDateTime.BeginDateTime;
  frVariables[ 'EndDt' ] := F_OptFrm.frame_SelDateTime.EndDateTime;
  frVariables[ 'OrderType' ] := F_OptFrm.GetOrderTypeName;
end;

procedure TSvodka062.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick := OnOrderClick;
  F_ResFrm.btn_Print.OnClick := OnPrintClick;
 // F_ResFrm.btn_Excel.OnClick := ExcelBtnClick;
 if DM_RightsManager.CurrentUserGroupID=1 then begin   //надо сменить 1 на 2 !!!!!
    F_ResFrm.btn_Close_Z.OnClick := OnClose_ZClick ;
     F_ResFrm.btn_Close_Z.Enabled:=true;
 end
 else
  F_ResFrm.btn_Close_Z.OnClick := nil;

end;

procedure TSvodka062.PrepareResultFormGrid;
var
  _gvb: TGridViewBuilder;
  _col: TGBColumn;
begin
  _gvb := TGridViewBuilder.Create( F_DM.ResultDset, F_ResFrm.Grid );
  try
    _gvb.IDFieldName := 'id';
    _gvb.IsNumberRecord := true;

    AddColToGVB( _gvb, 'OrderNumber', 'Номер'+#13+'наряда', alCenter );
    AddColToGVB( _gvb, 'DateComing', 'Дата/время'+#13+'поступления', alCenter );
    AddColToGVB( _gvb, 'Region', 'Район', alLeft );
    AddColToGVB( _gvb, 'Adres', 'Адрес', alLeft );
    AddColToGVB( _gvb, 'DamagePlace', 'Место повреждения', alLeft );
    AddColToGVB( _gvb, 'DateClosed', 'Дата/время'+#13+'закрытия', alCenter );

    _col :=AddColToGVB( _gvb, 'SONums', 'Номера'+#13+'заявок(0-62)', alCenter );//glasha 15.07.11


    _col := AddColToGVB( _gvb, 'works', 'Что сделано', alLeft );
    _col.DisplayWidth := 40;

    _gvb.BuildGridView;
  finally
    _gvb.Free;
  end;
end;

procedure TSvodka062.PrepareResultFormHeader;
begin
  F_ResFrm.CenterLabel :=
    F_Name + #13 +
    'за период с ' + DateToStr( F_OptFrm.frame_SelDateTime.BeginDateTime ) +
    ' по ' + DateToStr( F_OptFrm.frame_SelDateTime.EndDateTime );
  F_ResFrm.LeftLabel := 'Заявки: ' + F_OptFrm.GetOrderTypeName+
    #13 +'ИТОГО: ' + IntToStr(F_DM.KolZayav);
end;

{ TBlag2 }

procedure TBlag2.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptBlag2, F_Name ) as Tfrm_OptBlag2;
  F_DM := CreateDataModule( Tdm_RepBlag2 ) as Tdm_RepBlag2;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TBlag2.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.BegDate := F_OptFrm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_SelDates.EndDate;
    F_DM.blag := F_OptFrm.rgblag;
    F_DM.GZ := F_OptFrm.GZ;
    F_DM.ASF := F_OptFrm.RGASF;

    if F_DM.PrepareDset then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;

procedure TBlag2.InitFields;
begin
  F_Name := 'Сводка по благоустройству в ГИК №2';
  F_ReportFileName := 'Blag2.frf';
end;

procedure TBlag2.PrepareFastReport;
begin
  case F_OptFrm.rgblag of
   0: begin
          frVariables[ 'isall' ] := ' все наряды ';
          frVariables[ 'asf' ] := '  ';
      end;
   1: begin
          frVariables[ 'isall' ] := ' незаконченное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   2: begin
           frVariables[ 'isall' ] := ' полное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   end; //case

  if F_OptFrm.GZ then frVariables[ 'green' ] := ', с зелёной зоной '
      else frVariables[ 'green' ] := ', без зелёной зоны ';

  frVariables[ 'BegDate' ] := DateToStr( F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_SelDates.EndDate );
end;

{TDisconKPVoda}
procedure TDisconKPVoda.InitFields;
  begin
  F_Name := 'Сводка отключенийКП ''Харьковводоканал ''';
  F_ReportFileName := 'DisconnectedKPVoda.frf';
  end;


procedure TDisconKPVoda.CreateForms;
 begin
  F_OptFrm := CreateOptionForm( Tfrm_DateSelCB, F_Name ) as Tfrm_DateSelCB;
  F_DM := CreateDataModule( Tdm_DisconKPVoda ) as Tdm_DisconKPVoda;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
 end;

procedure TDisconKPVoda.PrepareFastReport;
var sDtIn:string;
  begin
   sDtIn:=DateToStr(F_OptFrm.dp_Date.Date);
    frVariables['Caption']:='Сводка отключений  КП ''Харьковводоканал '' по состоянию на '+
      sDtIn ;
    if F_OptFrm.CB.Checked then frVariables['day_hour_caption']:='Дней без воды'
       else frVariables['day_hour_caption']:='Часов без воды';
  end;

function TDisconKPVoda.Execute: boolean;
 begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.NCDP:= F_OptFrm.CB.Checked;
    F_DM.DisconDate := F_OptFrm.dp_Date.Date;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
  end;
 end;


{/TDisconKPVoda}

{TBlag3}
procedure TBlag3.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptBlag2, F_Name ) as Tfrm_OptBlag2;
  F_DM := CreateDataModule( Tdm_RepBlag4 ) as Tdm_RepBlag4;
  //F_DM.ForGIK := false;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TBlag3.InitFields;
begin
  F_Name := 'Сводка по благоустройству в ГИК №3';
  F_ReportFileName := 'Blag2.frf';
end;


procedure TBlag3.PrepareFastReport;
begin
  case F_OptFrm.rgblag of
   0: begin
          frVariables[ 'isall' ] := ' все наряды ';
          frVariables[ 'asf' ] := '  ';
      end;
   1: begin
          frVariables[ 'isall' ] := ' незаконченное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   2: begin
           frVariables[ 'isall' ] := ' полное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   end; //case

  if F_OptFrm.GZ then frVariables[ 'green' ] := ', с зелёной зоной '
      else frVariables[ 'green' ] := ', без зелёной зоны ';

  frVariables[ 'BegDate' ] := DateToStr( F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_SelDates.EndDate );
end;

function TBlag3.Execute: boolean;
begin
  Result := false;
  try
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
    if F_DM.PrepareDset then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
  except
   result:=false;
  end ;
end;

{/TBlag3}

{TObrZas}
procedure TObrZas.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptObrZas, F_Name ) as Tfrm_OptObrZas;
  F_DM := CreateDataModule( Tdm_RepObrZas ) as Tdm_RepObrZas;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TObrZas.InitFields;
begin
  F_Name := 'Сводка адресов обратной засыпки';
  F_ReportFileName := 'ObrZas.frf';
end;


procedure TObrZas.PrepareFastReport;
begin
  frVariables[ 'BegDate' ] := DateToStr( F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_SelDates.EndDate );
end;

function TObrZas.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.BegDate := F_OptFrm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptFrm.frame_SelDates.EndDate;


    if F_DM.PrepareDset then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;

{/TObrZas}

{TBlag3GIK}

procedure TBlag3GIK.InitFields;
begin
  F_Name := 'Сводка по благоустройству в ГИК №3';
  F_ReportFileName := 'Blag3GIK.frf';
//  F_ReportFileName := 'Blag2.frf';
end;

procedure TBlag3GIK.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_OptBlag2, F_Name ) as Tfrm_OptBlag2;
  F_DM := CreateDataModule( Tdm_RepBlag4 ) as Tdm_RepBlag4;
  F_DM.ForGIK := true;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;


{/TBlag3GIK}


{TBlagPodr}

 procedure TBlagPodr.InitFields;
 begin
  F_Name := 'Сводка по благоустройству подрядчиками';
  F_ReportFileName := 'BlagPodr.frf';
 end;

 procedure TBlagPodr.CreateForms;
 begin
  F_OptFrm := CreateOptionForm( Tfrm_PeriodRegSel, F_Name ) as Tfrm_PeriodRegSel;
  F_DM := CreateDataModule( Tdm_BlagPodr ) as Tdm_BlagPodr;
  F_PreviewFrm := Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
 end;

 procedure TBlagPodr.PrepareFastReport;
 const smech=20;
 var i:integer;
     Memo:TFrView;
 begin
    frVariables['Caption']:='Сводка по благоустройству подрядными организациями '+
         ' c '+ datetostr(F_OptFrm.dp_Date1.Date) + ' по ' +  datetostr(F_OptFrm.dp_Date2.Date);
    frVariables['year']:=GetYear(F_OptFrm.dp_Date1.Date);
    if  GetYear(F_OptFrm.dp_Date1.Date)<>GetYear(F_OptFrm.dp_Date2.Date) then
     frVariables['year']:=IntTOStr(frVariables['year'])+'-'+IntToStr(GetYear(F_OptFrm.dp_Date2.Date));
    for i:=0 to f_Dm.memasfcompany.RecordCount do
    begin
     Memo:= F_Dm.frReport.Pages[1].FindObject('MH'+IntToStr(i+1));
     if assigned(Memo) then
     begin
      Memo.Memo.Text:=f_Dm.memSvod.Fields[i*2+1].DisplayLabel;
      if  f_Dm.memSvod.Fields[i*2+1].FieldName='Comp0_count' then
          Memo.dx:=Memo.dx-smech;
      Memo.Visible:=true;
     end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MD'+IntToStr(i+1)+'1');
     if assigned(memo) then
     begin
        Memo.Memo.Text:='[memSvod."'+f_Dm.memSvod.Fields[i*2+1].FieldName+'"]';
        Memo.Visible:=true;
        if f_Dm.memSvod.Fields[i*2+1].FieldName='Comp0_count'  then
        begin
         (Memo as TfrMemoView).Font.Style:=[fsBold];
         (Memo as TfrMemoView).dx:=(Memo as TfrMemoView).dx-smech;
        end;
     end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MD'+IntToStr(i+1)+'2');
     if assigned(memo) then
     begin
       Memo.Memo.Text:='[memSvod."'+f_Dm.memSvod.Fields[i*2+2].FieldName+'"]';
       Memo.Visible:=true;
       if f_Dm.memSvod.Fields[i*2+2].FieldName='Comp0_square'  then
         begin
         (Memo as TfrMemoView).Font.Style:=[fsBold];
          Memo.x:=Memo.x-smech;
         end;
     end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MH'+IntToStr(i+1)+'1');
     if assigned(memo) then
       begin
          Memo.Visible:=true;
          if f_Dm.memSvod.Fields[i*2+2].FieldName='Comp0_square'  then
          begin
          (Memo as TfrMemoView).Font.Style:=[fsBold];
           Memo.dx:=Memo.dx-smech;
         end;
       end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MH'+IntToStr(i+1)+'2');
     if assigned(memo) then
      begin
        Memo.Visible:=true;
        if f_Dm.memSvod.Fields[i*2+2].FieldName='Comp0_square'  then
        begin
         (Memo as TfrMemoView).Font.Style:=[fsBold];
         Memo.x:=memo.x-smech;
        end;
      end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MF'+IntToStr(i+1)+'1');
     if assigned(memo) then
     begin
        Memo.Memo.Text:='[SUM(memSvod."'+f_Dm.memSvod.Fields[i*2+1].FieldName+'")]';
        Memo.Visible:=true;
        if f_Dm.memSvod.Fields[i*2+1].FieldName='Comp0_count'  then
        begin
         (Memo as TfrMemoView).Font.Style:=[fsBold];
          Memo.dx:=memo.dx-smech;
        end;
     end;
     Memo:= F_Dm.frReport.Pages[1].FindObject('MF'+IntToStr(i+1)+'2');
     if assigned(memo) then
     begin
       Memo.Memo.Text:='[SUM([memSvod."'+f_Dm.memSvod.Fields[i*2+2].FieldName+'"])]';
       Memo.Visible:=true;
       if f_Dm.memSvod.Fields[i*2+2].FieldName='Comp0_square'  then
       begin
         (Memo as TfrMemoView).Font.Style:=[fsBold];
          Memo.x:=Memo.x-smech;
       end;
     end;

    end;



 end;

 function TBlagPodr.Execute;
  begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date1.Date;
    F_DM.DtEnd := F_OptFrm.dp_Date2.Date;
    F_DM.RegionsID := F_OptFrm.RegionsID;
    F_DM.asfcompanyID:=F_OptFrm.asfcompanyID;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
  end;

  end;

{/TBlagPodr}

{NaledRep}

 procedure TNaledRep.InitFields;
 begin
  F_Name := 'Сводка по наледям';
  F_ReportFileName := 'NaledRep.frf';
 end;

 procedure TNaledRep.CreateForms;
 begin
  F_OptFrm := CreateOptionForm( Tfrm_PeriodRegSel, F_Name ) as Tfrm_PeriodRegSel;
  F_DM := CreateDataModule( Tdm_NaledRep ) as Tdm_NaledRep;
 end;

 procedure TNaledRep.PrepareFastReport;
 begin
    frVariables['Caption']:='Сводка по наледям '+
         ' c '+ datetostr(F_OptFrm.dp_Date1.Date) + ' по ' +  datetostr(F_OptFrm.dp_Date2.Date);
 end;

 function TNaledRep.Execute;
  begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date1.Date;
    F_DM.DtEnd := F_OptFrm.dp_Date2.Date;
    F_DM.RegionsID := F_OptFrm.RegionsID;
    F_DM.AsfCompanyId:=F_OptFrm.asfcompanyID;
    F_Dm._typ:=f_optFrm.cb_Type.ItemIndex;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
  end;

  end;


{/NaledRep}

{TSheben}

 procedure TSheben.InitFields;
 begin
  F_Name := 'Сводка выполнения щебенения';
  F_ReportFileName := 'Sheben.frf';
 end;

 procedure TSheben.CreateForms;
 begin
  F_OptFrm := CreateOptionForm( Tfrm_PeriodRegSel, F_Name ) as Tfrm_PeriodRegSel;
  F_DM := CreateDataModule( Tdm_ShebenDModule ) as Tdm_ShebenDModule;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM,  F_DM.frReport);
 end;

 procedure TSheben.PrepareFastReport;
 begin
    frVariables['Caption']:=F_Name +
         ' c '+ datetostr(F_OptFrm.dp_Date1.Date) + ' по ' +  datetostr(F_OptFrm.dp_Date2.Date);

    frVariables['Regions']:= F_OptFrm.strRegions;
    F_PreviewFrm.PreviewButtons := [pbPrint, pbExcel];
 end;

 function TSheben.Execute;
  begin
  if F_OptFrm.ShowModal <> mrOk then
  begin
    Result := false;
  end else
  begin
    Result := true;

    F_Pind.Show;
    F_DM.DtBeg := F_OptFrm.dp_Date1.Date;
    F_DM.DtEnd := F_OptFrm.dp_Date2.Date;
    F_DM.RegionsID := F_OptFrm.RegionsID;
    F_DM.PrepareDset;
    F_Pind.Hide;

    PrepareAndPrintFR( F_DM.frReport );
  end;

  end;

{/TSheben}


{TAVRDisconnections}

 procedure TAVRDisconnections.InitFields;
 begin
  F_Name := 'Отключения в ДКХ';
  F_ReportFileName := 'AVRDiscon.frf';
 end;

 procedure TAVRDisconnections.CreateForms;
 begin
 // F_OptFrm := CreateOptionForm( Tfrm_PeriodRegSel, F_Name ) as Tfrm_PeriodRegSel;
  F_OptFrm := CreateOptionForm( Tfrm_OptAvrDiscon ,F_name) as  Tfrm_OptAvrDiscon;
  F_ResFrm := TAVRDisconnResultForm.Create(nil);
//  F_DM := CreateDataModule( Tdm_AVRDisconn ) as Tdm_AVRDisconn;
  F_DM := Tdm_AVRDisconn.Create(nil);
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport1);
 end;

 procedure TAVRDisconnections.PrepareFastReport;
 begin
   // frVariables['Caption']:='Сводка по наледям '+
   //      ' c '+ datetostr(F_OptFrm.dp_Date1.Date) + ' по ' +  datetostr(F_OptFrm.dp_Date2.Date);
 end;

function TAVRDisconnections.Execute;
begin

  Result:=false;

  if F_OptFrm.ShowModal<>mrOk then exit;

  F_Pind.Show;
//  F_DM.Dt_beg:=F_OptFrm.dp_Date1.Date;
//  F_DM.Dt_end:=F_OptFrm.dp_Date2.Date;
//  F_DM.strRegionsID:=F_OptFrm.RegionsID;
  F_DM.Opened:=F_OptFrm.typ;
  if F_DM.PrepareDsets then
  begin
    PrepareResultFormGrid;
    PrepareResultFormBtns;
    F_ResFrm.ShowModal;
  end;



  F_Pind.Hide;

  Result:=true;

end;

procedure TAVRDisconnections.PrepareResultFormBtns;
begin

//  F_ResFrm.bt_LoadData.OnClick:=OnPrintClick;
  F_ResFrm.btSendAndSave.OnClick := OnPrintClick;
  F_ResFrm.btSave.OnClick := OnSaveData;
//  F_PreviewFrm.bb_Mail.Caption := 'Отослать по e-mail';

  F_PreviewFrm.bb_Mail.Visible := DM_RightsManager.IsCurrentUserDisp; //07.08.2012
 // F_ResFrm.btSendAndSave.Caption:='Печать сводки и автоматический посыл по e-mail';
end;

procedure TAVRDisconnections.PrepareResultFormGrid;
begin
    F_ResFrm.grid.DataSource := F_DM.ds_result;
    F_ResFrm.DBNavigator1.DataSource := F_DM.ds_result;
    F_ResFrm.grid.Visible := true;
end;


procedure TAVRDisconnections.OnSaveData(Sender: TObject);
begin
   //
   //F_DM.SaveToBases;
end;

function TAVRDisconnections.GetFileName(var filename :string):string;
  function PartOfDay: string;
   begin
      if frac(Now) < 0.5 then
          result := '_1'
          else
          result := '_2';
   end;
begin
 result:=trim('disconAVR_'+ReplaceChar(DateToStr(Date), '.', '_'))+ PartOfDay + '.xls';
 filename:=result;
 result:= AppSettings.Get_Abon_Path + result;
end;

procedure TAVRDisconnections.OnPrintClick(Sender: TObject);
var file_name, full_fn: string;
    pos:integer;

  procedure PrintFR(fr_rep: TfrReport);
      begin
        if LoadReportFileTo(fr_rep) then
        begin
          PrepareFastReport;
          fr_rep.PrepareReport;

          fr_rep.ShowPreparedReport;
          if Assigned(fr_rep.Preview) then
            (fr_rep.Preview.Owner as TForm).ShowModal;
        end;
      end;



begin
 //
//   PrepareAndPrintFR(F_DM.frReport);
  F_DM.SaveToBases;
  F_PreviewFrm.NeedAsk := true;
  F_PreviewFrm.NameReport := F_Name;
  PrintFR(F_DM.frReport1);
    {Отправка по почте}
  F_PreviewFrm.NeedAsk := true;
  F_PreviewFrm.NameReport := F_Name;
  if F_PreviewFrm.ToMail and (DM_RightsManager.IsCurrentUserDisp) then
  //  if Application.MessageBox('Отправить сформированную ведомость по почте?',
  //      PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
    begin
      F_Pind.Show;
      F_Pind.Caption:='Идет отправка по почте!!!';
      try
       full_fn:= GetFileName(file_name);
     // ExportFastReportToExcel(F_DM.frReport, file_name );
       F_Pind.StepBy(50);
       if F_DM.ExportFRToFile(f_dm.frReport1, full_fn) then
         begin
               F_DM.SaveFileNameToBase(file_name);
               F_Pind.StepBy(50);
                SendByEmail(Full_fn, 'Отключения КП "Харьковводоканал"');
                F_Pind.StepBy(50);
         end;
  //    ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
       finally
        F_Pind.Hide;
       end;
       end;
    {/Отправка по почте}
end;

{/TAVRDisconnections}


{TPovrRegion}

procedure TPovrRegion.CreateForms;
begin
  F_DM := CreateDataModule( Tdm_RepPovrRegion ) as Tdm_RepPovrRegion;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
  if  (DM_RightsManager.CurrentDistrictID = CDP_DISTRICT_ID) and DM_RightsManager.IsCurrentUserDisp then
      F_PreviewFrm.bb_Mail.Visible := true else F_PreviewFrm.bb_Mail.Visible := false;

end;

function TPovrRegion.Execute: boolean;

    procedure EMailPrint;
    var
      file_name: string;
      begin
        {Отправка по почте}
       // if Application.MessageBox('Отправить сформированную ведомость по почте?',
       //     PChar(F_Name), MB_YESNO+MB_ICONQUESTION)=IDYES then
        begin
          file_name:=trim(AppSettings.Get_Abon_Path+
                        'svod_reg_'+ReplaceChar(DateToStr(Date), '.', '_'));

          ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
          //ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
        end;
        {/Отправка по почте}
    end;


begin
    F_Pind.Show;
    F_DM.PrepareDset;
    F_Pind.Hide;
    
    PrepareAndPrintFR( F_DM.frReport );
    if F_PreviewFrm.ToMail then EMailPrint;

    Result := false;
end;

procedure TPovrRegion.InitFields;
begin
  F_Name := 'Сводка для Октябрьского РИК';
  F_ReportFileName := 'PovrRegion.frf';
  F_Pind.CancelButton := false;
end;

procedure TPovrRegion.PrepareFastReport;
begin
  frVariables[ 'reccount' ] := F_DM.DisconCount;
end;


{/TPovrRegion}


{/ TUniversalSearch2}



{ TInfBlag }

procedure TInfBlag.CreateForms;
begin
  F_OptFrm := CreateOptionForm( Tfrm_InfBlag, F_Name ) as Tfrm_InfBlag;
  F_DM := CreateDataModule( Tdm_NGRepInfBlag ) as Tdm_NGRepInfBlag;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TInfBlag.Execute: boolean;
begin
  Result := false;

  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.BegDate := F_OptFrm.frame_SelDateTimePeriod1.BeginDateTime;
    F_DM.EndDate := F_OptFrm.frame_SelDateTimePeriod1.EndDateTime;
    F_DM.blag := F_OptFrm.typeBlag;

    if F_DM.PrepareDset then
      prepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;

procedure TInfBlag.InitFields;
begin
  F_Name :='Информация по благоустройству ';
  F_ReportFileName := 'InfBlag.frf';
end;

procedure TInfBlag.PrepareFastReport;
begin
case  F_OptFrm.typeblag of
    1:begin
       frVariables['vost']:='восстановлению';
       frVariables['zone']:='';
      end;
    2:begin
       frVariables['vost']:='благоустройству';
       frVariables['zone']:='на зеленой зоне';
      end;
end;
  frVariables[ 'BegDate' ] := DateTimeToStr( F_OptFrm.frame_SelDateTimePeriod1.BeginDateTime);
  frVariables[ 'EndDate' ] := DateTimeToStr( F_OptFrm.frame_SelDateTimePeriod1.EndDateTime );
end;
{/}

{TRSvoVed}
function TRSvoVed.execute:boolean;
begin
 Result:=false;
 if F_OptFrm.ShowModal<>mrOk then exit;

 F_dtbeg:=F_optFrm.BeginDateTime;
 F_dtend:=F_optFrm.EndDateTime;
 F_DM.BegDate:=F_optFrm.BeginDateTime;
 F_DM.EndDate:=F_optFrm.EndDateTime;
 F_DM.Regions_id:=F_optFrm.F_RegionsID;
 F_DM.typ:=F_optFrm.F_Typ;
 F_DM.Orgs_id:= F_optFrm.F_organs_ID;
F_DM.DamPlace_ID := F_OptFrm.F_DamagePlace_ID;

 if F_Dm.PrepareDsets_ns then
 begin
     PrepareAndPrintFR(F_DM.frReport);
 end;
 Result:=true;
end;


procedure TRSvoVed.InitFields;
begin
  F_Name:='Расширенная сводная ведомость  ';
  F_ReportFileName:='RSvod_ved_ns.frf'
end;

procedure TRSvoVed.CreateForms;
begin
 F_Dm:= CreateDataModule(Tdm_RSvodved) as Tdm_RSvodved;
 F_OptFrm:=CreateOptionForm(Tfrm_OptRSvod_ns, F_Name) as Tfrm_OptRSvod_ns;
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TRSvoVed.PrepareFastReport;
begin
 frVariables['PrintDateTime']:=formatdatetime('dd.mm.yyyy hh:mm',Now());
 frVariables['beg_date']:=formatdatetime('dd.mm.yyyy hh:mm',F_dtbeg);
 frVariables['end_date']:= F_dtend;//formatdatetime('dd.mm.yyyy hh:mm',F_dtend);

end;
{/TRSvoVed}

//03.10.2012
{ TblagRasr}

procedure TblagRasr.CreateForms;
begin
 F_Dm:=CreateDataModule(Tdm_SBlagRazr) as Tdm_SBlagRazr;
 F_OptForm:=CreateOptionForm(Tfrm_OptBlagRazr, F_Name) as Tfrm_OptBlagRazr;
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;


procedure TblagRasr.InitFields;
begin
 F_Name:='Сводная ведомость по благоустройству разрытий';
 F_ReportFileName:='BlagRazrRep.frf' ;
end;

procedure TblagRasr.PrepareFastReport;
begin
 frVariables['Startdate']:=formatDatetime('dd.mm.yyyy',F_dt_beg);

 frVariables['Enddate']:=formatDatetime('dd.mm.yyyy',F_dt_end);


 frVariables['PrintDate']:=formatDatetime('dd.mm.yyyy hh:mm',Now());

end;

function TblagRasr.Execute:boolean;
begin
 Result:=false;
 if F_optForm.ShowModal<> mrOk then exit;

 F_dt_beg:=F_optForm.frame_SelDates.BeginDate;
 F_dt_end:=F_optForm.frame_SelDates.EndDate;
 F_Dm.Dt_Beg:=F_dt_beg;
 F_Dm.Dt_End:=F_dt_end;
 if F_Dm.preparedsets then
       PrepareAndPrintFR(F_DM.frReport);
 Result:=true;
end;

{/}

{TSTexnik 18.12.2012}
procedure TsTexnik.InitFields;
begin
 F_ReportFileName:='SvodPlanTexnik.frf';
 F_Name:='Сводка запланированной техники';
// F_Date_Beg:=F_Date;
// F_Now:=NOw();

end;

procedure TsTexnik.CreateForms;
begin
  F_OptForm:=CreateOptionForm(Tfrm_SOptTexn,F_name) as Tfrm_SOptTexn;
  F_Dm:=CreateDataModule(Tdm_STexn) as Tdm_STexn;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

function TsTexnik.Execute;
begin
 Result:=false;
 F_optForm._Date:=Date();
 if F_optForm.ShowModal<>mrOk then exit;
 f_dt_Beg:=F_optForm._Date;
 F_DM.Date:=f_dt_Beg;
 if F_DM.PrepareDsets then
   PrepareAndPrintFR(F_DM.frReport);
 Result:=true;
end;

procedure  TsTexnik.PrepareFastReport;
begin
frVariables['Dt_Beg']:=DateToStr(F_Dt_Beg);
frVariables['Dt_Now']:=FormatDateTime('dd.mm.yyyy hh:mm',Now());
DateTostr(NOw());
end;
{/}

{TSPlan_Work 22.01.2013}
procedure TSPlan_Work.InitFields;
begin
   F_ReportFileName:='SPlanWorks.frf';
   F_Name:='План проведения работ';
end;

procedure TSPlan_Work.CreateForms;
begin
 F_optForm:=CreateOptionForm(Tfrm_OptPlanWork,F_Name) as Tfrm_OptPlanWork;
 f_Dm:=CreateDataModule(Tdm_SPlanWork) as Tdm_SPlanWork;
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);

 
end;

procedure TSPlan_Work.PrepareFastReport;
begin
frVariables['Date']:=FormatDateTime('dd.mm.yyyy',f_Dt);
frVariables['REgion']:=F_region;
end;

function  TSPlan_Work.Execute :boolean;
begin
 REsult:=false;
 if F_optForm.ShowModal<>mrOk then exit;
 F_region:=F_optForm.REgion;
 F_dt:=F_optForm._Date;
 F_REgion_ID:=F_optForm.Region_ID;
 F_Dm.Region_ID:=F_REgion_ID;
 f_Dm._Date:=F_Dt;
 if     (F_region_ID>0)and (F_region_ID<10)  then begin
 F_Region:=trim(F_Region);
 delete(F_Region,length(F_Region)-1,2);
 F_REgion:=F_Region+'ОГО района';
 end
 else
 if F_REgion_ID>=10 then
  F_REgion:='"'+F_Region+'"'
  else
    F_REgion:='';
 if F_Dm.PrepareDsets then
   PrepareAndPrintFR(F_DM.frReport);
 REsult:=true;
end;
{/}


 //18.04.2013 новая сводка по заявкам
{ TSvPoZayvkam}


procedure TSvPoZayvkam.InitFields ;
 begin
  F_Name := 'Сводка по работе с заявками  "наружные сети"';
  F_ReportFileName := 'SvPoZayvkam.frf';
  F_Pind.CancelButton:=false;
  F_Pind.OnCancel:=nil;
 end;
procedure TSvPoZayvkam.CreateForms;
 begin
   //
  F_OptForm := CreateOptionForm( Tfrm_OptSvPoZayvkam, F_Name ) as Tfrm_OptSvPoZayvkam;
  F_DM := CreateDataModule( Tdm_SvPoZayvkam ) as Tdm_SvPoZayvkam;
  F_ResFrm := CreateResultForm( Tfrm_AnalysisView, F_Name ) as Tfrm_AnalysisView;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
 end;

procedure TSvPoZayvkam.PrepareFastReport;
begin
  frVariables[ 'BegDt' ] := F_OptForm.frame_SelDateTime.BeginDateTime;
  frVariables[ 'EndDt' ] := F_OptForm.frame_SelDateTime.EndDateTime;
  frVariables[ 'OrderType' ] := F_OptForm.GetZavName;
  frVariables[ 'Region' ]:=F_OptForm.REgionName;
  frVariables[ 'KolZayav' ]:=F_DM.KolZayav;
end;

function TSvPoZayvkam.Execute:boolean;
begin
   if F_OptForm.ShowModal<>mrOK then
    REsult:=false
   else
   begin
    F_Dm._DateBeg:=F_OptForm.frame_SelDateTime.BeginDateTime;
    F_Dm._DateEnd:=F_OptForm.frame_SelDateTime.EndDateTime;
    F_Dm._TypeZ:=F_OptForm.GetZavtype;
    F_Dm.ID_region:=F_OptForm.ID_REg;
    F_Dm._TypeNar:=F_OptForm.GetOrderType;
    f_dm._sort_type:=f_OPTfORM.sortType;

   try
     f_Pind.Show;
     F_Dm.prepareDsets;
     F_Kolz:=F_Dm.KolZayav;
     PrepareResultFormHeader;
     PrepareResultFormGrid;
     PrepareResultFormBtns
   finally
    f_Pind.Hide;
   end;
    F_rEsFrm.ShowModal;
    REsult:=true;
   end;
end;

procedure TSvPoZayvkam.OnPrintClick(Sender: TObject);
begin
  PrepareAndPrintFR(F_DM.frReport);
end;

procedure TSvPoZayvkam.PrepareResultFormBtns;
begin
  F_ResFrm.btn_Order.OnClick := OnOrderClick;
  F_ResFrm.btn_Print.OnClick := OnPrintClick;
 // F_ResFrm.btn_Excel.OnClick := ExcelBtnClick;

//    F_ResFrm.btn_Close_Z.OnClick := OnClose_ZClick ;
//     F_ResFrm.btn_Close_Z.Enabled:=true;
  F_ResFrm.btn_Close_Z.OnClick := nil;

end;

procedure TSvPoZayvkam.PrepareResultFormGrid;
var
  _gvb: TGridViewBuilder;
  _col: TGBColumn;
   _group:TGroup;
begin
  _gvb := TGridViewBuilder.Create( F_DM.md_result, F_ResFrm.Grid );
  try
    _gvb.IDFieldName := 'id_order';


    AddColToGVB( _gvb, 'number', 'Номер'+#13+'заявки', alCenter );
    AddColToGVB( _gvb, 'DateOurRequest', 'Дата/время'+#13+'поступления', alCenter );
    //AddColToGVB( _gvb, 'region', 'Район', alLeft );
    AddColToGVB( _gvb, 'adress', 'Адрес', alLeft );
     _col:=AddColToGVB( _gvb, 'about', 'О чем заявлено', alLeft );
     _col.DisplayWidth:=70;
    _col:=AddColToGVB( _gvb, 'why_not', 'Почему не'+#13+'выполнено', alLeft );
     _col.DisplayWidth:=35;
    AddColToGVB( _gvb, 'Brigname', 'Бригадир', alLeft );
    AddColToGVB( _gvb, 'order_number', 'Номер'+#13+'наряда', alLeft );
    _group:=_gvb.AddGroup('dopfield');
    _group.IsNumberRecordInGroup:=true;
    _group.GroupHeader.Visible:=false;
    _group.GroupFooter.Visible:=false;
    
   _group:= _gvb.AddGroup('region');
   _group.GroupHeader.Visible:=true;
   _group.GroupFooter.Visible:=false;
   _group.GroupHeader.Alignment:=alCenter;
   _group.GroupHeader.Font.Style:=[fsBold];
   _group.GroupHeader.Color:=clAqua;
   _group.IsNumberRecordInGroup:=true;
  _group.GroupHeader.OnShowCaption:=ONShowHeaderRegion;

   _group:=_gvb.AddGroup('group');
   _group.GroupHeader.Visible:=true;
   _group.GroupFooter.visible:=false;
   _group.GroupHeader.Color:=clGray;
   _group.GroupHeader.Alignment:=alCenter;
   _group.IsNumberRecordInGroup:=true;
   _group.GroupHeader.Font.Style:=[fsbold];
   _group.GroupHeader.OnShowCaption:= ONShowHeaderGroup;

   _gvb.IsNumberRecord:=true;
    _gvb.BuildGridView;
  finally
    _gvb.Free;
  end;
end;

procedure TSvPoZayvkam.PrepareResultFormHeader;
var s_orderTyp:string;
begin
  if F_OptForm.GetZavtype>=2 then
     s_orderTyp:='Наряды:'+F_OptForm.GetOrderTypeName+#13
  else
    s_orderTyp:='';
  F_ResFrm.CenterLabel :=
    F_Name + #13 +
    'за период с ' + DateToStr(f_OptForm.frame_SelDateTime.BeginDateTime ) +
    ' по ' + DateToStr( f_OptForm.frame_SelDateTime.EndDateTime );
    if F_OptForm.ID_REg>0 then
      F_ResFrm.LeftLabel := 'Заявки: ' + f_OptForm.GetZavName+#13+s_orderTyp+
       'Район  '+F_OptForm.REgionName+
        #13 +'ИТОГО: ' + IntToStr(F_DM.KolZayav)
    else
      F_ResFrm.LeftLabel := 'Заявки: ' + f_OptForm.GetZavName+#13+s_orderTyp+
        #13 +'ИТОГО: ' + IntToStr(F_DM.F_KolZayav);
end;


procedure TSvPoZayvkam.ONShowHeaderRegion(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
begin
OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
OutRow.Add(trim(Dataset.fieldbyname('Region').asstring)+' РАЙОН ');
end;


procedure TSvPoZayvkam.ONShowHeaderGroup(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList);
begin

OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
OutRow.Add('');
if  Dataset.FieldByName('group').AsInteger=1 then
OutRow.Add('Вновь поступившие')
else
OutRow.Add('В работе');
end;

{/}
procedure TBlagSvod.InitFields;
begin
  F_Name := 'График по благоустройству мест разрытий на инженерных сетях';
  F_ReportFileName := 'SvodBlag3.frf';
end;



function TBlagSvod.Execute:boolean;
var year,month,day:word;

begin
   Result := false;


  if F_OptFrm.ShowModal <> mrOk then exit;

  F_Pind.Show;
  try

    F_DM.BegDate :=(F_OptFrm as Tfrm_OptBlag2).frame_SelDates.de_Begin.Date ;
    F_DM.EndDate :=(F_OptFrm as Tfrm_OptBlag2).frame_SelDates.de_End.Date;
    F_Dm.DopBegin:= (F_OptFrm as Tfrm_OptBlag2).DopBegDate ;
    F_Dm.DopEnd:=(F_OptFrm as Tfrm_OptBlag2).DopEndDate;
    F_Dm.FinishBegin:= (F_OptFrm as Tfrm_OptBlag2).FinishBegDatte ;
    F_Dm.FinishEnd:=(F_OptFrm as Tfrm_OptBlag2).FinishpEndDatte;
    F_DM.blag := 1;
    F_DM.GZ := true;
    F_DM.ASF := true;
    F_Dm._isSvod:=true;
    print_add_asf:=(F_OptFrm as Tfrm_OptBlag2).cb_DopAsf.Checked;
    print_list:=(F_OptFrm as Tfrm_OptBlag2).cb_adress.Checked;
    F_Dm.IDREgions:=(F_OptFrm as Tfrm_OptBlag2).IDREgions;
    F_Dm.without_excav:=(F_OptFrm as Tfrm_OptBlag2).WithoutExcav;
    F_Dm.ClosedOrder :=  (F_OptFrm as Tfrm_OptBlag2).rg_ClosedOrder.ItemIndex;
     F_Dm.overdude:=F_OptFrm.overd;
{    if (F_DM is Tdm_RepBlag4) then
      F_DM.ASF:=true;}
    if F_DM.PrepareDset then
      PrepareAndPrintFR( F_DM.frReport );

  finally
    F_Pind.Hide;
  end;

  Result := true;
end;


procedure TBlagSvod.PrepareFastReport;
var year, month, day:word;
begin
  case F_OptFrm.rgblag of
   0: begin
          frVariables[ 'isall' ] := ' все наряды ';
          frVariables[ 'asf' ] := '  ';
      end;
   1: begin
          frVariables[ 'isall' ] := ' незаконченное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   2: begin
           frVariables[ 'isall' ] := ' полное благоустройство ';
          if F_OptFrm.RGASF then frVariables[ 'asf' ] := ', асфальтировка  ';
          if not F_OptFrm.RGASF then frVariables[ 'asf' ] := ', щебенение  ';
       end;
   end; //case

  if F_OptFrm.GZ then frVariables[ 'green' ] := ', с зелёной зоной '
      else frVariables[ 'green' ] := ', без зелёной зоны ';

  frVariables[ 'BegDate' ] := DateToStr( F_OptFrm.frame_SelDates.BeginDate );
  frVariables[ 'EndDate' ] := DateToStr( F_OptFrm.frame_SelDates.EndDate );
  DecodeDate(Date(),year,month,day);
  frVariables[ 'CurDate' ]:={ХDateToStr( (F_OptFrm as Tfrm_OptBlag2).FinishpEndDatte);}DateToStr(Date());
  frVariables[ 'FirsDate' ]:=DateToStr( (F_OptFrm as Tfrm_OptBlag2).FinishBegDatte);//EncodeDate(year,month,1));
  F_Dm.frReport.Pages[ F_Dm.frReport.Pages.Count-2].Visible:=print_add_asf;   //22.07.2013
  F_Dm.frReport.Pages[0].Visible:=print_List;    //22.07.2013

end;

procedure TBlagSvod.CreateForms;
  var year,month,day:word;
begin
   inherited;
   DecodeDate(Date(),year,month,day) ;
  (F_OptFrm as Tfrm_OptBlag2).rgblag:=1;
  (F_OptFrm as Tfrm_OptBlag2).rb1.Enabled:=false;
  (F_OptFrm as Tfrm_OptBlag2).rb3.Enabled:=false;

  (F_OptFrm as Tfrm_OptBlag2).frame_SelDates.de_Begin.Date:=EncodeDate(year-1,1,1);
  (F_OptFrm as Tfrm_OptBlag2).frame_SelDates.de_End.Date:=Date();
  (F_OptFrm as Tfrm_OptBlag2).DopBegDate:=EncodeDate(year,month,1);
  (F_OptFrm as Tfrm_OptBlag2).DopEndDate:=Date;
  (F_OptFrm as Tfrm_OptBlag2).FinishBegDatte:=EncodeDate(year,month,1);
  (F_OptFrm as Tfrm_OptBlag2).FinishpEndDatte:=Date();
  (F_OptFrm as Tfrm_OptBlag2).cb_DopAsf.Visible:=true;   //22.07.2013
  (F_OptFrm as Tfrm_OptBlag2).cb_adress.Visible:=true;
  (F_OptFrm as Tfrm_OptBlag2).cb_GreenZone.Visible:=false;
  (F_OptFrm as Tfrm_OptBlag2).rg_Excav.ItemIndex:=1;
  (F_OptFrm as Tfrm_OptBlag2).rg_Excav.Enabled:=false;
  (F_OptFrm as Tfrm_OptBlag2).rg_ClosedOrder.Visible:=true;

end;
{/}
{28.02.2014}
procedure TRepGreenSpring.CreateForms();
begin
  F_OptForm := CreateOptionForm( Tfrm_OptBlag2, F_Name ) as Tfrm_OptBlag2;
  F_DM := CreateDataModule( Tdm_RepGreenSpring ) as Tdm_RepGreenSpring;
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;


procedure  TRepGreenSpring.InitFields;
begin
  F_Name := 'Зеленая весна';
  F_ReportFileName := 'GreenSpring.frf';
end;

procedure  TRepGreenSpring.PrepareFastreport;
begin
 frVariables['f_Date']:= DateToStr(F_DtCur) ;
 frVariables['Year']:=GetYear(F_DtCur);
end;

function  TRepGreenSpring.Execute:boolean;
begin
result:=false;

try

F_OptForm.PrepareGreemSpring;
 if  F_OptForm.ShowModal<>mrOK then exit;
 F_Pind.Show;
 F_Dm.year:=GetYear(F_OptForm.frame_SelDates.EndDate);
  F_DM.BegDate := F_OptForm.frame_SelDates.BeginDate;
    F_DM.EndDate := F_OptForm.frame_SelDates.EndDate;
    F_Dm.DopBegin:=F_OptForm.DopBegDate;
    F_Dm.DopEnd:=F_OptForm.DopEndDate;
    F_Dm.FinishBegin:=F_OptForm.FinishBegDatte;
    F_Dm.FinishEnd:=F_OptForm.FinishpEndDatte;
    F_DM.blag := F_OptForm.rgblag;
    F_DM.GZ := F_OptForm.GZ;
    F_DM.ASF := F_OptForm.RGASF;
    F_DM.IDREgions:=F_OptForm.IDREgions;
    f_Dm.without_excav:=F_OptForm.WithoutExcav;
    F_Dm.overdude:=F_OptForm.overd;

 F_Dm._isSvod:=true;

 F_DtCur:=F_OptForm.frame_SelDateP1.EndDate;

 F_Dm.GZ:=true;
 F_Dm.without_excav:=0;
 if F_Dm.PrepareDset then
  PrepareAndPrintFR( F_DM.frReport );
 Result := true;
 finally
  F_Pind.Hide;
 end;

end;
{TDisconSite}
procedure TDisconSite.InitFields;
begin
 F_Name := 'Отключения на сайт';
  F_ReportFileName := 'DisconSite.frf';
end;

procedure TDisconSite.CreateForms;
begin
 F_OptFrm := CreateOptionForm( Tfrm_OptAvrDiscon ,F_name) as  Tfrm_OptAvrDiscon;
  F_ResFrm := TDisconnSiteResult.Create(nil);
//  F_DM := CreateDataModule( Tdm_AVRDisconn ) as Tdm_AVRDisconn;
  F_DM := Tdm_AVRDisconnSite.Create(nil);
  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport1);

end;

procedure TDisconSite.PrepareFastReport;
begin
inherited;
(F_DM as Tdm_AVRDisconnSite).PrepareAddAdreses;
end;

function TDisconSite.GetFileName(var filename :string):string;
begin
 filename:='Discon.html';
 result:=AppSettings.Get_Abon_Path + 'Discon.html';

end;
{/TDisconSite}

{TReport1321}
procedure TReport1321.CreateForms;
begin
 f_OptForm := CreateOptionForm( Tfrm_optReport1321 ,F_name) as  Tfrm_optReport1321;
 F_DM := Tdm_Report1321.Create(nil);
 F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
end;

procedure TReport1321.InitFields;
begin
 F_Name := 'Еженедедьный отчет 13.2.1';
 F_ReportFileName := 'Report1321.frf';
end;

procedure TReport1321.PrepareFastReport;
begin
inherited;
  frVariables['Dt_Beg']:=F_OptForm.beginDate;
  frVariables['Dt_End']:=F_Dm.end_Date;
  frVariables['bgdat1']:=F_Dm.Strboddt1;
  frVariables['bgdat2']:=F_Dm.Strboddt2;
  frVariables['bgdat3']:=F_Dm.Strboddt3;
  frVariables['bgdat0']:=F_Dm.Strboddt0;


end;

function TReport1321.Execute:boolean;
begin
result:=false;
try

 if  F_OptForm.ShowModal<>mrOK then exit;
 F_Pind.Show;
 F_DM.Dt_beg:=F_OptForm.beginDate;
 F_DM.Dt_end:=F_optForm.endDate;
 F_DM.excavCondition:='ns.add_excav is null  and o.FK_ORDERS_DAMAGEPLACE  not in(35)';// не по благоустройству
 F_DM.orderCondition:='o.isclosed=0 ';
 F_DM.code:=code1321;
 if F_Dm.prepareDsets then
  PrepareAndPrintFR( F_DM.frReport );
 Result := true;
finally
 F_Pind.hide;
end;
end;

{TReport 12192}
 procedure TReport13192.InitFields;
begin
 F_Name := 'Еженедедьный отчет 13.19.2';
 F_ReportFileName := 'Report13192.frf';
end;

function TReport13192.Execute:boolean;
begin
result:=false;
try
 if  F_OptForm.ShowModal<>mrOK then exit;
 F_Pind.Show;
 F_DM.Dt_beg:=F_OptForm.beginDate;
 F_DM.Dt_end:=F_optForm.endDate;
 F_DM.excavCondition:='((ns.add_excav=1) or (o.FK_ORDERS_DAMAGEPLACE=35))';
 F_DM.orderCondition:='o.Datecoming>''01.01.2013'' ';
 F_DM.code:=code13192;
 if F_Dm.prepareDsets then
  PrepareAndPrintFR( F_DM.frReport );
 Result := true;
finally
 F_Pind.hide;
end;
end;






end.
