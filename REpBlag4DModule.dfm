inherited dm_RepBlag4: Tdm_RepBlag4
  Left = 532
  Top = 311
  Height = 324
  Width = 345
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    Left = 32
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
      end
      item
        Name = 'confirm'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'group'
        DataType = ftInteger
      end
      item
        Name = 'order'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'work_type_Z'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'closed_order'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'date_reability_docs'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'pplan_dt'
        DataType = ftString
        Size = 30
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
    Left = 24
    Top = 128
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
    object ResultDsetclosed_order: TStringField
      FieldName = 'closed_order'
    end
    object ResultDsetdate_reability_docs: TStringField
      FieldName = 'date_reability_docs'
    end
    object ResultDsetpplan_dt: TStringField
      FieldName = 'pplan_dt'
      Size = 30
    end
    object ResultDsetSroc: TIntegerField
      FieldName = 'Sroc'
    end
    object ResultDsetprosroch: TIntegerField
      FieldName = 'prosroch'
    end
    object ResultDsetoverdude_Day: TIntegerField
      FieldName = 'overdude_Day'
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = ResultDset
    Left = 24
    Top = 72
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select NAME,id from S_REGIONS where id>0 order by id')
    Left = 104
    Top = 72
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 104
    Top = 128
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 104
    Top = 24
  end
  object Svod_Zel: TkbmMemTable
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
    Left = 168
    Top = 128
    object Svod_Zelid_region: TIntegerField
      FieldName = 'id_region'
    end
    object Svod_ZelREgion: TStringField
      DisplayWidth = 20
      FieldName = 'REgion'
    end
    object Svod_Zelneed_count: TIntegerField
      FieldName = 'need_count'
    end
    object Svod_Zelneed_sq: TFloatField
      FieldName = 'need_sq'
    end
    object Svod_Zelfact_count: TIntegerField
      FieldName = 'fact_count'
    end
    object Svod_Zelfact_sq: TFloatField
      FieldName = 'fact_sq'
    end
    object Svod_Zelrasc_count: TIntegerField
      FieldName = 'rasc_count'
    end
    object Svod_Zelrasc_sq: TFloatField
      FieldName = 'rasc_sq'
    end
    object Svod_Zeldo_count: TIntegerField
      FieldName = 'do_count'
    end
    object Svod_Zeldo_sq: TFloatField
      FieldName = 'do_sq'
    end
    object Svod_Zelalldo_count: TIntegerField
      FieldName = 'alldo_count'
    end
    object Svod_Zelalldo_sq: TFloatField
      FieldName = 'alldo_sq'
    end
    object Svod_Zelproc_count: TIntegerField
      FieldName = 'proc_count'
    end
    object Svod_Zelproc_sq: TIntegerField
      FieldName = 'proc_sq'
    end
    object Svod_Zelost_count: TIntegerField
      FieldName = 'ost_count'
    end
    object Svod_Zelost_sq: TFloatField
      FieldName = 'ost_sq'
    end
    object Svod_Zeldin_proc: TIntegerField
      FieldName = 'din_proc'
    end
    object Svod_Zeldin_sq: TFloatField
      FieldName = 'din_sq'
    end
    object Svod_Zelneedall_count: TIntegerField
      FieldName = 'needall_count'
    end
    object Svod_Zelneedall_sq: TFloatField
      FieldName = 'needall_sq'
    end
  end
  object Svod_asf: TkbmMemTable
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
    Left = 240
    Top = 128
    object IntegerField1: TIntegerField
      FieldName = 'id_region'
    end
    object StringField1: TStringField
      DisplayWidth = 20
      FieldName = 'REgion'
    end
    object IntegerField2: TIntegerField
      FieldName = 'need_count'
    end
    object FloatField1: TFloatField
      FieldName = 'need_sq'
    end
    object IntegerField3: TIntegerField
      FieldName = 'fact_count'
    end
    object FloatField2: TFloatField
      FieldName = 'fact_sq'
    end
    object IntegerField4: TIntegerField
      FieldName = 'rasc_count'
    end
    object FloatField3: TFloatField
      FieldName = 'rasc_sq'
    end
    object IntegerField5: TIntegerField
      FieldName = 'do_count'
    end
    object FloatField4: TFloatField
      FieldName = 'do_sq'
    end
    object IntegerField6: TIntegerField
      FieldName = 'alldo_count'
    end
    object FloatField5: TFloatField
      FieldName = 'alldo_sq'
    end
    object IntegerField7: TIntegerField
      FieldName = 'proc_count'
    end
    object IntegerField8: TIntegerField
      FieldName = 'proc_sq'
    end
    object IntegerField9: TIntegerField
      FieldName = 'ost_count'
    end
    object FloatField6: TFloatField
      FieldName = 'ost_sq'
    end
    object IntegerField10: TIntegerField
      FieldName = 'din_proc'
    end
    object FloatField7: TFloatField
      FieldName = 'din_sq'
    end
    object Svod_asfneedall_count: TIntegerField
      FieldName = 'needall_count'
    end
    object Svod_asfneedall_sq: TFloatField
      FieldName = 'needall_sq'
    end
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = Svod_Zel
    Left = 168
    Top = 72
  end
  object frDBDataSet3: TfrDBDataSet
    DataSet = Svod_asf
    Left = 248
    Top = 72
  end
  object mem_SvodAll: TkbmMemTable
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
    Top = 192
    object mem_SvodAllid_region: TIntegerField
      FieldName = 'id_region'
    end
    object mem_SvodAllREgion: TStringField
      DisplayWidth = 20
      FieldName = 'REgion'
    end
    object mem_SvodAllneed_count_zel: TIntegerField
      FieldName = 'needall_count_zel'
    end
    object mem_SvodAllneed_sq_zel: TFloatField
      FieldName = 'needall_sq_zel'
    end
    object mem_SvodAllneed_count_asf: TIntegerField
      FieldName = 'needall_count_asf'
    end
    object mem_SvodAllneed_sq_asf: TFloatField
      FieldName = 'needall_sq_asf'
    end
    object mem_SvodAllalldo_count_zel: TIntegerField
      FieldName = 'alldo_count_zel'
    end
    object mem_SvodAllall_docount_sq: TFloatField
      FieldName = 'alldo_count_sq'
    end
    object mem_SvodAllall_docount_asf: TIntegerField
      FieldName = 'alldo_count_asf'
    end
    object mem_SvodAllall_docsq_zel: TFloatField
      FieldName = 'alldo_sq_zel'
    end
    object mem_SvodAllall_docsq_asf: TFloatField
      FieldName = 'alldo_sq_asf'
    end
    object mem_SvodAllproc_zel: TIntegerField
      FieldName = 'proc_count_zel'
    end
    object mem_SvodAllproc_asf: TIntegerField
      FieldName = 'proc_count_asf'
    end
    object mem_SvodAllost_count_zel: TIntegerField
      FieldName = 'ost_count_zel'
    end
    object mem_SvodAllost_sq_zel: TFloatField
      FieldName = 'ost_sq_zel'
    end
    object mem_SvodAllost_count_asf: TIntegerField
      FieldName = 'ost_count_asf'
    end
    object mem_SvodAllost_sq_asf: TIntegerField
      FieldName = 'ost_sq_asf'
    end
    object mem_SvodAllneedadd_count: TIntegerField
      FieldName = 'needall_count'
    end
    object mem_SvodAllneedall_sq: TFloatField
      FieldName = 'needall_sq'
    end
  end
  object frDBD_svod: TfrDBDataSet
    DataSet = mem_SvodAll
    Left = 112
    Top = 192
  end
  object Svod_Cheb: TkbmMemTable
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
    Left = 240
    Top = 192
    object IntegerField11: TIntegerField
      FieldName = 'id_region'
    end
    object StringField2: TStringField
      DisplayWidth = 20
      FieldName = 'REgion'
    end
    object IntegerField12: TIntegerField
      FieldName = 'need_count'
    end
    object FloatField8: TFloatField
      FieldName = 'need_sq'
    end
    object IntegerField13: TIntegerField
      FieldName = 'fact_count'
    end
    object FloatField9: TFloatField
      FieldName = 'fact_sq'
    end
    object IntegerField14: TIntegerField
      FieldName = 'rasc_count'
    end
    object FloatField10: TFloatField
      FieldName = 'rasc_sq'
    end
    object IntegerField15: TIntegerField
      FieldName = 'do_count'
    end
    object FloatField11: TFloatField
      FieldName = 'do_sq'
    end
    object IntegerField16: TIntegerField
      FieldName = 'alldo_count'
    end
    object FloatField12: TFloatField
      FieldName = 'alldo_sq'
    end
    object IntegerField17: TIntegerField
      FieldName = 'proc_count'
    end
    object IntegerField18: TIntegerField
      FieldName = 'proc_sq'
    end
    object IntegerField19: TIntegerField
      FieldName = 'ost_count'
    end
    object FloatField13: TFloatField
      FieldName = 'ost_sq'
    end
    object IntegerField20: TIntegerField
      FieldName = 'din_proc'
    end
    object FloatField14: TFloatField
      FieldName = 'din_sq'
    end
    object IntegerField21: TIntegerField
      FieldName = 'needall_count'
    end
    object FloatField15: TFloatField
      FieldName = 'needall_sq'
    end
  end
  object frDB_SvodCheb: TfrDBDataSet
    DataSet = Svod_Cheb
    Left = 168
    Top = 200
  end
end
