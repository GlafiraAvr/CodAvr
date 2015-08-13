unit SelDatePeriodFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, ToolEdit;

type
  Tframe_SelDatePeriod = class(TFrame)
    Label1: TLabel;
    de_Begin: TDateEdit;
    Label2: TLabel;
    de_End: TDateEdit;
  private
    function GetBeginDate: TDateTime;
    procedure SetBeginDate(const Value: TDateTime);
    function GetEndDate: TDateTime;
    procedure SetEndDate(const Value: TDateTime);
  public
    property BeginDate: TDateTime read GetBeginDate write SetBeginDate;
    property EndDate: TDateTime read GetEndDate write SetEndDate;
    function IsDatesCorrect: boolean;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_SelDatePeriod }

function Tframe_SelDatePeriod.GetBeginDate: TDateTime;
begin
  Result := de_Begin.Date;
end;

function Tframe_SelDatePeriod.GetEndDate: TDateTime;
begin
  Result := de_End.Date;
end;

function Tframe_SelDatePeriod.IsDatesCorrect: boolean;
begin
  Result := false;
 
  if not IsDateCorrect( de_Begin.Text ) then
    Application.MessageBox( 'Дата начала периода не задана или задана неверно.',
      'Внимание', MB_OK + MB_ICONWARNING )
  else
  begin
    if de_End.Date = 0 then de_End.Date := Date;
    if not IsDateCorrect( de_End.Text ) then
      Application.MessageBox( 'Дата окончания периода не задана или задана неверно.',
        'Внимание', MB_OK + MB_ICONWARNING )
    else
    begin
      if de_Begin.Date > de_End.Date then
        Application.MessageBox( 'Дата начала периода не может быть больше даты окончания периода',
          'Внимание', MB_OK + MB_ICONWARNING )
      else
        Result := true;
    end;
  end;
end;

procedure Tframe_SelDatePeriod.SetBeginDate(const Value: TDateTime);
begin
  de_Begin.Date := Value;
end;

procedure Tframe_SelDatePeriod.SetEndDate(const Value: TDateTime);
begin
  de_End.Date := Value;
end;

end.
