inherited dm_Svodka062: Tdm_Svodka062
  Left = 374
  Top = 514
  Width = 416
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'OrderNumber'
        DataType = ftInteger
      end
      item
        Name = 'DateComing'
        DataType = ftDateTime
      end
      item
        Name = 'DateClosed'
        DataType = ftDateTime
      end
      item
        Name = 'adres'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'damageplace'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'SONums'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'works'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'fk_orders_off'
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
    Left = 96
    Top = 16
    object ResultDsetid: TIntegerField
      FieldName = 'id'
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
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 200
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 40
    end
    object ResultDsetdamageplace: TStringField
      FieldName = 'damageplace'
      Size = 40
    end
    object ResultDsetSONums: TStringField
      FieldName = 'SONums'
      Size = 1000
    end
    object ResultDsetworks: TStringField
      FieldName = 'works'
      Size = 150
    end
    object ResultDsetfk_orders_off: TIntegerField
      FieldName = 'fk_orders_off'
    end
    object ResultDsetstr_orders_off: TStringField
      FieldName = 'str_orders_off'
      Size = 12
    end
    object ResultDsetdtr_brigg: TStringField
      FieldName = 'dtr_brigg'
    end
    object ResultDsetaddtionalinfo: TStringField
      FieldName = 'addtionalinfo'
      Size = 100
    end
    object ResultDsetDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object ResultDsetid_regin: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetid_dplace: TIntegerField
      FieldName = 'id_dplace'
    end
    object ResultDsetNumberOurRequest: TStringField
      FieldName = 'NumberOurRequest'
      Size = 100
    end
    object ResultDsetDateOurRequest: TStringField
      FieldName = 'DateOurRequest'
      Size = 100
    end
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 96
    Top = 64
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 152
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 208
    Top = 16
  end
  object dset_trans: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran_1562_1
    Left = 168
    Top = 152
  end
  object tran_1562_1: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562_1
    Left = 104
    Top = 152
  end
  object IBSQL1: TIBSQL
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran_1562_1
    Left = 232
    Top = 152
  end
end
