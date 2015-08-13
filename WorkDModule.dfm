object dm_Work: Tdm_Work
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 710
  Top = 539
  Height = 391
  Width = 570
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 472
    Top = 16
  end
  object dset_BWork: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = dset_BWorkAfterInsert
    AfterPost = dset_BWorkAfterPost
    AfterScroll = dset_BWorkAfterScroll
    BeforeDelete = dset_BWorkBeforeDelete
    DeleteSQL.Strings = (
      'delete from departure_bwork where id = :old_id')
    InsertSQL.Strings = (
      'insert into departure_bwork('
      'id,'
      'id_order,'
      'id_departure,'
      'id_bwork)'
      'values('
      ':id,'
      ':id_order,'
      ':id_departure,'
      ':id_bwork)')
    RefreshSQL.Strings = (
      'select dbw.id, dbw.id_order, dbw.id_departure, dbw.id_bwork,'
      'sb.name_'
      'from departure_bwork dbw'
      'left join s_bwork sb on sb.id = dbw.id_bwork'
      'where dbw.id = :id')
    SelectSQL.Strings = (
      'select dbw.id, dbw.id_order, dbw.id_departure, dbw.id_bwork,'
      'sb.name_'
      'from departure_bwork dbw'
      'left join s_bwork sb on sb.id = dbw.id_bwork'
      'where (dbw.id_order = :pOrderID)'
      'and (dbw.id_departure = :pDepID)'
      'order by sb.name_')
    ModifySQL.Strings = (
      'update departure_bwork set'
      'id_bwork = :id_bwork'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTURE_BWORK_ID'
    Left = 24
    Top = 8
    object dset_BWorkID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTURE_BWORK"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_BWorkID_ORDER: TIntegerField
      FieldName = 'ID_ORDER'
      Origin = '"DEPARTURE_BWORK"."ID_ORDER"'
    end
    object dset_BWorkID_DEPARTURE: TIntegerField
      FieldName = 'ID_DEPARTURE'
      Origin = '"DEPARTURE_BWORK"."ID_DEPARTURE"'
    end
    object dset_BWorkID_BWORK: TIntegerField
      FieldName = 'ID_BWORK'
      Origin = '"DEPARTURE_BWORK"."ID_BWORK"'
    end
    object dset_BWorklpBWORK: TStringField
      FieldKind = fkLookup
      FieldName = 'lpBWORK'
      LookupDataSet = mt_BWork
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'ID_BWORK'
      Size = 50
      Lookup = True
    end
  end
  object mt_BWork: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_bwork
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
    Left = 16
    Top = 64
  end
  object dset_Work: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = dset_WorkAfterInsert
    BeforePost = dset_WorkBeforePost
    OnCalcFields = dset_WorkCalcFields
    DeleteSQL.Strings = (
      'delete from departureworks'
      'where ID = :OLD_ID')
    InsertSQL.Strings = (
      'insert into departureworks('
      'ID,'
      'FK_DEPWORKS_DEPARTURE,'
      'FK_DEPWORKS_ORDER,'
      'FK_DEPWORKS_WORK,'
      'FK_DEPWORKS_BWORK,'
      'FK_DEPWORKS_DIAMETER,'
      'QUANTITY,'
      'WORK_TIME,'
      'ADDITIONALINFO,'
      'MEASUR_QUANTITY,'
      'EXC_DEPTH,'
      'EXC_WIDTH,'
      'EXC_LENGTH,'
      'FK_DEPWORKS_OFFICPOST_INS,'
      'NUM_WORK,'
      'SQUARE_ASF,'
      'Sent_1562,'
      'fact_Datetime)'
      'values('
      ':ID,'
      ':FK_DEPWORKS_DEPARTURE,'
      ':FK_DEPWORKS_ORDER,'
      ':FK_DEPWORKS_WORK,'
      ':FK_DEPWORKS_BWORK,'
      ':FK_DEPWORKS_DIAMETER,'
      ':QUANTITY,'
      ':WORK_TIME,'
      ':ADDITIONALINFO,'
      ':MEASUR_QUANTITY,'
      ':EXC_DEPTH,'
      ':EXC_WIDTH,'
      ':EXC_LENGTH,'
      ':FK_DEPWORKS_OFFICPOST_INS,'
      ':NUM_WORK,'
      ':SQUARE_ASF,'
      ':Sent_1562,'
      ':fact_Datetime)')
    RefreshSQL.Strings = (
      'select dw.ID,'
      '    dw.FK_DEPWORKS_DEPARTURE ,'
      '    dw.FK_DEPWORKS_ORDER,'
      '    dw.FK_DEPWORKS_WORK,'
      '    dw.FK_DEPWORKS_DIAMETER,'
      '    dw.QUANTITY,'
      '    dw.WORK_TIME,'
      '    dw.FK_DEPWORKS_BWORK,'
      '    dw.FK_DEPWORKS_DEPBWORK,'
      '    dw.ADDITIONALINFO,'
      '    dw.MEASUR_QUANTITY,'
      '    dw.EXC_DEPTH,'
      '    dw.EXC_WIDTH,'
      '    dw.EXC_LENGTH,'
      '    dw.FK_DEPWORKS_OFFICPOST_INS,'
      '    dw.SQUARE_ASF'
      'from departureworks dw'
      'left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK'
      'left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER'
      'where dw.ID = :ID')
    SelectSQL.Strings = (
      'select dw.ID,'
      '    dw.FK_DEPWORKS_DEPARTURE ,'
      '    dw.FK_DEPWORKS_ORDER,'
      '    dw.FK_DEPWORKS_WORK,'
      '    dw.FK_DEPWORKS_DIAMETER,'
      '    dw.QUANTITY,'
      '    dw.WORK_TIME,'
      '    dw.FK_DEPWORKS_BWORK,'
      '    dw.FK_DEPWORKS_DEPBWORK,'
      '    dw.ADDITIONALINFO,'
      '    dw.MEASUR_QUANTITY,'
      '    dw.EXC_DEPTH,'
      '    dw.EXC_WIDTH,'
      '    dw.EXC_LENGTH,'
      '    dw.FK_DEPWORKS_OFFICPOST_INS,'
      '    dw.NUM_WORK,'
      '    dw.SQUARE_ASF,'
      '    dw.Sent_1562,'
      'dw.Fact_Datetime'
      'from departureworks dw'
      'left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK'
      'left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER'
      'where'
      '    (dw.FK_DEPWORKS_ORDER = :pOrderID ) and'
      '    (dw.FK_DEPWORKS_DEPARTURE = :pDepID)'
      'order by dw.NUM_WORK, sw.NAME, sd.DIAMETER')
    ModifySQL.Strings = (
      'update departureworks set'
      'FK_DEPWORKS_BWORK = :FK_DEPWORKS_BWORK,'
      'FK_DEPWORKS_WORK = :FK_DEPWORKS_WORK,'
      'FK_DEPWORKS_DIAMETER = :FK_DEPWORKS_DIAMETER,'
      'QUANTITY = :QUANTITY,'
      'WORK_TIME = :WORK_TIME,'
      'ADDITIONALINFO = :ADDITIONALINFO,'
      'MEASUR_QUANTITY = :MEASUR_QUANTITY,'
      'EXC_DEPTH = :EXC_DEPTH,'
      'EXC_WIDTH = :EXC_WIDTH,'
      'EXC_LENGTH = :EXC_LENGTH,'
      'NUM_WORK = :NUM_WORK,'
      'SQUARE_ASF = :SQUARE_ASF,'
      'Sent_1562=:Sent_1562'
      'where ID = :ID')
    Filtered = True
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTUREWORKS_ID'
    OnFilterRecord = dset_WorkFilterRecord
    Left = 144
    Top = 8
    object dset_WorkID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREWORKS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorkFK_DEPWORKS_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPWORKS_DEPARTURE'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_DEPARTURE"'
      Required = True
    end
    object dset_WorkFK_DEPWORKS_ORDER: TIntegerField
      FieldName = 'FK_DEPWORKS_ORDER'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_ORDER"'
      Required = True
    end
    object dset_WorkFK_DEPWORKS_WORK: TIntegerField
      FieldName = 'FK_DEPWORKS_WORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_WORK"'
      Required = True
      OnChange = dset_WorkFK_DEPWORKS_WORKChange
    end
    object dset_WorkFK_DEPWORKS_DIAMETER: TIntegerField
      FieldName = 'FK_DEPWORKS_DIAMETER'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_DIAMETER"'
    end
    object dset_WorkQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREWORKS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_WorkWORK_TIME: TIBBCDField
      FieldName = 'WORK_TIME'
      Origin = '"DEPARTUREWORKS"."WORK_TIME"'
      Precision = 18
      Size = 2
    end
    object dset_WorkFK_DEPWORKS_BWORK: TIntegerField
      FieldName = 'FK_DEPWORKS_BWORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_BWORK"'
    end
    object dset_WorkFK_DEPWORKS_DEPBWORK: TIntegerField
      FieldName = 'FK_DEPWORKS_DEPBWORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_DEPBWORK"'
    end
    object dset_WorkADDITIONALINFO: TIBStringField
      FieldName = 'ADDITIONALINFO'
      Origin = '"DEPARTUREWORKS"."ADDITIONALINFO"'
      Size = 40
    end
    object dset_WorkMEASUR_QUANTITY: TIBBCDField
      FieldName = 'MEASUR_QUANTITY'
      Origin = '"DEPARTUREWORKS"."MEASUR_QUANTITY"'
      Precision = 9
      Size = 2
    end
    object dset_WorkEXC_DEPTH: TIBBCDField
      FieldName = 'EXC_DEPTH'
      Origin = '"DEPARTUREWORKS"."EXC_DEPTH"'
      Precision = 9
      Size = 2
    end
    object dset_WorkEXC_WIDTH: TIBBCDField
      FieldName = 'EXC_WIDTH'
      Origin = '"DEPARTUREWORKS"."EXC_WIDTH"'
      Precision = 9
      Size = 2
    end
    object dset_WorkEXC_LENGTH: TIBBCDField
      FieldName = 'EXC_LENGTH'
      Origin = '"DEPARTUREWORKS"."EXC_LENGTH"'
      Precision = 9
      Size = 2
    end
    object dset_WorkFK_DEPWORKS_OFFICPOST_INS: TIntegerField
      FieldName = 'FK_DEPWORKS_OFFICPOST_INS'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_OFFICPOST_INS"'
    end
    object dset_WorklpWORK: TStringField
      FieldKind = fkLookup
      FieldName = 'lpWORK'
      LookupDataSet = mt_Works
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPWORKS_WORK'
      Size = 50
      Lookup = True
    end
    object dset_WorklpMEASUREMENT: TStringField
      FieldKind = fkLookup
      FieldName = 'lpMEASUREMENT'
      LookupDataSet = mt_Works
      LookupKeyFields = 'id'
      LookupResultField = 'measurement'
      KeyFields = 'FK_DEPWORKS_WORK'
      Lookup = True
    end
    object dset_WorklpDIAM: TIntegerField
      FieldKind = fkLookup
      FieldName = 'lpDIAM'
      LookupDataSet = mt_Diam
      LookupKeyFields = 'id'
      LookupResultField = 'diameter'
      KeyFields = 'FK_DEPWORKS_DIAMETER'
      OnGetText = dset_WorklpDIAMGetText
      Lookup = True
    end
    object dset_WorkclcWORKTIME: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clcWORKTIME'
      Calculated = True
    end
    object dset_WorkclcWT_INFO: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcWT_INFO'
      Size = 50
      Calculated = True
    end
    object dset_WorkclcFULL_WORKTIME: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clcFULL_WORKTIME'
      Calculated = True
    end
    object dset_WorkclcMEASUR_QUANTITY: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clcMEASUR_QUANTITY'
      Calculated = True
    end
    object dset_WorkclcWORK: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcWORK'
      Size = 70
      Calculated = True
    end
    object dset_Workclc_IS_CAN_EDIT: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'clc_IS_CAN_EDIT'
      Calculated = True
    end
    object dset_WorkNUM_WORK: TIntegerField
      FieldName = 'NUM_WORK'
      Origin = '"DEPARTUREWORKS"."NUM_WORK"'
    end
    object dset_WorkSQUARE_ASF: TIBBCDField
      FieldName = 'SQUARE_ASF'
      Origin = '"DEPARTUREWORKS"."SQUARE_ASF"'
      Precision = 9
      Size = 2
    end
    object dset_WorkSENT_1562: TSmallintField
      FieldName = 'SENT_1562'
      Origin = '"DEPARTUREWORKS"."SENT_1562"'
    end
    object dset_Workboolsent_1562: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'boolsent_1562'
      Calculated = True
    end
    object dset_WorkFACT_DATETIME: TDateTimeField
      FieldName = 'FACT_DATETIME'
      Origin = '"DEPARTUREWORKS"."FACT_DATETIME"'
    end
  end
  object mt_Works: TkbmMemTable
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
      end
      item
        Name = 'for_plan'
        DataType = ftInteger
      end>
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = 'For_Plan=null'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 144
    Top = 64
  end
  object mt_Diam: TkbmMemTable
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
    Left = 144
    Top = 120
  end
  object sql_InsertWorks: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'insert into  departureworks('
      'FK_DEPWORKS_ORDER,'
      'FK_DEPWORKS_DEPARTURE,'
      'FK_DEPWORKS_BWORK,'
      'FK_DEPWORKS_WORK,'
      'FK_DEPWORKS_DIAMETER,'
      'WORK_TIME,'
      'FK_DEPWORKS_DEPBWORK,'
      'FK_DEPWORKS_OFFICPOST_INS,'
      'Sent_1562)'
      'values('
      ':pOrderID,'
      ':pDepID,'
      ':pBWorkID,'
      ':pWorkID,'
      ':pDiamID,'
      ':pWorkTime,'
      ':pDepBWorkID,'
      ':pOfficPostInsID,'
      ':pSent_1562)')
    Transaction = tran
    Left = 144
    Top = 176
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 472
    Top = 152
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 472
    Top = 88
  end
  object md_FastAdd: TRxMemoryData
    FieldDefs = <>
    Left = 472
    Top = 288
    object md_FastAddBWork: TStringField
      FieldName = 'BWork'
      Size = 50
    end
    object md_FastAddid_bwork: TIntegerField
      FieldName = 'id_bwork'
    end
    object md_FastAddis_add_work: TBooleanField
      FieldName = 'is_add_work'
    end
    object md_FastAddis_add_mater: TBooleanField
      FieldName = 'is_add_mater'
    end
    object md_FastAddis_add_bwork: TBooleanField
      FieldName = 'is_add_bwork'
      OnChange = md_FastAddis_add_bworkChange
    end
  end
  object dset_Mater: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = dset_MaterAfterInsert
    DeleteSQL.Strings = (
      'delete from departurematers where id = :old_id')
    InsertSQL.Strings = (
      'insert into departurematers('
      'ID,'
      'FK_DEPMATERS_ORDER,'
      'FK_DEPMATERS_DEPARTURE,'
      'FK_DEPMATERS_DEPBWORK,'
      'FK_DEPMATERS_MATER,'
      'FK_DEPMATERS_DIAMETER,'
      'FK_DEPMATERS_BWORK,'
      'QUANTITY)'
      'values('
      ':ID,'
      ':FK_DEPMATERS_ORDER,'
      ':FK_DEPMATERS_DEPARTURE,'
      ':FK_DEPMATERS_DEPBWORK,'
      ':FK_DEPMATERS_MATER,'
      ':FK_DEPMATERS_DIAMETER,'
      ':FK_DEPMATERS_BWORK,'
      ':QUANTITY)')
    RefreshSQL.Strings = (
      'select'
      '    dm.ID,'
      '    dm.FK_DEPMATERS_ORDER,'
      '    dm.FK_DEPMATERS_DEPARTURE,'
      '    dm.FK_DEPMATERS_DEPBWORK,'
      '    dm.FK_DEPMATERS_MATER,'
      '    dm.FK_DEPMATERS_DIAMETER,'
      '    dm.FK_DEPMATERS_BWORK,'
      '    dm.QUANTITY'
      'from departurematers dm'
      'left join materials m on m.id = dm.fk_depmaters_mater'
      'left join s_tubediameter d on d.id = dm.fk_depmaters_diameter'
      'where dm.ID = :ID')
    SelectSQL.Strings = (
      'select'
      '    dm.ID,'
      '    dm.FK_DEPMATERS_ORDER,'
      '    dm.FK_DEPMATERS_DEPARTURE,'
      '    dm.FK_DEPMATERS_DEPBWORK,'
      '    dm.FK_DEPMATERS_MATER,'
      '    dm.FK_DEPMATERS_DIAMETER,'
      '    dm.FK_DEPMATERS_BWORK,'
      '    dm.QUANTITY'
      'from departurematers dm'
      'left join materials m on m.id = dm.fk_depmaters_mater'
      'left join s_tubediameter d on d.id = dm.fk_depmaters_diameter'
      'where ( dm.FK_DEPMATERS_ORDER = :pOrderID )'
      'and ( dm.FK_DEPMATERS_DEPARTURE = :pDepID )'
      'order by m.name, d.diameter')
    ModifySQL.Strings = (
      'update departurematers set'
      'FK_DEPMATERS_DEPBWORK = :FK_DEPMATERS_DEPBWORK,'
      'FK_DEPMATERS_MATER = :FK_DEPMATERS_MATER,'
      'FK_DEPMATERS_DIAMETER = :FK_DEPMATERS_DIAMETER,'
      'FK_DEPMATERS_BWORK = :FK_DEPMATERS_BWORK,'
      'QUANTITY = :QUANTITY'
      'where ID = :ID')
    Filtered = True
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTUREMATERS_ID'
    OnFilterRecord = dset_MaterFilterRecord
    Left = 288
    Top = 8
    object dset_MaterID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREMATERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MaterFK_DEPMATERS_ORDER: TIntegerField
      FieldName = 'FK_DEPMATERS_ORDER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_ORDER"'
      Required = True
    end
    object dset_MaterFK_DEPMATERS_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPMATERS_DEPARTURE'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_DEPARTURE"'
      Required = True
    end
    object dset_MaterFK_DEPMATERS_DEPBWORK: TIntegerField
      FieldName = 'FK_DEPMATERS_DEPBWORK'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_DEPBWORK"'
    end
    object dset_MaterFK_DEPMATERS_MATER: TIntegerField
      FieldName = 'FK_DEPMATERS_MATER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_MATER"'
      Required = True
    end
    object dset_MaterFK_DEPMATERS_DIAMETER: TIntegerField
      FieldName = 'FK_DEPMATERS_DIAMETER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_DIAMETER"'
    end
    object dset_MaterFK_DEPMATERS_BWORK: TIntegerField
      FieldName = 'FK_DEPMATERS_BWORK'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_BWORK"'
    end
    object dset_MaterQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREMATERS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MaterlpMater: TStringField
      FieldKind = fkLookup
      FieldName = 'lpMater'
      LookupDataSet = mt_Maters
      LookupKeyFields = 'id'
      LookupResultField = 'full_name'
      KeyFields = 'FK_DEPMATERS_MATER'
      Size = 50
      Lookup = True
    end
    object dset_MaterlpDiam: TIntegerField
      FieldKind = fkLookup
      FieldName = 'lpDiam'
      LookupDataSet = mt_Diam
      LookupKeyFields = 'id'
      LookupResultField = 'diameter'
      KeyFields = 'FK_DEPMATERS_DIAMETER'
      OnGetText = dset_MaterlpDiamGetText
      Lookup = True
    end
  end
  object mt_Maters: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_materials
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
    Left = 288
    Top = 72
  end
  object sql_InsertMaters: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'insert into departurematers('
      'FK_DEPMATERS_ORDER,'
      'FK_DEPMATERS_DEPARTURE,'
      'FK_DEPMATERS_DEPBWORK,'
      'FK_DEPMATERS_MATER,'
      'FK_DEPMATERS_DIAMETER,'
      'FK_DEPMATERS_BWORK'
      ')'
      'values('
      ':pOrderID,'
      ':pDepID,'
      ':pDepBWorkID,'
      ':pMaterID,'
      ':pDiamID,'
      ':pBWorkID)')
    Transaction = tran
    Left = 288
    Top = 128
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
    Left = 56
    Top = 272
  end
end
