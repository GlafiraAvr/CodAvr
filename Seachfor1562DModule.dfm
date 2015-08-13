inherited dm_Seachfor1562: Tdm_Seachfor1562
  Left = 883
  Top = 655
  Height = 275
  Width = 348
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 16
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 256
    Top = 24
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetOrderNumber: TStringField
      FieldName = 'OrderNumber'
      Size = 10
    end
    object ResultDsetDateComing: TDateField
      FieldName = 'DateComing'
    end
    object ResultDsetFlowSpeed: TFloatField
      FieldName = 'FlowSpeed'
    end
    object ResultDsetRegions: TStringField
      FieldName = 'Regions'
      Size = 32
    end
    object ResultDsetDamagePlace: TStringField
      FieldName = 'DamagePlace'
      Size = 32
    end
    object ResultDsetDamageType: TStringField
      FieldName = 'DamageType'
    end
    object ResultDsetDiameter: TIntegerField
      FieldName = 'Diameter'
    end
    object ResultDsetLeak: TFloatField
      FieldName = 'Leak'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 180
    end
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetptr_add_info: TIntegerField
      FieldName = 'ptr_add_info'
    end
    object ResultDsetwhatisdone: TStringField
      FieldName = 'whatisdone'
      Size = 1000
    end
    object ResultDsetDateClosed: TDateField
      FieldName = 'DateClosed'
    end
    object ResultDsetHouseType: TIntegerField
      FieldName = 'HouseType'
    end
    object ResultDsetHouseNum: TStringField
      FieldName = 'HouseNum'
    end
    object ResultDsetStreetID: TIntegerField
      FieldName = 'StreetID'
    end
    object ResultDsetAddAddr: TStringField
      FieldName = 'AddAddr'
      Size = 32
    end
    object ResultDsetAomTypeOfAvar: TIntegerField
      FieldName = 'AomTypeOfAvar'
    end
    object ResultDsetisclosed: TIntegerField
      FieldName = 'isclosed'
    end
    object ResultDsetsDateClosed: TStringField
      FieldName = 'sDateClosed'
    end
    object ResultDsetMessageTypes: TStringField
      FieldName = 'MessageTypes'
      Size = 32
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 120
  end
  object dset_number: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 184
  end
  object result1562: TRxMemoryData
    FieldDefs = <>
    Left = 248
    Top = 184
  end
end
