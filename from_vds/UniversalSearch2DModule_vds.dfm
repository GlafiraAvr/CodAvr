inherited dm_UniversalSearch2_vds: Tdm_UniversalSearch2_vds
  Left = 604
  Top = 596
  Height = 295
  Width = 442
  inherited frReport: TfrReport
    Dataset = frDS_Result
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 176
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 128
    Top = 120
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 256
    Top = 24
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetOrderNumber: TStringField
      FieldName = 'OrderNumber'
      Size = 15
    end
    object ResultDsetDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object ResultDsetMessageTypes: TStringField
      FieldName = 'MessageTypes'
      Size = 50
    end
    object ResultDsetRegions: TStringField
      FieldName = 'Regions'
      Size = 32
    end
    object ResultDsetDamageType: TStringField
      FieldName = 'DamageType'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 200
    end
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetptr_add_info: TIntegerField
      FieldName = 'ptr_add_info'
    end
    object ResultDsetFullOrderNum: TStringField
      FieldName = 'FullOrderNum'
    end
    object ResultDsetDateClosed: TStringField
      FieldName = 'DateClosed'
    end
    object ResultDsetstart_regions: TStringField
      FieldName = 'start_region'
      Size = 18
    end
    object ResultDsetend_region: TStringField
      FieldName = 'end_region'
      Size = 18
    end
    object ResultDsetpr_startregion: TStringField
      FieldName = 'pr_startregion'
      Size = 2
    end
    object ResultDsetpr_endregion: TStringField
      FieldName = 'pr_endregion'
      Size = 2
    end
    object ResultDsetnumber: TIntegerField
      FieldName = 'number'
    end
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 24
    Top = 88
  end
end
