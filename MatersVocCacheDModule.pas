unit MatersVocCacheDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_MatersVocCache = class(Tdm_VocCache)
    cds_Diam: TClientDataSet;
    cds_Diamid: TIntegerField;
    cds_Diamdiameter: TIntegerField;
    cds_Diamactivity: TStringField;
    cds_Maters: TClientDataSet;
    cds_Matersid: TIntegerField;
    cds_Matersname_r: TStringField;
    cds_Matersactivity: TStringField;
    procedure cds_Matersname_rGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
  public
  end;

implementation

{$R *.dfm}

procedure Tdm_MatersVocCache.cds_Matersname_rGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if cds_Maters.FieldByName( 'ID' ).AsInteger = -1 then Text := ''
  else Text := Sender.AsString;
end;

end.
