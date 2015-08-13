inherited dm_GetOst1562: Tdm_GetOst1562
  Left = 868
  Top = 388
  Height = 407
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 16
    Top = 112
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 24
    Top = 72
  end
  object tran_1562: TIBTransaction
    Left = 72
    Top = 80
  end
  object dset_1562: TIBDataSet
    Transaction = tran_1562
    Left = 64
    Top = 136
  end
  object md_result: TRxMemoryData
    FieldDefs = <>
    ObjectView = True
    Left = 184
    Top = 80
    object md_resultdt: TDateTimeField
      FieldName = 'dt'
    end
    object md_resultid_region: TIntegerField
      FieldName = 'id_region'
    end
    object md_resultPlace: TStringField
      FieldName = 'Place'
      Size = 4
    end
    object md_resultvalue: TIntegerField
      FieldName = 'value'
    end
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 136
    Top = 184
  end
  object ADOQry: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 24
    Top = 192
  end
  object ADOQ_selOst1562: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 24
    Top = 256
  end
end
