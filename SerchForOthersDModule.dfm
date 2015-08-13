inherited dm_serchforothers: Tdm_serchforothers
  Width = 382
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object frUserDataset1: TfrUserDataset
    Left = 32
    Top = 72
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 104
    Top = 16
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
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
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 128
    Top = 88
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 144
  end
end
