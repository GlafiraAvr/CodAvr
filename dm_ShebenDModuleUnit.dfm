inherited dm_ShebenDModule: Tdm_ShebenDModule
  Left = 647
  Top = 295
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
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ID_ORDER'
        DataType = ftInteger
      end
      item
        Name = 'ORDER_NUMBER'
        DataType = ftInteger
      end
      item
        Name = 'ADRES'
        DataType = ftString
        Size = 190
      end
      item
        Name = 'DAMAGELOCALITY'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'EXC_SQUARE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RASKOP_DT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DT_SHEB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DT_ASF'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Region'
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
    Left = 32
    Top = 184
    object ResultDsetID_ORDER: TIntegerField
      FieldName = 'ID_ORDER'
    end
    object ResultDsetORDER_NUMBER: TIntegerField
      FieldName = 'ORDER_NUMBER'
    end
    object ResultDsetADRES: TStringField
      FieldName = 'ADRES'
      Size = 190
    end
    object ResultDsetDAMAGELOCALITY: TStringField
      FieldName = 'DAMAGELOCALITY'
      Size = 64
    end
    object ResultDsetEXC_SQUARE: TStringField
      FieldName = 'EXC_SQUARE'
      Size = 5
    end
    object ResultDsetRASKOP_DT: TStringField
      FieldName = 'RASKOP_DT'
    end
    object ResultDsetDT_SHEB: TStringField
      FieldName = 'DT_SHEB'
    end
    object ResultDsetDT_ASF: TStringField
      FieldName = 'DT_ASF'
    end
    object ResultDsetRegion: TStringField
      FieldName = 'Region'
    end
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
  end
  object Dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      '  select id_order, order_number, adres, exc_square,'
      
        '  (select name from s_DamageLocality where id=o.fk_orders_Damage' +
        'Locality) DamageLocality,'
      '  raskop_dt,'
      '  ex.dtime dt_sheb,'
      
        '  ( select dtime from excavations where fk_excavations_orders = ' +
        'o.id and fk_excavations_excwt = 5 ) dt_asf,'
      '  id_dmgloc, last_exc_wrktype, blag_dt, pplan_dt'
      '  from get_blag2( 1, '#39'02.11.2009'#39', '#39'01.01.2010'#39', '#39'24.03.2010'#39' )'
      
        '  join excavations ex on (ex.fk_excavations_orders = id_order an' +
        'd ex.fk_excavations_excwt = 11)'
      '  left join orders o on ( o.id = id_order )'
      '')
    Left = 24
    Top = 96
    object DsetID_ORDER: TIntegerField
      FieldName = 'ID_ORDER'
      Origin = '"GET_BLAG2"."ID_ORDER"'
    end
    object DsetORDER_NUMBER: TIntegerField
      FieldName = 'ORDER_NUMBER'
      Origin = '"GET_BLAG2"."ORDER_NUMBER"'
    end
    object DsetADRES: TIBStringField
      FieldName = 'ADRES'
      Origin = '"GET_BLAG2"."ADRES"'
      Size = 190
    end
    object DsetEXC_SQUARE: TFloatField
      FieldName = 'EXC_SQUARE'
      Origin = '"GET_BLAG2"."EXC_SQUARE"'
    end
    object DsetDAMAGELOCALITY: TIBStringField
      FieldName = 'DAMAGELOCALITY'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object DsetRASKOP_DT: TDateTimeField
      FieldName = 'RASKOP_DT'
      Origin = '"GET_BLAG2"."RASKOP_DT"'
    end
    object DsetDT_SHEB: TDateTimeField
      FieldName = 'DT_SHEB'
      Origin = '"EXCAVATIONS"."DTIME"'
    end
    object DsetDT_ASF: TDateTimeField
      FieldName = 'DT_ASF'
      ProviderFlags = []
    end
    object DsetID_DMGLOC: TIntegerField
      FieldName = 'ID_DMGLOC'
      Origin = '"GET_BLAG2"."ID_DMGLOC"'
    end
    object DsetLAST_EXC_WRKTYPE: TIntegerField
      FieldName = 'LAST_EXC_WRKTYPE'
      Origin = '"GET_BLAG2"."LAST_EXC_WRKTYPE"'
    end
    object DsetBLAG_DT: TDateTimeField
      FieldName = 'BLAG_DT'
      Origin = '"GET_BLAG2"."BLAG_DT"'
    end
    object DsetPPLAN_DT: TDateTimeField
      FieldName = 'PPLAN_DT'
      Origin = '"GET_BLAG2"."PPLAN_DT"'
    end
  end
  object dset_reg: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name from s_regions')
    Left = 136
    Top = 96
    object dset_regID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_regNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
  end
end
