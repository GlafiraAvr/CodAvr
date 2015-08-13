inherited dm_ActExeWorks_vds: Tdm_ActExeWorks_vds
  Left = 565
  Top = 547
  Height = 250
  Width = 359
  inherited frReport: TfrReport
    ModifyPrepared = False
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 16
    Top = 160
    object ResultDsetID: TIntegerField
      FieldName = 'ID'
    end
    object ResultDsetAPPLICANT: TStringField
      FieldName = 'APPLICANT'
      Size = 30
    end
    object ResultDsetADRES: TStringField
      FieldName = 'ADRES'
      Size = 200
    end
    object ResultDsetREGION: TStringField
      FieldName = 'REGION'
    end
    object ResultDsetWORKS: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetdistrict: TStringField
      FieldName = 'district'
    end
    object ResultDsetDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object ResultDsetDateClosed: TDateTimeField
      FieldName = 'DateClosed'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 88
    Top = 96
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 144
    Top = 96
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.name WorksName'
      'from departurework_vds dw'
      'left join s_works sw on sw.id=dw.fk_depwork_works'
      'where dw.fk_depwork_orders=:pOrderID')
    Left = 232
    Top = 88
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 96
  end
end
