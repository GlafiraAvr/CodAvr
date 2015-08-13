unit PeriodTimeRegDmgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin;

type
  Tfrm_PeriodTimeRegDmgSel = class(Tfrm_UniversalSearch)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    procedure btn_okClick(Sender: TObject);
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

uses StringConsts;

{ Tfrm_PeriodTimeRegDmgSel }

constructor Tfrm_PeriodTimeRegDmgSel.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodTimeRegDmgSel.OpenDataSets;
begin
// Не убирать
end;

procedure Tfrm_PeriodTimeRegDmgSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
  begin
    Application.MessageBox('Введите дату начала',gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if dp_Date2.Date=0 then dp_Date2.Date:=Date;
    inherited btn_okClick(Sender);
  end;
end;

end.
