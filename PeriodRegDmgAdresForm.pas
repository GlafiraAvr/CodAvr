unit PeriodRegDmgAdresForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin, ExtCtrls;

type
  Tfrm_PeriodRegDmgAdresSel = class(Tfrm_UniversalSearch)
    lbl_Adres: TLabel;
    rg_closed: TRadioGroup;
    procedure rg_closedClick(Sender: TObject);
  private
   F_typ:integer;
  public
    constructor Create(AOwner: TComponent; Title: string);
    property _typ:integer read F_typ;
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodRegDmgAdresSel }

constructor Tfrm_PeriodRegDmgAdresSel.Create(AOwner: TComponent;
  Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
  F_typ:=1;
end;

procedure Tfrm_PeriodRegDmgAdresSel.rg_closedClick(Sender: TObject);
begin
  inherited;
  F_typ:=rg_closed.ItemIndex;
end;

end.
