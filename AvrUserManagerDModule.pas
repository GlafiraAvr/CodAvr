unit AvrUserManagerDModule;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IB, IBErrorCodes, Forms, Windows,
  IBCustomDataSet;

type
  Tdm_AvrUserManager = class(TDataModule)
    IBDB: TIBDatabase;
    procedure DataModuleDestroy(Sender: TObject);
  private
    function ConnectToIB(SysDba_pwd: string): boolean;
    function GetIsConnected: boolean;
  public
    function Connect: boolean;
    procedure Disconnect;
    property IsConnected: boolean read GetIsConnected;
    procedure Execute;
  end;

implementation

{$R *.dfm}

uses ApplicationSettings, AvrUserMgrLoginForm, AvrUserManagerForm, RightsManagerDModule,
      StringConsts;

{ Tdm_AvrUserManager }

function Tdm_AvrUserManager.Connect: boolean;
var
  IsExitFromCikl: boolean;
  pwd: string;
begin
  if ShowLoginDLG(pwd) then
  begin
    repeat
      IsExitFromCikl:=ConnectToIB(pwd);
      if not IsExitFromCikl then
      begin
        Application.MessageBox('Введенный пароль не опознан. Попробуйте еще раз.',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
        IsExitFromCikl:=not(ShowLoginDLG(pwd));
      end;
    until IsExitFromCikl;
  end;

  Result:=IBDB.Connected;
end;

function Tdm_AvrUserManager.ConnectToIB(SysDba_pwd: string): boolean;
begin
  Result:=false;

  with IBDB do
  begin
    if Connected then Connected:=false;
    DatabaseName:=AppSettings.Get_MainDB_Path;
    Params.Clear;
    Params.Add('user_name=sysdba');
    Params.Add('lc_ctype=WIN1251');
    Params.Add('password='+SYSDBA_pwd);

    try
      Connected:=true;
    except
      on E: EIBInterBaseError do
      begin
        if E.IBErrorCode=isc_login then exit
        else raise Exception.Create(E.Message+'(Tdm_AvrUserManager.ConnectToIB)');
      end;
      on E: Exception do raise Exception.Create(E.Message+'(Tdm_AvrUserManager.ConnectToIB)');
    end;
  end; //end with

  Result:=true;
end;

procedure Tdm_AvrUserManager.Disconnect;
begin
  if IBDB.Connected then
    IBDB.Connected:=false;
end;

procedure Tdm_AvrUserManager.Execute;
var
  MgrFrm: Tfrm_AvrUserManager;
begin
  if Connect then
  begin
    MgrFrm:=Tfrm_AvrUserManager.Create(nil);
    try
      MgrFrm.ShowModal;
      DM_RightsManager.SetCurrentUserRights;
    finally
      MgrFrm.Free
    end;
  end;
end;

function Tdm_AvrUserManager.GetIsConnected: boolean;
begin
  Result:=IBDB.Connected;
end;

procedure Tdm_AvrUserManager.DataModuleDestroy(Sender: TObject);
begin
  Disconnect;
end;

end.
