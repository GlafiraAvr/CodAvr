unit StDispDModule;

interface

uses
  SysUtils, Classes, DB, IBDatabase, Forms, Windows, IBCustomDataSet;

type
  TDM_StDisp = class(TDataModule)
    IBDB_StDisp: TIBDatabase;
    tran: TIBTransaction;
    dset: TIBDataSet;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function ConnectToStDispBase(const UserName, Password: string): boolean;
  end;


implementation

{$R *.dfm}

uses ApplicationSettings, StringConsts;

{ TDM_StDisp }

function TDM_StDisp.ConnectToStDispBase(const UserName,
  Password: string): boolean;
begin
  Result:=true;
  try
    with IBDB_StDisp do
    begin
      DatabaseName:=AppSettings.Get_StDispDB_Path;
      Params.Clear;
      Params.Add('user_name='+trim(UserName));
      Params.Add('password='+trim(Password));
      Params.Add('lc_ctype=WIN1251');
      Connected:=true;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message+'(TDM_StDisp.ConnectToStDispBase)'),
                    gc_strDispAVR, MB_OK+MB_ICONERROR);
      Result:=false;
    end;
  end;

end;

procedure TDM_StDisp.DataModuleDestroy(Sender: TObject);
begin
  if IBDB_StDisp.Connected then
    IBDB_StDisp.Connected:=false;
end;

end.
