unit WorksVocCacheDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_WorksVocCache = class(Tdm_VocCache)
    cds_Works: TClientDataSet;
    cds_Worksactivity: TStringField;
    cds_Worksid: TIntegerField;
    cds_Diam: TClientDataSet;
    cds_Diamid: TIntegerField;
    cds_Diamdiameter: TIntegerField;
    cds_Diamactivity: TStringField;
    cds_Worksname: TStringField;
    procedure cds_Worksname_rGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
  public
  end;


implementation

{$R *.dfm}

procedure Tdm_WorksVocCache.cds_Worksname_rGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if cds_Works.FieldByName( 'ID' ).AsInteger = -1 then Text := ''
  else Text := Sender.AsString;
end;

end.
