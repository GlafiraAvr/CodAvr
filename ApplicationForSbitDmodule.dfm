inherited dm_ApplicationForSbit: Tdm_ApplicationForSbit
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object rm_result: TRxMemoryData
    FieldDefs = <>
    Left = 152
    Top = 16
    object rm_resultid_region: TIntegerField
      FieldName = 'id_region'
    end
    object rm_resultRegion: TStringField
      FieldName = 'Region'
    end
    object rm_resultnumber_our_request: TIntegerField
      FieldName = 'number_our_request'
    end
    object rm_resultdate_our_request: TDateTimeField
      FieldName = 'date_our_request'
    end
    object rm_resultabonent: TStringField
      FieldName = 'abonent'
      Size = 30
    end
    object rm_resultphone: TStringField
      FieldName = 'phone'
    end
    object rm_resultabout: TStringField
      FieldName = 'about'
      Size = 1000
    end
    object rm_resultadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object rm_resultcadditionalinfo: TStringField
      FieldName = 'additionalinfo'
      Size = 800
    end
    object rm_resultsource: TStringField
      FieldName = 'source'
      Size = 10
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_result
    Left = 80
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 16
    Top = 104
  end
end
