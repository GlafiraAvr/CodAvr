unit PeriodRegDmgDiamSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin, RXSpin;

type
  Tfrm_PeriodRegDmgDiamSel = class(Tfrm_UniversalSearch)
    cb_SortType: TComboBox;
    sp_DamageCount: TRxSpinEdit;
  protected
    procedure OpenDataSets; virtual;
  public
    constructor Create(AOwner: TComponent; Title: string='');
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodRegDmgDiamSel }

constructor Tfrm_PeriodRegDmgDiamSel.Create(AOwner: TComponent;
  Title: string='');
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodRegDmgDiamSel.OpenDataSets;
begin
  //
end;

end.
