unit PeriodCloseDmgExcSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin;

type
  Tfrm_PeriodCloseDmgExcSel = class(Tfrm_UniversalSearch)
    procedure dp_Closed1Change(Sender: TObject);
    procedure dp_Closed2Change(Sender: TObject);
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodDmgExcSel }

constructor Tfrm_PeriodCloseDmgExcSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodCloseDmgExcSel.OpenDataSets;
begin
//
end;

procedure Tfrm_PeriodCloseDmgExcSel.dp_Closed1Change(Sender: TObject);
begin
  if dp_Closed1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Closed1.Date);
end;

procedure Tfrm_PeriodCloseDmgExcSel.dp_Closed2Change(Sender: TObject);
begin
  if dp_Closed2.Date<>0 then
    F_strStartDate:=DateToStr(dp_Closed2.Date);
end;

end.
