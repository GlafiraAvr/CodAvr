inherited Tdm_DamageBlagObject: TTdm_DamageBlagObject
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object dset_main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 88
    Top = 24
  end
  object rm_result: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 72
    object rm_resultid_region: TIntegerField
      FieldName = 'id_region'
    end
    object rm_resultRegion: TStringField
      FieldName = 'Region'
    end
    object rm_resulttype: TStringField
      FieldName = 'type'
      Size = 4
    end
    object rm_resultadres: TStringField
      FieldName = 'adres'
      Size = 250
    end
    object rm_resultlabel: TStringField
      FieldName = 'label'
      Size = 30
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_result
    Left = 32
    Top = 136
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select ID, UK_Name NAME from S_REGIONS'
      'where id>0')
    Left = 104
    Top = 80
  end
end
