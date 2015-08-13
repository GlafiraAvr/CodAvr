object dm_prinzayv1562: Tdm_prinzayv1562
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 289
  Top = 109
  Height = 205
  Width = 304
  object mt_attbrig: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_brigadiers
    AttachedAutoRefresh = True
    AttachMaxCount = 5
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'fk_brigadiers_regions'
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
    Left = 56
    Top = 32
  end
  object dset_brig: TIBDataSet
    Left = 112
    Top = 32
  end
  object IBSQL1: TIBSQL
    Left = 168
    Top = 104
  end
  object dset_why: TIBDataSet
    Left = 120
    Top = 112
  end
end
