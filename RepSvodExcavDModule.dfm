inherited dm_RepSvodExcav: Tdm_RepSvodExcav
  Left = 405
  Top = 253
  Height = 322
  Width = 405
  inherited frReport: TfrReport
    Dataset = frDset
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 144
    Top = 24
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 24
    Top = 104
    object ResultDsetID: TIntegerField
      FieldName = 'ID'
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object ResultDsetDateClosed: TDateTimeField
      FieldName = 'DateClosed'
    end
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetid_damageplace: TIntegerField
      FieldName = 'id_damageplace'
    end
    object ResultDsetRegion: TStringField
      FieldName = 'Region'
      Size = 50
    end
    object ResultDsetDamageplace: TStringField
      FieldName = 'Damageplace'
    end
    object ResultDsetDamagelocality: TStringField
      FieldName = 'Damagelocality'
      Size = 50
    end
    object ResultDsetTubematerial: TStringField
      FieldName = 'Tubematerial'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 190
    end
    object ResultDsetExcDate: TDateTimeField
      FieldName = 'ExcDate'
    end
    object ResultDsetAdditionalInfo: TStringField
      FieldName = 'AdditionalInfo'
      Size = 200
    end
    object ResultDsetExcWt: TStringField
      FieldName = 'ExcWt'
      Size = 30
    end
    object ResultDsetMainGr: TIntegerField
      FieldName = 'MainGr'
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 288
    Top = 48
  end
  object frDset: TfrDBDataSet
    DataSet = ResultDset
    Left = 24
    Top = 184
  end
end
