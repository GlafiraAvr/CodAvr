inherited dm_RepGreenSpring: Tdm_RepGreenSpring
  inherited frReport: TfrReport
    Dataset = frDBDResult
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 144
    Top = 72
  end
  object FrResult: TRxMemoryData
    FieldDefs = <>
    Left = 88
    Top = 72
    object FrResultid_region: TIntegerField
      FieldName = 'id_region'
    end
    object FrResultRegion: TStringField
      FieldName = 'Region'
    end
    object FrResultneed_zel_count: TIntegerField
      FieldName = 'need_zel_count'
    end
    object FrResultneed_asf_count: TIntegerField
      FieldName = 'need_asf_count'
    end
    object FrResultdo_zel_count: TIntegerField
      FieldName = 'do_zel_count'
    end
    object FrResultdo_asf_count: TIntegerField
      FieldName = 'do_asf_count'
    end
    object FrResultneed_zel_sqw: TFloatField
      FieldName = 'need_zel_sqw'
    end
    object FrResultneed_asf_sqw: TFloatField
      FieldName = 'need_asf_sqw'
    end
    object FrResultdo_zel_sqw: TFloatField
      FieldName = 'do_zel_sqw'
    end
    object FrResultdo_asf_sqw: TFloatField
      FieldName = 'do_asf_sqw'
    end
  end
  object frDBDResult: TfrDBDataSet
    DataSet = FrResult
    Left = 24
    Top = 72
  end
end
