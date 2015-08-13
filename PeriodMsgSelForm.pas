unit PeriodMsgSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin;

type
  Tfrm_PeriodMsgSel = class(Tfrm_UniversalSearch)
  private
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string);
  end;


implementation

{$R *.dfm}

{ Tfrm_PeriodMsgSel }

constructor Tfrm_PeriodMsgSel.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_PeriodMsgSel.OpenDataSets;
begin
  //
end;

end.
