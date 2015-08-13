unit SetPwdForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, AvrUserManagerDModule, IBDatabase,
  IBSQL;

type
  Tfrm_SetPwd = class(TForm)
    ed_Pwd: TEdit;
    ed_ConfPwd: TEdit;
    btn_Apply: TBitBtn;
    btn_Cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    tran_Exec: TIBTransaction;
    IBSQL: TIBSQL;
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ApplyClick(Sender: TObject);
  private
    F_UserID: integer;
  public
    property UserID: integer read F_UserID write F_UserID;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_SetPwd.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SetPwd.btn_ApplyClick(Sender: TObject);
begin
  if trim(ed_Pwd.Text)<>trim(ed_ConfPwd.Text) then
  begin
    Application.MessageBox('¬веденные пароли не совпадают', 'ќшибка', MB_OK+MB_ICONERROR);
    exit;
  end;

  if tran_exec.InTransaction then
    tran_exec.Rollback;
  tran_exec.StartTransaction;
  try
    MyExecIBSQL(IBSQL, Format(
      'update sec_users set ib_pwd=%s where id=%d',
      [QuotedStr(trim(ed_pwd.Text)), F_UserID]));

    tran_exec.Commit;
  except
    on E: Exception do
    begin
      tran_exec.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_SetPwd.btn_ApplyClick)');
    end;
  end;

  ModalResult:=mrOk;
end;

end.
