inherited dm_SvodVedLukAndPG: Tdm_SvodVedLukAndPG
  Left = 462
  Top = 458
  Height = 423
  Width = 531
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object md_Result: TRxMemoryData
    FieldDefs = <>
    Left = 200
    Top = 24
    object md_Resultreg_name: TStringField
      FieldName = 'reg_name'
      Size = 32
    end
    object md_Resultluk_count: TIntegerField
      FieldName = 'luk_count'
    end
    object md_Resultpg_count: TIntegerField
      FieldName = 'pg_count'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 304
    Top = 80
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 312
    Top = 168
  end
  object frDS_Result: TfrDBDataSet
    DataSet = md_Result
    Left = 208
    Top = 104
  end
end
