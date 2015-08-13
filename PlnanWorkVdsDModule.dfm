inherited dm_PlanWorkVds: Tdm_PlanWorkVds
  Left = 610
  Top = 404
  inherited frReport: TfrReport
    Left = 32
    ReportForm = {19000000}
  end
  object dset_work: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 104
    Top = 128
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 32
    Top = 128
  end
  object md_table: TRxMemoryData
    FieldDefs = <>
    Left = 104
    Top = 72
    object md_tableRegion: TStringField
      DisplayWidth = 20
      FieldName = 'Region'
    end
    object md_tablebrigadier: TStringField
      FieldName = 'brigadier'
    end
    object md_tableworkerscount: TIntegerField
      FieldName = 'workerscount'
    end
    object md_tablestartdate: TStringField
      FieldName = 'startdate'
      Size = 15
    end
    object md_tableADRESS: TStringField
      FieldName = 'ADRESS'
      Size = 100
    end
    object md_tableWork_avar: TStringField
      FieldName = 'Work_avar'
      Size = 1000
    end
    object md_tableWork_tex: TStringField
      FieldName = 'Work_tex'
      Size = 50
    end
    object md_tableMater_name: TStringField
      FieldName = 'Mater_name'
      Size = 1000
    end
    object md_tableMater_quantity: TIntegerField
      FieldName = 'Mater_quantity'
    end
    object md_tableAddInfo: TStringField
      FieldName = 'AddInfo'
      Size = 200
    end
    object md_tableMater_quantity_string: TStringField
      FieldName = 'Mater_quantity_string'
      Size = 200
    end
    object md_tablestrartDateD: TDateTimeField
      FieldName = 'strartDateD'
    end
    object md_tableplanendDate: TDateTimeField
      FieldName = 'planendDate'
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = md_table
    Left = 32
    Top = 72
  end
  object dset_maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 168
    Top = 128
  end
  object dset_main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 64
    Top = 192
  end
end
