inherited dm_STexn: Tdm_STexn
  Left = 773
  Top = 446
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 96
    Top = 16
  end
  object md_REsult: TRxMemoryData
    FieldDefs = <>
    Left = 32
    Top = 144
    object md_REsultid_Region: TIntegerField
      FieldName = 'id_Region'
    end
    object md_REsultRegion: TStringField
      FieldName = 'Region'
    end
    object md_REsultfk_order_damageplace: TIntegerField
      FieldName = 'fk_order_damageplace'
    end
    object md_REsultdamagePlace: TStringField
      FieldName = 'damagePlace'
    end
    object md_REsultplan_people: TIntegerField
      FieldName = 'plan_people'
    end
    object md_REsultExcav: TStringField
      FieldName = 'Excav'
      Size = 1000
    end
    object md_REsultavm: TStringField
      FieldName = 'avm'
      Size = 1000
    end
    object md_REsultSams: TStringField
      FieldName = 'Sams'
      Size = 1000
    end
    object md_REsultBort: TStringField
      FieldName = 'Bort'
      Size = 400
    end
    object md_REsultAvKran: TStringField
      FieldName = 'AvKran'
      Size = 200
    end
    object md_REsultBuld: TStringField
      FieldName = 'Buld'
      Size = 400
    end
    object md_REsultpogr: TStringField
      FieldName = 'pogr'
      Size = 100
    end
    object md_REsultgmolot: TStringField
      FieldName = 'gmolot'
      Size = 100
    end
    object md_REsultpris: TStringField
      FieldName = 'pris'
      Size = 100
    end
    object md_REsulttrak: TStringField
      FieldName = 'trak'
      Size = 400
    end
    object md_REsultadd_info: TStringField
      FieldName = 'add_info'
      Size = 500
    end
    object md_REsultAdress: TStringField
      FieldName = 'Adress'
      Size = 100
    end
    object md_REsultS_DateTime: TDateTimeField
      FieldName = 'S_DateTime'
    end
    object md_REsultDepId: TIntegerField
      FieldName = 'DepId'
    end
    object md_REsultbrig: TStringField
      FieldName = 'brig'
    end
    object md_REsultBar: TStringField
      FieldName = 'Bar'
      Size = 500
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 88
    Top = 88
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = md_REsult
    Left = 24
    Top = 64
  end
end
