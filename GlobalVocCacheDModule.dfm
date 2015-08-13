object dm_GlobalVocCache: Tdm_GlobalVocCache
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 334
  Top = 179
  Height = 591
  Width = 874
  object mt_s_streets: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 8
    object mt_s_streetsid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_streetsname: TStringField
      FieldName = 'name'
      Size = 64
    end
    object mt_s_streetsactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object dset_Voc: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 744
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 744
    Top = 80
  end
  object mt_s_subordermsg: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 56
    object mt_s_subordermsgid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_subordermsgname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mt_s_subordermsgactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object kbmCSVStreamFormat1: TkbmCSVStreamFormat
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    sfLocalFormat = []
    sfQuoteOnlyStrings = []
    sfNoHeader = []
    Version = '3.00'
    sfData = [sfSaveData, sfLoadData]
    sfCalculated = []
    sfLookup = []
    sfNonVisible = [sfSaveNonVisible, sfLoadNonVisible]
    sfBlobs = [sfSaveBlobs, sfLoadBlobs]
    sfDef = [sfSaveDef, sfLoadDef]
    sfIndexDef = [sfSaveIndexDef, sfLoadIndexDef]
    sfPlaceHolders = []
    sfFiltered = [sfSaveFiltered]
    sfIgnoreRange = [sfSaveIgnoreRange]
    sfIgnoreMasterDetail = [sfSaveIgnoreMasterDetail]
    sfDeltas = []
    sfDontFilterDeltas = []
    sfAppend = []
    sfFieldKind = [sfSaveFieldKind]
    sfFromStart = [sfLoadFromStart]
    Left = 736
    Top = 392
  end
  object dset_Ver: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 744
    Top = 136
  end
  object kbmBinaryStreamFormat1: TkbmBinaryStreamFormat
    Version = '3.00'
    sfUsingIndex = [sfSaveUsingIndex]
    sfData = [sfSaveData, sfLoadData]
    sfCalculated = []
    sfLookup = []
    sfNonVisible = [sfSaveNonVisible, sfLoadNonVisible]
    sfBlobs = [sfSaveBlobs, sfLoadBlobs]
    sfDef = [sfSaveDef, sfLoadDef]
    sfIndexDef = [sfSaveIndexDef, sfLoadIndexDef]
    sfFiltered = [sfSaveFiltered]
    sfIgnoreRange = [sfSaveIgnoreRange]
    sfIgnoreMasterDetail = [sfSaveIgnoreMasterDetail]
    sfDeltas = []
    sfDontFilterDeltas = []
    sfAppend = []
    sfFieldKind = [sfSaveFieldKind]
    sfFromStart = [sfLoadFromStart]
    sfDataTypeHeader = [sfSaveDataTypeHeader, sfLoadDataTypeHeader]
    BufferSize = 16384
    Left = 736
    Top = 440
  end
  object mt_s_suborderabon: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 120
    object mt_s_suborderabonid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_suborderabonname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mt_s_suborderabonactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_brigadiers: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 176
    object mt_brigadiersid: TIntegerField
      FieldName = 'id'
    end
    object mt_brigadiersname: TStringField
      FieldName = 'name'
      Size = 64
    end
    object mt_brigadiersactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object mt_brigadiersfk_brigadiers_regions: TIntegerField
      FieldName = 'fk_brigadiers_regions'
    end
  end
  object mt_s_officials: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 240
    object mt_s_officialsid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_officialsname: TStringField
      FieldName = 'name'
      Size = 64
    end
    object mt_s_officialsactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object mt_s_officialsfk_offic_officpost: TIntegerField
      FieldName = 'fk_offic_officpost'
    end
  end
  object mt_s_regions: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 312
    object mt_s_regionsid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_regionsname: TStringField
      FieldName = 'name'
      Size = 32
    end
    object mt_s_regionsactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object mt_s_damageplace: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 376
    object mt_s_damageplaceid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_damageplacename: TStringField
      FieldName = 'name'
      Size = 32
    end
    object mt_s_damageplaceactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object mt_s_damageplaceCHACK_DIAM: TStringField
      FieldName = 'CHACK_DIAM'
      Size = 1
    end
  end
  object mt_s_worktime: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 168
    Top = 8
    object mt_s_worktimeid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_worktimeid_work: TIntegerField
      FieldName = 'id_work'
    end
    object mt_s_worktimeid_diam: TIntegerField
      FieldName = 'id_diam'
    end
    object mt_s_worktimehour_summer: TFloatField
      FieldName = 'hour_summer'
    end
    object mt_s_worktimehour_winter: TFloatField
      FieldName = 'hour_winter'
    end
    object mt_s_worktimeactivity: TSmallintField
      FieldName = 'activity'
    end
    object mt_s_worktimediam: TIntegerField
      FieldName = 'diam'
    end
    object mt_s_worktimework_name: TStringField
      FieldName = 'work_name'
      Size = 50
    end
    object mt_s_worktimemeasur_quantity: TFloatField
      FieldName = 'measur_quantity'
    end
  end
  object mt_s_bwork: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 168
    Top = 80
    object mt_s_bworkid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_bworkname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mt_s_bworkactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_s_works: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 7
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
        Name = 'measurement'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'id_workkind'
        DataType = ftInteger
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'for_plan'
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 160
    Top = 152
    object mt_s_worksid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_worksname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mt_s_worksmeasurement: TStringField
      FieldName = 'measurement'
    end
    object mt_s_worksid_workkind: TIntegerField
      FieldName = 'id_workkind'
    end
    object mt_s_worksactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object mt_s_worksfor_plan: TIntegerField
      FieldName = 'for_plan'
    end
  end
  object mt_s_tubediameter: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 160
    Top = 216
    object mt_s_tubediameterid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_tubediameterdiameter: TIntegerField
      FieldName = 'diameter'
    end
    object mt_s_tubediametername: TStringField
      FieldName = 'name'
      Size = 10
    end
    object mt_s_tubediameteractivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object mt_materials: TkbmMemTable
    DesignActivation = True
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
        Size = 50
      end
      item
        Name = 'measurement'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'full_name'
        DataType = ftString
        Size = 50
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 176
    Top = 288
    object mt_materialsid: TIntegerField
      FieldName = 'id'
    end
    object mt_materialsname: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mt_materialsmeasurement: TStringField
      FieldName = 'measurement'
      Size = 50
    end
    object mt_materialsfull_name: TStringField
      FieldName = 'full_name'
      Size = 50
    end
    object mt_materialsactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object mt_s_worktype: TkbmMemTable
    DesignActivation = True
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
        Size = 40
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 168
    Top = 360
    object mt_s_worktypeid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_worktypename: TStringField
      FieldName = 'name'
      Size = 40
    end
    object mt_s_worktypeactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_Equipment: TkbmMemTable
    DesignActivation = True
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
        Size = 40
      end
      item
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'id_region'
        DataType = ftInteger
      end
      item
        Name = 'id_vocrectype'
        DataType = ftInteger
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'is_visible_for_cur_district'
        DataType = ftSmallint
      end
      item
        Name = 'fl_FULL_NAME'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'v_kovsh'
        DataType = ftFloat
      end
      item
        Name = 'gos_number'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'shot_name'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'id_typ'
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 40
    Top = 456
    object mt_Equipmentid: TIntegerField
      FieldName = 'id'
    end
    object mt_Equipmentname: TStringField
      FieldName = 'name'
      Size = 40
    end
    object mt_Equipmentnumber: TIntegerField
      FieldName = 'number'
    end
    object mt_Equipmentid_region: TIntegerField
      FieldName = 'id_region'
    end
    object mt_Equipmentid_vocrectype: TIntegerField
      FieldName = 'id_vocrectype'
    end
    object mt_Equipmentactivity: TStringField
      FieldName = 'activity'
      Size = 5
    end
    object mt_Equipmentis_visible_for_cur_district: TSmallintField
      FieldName = 'is_visible_for_cur_district'
    end
    object mt_Equipmentfl_FULL_NAME: TStringField
      FieldName = 'fl_FULL_NAME'
      Size = 40
    end
    object mt_Equipmentv_kovsh: TFloatField
      FieldName = 'v_kovsh'
    end
    object mt_Equipmentgos_number: TStringField
      FieldName = 'gos_number'
      Size = 2
    end
    object mt_Equipmentshot_name: TStringField
      FieldName = 'shot_name'
      Size = 10
    end
    object mt_Equipmentid_typ: TIntegerField
      FieldName = 'id_typ'
    end
  end
  object mt_s_messagetypes: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 176
    Top = 448
    object mt_s_messagetypesid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_messagetypesname: TStringField
      FieldName = 'name'
    end
    object mt_s_messagetypesS_MT_CATEGORY_ID: TSmallintField
      FieldName = 'S_MT_CATEGORY_ID'
    end
    object mt_s_messagetypesactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_HouseType: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 336
    Top = 56
    object mt_HouseTypeid: TIntegerField
      FieldName = 'id'
    end
    object mt_HouseTypename: TStringField
      FieldName = 'name'
      Size = 16
    end
    object mt_HouseTypeactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_damagelocality: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 336
    Top = 120
    object mt_damagelocalityid: TIntegerField
      FieldName = 'id'
    end
    object mt_damagelocalityname: TStringField
      FieldName = 'name'
      Size = 64
    end
    object mt_damagelocalityactivity: TSmallintField
      FieldName = 'activity'
    end
    object mt_damagelocalityclassnumber: TStringField
      FieldName = 'classnumber'
    end
  end
  object mt_tubematerial: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 336
    Top = 184
    object mt_tubematerialid: TIntegerField
      FieldName = 'id'
    end
    object mt_tubematerialname: TStringField
      FieldName = 'name'
      Size = 16
    end
    object mt_tubematerialactivity: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'activity'
      Calculated = True
    end
  end
  object mt_organisation: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 336
    Top = 240
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object StringField1: TStringField
      FieldName = 'name'
      Size = 16
    end
    object SmallintField1: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'activity'
      Calculated = True
    end
    object mt_organisationphone: TStringField
      FieldName = 'phone'
      Size = 16
    end
  end
  object mt_s_soil: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 328
    Top = 320
    object mt_s_soilid: TIntegerField
      FieldName = 'id'
    end
    object mt_s_soilname: TStringField
      FieldName = 'name'
      Size = 16
    end
    object mt_s_soilactivity: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'activity'
      Calculated = True
    end
  end
  object mt_s_Damagetype: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 328
    Top = 400
    object IntegerField2: TIntegerField
      FieldName = 'id'
    end
    object StringField2: TStringField
      FieldName = 'name'
      Size = 16
    end
    object mt_s_Damagetypeactivity: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'activity'
      Calculated = True
    end
  end
  object mt_S_Applicant_vds: TkbmMemTable
    DesignActivation = True
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 472
    Top = 64
    object IntegerField3: TIntegerField
      FieldName = 'id'
    end
    object StringField3: TStringField
      FieldName = 'name'
      Size = 16
    end
    object SmallintField2: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_S_Message_vDS: TkbmMemTable
    DesignActivation = True
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
        Size = 30
      end
      item
        Name = 'activity'
        DataType = ftSmallint
      end
      item
        Name = 'messagename'
        DataType = ftString
        Size = 30
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 472
    Top = 120
    object IntegerField4: TIntegerField
      FieldName = 'id'
    end
    object StringField4: TStringField
      FieldName = 'name'
      Size = 30
    end
    object SmallintField3: TSmallintField
      DisplayWidth = 10
      FieldName = 'activity'
    end
    object mt_S_Message_vDSmessagename: TStringField
      FieldName = 'messagename'
      Size = 30
    end
  end
  object mt_demagetype_vds: TkbmMemTable
    DesignActivation = True
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
        Size = 30
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 472
    Top = 192
    object mt_demagetype_vdsid: TIntegerField
      FieldName = 'id'
    end
    object mt_demagetype_vdsname: TStringField
      FieldName = 'name'
      Size = 30
    end
    object mt_demagetype_vdsactivity: TSmallintField
      FieldName = 'activity'
    end
  end
  object mt_S_all_regions: TkbmMemTable
    DesignActivation = True
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
        Size = 30
      end
      item
        Name = 'full_name'
        DataType = ftString
        Size = 200
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
    DefaultFormat = kbmBinaryStreamFormat1
    Left = 472
    Top = 288
    object IntegerField5: TIntegerField
      FieldName = 'id'
    end
    object StringField5: TStringField
      FieldName = 'name'
      Size = 30
    end
    object mt_S_all_regionsfull_name: TStringField
      FieldName = 'full_name'
      Size = 200
    end
  end
end
