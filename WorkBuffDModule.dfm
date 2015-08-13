object dm_WorkBuff: Tdm_WorkBuff
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 594
  Top = 502
  Height = 433
  Width = 569
  object mt_DepWorks: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'OrderID'
        DataType = ftInteger
      end
      item
        Name = 'DepID'
        DataType = ftInteger
      end
      item
        Name = 'WorkID'
        DataType = ftInteger
      end
      item
        Name = 'DiamID'
        DataType = ftInteger
      end
      item
        Name = 'Quantity'
        DataType = ftFloat
      end
      item
        Name = 'AddInfo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'OfficPostInsID'
        DataType = ftInteger
      end
      item
        Name = 'TrudoZatrat'
        DataType = ftFloat
      end
      item
        Name = 'TZ_KolEd'
        DataType = ftFloat
      end
      item
        Name = 'exc_depth'
        DataType = ftFloat
      end
      item
        Name = 'exc_width'
        DataType = ftFloat
      end
      item
        Name = 'exc_length'
        DataType = ftFloat
      end
      item
        Name = 'REC_STATE'
        DataType = ftSmallint
      end
      item
        Name = 'IS_CAN_EDIT'
        DataType = ftBoolean
      end
      item
        Name = 'SQUARE_ASF'
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
    AfterInsert = mt_DepWorksAfterInsert
    OnFilterRecord = mt_DepWorksFilterRecord
    Left = 32
    Top = 24
    object mt_DepWorksID: TIntegerField
      FieldName = 'ID'
    end
    object mt_DepWorksOrderID: TIntegerField
      FieldName = 'OrderID'
    end
    object mt_DepWorksDepID: TIntegerField
      FieldName = 'DepID'
    end
    object mt_DepWorksWorkID: TIntegerField
      FieldName = 'WorkID'
      OnChange = mt_DepWorksWorkIDChange
    end
    object mt_DepWorksDiamID: TIntegerField
      FieldName = 'DiamID'
    end
    object mt_DepWorksQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object mt_DepWorksAddInfo: TStringField
      FieldName = 'AddInfo'
      Size = 50
    end
    object mt_DepWorksOfficPostInsID: TIntegerField
      FieldName = 'OfficPostInsID'
    end
    object mt_DepWorksTrudoZatrat: TFloatField
      FieldName = 'TrudoZatrat'
    end
    object mt_DepWorksTZ_KolEd: TFloatField
      FieldName = 'TZ_KolEd'
    end
    object mt_DepWorksexc_depth: TFloatField
      FieldName = 'exc_depth'
    end
    object mt_DepWorksexc_width: TFloatField
      FieldName = 'exc_width'
    end
    object mt_DepWorksexc_length: TFloatField
      FieldName = 'exc_length'
    end
    object mt_DepWorksREC_STATE: TSmallintField
      FieldName = 'REC_STATE'
    end
    object mt_DepWorksIS_CAN_EDIT: TBooleanField
      FieldName = 'IS_CAN_EDIT'
    end
    object mt_DepWorkslp_Work: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_Work'
      LookupDataSet = mt_s_work
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'WorkID'
      Size = 50
      Lookup = True
    end
    object mt_DepWorkslp_Diam: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_Diam'
      LookupDataSet = mt_s_diam
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'DiamID'
      Size = 10
      Lookup = True
    end
    object mt_DepWorksSQUARE_ASF: TFloatField
      FieldName = 'SQUARE_ASF'
    end
    object mt_DepWorkssentto1562: TBooleanField
      FieldName = 'sentto1562'
    end
    object mt_DepWorksFact_DateTime: TDateTimeField
      FieldName = 'Fact_DateTime'
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 160
  end
  object mt_s_work: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_works
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
    Left = 120
    Top = 24
  end
  object mt_s_diam: TkbmMemTable
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
    Left = 200
    Top = 24
  end
  object sql_DeleteWork: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'delete from departureworks where id = :pID')
    Transaction = tran
    Left = 80
    Top = 160
  end
  object sql_UpdateWork: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'update departureworks set'
      'FK_DEPWORKS_WORK = :pWorkID,'
      'FK_DEPWORKS_DIAMETER = :pDiamID,'
      'QUANTITY = :pQuantity,'
      'ADDITIONALINFO = :pAddInfo,'
      'WORK_TIME = :pWorkTime,'
      'MEASUR_QUANTITY = :pMeasurQuantity,'
      'EXC_DEPTH = :pExcDepth,'
      'EXC_WIDTH = :pExcWidth,'
      'EXC_LENGTH = :pExcLength,'
      'SQUARE_ASF = :pSQUAREASF,'
      'Sent_1562  =:pSent_1562 '
      'where id = :pID')
    Transaction = tran
    Left = 264
    Top = 160
  end
  object sql_InsertWork: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'insert into departureworks('
      'FK_DEPWORKS_ORDER,'
      'FK_DEPWORKS_DEPARTURE,'
      'FK_DEPWORKS_WORK,'
      'FK_DEPWORKS_DIAMETER,'
      'QUANTITY,'
      'ADDITIONALINFO,'
      'FK_DEPWORKS_OFFICPOST_INS,'
      'WORK_TIME,'
      'MEASUR_QUANTITY,'
      'EXC_DEPTH,'
      'EXC_WIDTH,'
      'EXC_LENGTH,'
      'SQUARE_ASF,'
      'Sent_1562'
      ')'
      'values('
      ':pOrderID,'
      ':pDepID,'
      ':pWorkID,'
      ':pDiamID,'
      ':pQuantity,'
      ':pAddInfo,'
      ':pOfficPostInsID,'
      ':pWorkTime,'
      ':pMeasurQuantity,'
      ':pExcDepth,'
      ':pExcWidth,'
      ':pExcLength,'
      ':pSQUAREASF,'
      ':pSent_1562'
      ')')
    Transaction = tran
    Left = 176
    Top = 160
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 24
    Top = 96
  end
  object mt_WorkAtt: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_works
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
    Top = 336
  end
end
