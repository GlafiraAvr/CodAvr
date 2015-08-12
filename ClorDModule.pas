unit ClorDModule;

interface

uses
  SysUtils, Classes, DB, IBDatabase, Forms, Windows, IBCustomDataSet;

type
  Tdm_Clor = class(TDataModule)
    IBDB_Clor: TIBDatabase;
    tran: TIBTransaction;
    dset: TIBDataSet;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function ConnectToClorBase: boolean;
  end;


implementation

{$R *.dfm}

uses ApplicationSettings, StringConsts;



{ Tdm_Clor }

function Tdm_Clor.ConnectToClorBase: boolean;
const
  USER_NAME = 'CLOR';
  PASSWORD = 'roma';
begin
  Result := true;
  try
    with IBDB_Clor do
    begin
      DatabaseName := AppSettings.Get_ClorDB_Path;
      Params.Add( 'user_name=' + trim( USER_NAME ) );
      Params.Add( 'password=' + trim( PASSWORD ) );
      Params.Add( 'lc_ctype=WIN1251' );
      Connected := true;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox( PChar( E.Message + '(Tdm_Clor.ConnectToClorBase)' ),
                    gc_strDispAVR, MB_OK + MB_ICONERROR);
      Result := false;
    end;
  end;
end;

procedure Tdm_Clor.DataModuleDestroy(Sender: TObject);
begin
  if IBDB_Clor.Connected then
    IBDB_Clor.Connected := false;

end;

end.
