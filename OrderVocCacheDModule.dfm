inherited dm_OrderVocCache: Tdm_OrderVocCache
  OldCreateOrder = True
  Left = 488
  Top = 186
  Height = 552
  Width = 681
  inherited dset: TIBDataSet
    Left = 8
    Top = 16
  end
  inherited tran: TIBTransaction
    Left = 8
    Top = 64
  end
  object cds_OfficialOpen: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_Officials order by name'
    Params = <>
    Left = 144
    Top = 16
    object cds_OfficialOpenID: TIntegerField
      FieldName = 'ID'
    end
    object cds_OfficialOpenNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_OfficialOpenACTIVITY: TStringField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_OfficialOpen: TDataSource
    DataSet = cds_OfficialOpen
    Left = 144
    Top = 64
  end
  object cds_Region: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_regions order by name'
    Params = <>
    Left = 264
    Top = 16
    object cds_RegionID: TIntegerField
      FieldName = 'ID'
    end
    object cds_RegionNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_RegionACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 0
    end
  end
  object ds_Region: TDataSource
    DataSet = cds_Region
    Left = 264
    Top = 64
  end
  object cds_Street1: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select s.id, (select name from Get_FullStreetName(s.id)) as name' +
      ', s.activity from s_streets s order by name'
    Params = <>
    Left = 360
    Top = 16
    object cds_Street1ID: TIntegerField
      FieldName = 'ID'
    end
    object cds_Street1NAME: TStringField
      FieldName = 'NAME'
    end
    object cds_Street1ACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_Street1: TDataSource
    DataSet = cds_Street1
    Left = 360
    Top = 64
  end
  object cds_Street2: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select s.id, (select name from Get_FullStreetName(s.id)) as name' +
      ', s.activity from s_streets s order by name'
    Params = <>
    Left = 456
    Top = 16
    object cds_Street2ID: TIntegerField
      FieldName = 'ID'
    end
    object cds_Street2NAME: TStringField
      FieldName = 'NAME'
    end
    object cds_Street2ACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_Street2: TDataSource
    DataSet = cds_Street2
    Left = 456
    Top = 64
  end
  object cds_HouseType: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_housetype order by id'
    Params = <>
    Left = 544
    Top = 16
    object cds_HouseTypeID: TIntegerField
      FieldName = 'ID'
    end
    object cds_HouseTypeNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_HouseTypeACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_HouseType: TDataSource
    DataSet = cds_HouseType
    Left = 544
    Top = 64
  end
  object cds_MessageType: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, messagename name, activity from s_messagetypes order ' +
      ' by messagename'
    Params = <>
    Left = 144
    Top = 144
    object cds_MessageTypeID: TIntegerField
      FieldName = 'ID'
    end
    object cds_MessageTypeNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_MessageTypeACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 2
    end
  end
  object ds_MessageType: TDataSource
    DataSet = cds_MessageType
    Left = 144
    Top = 192
  end
  object cds_DamageLocality: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_damagelocality order by name'
    Params = <>
    Left = 264
    Top = 144
    object cds_DamageLocalityID: TIntegerField
      FieldName = 'ID'
    end
    object cds_DamageLocalityNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_DamageLocalityACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 2
    end
  end
  object ds_DamageLocality: TDataSource
    DataSet = cds_DamageLocality
    Left = 264
    Top = 192
  end
  object cds_DamagePlace: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_damageplace order by name'
    Params = <>
    Left = 384
    Top = 145
    object cds_DamagePlaceID: TIntegerField
      FieldName = 'ID'
    end
    object cds_DamagePlaceNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_DamagePlaceACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 2
    end
  end
  object ds_DamagePlace: TDataSource
    DataSet = cds_DamagePlace
    Left = 384
    Top = 192
  end
  object cds_ControlOrg: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_organisations order by name'
    Params = <>
    Left = 488
    Top = 144
    object cds_ControlOrgID: TIntegerField
      FieldName = 'ID'
    end
    object cds_ControlOrgNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_ControlOrgACTIVITY: TStringField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_ControlOrg: TDataSource
    DataSet = cds_ControlOrg
    Left = 488
    Top = 192
  end
  object cds_OfficialClose: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_Officials order by name'
    Params = <>
    Left = 144
    Top = 272
    object cds_OfficialCloseID: TIntegerField
      FieldName = 'ID'
    end
    object cds_OfficialCloseNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_OfficialCloseACTIVITY: TStringField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_OfficialClose: TDataSource
    DataSet = cds_OfficialClose
    Left = 144
    Top = 320
  end
  object cds_TubeDiameter: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select sd.id, (select strval from tochar(sd.diameter)) as name, ' +
      'sd.activity from s_tubediameter sd order by sd.diameter'
    Params = <>
    Left = 256
    Top = 272
    object cds_TubeDiameterID: TIntegerField
      FieldName = 'ID'
    end
    object cds_TubeDiameterNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_TubeDiameterACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 1
    end
  end
  object ds_TubeDiameter: TDataSource
    DataSet = cds_TubeDiameter
    Left = 256
    Top = 320
  end
  object cds_Soil: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_soil order by name'
    Params = <>
    Left = 336
    Top = 272
    object cds_SoilID: TIntegerField
      FieldName = 'ID'
    end
    object cds_SoilNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_SoilACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 1
    end
  end
  object ds_Soil: TDataSource
    DataSet = cds_Soil
    Left = 336
    Top = 320
  end
  object cds_TubeMaterial: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_tubematerial order by name'
    Params = <>
    Left = 432
    Top = 272
    object cds_TubeMaterialID: TIntegerField
      FieldName = 'ID'
    end
    object cds_TubeMaterialNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_TubeMaterialACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 1
    end
  end
  object ds_TubeMaterial: TDataSource
    DataSet = cds_TubeMaterial
    Left = 432
    Top = 322
  end
  object cds_DamageType: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_damagetype order by name'
    Params = <>
    Left = 536
    Top = 272
    object cds_DamageTypeID: TIntegerField
      FieldName = 'ID'
    end
    object cds_DamageTypeNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_DamageTypeACTIVITY: TStringField
      FieldName = 'ACTIVITY'
    end
  end
  object ds_DamageType: TDataSource
    DataSet = cds_DamageType
    Left = 536
    Top = 320
  end
end
