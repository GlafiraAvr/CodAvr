inherited dm_UtechkiNaVodoseti: Tdm_UtechkiNaVodoseti
  Left = 688
  Top = 261
  Height = 290
  Width = 561
  inherited frReport: TfrReport
    Left = 208
    Top = 184
    ReportForm = {19000000}
  end
  object md_Podacha: TRxMemoryData
    FieldDefs = <>
    Left = 144
    Top = 8
    object md_PodachaDonec: TFloatField
      FieldName = 'Donec'
    end
    object md_PodachaLednoe: TFloatField
      FieldName = 'Lednoe'
    end
    object md_PodachaSAVH: TFloatField
      FieldName = 'SAVH'
    end
    object md_PodachaItogo: TFloatField
      FieldName = 'Itogo'
    end
  end
  object md_Utechka: TRxMemoryData
    FieldDefs = <>
    Left = 248
    Top = 8
    object md_Utechkaregion: TStringField
      FieldName = 'region'
      Size = 32
    end
    object md_Utechkadamage_count: TIntegerField
      FieldName = 'damage_count'
    end
    object md_Utechkaleak: TFloatField
      FieldName = 'leak'
    end
    object md_Utechkaleak_percent: TFloatField
      FieldName = 'leak_percent'
    end
    object md_Utechkamain_gr: TIntegerField
      FieldName = 'main_gr'
    end
    object md_Utechkaemptibg: TFloatField
      DisplayWidth = 4
      FieldName = 'empting'
    end
    object md_Utechkaleak_kol: TFloatField
      FieldName = 'leak_kol'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait'
      'read')
    Left = 24
    Top = 88
  end
  object dset_bolt: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 184
  end
  object dset_reg: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 184
  end
  object qry_StDisp: TIBQuery
    Database = DM_StDisp.IBDB_StDisp
    Transaction = tran_StDisp
    SQL.Strings = (
      'select b.kpodr,sum(a.znach) znach from energydata a, sprsign b '
      
        '                  where a.num_sign=b.idnum and (b.kpokaz=8) and ' +
        '(b.kupokaz=0) and (b.kpodr in (35,45,8,9,10,14)) '
      
        '                  and (((a.date_p=:date1) and (a.time_p>:time1))' +
        'or'
      '                  ((a.date_p>:date1) and (a.date_p<:date2)) or'
      '                  ((a.date_p=:date2) and (a.time_p<=:time2)))'
      '                  group by b.kpodr')
    Left = 392
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'date1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'time1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'time2'
        ParamType = ptUnknown
      end>
  end
  object tran_StDisp: TIBTransaction
    DefaultDatabase = DM_StDisp.IBDB_StDisp
    Params.Strings = (
      'concurrency'
      'nowait'
      'read')
    Left = 472
    Top = 16
  end
  object frDS_Podacha: TfrDBDataSet
    DataSet = md_Podacha
    Left = 152
    Top = 80
  end
  object frDS_Utechka: TfrDBDataSet
    DataSet = md_Utechka
    Left = 256
    Top = 80
  end
end
