unit MenuManager;

interface

uses Classes, Menus, Forms, Windows, Controls, Buttons,
      ReportManager, AnalysisManager, NGReportManager, VocManager,

      NGReportManager_vds,ReportManager_vds;//הכÿ מעקועמג טח גהס


type
  TMenuContainer=class
  protected
    F_Name: string;
    F_IsCheckShift: boolean;
    procedure Execute; virtual; abstract;
  public
    procedure OnClick(Sender: TObject);
    property Name: string read F_Name write F_Name;
    property IsCheckShift: boolean read F_IsCheckShift write F_IsCheckShift;
    constructor Create;
  end;

  TRepMenuContainer=class(TMenuContainer)
  protected
    F_ReportName: TReportName;
    procedure Execute; override;
  public
    property ReportName: TReportName read F_ReportName write F_ReportName;
  end;

   TRepVdsMenuContainer=class(TMenuContainer)
  protected
    F_ReportName: TReportNameVds;
    procedure Execute; override;
  public
    property ReportName: TReportNameVDS read F_ReportName write F_ReportName;
  end;

  TAnMenuContainer=class(TMenuContainer)
  protected
    F_AnalysisName: TAnalysisName;
    procedure Execute; override;
  public
    property AnalysisName: TAnalysisName read F_AnalysisName write F_AnalysisName;
  end;

  TNGRepMenuContainer=class(TMenuContainer)
  protected
    F_NGReportName: TNGReportName;
    procedure Execute; override;
  public
    property NGReportName: TNGReportName read F_NGReportName write F_NGReportName;
  end;

  TVocMenuContainer=class(TMenuContainer)
  protected
    F_VocName: TVocName;
    F_IsReadOnly: boolean;
    procedure Execute; override;
  public
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    property VocName: TVocName read F_VocName write F_VocName;
  end;

  TMenuManager=class
  private
    F_ContList: TList;
    procedure AddMenu(omenu: TMenuItem; menu_name: string; on_click: TNotifyEvent);
    procedure AddCtrl(ctrl: TControl; on_click: TNotifyEvent);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRepToMenu(omenu: TMenuItem; menu_name: string; rep_name: TReportName; is_check_shift: boolean=false);
    procedure AddAnToMenu(omenu: TMenuItem; menu_name: string; an_name: TAnalysisName; is_check_shift: boolean=false);
    procedure AddNGRepToMenu(omenu: TMenuItem; menu_name: string; ngrep_name: TNGReportName; is_check_shift: boolean=false);
    procedure AddToMenu(omenu: TMenuItem; menu_name: string; on_click: TNotifyEvent);
    procedure AddRepToCtrl(ctrl: TControl; rep_name: TReportName; is_check_shift: boolean=false);
    procedure AddNGRepToCtrl(ctrl: TControl; ngrep_name: TNGReportName; is_check_shift: boolean=false);
    procedure AddVocToMenu(omenu: TMenuItem; menu_name: string; voc_name: TVocName; is_readonly: boolean);
    procedure AddRepVDSToMenu(omenu: TMenuItem; menu_name: string;rep_name: TReportNameVDS; is_check_shift: boolean=false);

  procedure AddNGRepvdsToCtrl(ctrl: TControl; ngrep_name: TNGReportName_vds; is_check_shift: boolean);  //2012
  procedure AddNGRepvdsToMenu(omenu: TMenuItem; menu_name: string; ngrep_name: TNGReportName_vds; is_check_shift: boolean);
  end;

   TNGRepMenuContainer_vds=class(TMenuContainer)
  protected
    F_NGReportName: TNGReportName_vds;
    procedure Execute; override;
  public
    property NGReportName: TNGReportName_vds read F_NGReportName write F_NGReportName;
  end;

implementation

uses  shiftnumform, TemperatureForm, StringConsts;

{ TRepMenuManager }

procedure TMenuManager.AddAnToMenu(omenu: TMenuItem; menu_name: string;
  an_name: TAnalysisName; is_check_shift: boolean=false);
var
  amcont: TAnMenuContainer;
begin
  amcont:=TAnMenuContainer.Create;
  amcont.AnalysisName:=an_name;
  amcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(amcont);

  AddMenu(omenu, menu_name, amcont.OnClick);
end;

procedure TMenuManager.AddCtrl(ctrl: TControl; on_click: TNotifyEvent);
begin
  if (ctrl is TSpeedButton) then
    (ctrl as TSpeedButton).OnClick:=on_click;
end;

procedure TMenuManager.AddMenu(omenu: TMenuItem; menu_name: string;
  on_click: TNotifyEvent);
var
  mi: TMenuItem;
begin
  mi:=TMenuItem.Create(omenu);
  mi.Caption:=menu_name;
  mi.OnClick:=on_click;
  
  omenu.Add(mi);
end;

procedure TMenuManager.AddNGRepToCtrl(ctrl: TControl;
  ngrep_name: TNGReportName; is_check_shift: boolean);
var
  ngcont: TNGRepMenuContainer;
begin
  ngcont:=TNGRepMenuContainer.Create;
  ngcont.NGReportName:=ngrep_name;
  ngcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(ngcont);
  AddCtrl(ctrl, ngcont.OnClick);
end;

procedure TMenuManager.AddNGRepToMenu(omenu: TMenuItem; menu_name: string;
  ngrep_name: TNGReportName; is_check_shift: boolean);
var
  ngcont: TNGRepMenuContainer;
begin
  ngcont:=TNGRepMenuContainer.Create;
  ngcont.NGReportName:=ngrep_name;
  ngcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(ngcont);

  AddMenu(omenu, menu_name, ngcont.OnClick);
end;

{}
procedure TMenuManager.AddNGRepvdsToCtrl(ctrl: TControl;
  ngrep_name: TNGReportName_vds; is_check_shift: boolean);
var
  ngcont: TNGRepMenuContainer_vds;
begin
  ngcont:=TNGRepMenuContainer_vds.Create;
  ngcont.NGReportName:=ngrep_name;
  ngcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(ngcont);
  AddCtrl(ctrl, ngcont.OnClick);
end;

procedure TMenuManager.AddNGRepvdsToMenu(omenu: TMenuItem; menu_name: string;
  ngrep_name: TNGReportName_vds; is_check_shift: boolean);
var
  ngcont: TNGRepMenuContainer_vds;
begin
  ngcont:=TNGRepMenuContainer_vds.Create;
  ngcont.NGReportName:=ngrep_name;
  ngcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(ngcont);

  AddMenu(omenu, menu_name, ngcont.OnClick);
end;
{/}

procedure TMenuManager.AddRepToCtrl(ctrl: TControl; rep_name: TReportName;
  is_check_shift: boolean);
var
  rccont: TRepMenuContainer;
begin
  rccont:=TRepMenuContainer.Create;
  rccont.ReportName:=rep_name;
  rccont.IsCheckShift:=is_check_shift;
  F_ContList.Add(rccont);
  //ctrl.OnClick:=rccont.OnClick;
  AddCtrl(ctrl, rccont.OnClick);
end;

procedure TMenuManager.AddRepToMenu(omenu: TMenuItem; menu_name: string;
  rep_name: TReportName; is_check_shift: boolean=false);
var
  rmcont: TRepMenuContainer;
begin
  rmcont:=TRepMenuContainer.Create;
  rmcont.ReportName:=rep_name;
  rmcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(rmcont);

  AddMenu(omenu, menu_name, rmcont.OnClick);
end;

procedure TMenuManager.AddRepVDSToMenu(omenu: TMenuItem; menu_name: string;
  rep_name: TReportNameVDS; is_check_shift: boolean=false);
var
  rmcont: TRepVDSMenuContainer;
begin
  rmcont:=TRepVDSMenuContainer.Create;
  rmcont.ReportName:=rep_name;
  rmcont.IsCheckShift:=is_check_shift;
  F_ContList.Add(rmcont);

  AddMenu(omenu, menu_name, rmcont.OnClick);
end;

procedure TMenuManager.AddToMenu(omenu: TMenuItem; menu_name: string;
  on_click: TNotifyEvent);
begin
  AddMenu(omenu, menu_name, on_click);
end;

procedure TMenuManager.AddVocToMenu(omenu: TMenuItem; menu_name: string;
  voc_name: TVocName; is_readonly: boolean);
var
  vcont: TVocMenuContainer;
begin
  vcont:=TVocMenuContainer.Create;
  vcont.VocName:=voc_name;
  vcont.IsReadOnly:=is_readonly;
  F_ContList.Add(vcont);

  AddMenu(omenu, menu_name, vcont.OnClick);
end;

constructor TMenuManager.Create;
begin
  inherited Create;
  F_ContList:=TList.Create;
end;

destructor TMenuManager.Destroy;
var
  i: integer;
begin
  for i:=0 to F_ContList.Count-1 do
    TRepMenuContainer(F_ContList.Items[i]).Free;
  F_ContList.Free;

  inherited Destroy;
end;

{ TRepMenuContainer }

procedure TRepMenuContainer.Execute;
var
  dm_RepMgr: Tdm_ReportManager;
begin
  dm_RepMgr:=Tdm_ReportManager.Create(nil);
  try
    dm_RepMgr.ShowReport(F_ReportName);
  finally
    dm_RepMgr.Free;
  end;
end;

{ TRepVDSMenuContainer }
procedure TRepVdsMenuContainer.Execute;
var
  dm_RepMgr: Tdm_ReportManager_vds;
begin
  dm_RepMgr:=Tdm_ReportManager_vds.Create(nil);
  try
    dm_RepMgr.ShowReport(F_ReportName);
  finally
    dm_RepMgr.Free;
  end;
end;

{ TMenuContainer }

constructor TMenuContainer.Create;
begin
  inherited Create;
  F_IsCheckShift:=false;
end;

procedure TMenuContainer.OnClick(Sender: TObject);
begin
  if not (F_IsCheckShift and (IsNeedToChangeShift or IsNeedToInputTemper)) then
    Execute;
end;

{ TAnMenuContainer }

procedure TAnMenuContainer.Execute;
var
  dm_AnMgr: TDM_AnalysisManager;
begin
  dm_AnMgr:=TDM_AnalysisManager.Create(nil);
  try
    dm_AnMgr.ShowAnalysis(F_AnalysisName);
  finally
    dm_AnMgr.Free;
  end;
end;

{ TNGRepMenuContainer }

procedure TNGRepMenuContainer.Execute;
var
  RepMan: TNGReportManager;
begin
  RepMan:=TNGReportManager.Create;
  try
    RepMan.ShowReport(F_NGReportName);
  finally
    RepMan.Free;
  end;
end;

{ TVocMenuContainer }

procedure TVocMenuContainer.Execute;
var
  VocMgr: TVocManager;
begin
  VocMgr:=TVocManager.Create;
  try
    VocMgr.ShowVoc(F_VocName, F_IsReadOnly);
  finally
    VocMgr.Free;
  end;
end;


{ TNGRepMenuContainer_vds}
procedure TNGRepMenuContainer_vds.Execute;
var
  RepMan: TNGReportManager_vds;
begin
  RepMan:=TNGReportManager_vds.Create;
  try
    RepMan.ShowReport(F_NGReportName);
  finally
    RepMan.Free;
  end;
end;
{/ TNGRepMenuContainer_vds}
end.
