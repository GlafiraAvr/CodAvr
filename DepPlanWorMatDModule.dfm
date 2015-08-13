object dm_DepPlanWorMat: Tdm_DepPlanWorMat
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 981
  Top = 442
  Height = 290
  Width = 299
  object dset_works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = dset_worksAfterInsert
    BeforePost = dset_worksBeforePost
    OnCalcFields = dset_worksCalcFields
    DeleteSQL.Strings = (
      'delete from PLAN_DEP_WORKS where id=:id')
    InsertSQL.Strings = (
      'insert into PLAN_DEP_WORKS('
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
      'fact_Datetime)'
      'values('
      ':ID,'
      ':FK_DEPWORKS_DEPARTURE,'
      ':FK_DEPWORKS_ORDER,'
      ':FK_DEPWORKS_WORK,'
      ':FK_DEPWORKS_BWORK,'
      ':IDDIAM,'
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
      ':fact_Datetime)'
      '')
    RefreshSQL.Strings = (
      'select dw.ID,'
      '    dw.FK_DEPWORKS_DEPARTURE ,'
      '    dw.FK_DEPWORKS_ORDER,'
      '    dw.FK_DEPWORKS_WORK,'
      '    dw.FK_DEPWORKS_DIAMETER IDDIAM,'
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
      'dw.Fact_Datetime,'
      'sw.name workname,sd.diameter diam'
      'from PLAN_DEP_WORKS dw'
      'left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK'
      'left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER'
      'where'
      '    (dw.FK_DEPWORKS_ORDER = :pOrderID ) and'
      '    (dw.FK_DEPWORKS_DEPARTURE = :pDepID)'
      'order by dw.NUM_WORK, sw.NAME, sd.DIAMETER')
    SelectSQL.Strings = (
      'select dw.ID,'
      '    dw.FK_DEPWORKS_DEPARTURE ,'
      '    dw.FK_DEPWORKS_ORDER,'
      '    dw.FK_DEPWORKS_WORK,'
      '    dw.FK_DEPWORKS_DIAMETER IDDIAM,'
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
      '  dw.FK_DEPWORKS_DIAMETER ,'
      'dw.Fact_Datetime,'
      'sw.name workname,sd.diameter diam'
      'from PLAN_DEP_WORKS dw'
      'left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK'
      'left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER'
      'where'
      '    (dw.FK_DEPWORKS_ORDER = :pOrderID ) and'
      '    (dw.FK_DEPWORKS_DEPARTURE = :pDepID)'
      'order by dw.NUM_WORK, sw.NAME, sd.DIAMETER'
      '')
    ModifySQL.Strings = (
      'update PLAN_DEP_WORKS set'
      'FK_DEPWORKS_BWORK = :FK_DEPWORKS_BWORK,'
      'FK_DEPWORKS_WORK = :FK_DEPWORKS_WORK,'
      'FK_DEPWORKS_DIAMETER = :IDDIAM,'
      'QUANTITY = :QUANTITY,'
      'WORK_TIME = :WORK_TIME,'
      'ADDITIONALINFO = :ADDITIONALINFO,'
      'MEASUR_QUANTITY = :MEASUR_QUANTITY,'
      'EXC_DEPTH = :EXC_DEPTH,'
      'EXC_WIDTH = :EXC_WIDTH,'
      'EXC_LENGTH = :EXC_LENGTH,'
      'NUM_WORK = :NUM_WORK,'
      'SQUARE_ASF = :SQUARE_ASF'
      'where ID = :ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_PLAN_DEP_WORKS_VDS_ID'
    Left = 40
    Top = 16
    object dset_worksID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREWORKS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_worksFK_DEPWORKS_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPWORKS_DEPARTURE'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_DEPARTURE"'
      Required = True
    end
    object dset_worksFK_DEPWORKS_ORDER: TIntegerField
      FieldName = 'FK_DEPWORKS_ORDER'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_ORDER"'
      Required = True
    end
    object dset_worksFK_DEPWORKS_WORK: TIntegerField
      FieldName = 'FK_DEPWORKS_WORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_WORK"'
      Required = True
    end
    object dset_worksQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREWORKS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_worksWORK_TIME: TIBBCDField
      FieldName = 'WORK_TIME'
      Origin = '"DEPARTUREWORKS"."WORK_TIME"'
      Precision = 18
      Size = 2
    end
    object dset_worksFK_DEPWORKS_BWORK: TIntegerField
      FieldName = 'FK_DEPWORKS_BWORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_BWORK"'
    end
    object dset_worksFK_DEPWORKS_DEPBWORK: TIntegerField
      FieldName = 'FK_DEPWORKS_DEPBWORK'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_DEPBWORK"'
    end
    object dset_worksADDITIONALINFO: TIBStringField
      FieldName = 'ADDITIONALINFO'
      Origin = '"DEPARTUREWORKS"."ADDITIONALINFO"'
      Size = 40
    end
    object dset_worksMEASUR_QUANTITY: TIBBCDField
      FieldName = 'MEASUR_QUANTITY'
      Origin = '"DEPARTUREWORKS"."MEASUR_QUANTITY"'
      Precision = 9
      Size = 2
    end
    object dset_worksEXC_DEPTH: TIBBCDField
      FieldName = 'EXC_DEPTH'
      Origin = '"DEPARTUREWORKS"."EXC_DEPTH"'
      Precision = 9
      Size = 2
    end
    object dset_worksEXC_WIDTH: TIBBCDField
      FieldName = 'EXC_WIDTH'
      Origin = '"DEPARTUREWORKS"."EXC_WIDTH"'
      Precision = 9
      Size = 2
    end
    object dset_worksEXC_LENGTH: TIBBCDField
      FieldName = 'EXC_LENGTH'
      Origin = '"DEPARTUREWORKS"."EXC_LENGTH"'
      Precision = 9
      Size = 2
    end
    object dset_worksFK_DEPWORKS_OFFICPOST_INS: TIntegerField
      FieldName = 'FK_DEPWORKS_OFFICPOST_INS'
      Origin = '"DEPARTUREWORKS"."FK_DEPWORKS_OFFICPOST_INS"'
    end
    object dset_worksNUM_WORK: TSmallintField
      FieldName = 'NUM_WORK'
      Origin = '"DEPARTUREWORKS"."NUM_WORK"'
    end
    object dset_worksSQUARE_ASF: TIBBCDField
      FieldName = 'SQUARE_ASF'
      Origin = '"DEPARTUREWORKS"."SQUARE_ASF"'
      Precision = 9
      Size = 2
    end
    object dset_worksFACT_DATETIME: TDateTimeField
      FieldName = 'FACT_DATETIME'
      Origin = '"DEPARTUREWORKS"."FACT_DATETIME"'
    end
    object dset_worksclc_WorkTime: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clc_WorkTime'
      Calculated = True
    end
    object dset_worksclc_Measur_Quamtity: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clc_Measur_Quamtity'
      Calculated = True
    end
    object dset_worksclcWT_INFO: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcWT_INFO'
      Size = 50
      Calculated = True
    end
    object dset_worksipWork: TStringField
      FieldKind = fkLookup
      FieldName = 'ipWork'
      LookupDataSet = mt_works
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPWORKS_WORK'
      Size = 100
      Lookup = True
    end
    object dset_worksipDiam: TStringField
      FieldKind = fkLookup
      FieldName = 'ipDiam'
      LookupDataSet = mt_diametr
      LookupKeyFields = 'id'
      LookupResultField = 'diameter'
      KeyFields = 'FK_DEPWORKS_DIAMETER'
      Lookup = True
    end
    object dset_worksWORKNAME: TIBStringField
      FieldName = 'WORKNAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 50
    end
    object dset_worksDIAM: TIntegerField
      FieldName = 'DIAM'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
    end
    object dset_worksIDDIAM: TIntegerField
      FieldName = 'IDDIAM'
      Origin = '"PLAN_DEP_WORKS"."FK_DEPWORKS_DIAMETER"'
    end
    object dset_worksFK_DEPWORKS_DIAMETER: TIntegerField
      FieldName = 'FK_DEPWORKS_DIAMETER'
    end
    object dset_worksclcWorkTime: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clcWorkTime'
      Calculated = True
    end
    object dset_worksclcMEASUR_QUNTITy: TFloatField
      FieldKind = fkCalculated
      FieldName = 'clcMEASUR_QUANTITY'
      Calculated = True
    end
    object dset_worksclcWork: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcWork'
      Size = 50
      Calculated = True
    end
  end
  object dset_maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterInsert = dset_matersAfterInsert
    DeleteSQL.Strings = (
      'delete from depPlanMaters where id=:id')
    InsertSQL.Strings = (
      'insert into depPlanMaters'
      '(id, fk_departure,'
      ' fk_order,'
      ' fk_mater,'
      ' fk_diameter,'
      ' quantity )'
      'values (:id,'
      ':fk_departure,'
      ':fk_order,'
      ':fk_mater,'
      ':fk_diameter,'
      ':quantity )')
    RefreshSQL.Strings = (
      
        'select pm.id, pm.fk_departure, pm.fk_order, pm.fk_mater, pm.fk_d' +
        'iameter, pm.quantity,'
      ' m.name MaterName, d.diameter dia'
      'from depPlanMaters pm left  join MATERIALS m on pm.fk_mater=m.id'
      'left join s_tubediameter d on d.id=pm.fk_diameter'
      'where pm.fk_departure=:pDepID and pm.fk_order=:pOrderID')
    SelectSQL.Strings = (
      
        'select pm.id, pm.fk_departure, pm.fk_order, pm.fk_mater, pm.fk_d' +
        'iameter, pm.quantity,'
      ' m.name MaterName, d.diameter diam'
      'from depPlanMaters pm left  join MATERIALS m on pm.fk_mater=m.id'
      'left join s_tubediameter d on d.id=pm.fk_diameter'
      'where pm.fk_departure=:pDepID and pm.fk_order=:pOrderID')
    ModifySQL.Strings = (
      'update depPlanMaters'
      'set'
      'fk_departure=:fk_Departure,'
      'fk_order=:fk_order,'
      'fk_mater=:fk_mater,'
      'fk_diameter=:fk_diamete,'
      ' quantity=:quantity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPPLANMATERS_VDS_ID'
    Left = 136
    Top = 16
    object dset_matersID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPPLANMATERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_matersFK_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPARTURE'
      Origin = '"DEPPLANMATERS"."FK_DEPARTURE"'
      Required = True
    end
    object dset_matersFK_ORDER: TIntegerField
      FieldName = 'FK_ORDER'
      Origin = '"DEPPLANMATERS"."FK_ORDER"'
      Required = True
    end
    object dset_matersFK_MATER: TIntegerField
      FieldName = 'FK_MATER'
      Origin = '"DEPPLANMATERS"."FK_MATER"'
      Required = True
    end
    object dset_matersFK_DIAMETER: TIntegerField
      FieldName = 'FK_DIAMETER'
      Origin = '"DEPPLANMATERS"."FK_DIAMETER"'
    end
    object dset_matersQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPPLANMATERS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_matersMATERNAME: TIBStringField
      FieldName = 'MATERNAME'
      Origin = '"MATERIALS"."NAME"'
      FixedChar = True
      Size = 32
    end
    object dset_matersDIAM: TIntegerField
      FieldName = 'DIAM'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 40
    Top = 88
  end
  object mt_works: TkbmMemTable
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
    Filter = 'for_plan=1'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 40
    Top = 200
  end
  object mt_maters: TkbmMemTable
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
    Left = 128
    Top = 200
  end
  object mt_diametr: TkbmMemTable
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
    Left = 208
    Top = 200
  end
end
