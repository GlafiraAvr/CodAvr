unit FrPreviewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FR_View, BaseFrPreviewForm, StdCtrls, Buttons,
  FR_Class, frOLEExl, frRtfExp, FR_E_TXT;

type
  TPreviewButton=(pbPrint, pbExcel, pbWord, pbText, bb_Mail);
  TPreviewButtons=set of TPreviewButton;

  Tfrm_FrPreview = class(Tfrm_BaseFrPreview)
    pnl_Btns: TPanel;
    frPreview: TfrPreview;
    sb_Print: TSpeedButton;
    sb_Excel: TSpeedButton;
    sb_exit: TSpeedButton;
    frOLEExcelExport: TfrOLEExcelExport;
    dlg_SaveExcel: TSaveDialog;
    frRtfAdvExport: TfrRtfAdvExport;
    sb_Word: TSpeedButton;
    dlg_SaveWord: TSaveDialog;
    sb_Graph: TSpeedButton;
    sb_Text: TSpeedButton;
    frTextExport: TfrTextExport;
    dlg_SaveText: TSaveDialog;
    bb_Mail: TBitBtn;
    frRtfAdvExport1: TfrRtfAdvExport;
    procedure sb_PrintClick(Sender: TObject);
    procedure sb_ExcelClick(Sender: TObject);
    procedure sb_exitClick(Sender: TObject);
    procedure sb_WordClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sb_GraphClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sb_TextClick(Sender: TObject);
    procedure bb_MailClick(Sender: TObject);
  private
    F_OnShowGraph: TNotifyEvent;
    frReport: TfrReport;
    F_PreviewButtons: TPreviewButtons;
    F_NeedAsk, F_ToMail: boolean;
    F_NameReport: string;
    procedure SetDefaultPrBtns;
  public
    property ToMail: boolean read F_ToMail;
    property NeedAsk: boolean write F_NeedAsk;
    property OnShowGraph: TNotifyEvent read F_OnShowGraph write F_OnShowGraph;
    property PreviewButtons: TPreviewButtons read F_PreviewButtons write F_PreviewButtons;
    property NameReport: string write F_NameReport;
    constructor Create(AOwner: TComponent; frRep: TfrReport);
  end;


implementation

{$R *.dfm}

uses StringConsts;

procedure Tfrm_FrPreview.sb_PrintClick(Sender: TObject);
begin
  frPreview.Print;
end;

procedure Tfrm_FrPreview.sb_ExcelClick(Sender: TObject);
begin
  if not dlg_SaveExcel.Execute then exit;
  frReport.ExportTo(frOLEExcelExport, dlg_SaveExcel.FileName);
  Application.MessageBox('Отчет сохранен в формате XLS',
                          gc_strDispAVR, MB_OK+MB_ICONINFORMATION);

end;

constructor Tfrm_FrPreview.Create(AOwner: TComponent; frRep: TfrReport);
begin
  inherited Create(AOwner);
  frReport:=frRep;
  frReport.Preview:=frPreview;
  F_ToMail := false;
end;

procedure Tfrm_FrPreview.sb_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_FrPreview.sb_WordClick(Sender: TObject);
begin
  if not dlg_SaveWord.Execute then exit;
  frReport.ExportTo(frRtfAdvExport, dlg_SaveWord.FileName+'.rtf');
  Application.MessageBox('Отчет сохранен в формате RFT',
                          gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
end;

procedure Tfrm_FrPreview.FormShow(Sender: TObject);
begin
  if Assigned(F_OnShowGraph) then sb_Graph.Visible:=true
  else sb_Graph.Visible:=false;

  if (pbPrint in F_PreviewButtons) then sb_Print.Visible:=true
  else sb_Print.Visible:=false;

  if (pbExcel in F_PreviewButtons) then sb_Excel.Visible:=true
  else sb_Excel.Visible:=false;

  if (pbWord in F_PreviewButtons) then sb_Word.Visible:=true
  else sb_Word.Visible:=false;

  if (pbText in F_PreviewButtons) then sb_Text.Visible:=true
  else sb_Text.Visible:=false;

  F_ToMail := false;

  WindowState:=wsMaximized;
end;

procedure Tfrm_FrPreview.sb_GraphClick(Sender: TObject);
begin
  if Assigned(F_OnShowGraph) then
    F_OnShowGraph(Sender);
end;

procedure Tfrm_FrPreview.SetDefaultPrBtns;
begin
  F_PreviewButtons:=[pbPrint, pbExcel];
end;


procedure Tfrm_FrPreview.FormCreate(Sender: TObject);
begin
  inherited;
  SetDefaultPrBtns;
  F_NeedAsk := false;
end;

procedure Tfrm_FrPreview.sb_TextClick(Sender: TObject);
begin
  if not dlg_SaveText.Execute then exit;
  frReport.ExportTo(frTextExport, dlg_SaveText.FileName+'.txt');
  Application.MessageBox('Отчет сохранен в текстовом формате',
                          gc_strDispAVR, MB_OK+MB_ICONINFORMATION);
end;

procedure Tfrm_FrPreview.bb_MailClick(Sender: TObject);
var
  file_name: string;
begin
  inherited;
    {Отправка по почте}
  if  not( F_NeedAsk ) then F_ToMail := true
   else
    if Application.MessageBox('Отправить сформированную ведомость по почте?',
        PChar(F_NameReport), MB_YESNO+MB_ICONQUESTION)=IDYES then F_ToMail := true;
   {    begin
      file_name:=trim(AppSettings.Get_Abon_Path+
                    'svod_plan_'+ReplaceChar(DateToStr(Date), '.', '_'));

      ExportFRToRTFAndSendByEmail(F_DM.frReport, file_name, F_Name);
     // ExportFRToExcelAndSendByEmail(F_DM.frReport, file_name, F_Name);
    end;}
    {/Отправка по почте}
end;

end.
