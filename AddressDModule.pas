unit AddressDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_Address = class(Tdm_VocCache)
    cds_HouseType: TClientDataSet;
    cds_Street1: TClientDataSet;
    cds_Street2: TClientDataSet;
    cds_HouseTypeid: TIntegerField;
    cds_HouseTypename: TStringField;
    cds_Street1id: TIntegerField;
    cds_Street1name: TStringField;
    cds_Street1activity: TIntegerField;
    cds_Street2id: TIntegerField;
    cds_Street2name: TStringField;
    cds_Street2activity: TIntegerField;
    cds_HouseTypeactivity: TIntegerField;
    procedure cds_HouseTypeidChange(Sender: TField);
  private
  public
  end;

implementation

{$R *.dfm}

procedure Tdm_Address.cds_HouseTypeidChange(Sender: TField);
begin
  inherited;
//
end;

end.
