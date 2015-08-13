unit MemTableFillerDM;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, DModule,  kbmMemTable;

type
  Tdm_MemTableFiller = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
  private
  public
    procedure FillMemTable(_SQL: string; _MemTable: TkbmMemTable);
  end;

implementation

{$R *.dfm}

{ Tdm_MemTableFiller }

procedure Tdm_MemTableFiller.FillMemTable(_SQL: string;
  _MemTable: TkbmMemTable);
var
  i: integer;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    dset.Close;
    dset.SelectSQL.Clear;
    dset.SelectSQL.Text := _SQL;
    dset.Open;

    //_MemTable.LoadFromDataSet( dset, [ mtcpoStructure ] );

    _MemTable.Close;
    for i := 0 to dset.FieldCount - 1 do
      if not Assigned( _MemTable.FindField( dset.Fields[i].FieldName ) ) then
        _MemTable.CreateFieldAs( dset.Fields[i] );
    _MemTable.Open;

    dset.First;
    while not dset.Eof do
    begin
      _MemTable.Append;
      for i := 0 to dset.FieldCount - 1 do
        _MemTable.FieldByName( dset.Fields[ i ].FieldName ).Value := dset.Fields[ i ].Value;
      _MemTable.Post;
      dset.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_MemTableFiller.FillMemTable)';
      raise;
    end;
  end;
end;

end.
