unit OptTrudoZatrat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, BaseFrameOptionForm, ExtCtrls, StdCtrls,
  Buttons, SelDatePeriodFrame, RxLookup, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tfrm_OptTrudoZatrat = class(Tfrm_BaseOption)
    frame_Dates: Tframe_SelDatePeriod;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    mt_RegAttach: TkbmMemTable;
    dbl_Region: TRxDBLookupCombo;
    Label1: TLabel;
    ds_RegAttach: TDataSource;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    function GetRegionID: integer;
    function GetRegionName: string;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptTrudoZatrat.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptTrudoZatrat.btn_okClick(Sender: TObject);
begin
  if frame_Dates.IsDatesCorrect then
    if HelpFunctions.IsDBLEmpty( dbl_Region ) then
      Application.MessageBox( 'Выберите район!', 'Внимание', MB_OK + MB_ICONWARNING )
    else
      ModalResult := mrOk;
end;

procedure Tfrm_OptTrudoZatrat.FormCreate(Sender: TObject);
begin
  inherited;
  DM_GlobalVocCache.CheckVoc( mt_RegAttach );
  mt_RegAttach.Open;
  HelpFunctions.FixDBLValue( 9, dbl_Region );
end;

function Tfrm_OptTrudoZatrat.GetRegionID: integer;
begin
  Result := mt_RegAttach.FieldByName( 'id' ).AsInteger;
end;

function Tfrm_OptTrudoZatrat.GetRegionName: string;
begin
  Result := trim( mt_RegAttach.FieldByName( 'name' ).AsString );
end;

end.
