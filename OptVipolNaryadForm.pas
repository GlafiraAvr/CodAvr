unit OptVipolNaryadForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, StdCtrls, Buttons, GlobalVocCacheDModule,
  DB, kbmMemTable, RxLookup, SelDatePeriodFrame, RepVipolNaryadDModule;

type
  Tfrm_OptVipolNaryad = class(Tfrm_BaseOption)
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dbl_Region: TRxDBLookupCombo;
    mt_RegAttach: TkbmMemTable;
    Label3: TLabel;
    ds_RegAttach: TDataSource;
    dbl_WorkType: TRxDBLookupCombo;
    mt_WorkTypeAttach: TkbmMemTable;
    ds_WorkTypeAttach: TDataSource;
    Label4: TLabel;
    frame_SelDates: Tframe_SelDatePeriod;
    RBG_Sort: TRadioGroup;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
 
  public
    function GetRegionID: integer;
    function GetWorkTypeID: integer;
    //
    function GetRegionName: string;
    function GetWorkTypeName: string;
    //
    function GetSortType: TRV_SortType;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptVipolNaryad.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptVipolNaryad.btn_okClick(Sender: TObject);
begin
  if frame_SelDates.IsDatesCorrect then
  begin
    if IsDblEmpty( dbl_Region ) then
      Application.MessageBox( 'Выберите район!', 'Внимание', MB_OK + MB_ICONWARNING )
    else
    if IsDblEmpty( dbl_WorkType ) then
      Application.MessageBox( 'Выберите вид работы!', 'Внимание', MB_OK + MB_ICONWARNING )
    else
      ModalResult := mrOk;
  end;
end;

procedure Tfrm_OptVipolNaryad.FormCreate(Sender: TObject);
var
  _AttList: TList;
begin
  inherited;
  _AttList := TList.Create;
  try
    _AttList.Add( mt_RegAttach );
    _AttList.Add( mt_WorkTypeAttach );
    DM_GlobalVocCache.CheckVocs( _AttList );
  finally
    _AttList.Free;
  end;
  mt_RegAttach.Open;
  mt_WorkTypeAttach.Open;
  FixDBLValue( 9, dbl_Region );
end;

function Tfrm_OptVipolNaryad.GetRegionID: integer;
begin
  Result := mt_RegAttach.FieldByName( 'id' ).AsInteger;
end;

function Tfrm_OptVipolNaryad.GetRegionName: string;
begin
  Result := trim( mt_RegAttach.FieldByName( 'name' ).AsString );
end;

function Tfrm_OptVipolNaryad.GetWorkTypeID: integer;
begin
  Result := mt_WorkTypeAttach.FieldByName( 'id' ).AsInteger;
end;

function Tfrm_OptVipolNaryad.GetWorkTypeName: string;
begin
  Result := mt_WorkTypeAttach.FieldByName( 'name' ).AsString;
end;

function Tfrm_OptVipolNaryad.GetSortType: TRV_SortType;
begin
  Result := TRV_SortType(RBG_Sort.ItemIndex);
end;

end.
