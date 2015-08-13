unit UtechkiNaVodosetiRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, ExtCtrls, Grids, Aligrid, StdCtrls, Buttons;

type
  Tfrm_UtechkiNaVodosetiRes = class(Tfrm_BaseResult)
    pnl_Podacha: TPanel;
    grd_Podacha: TStringAlignGrid;
    grd_Utechka: TStringAlignGrid;
    pnl_Utechka: TPanel;
    pnl_btns: TPanel;
    pnl_AddInfo: TPanel;
    lbl_PodachaHeader: TLabel;
    lbl_UtechkaHeader: TLabel;
    btn_Print: TBitBtn;
    btn_Excel: TBitBtn;
    btn_Word: TBitBtn;
    btn_Exit: TBitBtn;
    lbl_Podacha: TLabel;
    lbl_Utechka: TLabel;
    lbl_UtechkaPercent: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
  private
    F_strPodachaHeader: string;
    F_strUtechkaHeader: string;
    F_strPodacha: string;
    F_strUtechka: string;
    F_strUtechkaPercent: string;

    F_OnPrintClick: TNotifyEvent;
    F_OnExcelClick: TNotifyEvent;
    F_OnWordClick: TNotifyEvent;
  public
    property strPodachaHeader: string read F_strPodachaHeader write F_strPodachaHeader;
    property strUtechkaHeader: string read F_strUtechkaHeader write F_strUtechkaHeader;
    property strPodacha: string read F_strPodacha write F_strPodacha;
    property strUtechka: string read F_strUtechka write F_strUtechka;
    property strUtechkaPercent: string read F_strUtechkaPercent write F_strUtechkaPercent;

    property OnPrintClick: TNotifyEvent read F_OnPrintClick write F_OnPrintClick;
    property OnExcelClick: TNotifyEvent read F_OnExcelClick write F_OnExcelClick;
    property OnWordClick: TNotifyEvent read F_OnWordClick write F_OnWordClick;

    constructor Create(AOwner: TComponent; Title: string);
  end;

implementation

{$R *.dfm}


constructor Tfrm_UtechkiNaVodosetiRes.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_UtechkiNaVodosetiRes.FormShow(Sender: TObject);
begin
  inherited;
  lbl_PodachaHeader.Caption:=F_strPodachaHeader;
  lbl_UtechkaHeader.Caption:=F_strUtechkaHeader;
  lbl_Podacha.Caption:=F_strPodacha;
  lbl_Utechka.Caption:=F_strUtechka;
  lbl_UtechkaPercent.Caption:=F_strUtechkaPercent;

  btn_Print.OnClick:=F_OnPrintClick;
  btn_Excel.OnClick:=F_OnExcelClick;
  btn_Word.OnClick:=F_OnWordClick;

  btn_Print.Visible:=Assigned(F_OnPrintClick);
  btn_Excel.Visible:=Assigned(F_OnExcelClick);
  btn_Word.Visible:=Assigned(F_OnWordClick);
end;

procedure Tfrm_UtechkiNaVodosetiRes.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
