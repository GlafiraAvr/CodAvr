inherited dm_RepSvodVed_vds_new: Tdm_RepSvodVed_vds_new
  Left = 489
  Top = 462
  Height = 394
  Width = 519
  inherited frReport: TfrReport
    Top = 24
    ReportForm = {19000000}
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
    DataSet = md_CountByReg_new
    Left = 16
    Top = 72
  end
  object md_Discon: TRxMemoryData
    Active = True
    FieldDefs = <
      item
        Name = 'id_reg'
        DataType = ftInteger
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'adres'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'discontype'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'dttm_discon'
        DataType = ftDateTime
      end
      item
        Name = 'id_discon'
        DataType = ftInteger
      end
      item
        Name = 'OrderNumber'
        DataType = ftInteger
      end
      item
        Name = 'district'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DaysCount'
        DataType = ftInteger
      end
      item
        Name = 'DisconReason'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'G_ZHD'
        DataType = ftInteger
      end
      item
        Name = 'G_KV'
        DataType = ftInteger
      end
      item
        Name = 'G_STOJ'
        DataType = ftInteger
      end
      item
        Name = 'G_ST_SP'
        DataType = ftInteger
      end
      item
        Name = 'G_POD'
        DataType = ftInteger
      end
      item
        Name = 'G_GV'
        DataType = ftString
        Size = 10
      end>
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
    Active = True
    FieldDefs = <
      item
        Name = 'discontype'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'dcount'
        DataType = ftInteger
      end>
    Left = 176
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
    Active = True
    FieldDefs = <
      item
        Name = 'id_reg'
        DataType = ftInteger
      end
      item
        Name = 'prin_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_new'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall'
        DataType = ftInteger
      end
      item
        Name = 'prin_zhit'
        DataType = ftInteger
      end
      item
        Name = 'prin_nar'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_zhit'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_zhit'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_all'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_nar'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_nar'
        DataType = ftInteger
      end
      item
        Name = 'col_dep'
        DataType = ftInteger
      end
      item
        Name = 'ost_zayv'
        DataType = ftInteger
      end
      item
        Name = 'ost_nar'
        DataType = ftInteger
      end
      item
        Name = 'ods_vip'
        DataType = ftInteger
      end
      item
        Name = 'ods_prin'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_all'
        DataType = ftInteger
      end
      item
        Name = 'ost_1562'
        DataType = ftInteger
      end
      item
        Name = 'percent_n'
        DataType = ftFloat
      end
      item
        Name = 'ost_zhit'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_tek_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vipall_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vipall_rall'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_tek_rall'
        DataType = ftInteger
      end
      item
        Name = 'vip_nar_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_zhit_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_per_rall'
        DataType = ftInteger
      end
      item
        Name = 'prin_all_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_zhit_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall_old'
        DataType = ftInteger
      end
      item
        Name = 'prin_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall_new'
        DataType = ftInteger
      end
      item
        Name = 'prin_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'ost_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'vip_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_all_1562'
        DataType = ftInteger
      end
      item
        Name = 'Region'
        DataType = ftString
        Size = 20
      end>
    Left = 104
    Top = 72
    object md_CountByReg_newid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_CountByReg_newprin_all: TIntegerField
      FieldName = 'prin_all'
    end
    object md_CountByReg_newprin_1562_new: TIntegerField
      FieldName = 'prin_1562_new'
    end
    object md_CountByReg_newprin_1562_rall: TIntegerField
      FieldName = 'prin_1562_rall'
    end
    object md_CountByReg_newprin_zhit: TIntegerField
      FieldName = 'prin_zhit'
    end
    object md_CountByReg_newprin_narad: TIntegerField
      FieldName = 'prin_nar'
    end
    object md_CountByReg_newvip_tek_1562: TIntegerField
      FieldName = 'vip_tek_1562'
    end
    object md_CountByReg_newvip_tek_zhit: TIntegerField
      FieldName = 'vip_tek_zhit'
    end
    object md_CountByReg_newvip_per_1562: TIntegerField
      FieldName = 'vip_per_1562'
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
    object md_CountByReg_newcol_dep: TIntegerField
      FieldName = 'col_dep'
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
    object md_CountByReg_newpercent_n: TFloatField
      FieldName = 'percent_n'
      DisplayFormat = '0.##'
    end
    object md_CountByReg_newost_zhit: TIntegerField
      FieldName = 'ost_zhit'
    end
    object md_CountByReg_newField1562_vip_tek_new: TIntegerField
      FieldName = '1562_vip_tek_new'
    end
    object md_CountByReg_newField1562_vipall_new: TIntegerField
      FieldName = '1562_vipall_new'
    end
    object md_CountByReg_newField1562_vipall_rall: TIntegerField
      FieldName = '1562_vipall_rall'
    end
    object md_CountByReg_newField1562_vip_tek_rall: TIntegerField
      FieldName = '1562_vip_tek_rall'
    end
    object md_CountByReg_newvip_nar_all: TIntegerField
      FieldName = 'vip_nar_all'
    end
    object md_CountByReg_newprin_zhit_new: TIntegerField
      FieldName = 'prin_zhit_new'
    end
    object md_CountByReg_newField1562_vip_per_rall: TIntegerField
      FieldName = '1562_vip_per_rall'
    end
    object md_CountByReg_newprin_all_1562: TIntegerField
      FieldName = 'prin_all_1562'
    end
    object md_CountByReg_newvip_zhit_all: TIntegerField
      FieldName = 'vip_zhit_all'
    end
    object md_CountByReg_newprin_1562_rall_old: TIntegerField
      FieldName = 'prin_1562_rall_old'
    end
    object md_CountByReg_newprin_failure_1562: TIntegerField
      FieldName = 'prin_failure_1562'
    end
    object md_CountByReg_newprin_1562_rall_new: TIntegerField
      FieldName = 'prin_1562_rall_new'
    end
    object md_CountByReg_newprin_failure_rall_1562: TIntegerField
      FieldName = 'prin_failure_rall_1562'
    end
    object md_CountByReg_newprin_1562_all: TIntegerField
      FieldName = 'prin_1562_all'
    end
    object md_CountByReg_newprin__orders_tech: TIntegerField
      FieldName = 'prin_nar_leak'
    end
    object md_CountByReg_newost_order_tech: TIntegerField
      FieldName = 'ost_nar_leak'
    end
    object md_CountByReg_newvip_nar_leak: TIntegerField
      FieldName = 'vip_nar_leak'
    end
    object md_CountByReg_newwip_per_rall_1562: TIntegerField
      FieldName = 'vip_per_rall_1562'
    end
    object md_CountByReg_newvip_tek_failure_1562: TIntegerField
      FieldName = 'vip_tek_failure_1562'
    end
    object md_CountByReg_newvip_per_failure_1562: TIntegerField
      FieldName = 'vip_per_failure_1562'
    end
    object md_CountByReg_newvip_per_failure_rall_1562: TIntegerField
      FieldName = 'vip_per_failure_rall_1562'
    end
    object md_CountByReg_newvip_tek_failure_rall_1562: TIntegerField
      FieldName = 'vip_tek_failure_rall_1562'
    end
    object md_CountByReg_newvip_all_1562: TIntegerField
      FieldName = 'vip_all_1562'
    end
    object md_CountByReg_newRegion: TStringField
      FieldName = 'Region'
    end
  end
  object query: TADOQuery
    Connection = DM_Main.ADOConn_1562
    CommandTimeout = 120
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
  object md_HappyNewYear: TRxMemoryData
    Active = True
    FieldDefs = <
      item
        Name = 'id_reg'
        DataType = ftInteger
      end
      item
        Name = 'prin_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_new'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall'
        DataType = ftInteger
      end
      item
        Name = 'prin_zhit'
        DataType = ftInteger
      end
      item
        Name = 'prin_nar'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_zhit'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_zhit'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_all'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_nar'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_nar'
        DataType = ftInteger
      end
      item
        Name = 'col_dep'
        DataType = ftInteger
      end
      item
        Name = 'ost_zayv'
        DataType = ftInteger
      end
      item
        Name = 'ost_nar'
        DataType = ftInteger
      end
      item
        Name = 'ods_vip'
        DataType = ftInteger
      end
      item
        Name = 'ods_prin'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_all'
        DataType = ftInteger
      end
      item
        Name = 'ost_1562'
        DataType = ftInteger
      end
      item
        Name = 'percent_n'
        DataType = ftFloat
      end
      item
        Name = 'ost_zhit'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_tek_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vipall_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vipall_rall'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_tek_rall'
        DataType = ftInteger
      end
      item
        Name = 'vip_nar_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_zhit_new'
        DataType = ftInteger
      end
      item
        Name = '1562_vip_per_rall'
        DataType = ftInteger
      end
      item
        Name = 'prin_all_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_zhit_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall_old'
        DataType = ftInteger
      end
      item
        Name = 'prin_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_rall_new'
        DataType = ftInteger
      end
      item
        Name = 'prin_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'prin_1562_all'
        DataType = ftInteger
      end
      item
        Name = 'prin_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'ost_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'vip_nar_leak'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_failure_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_per_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_tek_failure_rall_1562'
        DataType = ftInteger
      end
      item
        Name = 'vip_all_1562'
        DataType = ftInteger
      end
      item
        Name = 'Region'
        DataType = ftString
        Size = 20
      end>
    Left = 136
    Top = 264
    object md_HappyNewYearid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_HappyNewYearprin_all: TIntegerField
      FieldName = 'prin_all'
    end
    object md_HappyNewYearprin_1562_new: TIntegerField
      FieldName = 'prin_1562_new'
    end
    object md_HappyNewYearprin_1562_all: TIntegerField
      FieldName = 'prin_1562_rall'
    end
    object md_HappyNewYearprin_zhit: TIntegerField
      FieldName = 'prin_zhit'
    end
    object md_HappyNewYearprin_nar: TIntegerField
      FieldName = 'prin_nar'
    end
    object md_HappyNewYearvip_tek_1562: TIntegerField
      FieldName = 'vip_tek_1562'
    end
    object md_HappyNewYearvip_tek_xhit: TIntegerField
      FieldName = 'vip_tek_zhit'
    end
    object md_HappyNewYearvip_per_1562: TIntegerField
      FieldName = 'vip_per_1562'
    end
    object md_HappyNewYearvip_per_zhit: TIntegerField
      FieldName = 'vip_per_zhit'
    end
    object md_HappyNewYearvip_per_all: TIntegerField
      FieldName = 'vip_per_all'
    end
    object md_HappyNewYearvip_per_nar: TIntegerField
      FieldName = 'vip_per_nar'
    end
    object md_HappyNewYearvip_tek_nar: TIntegerField
      FieldName = 'vip_tek_nar'
    end
    object md_HappyNewYearcol_dep: TIntegerField
      FieldName = 'col_dep'
    end
    object md_HappyNewYearost_zayv: TIntegerField
      FieldName = 'ost_zayv'
    end
    object md_HappyNewYearost_nar: TIntegerField
      FieldName = 'ost_nar'
    end
    object md_HappyNewYearods_vip: TIntegerField
      FieldName = 'ods_vip'
    end
    object md_HappyNewYearods_prin: TIntegerField
      FieldName = 'ods_prin'
    end
    object md_HappyNewYearvip_tek_all: TIntegerField
      FieldName = 'vip_tek_all'
    end
    object md_HappyNewYearost_1562: TIntegerField
      FieldName = 'ost_1562'
    end
    object md_HappyNewYearpercent_n: TFloatField
      FieldName = 'percent_n'
      DisplayFormat = '0.##'
    end
    object md_HappyNewYearost_zhit: TIntegerField
      FieldName = 'ost_zhit'
    end
    object md_HappyNewYear1562_vip_tek_new: TIntegerField
      FieldName = '1562_vip_tek_new'
    end
    object md_HappyNewYear1562_vip_all_new: TIntegerField
      FieldName = '1562_vipall_new'
    end
    object md_HappyNewYear1562_vip_all_rall: TIntegerField
      FieldName = '1562_vipall_rall'
    end
    object md_HappyNewYear1562_vip_tek_rall: TIntegerField
      FieldName = '1562_vip_tek_rall'
    end
    object md_HappyNewYear_vip_nar_all: TIntegerField
      FieldName = 'vip_nar_all'
    end
    object md_HappyNewYearprin_zhit_new: TIntegerField
      FieldName = 'prin_zhit_new'
    end
    object md_HappyNewYear1562_vip_per_rall: TIntegerField
      FieldName = '1562_vip_per_rall'
    end
    object md_HappyNewYearprin_all_1562: TIntegerField
      FieldName = 'prin_all_1562'
    end
    object md_HappyNewYearvip_zhit_all: TIntegerField
      FieldName = 'vip_zhit_all'
    end
    object md_HappyNewYearprin_1562_rall_old: TIntegerField
      FieldName = 'prin_1562_rall_old'
    end
    object md_HappyNewYearprin_failure_1562: TIntegerField
      FieldName = 'prin_failure_1562'
    end
    object md_HappyNewYearprin_1562_rall_new: TIntegerField
      FieldName = 'prin_1562_rall_new'
    end
    object md_HappyNewYearprin_failure_rall_1562: TIntegerField
      FieldName = 'prin_failure_rall_1562'
    end
    object md_HappyNewYearprin__1562_all: TIntegerField
      FieldName = 'prin_1562_all'
    end
    object md_HappyNewYearprin_nar_leak: TIntegerField
      FieldName = 'prin_nar_leak'
    end
    object md_HappyNewYearost_nar_leak: TIntegerField
      FieldName = 'ost_nar_leak'
    end
    object md_HappyNewYearvip_nar_leak: TIntegerField
      FieldName = 'vip_nar_leak'
    end
    object md_HappyNewYearvip_per_rall_1562: TIntegerField
      FieldName = 'vip_per_rall_1562'
    end
    object md_HappyNewYearvip_tek_failurel_1562: TIntegerField
      FieldName = 'vip_tek_failure_1562'
    end
    object md_HappyNewYearvip_per_failurel_1562: TIntegerField
      FieldName = 'vip_per_failure_1562'
    end
    object md_HappyNewYearvip_per_failure_ralll_1562: TIntegerField
      FieldName = 'vip_per_failure_rall_1562'
    end
    object md_HappyNewYearvip_tek_failure_ralll_1562: TIntegerField
      FieldName = 'vip_tek_failure_rall_1562'
    end
    object md_HappyNewYearvip_per_alll_1562: TIntegerField
      FieldName = 'vip_all_1562'
    end
    object md_HappyNewYearRegion: TStringField
      FieldName = 'Region'
    end
  end
  object frDBD_NewYEar: TfrDBDataSet
    DataSet = md_HappyNewYear
    Left = 24
    Top = 264
  end
end
