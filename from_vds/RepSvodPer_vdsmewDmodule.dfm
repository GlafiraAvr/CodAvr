inherited dm_RepSvodVed_vds_new_per: Tdm_RepSvodVed_vds_new_per
  Left = 459
  Top = 414
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  inherited frDSet: TfrDBDataSet
    DataSet = md_CountByReg
  end
  object md_CountByReg: TRxMemoryData
    FieldDefs = <>
    Left = 88
    Top = 24
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
    end
    object md_CountByRegsum_prin: TIntegerField
      FieldName = 'sum_prin'
    end
    object md_CountByRego62_vip: TIntegerField
      FieldName = 'o62_vip'
    end
    object md_CountByRego62_prin: TIntegerField
      FieldName = 'o62_prin'
    end
    object md_CountByRegods_vip: TIntegerField
      FieldName = 'ods_vip'
    end
    object md_CountByRegzhitel_vip: TIntegerField
      FieldName = 'zhitel_vip'
    end
    object md_CountByRegsum_vip: TIntegerField
      FieldName = 'sum_vip'
    end
    object md_CountByRegpercent_vip: TFloatField
      FieldName = 'percent_vip'
      DisplayFormat = '0.##'
    end
    object md_CountByRegostalos: TIntegerField
      FieldName = 'ostalos'
    end
  end
  object md_CountByRegsum: TRxMemoryData
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
    Left = 328
    Top = 176
    object md_CountByRegsumid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_CountByRegsumprin_all: TIntegerField
      FieldName = 'prin_all'
    end
    object md_CountByRegsumprin_1562: TIntegerField
      FieldName = 'prin_1562_new'
    end
    object md_CountByRegsumprin_1562_rall: TIntegerField
      FieldName = 'prin_1562_rall'
    end
    object md_CountByRegsumprin_zhit: TIntegerField
      FieldName = 'prin_zhit'
    end
    object md_CountByRegsumprin_nar: TIntegerField
      FieldName = 'prin_nar'
    end
    object md_CountByRegsumvip_tek_1562: TIntegerField
      FieldName = 'vip_tek_1562'
    end
    object md_CountByRegsumvip_tek_zhit: TIntegerField
      FieldName = 'vip_tek_zhit'
    end
    object md_CountByRegsumvip_per_1562: TIntegerField
      FieldName = 'vip_per_1562'
    end
    object md_CountByRegsumvip_per_zhit: TIntegerField
      FieldName = 'vip_per_zhit'
    end
    object md_CountByRegsumvip_per_all: TIntegerField
      FieldName = 'vip_per_all'
    end
    object md_CountByRegsumvip_per_nar: TIntegerField
      FieldName = 'vip_per_nar'
    end
    object md_CountByRegsumvip_tek_nar: TIntegerField
      FieldName = 'vip_tek_nar'
    end
    object md_CountByRegsumcol_dep: TIntegerField
      FieldName = 'col_dep'
    end
    object md_CountByRegsumvost_zayv: TIntegerField
      FieldName = 'ost_zayv'
    end
    object md_CountByRegsumost_nar_1562: TIntegerField
      FieldName = 'ost_nar'
    end
    object md_CountByRegsumods_vip: TIntegerField
      FieldName = 'ods_vip'
    end
    object md_CountByRegsumods_prin: TIntegerField
      FieldName = 'ods_prin'
    end
    object md_CountByRegsumvip_tek_all: TIntegerField
      FieldName = 'vip_tek_all'
    end
    object md_CountByRegsumost_1562: TIntegerField
      FieldName = 'ost_1562'
    end
    object md_CountByRegsumvpercent_n: TFloatField
      FieldName = 'percent_n'
      DisplayFormat = '0.##'
    end
    object md_CountByRegsumost_zhit: TIntegerField
      FieldName = 'ost_zhit'
    end
    object md_CountByRegsum1562_vip_tek_new: TIntegerField
      FieldName = '1562_vip_tek_new'
    end
    object md_CountByRegsum1562_vip_all_new: TIntegerField
      FieldName = '1562_vipall_new'
    end
    object md_CountByRegsum1562_vip_all_rall: TIntegerField
      FieldName = '1562_vipall_rall'
    end
    object md_CountByRegsum1562_vip_tek_rall: TIntegerField
      FieldName = '1562_vip_tek_rall'
    end
    object md_CountByRegsum_vip_nar_all: TIntegerField
      FieldName = 'vip_nar_all'
    end
    object md_CountByRegsumprin_zhit_new: TIntegerField
      FieldName = 'prin_zhit_new'
    end
    object md_CountByRegsum1562_vip_per_rall: TIntegerField
      FieldName = '1562_vip_per_rall'
    end
    object md_CountByRegsumprin_all_1562: TIntegerField
      FieldName = 'prin_all_1562'
    end
    object md_CountByRegsum_vip_zhit_all: TIntegerField
      FieldName = 'vip_zhit_all'
    end
    object md_CountByRegsumprin_1562_rall_old: TIntegerField
      FieldName = 'prin_1562_rall_old'
    end
    object md_CountByRegsumprin_failure1562: TIntegerField
      FieldName = 'prin_failure_1562'
    end
    object md_CountByRegsumprin_1562_rall_new: TIntegerField
      FieldName = 'prin_1562_rall_new'
    end
    object md_CountByRegsumprin_failure_rall_1562: TIntegerField
      FieldName = 'prin_failure_rall_1562'
    end
    object md_CountByRegsumprin_1562_all: TIntegerField
      FieldName = 'prin_1562_all'
    end
    object md_CountByRegsumprin_nar_leak: TIntegerField
      FieldName = 'prin_nar_leak'
    end
    object md_CountByRegsumost_nar_leak: TIntegerField
      FieldName = 'ost_nar_leak'
    end
    object md_CountByRegsumvip_nar_leak: TIntegerField
      FieldName = 'vip_nar_leak'
    end
    object md_CountByRegsumvip_per_rall_1562: TIntegerField
      FieldName = 'vip_per_rall_1562'
    end
    object md_CountByRegsumvip_tek_failure_1562: TIntegerField
      FieldName = 'vip_tek_failure_1562'
    end
    object md_CountByRegsumvip_per_failure_1562: TIntegerField
      FieldName = 'vip_per_failure_1562'
    end
    object md_CountByRegsumvip_per_failure_rall_1562: TIntegerField
      FieldName = 'vip_per_failure_rall_1562'
    end
    object md_CountByRegsumvip_tek_failure_rall_1562: TIntegerField
      FieldName = 'vip_tek_failure_rall_1562'
    end
    object md_CountByRegsumvip_all_1562: TIntegerField
      FieldName = 'vip_all_1562'
    end
    object md_CountByRegsumRegion: TStringField
      FieldName = 'Region'
    end
  end
end
