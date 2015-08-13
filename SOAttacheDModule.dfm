object dm_SOAttacher: Tdm_SOAttacher
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 229
  Top = 210
  Height = 318
  Width = 306
  object mt_OrderCache: TkbmMemTable
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
    Left = 40
    Top = 16
    object mt_OrderCacheid: TIntegerField
      FieldName = 'id'
    end
    object mt_OrderCacheOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object mt_OrderCacheDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object mt_OrderCacheDateClosed: TDateTimeField
      FieldName = 'DateClosed'
    end
    object mt_OrderCacheAdres: TStringField
      FieldName = 'Adres'
      Size = 190
    end
    object mt_OrderCacheregion: TStringField
      FieldName = 'region'
    end
    object mt_OrderCacheDmgPlace: TStringField
      FieldName = 'DmgPlace'
    end
  end
  object tr_Search: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 192
    Top = 24
  end
  object dset_Search: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Search
    Left = 200
    Top = 96
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_tmp
    Left = 40
    Top = 96
  end
  object tr_tmp: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 40
    Top = 160
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tr_Exec
    Left = 208
    Top = 184
  end
  object tr_Exec: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 216
  end
end
