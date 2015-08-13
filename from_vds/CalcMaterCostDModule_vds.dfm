inherited dm_CalcMaterCost_vds: Tdm_CalcMaterCost_vds
  Left = 438
  Top = 397
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    OnCalcFields = ResultDsetCalcFields
    Left = 88
    Top = 16
    object ResultDsetRowNumber: TIntegerField
      FieldName = 'RowNumber'
    end
    object ResultDsetStartDate: TDateField
      FieldName = 'StartDate'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 200
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 50
    end
    object ResultDsetworks: TStringField
      FieldName = 'works'
      Size = 200
    end
    object ResultDsetMater: TStringField
      FieldName = 'Mater'
      Size = 50
    end
    object ResultDsetMeasurement: TStringField
      FieldName = 'Measurement'
    end
    object ResultDsetQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object ResultDsetPrice: TFloatField
      FieldName = 'Price'
    end
    object ResultDsetCost: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Cost'
      Calculated = True
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 216
    Top = 88
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 152
    Top = 88
  end
  object frDset: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 96
  end
  object dset_Maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select m.name, m.measurement, dm.price, sum(dm.quantity) quantit' +
        'y'
      'from departurematerials_vds dm'
      'left join materials m on m.id=dm.fk_usedmaterials_materials'
      'where dm.fk_usedmaterials_departure=:pDepID'
      'and IsPayed=0'
      'group by m.name, m.measurement, dm.price')
    Left = 32
    Top = 176
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.name WorksName'
      'from departurework_vds dw'
      'left join s_works sw on sw.id=dw.fk_depwork_works'
      'where dw.fk_depwork_departure=:pDepID'
      'and IsPayed=0')
    Left = 136
    Top = 176
  end
end
