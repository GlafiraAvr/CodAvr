inherited dm_SuborderVA: Tdm_SuborderVA
  OldCreateOrder = True
  Height = 228
  object mt_Streets: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_streets
    AttachedAutoRefresh = True
    AttachMaxCount = 10
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
        DataType = ftSmallint
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
    Top = 16
  end
  object mt_Brig: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_brigadiers
    AttachedAutoRefresh = True
    AttachMaxCount = 10
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
    Left = 32
    Top = 96
  end
  object mt_Offic: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_officials
    AttachedAutoRefresh = True
    AttachMaxCount = 10
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
        Name = 'fk_offic_officpost'
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
    Left = 112
    Top = 96
  end
  object mt_Abon: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_suborderabon
    AttachedAutoRefresh = True
    AttachMaxCount = 10
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'activity'
        DataType = ftSmallint
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
    Left = 112
    Top = 16
  end
  object mt_Msg: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_subordermsg
    AttachedAutoRefresh = True
    AttachMaxCount = 10
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'activity'
        DataType = ftSmallint
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
    Left = 208
    Top = 24
  end
  object mt_Region: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_regions
    AttachedAutoRefresh = True
    AttachMaxCount = 10
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
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
    Left = 200
    Top = 96
  end
end
