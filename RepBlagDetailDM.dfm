inherited dm_RepBlagDetail: Tdm_RepBlagDetail
  Width = 295
  inherited frReport: TfrReport
    ReportForm = {19000000}
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
    Left = 112
    Top = 16
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetbit_mask: TIntegerField
      FieldName = 'bit_mask'
    end
    object ResultDsetraskop_dt: TDateTimeField
      FieldName = 'raskop_dt'
    end
    object ResultDsetordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object ResultDsetdatecoming: TDateTimeField
      FieldName = 'datecoming'
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 32
    end
    object ResultDsetdamageplace: TStringField
      FieldName = 'damageplace'
      Size = 32
    end
    object ResultDsetdamagelocality: TStringField
      FieldName = 'damagelocality'
      Size = 64
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 190
    end
    object ResultDsetmain_gr: TIntegerField
      FieldName = 'main_gr'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 208
    Top = 8
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 208
    Top = 72
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 88
  end
end
