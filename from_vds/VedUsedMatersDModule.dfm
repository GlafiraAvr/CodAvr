inherited dm_VedUsedMaters: Tdm_VedUsedMaters
  Left = 435
  Top = 359
  Height = 243
  Width = 346
  inherited frReport: TfrReport
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
    object ResultDsetMATERS: TStringField
      FieldName = 'MATERS'
      Size = 200
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
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 96
  end
  object dset_Maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    OnCalcFields = dset_MatersCalcFields
    SelectSQL.Strings = (
      'select m.name, m.measurement, sum(dm.quantity) quantity'
      'from departurematerials dm'
      'left join materials m on m.id=dm.fk_usedmaterials_materials'
      'where dm.fk_usedmaterials_orders=:pOrderID'
      'group by m.name, m.measurement')
    Left = 232
    Top = 112
    object dset_MatersNAME: TIBStringField
      FieldName = 'NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object dset_MatersMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      ProviderFlags = []
      FixedChar = True
      Size = 16
    end
    object dset_MatersQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object dset_MatersMATERSNAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'MATERSNAME'
      Size = 50
      Calculated = True
    end
  end
end
