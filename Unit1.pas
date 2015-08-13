unit Unit1;

interface

uses
  SysUtils, Classes,  GlobalVocCacheDModule, DB, kbmMemTable, IBSQL,
  IBCustomDataSet,;

type
  Tdm_prinzayv1562 = class(TDataModule)
    mt_attbrig: TkbmMemTable;
    dset_brig: TIBDataSet;
    IBSQL1: TIBSQL;
    dset_why: TIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure prin_master();
  end;


const SEL_SQL_brig:='select ns.fk_brig, ns.date_brig from  %s ns where ns.id_1562=%d';
     INSERT_SQL:='insert into %s (numsorder)'

var
  dm_prinzayv1562: Tdm_prinzayv1562;

implementation

{$R *.dfm}

procedure Tdm_prinzayv1562.DataModuleCreate(Sender: TObject);
begin
mt_attbrig.Open;
end;

procedure Tdm_prinzayv1562.prin_master();
begin
ibsql1.SQL:=isert_sql;
ibsql1.ExecQuery;

end;


end.
