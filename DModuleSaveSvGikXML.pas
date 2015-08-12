unit DModuleSaveSvGikXML;

interface

uses
  SysUtils, Classes, IBSQL, DB, IBCustomDataSet, IBDatabase;

type
  Tdm_saveSVGikXML = class(TDataModule)
    IBTransaction1: TIBTransaction;
    IBDataSet1: TIBDataSet;
    IBSQL1: TIBSQL;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_saveSVGikXML: Tdm_saveSVGikXML;

implementation

{$R *.dfm}

end.
