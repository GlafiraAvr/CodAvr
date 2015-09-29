unit MainForm;

interface

{$I !TEST_DEFINE.inc}
{$define spisok1562}

uses
  AppEvnts, Menus, StdCtrls, Buttons, ToolWin, ComCtrls, Controls,
  Classes, Forms, Dialogs, SysUtils, Graphics, sfexec, MenuManager,
  RGAppError, Windows, ExtCtrls, Spisok1562_FrameUnit, DB,
  SuborderManager,
  Search1562DModule , Order1562Form, Order1562Manager, DBGrids,
  Options_1562,Zayv1562Manager,WaitProcessForm;

type
  TLoginType=(ltCommandStr, ltLoginForm);

  Tfrm_Main = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mi_ShiftNumber: TMenuItem;
    mi_InputOrder: TMenuItem;
    mi_InputTemper: TMenuItem;
    mi_WorkWIthOrder: TMenuItem;
    N9: TMenuItem;
    mi_Svodki: TMenuItem;
    mi_Voc: TMenuItem;
    N7: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    CoolBar1: TCoolBar;
    SpeedButton2: TSpeedButton;               
    sp_UniversalSearch: TSpeedButton;
    sp_SvodkaGik: TSpeedButton;
    sp_SvodVed: TSpeedButton;
    sb_KilledDamage: TSpeedButton;      
    mi_EquipPlanned: TMenuItem;
    sb_InputOrder: TSpeedButton;
    mi_Service: TMenuItem;
    N17: TMenuItem;
    AppExec: TsfAppExec;
    N18: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    mi_Analysis: TMenuItem;
    mi_Users: TMenuItem;
    RGAppError1: TRGAppError;
    N0621: TMenuItem;
    mi_SvodkiReg: TMenuItem;
    mi_Svodki2: TMenuItem;
    sp_1562: TSpeedButton;
    p_InfoPanel: TPanel;
    lbl_AvrOnMap: TLabel;
    lbl_ShiftNum: TLabel;
    lbl_ShiftDate: TLabel;
    Button1: TButton;
    Label4: TLabel;
    lbl_UserName: TLabel;
    p_ForFrame1562: TPanel;
    Spisok1562_Frame1: TSpisok1562_Frame;
    ds_Main: TDataSource;
    sb_InputOrder_vds: TSpeedButton;
    Timer1: TTimer;
    mi_svodki_vds: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    sb_Reconnect: TSpeedButton;
    mi_Departure: TMenuItem;
    mi_DepRed: TMenuItem;
    procedure mi_InputTemperClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure mi_InputOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mi_ShiftNumberClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
    procedure mi_EquipPlannedClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mi_UsersClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure N0621Click(Sender: TObject);
    procedure Spisok1562_Frame1Button1Click(Sender: TObject);
    procedure Spisok1562_Frame1GridDblClick(Sender: TObject);
	procedure SpeedButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure sp_1562Click(Sender: TObject);
    procedure sb_InputOrder_vdsClick(Sender: TObject);
    procedure sp_UniversalSearchClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Spisok1562_Frame1RegionsClick(Sender: TObject);
    procedure sb_ReconnectClick(Sender: TObject);
    procedure Spisok1562_Frame1BitBtn1Click(Sender: TObject);
    procedure Spisok1562_Frame1GridTitleClick(Column: TColumn);
    procedure Spisok1562_Frame1BitBtn2Click(Sender: TObject);
  private
	F_FlagShift : boolean;
    F_MenuMgr: TMenuManager;
{$IFDEF spisok1562}
    F_Show1562: boolean;
    F_DM1562: Tdm_Search1562;
    F_SOFrm: Tfrm_Order1562;

    procedure Show1562;
    procedure Refresh1562;
    procedure OnClickGrid1562;
    procedure ClickGrid1562;
{$endif}
    procedure FillMenu;
    function Login(LoginType: TLoginType): boolean;
    procedure PrepareFormViewByUser;
    procedure PrepareAomView;
  private
    procedure OnTemperSvodClick(Sender: TObject);
    procedure OnAnAVRByStreetClick(Sender: TObject);
    procedure OnAnRaskopokClick(Sender: TObject);
    procedure OnCurrentUserChange(NewUserName, NewUserGroupName: string);

  public
    property FlagShift:boolean read F_FlagShift write F_FlagShift default false;
  private
   F_ShiftDate:TDateTime;
  procedure mi_RegClick(Sender: TObject);
  procedure  OpenDeps(Reg:integer;Reg_name:string);
  public
  property ShiftDate:TDateTime read F_ShiftDate write F_ShiftDate;
  end;

var
  frm_Main: Tfrm_Main;

implementation

uses DModule, TemperatureForm, SearchOrderByNumber,
  EquipPlannedForm,
  AboutForm,
  EquipmentUsedForm,
  StringConsts, AN_DIAGR,
  TemperSvodForm,
  PeriodExcSpredSelForm,
  OrderForm, ShiftNumForm, GlobalData,
  NotePadForm, AddPrintDModule,
  StrTool, ReportManager, AnalysisManager, NGReportManager, VocManager,
  ApplicationSettings, AvrUserManagerDModule, AppLoginer,
  RightsManagerDModule, AomComClientDModule, AppGUIDS, ver,
  NGReports,
  {����� ���� ����� ������}
  HelpFunctions, NumSOBuffDModule, NumSOForm,
  BeforUnSearch,
  {/����� ���� ����� ������}
  OrderForm_vds ,NGReportManager_vds,
  ReportManager_vds,
  SaveSTDISP,
  save_Rasr,
  OneDayManager,
  NGDepManager;

{$R *.dfm}

var
  UserMgrPwd: string;

procedure Tfrm_Main.N7Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Main.mi_InputOrderClick(Sender: TObject);
var
  frm_Order: Tfrm_Order;
begin
  if not(IsNeedToChangeShift or IsNeedToInputTemper) then
  begin
    frm_Order:=Tfrm_Order.Create(Application); //����� �����
    try
      frm_Order.ShowModal;
    finally
      frm_Order.Free;
    end;
  end;
end;

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin
  F_MenuMgr:=TMenuManager.Create;
  FillMenu;
  StatusBar1.SimpleText := '������: ' + ver.TempVersion;

  Button1.Visible := (NameCase(GetComputerName) = 'Mp');
  //Button1.Visible := false;
  Flagshift:=false;

{$IFDEF spisok1562}

{   Timer1.Enabled:=true;
   Timer1.Interval:=AppSettings.Get_Interval;
   
   Show1562;
 }
{$endif}
{$IFNDEF spisok1562}
  p_ForFrame1562.Visible := false;
  sp_1562.Visible := true;
  p_InfoPanel.Align := alClient;
  p_InfoPanel.Color := clGray;
{$endif}


end;

procedure Tfrm_Main.mi_ShiftNumberClick(Sender: TObject);
var
  frm_ShiftNum: Tfrm_ShiftNum;
begin
  if not DM_Main.IsNeedToChangeShiftBlock(true) then
    begin
    frm_ShiftNum:=Tfrm_ShiftNum.Create(Application);
    try
      frm_ShiftNum.ShowModal;
      lbl_ShiftNum.Caption := '����� � ' + IntToStr(frm_ShiftNum.ShiftNum);
      lbl_ShiftDate.Caption := '���� ����� ' + DateToStr(frm_ShiftNum.ShiftDate);
    finally
      frm_ShiftNum.Free;
    end;
  end;
end;

procedure Tfrm_Main.mi_InputTemperClick(Sender: TObject);
var
  frm_Temper: Tfrm_Temperature;
begin
  if not IsNeedToChangeShift then
  begin
    frm_Temper:=Tfrm_Temperature.Create(Application);
    try
      frm_Temper.showModal;
    finally
      frm_Temper.Free;
    end;
  end;
end;


procedure Tfrm_Main.N9Click(Sender: TObject);
var
  frm_SearchOrderByNumber: Tfrm_SearchOrderByNumber;
begin
{  if not(IsNeedToChangeShift or IsNeedToInputTemper) then}
  begin
    frm_SearchOrderByNumber:=Tfrm_SearchOrderByNumber.Create(self);
    try
      frm_SearchOrderByNumber.ShowModal;
    finally
      frm_SearchOrderByNumber.Free
    end;
  end;
end;

procedure Tfrm_Main.FormShow(Sender: TObject);
var
  ShiftNum:integer;
  ShiftDate:TDate;
begin
  if not Login(ltCommandStr) then
    if not Login(ltLoginForm) then
    begin
      Application.Terminate;
      exit;
    end;

  GetShiftsNumAndDate(ShiftNum, ShiftDate);
  if(ShiftNum <> -1 ) then
  begin
    lbl_ShiftNum.Caption := '����� � ' + IntToStr(ShiftNum);
    lbl_ShiftDate.Caption := '���� ����� ' + DateToStr(ShiftDate);
  end;
 
  /// for  DemoAbon
{  mi_Voc.Visible:=false;
  mi_Service.Visible := false;
  CoolBar1.Visible := false;
 }


end;


procedure Tfrm_Main.SpeedItem1Click(Sender: TObject);
begin
  MessageDlg('dsf', mtInformation, [mbOK], 0);
end;

procedure Tfrm_Main.mi_EquipPlannedClick(Sender: TObject);
var
  frm_EquipPlanned: Tfrm_EquipPlanned;
begin
  frm_EquipPlanned := Tfrm_EquipPlanned.Create(nil);
  try
    frm_EquipPlanned.ShowModal();
  finally
    frm_EquipPlanned.Free();
  end;
end;

procedure Tfrm_Main.About1Click(Sender: TObject);
var
  AboutFrm: TAboutFrm;
begin
  AboutFrm := TAboutFrm.Create(self);
  try
    AboutFrm.ShowModal();
  finally
    AboutFrm.Free();
  end;
end;

procedure Tfrm_Main.FormResize(Sender: TObject);
var dist:integer;
begin
//
{$IFNDEF spisok1562}
  lbl_ShiftNum.Left := trunc((self.Width - lbl_ShiftNum.Width)/3);
  lbl_ShiftDate.Left := lbl_ShiftNum.Left;
  lbl_ShiftNum.Font.Color := clWhite;
  lbl_ShiftNum.Font.Size := 13;
  lbl_ShiftNum.Font.Style := [fsBold];  
  lbl_ShiftDate.Font.Color := clWhite;
  lbl_ShiftDate.Font.Size := 13;

//  dist := lbl_ShiftDate.Top - lbl_ShiftNum.Top;
//  lbl_ShiftNum.Top := trunc((self.Height - (dist + lbl_ShiftDate.Height))/2.2);

  label4.Top := p_InfoPanel.Height - 30;
  lbl_UserName.Top := p_InfoPanel.Height - 30;

  dist := 20;
  lbl_ShiftNum.Top := trunc((self.Height - (dist + lbl_ShiftDate.Height))/3);
  lbl_ShiftDate.Top := lbl_ShiftNum.Top + dist;
{$endif}  
end;

procedure Tfrm_Main.N17Click(Sender: TObject);
var
  frm :Tfrm_NotePad;
begin
  frm:=Tfrm_NotePad.Create(nil);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure Tfrm_Main.N18Click(Sender: TObject);
begin
  AppExec.ApplicationName:='calc.exe';
  AppExec.Execute;
end;

procedure Tfrm_Main.N28Click(Sender: TObject);
begin
  AppExec.ApplicationName:='control.exe Timedate.cpl';
  AppExec.Execute;
end;

procedure Tfrm_Main.N29Click(Sender: TObject);
var
  dm: Tdm_AddPrint;
begin
  dm:=Tdm_AddPrint.Create(nil);
  try
    dm.PrintingDoc:=pdPropusk;
    dm.Print;
  finally
    dm.Free;
  end;
end;

procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  F_MenuMgr.Free;
{$IFDEF spisok1562}
  F_DM1562.Free;
{$endif}  
end;

procedure Tfrm_Main.FillMenu;
var
  is_voc_readonly: boolean;
begin
  with F_MenuMgr do
  begin
    {��������� ������ � ���� "������ � ��������"}
    AddRepToMenu(   mi_WorkWithOrder, '����� ���������� ������� �� ������', rnOpenOrderSearch,  true );
    AddRepToMenu(   mi_WorkWithOrder, '����� �������� ������� �� ������',   rnCloseOrderSearch, true );
    AddRepToMenu(   mi_WorkWithOrder, '����� ���� ������� �� ������',       rnAllOrderSearch,   true );
    AddNGRepToMenu( mi_WorkWithOrder, '������������ ����� �������',         rnUniversalSearch2, true );
    {��������� ������ � ���� "������ � ��������"}

    {��������� ���� "������"}
   // AddRepToMenu(   mi_Svodki2, '������� ��������� ��������',                                rnSvodVed,               true );
    AddRepToMenu(   mi_Svodki, '������� ��������� �����������',                                rnSvodVedDamage,               true );
   // AddRepToMenu(   mi_Svodki, '������� ��������� �2 (�����)',                                      rnSvodVed2,              true );
   // AddRepToMenu(   mi_Svodki, '������� ��������� �2 ��� ����������� (������)',       rnSvodVed2Land,       true );
    AddNGRepToMenu( mi_Svodki, '������ ��� ������������ ���',                          rnPovrRegion,             true );
   // AddRepToMenu(   mi_Svodki2, '������� ��������� ��� ����������� �������� (2 ���.)',       rnSvodVed3,              true );
    AddRepToMenu(   mi_Svodki, '������ �� ���������� ���������',                            rnClosedBolts,           true );
    AddRepToMenu(   mi_Svodki2, '������ �� ���������� ���������(����� ������)',              rnClosedBoltsAdres,      true );

    AddRepToMenu(   mi_Svodki2, '������� � ���������� �����',                                rnSpravkaAbon,           true );
    AddNGRepToMenu( mi_Svodki, '������ � ���',                                              rnSvodkaGik,             true );
    AddRepToMenu(   mi_Svodki, '������ "���������� �������..."',                            rnKolvoOtkazov );
    AddRepToMenu(   mi_Svodki, '������ � ����� ���������',                                  rnProfWorkType,          true );
    AddRepToMenu(   mi_Svodki2, '������ �� ��������������� ������������',                    rnKilledDamage,          true );
    AddRepToMenu(   mi_Svodki2, '������ �� ����. ������������(��������)',                    rnKilledDamage_vodoset,  true );
    AddRepToMenu(   mi_Svodki, '������ ������� �������',                                    rnPayedOrders );
    AddToMenu(      mi_Svodki, '������ �� �����������',                                     OnTemperSvodClick );
    AddRepToMenu(   mi_Svodki2, '������ ����. ����. ��� ���.���������',                      rnKilledDamage_director, true );
    AddAnToMenu(    mi_Svodki2, '���-�� ������������ ������� �� ������',                     anNoWorkingKol );
    AddNGRepToMenu( mi_Svodki, '������ ���� �� ������������� �����',                        rnUtechkiNaVodoseti );

    AddRepToMenu(   mi_Svodki2, '������� ��������� �� �����',                                rnSvodVed_smena );
    AddRepToMenu(   mi_Svodki2, '������ � ���',                                              rnSvodSES );
    AddRepToMenu(   mi_Svodki, '��������� �������� �������',                                rnClosedOrders );
    AddRepToMenu(   mi_Svodki, '������� ��������� �� ��������',                             rnSvodVed_excav );
    AddNGRepToMenu( mi_Svodki, '������ �� ��������',                                        rnSvodExcav );
    AddRepToMenu(   mi_Svodki, '������� ��������� ������������� ����� �� �������� �������', rnSvodVed_OutstandWork );
    AddRepToMenu(   mi_Svodki, '��������� ��������� ��������������',                        rnBlagState );

    AddNGRepToMenu( mi_Svodki, '������  ���������� �� ������ �� ��',                        rnVAbonBezVody );
    AddNGRepToMenu( mi_Svodki, '������ ���������� ���������� ������������� ������',                            rnNODSBezVody );
    AddRepToMenu(   mi_Svodki, '������ ��������� ������ ����',                              rnInstallHatch );
    AddRepToMenu(   mi_Svodki, '������ ������� ������',                                     rnHideLeak );
    AddNGRepToMenu( mi_Svodki, '��������� ������ �� ��������� ����� � ������ ���. ���������', rnSvodVedLukAndPG );
    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� � ���',                           rnNeedAsfalt );
//    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� � ��� �2',                        rnBlag2 );
    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� � ��� �3',                        rnBlag3 );
    AddNGRepToMenu( mi_Svodki, '�������� ������� �� ���������������',                       rnBlagItog );
    AddNGRepToMenu( mi_Svodki, '������ � ������ ��� ��. �����',                             rnGorSES );
//    AddNGRepToMenu( mi_Svodki2, '������ �������� ����',                                      rnNetBar );
    AddRepToMenu(   mi_Svodki, '������ ��� �����������',                                      rnSvodVed2,              true );
    AddNGRepToMenu( mi_Svodki, '������ �� ������ � �������� 1562',                           rnSvodka062 );
    AddToMenu(      mi_Svodki, '-', nil);
    AddNGRepToMenu(mi_Svodki,  '������ �� ������ � �������� ',                           rnSvPoZayav );

    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� �������',                         rnPlanDep );
    AddNGRepToMenu( mi_Svodki, '������ �� ������������� �������',                           rnPlanDenial );
    AddNGRepToMenu( mi_Svodki, '������������� ���������� ��� ���������������',              rnUseEquip );
    AddNGRepToMenu( mi_Svodki, '���������� �� ��������� ���������',                         rnAvarSit );


    if AppSettings.IsUseVDSDB then
      AddNGRepToMenu( mi_Svodki, '������ ����������  �� ''���������������� ''',                          rnDisconnectKPVoda );

    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� ������������',                    rnBlagPodr );
    AddNGRepToMenu( mi_Svodki, '������ �� �������',                                         rnNaled );
    AddNGRepToMenu( mi_Svodki, '������ ���������� ���������',                               rnSheben );
    if AppSettings.IsUseVDSDB then
      AddNGRepToMenu( mi_Svodki, '���������� � ���',            rnAVRDisconn );
    if AppSettings.IsUseVDSDB then
    AddNGRepToMenu( mi_Svodki, '������ �������� ',                                 rnRazrtDep);
//    if AppSettings.IsUseVDSDB then
//    AddNGRepToMenu( mi_Svodki, '������ �� ��������������� ��� ���. ��������� ',          rnBlag3GIK);

    AddToMenu(      mi_Svodki, '-',                                                         nil );
    AddRepToMenu(   mi_Svodki, '��� �������� ���������� ������', rnGlavUpr );
    AddNGRepToMenu( mi_Svodki, '���������� �� ���������������',            rnInfBlag );
//    AddNGRepToMenu( mi_Svodki, '������ ������� �������� �������',           rnObrZas );
    AddNGRepToMenu( mi_Svodki, '����������� ������� ��������� ��������� ����',  rnRSvodved  );
    AddNGRepToMenu( mi_Svodki2, 'C������ ��������� �� �������������� ��������',  rnblagRasr  );
//    AddNGRepToMenu( mi_Svodki2, '������ ��������������� ������� ',  rnPlanTexnik  );
    AddNGRepToMenu( mi_Svodki2, '���� ���������� ����� �� �������',  rnSPlanWorks  );
    AddNgRepToMenu(mi_Svodki2, '������ �� ���������������' ,rnBlagSvod);
    AddNgRepToMenu(mi_Svodki2, '������� ��������� �� � ��������',rnSodVed_1562ns);

    AddRepToMenu(  mi_Svodki2, '��������� ��������� ��������',                                      rnSvodVed_sent,              true );
   AddNgRepToMenu(mi_Svodki2,'������ "������� �����"',rnRepGreenSpring);
   AddNgRepToMenu(mi_Svodki2,'������ ����������, ����',rnDisconSite);
   AddNgRepToMenu(mi_Svodki2,'������������ ����� 13.2.1', rnReport1321);
   AddNgRepToMenu(mi_Svodki2,'������������ ����� 13.19.2', rnReport13192);
   AddNgRepToMenu(mi_Svodki2,'������� �� ������� ', rnExcavOrderTable);
   AddNgRepToMenu(mi_Svodki_vds,'������ ������ ��� �����', rnApplicationForSbit);
   AddNgRepToMenu(mi_Svodki2,'���������� �����������  ��������������� ', rnTDamageBlagObject);
   AddNgRepToMenu(mi_Svodki2,'�������� ��������������������� �����',rnAllReport1);
   AddNgRepToMenu(mi_Svodki2,'���������� ������ � �������� �������',rnOptZvCloseOrder);


    {/��������� ���� "������"}

    {��������� ���� "������ ������"}
    AddNGRepToMenu( mi_SvodkiReg, '������ �����������',        rnTrudoZatrat , false);
    AddNGRepToMenu( mi_SvodkiReg, '������ ����������� �����',  rnVipolNaryad , false);
    {/��������� ���� "������ ������"}


    {��������� ���� "������"}
    AddToMenu(    mi_Analysis, '������ ��� �� ������',                                     OnAnAVRByStreetClick );
    AddAnToMenu(  mi_Analysis, '������ ���-�� ����������� �� ���� �������',                anRegionDamageCount );
    AddAnToMenu(  mi_Analysis, '����� ������� ������ ������������� ���-��',                anSearchAdres );
    AddAnToMenu(  mi_Analysis, '������ �����������, ��������������� � ���. ��������.',     anComingClosedEquip );
    AddAnToMenu(  mi_Analysis, '������ ����������� �� ������',                             anDmgPeriod );
    AddAnToMenu(  mi_Analysis, '������ ������������� ������������ �� ������',              anEquipUse );
    AddRepToMenu( mi_Analysis, '������ ������ ������������ ��� ����. ����.',               rnAnalysisEquipWork );
    AddRepToMenu( mi_Analysis, '������ ����. ����. ������ ���������',                      rnLongOrder );
    AddAnToMenu(  mi_Analysis, '������ ����������� �� ������ � ������������',              anDmgWithTemper );
    AddRepToMenu( mi_Analysis, '������ ������ �� ������',                                  rnAnalysisLeak );
    AddAnToMenu(  mi_Analysis, '������ ������ �� ������ �2',                               anLeakPeriod );
    AddAnToMenu(  mi_Analysis, '������ ���-�� ����. ����������� �� ����� �����������',     anLeakDmgPlace );
    AddAnToMenu(  mi_Analysis, '������ ���-�� ����. ����������� �� ��������� �����������', anLeakDmgLoc );
    AddAnToMenu(  mi_Analysis, '������ ���-�� ����. ����������� �� ���������',             anLeakDiam );
    AddAnToMenu(  mi_Analysis, '������ ������ ���������� �����������',                     anLeakDays );
    AddAnToMenu(  mi_Analysis, '������ ���-�� ����������� �� ������� �����������',         anLeakTime );
    AddAnToMenu(  mi_Analysis, '������ ������� ������ � ����������� �����',                anBrigDep );
    AddToMenu(    mi_Analysis, '������ ��������',                                          OnAnRaskopokClick );
    {/��������� ���� "������"}

    {������ �������� �� ������� ������ ����}
  //  AddNGRepToCtrl( sp_UniversalSearch, rnUniversalSearch2, true );
    AddNGRepToCtrl( sp_1562, rnSearch1562, true );
    AddRepToCtrl(   sp_SvodVed,         rnSvodVed,          true );
    AddNGRepToCtrl( sp_SvodkaGik,       rnSvodkaGik,        true );
    AddRepToCtrl(   sb_KilledDamage,    rnKilledDamage,     true );


    {/������ �������� �� ������� ������ ����}

    {��������� ���� "�����������"}
    is_voc_readonly:=false;
    AddVocToMenu( mi_Voc,   '����',                       vnVocStreets,        is_voc_readonly );
    AddVocToMenu( mi_Voc,   '�����������',                vnVocOfficials,      is_voc_readonly );
    AddVocToMenu( mi_Voc,   '����������',                 vnVocBrigadiers,     is_voc_readonly );
    AddVocToMenu( mi_Voc,   '���������� ����',            vnVocTubeMaterial,   is_voc_readonly );
    AddVocToMenu( mi_Voc,   '��������� ����',             vnVocTubeDiameter,   is_voc_readonly );
    AddVocToMenu( mi_Voc,   '��������� �����������',      vnVocDamageLocality, is_voc_readonly );
    AddVocToMenu( mi_Voc,   '����� �����������',          vnVocDamagePlace,    is_voc_readonly );
//    AddVocToMenu( mi_Voc,   '����� ���������',            vnVocProfWorks,      is_voc_readonly );
    AddVocToMenu( mi_Voc,   '���������',                  vnVocMessageTypes,   is_voc_readonly );
    AddVocToMenu( mi_Voc,   '���������������� �������',   vnVocRegions,        is_voc_readonly );
    AddVocToMenu( mi_Voc,   '������������',               vnVocEquipment,      is_voc_readonly );
    AddVocToMenu( mi_Voc,   '�������������� �����������', vnVocOrganizations,  is_voc_readonly );
//    AddVocToMenu( mi_Voc,   '0-62(� ��� ��������)',       vnVocSubOrderMsg,    is_voc_readonly ); ���������� ����
    AddVocToMenu( mi_Voc,   '0-62(��������� ��)',         vnVocSubOrderAbon,   is_voc_readonly );
    AddVocToMenu( mi_Voc,   '������ ���������*',          vnVocMeasurement,    is_voc_readonly );
    AddVocToMenu( mi_Voc,   '��������*',                  vnVocWorkers,        is_voc_readonly );
    AddVocToMenu( mi_Voc,   '��������� ��������*',        vnVocWorkerPost,     is_voc_readonly );
    AddVocToMenu( mi_Voc,   '������*',                    vnVocTeams,          is_voc_readonly );
    AddVocToMenu( mi_Voc,   '����������*',                vnVocMaterials,      is_voc_readonly );
    AddVocToMenu( mi_Voc,   '�����*',                     vnVocBWork,          is_voc_readonly );
    AddVocToMenu( mi_Voc,   '��������*',                  vnVocWorks,          is_voc_readonly );
    AddVocToMenu( mi_Voc,   '�����������*',               vnVocWorkTime,       is_voc_readonly );
    AddVocToMenu( mi_Voc,   '����� �����*',               vnVocWorkType,       is_voc_readonly );
    AddVocToMenu( mi_Voc,   '����������� �������������*', vnVocAsfCompanyType, is_voc_readonly );
    {��������� ���� "�����������"}

    {��������� ���� "������ ���"}
     AddRepVDSToMenu( mi_Svodki_vds,    '����� ���������� ������� �� ������', rnOpenOrderSearch_vds,  true );
     AddRepVDSToMenu(   mi_Svodki_vds, '����� �������� ������� �� ������',   rnCloseOrderSearch_vds, true );
     AddRepVDSToMenu(   mi_Svodki_vds, '����� ���� ������� �� ������',       rnAllOrderSearch_vds,   true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������������ ����� ������� ���',  rnUniversalSearch2_vds,     true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������ ���������� ������� ���',  rnRepOpenOrders_vds,     true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������ ����������� ����������',  rnRepClosedOrders_vds,     true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������� ��������� ���',  rnSvodVed_vds,     true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������� ��������� ��� 2', rnSvodVed_vds_2 ,  true );

   //   AddNGRepvdsToMenu( mi_Svodki_vds,  '������� ��������� ��� �������� 2', rnSvodVed_vds_per_2 ,  true );

     AddNGRepvdsToMenu( mi_Svodki_vds,  '������� ��������� �� ������', rnSvodVedPer_vds,   true);
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������ ���������� �� ������ �� ���', rnRepDiscon_vds,   true);
     AddNGRepvdsToMenu( mi_Svodki_vds,  '�������� ����� ���������� ���������  (����� �� �������)', rnRepRayonOrders_vds, true );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������ � ���', rnSvodkaGek,   true);

     AddNGRepvdsToMenu( mi_Svodki_vds,  '��� ����������� �����', rnActExeWorks_vds,   true);
//     AddNGRepvdsToMenu( mi_Svodki_vds,  '��������� ������������� ����������', rnVedUsedMaters_vds,   true);
     AddNGRepvdsToMenu( mi_Svodki_vds,  '������ ��������� ����������',  rnCalcMaterCost_vds,   true);
     AddToMenu(      mi_Svodki_vds, '-',                                                         nil );
     AddNGRepvdsToMenu( mi_Svodki_vds,  '����������� ������� ��������� �� ���',  rnRSvodved_vds,   true);
     AddNGRepvdsToMenu( mi_Svodki_vds, '������ �� ��������������� ������� ���' ,rnPlanWork_vds , true);
     AddNGRepvdsToMenu(mi_Svodki_vds, '������� ��������� ���������� �������(����)', rnVedNotCloseOrder_vds, true);
     AddNGRepToMenu(mi_Svodki_vds, '���������� � �������� � ����������� �������',rnGetToDoNar,true);


    {/��������� ���� "������ ���"}

  end;



  if not Spisok1562_Frame1.dset_region2.Active then
      Spisok1562_Frame1.dset_region2.open;
   with Spisok1562_Frame1.dset_region2  do
  begin
   First;
   while not EOF do begin
    F_MenuMgr.AddToMenu(mi_DepRed,FieldByName('name').asstring, mi_RegClick);
    mi_DepRed.Find(FieldByName('name').asstring).tag:=FieldByName('id').asinteger;
     Next;

   end;
   Close;
  end;
  F_MenuMgr.AddToMenu(mi_DepRed,'-' ,nil);
  if not Spisok1562_Frame1.DSET_UCHASTOK.Active then
   Spisok1562_Frame1.DSET_UCHASTOK.Open;
   with Spisok1562_Frame1.DSET_UCHASTOK do
   begin
    first;
    while not EOF do begin
    F_MenuMgr.AddToMenu(mi_DepRed,FieldByName('shot_name').asstring, mi_RegClick);
    mi_DepRed.Find(FieldByName('shot_name').asstring).tag:=FieldByName('id').asinteger;
     Next;
   end;
   Close;
 end;
end;

procedure Tfrm_Main.OnTemperSvodClick(Sender: TObject);
var
  frm_TemperSvod: Tfrm_TemperSvod;
begin
  frm_TemperSvod:=Tfrm_TemperSvod.Create(self);
  frm_TemperSvod.ShowModal;
end;

procedure Tfrm_Main.OnAnAVRByStreetClick(Sender: TObject);
var
  QueryForm: TQueryForm;
begin
  QueryForm:=TQueryForm.Create(self);
  QueryForm.ShowModal;
end;

procedure Tfrm_Main.OnAnRaskopokClick(Sender: TObject);
var
  frm_Opt: Tfrm_PeriodExcSpreadSel;
begin
  {���� ������� �� ������ ������.
  ���� ����� ����������� ����������}
  frm_Opt:=Tfrm_PeriodExcSpreadSel.Create(self);
  frm_Opt.ShowModal;
end;

procedure Tfrm_Main.mi_UsersClick(Sender: TObject);
var
  dm_UserMgr: Tdm_AvrUserManager;
begin
  dm_UserMgr:=Tdm_AvrUserManager.Create(nil);
  try
    dm_UserMgr.Execute;
  finally
    dm_UserMgr.Free
  end;
end;


function Tfrm_Main.Login(LoginType: TLoginType): boolean;
var
  Loginer: TBaseLoginer;
begin
  DM_RightsManager.OnCurrentUserChange:=OnCurrentUserChange;

  {���������}
  case LoginType of
    ltCommandStr: Loginer:=TCommandStrLoginer.Create;
    ltLoginForm: Loginer:=TFormLoginer.Create;
  end;

  try
    Result:=Loginer.Login;
  finally
    Loginer.Free;
  end;
  {���������}

  PrepareFormViewByUser;
end;

procedure Tfrm_Main.PrepareFormViewByUser;
var
  IsDisp, IsCDP: boolean;
begin
  IsDisp:=DM_RightsManager.IsCurrentUserDisp;
  IsCDP:=DM_RightsManager.IsCurrentUserDispCDP;

  sb_InputOrder.Enabled:=IsDisp;



  sb_InputOrder_vds.Enabled:=IsDisp;


  mi_ShiftNumber.Visible:=IsCDP;
  mi_InputTemper.Visible:=IsCDP;
  mi_InputOrder.Visible:=IsDisp;
  mi_EquipPlanned.Visible:=(IsDisp)or(DM_RightsManager.CurrentUserGroupID=3);
{  mi_Voc.Visible := false;{DM_RightsManager.IsCurrentUserCanEditForm( ALLVOCFORMGUID ) or
                    DM_RightsManager.IsCurrentUserCanEditForm( DEP_VOC );}
  //mi_Voc.Visible := DM_RightsManager.IsCurrentUserCanEditForm( ALLVOCFORMGUID );
  mi_Service.Visible:=IsDisp;
///    mi_Users.Visible:=isDisp;
 //   N29.Visible:=isdisp;

  lbl_ShiftNum.Visible:=IsDisp;
  lbl_ShiftDate.Visible:=IsDisp;

  Timer1.Enabled:=isDisp;
{$IFDEF spisok1562}
 if IsDisp then   begin
   if AppSettings.Get_Interval>0 then
    Timer1.Interval:=AppSettings.Get_Interval
   else
    Timer1.Enabled:=false;
   Spisok1562_Frame1.LoadSettings;
   Show1562;
  end;
  p_ForFrame1562.Visible := IsDisp;
 // p_ForFrame1562.Visible:=true;
  sp_1562.Visible:=isDisp;
{$endif}

  PrepareAomView;
end;

procedure Tfrm_Main.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=char(13) then
  begin
    if UserMgrPwd='users' then
      mi_UsersClick(Sender);
    UserMgrPwd:='';
  end else UserMgrPwd:=UserMgrPwd+Key;
end;

procedure Tfrm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('�� �������, ��� ������ ����� �� ���������?', gc_strDispAVR,
      MB_YESNO+MB_ICONQUESTION)<>ID_YES
  then
    Action:=caNone
  else
  begin
//  if assigned(Spisok1562_Frame1)and (DM_RightsManager.IsCurrentUserDisp)  then
  //  Spisok1562_Frame1.SaveSettings;


  end;

//   if Assigned(_S1562Mgr) then _S1562Mgr.Free;

end;

procedure Tfrm_Main.OnCurrentUserChange(NewUserName,
  NewUserGroupName: string);
begin
  lbl_UserName.Caption:=NewUserName+' <'+NewUserGroupName+'>';
end;

procedure Tfrm_Main.PrepareAomView;
begin
 { if AppSettings.IsCanStartAvrOnMap and
    ( DM_RightsManager.IsCurrentUserCanEditForm( AVRONMAP_EDIT ) or
      DM_RightsManager.IsCurrentUserCanEditForm( AVRONMAP_VIEW ) ) then
  begin
    mi_AvrOnMap.Visible := true;
    DM_AomComClient.OnChangeMapWorkState := OnChangeMapWorkState;
  end else
  begin
    mi_AvrOnMap.Visible := false;
    if DM_AomComClient.IsMapWork then DM_AomComClient.DisconnectFromAom
  end;
  OnChangeMapWorkState( DM_AomComClient.IsMapWork );}
end;


procedure Tfrm_Main.Button1Click(Sender: TObject);
var
  _NumSOBuff: Tdm_NumSOBuff;
  _frm: Tfrm_NumSO;
begin
  if NameCase(GetComputerName) <> 'Mp' then exit;

  _NumSOBuff := Tdm_NumSOBuff.Create( nil );
  try
    _NumSOBuff.OrderID := 1;
    //_NumSOBuff.IsReadOnly := true;
    //_NumSOBuff.LoadData;

 //������� ����� ��� ��������������
    _frm := Tfrm_NumSO.Create( nil, _NumSOBuff);
    try
      if _frm.ShowModal = mrOk then
      begin
        _NumSOBuff.OrderID := 1;
        _NumSOBuff.SaveData;
      end;
    finally
      _frm.Free;
    end;


  finally
    _NumSOBuff.Free;
  end;
end;

procedure Tfrm_Main.N0621Click(Sender: TObject);
var
  _SOMgr: TSuborderManager;
begin
  _SOMgr := TSuborderManager.Create;
  try
//    _SOMgr.OrderFields.IDDisp := g_IDOfficial;
    _SOMgr.ShowGridFrm;
  finally
    _SOMgr.Free;
  end;
end;
{$IFDEF spisok1562}
procedure Tfrm_Main.Show1562;
//var _OnClickGrid1562: Event
//  _SOMgr: TSuborderManager;


    procedure AddToGrid( _field: string; _Title: string; _len: integer);
    begin
        //
      with Spisok1562_Frame1.Grid do
       begin
        Columns.Add;
        Columns[Columns.Count-1].FieldName := _field;
        Columns[Columns.Count-1].Title.Caption := _Title;
        Columns[Columns.Count-1].Width := _len;
       // Columns[Columns.Count-1].WordWrap := true;
       // Columns[Columns.Count-1].AutoFitColWidth := true;
       end;



    end;

    procedure FillTitles;
    begin
      {AddToGrid( 'NUM1562', '� ������ 1562', 64);
      AddToGrid( 'DATATIME', '����'+#13+'�����������', 104);
      AddToGrid( 'Region', '�����', 54);
      AddToGrid( 'street_name', '�����',94);
      AddToGrid( 'house', '���', 54);
      AddToGrid( 'appartment', '��������',74);
      AddToGrid( 'about', '� ��� ��������',114);
      AddToGrid( 'AVAR', '������', 54);
      AddToGrid( 'status', '������',74);
      AddToGrid( 'ordernumber', '� ������',74);}
       AddToGrid('id','',0);
       Spisok1562_Frame1.Grid.Columns[ 0].Visible:=false;
       AddToGrid('NumberReceivedRequest', '���������� ������', 54);
       AddToGrid('NumberOurRequest', '� � ����'+'������', 44);
       AddToGrid( 'DateOurRequest', '���� � ���� ������', 84);
 //    AddColToGVB(F_GVB, 'AppurtenanceState', 'AppurtenanceState', alLeft);

    AddToGrid('DateReceivedRequest', '���� ��������', 84);
   // AddColToGVB(F_GVB, 'AppurtenanceState', 'AppurtenanceState', alCenter);
  //  AddColToGVB(F_GVB, 'State', 'State', alCenter);
    AddToGrid('Avar','����', 24);
   AddToGrid('Place','�����', 44);
    AddToGrid('rayon_name','�����', 74);
    AddToGrid('name_street','�����', 124);
    AddToGrid('HOUSE','���', 54);
    AddToGrid( 'APPARTMENT','�������', 54);
    AddToGrid('NumberFloor','����', 44);
    AddToGrid('Podesd','�������',44);
    AddToGrid('abonent','�������',44);
    AddToGrid('phone','�������',74);

    AddToGrid('opened','������',45);
    AddToGrid('ABOUT','� ��� ��������',214);
    AddToGrid('appuartenan_str','��� ����',2);
    //AddColToGVB(F_GVB, 'Appurtenance','Appurtenance', alLeft);
   // AddColToGVB(F_GVB, 'state_1','state_1', alLeft);
    AddToGrid('Number_Order','�������',54);

    end;


begin
  //
  //if not F_Show1562 then exit;
  Spisok1562_Frame1.InitFilter;
  FillTitles;
  //Spisok1562_Frame1.Grid.OnCellClick := OnClickGrid1562;


  Refresh1562;

end;

procedure Tfrm_Main.Refresh1562;
var Filt, dt1, dt2:string;
 i:integer;
begin
 try
 Timer1.Enabled:=false;
 if not Assigned(F_DM1562) then
    F_DM1562 := Tdm_Search1562.Create( nil );

  F_DM1562.StartTransaction;
  try


    Spisok1562_Frame1.GetFilter;

 //   F_DM1562.ID_Region:=Spisok1562_Frame1.ID_Region;
   // F_DM1562.RegionsList.Clear;
   { if Spisok1562_Frame1.RegionList<>nil then
    if  Spisok1562_Frame1.RegionList.Count>0 then
     begin
      F_DM1562.RegionsList:=Spisok1562_Frame1.RegionList;

     end;}
                                      //F_DM1562.RegionsList.Add(IntTOStr(Spisok1562_Frame1.ID_Region));
  //  F_DM1562.App.Clear;
 //   F_DM1562._isclosed.Clear;
   { if Spisok1562_Frame1.app=3 then
    begin
      F_DM1562.App.add('2');//from ns
      F_DM1562.App.add('3');//from vds
    //  Filt:=Filt+'  (Appurtenance=3 or AppurtenanceState=2 )'
    end
    else
     begin
      F_DM1562.App.add(IntTOStr(Spisok1562_Frame1.app+1));
    //  Filt:=Filt+' (Appurtenance='+intTostr(Spisok1562_Frame1.app+1)+')';
     end;
    }
    F_DM1562._isclosed:=Spisok1562_Frame1.isclosed;
   { F_DM1562._isclosed.Add('0');  //    F_DM1562._isclosed.Add('-1');
    if Spisok1562_Frame1.rb_inworknot.Checked then
     F_DM1562._isclosed.Add('1');  //    F_DM1562._isclosed.Add('0');
    if  Spisok1562_Frame1.rb_All.Checked then
     begin
       F_DM1562._isclosed.Add('1');      //   F_DM1562._isclosed.Add('0');
       F_DM1562._isclosed.Add('3');      //    F_DM1562._isclosed.Add('1');
    end;
    }

   // F_DM1562.ID_Region2:=Spisok1562_Frame1.ID_Region2;


    F_DM1562.F_dt1:=Spisok1562_Frame1.strStartDate;
    F_DM1562.F_dt2:=Spisok1562_Frame1.strFinishedDate;

  //  Filt:=Filt+ Format('and  ( DateOurRequest>=''%s'') and ( DateOurRequest<=''%s'')',[dt1,dt2]);

   /// F_DM1562.Filter:=Filt;
    F_DM1562.ForMainForm:= true;
    F_DM1562.Condition :=  Spisok1562_Frame1.ResultCondition; //��� ����� ������� + ����������
    F_DM1562.PrepareDset;

//    F_DM.CommitTransaction;

  except
    on E: Exception do
    begin
      F_DM1562.RollBackTransaction;
      raise Exception.Create( E.Message + 'Tfrm_Main.Show1562' );
    end;
  end;
 except
  on e:exception do
  begin
  Timer1.Enabled:=false;
     Application.MessageBox(PChar(E.message+'�� ������ ���������� ������� ������. �������������� ���������!'), '������', MB_OK);
   exit;
  end;
 end;
 try
if (Time>StrToTime(startstrDateCreateReportrs)) and (Time<StrToTime(endrtstrDateCreateReportrs)) then //31.07.2012 glasha
 if AppSettings.Get_IsSentXML='1' then  //1.08.2012 glasha
 //   SaveForStDispXML();    //31.07.2012 glasha
     OneDayManagerTime.ExcuteAll;
except
   on e:exception do
   Application.MessageBox(PChar(E.message+'�� ������ ���������� ���������� ��� ��������� ������� �������!'), '������', MB_OK);
end;

{try
if (Time>StrToTime('6:00:01')) and (Time<StrToTime('6:30:01')) then //31.07.2012 glasha
   if AppSettings.Get_IsSentXML='1' then///AppSettings.Get_IsSaveRazr='1' then  //12.10.2012 glasha
    Save_for_Ras();    //31.07.2012 glasha
except
   on e:exception do
   Application.MessageBox(PChar(E.message+'�� ������ ���������� ���������� ��� ������ ��������!'), '������', MB_OK);
end;
}
Timer1.Enabled:=true;
end;


procedure Tfrm_Main.OnClickGrid1562;

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
 // F_ResFrm: Tfrm_Order1562;
  F_SearchOrders: TSearchForOrdersFromOtherClasses2;
 // F_Order1562: TOrder1562Manager;
begin

Timer1.Enabled:=false;
if  (F_DM1562.ResultDset.RecordCount>0) and (Spisok1562_Frame1.Grid.Row>0) then
begin
 F_SearchOrders := TSearchForOrdersFromOtherClasses2.Create;
        F_SearchOrders.ShowAll := true;


        F_SearchOrders.MainGrid:=Spisok1562_Frame1.Grid;
        F_SearchOrders._result1562:=F_DM1562.ResultDset;
       F_SearchOrders.Condition:=' where ';



                F_SearchOrders.onOrder1562Click(nil);

        with F_SearchOrders    do begin
        try
           _IsExecuteOk:= Execute;

            Refresh1562;

        finally
          F_ResFrm.Free;
        end;
      end;// with F_SearchOrders

 end;
 Timer1.Enabled:=true;
end;


procedure Tfrm_Main.ClickGrid1562;
var
  _RegionID, _ID1562, Order_ID, i: integer;
  _Datatime: TDate;
  F_Order1562: TOrder1562Manager;
begin

  F_Order1562 := TOrder1562Manager.Create;
  try
    _id1562 := F_DM1562.ResultDset.fieldbyname('id').AsInteger;

    F_Order1562.ShowOrder( _ID1562 );
  finally
    F_Order1562.Free;
  end;
end;


{$endif}


procedure Tfrm_Main.Spisok1562_Frame1Button1Click(Sender: TObject);
begin
   //

end;


procedure Tfrm_Main.Spisok1562_Frame1GridDblClick(Sender: TObject);

begin
Timer1.Enabled:=false;
{$IFDEF spisok1562}

 if not(IsNeedToChangeShift or IsNeedToInputTemper) then
  begin
  if (F_DM1562.ResultDset.RecordCount>0) and ( Spisok1562_Frame1.Grid.Row>0) then
   OnClickGrid1562;  // ������ �����
  end;
//    ClickGrid1562;  // �����  �����

{$endif}
Timer1.Enabled:=true;

end;

procedure Tfrm_Main.SpeedButton2Click(Sender: TObject);
var
  frm_SearchOrderByNumber: Tfrm_SearchOrderByNumber;
begin
  if FlagShift
  then  begin
		  frm_SearchOrderByNumber:=Tfrm_SearchOrderByNumber.Create(self);
		  try
			frm_SearchOrderByNumber.ShowModal;
		  finally
			frm_SearchOrderByNumber.Free
		  end;
		end
  else N9Click(self);
end;

procedure Tfrm_Main.Timer1Timer(Sender: TObject);
begin
 {$IFDEF spisok1562}
   Refresh1562;

{$endif}
end;

procedure Tfrm_Main.sp_1562Click(Sender: TObject);
begin
Timer1.Enabled:=false;
end;

procedure Tfrm_Main.sb_InputOrder_vdsClick(Sender: TObject);
var
frm_Order:Tfrm_Order_vds;
begin
if not(IsNeedToChangeShift or IsNeedToInputTemper) then
begin
 try
  frm_Order:=Tfrm_Order_vds.Create(Application); //����� �����
  frm_Order.ShowModal;
 finally
   frm_Order.Free;
 end;  
end;    
end;

procedure Tfrm_Main.sp_UniversalSearchClick(Sender: TObject);
var
 frm_befor:Tfor_univ_serch;
begin
  if not(IsNeedToChangeShift or IsNeedToInputTemper) then

   try
    frm_befor:=Tfor_univ_serch.Create(Application);
    frm_befor.ShowModal;
   finally
     frm_befor.Free;
   end;

end;

procedure Tfrm_Main.N3Click(Sender: TObject);
begin
  Login(ltLoginForm);
end;

procedure Tfrm_Main.N4Click(Sender: TObject);
var frm_opt:Tfrm_options1562;
begin

try
   frm_opt:=Tfrm_options1562.Create(Self,);
   frm_opt.Automat.Checked:=timer1.Enabled;
   frm_opt.Interval.Value:=Timer1.Interval div 60000;
   frm_opt.ShowModal;
   if frm_opt.ModalResult=mrOk then
     begin
      Timer1.Enabled:= frm_opt.Automat.Checked;
       if Timer1.Enabled then Timer1.Interval:= frm_opt.Interval.Value*60000;
     end;
  finally
   frm_opt.Free;
  end;
 { except on E:exception do
     Application.MessageBox('�� ���������� ����� ��������!', '������', MB_OK);
   end ;}
end;

procedure Tfrm_Main.Spisok1562_Frame1RegionsClick(Sender: TObject);
begin
  Spisok1562_Frame1.RegionsClick(Sender);

end;

procedure Tfrm_Main.sb_ReconnectClick(Sender: TObject);
begin
DM_Main.ReconnectAll;
end;

procedure Tfrm_Main.Spisok1562_Frame1BitBtn1Click(Sender: TObject);  // ��� ���������� ������ ������ ������� ����� �������    23.01.2012
begin
{$IFDEF spisok1562}
   Spisok1562_Frame1.SaveSettings;
   Refresh1562;

{$endif}
end;

procedure Tfrm_Main.Spisok1562_Frame1GridTitleClick(Column: TColumn);
begin
  Spisok1562_Frame1.GridTitleClick(Column);
  REfresh1562;
end;

procedure Tfrm_Main.Spisok1562_Frame1BitBtn2Click(Sender: TObject);
   var frm_Wait: Tfrm_WaitProcess;
     col:integer;
     str:string;
     Save_Column:TColumn;
     L:string;
begin
  Timer1.Enabled:=false;
 Spisok1562_Frame1.SaveColumn;
 try
 frm_Wait:=Tfrm_WaitProcess.Create(nil);
 frm_Wait.Show;
   try
   if not Assigned(F_DM1562) then
    F_DM1562 := Tdm_Search1562.Create( nil );

  F_DM1562.StartTransaction;
  try
    Spisok1562_Frame1.GetFilter;


    F_DM1562.Condition :=  Spisok1562_Frame1.ResultCondition; //��� ����� ������� + ����������
    L:=F_DM1562.Redefine;
    F_DM1562.ForMainForm:= true;
    Spisok1562_Frame1.LoadColumn;
    Spisok1562_Frame1.GetFilter;
    F_DM1562.Condition :=  Spisok1562_Frame1.ResultCondition; //��� ����� ������� + ����������
    F_DM1562.PrepareDset;
    if L='' then
     str:='��� ���������������� ������!!'
    else
     str:='������ ���������������� ������-'+L;
    {case col mod 10 of
     1:str:='�������������a '+InttoStr(col)+'  �����a';
     2,3,4:str:='�������������o '+InttoStr(col)+' ������';
     0,5,6,7,8,9:str:='�������������o '+InttoStr(col)+' ������';
    end;   }
    Application.MessageBox(PAnsiChar(str ),gc_strDispAVR,
                           MB_OK+MB_ICONINFORMATION );
    Timer1.Enabled:=true;
//    F_DM.CommitTransaction;
  except
    on E: Exception do
    begin
      F_DM1562.RollBackTransaction;
      raise Exception.Create( E.Message + 'Tfrm_Main.Redefine' );
    end;
  end;
 except
  on e:exception do
  begin
  Timer1.Enabled:=false;
     Application.MessageBox(PChar(E.message+'�� ������ ���������������. �������������� ���������!'), '������', MB_OK);
  end;
 end;
 frm_Wait.Hide;
 finally
frm_wait.Free
end;
end;

{�������� ����� ������� ��� ������ �� �������}
procedure  Tfrm_Main.OpenDeps(Reg:integer;Reg_name:string);
var _IsReadOnly: boolean;
     visoutOrder:boolean;
     F_DepMgr: TNGDepManager;
     str:string;
begin
try
  F_DepMgr := TNGDepManager.Create;
 _IsREadOnly:=false;
 visoutOrder:=true;
 F_DepMgr.DepData.OrderID :=-Reg;

 str:='01.01.'+IntToStr(GetYear(Now()));

 F_DepMgr.DepData.OrderDateComing :=StrToDate(str);
 F_DepMgr.DepData.CurShiftDate := F_ShiftDate;
 F_DepMgr.Name_Reg:=Reg_name;
 F_DepMgr.Execute( etReg, _IsReadOnly,Reg,visoutOrder );
 F_DepMgr.DepData.CommitTran;
finally
  F_DepMgr.Free;
end;

end;

procedure Tfrm_Main.mi_RegClick(Sender: TObject);
var s:integer;
begin
DM_Main.IsNeedToChangeShift;

s:=(Sender as TMenuItem).Tag;
OpenDeps(s, (Sender as TMenuItem).Caption);

end ;

end.
