unit OptSvodka062Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDatePeriodFrame, StdCtrls, Buttons, Svodka062DModule,
  ExtCtrls, SelDateTimePeriodFrame, DateUtils;

type
  Tfrm_OptSvodka062 = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    cb_OrderType: TComboBox;
    Label1: TLabel;
    lbl_DateType: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    frame_SelDateTime: Tframe_SelDateTimePeriod;
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure cb_OrderTypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowDateType;
    procedure SetDefoultDateTime;
  public
    function GetOrderType: TOrderType;
    function GetOrderTypeName: string;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptSvodka062.btn_cancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptSvodka062.btn_okClick(Sender: TObject);
begin
  inherited;
  if frame_SelDateTime.IsDateTimeCorrect then
    ModalResult := mrOk;
end;

function Tfrm_OptSvodka062.GetOrderType: TOrderType;
begin
  case cb_OrderType.ItemIndex of
    0: Result := otAll;
    1: Result := otOpen;
    2: Result := otClose;
    else Result := otAll;
  end;
end;

function Tfrm_OptSvodka062.GetOrderTypeName: string;
begin
  Result := cb_OrderType.Text;
end;

procedure Tfrm_OptSvodka062.ShowDateType;
begin
  if GetOrderType = otClose then
    lbl_DateType.Caption := 'Наряды по дате закрытия'
  else
    lbl_DateType.Caption := 'Наряды по дате открытия';
end;

procedure Tfrm_OptSvodka062.cb_OrderTypeChange(Sender: TObject);
begin
  inherited;
  ShowDateType;
end;

procedure Tfrm_OptSvodka062.FormShow(Sender: TObject);
begin
  inherited;
  ShowDateType;
  frame_SelDateTime.de_Begin.SetFocus;
end;

procedure Tfrm_OptSvodka062.SetDefoultDateTime;
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

procedure Tfrm_OptSvodka062.FormCreate(Sender: TObject);
begin
  inherited;
  SetDefoultDateTime;
end;

end.
