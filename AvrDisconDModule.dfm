object DModule: TDModule
  OldCreateOrder = False
  Left = 293
  Top = 123
  Height = 361
  Width = 546
  object IBDB_Main: TIBDatabase
    Params.Strings = (
      'user_name=avr_ib'
      'password=avr_ib_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tran
    Left = 24
    Top = 8
  end
  object IBDB_NS: TIBDatabase
    Params.Strings = (
      'user_name=avr_ib'
      'password=avr_ib_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tran_NS
    Left = 24
    Top = 72
  end
  object IBDB_VDS: TIBDatabase
    Params.Strings = (
      'user_name=avr_vds'
      'password=avr_vds_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = tran_VDS
    Left = 24
    Top = 136
  end
  object tran_NS: TIBTransaction
    DefaultDatabase = IBDB_NS
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 104
    Top = 72
  end
  object tran_VDS: TIBTransaction
    DefaultDatabase = IBDB_VDS
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 104
    Top = 136
  end
  object tran: TIBTransaction
    DefaultDatabase = IBDB_Main
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 96
    Top = 16
  end
  object dset: TIBDataSet
    Database = IBDB_Main
    Transaction = tran
    Left = 176
    Top = 8
  end
  object ib_exec: TIBSQL
    Database = IBDB_Main
    Transaction = tran
    Left = 136
    Top = 208
  end
  object dset_NS: TIBDataSet
    Database = IBDB_NS
    Transaction = tran_NS
    Left = 176
    Top = 80
  end
  object dset_VDS: TIBDataSet
    Database = IBDB_VDS
    Transaction = tran_VDS
    Left = 184
    Top = 144
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <
      item
        Name = 'Adres'
        DataType = ftString
        Size = 180
      end
      item
        Name = 'Zhd'
        DataType = ftInteger
      end
      item
        Name = 'Pod'
        DataType = ftInteger
      end
      item
        Name = 'Stojak'
        DataType = ftInteger
      end
      item
        Name = 'Kv'
        DataType = ftInteger
      end
      item
        Name = 'DK'
        DataType = ftInteger
      end
      item
        Name = 'ShK'
        DataType = ftInteger
      end
      item
        Name = 'LU'
        DataType = ftInteger
      end
      item
        Name = 'Ved'
        DataType = ftInteger
      end
      item
        Name = 'DisconReason'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'Dttm_Discon'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Dttm_ConnWait'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Podrazd'
        DataType = ftString
        Size = 25
      end>
    Left = 344
    Top = 16
    object ResultDsetPodrazd: TStringField
      DisplayLabel = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      FieldName = 'Podrazd'
      Size = 25
    end
    object ResultDsetregion: TStringField
      DisplayLabel = #1056#1072#1081#1086#1085
      FieldName = 'region'
    end
    object ResultDsetAdres: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      DisplayWidth = 64
      FieldName = 'Adres'
      Size = 180
    end
    object ResultDsetZhd: TIntegerField
      DisplayLabel = #1046'/'#1044
      DisplayWidth = 5
      FieldName = 'Zhd'
    end
    object ResultDsetPod: TIntegerField
      DisplayLabel = #1055#1086#1076
      DisplayWidth = 5
      FieldName = 'Pod'
    end
    object ResultDsetStojak: TIntegerField
      DisplayLabel = #1057#1090#1086#1103#1082
      DisplayWidth = 5
      FieldName = 'Stojak'
    end
    object ResultDsetKv: TIntegerField
      DisplayLabel = #1082#1074
      DisplayWidth = 5
      FieldName = 'Kv'
    end
    object ResultDsetDK: TIntegerField
      DisplayLabel = #1076'/'#1082
      DisplayWidth = 5
      FieldName = 'DK'
    end
    object ResultDsetShK: TIntegerField
      DisplayLabel = #1096#1082
      DisplayWidth = 5
      FieldName = 'ShK'
    end
    object ResultDsetLU: TIntegerField
      DisplayLabel = #1083'/'#1091
      DisplayWidth = 5
      FieldName = 'LU'
    end
    object ResultDsetVed: TIntegerField
      DisplayLabel = #1074#1077#1076
      DisplayWidth = 5
      FieldName = 'Ved'
    end
    object ResultDsetDisconReason: TStringField
      DisplayLabel = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
      DisplayWidth = 30
      FieldName = 'DisconReason'
      Size = 64
    end
    object ResultDsetDttm_Discon: TStringField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1082#1083'.'
      FieldName = 'Dttm_Discon'
    end
    object ResultDsetDttm_ConnWait: TStringField
      DisplayLabel = #1054#1078#1080#1076#1072#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1074#1082#1083'.'
      FieldName = 'Dttm_ConnWait'
    end
  end
  object ds_result: TDataSource
    DataSet = ResultDset
    Left = 344
    Top = 64
  end
  object frReport: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 344
    Top = 136
    ReportForm = {19000000}
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = ResultDset
    Left = 408
    Top = 136
  end
end
