object dm_TrudoZatrat: Tdm_TrudoZatrat
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 481
  Top = 265
  Height = 279
  Width = 353
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 24
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 24
  end
  object mt_WorkTimeAtt: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_worktime
    AttachedAutoRefresh = True
    AttachMaxCount = 5
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_work'
        DataType = ftInteger
      end
      item
        Name = 'id_diam'
        DataType = ftInteger
      end
      item
        Name = 'hour_summer'
        DataType = ftFloat
      end
      item
        Name = 'hour_winter'
        DataType = ftFloat
      end
      item
        Name = 'activity'
        DataType = ftSmallint
      end
      item
        Name = 'diam'
        DataType = ftInteger
      end
      item
        Name = 'work_name'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'measur_quantity'
        DataType = ftFloat
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
    Left = 56
    Top = 112
  end
end
