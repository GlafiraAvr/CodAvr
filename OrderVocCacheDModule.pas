unit OrderVocCacheDModule;
{
  ƒанный модуль представл€ет кеши наборов данных справочников.
  ѕрикол в том что создаетс€ кеш справочника. ѕри этом в отличии
  от других дадасетов TClientDataSet позвол€ет не держать активной
  транзакции (согласно моему новому убеждению все
  транзакции должны быть максимально короткими). ѕри этом кеш заполн€тс€
  один раз дл€ рабочего потока, что уменьшает количество обращений к Ѕƒ,
  а значит положительно сказываетс€ на производительности.
  —ам по себе модуль не используетс€ а вызываетс€ из OrderManager
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocCacheDModule, IBDatabase, DB, IBCustomDataSet, DBClient;

type
  Tdm_OrderVocCache = class(Tdm_VocCache)
    cds_OfficialOpen: TClientDataSet;
    ds_OfficialOpen: TDataSource;
    cds_OfficialOpenID: TIntegerField;
    cds_OfficialOpenNAME: TStringField;
    cds_OfficialOpenACTIVITY: TStringField;
    cds_Region: TClientDataSet;
    ds_Region: TDataSource;
    cds_RegionID: TIntegerField;
    cds_RegionNAME: TStringField;
    cds_RegionACTIVITY: TStringField;
    cds_Street1: TClientDataSet;
    ds_Street1: TDataSource;
    cds_Street1ID: TIntegerField;
    cds_Street1NAME: TStringField;
    cds_Street1ACTIVITY: TSmallintField;
    cds_Street2: TClientDataSet;
    cds_Street2ID: TIntegerField;
    cds_Street2NAME: TStringField;
    cds_Street2ACTIVITY: TSmallintField;
    ds_Street2: TDataSource;
    cds_HouseType: TClientDataSet;
    cds_HouseTypeID: TIntegerField;
    cds_HouseTypeNAME: TStringField;
    cds_HouseTypeACTIVITY: TSmallintField;
    ds_HouseType: TDataSource;
    cds_MessageType: TClientDataSet;
    ds_MessageType: TDataSource;
    cds_MessageTypeID: TIntegerField;
    cds_MessageTypeNAME: TStringField;
    cds_MessageTypeACTIVITY: TStringField;
    cds_DamageLocality: TClientDataSet;
    ds_DamageLocality: TDataSource;
    cds_DamageLocalityID: TIntegerField;
    cds_DamageLocalityNAME: TStringField;
    cds_DamageLocalityACTIVITY: TStringField;
    cds_DamagePlace: TClientDataSet;
    cds_DamagePlaceID: TIntegerField;
    cds_DamagePlaceNAME: TStringField;
    cds_DamagePlaceACTIVITY: TStringField;
    ds_DamagePlace: TDataSource;
    cds_ControlOrg: TClientDataSet;
    cds_ControlOrgID: TIntegerField;
    cds_ControlOrgNAME: TStringField;
    cds_ControlOrgACTIVITY: TStringField;
    ds_ControlOrg: TDataSource;
    cds_OfficialClose: TClientDataSet;
    ds_OfficialClose: TDataSource;
    cds_OfficialCloseID: TIntegerField;
    cds_OfficialCloseNAME: TStringField;
    cds_OfficialCloseACTIVITY: TStringField;
    cds_TubeDiameter: TClientDataSet;
    ds_TubeDiameter: TDataSource;
    cds_TubeDiameterID: TIntegerField;
    cds_TubeDiameterNAME: TStringField;
    cds_TubeDiameterACTIVITY: TStringField;
    cds_Soil: TClientDataSet;
    cds_SoilID: TIntegerField;
    cds_SoilNAME: TStringField;
    cds_SoilACTIVITY: TStringField;
    ds_Soil: TDataSource;
    cds_TubeMaterial: TClientDataSet;
    cds_TubeMaterialID: TIntegerField;
    cds_TubeMaterialNAME: TStringField;
    cds_TubeMaterialACTIVITY: TStringField;
    ds_TubeMaterial: TDataSource;
    cds_DamageType: TClientDataSet;
    ds_DamageType: TDataSource;
    cds_DamageTypeID: TIntegerField;
    cds_DamageTypeNAME: TStringField;
    cds_DamageTypeACTIVITY: TStringField;
  private
  public
  end;

implementation

{$R *.dfm}

end.
