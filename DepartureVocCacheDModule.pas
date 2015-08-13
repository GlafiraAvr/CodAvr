unit DepartureVocCacheDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DModule,
  DBClient;

type
  Tdm_DepartureVocCache = class(Tdm_VocCache)
    cds_Brig: TClientDataSet;
    cds_BrigID: TIntegerField;
    cds_BrigNAME: TStringField;
    cds_BrigACTIVITY: TStringField;
  private
  public
  end;

implementation

{$R *.dfm}

{ Tdm_DepartureVocCache }


end.
