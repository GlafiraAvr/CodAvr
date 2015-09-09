object dm_NGDep: Tdm_NGDep
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 602
  Top = 267
  Height = 562
  Width = 463
  object tran: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 48
    Top = 16
  end
  object dset_Dep: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterCancel = dset_DepAfterCancel
    AfterDelete = dset_DepAfterDelete
    AfterEdit = dset_DepAfterEdit
    AfterInsert = dset_DepAfterInsert
    AfterOpen = dset_DepAfterOpen
    AfterPost = dset_DepAfterPost
    BeforeDelete = dset_DepBeforeDelete
    BeforeInsert = dset_DepBeforeInsert
    BeforePost = dset_DepBeforePost
    OnCalcFields = dset_DepCalcFields
    DeleteSQL.Strings = (
      'delete from departures where id=:old_id')
    InsertSQL.Strings = (
      'insert into departures(StartDate, EndDate,'
      'fk_departures_Brigadiers, fk_departures_OfficialsOpen,'
      'fk_departures_OfficialsClose, fk_departures_orders, DepNumber,'
      'Additionalinfo, fk_departures_officpost_ins,'
      'PLANSTARTDATE, PLANENDDATE, fk_departures_equipment, '
      'fk_departures_officialsplan,empting,plan_people,'
      'fk_Deparure_id_street,'
      'fk_Deparure_HOUSETYPES,'
      'housenum,'
      ''
      'ADDAdres,'
      'fk_Departure_Regions,'
      'fk_departures_DamageLocality,'
      ' FK_DIAMETER,'
      'PLANDATEREGL,'
      'fk_departures_region_brig,'
      'excav_close_info,'
      'date_close_info,'
      'CapRep_ClosedInfo,'
      'CapRem_Date'
      ''
      ')'
      'values(:StartDate, :EndDate,'
      ':fk_departures_Brigadiers, :fk_departures_OfficialsOpen,'
      
        ':fk_departures_OfficialsClose, :fk_departures_orders, :DepNumber' +
        ','
      ':Additionalinfo, :fk_departures_officpost_ins,'
      ':PLANSTARTDATE,:PLANENDDATE ,  :fk_departures_equipment,'
      ' :fk_departures_officialsplan,:empting,:plan_people,'
      ':fk_Deparure_id_street,'
      ':fk_Deparure_HOUSETYPES,'
      ':housenum,'
      ':ADDAdres,'
      ':fk_Departure_Regions,'
      ':fk_departures_DamageLocality,'
      ':FK_DIAMETER,'
      ':PLANDATEREGL,'
      ':fk_departures_region_brig,'
      ':excav_close_info,'
      ':date_close_info,'
      ':CapRep_ClosedInfo,'
      ':CapRem_Date'
      ''
      ''
      ''
      ')')
    RefreshSQL.Strings = (
      
        'select d.id id, d.StartDate, d.EndDate, d.fk_departures_Brigadie' +
        'rs,'
      'd.fk_departures_OfficialsOpen, d.fk_departures_OfficialsClose,'
      'd.fk_departures_orders, d.DepNumber, d.Additionalinfo,'
      'd.fk_departures_officpost_ins,'
      'd.PLANSTARTDATE , '
      'd.PLANENDDATE, '
      'd.fk_departures_equipment,'
      
        'd.FK_DEPARTURES_OFFICIALSPLAN, EMPTING,plan_people, FK_DEPARURE_' +
        'ID_STREET,'
      'fk_Deparure_HOUSETYPES,'
      ''
      'housenum,'
      'ADDAdres,'
      'fk_Departure_Regions,'
      'fk_departures_DamageLocality fk_ID_DAMAGELOCALITY,'
      ' fk_departures_DamageLocality,'
      ' FK_DIAMETER,'
      ' PLANDATEREGL,'
      'fk_departures_region_brig,'
      'date_close_info,'
      'excav_close_info,'
      'date_close_info'
      'from Departures d'
      'where fk_departures_orders=:pOrderID'
      'order by  1,2,d.DepNumber')
    SelectSQL.Strings = (
      
        'select d.id id, d.StartDate, d.EndDate, d.fk_departures_Brigadie' +
        'rs,'
      'd.fk_departures_OfficialsOpen, d.fk_departures_OfficialsClose,'
      'd.fk_departures_orders, d.DepNumber, d.Additionalinfo,'
      'd.fk_departures_officpost_ins,'
      'd.PLANSTARTDATE , '
      'd.PLANENDDATE, '
      'd.fk_departures_equipment,'
      
        'd.FK_DEPARTURES_OFFICIALSPLAN, EMPTING,plan_people, FK_DEPARURE_' +
        'ID_STREET,'
      'fk_Deparure_HOUSETYPES,'
      ''
      'housenum,'
      'ADDAdres,'
      'fk_Departure_Regions,'
      'fk_departures_DamageLocality fk_ID_DAMAGELOCALITY,'
      ' fk_departures_DamageLocality,'
      ' FK_DIAMETER,'
      ' PLANDATEREGL,'
      'fk_departures_region_brig,'
      'excav_close_info,'
      'date_close_info,'
      'CapRep_ClosedInfo,'
      ''
      'CapRem_Date'
      ''
      ''
      'from Departures d'
      'where fk_departures_orders=:pOrderID'
      ''
      'order by  1,2,d.DepNumber')
    ModifySQL.Strings = (
      'update departures set'
      'StartDate = :StartDate,'
      'EndDate = :EndDate,'
      'fk_departures_Brigadiers = :fk_departures_Brigadiers,'
      'fk_departures_OfficialsOpen = :fk_departures_OfficialsOpen,'
      'fk_departures_OfficialsClose = :fk_departures_OfficialsClose,'
      'DepNumber = :DepNumber,'
      'Additionalinfo = :Additionalinfo,'
      'PLANSTARTDATE =:PLANSTARTDATE , '
      'PLANENDDATE =:PLANENDDATE , '
      'fk_departures_equipment =:fk_departures_equipment,'
      'FK_DEPARTURES_OFFICIALSPLAN =:fk_departures_officialsplan,'
      'empting=:empting,'
      'plan_people=:plan_people,'
      'fk_Deparure_id_street=:fk_Deparure_id_street,'
      'fk_Deparure_HOUSETYPES=:fk_Deparure_HOUSETYPES,'
      'ADDAdres=:ADDAdres,'
      'fk_Departure_Regions=:fk_Departure_Regions,'
      'fk_departures_DamageLocality=:fk_departures_DamageLocality,'
      'housenum=:housenum,'
      'FK_DIAMETER=:FK_DIAMETER,'
      'PLANDATEREGL=:PLANDATEREGL,'
      'fk_departures_region_brig=:fk_departures_region_brig,'
      'excav_close_info=:excav_close_info,'
      'date_close_info=:date_close_info,'
      'CapRep_ClosedInfo =:CapRep_ClosedInfo,'
      'CapRem_Date = :CapRem_Date'
      ''
      ''
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTURES'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 40
    Top = 88
    object dset_DepID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTURES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_DepSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = '"DEPARTURES"."STARTDATE"'
      OnChange = dset_DepSTARTDATEChange
    end
    object dset_DepENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
      Origin = '"DEPARTURES"."ENDDATE"'
      OnChange = dset_DepENDDATEChange
    end
    object dset_DepFK_DEPARTURES_BRIGADIERS: TIntegerField
      FieldName = 'FK_DEPARTURES_BRIGADIERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_BRIGADIERS"'
      OnChange = InputDepFieldChange
    end
    object dset_DepFK_DEPARTURES_OFFICIALSOPEN: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSOPEN'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSOPEN"'
    end
    object dset_DepFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSCLOSE'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSCLOSE"'
    end
    object dset_DepFK_DEPARTURES_ORDERS: TIntegerField
      FieldName = 'FK_DEPARTURES_ORDERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_ORDERS"'
    end
    object dset_DepADDITIONALINFO: TIBStringField
      FieldName = 'ADDITIONALINFO'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICPOST_INS"'
      Size = 1000
    end
    object dset_DepFK_DEPARTURES_OFFICPOST_INS: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICPOST_INS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICPOST_INS"'
    end
    object dset_Deplp_Brig: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_Brig'
      LookupDataSet = mem_BrigAtt
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPARTURES_BRIGADIERS'
      Size = 50
      Lookup = True
    end
    object dset_Deplp_DispOpen: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_DispOpen'
      LookupDataSet = mem_DispOpenAtt
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPARTURES_OFFICIALSOPEN'
      Size = 64
      Lookup = True
    end
    object dset_DepDEPNUMBER: TSmallintField
      FieldName = 'DEPNUMBER'
      Origin = '"DEPARTURES"."DEPNUMBER"'
    end
    object dset_Deplp_DispClose: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_DispClose'
      LookupDataSet = mem_DispCloseAtt
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPARTURES_OFFICIALSCLOSE'
      Size = 64
      Lookup = True
    end
    object dset_Depclc_IsCanEdit: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'clc_IsCanEdit'
      Calculated = True
    end
    object dset_Depclc_IsCanDel: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'clc_IsCanDel'
      Calculated = True
    end
    object dset_Depclc_RecInfo: TStringField
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'clc_RecInfo'
      Size = 50
      Calculated = True
    end
    object dset_DepPLANSTARTDATE: TDateTimeField
      FieldName = 'PLANSTARTDATE'
      Origin = '"DEPARTURES"."PLANSTARTDATE"'
      OnChange = dset_DepPLANSTARTDATEChange
    end
    object dset_DepPLANENDDATE: TDateTimeField
      FieldName = 'PLANENDDATE'
      Origin = '"DEPARTURES"."PLANENDDATE"'
      OnChange = dset_DepPLANSTARTDATEChange
    end
    object dset_DepFK_DEPARTURES_EQUIPMENT: TIntegerField
      FieldName = 'FK_DEPARTURES_EQUIPMENT'
      Origin = '"DEPARTURES"."FK_DEPARTURES_EQUIPMENT"'
    end
    object dset_DepFK_DEPARTURES_OFFICIALSPLAN: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSPLAN'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSPLAN"'
    end
    object dset_Deplp_DispPlan: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_DispPlan'
      LookupDataSet = mem_DispPlanAtt
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'FK_DEPARTURES_OFFICIALSPLAN'
      Lookup = True
    end
    object dset_DepEMPTING: TFloatField
      FieldName = 'EMPTING'
      Origin = '"DEPARTURES"."EMPTING"'
    end
    object dset_DepPLAN_PEOPLE: TIntegerField
      FieldName = 'PLAN_PEOPLE'
      Origin = '"DEPARTURES"."PLAN_PEOPLE"'
    end
    object dset_DepFK_DEPARURE_ID_STREET: TIntegerField
      FieldName = 'FK_DEPARURE_ID_STREET'
      Origin = '"DEPARTURES"."FK_DEPARURE_ID_STREET"'
    end
    object dset_DepFK_DEPARURE_HOUSETYPES: TIntegerField
      FieldName = 'FK_DEPARURE_HOUSETYPES'
      Origin = '"DEPARTURES"."FK_DEPARURE_HOUSETYPES"'
    end
    object dset_DepADDADRES: TIBStringField
      FieldName = 'ADDADRES'
      Origin = '"DEPARTURES"."ADDADRES"'
      Size = 64
    end
    object dset_DepFK_DEPARTURE_REGIONS: TIntegerField
      FieldName = 'FK_DEPARTURE_REGIONS'
      Origin = '"DEPARTURES"."FK_DEPARTURE_REGIONS"'
    end
    object dset_Depfk_ID_DAMAGELOCALITY: TIntegerField
      FieldName = 'fk_ID_DAMAGELOCALITY'
    end
    object dset_Depfk_departures_DamageLocality: TIntegerField
      FieldName = 'fk_departures_DamageLocality'
    end
    object dset_Dephousenum: TStringField
      FieldName = 'housenum'
    end
    object dset_DepFK_DIAMETER: TIntegerField
      FieldName = 'FK_DIAMETER'
      Origin = '"DEPARTURES"."FK_DIAMETER"'
    end
    object dset_DepPLANDATEREGL: TDateTimeField
      FieldName = 'PLANDATEREGL'
      Origin = '"DEPARTURES"."PLANDATEREGL"'
    end
    object dset_DepFK_DEPARTURES_REGION_BRIG: TIntegerField
      FieldName = 'FK_DEPARTURES_REGION_BRIG'
      Origin = '"DEPARTURES"."FK_DEPARTURES_REGION_BRIG"'
    end
    object dset_DepEXCAV_CLOSE_INFO: TIBStringField
      FieldName = 'EXCAV_CLOSE_INFO'
      Origin = '"DEPARTURES"."EXCAV_CLOSE_INFO"'
      Size = 500
    end
    object dset_DepDATE_CLOSE_INFO: TDateTimeField
      FieldName = 'DATE_CLOSE_INFO'
      Origin = '"DEPARTURES"."DATE_CLOSE_INFO"'
    end
    object dset_DepCAPREP_CLOSEDINFO: TIBStringField
      FieldName = 'CAPREP_CLOSEDINFO'
      Origin = '"DEPARTURES"."CAPREP_CLOSEDINFO"'
      Size = 500
    end
    object dset_DepCAPREM_DATE: TDateTimeField
      FieldName = 'CAPREM_DATE'
      Origin = '"DEPARTURES"."CAPREM_DATE"'
    end
  end
  object dset_RebuildDepNum: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, DepNumber'
      'from Departures'
      'where ( fk_departures_orders=:pOrderID ) and'
      '( (DepNumber <> 1) or (DepNumber is null) )'
      'order by StartDate asc, id asc')
    ModifySQL.Strings = (
      'update departures set'
      'DepNumber = :DepNumber'
      'where id = :id')
    Left = 160
    Top = 16
    object dset_RebuildDepNumID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTURES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_RebuildDepNumDEPNUMBER: TSmallintField
      FieldName = 'DEPNUMBER'
      Origin = '"DEPARTURES"."DEPNUMBER"'
    end
  end
  object mem_BrigAtt: TkbmMemTable
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
    OnFilterRecord = mem_BrigAttFilterRecord
    Left = 48
    Top = 152
  end
  object mem_DispOpenAtt: TkbmMemTable
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
    Left = 48
    Top = 208
  end
  object mem_DispCloseAtt: TkbmMemTable
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
    Left = 48
    Top = 264
  end
  object tran_tmp: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 304
    Top = 144
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_tmp
    Left = 304
    Top = 200
  end
  object mem_MessagetypesAtt: TkbmMemTable
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
      end
      item
        Name = 'activity'
        DataType = ftSmallint
      end>
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = True
    SavedCompletely = False
    Filter = 'S_MT_CATEGORY_ID=4'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    OnFilterRecord = mem_MessagetypesAttFilterRecord
    Left = 144
    Top = 152
    object mem_MessagetypesAttid: TIntegerField
      FieldName = 'id'
    end
    object mem_MessagetypesAttmessagename: TStringField
      FieldName = 'name'
      Size = 50
    end
    object mem_MessagetypesAttS_MT_CATEGORY_ID: TSmallintField
      FieldName = 'S_MT_CATEGORY_ID'
    end
  end
  object mem_EquipmentAtt: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_Equipment
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
    Left = 144
    Top = 88
  end
  object mem_DispPlanAtt: TkbmMemTable
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
    Left = 48
    Top = 320
  end
  object ds_exectmp: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_tmp
    Left = 296
    Top = 256
  end
  object mem_LookupEquip: TkbmMemTable
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
    Left = 232
    Top = 120
    object mem_LookupEquipid: TIntegerField
      FieldName = 'id'
    end
    object mem_LookupEquipsnumber: TStringField
      FieldName = 'snumber'
      Size = 40
    end
  end
  object mem_streets: TkbmMemTable
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
    Left = 144
    Top = 216
  end
  object dset_adress: TIBDataSet
    Left = 240
    Top = 328
  end
  object mem_street_2: TkbmMemTable
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
    Left = 232
    Top = 208
  end
  object mem_Region: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_S_all_regions
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
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = '(id>0) and (id<10)'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 312
    Top = 56
  end
  object dset_locality: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      ' select sd.id, sd.name, sd.activity '
      ' from s_damagelocality sd '
      ' where id<>4')
    Left = 136
    Top = 272
    object dset_localityID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_DAMAGELOCALITY"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_localityNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_DAMAGELOCALITY"."NAME"'
      FixedChar = True
      Size = 64
    end
    object dset_localityACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"S_DAMAGELOCALITY"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
  end
  object mem_diameter: TkbmMemTable
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
    Left = 136
    Top = 320
  end
  object mem_region_brig: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_S_all_regions
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
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = '(id>0) and (id<10)'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 312
    Top = 312
  end
  object tran_closwedCapRem: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 40
    Top = 392
  end
  object IBSQLClosedCaprem: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_closwedCapRem
    Left = 168
    Top = 392
  end
end
