inherited dm_GetToDoNar: Tdm_GetToDoNar
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 160
    Top = 8
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetRegion: TStringField
      FieldName = 'Region'
    end
    object ResultDsetcount_open: TIntegerField
      FieldName = 'count_open'
    end
    object ResultDsetcount_closed: TIntegerField
      FieldName = 'count_closed'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 104
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 88
    Top = 104
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = ResultDset
    Left = 72
    Top = 16
  end
end
