inherited dm_RepBlagItog: Tdm_RepBlagItog
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 16
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id_region'
        DataType = ftInteger
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'asf_need_restore_count'
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
    Left = 24
    Top = 96
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 32
    end
    object ResultDsetasf_need_restore_count: TIntegerField
      FieldName = 'asf_need_restore_count'
    end
    object ResultDsetasf_need_restore_square: TFloatField
      FieldName = 'asf_need_restore_square'
    end
    object ResultDsetasf_restored_plan_count: TIntegerField
      FieldName = 'asf_restored_plan_count'
    end
    object ResultDsetasf_restored_plan_square: TFloatField
      FieldName = 'asf_restored_plan_square'
    end
    object ResultDsetasf_restored_noplan_count: TIntegerField
      FieldName = 'asf_restored_noplan_count'
    end
    object ResultDsetasf_restored_noplan_square: TFloatField
      FieldName = 'asf_restored_noplan_square'
    end
    object ResultDsetzel_need_restore_count: TIntegerField
      FieldName = 'zel_need_restore_count'
    end
    object ResultDsetzel_need_restore_square: TFloatField
      FieldName = 'zel_need_restore_square'
    end
    object ResultDsetzel_restored_plan_count: TIntegerField
      FieldName = 'zel_restored_plan_count'
    end
    object ResultDsetzel_restored_plan_square: TFloatField
      FieldName = 'zel_restored_plan_square'
    end
    object ResultDsetzel_restored_noplan_count: TIntegerField
      FieldName = 'zel_restored_noplan_count'
    end
    object ResultDsetzel_restored_noplan_square: TFloatField
      FieldName = 'zel_restored_noplan_square'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 136
    Top = 104
  end
  object dset2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 136
    Top = 184
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 24
    Top = 160
  end
end
