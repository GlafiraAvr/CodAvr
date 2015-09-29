inherited dm_ZvClosedOrder: Tdm_ZvClosedOrder
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object rm_result: TRxMemoryData
    FieldDefs = <>
    Left = 16
    Top = 96
    object rm_resultid_order: TIntegerField
      FieldName = 'id_order'
    end
    object rm_resultIDREgion: TIntegerField
      FieldName = 'IDREgion'
    end
    object rm_resultid_1562: TIntegerField
      FieldName = 'id_1562'
    end
    object rm_resultordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object rm_resultRegion: TStringField
      FieldName = 'Region'
    end
    object rm_resultAdres: TStringField
      FieldName = 'Adres'
      Size = 120
    end
    object rm_resultnumber: TIntegerField
      FieldName = 'number'
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_result
    Left = 96
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 96
    Top = 136
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 104
    Top = 80
  end
end
