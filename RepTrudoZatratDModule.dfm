inherited dm_RepTrudoZatrat: Tdm_RepTrudoZatrat
  Left = 649
  Top = 400
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 24
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 96
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
    Left = 128
    Top = 96
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id_order'
        DataType = ftInteger
      end
      item
        Name = 'id_dep'
        DataType = ftInteger
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
      end
      item
        Name = 'WorkName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Diam'
        DataType = ftInteger
      end>
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
    Left = 32
    Top = 184
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetid_dep: TIntegerField
      FieldName = 'id_dep'
    end
    object ResultDsetStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object ResultDsetWorkName: TStringField
      FieldName = 'WorkName'
      Size = 50
    end
    object ResultDsetWorkTime: TFloatField
      FieldName = 'WorkTime'
    end
    object ResultDsetDiam: TIntegerField
      FieldName = 'Diam'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 200
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
  end
end
