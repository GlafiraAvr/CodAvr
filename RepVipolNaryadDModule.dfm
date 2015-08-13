inherited dm_RepVipolNaryad: Tdm_RepVipolNaryad
  Left = 412
  Top = 302
  inherited frReport: TfrReport
    OnBeginPage = frReportBeginPage
    OnBeforePrint = frReportBeforePrint
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 104
    Top = 16
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
    Left = 184
    Top = 160
    object ResultDsetrow_num: TIntegerField
      FieldName = 'row_num'
    end
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 200
    end
    object ResultDsetWorkTime: TFloatField
      FieldName = 'WorkTime'
    end
    object ResultDsetkol: TFloatField
      FieldName = 'kol'
    end
    object ResultDsetDiam: TStringField
      FieldName = 'Diam'
      Size = 30
    end
    object ResultDsetFullWorkTime: TFloatField
      FieldName = 'FullWorkTime'
    end
    object ResultDsetkol_norm: TFloatField
      FieldName = 'kol_norm'
    end
    object ResultDsetWorkName: TStringField
      FieldName = 'WorkName'
      Size = 50
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 48
    Top = 88
  end
  object dset_OrderInfo: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select o.OrderNumber,'
      
        '(select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders' +
        '_streets,'
      '    o.housenum, o.additionaladdress)) adres'
      'from orders o'
      'where o.id = :pOrderID')
    Left = 48
    Top = 160
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 184
    Top = 88
  end
end
