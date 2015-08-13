inherited dm_NaledRep: Tdm_NaledRep
  inherited frReport: TfrReport
    Dataset = frDBResult
    ReportForm = {19000000}
  end
  object Dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      '  select '#39'1'#39' MainGr, o.id, o.ordernumber'
      
        '        , (select name from s_Regions where id=o.fk_orders_regio' +
        'ns) Regions'
      
        '        , (select adres from Get_adres(o.fk_orders_housetypes, o' +
        '.fk_orders_streets,  o.housenum, o.additionaladdress)) adres'
      
        '        , (select dl.name from s_damagelocality dl where dl.id =' +
        ' o.fk_orders_damagelocality) dlname'
      '        , o.datecoming'
      
        '        , n.dttm_open , n.fk_naled_officialopen , n.dttm_closed ' +
        ', n.fk_naled_officialclosed , n.square , n.volume'
      '  from naled n'
      '  left join orders o on (n.fk_naled_orders = o.id)'
      '')
    Left = 24
    Top = 96
    object DsetID: TIntegerField
      FieldName = 'ID'
      Origin = '"ORDERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object DsetORDERNUMBER: TIntegerField
      FieldName = 'ORDERNUMBER'
      Origin = '"ORDERS"."ORDERNUMBER"'
    end
    object DsetREGIONS: TIBStringField
      FieldName = 'REGIONS'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object DsetADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      Size = 190
    end
    object DsetDLNAME: TIBStringField
      FieldName = 'DLNAME'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object DsetDATECOMING: TDateTimeField
      FieldName = 'DATECOMING'
      Origin = '"ORDERS"."DATECOMING"'
    end
    object DsetDTTM_OPEN: TDateTimeField
      FieldName = 'DTTM_OPEN'
      Origin = '"NALED"."DTTM_OPEN"'
    end
    object DsetFK_NALED_OFFICIALOPEN: TIntegerField
      FieldName = 'FK_NALED_OFFICIALOPEN'
      Origin = '"NALED"."FK_NALED_OFFICIALOPEN"'
    end
    object DsetDTTM_CLOSED: TDateTimeField
      FieldName = 'DTTM_CLOSED'
      Origin = '"NALED"."DTTM_CLOSED"'
    end
    object DsetFK_NALED_OFFICIALCLOSED: TIntegerField
      FieldName = 'FK_NALED_OFFICIALCLOSED'
      Origin = '"NALED"."FK_NALED_OFFICIALCLOSED"'
    end
    object DsetSQUARE: TFloatField
      FieldName = 'SQUARE'
      Origin = '"NALED"."SQUARE"'
    end
    object DsetVOLUME: TFloatField
      FieldName = 'VOLUME'
      Origin = '"NALED"."VOLUME"'
    end
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
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
    Left = 32
    Top = 184
    object ResultDsetordernumber: TStringField
      FieldName = 'ordernumber'
      Size = 8
    end
    object ResultDsetRegions: TStringField
      DisplayWidth = 20
      FieldName = 'Regions'
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 190
    end
    object ResultDsetdlname: TStringField
      FieldName = 'dlname'
      Size = 30
    end
    object ResultDsetsquare: TIntegerField
      FieldName = 'square'
    end
    object ResultDsetdatecoming: TDateTimeField
      FieldName = 'dttm_open'
    end
    object ResultDsetdttm_closed: TDateTimeField
      FieldName = 'dttm_closed'
    end
    object ResultDsets_dttm_closed: TStringField
      FieldName = 's_dttm_closed'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 24
  end
end
