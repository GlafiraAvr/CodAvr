inherited dm_RepSvodVed_vds: Tdm_RepSvodVed_vds
  Left = 436
  Top = 395
  Height = 407
  Width = 507
  inherited frReport: TfrReport
    Left = 40
    ReportForm = {19000000}
  end
  object md_CountByReg: TRxMemoryData
    FieldDefs = <>
    OnCalcFields = md_CountByRegCalcFields
    Left = 96
    Top = 72
    object md_CountByRegid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_CountByRegRegion: TStringField
      FieldName = 'Region'
      Size = 50
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
    object md_CountByRego62_prin: TIntegerField
      FieldName = 'o62_prin'
      OnChange = md_CountByRego62_prinChange
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
    Left = 424
    Top = 16
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 424
    Top = 72
  end
  object frDSet: TfrDBDataSet
    DataSet = md_CountByReg
    Left = 16
    Top = 72
  end
  object md_Discon: TRxMemoryData
    FieldDefs = <>
    Left = 96
    Top = 128
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
      Size = 60
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
    object md_DisconG_ZHD: TIntegerField
      FieldName = 'G_ZHD'
    end
    object md_DisconG_KV: TIntegerField
      FieldName = 'G_KV'
    end
    object md_DisconG_STOJ: TIntegerField
      FieldName = 'G_STOJ'
    end
    object md_DisconG_ST_SP: TIntegerField
      FieldName = 'G_ST_SP'
    end
    object md_DisconG_POD: TIntegerField
      FieldName = 'G_POD'
    end
    object md_DisconG_GV: TStringField
      FieldName = 'G_GV'
      Size = 10
    end
  end
  object frDS_Discon: TfrDBDataSet
    DataSet = md_Discon
    Left = 16
    Top = 128
  end
  object md_DisconSumInfo: TRxMemoryData
    FieldDefs = <>
    Left = 96
    Top = 192
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
    Left = 16
    Top = 192
  end
  object XMLDocument1: TXMLDocument
    Left = 416
    Top = 296
    DOMVendorDesc = 'MSXML'
  end
  object md_CountByReg_new: TRxMemoryData
    FieldDefs = <
      item
        Name = 'md_CountByReg_newField1'
      end>
    Left = 96
    Top = 272
    object md_CountByReg_newid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_CountByReg_newprin_all: TIntegerField
      FieldName = 'prin_all'
    end
    object md_CountByReg_newprin_1562_new: TIntegerField
      FieldName = 'prin_1562_new'
      OnChange = md_CountByReg_newprin_1562_newChange
    end
    object md_CountByReg_newprin_1562_rall: TIntegerField
      FieldName = 'prin_1562_rall'
      OnChange = md_CountByReg_newprin_1562_newChange
    end
    object md_CountByReg_newprin_zhit: TIntegerField
      FieldName = 'prin_zhit'
      OnChange = md_CountByReg_newprin_1562_newChange
    end
    object md_CountByReg_newprin_narad: TIntegerField
      FieldName = 'prin_nar'
    end
    object md_CountByReg_newvip_tek_1562: TIntegerField
      FieldName = 'vip_tek_1562'
      OnChange = md_CountByReg_newvip_tek_1562Change
    end
    object md_CountByReg_newvip_tek_zhit: TIntegerField
      FieldName = 'vip_tek_zhit'
      OnChange = md_CountByReg_newvip_tek_1562Change
    end
    object md_CountByReg_newptin_tek_all: TIntegerField
      FieldName = 'ptin_tek_all'
    end
    object md_CountByReg_newprin_tek_nar: TIntegerField
      FieldName = 'prin_tek_nar'
    end
    object md_CountByReg_newvip_per_1562: TIntegerField
      FieldName = 'vip_per_1562'
      OnChange = md_CountByReg_newvip_per_1562Change
    end
    object md_CountByReg_newvip_per_zhit: TIntegerField
      FieldName = 'vip_per_zhit'
    end
    object md_CountByReg_newvip_per_all: TIntegerField
      FieldName = 'vip_per_all'
    end
    object md_CountByReg_newvip_per_nar: TIntegerField
      FieldName = 'vip_per_nar'
    end
    object md_CountByReg_newvip_tek_nar: TIntegerField
      FieldName = 'vip_tek_nar'
    end
    object md_CountByReg_newost_zayv: TIntegerField
      FieldName = 'ost_zayv'
    end
    object md_CountByReg_newost_nar: TIntegerField
      FieldName = 'ost_nar'
    end
    object md_CountByReg_newods_vip: TIntegerField
      FieldName = 'ods_vip'
    end
    object md_CountByReg_newods_prin: TIntegerField
      FieldName = 'ods_prin'
    end
    object md_CountByReg_newvip_tek_all: TIntegerField
      FieldName = 'vip_tek_all'
    end
    object md_CountByReg_newost_1562: TIntegerField
      FieldName = 'ost_1562'
    end
    object md_CountByReg_newost_zhit: TIntegerField
      FieldName = 'ost_zhit'
    end
    object md_CountByReg_newField1562_vipall_new: TIntegerField
      FieldName = '1562_vipall_new'
    end
    object md_CountByReg_newField1562_vipall_rall: TIntegerField
      FieldName = '1562_vipall_rall'
    end
    object md_CountByReg_newField1562_vip_tek_new: TIntegerField
      FieldName = '1562_vip_tek_new'
    end
    object md_CountByReg_newField1562_vip_tek_rall: TIntegerField
      FieldName = '1562_vip_tek_rall'
    end
    object md_CountByReg_newRegion: TStringField
      FieldName = 'Region'
    end
  end
  object query: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 240
    Top = 32
  end
  object ado_dset: TADODataSet
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 240
    Top = 96
  end
  object ADOStoredProc1: TADOStoredProc
    Parameters = <>
    Left = 272
    Top = 224
  end
end
