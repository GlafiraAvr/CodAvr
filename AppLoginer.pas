unit AppLoginer;

interface

type
  TLoginError=(leNone, leWrongName, leWrongPassword);

  TOnIsLogin=procedure(UserName, Password: string; var IsConnect: boolean; var LoginError: TLoginError) of object;

  TBaseLoginer=class
  protected
    function Connect(UserName, Password: string; var LoginError: TLoginError): boolean;
    function Execute: boolean; virtual; abstract;
  public
    function Login: boolean;
  end;

  TFormLoginer=class(TBaseLoginer)
  private
    procedure F_OnIsLogin(UserName, Password: string; var IsConnect: boolean; var LoginError: TLoginError);
    function Execute: boolean; override;
  end;

  TCommandStrLoginer=class(TBaseLoginer)
  private
    function Execute: boolean; override;
  end;

implementation

uses LoginForm, DModule, RightsManagerDModule, Controls, ApplicationSettings;

{ TFormLoginer }

function TFormLoginer.Execute: boolean;
var
  frm: Tfrm_Login;
  Title: string;
begin
  DM_RightsManager.FillUsers(futByHost);

  if DM_RightsManager.IsCurrentHostDispHost then
    Title:='АРМ "Диспетчер АВР"'
  else
    Title:='Анализ АВР';

  frm:=Tfrm_Login.Create(nil, Title, AppSettings.IsShowLoginUserList);
  try
    frm.OnIsLogin:=F_OnIsLogin;
    if frm.ShowModal=mrOk then
      Result:=true
    else
      Result:=false;
  finally
    frm.Free;
  end;
end;

procedure TFormLoginer.F_OnIsLogin(UserName, Password: string;
  var IsConnect: boolean; var LoginError: TLoginError);
begin
  IsConnect:=Connect(UserName, Password, LoginError);
end;

{ TBaseLoginer }

function TBaseLoginer.Connect(UserName, Password: string; var LoginError: TLoginError): boolean;
var
  IBUserName, IBUserPwd: string;
begin
  Result:=false;
  LoginError:=leNone;

  if DM_RightsManager.LocateUser(UserName, IBUserName, IBUserPwd) then
  begin
    if Password=IBUserPwd then
    begin
      {Не удалять}
      //DM_Main.Disconnect;
      //if DM_Main.Connect('avr_ib', 'avr_ib_pwd') then
      //if DM_Connect(IBUserName, Password) then    //так будет работать в будещем
      begin
        DM_RightsManager.SetCurrentUser(IBUserName);
        DM_RightsManager.SetCurrentUserRights;
        Result:=true;
      end;
      {/Не удалять}
    end else LoginError:=leWrongPassword;
  end else LoginError:=leWrongName;
end;

function TBaseLoginer.Login: boolean;
begin
//  DM_RightsManager.FillUsers(futByHost);
  Result:=Execute;
  DM_RightsManager.ClearUsers;
end;

{ TCommandStrLoginer }

function TCommandStrLoginer.Execute: boolean;
var
  user_name, user_pwd: string;
  login_err: TLoginError;
begin
  if (ParamStr(1)='\user') and (ParamStr(3)='\password') then
  begin
    DM_RightsManager.FillUsers(futAll);
    user_name:=ParamStr(2);
    user_pwd:=ParamStr(4);
    Result:=Connect(user_name, user_pwd, login_err);
  end else Result:=false;
end;

end.
