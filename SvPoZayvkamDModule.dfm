inherited dm_SvPoZayvkam: Tdm_SvPoZayvkam
  Left = 696
  Top = 298
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object md_result: TRxMemoryData
    FieldDefs = <>
    Left = 72
    Top = 72
    object md_resultid_1562: TIntegerField
      FieldName = 'id_1562'
    end
    object md_resultnumber: TStringField
      FieldName = 'number'
      Size = 30
    end
    object md_resultDateOurRequest: TStringField
      FieldName = 'DateOurRequest'
    end
    object md_resultadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object md_resultabout: TStringField
      FieldName = 'about'
      Size = 1000
    end
    object md_resultwhy_not: TStringField
      FieldName = 'why_not'
      Size = 200
    end
    object md_resultBrigname: TStringField
      FieldName = 'Brigname'
    end
    object md_resultregion: TStringField
      FieldName = 'region'
    end
    object md_resultid_region: TIntegerField
      FieldName = 'id_region'
    end
    object md_resultid_order: TIntegerField
      FieldName = 'id_order'
    end
    object md_resultgroup: TIntegerField
      FieldName = 'group'
    end
    object md_resultordernumber: TStringField
      FieldName = 'order_number'
      Size = 10
    end
    object md_resultdopfield: TIntegerField
      FieldName = 'dopfield'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 80
    Top = 128
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 152
    Top = 128
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select  id,name from s_regions where id>0')
    Left = 152
    Top = 80
    object dset_regionID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_regionNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
  end
  object ADOQ_work: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 128
    Top = 192
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = md_result
    Left = 72
    Top = 16
  end
end
