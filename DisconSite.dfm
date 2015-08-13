inherited dm_AVRDisconnSite: Tdm_AVRDisconnSite
  inherited frReport1: TfrReport
    ReportForm = {19000000}
  end
  object rm_Adreses: TRxMemoryData
    FieldDefs = <>
    Left = 256
    Top = 128
    object rm_AdresesAdress: TMemoField
      DisplayWidth = 100000
      FieldName = 'Adres'
      BlobType = ftMemo
      Size = 10000
    end
    object rm_AdresesREgion: TStringField
      DisplayWidth = 60
      FieldName = 'REgion'
      Size = 60
    end
    object rm_Adresesadd: TStringField
      FieldName = 'add'
      Size = 50
    end
    object rm_Adresesweak_press: TBooleanField
      FieldName = 'weak_press'
    end
  end
  object fr_adresses: TfrDBDataSet
    DataSet = rm_Adreses
    Left = 328
    Top = 104
  end
end
