unit UniDataExchUnit;

interface

uses Classes, DataExchFileUnit, DataExchInterfacesUnit, DataExchItemUnit;

type

  TUniDataExch = class (TDataExchAccess_XML)
  private
    FBuf: IEnumerator;
  public
    constructor Create;
    destructor Destroy; override;
    //
    property Buf: IEnumerator read FBuf;
  end;

implementation

{TUniDataExch}

constructor TUniDataExch.Create;
begin
  inherited;
  FBuf := TDataExchItem.Create;
end;

destructor TUniDataExch.Destroy;
begin
  inherited;
end;

end.
