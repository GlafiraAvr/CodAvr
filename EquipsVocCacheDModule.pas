unit EquipsVocCacheDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_EquipsVocCache = class(Tdm_VocCache)
    cds_Equips: TClientDataSet;
    cds_Equipsid: TIntegerField;
    cds_Equipsname_r: TStringField;
    cds_Equipsactivity: TStringField;
    procedure cds_Equipsname_rGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
  public
  end;


implementation

{$R *.dfm}

procedure Tdm_EquipsVocCache.cds_Equipsname_rGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if cds_Equips.FieldByName( 'ID' ).AsInteger = -1 then Text := ''
  else Text := Sender.AsString;
end;

end.
