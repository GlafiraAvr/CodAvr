unit SelDateTimePeriodFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, ToolEdit, ComCtrls;

type
  Tframe_SelDateTimePeriod = class(TFrame)
    de_Begin: TDateEdit;
    de_End: TDateEdit;
    tp_Begin: TDateTimePicker;
    tp_End: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
  private
    function GetBeginDateTime: TDateTime;
    procedure SetBeginDateTime(const Value: TDateTime);
    function GetEndDateTime: TDateTime;
    procedure SetEndDateTime(const Value: TDateTime);
  public
    property BeginDateTime: TDateTime read GetBeginDateTime write SetBeginDateTime;
    property EndDateTime: TDateTime read GetEndDateTime write SetEndDateTime;
    function IsDateTimeCorrect: boolean;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_SelDateTimePeriod }

function Tframe_SelDateTimePeriod.GetBeginDateTime: TDateTime;
begin
  Result := Trunc( de_Begin.Date ) + Frac( tp_Begin.Time );
end;

function Tframe_SelDateTimePeriod.GetEndDateTime: TDateTime;
begin
  Result := Trunc( de_End.Date ) + Frac( tp_End.Time );
end;

function Tframe_SelDateTimePeriod.IsDateTimeCorrect: boolean;
const
  MIN_DT = 20;
var
  _BegDT, _EndDT: TDateTime;
begin
  Result := false;

  _BegDT := GetBeginDateTime;
  if _BegDT < MIN_DT then
    Application.MessageBox( 'Дата начала периода не задана или задана неверно.',
      'Внимание', MB_OK + MB_ICONWARNING )
  else
  begin
    if GetEndDateTime < MIN_DT then de_End.Date := Date;
    _EndDT := GetEndDateTime;

    if _EndDT < MIN_DT then
      Application.MessageBox( 'Дата окончания периода не задана или задана неверно.',
        'Внимание', MB_OK + MB_ICONWARNING )
    else
    begin
      if _BegDT > _EndDT then
        Application.MessageBox( 'Дата начала периода не может быть больше даты окончания периода',
          'Внимание', MB_OK + MB_ICONWARNING )
      else
        Result := true;
    end;
  end;
end;

procedure Tframe_SelDateTimePeriod.SetBeginDateTime(
  const Value: TDateTime);
begin
  de_Begin.Date := Trunc( Value );
  tp_Begin.Time := Frac( Value );
end;

procedure Tframe_SelDateTimePeriod.SetEndDateTime(const Value: TDateTime);
begin
  de_End.Date := Trunc( Value );
  tp_End.Time := Frac( Value );
end;

end.
