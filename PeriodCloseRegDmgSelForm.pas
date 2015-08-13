unit PeriodCloseRegDmgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin;

type
  Tfrm_PeriodCloseRegDmgSel = class(Tfrm_UniversalSearch)
    procedure btn_okClick(Sender: TObject);
  private
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodCloseRegDmgSel }

constructor Tfrm_PeriodCloseRegDmgSel.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodCloseRegDmgSel.OpenDataSets;
begin
//
end;

procedure Tfrm_PeriodCloseRegDmgSel.btn_okClick(Sender: TObject);
begin
  inherited;

  if dp_Closed1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Closed1.Date);

  if dp_Closed2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Closed2.Date);
end;

end.
