unit OptSvPoZayvkamForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDatePeriodFrame, StdCtrls, Buttons, SvPoZayvkamDModule,
  ExtCtrls, SelDateTimePeriodFrame, DateUtils, IBDatabase, DB,
  IBCustomDataSet, DBCtrls,DModule, RxLookup;

type
  Tfrm_OptSvPoZayvkam = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    cb_OrderType: TComboBox;
    Label1: TLabel;
    lbl_DateType: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    frame_SelDateTime: Tframe_SelDateTimePeriod;
    LZayv: TLabel;
    cb_zayv: TComboBox;
    Panel1: TPanel;
    dset_region: TIBDataSet;
    tran: TIBTransaction;
    ds_region: TDataSource;
    dset_regionID: TIntegerField;
    dset_regionNAME: TIBStringField;
    Label2: TLabel;
    RxDBL_region: TRxDBLookupCombo;
    rg_sort: TRadioGroup;

    procedure btn_cancelClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure cb_OrderTypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cb_zayvChange(Sender: TObject);
  private
   isOrderActiv:boolean;
    procedure ShowDateType;
    procedure SetDefoultDateTime;
    function GetRegionId:integer;
    function GetRegionName:string;
    function getSortType:integer;
  public
    function GetOrderType: TOrderType;
    function GetOrderTypeName: string;
    function GetZavtype:integer;
    function GetZavName:string;
    property ID_REg:integer read  GetRegionId;
    property  REgionName:string read GetRegionName;
    property sortType: integer read getSortType;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptSvPoZayvkam.btn_cancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptSvPoZayvkam.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_SelDateTime.IsDateTimeCorrect then
    ModalResult := mrOk;
end;

function Tfrm_OptSvPoZayvkam.GetOrderType: TOrderType;
begin
if isOrderActiv then
  case cb_OrderType.ItemIndex of
    0: Result := otAll;
    1: Result := otOpen;
    2: Result := otClose;
    else Result := otAll;
  end
  else
  Result := otAll;
end;

function Tfrm_OptSvPoZayvkam.GetOrderTypeName: string;
begin
if  isOrderActiv then
  Result := cb_OrderType.Text
else
  Result:='';

end;

procedure Tfrm_OptSvPoZayvkam.ShowDateType;
begin
  {if GetOrderType = otClose then
    lbl_DateType.Caption := 'Наряды по дате закрытия'
  else
    lbl_DateType.Caption := 'Наряды по дате открытия';}
end;

procedure Tfrm_OptSvPoZayvkam.cb_OrderTypeChange(Sender: TObject);
begin
  inherited;
  ShowDateType;
end;

procedure Tfrm_OptSvPoZayvkam.FormShow(Sender: TObject);
begin
  inherited;
  ShowDateType;
  frame_SelDateTime.de_Begin.SetFocus;
  RxDBL_region.Value:='-1';
end;

procedure Tfrm_OptSvPoZayvkam.SetDefoultDateTime;
  function _GetBeginShift: TDateTime;
  var
    _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond: Word;
  begin
    DecodeDateTime( Now, _Year, _Month, _Day, _Hour, _Minute, _Second, _MilliSecond );
    Result := EncodeDateTime( _Year, _Month, _Day, 8, 0, 0, 0 );
  end;
var
  _Now, _BeginShift: TDateTime;
begin
  _Now := MyNow;
  _BeginShift := _GetBeginShift;

  if _Now >= _BeginShift then
  begin
    frame_SelDateTime.BeginDateTime := _BeginShift;
    frame_SelDateTime.EndDateTime := _Now;
  end else
  begin
    frame_SelDateTime.BeginDateTime := _BeginShift - 1;
    frame_SelDateTime.EndDateTime := _Now;
  end;
end;

procedure Tfrm_OptSvPoZayvkam.FormCreate(Sender: TObject);
begin
  inherited;
  SetDefoultDateTime;
  isOrderActiv:=false;
  dset_region.Open;
  dset_region.First;
  dset_region.Next;
end;

procedure Tfrm_OptSvPoZayvkam.cb_zayvChange(Sender: TObject);
begin
  inherited;
if cb_zayv.ItemIndex>=2 then
begin
 Panel1.Visible:=true;
 isOrderActiv:=true;
 end
else
begin
 Panel1.Visible:=false;
 isOrderActiv:=false;
end;
end;

function Tfrm_OptSvPoZayvkam.GetZavtype:integer;
begin
 REsult:=cb_zayv.ItemIndex;
end;


function Tfrm_OptSvPoZayvkam.GetZavName:string;
begin
Result:=cb_zayv.Text;
end;


function Tfrm_OptSvPoZayvkam.GetRegionId:integer;
begin
  REsuLt:=RxDBL_region.KeyValue;
end;

function Tfrm_OptSvPoZayvkam.GetRegionName:string;
begin
 REsuLt:=RxDBL_region.Text;
end;

function Tfrm_OptSvPoZayvkam.getSortType: integer;
begin
 Result:= rg_sort.ItemIndex;
end;

end.
