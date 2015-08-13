inherited dm_RepGorSES: Tdm_RepGorSES
  Left = 407
  Top = 342
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 120
    Top = 16
    object ResultDsetreg_id: TIntegerField
      FieldName = 'reg_id'
    end
    object ResultDsetreg_name: TStringField
      FieldName = 'reg_name'
    end
    object ResultDsetdmg_count: TIntegerField
      FieldName = 'dmg_count'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 72
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 168
    Top = 136
  end
  object frDSResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 56
    Top = 112
  end
end
