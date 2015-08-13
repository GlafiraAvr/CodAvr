inherited dm_RepNeedAsfalt: Tdm_RepNeedAsfalt
  Left = 1013
  Top = 571
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 128
    Top = 24
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 80
    object ResultDsetline_num: TStringField
      FieldName = 'line_num'
      Size = 2
    end
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 32
    end
    object ResultDsetneed_restore_count: TIntegerField
      FieldName = 'need_restore_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetneed_restore_square: TFloatField
      FieldName = 'need_restore_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetneed_restore_gran_count: TIntegerField
      FieldName = 'need_restore_gran_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetneed_restore_gran_square: TFloatField
      FieldName = 'need_restore_gran_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetplan_restore_count: TIntegerField
      FieldName = 'plan_restore_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetplan_restore_square: TFloatField
      FieldName = 'plan_restore_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetrestored_plan_count: TIntegerField
      FieldName = 'restored_plan_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetrestored_plan_square: TFloatField
      FieldName = 'restored_plan_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetnew_exc_count: TIntegerField
      FieldName = 'new_exc_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetnew_exc_square: TFloatField
      FieldName = 'new_exc_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetrestored_noplan_count: TIntegerField
      FieldName = 'restored_noplan_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetrestored_noplan_square: TFloatField
      FieldName = 'restored_noplan_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetostat_gran_count: TIntegerField
      FieldName = 'ostat_gran_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetostat_gran_square: TFloatField
      FieldName = 'ostat_gran_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetin_work_count: TIntegerField
      FieldName = 'in_work_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetin_work_square: TFloatField
      FieldName = 'in_work_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsettotal_restored_count: TIntegerField
      FieldName = 'total_restored_count'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsettotal_restored_square: TFloatField
      FieldName = 'total_restored_square'
      OnGetText = ResultDsetneed_restore_countGetText
    end
    object ResultDsetpercent_exc: TFloatField
      FieldName = 'percent_exc'
      OnGetText = ResultDsetneed_restore_countGetText
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 120
    Top = 96
  end
  object dset2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 184
    Top = 112
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 24
    Top = 152
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 144
    Top = 192
  end
end
