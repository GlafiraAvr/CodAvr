inherited dm_RSvodved: Tdm_RSvodved
  Left = 796
  Width = 324
  inherited frReport: TfrReport
    Top = 24
    ReportForm = {19000000}
  end
  object md_res: TRxMemoryData
    FieldDefs = <>
    Left = 16
    Top = 128
    object md_resid_reg: TIntegerField
      FieldName = 'id_reg'
    end
    object md_resRegion: TStringField
      FieldName = 'Region'
      Size = 15
    end
    object md_resabonenet: TStringField
      FieldName = 'APPLICANTFIO'
    end
    object md_rescol_1562: TIntegerField
      FieldName = 'col_1562'
    end
    object md_rescol_zhit: TIntegerField
      FieldName = 'col_zhit'
    end
    object md_resadress: TStringField
      FieldName = 'adress'
      Size = 100
    end
    object md_resAPPLICANTPHONE: TStringField
      FieldName = 'APPLICANTPHONE'
      Size = 15
    end
    object md_resMessage: TStringField
      FieldName = 'Message'
      Size = 30
    end
    object md_resadditionalinfo: TStringField
      FieldName = 'additionalinfo'
      Size = 100
    end
    object md_resbrig: TStringField
      FieldName = 'brig'
      Size = 15
    end
    object md_resexcutwork: TStringField
      DisplayWidth = 400
      FieldName = 'excut_work'
      Size = 400
    end
    object md_resordernumber: TStringField
      FieldName = 'ordernumber'
    end
    object md_resDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object md_resDATECLOSED: TDateTimeField
      FieldName = 'DATECLOSED'
    end
  end
  object frDBD_dm_res: TfrDBDataSet
    DataSet = md_res
    Left = 16
    Top = 72
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 176
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 16
    Top = 184
  end
  object md_res_ns: TRxMemoryData
    FieldDefs = <>
    Left = 120
    Top = 128
    object IntegerField1: TIntegerField
      FieldName = 'id_reg'
    end
    object StringField1: TStringField
      FieldName = 'Region'
      Size = 15
    end
    object StringField2: TStringField
      FieldName = 'APPLICANTFIO'
    end
    object IntegerField2: TIntegerField
      FieldName = 'col_1562'
    end
    object IntegerField3: TIntegerField
      FieldName = 'col_zhit'
    end
    object StringField3: TStringField
      FieldName = 'adress'
      Size = 100
    end
    object StringField4: TStringField
      FieldName = 'APPLICANTPHONE'
      Size = 15
    end
    object StringField5: TStringField
      FieldName = 'Message'
      Size = 30
    end
    object StringField6: TStringField
      FieldName = 'additionalinfo'
      Size = 1000
    end
    object StringField7: TStringField
      FieldName = 'brig'
      Size = 15
    end
    object StringField8: TStringField
      FieldName = 'excut_work'
      Size = 1000
    end
    object StringField11: TStringField
      FieldName = 'ordernumber'
    end
    object md_res_nsDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object md_res_nsDATECLOSED: TDateTimeField
      FieldName = 'DATECLOSED'
    end
  end
  object frDBD_md_res_ns: TfrDBDataSet
    DataSet = md_res_ns
    Left = 112
    Top = 72
  end
end
