unit DateSelCBForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateSelForm, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_DateSelCB = class(Tfrm_DateSel)
    CB: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_DateSelCB: Tfrm_DateSelCB;

implementation

{$R *.dfm}

end.
