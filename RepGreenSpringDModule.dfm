inherited dm_RepGreenSpring: Tdm_RepGreenSpring
  Height = 366
  Width = 464
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object mem_Itog: TkbmMemTable
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
    Top = 272
    object mem_ItogId_REgion: TIntegerField
      FieldName = 'Id_REgion'
    end
    object mem_ItogRegion: TStringField
      FieldName = 'Region'
    end
    object mem_Itogneed_asf_count: TIntegerField
      FieldName = 'need_asf_count'
    end
    object mem_Itogneed_asf_sq: TFloatField
      FieldName = 'need_asf_sq'
    end
    object mem_Itogneed_gz_count: TIntegerField
      FieldName = 'need_gz_count'
    end
    object mem_Itogneed_gz_sq: TFloatField
      FieldName = 'need_gz_sq'
    end
    object mem_Itogdo_asf_count: TIntegerField
      FieldName = 'do_asf_count'
    end
    object mem_Itogdo_asf_sq: TFloatField
      FieldName = 'do_asf_sq'
    end
    object mem_Itogdo_gz_count: TIntegerField
      FieldName = 'do_gz_count'
    end
    object mem_Itogdo_gr_sq: TFloatField
      FieldName = 'do_gz_sq'
    end
    object mem_Itogpercent_do_asf_count: TFloatField
      FieldName = 'percent_do_asf_count'
    end
    object mem_Itogpercent_do_asf_sq: TFloatField
      FieldName = 'percent_do_asf_sq'
    end
    object mem_Itogpercent_do_gz_count: TFloatField
      FieldName = 'percent_do_gz_count'
    end
    object mem_Itogpercent_do_gz_sq: TFloatField
      FieldName = 'percent_do_gz_sq'
    end
  end
  object frDBD_memItog: TfrDBDataSet
    DataSet = mem_Itog
    Left = 96
    Top = 272
  end
end
