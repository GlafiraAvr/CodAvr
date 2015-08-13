inherited dm_NGRepInfBlag: Tdm_NGRepInfBlag
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object Resultdset: TRxMemoryData
    FieldDefs = <>
    Left = 64
    Top = 16
    object Resultdsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object Resultdsetordernumber: TStringField
      FieldName = 'ordernumber'
      Size = 10
    end
    object Resultdsetadress: TStringField
      FieldName = 'adress'
      Size = 50
    end
    object ResultdsetPlan_kol: TIntegerField
      FieldName = 'Plan_kol'
    end
    object ResultdsetPlan_SQUARE: TFloatField
      FieldName = 'Plan_SQUARE'
    end
    object ResultdsetFact_kol: TIntegerField
      FieldName = 'Fact_kol'
    end
    object ResultdsetFact_SQUARE: TFloatField
      FieldName = 'Fact_SQUARE'
    end
    object ResultdsetASFCOMPANY: TStringField
      FieldName = 'ASFCOMPANY'
    end
    object ResultdsetRegion: TStringField
      FieldName = 'Region'
    end
    object Resultdsetprim: TStringField
      FieldName = 'prim'
      Size = 15
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = Resultdset
    Left = 40
    Top = 88
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 152
    Top = 88
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 152
    Top = 136
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name'
      'from s_regions'
      'where (id>0) and (activity is null)'
      'order by name')
    Left = 40
    Top = 168
  end
  object dset_adress: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 184
  end
end
