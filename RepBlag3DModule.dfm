inherited dm_RepBlag3: Tdm_RepBlag3
  Left = 926
  Top = 571
  Height = 347
  Width = 354
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'region'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'adres'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'total_count'
        DataType = ftInteger
      end
      item
        Name = 'total_square'
        DataType = ftFloat
      end
      item
        Name = 'magistr_count'
        DataType = ftInteger
      end
      item
        Name = 'magistr_square'
        DataType = ftFloat
      end
      item
        Name = 'vnutr_count'
        DataType = ftInteger
      end
      item
        Name = 'vnutr_square'
        DataType = ftFloat
      end
      item
        Name = 'zelen_count'
        DataType = ftInteger
      end
      item
        Name = 'zelen_square'
        DataType = ftFloat
      end
      item
        Name = 'work_type'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'raskop_dt'
        DataType = ftDateTime
      end
      item
        Name = 'pplan_dt'
        DataType = ftDateTime
      end
      item
        Name = 'blag_dt'
        DataType = ftDateTime
      end
      item
        Name = 'id_order'
        DataType = ftInteger
      end
      item
        Name = 'excnumber'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'excorder'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'dttm_excord'
        DataType = ftDateTime
      end
      item
        Name = 'dttm_planendwork'
        DataType = ftDateTime
      end
      item
        Name = 'stype'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'street'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'hnum'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'orientir'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'sblag_dt'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'sdt_excord'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'sdt_planendwork'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'numclass'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'centrDor_square'
        DataType = ftInteger
      end
      item
        Name = 'centrDor_count'
        DataType = ftInteger
      end
      item
        Name = 'form7'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'form3'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    SortFields = 'region'
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 1
    SubLanguageID = 1
    LocaleID = 66560
    Left = 144
    Top = 40
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 40
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 200
    end
    object ResultDsettotal_count: TIntegerField
      FieldName = 'total_count'
    end
    object ResultDsettotal_square: TFloatField
      FieldName = 'total_square'
    end
    object ResultDsetmagistr_count: TIntegerField
      FieldName = 'magistr_count'
    end
    object ResultDsetmagistr_square: TFloatField
      FieldName = 'magistr_square'
    end
    object ResultDsetvnutr_count: TIntegerField
      FieldName = 'vnutr_count'
    end
    object ResultDsetvnutr_square: TFloatField
      FieldName = 'vnutr_square'
    end
    object ResultDsetzelen_count: TIntegerField
      FieldName = 'zelen_count'
    end
    object ResultDsetzelen_square: TFloatField
      FieldName = 'zelen_square'
    end
    object ResultDsetwork_type: TStringField
      FieldName = 'work_type'
      Size = 10
    end
    object ResultDsetraskop_dt: TDateTimeField
      FieldName = 'raskop_dt'
    end
    object ResultDsetpplan_dt: TDateTimeField
      FieldName = 'pplan_dt'
    end
    object ResultDsetblag_dt: TDateTimeField
      FieldName = 'blag_dt'
    end
    object ResultDsetorder_number: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'order_number'
      Calculated = True
    end
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetexcnumber: TStringField
      FieldName = 'excnumber'
      Size = 6
    end
    object ResultDsetexcorder: TStringField
      FieldName = 'excorder'
      Size = 10
    end
    object ResultDsetdttm_excord: TDateTimeField
      FieldName = 'dttm_excord'
    end
    object ResultDsetdttm_planendwork: TDateTimeField
      FieldName = 'dttm_planendwork'
    end
    object ResultDsetstype: TStringField
      FieldName = 'stype'
      Size = 8
    end
    object ResultDsetstreet: TStringField
      FieldName = 'street'
      Size = 64
    end
    object ResultDsethnum: TStringField
      FieldName = 'hnum'
    end
    object ResultDsetorientir: TStringField
      FieldName = 'orientir'
      Size = 32
    end
    object ResultDsetsblag_dt: TStringField
      FieldName = 'sblag_dt'
      Size = 10
    end
    object ResultDsetsdt_excord: TStringField
      FieldName = 'sdt_excord'
      Size = 10
    end
    object ResultDsetsdt_planendwork: TStringField
      FieldName = 'sdt_planendwork'
      Size = 10
    end
    object ResultDsetnumclass: TStringField
      FieldName = 'numclass'
      Size = 5
    end
    object ResultDsetcentrDor_square: TIntegerField
      FieldName = 'centrDor_square'
    end
    object ResultDsetcentrDor_count: TIntegerField
      FieldName = 'centrDor_count'
    end
    object ResultDsetform7: TStringField
      FieldName = 'form7'
    end
    object ResultDsetform3: TStringField
      FieldName = 'form3'
      Size = 100
    end
    object ResultDsetconfirm: TStringField
      FieldName = 'confirm'
      Size = 10
    end
    object ResultDsetgroup: TIntegerField
      FieldName = 'group'
    end
    object ResultDsetorder: TStringField
      FieldName = 'order'
    end
    object ResultDsetwork_type_Z: TStringField
      FieldName = 'work_type_Z'
      Size = 4
    end
  end
  object dset_Region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name'
      'from s_regions'
      'where (id>0) and (activity is null)'
      'order by name')
    Left = 32
    Top = 104
    object dset_RegionID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_RegionNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 160
    Top = 120
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 176
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 232
    Top = 48
  end
  object dset_tmp2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 184
  end
end
