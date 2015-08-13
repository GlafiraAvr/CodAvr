unit NGReportBaseDModule;

interface

uses
  SysUtils, Classes, FR_Class, DB, RootReportDModule;

const
  PROG_LENGTH=1000;


type
  TOnChangeProgressStatusEvent=procedure(ProgLength, ProgPos: integer) of object;

  Tdm_NGReportBase = class(Tdm_RootReport)
    frReport: TfrReport;
    procedure DataModuleDestroy(Sender: TObject);
  protected
    F_ProgressPos: integer;
    F_OnChangeProgressStatus: TOnChangeProgressStatusEvent;
    F_IsStopProgress: boolean;
    function GetProgressShagLength(percent, shag_count: integer): integer;
    procedure IncProgressStatus(IncValue: integer);
  public
    procedure ResetProgressFields;
    property OnChangeProgressStatus: TOnChangeProgressStatusEvent read F_OnChangeProgressStatus
                      write F_OnChangeProgressStatus;
    property IsStopProgress: boolean read F_IsStopProgress write F_IsStopProgress;
  end;


implementation

{$R *.dfm}

{ Tdm_NGReportBase }

function Tdm_NGReportBase.GetProgressShagLength(percent,
  shag_count: integer): integer;
begin
  if shag_count=0 then
    Result:=0
  else
    Result:=Round(((PROG_LENGTH/100)*percent)/shag_count);
end;

procedure Tdm_NGReportBase.IncProgressStatus(IncValue: integer);
begin
  F_ProgressPos:=F_ProgressPos+IncValue;
  if Assigned(F_OnChangeProgressStatus) then
    F_OnChangeProgressStatus(PROG_LENGTH, F_ProgressPos);
end;

procedure Tdm_NGReportBase.ResetProgressFields;
begin
  F_ProgressPos:=0;
  F_IsStopProgress:=false;
end;

procedure Tdm_NGReportBase.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  inherited;
  for i:=0 to ComponentCount-1 do
    if (Components[i] is TDataSet) and ((Components[i] as TDataSet).Active) then
      (Components[i] as TDataSet).Close;
  
end;

end.
