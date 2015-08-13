inherited dm_RepSvodVed: Tdm_RepSvodVed
  Left = 370
  Top = 306
  Height = 407
  Width = 507
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object md_CountByReg: TRxMemoryData
    FieldDefs = <>
    OnCalcFields = md_CountByRegCalcFields
    Left = 112
    Top = 24
    object md_CountByRegid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_CountByRegRegion: TStringField
      FieldName = 'Region'
      Size = 50
    end
    object md_CountByRego62_prin: TIntegerField
      FieldName = 'o62_prin'
      OnChange = md_CountByRego62_prinChange
    end
    object md_CountByRegods_prin: TIntegerField
      FieldName = 'ods_prin'
    end
    object md_CountByRegzhitel_prin: TIntegerField
      FieldName = 'zhitel_prin'
      OnChange = md_CountByRego62_prinChange
    end
    object md_CountByRegsum_prin: TIntegerField
      FieldName = 'sum_prin'
    end
    object md_CountByRego62_vip: TIntegerField
      FieldName = 'o62_vip'
      OnChange = md_CountByRego62_vipChange
    end
    object md_CountByRegods_vip: TIntegerField
      FieldName = 'ods_vip'
    end
    object md_CountByRegzhitel_vip: TIntegerField
      FieldName = 'zhitel_vip'
      OnChange = md_CountByRego62_vipChange
    end
    object md_CountByRegsum_vip: TIntegerField
      FieldName = 'sum_vip'
    end
    object md_CountByRegpercent_vip: TFloatField
      FieldKind = fkCalculated
      FieldName = 'percent_vip'
      DisplayFormat = '0.##'
      Calculated = True
    end
    object md_CountByRegostalos: TIntegerField
      FieldName = 'ostalos'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 328
    Top = 104
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 272
    Top = 200
  end
  object frDSet: TfrDBDataSet
    DataSet = md_CountByReg
    Left = 112
    Top = 152
  end
  object md_Discon: TRxMemoryData
    FieldDefs = <>
    Left = 24
    Top = 152
    object md_Disconid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_Disconregion: TStringField
      FieldName = 'region'
      Size = 50
    end
    object md_Disconadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object md_Discondiscontype: TStringField
      FieldName = 'discontype'
      Size = 30
    end
    object md_Discondttm_discon: TDateTimeField
      FieldName = 'dttm_discon'
    end
    object md_Disconid_discon: TIntegerField
      FieldName = 'id_discon'
    end
    object md_DisconOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object md_Discondistrict: TStringField
      FieldName = 'district'
    end
    object md_DisconDaysCount: TIntegerField
      FieldName = 'DaysCount'
    end
    object md_DisconDisconReason: TStringField
      FieldName = 'DisconReason'
      Size = 30
    end
  end
  object frDS_Discon: TfrDBDataSet
    DataSet = md_Discon
    Left = 24
    Top = 240
  end
  object md_DisconSumInfo: TRxMemoryData
    FieldDefs = <>
    Left = 248
    Top = 304
    object md_DisconSumInfodiscontype: TStringField
      FieldName = 'discontype'
      Size = 30
    end
    object md_DisconSumInfodcount: TIntegerField
      FieldName = 'dcount'
    end
  end
  object frDS_DisconSumInfo: TfrDBDataSet
    DataSet = md_DisconSumInfo
    Left = 376
    Top = 296
  end
  object XMLDocument1: TXMLDocument
    Left = 216
    Top = 40
    DOMVendorDesc = 'MSXML'
  end
end
