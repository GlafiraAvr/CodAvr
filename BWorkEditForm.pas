unit BWorkEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BWorkChangeForm, DB, RxLookup, StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_BWorkEdit = class(Tfrm_BWorkChange)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    chb_AddNewWork: TCheckBox;
    chb_DelOldWork: TCheckBox;
    chb_AddNewMater: TCheckBox;
    chb_DelOldMater: TCheckBox;
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses WorkDModule;

procedure Tfrm_BWorkEdit.btn_okClick(Sender: TObject);
var
  _ChangeActOpt: TChangeActionOption;
begin
  _ChangeActOpt := [];

  if chb_DelOldWork.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caDeleteWorksWithOldAttach ]
  else
    _ChangeActOpt := _ChangeActOpt + [caResetWorksAttach];
  if chb_AddNewWork.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caInsertWorks ];

  if chb_DelOldMater.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caDeleteMatersWithOldAttach ]
  else
    _ChangeActOpt := _ChangeActOpt + [ caResetMatersAttach ];
  if chb_AddNewMater.Checked then
    _ChangeActOpt := _ChangeActOpt + [ caInsertMaters ];

  if Assigned( F_OnChangeActOpt ) then
    F_OnChangeActOpt( _ChangeActOpt );
  inherited;
end;

end.
