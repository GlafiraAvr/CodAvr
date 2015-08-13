object dm_SubOrder: Tdm_SubOrder
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 312
  Top = 231
  Height = 467
  Width = 581
  object dset_Main: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = tran
    AfterCancel = dset_MainAfterCancel
    AfterEdit = dset_MainAfterEdit
    AfterInsert = dset_MainAfterInsert
    AfterPost = dset_MainAfterPost
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from suborders where id = :old_id')
    InsertSQL.Strings = (
      'execute procedure'
      'suborder_ins_upd('
      '1,'
      ':id,'
      ':dttm_begin,'
      ':id_region,'
      ':id_street,'
      ':house_num,'
      ':apartment_num,'
      ':id_subordermsg,'
      ':id_suborderabon,'
      ':id_official_closed,'
      ':id_brig,'
      ':dttm_end,'
      ':id_order,'
      ':phone_num,'
      ':add_info,'
      ':is_checked)'
      '')
    RefreshSQL.Strings = (
      'select so.id, so.dttm_begin,'
      'so.id_street, so.house_num, so.apartment_num,'
      'so.id_subordermsg, so.id_official_closed,'
      'so.id_brig, so.dttm_end, so.id_order, so.id_suborderabon,'
      'so.id_region,'
      'ss.name street,'
      
        '( select is_checked from is_suborder_checked(so.id, 1) ) is_chec' +
        'ked'
      'from suborders so'
      'left join s_streets ss on so.id_street = ss.id'
      'where so.id = :id')
    SelectSQL.Strings = (
      '/*select so.id, so.dttm_begin,'
      'so.id_street, so.house_num, so.apartment_num,'
      'so.id_subordermsg, so.id_official_closed,'
      'so.id_brig, so.dttm_end, so.id_order, so.id_suborderabon,'
      'so.id_region,'
      'ss.name street,'
      
        '( select is_checked from is_suborder_checked(so.id, 1) ) is_chec' +
        'ked'
      'from suborders so'
      'left join s_streets ss on so.id_street = ss.id'
      'order by ss.name, so.house_num, so.dttm_begin'
      '*/')
    ModifySQL.Strings = (
      'execute procedure'
      'suborder_ins_upd('
      '2,'
      ':id,'
      ':dttm_begin,'
      ':id_region,'
      ':id_street,'
      ':house_num,'
      ':apartment_num,'
      ':id_subordermsg,'
      ':id_suborderabon,'
      ':id_official_closed,'
      ':id_brig,'
      ':dttm_end,'
      ':id_order,'
      ':phone_num,'
      ':add_info,'
      ':is_checked)')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_SUBORDERS_ID'
    Left = 32
    Top = 24
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"SUBORDERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainDTTM_BEGIN: TDateTimeField
      FieldName = 'DTTM_BEGIN'
      Origin = '"SUBORDERS"."DTTM_BEGIN"'
    end
    object dset_MainID_REGION: TIntegerField
      FieldName = 'ID_REGION'
    end
    object dset_MainID_STREET: TIntegerField
      FieldName = 'ID_STREET'
      Origin = '"SUBORDERS"."ID_STREET"'
    end
    object dset_MainHOUSE_NUM: TIBStringField
      FieldName = 'HOUSE_NUM'
      Origin = '"SUBORDERS"."HOUSE_NUM"'
      Size = 10
    end
    object dset_MainAPARTMENT_NUM: TIBStringField
      FieldName = 'APARTMENT_NUM'
      Origin = '"SUBORDERS"."APARTMENT_NUM"'
      Size = 10
    end
    object dset_MainPHONE_NUM: TStringField
      FieldName = 'PHONE_NUM'
      Size = 25
    end
    object dset_MainID_SUBORDERMSG: TIntegerField
      FieldName = 'ID_SUBORDERMSG'
      Origin = '"SUBORDERS"."ID_SUBORDERMSG"'
    end
    object dset_MainID_SUBORDERABON: TIntegerField
      FieldName = 'ID_SUBORDERABON'
      Origin = '"SUBORDERS"."ID_SUBORDERABON"'
    end
    object dset_MainID_OFFICIAL_CLOSED: TIntegerField
      FieldName = 'ID_OFFICIAL_CLOSED'
      Origin = '"SUBORDERS"."ID_OFFICIAL_CLOSED"'
    end
    object dset_MainID_BRIG: TIntegerField
      FieldName = 'ID_BRIG'
      Origin = '"SUBORDERS"."ID_BRIG"'
    end
    object dset_MainDTTM_END: TDateTimeField
      FieldName = 'DTTM_END'
      Origin = '"SUBORDERS"."DTTM_END"'
    end
    object dset_MainID_ORDER: TIntegerField
      FieldName = 'ID_ORDER'
      Origin = '"SUBORDERS"."ID_ORDER"'
    end
    object dset_MainADD_INFO: TStringField
      FieldName = 'ADD_INFO'
      Size = 150
    end
    object dset_MainIS_CHECKED: TIntegerField
      FieldName = 'IS_CHECKED'
      ProviderFlags = []
    end
    object dset_MainlpSTREET: TStringField
      FieldKind = fkLookup
      FieldName = 'lpSTREET'
      LookupDataSet = mt_Street
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_STREET'
      Lookup = True
    end
    object dset_MainlpMSG: TStringField
      FieldKind = fkLookup
      FieldName = 'lpMSG'
      LookupDataSet = mt_Msg
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_SUBORDERMSG'
      Lookup = True
    end
    object dset_MainlpABON: TStringField
      FieldKind = fkLookup
      FieldName = 'lpABON'
      LookupDataSet = mt_Abon
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_SUBORDERABON'
      Lookup = True
    end
    object dset_MainlpOFFIC: TStringField
      FieldKind = fkLookup
      FieldName = 'lpOFFIC'
      LookupDataSet = mt_Offic
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_OFFICIAL_CLOSED'
      Lookup = True
    end
    object dset_MainlpBRIG: TStringField
      FieldKind = fkLookup
      FieldName = 'lpBRIG'
      LookupDataSet = mt_Brig
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_BRIG'
      Lookup = True
    end
    object dset_Mainlp_IsChecked: TBooleanField
      FieldKind = fkLookup
      FieldName = 'lp_IsChecked'
      LookupDataSet = mt_bool
      LookupKeyFields = 'id'
      LookupResultField = 'value'
      KeyFields = 'IS_CHECKED'
      Lookup = True
    end
    object dset_MainlpREGION: TStringField
      FieldKind = fkLookup
      FieldName = 'lpREGION'
      LookupDataSet = mt_Region
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_REGION'
      Lookup = True
    end
    object dset_MainADDRESS: TStringField
      FieldKind = fkCalculated
      FieldName = 'ADDRESS'
      Size = 80
      Calculated = True
    end
    object dset_MainIsALIEN: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'IsALIEN'
      Calculated = True
    end
    object dset_MainclcOrderNumber: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'clcOrderNumber'
      Calculated = True
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 176
    Top = 24
  end
  object mt_Street: TkbmMemTable
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
    Left = 24
    Top = 152
  end
  object mt_Msg: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_subordermsg
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
    Left = 88
    Top = 152
  end
  object mt_Abon: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_suborderabon
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
    Left = 152
    Top = 152
  end
  object mt_Offic: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_officials
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
    Left = 24
    Top = 232
  end
  object mt_Brig: TkbmMemTable
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
    Left = 96
    Top = 232
  end
  object mt_bool: TkbmMemTable
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
    Left = 368
    Top = 40
    object mt_boolid: TIntegerField
      FieldName = 'id'
    end
    object mt_boolvalue: TBooleanField
      FieldName = 'value'
    end
  end
  object dset_OrderNumber: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select OrderNumber'
      'from orders'
      'where id = :pOrderID')
    Left = 376
    Top = 152
  end
  object mt_Region: TkbmMemTable
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
    Left = 168
    Top = 232
  end
end
