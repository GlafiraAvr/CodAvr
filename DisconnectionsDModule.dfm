object DM_Disconnect: TDM_Disconnect
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 344
  Top = 220
  Height = 387
  Width = 414
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 40
    Top = 32
  end
  object ds_Disconnections: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = ds_DisconnectionsAfterInsert
    BeforeEdit = ds_DisconnectionsBeforeEdit
    BeforePost = ds_DisconnectionsBeforePost
    OnCalcFields = ds_DisconnectionsCalcFields
    DeleteSQL.Strings = (
      'delete'
      ' from disconnections '
      ' where id=:id')
    InsertSQL.Strings = (
      'insert into disconnections'
      '('
      '  fk_id_order,'
      '  fk_id_street,'
      '  houses,'
      '  additionalinfo'
      ')'
      'values ('
      '  :fk_id_order,'
      '  :fk_id_street,'
      '  :houses,'
      '  :additionalinfo'
      ')')
    RefreshSQL.Strings = (
      'select'
      '  di.id'
      '  , di.fk_id_order'
      ' , di.fk_id_street'
      ' , di.houses '
      ' , di.additionalinfo'
      'from disconnections di'
      'where di.fk_id_order = :orderid')
    SelectSQL.Strings = (
      'select'
      '  di.id'
      ' , di.fk_id_order'
      ' , di.fk_id_street'
      ' , di.houses '
      ' , di.additionalinfo '
      'from disconnections di'
      'where di.fk_id_order = :orderid')
    ModifySQL.Strings = (
      'update disconnections set'
      'fk_id_order=:fk_id_order,'
      'fk_id_street=:fk_id_street,'
      'houses=:houses,'
      'additionalinfo=:additionalinfo'
      'where id=:id')
    Left = 128
    Top = 64
    object ds_Disconnectionslook_streets: TStringField
      DisplayLabel = #1059#1083#1080#1094#1072
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'look_streets'
      LookupDataSet = mt_Streets
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_ID_STREET'
      OnGetText = GetText
      Size = 75
      Lookup = True
    end
    object ds_DisconnectionsFK_ID_STREET: TIntegerField
      FieldName = 'FK_ID_STREET'
      Origin = '"DISCONNECTIONS"."FK_ID_STREET"'
      Visible = False
    end
    object ds_DisconnectionsFK_ID_ORDER: TIntegerField
      FieldName = 'FK_ID_ORDER'
      Origin = '"DISCONNECTIONS"."FK_ID_ORDER"'
      Required = True
      Visible = False
    end
    object ds_Disconnectionscalc_rayon: TStringField
      FieldKind = fkCalculated
      FieldName = 'calc_rayon'
      Calculated = True
    end
    object ds_DisconnectionsHOUSES: TIBStringField
      DisplayWidth = 64
      FieldName = 'HOUSES'
      ProviderFlags = []
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
    object ds_DisconnectionsADDITIONALINFO: TIBStringField
      DisplayWidth = 64
      FieldName = 'ADDITIONALINFO'
      ProviderFlags = []
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
  end
  object mt_Streets: TkbmMemTable
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
    Left = 280
    Top = 56
  end
end
