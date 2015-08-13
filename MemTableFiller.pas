unit MemTableFiller;

interface

uses MemTableFillerDM, kbmMemTable;

type
  TMemTableFiller=class
  private
    F_DM: Tdm_MemTableFiller;
    F_ResMemTable: TkbmMemTable;
  public
    property ResMemTable: TkbmMemTable read F_ResMemTable write F_ResMemTable;
    procedure FillResMemTable( _SQL: string );
    constructor Create;
    destructor Destroy; override;
  end;


implementation


{ TMemTableFiller }

constructor TMemTableFiller.Create;
begin
  inherited Create;
  F_DM := Tdm_MemTableFiller.Create( nil );
end;

destructor TMemTableFiller.Destroy;
begin
  F_DM.Free;
  inherited Destroy;
end;

procedure TMemTableFiller.FillResMemTable(_SQL: string);
begin
  F_DM.FillMemTable( _SQL, F_ResMemTable );
end;

end.
