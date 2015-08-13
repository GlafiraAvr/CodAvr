unit OptBlagItogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, StdCtrls, Buttons, SelDatePeriodFrame,
  Mask, ToolEdit;

type
  Tfrm_OptBlagItog = class(Tfrm_BaseOption)
    frame_SelDates: Tframe_SelDatePeriod;
    btn_on: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    Label2: TLabel;
    de_StartDate: TDateEdit;
    Bevel3: TBevel;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_onClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetStartDate: TDateTime;
  public
    property StartDate: TDateTime read GetStartDate;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptBlagItog.btn_exitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptBlagItog.btn_onClick(Sender: TObject);
begin
  inherited;
  if not IsDateCorrect( de_StartDate.Text ) then
    Application.MessageBox( 'Поле "Учитывать заявки дата поступления которых больше чем" не задано или задано неверно',
      'Внимание', MB_OK + MB_ICONWARNING )
  else
    if frame_SelDates.IsDatesCorrect then
      ModalResult := mrOk;
end;

procedure Tfrm_OptBlagItog.FormCreate(Sender: TObject);
var
  _Year, _Month, _Day: word;
begin
  inherited;
  DecodeDate( Date, _Year, _Month, _Day );
  de_StartDate.Date := Date - 7;
  frame_SelDates.BeginDate := EncodeDate( _Year, _Month, 1 );
  frame_SelDates.EndDate := Date;
end;

function Tfrm_OptBlagItog.GetStartDate: TDateTime;
begin
  Result := de_StartDate.Date;
end;

end.
