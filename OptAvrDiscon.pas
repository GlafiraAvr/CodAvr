unit OptAvrDiscon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons;

type
  Tfrm_OptAvrDiscon = class(Tfrm_BaseOption)
    cb_typ: TCheckBox;
    Btn_Ok: TBitBtn;
    btn_Cancel: TBitBtn;
  private
    { Private declarations }
    function readTyp:boolean;
  public
    { Public declarations }
    property typ:boolean read readTyp;
  end;


var frm_OptAvrDiscon:Tfrm_OptAvrDiscon ;

implementation

{$R *.dfm}
function Tfrm_OptAvrDiscon.readTyp:boolean;
begin
  result:=cb_typ.Checked;
end;

end.
