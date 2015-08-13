unit OrderNGDModule;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, DModule,
  IBSQL;

type
  Tdm_OrderNG = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    IBSQL: TIBSQL;
  private
  public
  end;

implementation

uses HelpFunctions;

{$R *.dfm}

end.
