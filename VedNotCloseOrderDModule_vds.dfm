inherited dm_VedNotCloseOrder_vds: Tdm_VedNotCloseOrder_vds
  inherited frReport: TfrReport
    Dataset = frDBDataSet
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 160
    Top = 80
  end
  object rmem: TRxMemoryData
    FieldDefs = <>
    Left = 72
    Top = 80
    object rmemRegion_ID: TIntegerField
      FieldName = 'Region_ID'
    end
    object rmemRegion: TStringField
      FieldName = 'Region'
    end
    object rmemAll: TIntegerField
      FieldName = 'All'
    end
    object rmemwith_leak: TIntegerField
      FieldName = 'with_leak'
    end
    object rmemlocal_leak: TIntegerField
      FieldName = 'local_leak'
    end
  end
  object dset_all: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 160
  end
  object dset_leak: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 96
    Top = 160
  end
  object dset_local: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 168
    Top = 152
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = rmem
    Left = 72
    Top = 16
  end
end
