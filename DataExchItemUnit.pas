unit DataExchItemUnit;

interface

uses Classes, DataExchInterfacesUnit;

type

  TDataExchItem = class (TInterfacedObject, IEnumerator)
  private
    FIndex: integer;
    FList: TStringList;
    FEOF, FBOF: boolean;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function EOF: boolean;
    function BOF: boolean;
    function Add(_value: TNameValuePair): integer;
    procedure Clear;
    function GetNameValuePair(): TNameValuePair;
  end;


implementation

{ TDataExchItem }

function TDataExchItem.Add(_value: TNameValuePair): integer;
begin
  FList.Add(_value.name + '=' + _value.value);
end;

procedure TDataExchItem.Clear;
begin
  FList.Clear;
end;

function TDataExchItem.EOF: boolean;
begin
  result := FEOF;
end;

function TDataExchItem.BOF: boolean;
begin
  result := FBOF;
end;

function TDataExchItem.GetNameValuePair(): TNameValuePair;
begin
  result.name := FList.Names[FIndex];
  result.value := FList.Values[result.name];
end;

procedure TDataExchItem.First;
begin
  FIndex := 0;
end;

procedure TDataExchItem.Last;
begin
  FIndex := FList.Count - 1;
end;

procedure TDataExchItem.Next;
begin
  if (FIndex=FList.Count - 1) then
  begin
    FEOF := true;
    exit;
  end;
  FEOF := false;      
  inc(FIndex);
end;

procedure TDataExchItem.Prior;
begin
  if (FIndex=0) then
  begin
    FBOF := true;
    exit;
  end;
  FBOF := false;    
  dec(FIndex);
end;

constructor TDataExchItem.Create;
begin
  FList := TStringList.Create;
  FIndex := 0;
  FEOF := false;
  FBOF := false;
end;

destructor TDataExchItem.Destroy;
begin
  FList.Free;
  inherited;
end;

end.
