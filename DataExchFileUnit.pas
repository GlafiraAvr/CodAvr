unit DataExchFileUnit;

interface

uses DataExchInterfacesUnit, DataExchItemUnit, SimpleXML, SysUtils;

type

  TDataExchAccessFile = class (TInterfacedObject)
  protected
    FFileName: string;
    function FileNameGenerator(): string;
  end;

  TDataExchAccess_XML = class(TDataExchAccessFile, IDataAccess)
  private
  protected
  public
    procedure Write(_data: IEnumerator; _elemName:string ='');
    function Read(): IEnumerator;
    procedure SetFileName(_filename: string);
  end;

implementation

{ TDataExchAccessFile }

function TDataExchAccessFile.FileNameGenerator(): string;
begin
  result := 'dt_' + DateToStr(Date);
end;

{ TDataExchAccess_XML }

procedure TDataExchAccess_XML.SetFileName(_filename: string);
begin
  FFileName := _filename;
end;

procedure TDataExchAccess_XML.Write(_data: IEnumerator; _elemName:string ='');
var
  aDoc: IXmlDocument;
  anElem: IXmlNode;
  _dt: string;
begin
  aDoc := CreateXmlDocument('xml');
  if FileExists(FFileName) then aDoc.Load(FFileName);
  {так как нужна информаци€ за день, всегда сама€ последн€€}
  if _elemName='' then _dt := FileNameGenerator() else _dt := _elemName;  
  anElem := aDoc.DocumentElement.SelectSingleNode(_dt);
  if not Assigned(anElem)
  then anElem := aDoc.DocumentElement.AppendElement(_dt);
  try
  _data.First;
  while not _data.EOF do
  begin
    anElem.SetAttr(_data.GetNameValuePair().name, _data.GetNameValuePair().value);
    _data.Next;
  end;
  finally
    aDoc.Save(FFileName);
  end;
end;

function TDataExchAccess_XML.Read(): IEnumerator;
begin
//
end;

end.
