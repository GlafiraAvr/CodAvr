unit BoltsVocCacheDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_BoltsVocCache = class(Tdm_VocCache)
    cds_Diam: TClientDataSet;
    cds_BrigClose: TClientDataSet;
    cds_BrigOpen: TClientDataSet;
    cds_Diamid: TIntegerField;
    cds_Diamname: TStringField;
    cds_Diamactivity: TStringField;
    cds_BrigCloseid: TIntegerField;
    cds_BrigClosename: TStringField;
    cds_BrigCloseactivity: TStringField;
    cds_BrigOpenid: TIntegerField;
    cds_BrigOpenname: TStringField;
    cds_BrigOpenactivity: TStringField;
  private
  public
  end;


implementation

{$R *.dfm}

end.
