unit FrPrintDM;

interface

uses
  SysUtils, Classes, FR_Class, FR_DSet, Printers;

type

  TDM_Print = class(TDataModule)
    RowDataset: TfrUserDataset;
    frReport1: TfrReport;
    ColDataset: TfrUserDataset;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FPrintStrings:TStrings;
  public
    { Public declarations }
    procedure ShowReport;
    property PrintStrings:TStrings read FPrintStrings write FPrintStrings;
  end;


implementation

{$R *.dfm}

procedure TDM_Print.ShowReport;
begin
  ColDataset.RangeEnd:=reCount;
  ColDataset.RangeEndCount:=1;
  RowDataset.RangeEnd:=reCount;
  RowDataset.RangeEndCount:=FPrintStrings.Count;
  frReport1.Pages[0].pgOr:=poPortrait;//poLandscape,poPortrait
  frReport1.PrepareReport;
  frReport1.ShowPreparedReport;
end;

procedure TDM_Print.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if FPrintStrings<>nil then
    begin
      if AnsiCompareText(ParName, 'Cell') = 0 then
        ParValue:=FPrintStrings[RowDataset.RecNo];
    end;        
end;

procedure TDM_Print.DataModuleCreate(Sender: TObject);
begin
  FPrintStrings:=nil;
end;

end.
