unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RxLookup, ExtCtrls, RightsManagerDModule, DB,
  AppLoginer;

type
  Tfrm_Login = class(TForm)
    btn_Exit: TBitBtn;
    ds_Users: TDataSource;
    GroupBox1: TGroupBox;
    dbl_Users: TRxDBLookupCombo;
    ed_Pwd: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn_Apply: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    GroupBox2: TGroupBox;
    ed_UserName: TEdit;
    st_Title: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_ApplyClick(Sender: TObject);
    procedure ed_PwdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_UserNameEnter(Sender: TObject);
    procedure ed_PwdEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    F_OnIsLogin: TOnIsLogin;
    F_IsShowUserList: boolean;
  public
    property OnIsLogin: TOnIsLogin read F_OnIsLogin write F_OnIsLogin;
    constructor Create(AOwner: TComponent; ATitle: string; AIsShowUserList: boolean=true);
  end;

implementation

uses  GlobalData, DModule, HelpFunctions, ApplicationSettings;

{$R *.dfm}


procedure Tfrm_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ActivateKeyboardLayout(CyrKeyboardLayot, 0);
end;

procedure Tfrm_Login.FormShow(Sender: TObject);
begin
  dbl_Users.Visible:=F_IsShowUserList;
  ed_UserName.Visible:=not F_IsShowUserList;
end;

procedure Tfrm_Login.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Login.btn_ApplyClick(Sender: TObject);
var
  IsConnect: boolean;
  LoginError: TLoginError;
begin
  if (trim(dbl_Users.Text)='') and (trim(ed_UserName.Text)='') then
  begin
    Application.MessageBox('Выберите имя пользователя!', 'Ошибка', MB_OK+MB_ICONERROR);
    exit;
  end;

  IsConnect:=false;
  if Assigned(F_OnIsLogin) then
  begin
    if F_IsShowUserList then
      F_OnIsLogin(trim(dbl_Users.Text), trim(ed_Pwd.Text), IsConnect, LoginError)
    else
      F_OnIsLogin(trim(ed_UserName.Text), trim(ed_Pwd.Text), IsConnect, LoginError);
  end;

  if IsConnect then
  begin
    ModalResult:=mrOk
  end else
  begin
    case LoginError of
      leWrongName:
        begin
          Application.MessageBox('Неправильно задано имя пользователя!', 'Ошибка', MB_OK+MB_ICONERROR);
          if F_IsShowUserList then
            dbl_Users.SetFocus
          else
            ed_UserName.SetFocus;
        end;
      leWrongPassword:
        begin
          Application.MessageBox('Неправильно задан пароль!', 'Ошибка', MB_OK+MB_ICONERROR);
          ed_Pwd.SetFocus;
        end;
    end;
  end;
end;

procedure Tfrm_Login.ed_PwdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    btn_ApplyClick(nil);
  end;
end;

constructor Tfrm_Login.Create(AOwner: TComponent; ATitle: string; AIsShowUserList: boolean=true);
begin
  inherited Create(AOwner);
  F_IsShowUserList:=AIsShowUserList;
  st_Title.Caption:=ATitle;
end;

procedure Tfrm_Login.ed_UserNameEnter(Sender: TObject);
begin
  ActivateKeyboardLayout(CyrKeyboardLayot, 0);
end;

procedure Tfrm_Login.ed_PwdEnter(Sender: TObject);
begin
  ActivateKeyboardLayout(LatKeyboardLayout, 0);
end;

procedure Tfrm_Login.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

end.
