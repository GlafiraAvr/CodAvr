unit ResNeedAsfaltForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, ExtCtrls, Grids, DBGridEh, DB, RepNeedAsfaltDModule,
  StdCtrls, Buttons, RepBlagDetailDM;

type
  TSelDetailEvent = procedure( _DetailInfo :TDetailInfo ) of object;

  Tfrm_ResNeedAsfalt = class(Tfrm_BaseResult)
    pnl_top: TPanel;
    pnl_grid: TPanel;
    pnl_btns: TPanel;
    Grid: TDBGridEh;
    ds_Result: TDataSource;
    btn_Print: TBitBtn;
    btn_Exit: TBitBtn;
    lbl_Caption: TLabel;
    procedure GridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    F_strBeginDate,
    F_strEndDate,
    F_strGranDate: string;
    F_OnPrintClick: TNotifyEvent;
    F_OnSelDetail: TSelDetailEvent;
    F_DefoultColumnCaptions: TStringList;
    procedure PrepareGridTitle;
    procedure SetBeginDate(const Value: TDateTime);
    procedure SetEndDate(const Value: TDateTime);
    procedure SetGranDate(const Value: TDateTime);
    function Dt_2_Str( const Value: TDateTime ): string;
    procedure SetCaption(const Value: string);
  public
    property BeginDate: TDateTime write SetBeginDate;
    property EndDate: TDateTime write SetEndDate;
    property GranDate: TDateTime write SetGranDate;
    property Caption: string write SetCaption;
    property OnPrintClick: TNotifyEvent read F_OnPrintClick write F_OnPrintClick;
    property OnSelDetail: TSelDetailEvent read F_OnSelDetail write F_OnSelDetail;
  end;


implementation

{$R *.dfm}

procedure Tfrm_ResNeedAsfalt.GridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  inherited;
  if Assigned( F_OnSelDetail ) then
  begin
    case Column.Tag of
      1: F_OnSelDetail( diNeedRestore );
      2: F_OnSelDetail( diNeedRestoreGran );
      3: F_OnSelDetail( diPlanRestore );
      4: F_OnSelDetail( diRestoredPlan );
      5: F_OnSelDetail( diNewExc );
      6: F_OnSelDetail( diRestoredNoplan );
      7: F_OnSelDetail( diInWork );
      8: F_OnSelDetail( diOstatGran );
      9: F_OnSelDetail( diTotalRestored );
      else F_OnSelDetail( diNull );
    end;
  end;
end;

procedure Tfrm_ResNeedAsfalt.PrepareGridTitle;
  function _Prep( const _S: string ): string;
  begin
    Result := StringReplace( _S, '%gran', F_strGranDate, [rfReplaceAll, rfIgnoreCase] );
    Result := StringReplace( Result, '%beg', F_strBeginDate, [rfReplaceAll, rfIgnoreCase] );
    Result := StringReplace( Result, '%end', F_strEndDate, [rfReplaceAll, rfIgnoreCase] );
  end;
var
  i: integer;
begin
  for i:=0 to Grid.Columns.Count -1 do
    Grid.Columns[i].Title.Caption := F_DefoultColumnCaptions.Strings[i];

  for i:=0 to Grid.Columns.Count -1 do
    Grid.Columns[i].Title.Caption := _Prep( Grid.Columns[i].Title.Caption );
end;

procedure Tfrm_ResNeedAsfalt.SetBeginDate(const Value: TDateTime);
begin
  F_strBeginDate := Dt_2_Str( Value );
end;

procedure Tfrm_ResNeedAsfalt.SetEndDate(const Value: TDateTime);
begin
  F_strEndDate := Dt_2_Str( Value );
end;

procedure Tfrm_ResNeedAsfalt.SetGranDate(const Value: TDateTime);
begin
  F_strGranDate := Dt_2_Str( Value );
end;

procedure Tfrm_ResNeedAsfalt.FormShow(Sender: TObject);
begin
  inherited;
  PrepareGridTitle;
end;

function Tfrm_ResNeedAsfalt.Dt_2_Str(const Value: TDateTime): string;
begin
  Result := FormatDateTime( 'dd.mm.yy', Value );
end;

procedure Tfrm_ResNeedAsfalt.SetCaption(const Value: string);
begin
  lbl_Caption.Caption := Value;
end;

procedure Tfrm_ResNeedAsfalt.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_ResNeedAsfalt.btn_PrintClick(Sender: TObject);
begin
  inherited;
  if Assigned( F_OnPrintClick ) then
    F_OnPrintClick( Sender );
end;

procedure Tfrm_ResNeedAsfalt.FormCreate(Sender: TObject);
var
  i: integer;
begin
  inherited;
  F_DefoultColumnCaptions := TStringList.Create;

  for i:=0 to Grid.Columns.Count -1 do
    F_DefoultColumnCaptions.Add( Grid.Columns[i].Title.Caption );
end;

procedure Tfrm_ResNeedAsfalt.FormDestroy(Sender: TObject);
begin
  inherited;
  F_DefoultColumnCaptions.Free;
end;

end.
