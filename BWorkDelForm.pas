unit BWorkDelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BWorkChangeForm, DB, StdCtrls, Buttons, RxLookup, ExtCtrls;

type
  Tfrm_BWorkDel = class(Tfrm_BWorkChange)
    chb_work: TCheckBox;
    chb_mater: TCheckBox;
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses WorkDModule;

procedure Tfrm_BWorkDel.btn_okClick(Sender: TObject);
var
  _ChangeActOpt: TChangeActionOption;
begin
  _ChangeActOpt := [];

  if chb_work.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caDeleteWorks ];
  if chb_mater.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caDeleteMaters ];

  if Assigned( F_OnChangeActOpt ) then
    F_OnChangeActOpt( _ChangeActOpt );
  inherited;
end;

end.
