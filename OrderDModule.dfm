object dm_Order: Tdm_Order
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 723
  Top = 517
  Height = 399
  Width = 485
  object mt_Order: TkbmMemTable
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
    Top = 8
    object mt_OrderDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object mt_OrderShiftNumber: TIntegerField
      FieldName = 'ShiftNumber'
    end
    object mt_OrderShiftNumberClose: TIntegerField
      FieldName = 'ShiftNumberClose'
    end
    object mt_OrderRegionID: TIntegerField
      FieldName = 'RegionID'
    end
  end
  object mt_officials_open: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_officials
    AttachedAutoRefresh = True
    AttachMaxCount = 8
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
    Left = 40
    Top = 64
  end
  object mt_street: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_streets
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
    Left = 40
    Top = 120
  end
  object mt_regions: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_regions
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
    Left = 32
    Top = 184
  end
  object mt_HouseType: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_HouseType
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 16
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
    Left = 128
    Top = 72
  end
  object mt_street2: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_streets
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
    Left = 128
    Top = 120
  end
  object mt_messagetype: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_messagetypes
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
        Size = 20
      end
      item
        Name = 'S_MT_CATEGORY_ID'
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
    Left = 128
    Top = 184
  end
  object mt_DamageLocality: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_damagelocality
    AttachedAutoRefresh = True
    AttachMaxCount = 3
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
      end
      item
        Name = 'classnumber'
        DataType = ftString
        Size = 20
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
    Left = 216
    Top = 72
  end
  object mt_DamagePlace: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_damageplace
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
        Size = 32
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CHACK_DIAM'
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
    Left = 216
    Top = 128
  end
  object mt_Organisation: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_organisation
    AttachedAutoRefresh = True
    AttachMaxCount = 3
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'phone'
        DataType = ftString
        Size = 16
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
    Top = 192
  end
  object mt_tubediametr: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_tubediameter
    AttachedAutoRefresh = True
    AttachMaxCount = 5
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'diameter'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 10
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
    Left = 328
    Top = 72
  end
  object md_tubemater: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_tubematerial
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 16
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
    Left = 328
    Top = 120
  end
  object mt_officials_close: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_officials
    AttachedAutoRefresh = True
    AttachMaxCount = 8
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
    Left = 328
    Top = 192
  end
  object mt_soil: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_soil
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 16
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
    Left = 408
    Top = 80
  end
  object mt_Damagetype: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_Damagetype
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 16
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
    Left = 408
    Top = 136
  end
  object mt_DamageLocality_2: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_damagelocality
    AttachedAutoRefresh = True
    AttachMaxCount = 3
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
      end
      item
        Name = 'classnumber'
        DataType = ftString
        Size = 20
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
    Top = 240
  end
end
