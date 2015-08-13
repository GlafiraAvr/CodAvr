object dm_AVRDisconn: Tdm_AVRDisconn
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Left = 386
  Top = 336
  Height = 248
  Width = 441
  object dset_NS: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 104
    Top = 64
  end
  object dset_VDS: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_VDS
    Left = 96
    Top = 120
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
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
      end
      item
        Name = 'id_disconnection'
        DataType = ftInteger
      end
      item
        Name = 'id_podr'
        DataType = ftInteger
      end>
    Left = 256
    Top = 24
    object ResultDsetPodrazd: TStringField
      DisplayLabel = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      DisplayWidth = 23
      FieldName = 'Podrazd'
      Size = 25
    end
    object ResultDsetregion: TStringField
      DisplayLabel = #1056#1072#1081#1086#1085
      FieldName = 'region'
    end
    object ResultDsetAdres: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      DisplayWidth = 40
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
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetid_disconnection: TIntegerField
      FieldName = 'id_disconnection'
    end
    object ResultDsetid_podr: TIntegerField
      FieldName = 'id_podr'
    end
    object ResultDsetdttm_con: TStringField
      DisplayWidth = 20
      FieldName = 'dttm_con'
    end
    object ResultDsetG_ATG: TIntegerField
      FieldName = 'G_ATG'
    end
    object ResultDsetG_GV: TStringField
      DisplayWidth = 5
      FieldName = 'G_GV'
      Size = 5
    end
    object ResultDsetAll_ZND: TIntegerField
      FieldName = 'All_ZND'
    end
    object ResultDsetG_ST_SP: TIntegerField
      FieldName = 'G_ST_SP'
    end
    object ResultDsetISPRIVATESEC: TIntegerField
      FieldName = 'ISPRIVATESEC'
    end
    object ResultDsetweak_press: TBooleanField
      FieldName = 'weak_press'
    end
  end
  object ds_result: TDataSource
    DataSet = ResultDset
    Left = 256
    Top = 72
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = ResultDset
    Left = 320
    Top = 144
  end
  object tran_VDS: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 120
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 64
  end
  object frReport1: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 320
    Top = 40
    ReportForm = {19000000}
  end
  object IBSQL_NS: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 152
    Top = 64
  end
  object IBSQL_VDS: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_VDS
    Left = 152
    Top = 120
  end
end
