unit BWorkInsertForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BWorkChangeForm, DB, RxLookup, StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_BWorkInsert = class(Tfrm_BWorkChange)
    chb_work: TCheckBox;
    chb_mater: TCheckBox;
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;


implementation

{$R *.dfm}

uses WorkDModule;

procedure Tfrm_BWorkInsert.btn_okClick(Sender: TObject);
var
  _ChangeActOpt: TChangeActionOption;
begin
  _ChangeActOpt := [];

  if chb_work.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caInsertWorks ];
  if chb_mater.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caInsertMaters ];

  if Assigned( F_OnChangeActOpt ) then
    F_OnChangeActOpt( _ChangeActOpt );
  inherited;
end;

end.
