unit AvrUserMgrLoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  Tfrm_AvrUserMgrLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ed_pwd: TEdit;
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowLoginDlg(var pwd: string): boolean;

implementation

{$R *.dfm}

function ShowLoginDlg(var pwd: string): boolean;
var
  frm_Login: Tfrm_AvrUserMgrLogin;
begin
  frm_Login:=Tfrm_AvrUserMgrLogin.Create(nil);
  try
    if frm_Login.ShowModal=mrOk then
    begin
      pwd:=frm_Login.ed_pwd.Text;
      Result:=true;
    end else Result:=false;
  finally
    frm_Login.Free;
  end;
end;

end.
