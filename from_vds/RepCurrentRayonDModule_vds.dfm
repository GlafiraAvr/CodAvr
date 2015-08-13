inherited dm_RepCurrentRayon_vds: Tdm_RepCurrentRayon_vds
  Height = 336
  Width = 344
  inherited frReport: TfrReport
    Left = 8
    ReportForm = {19000000}
  end
  inherited ResultDset: TRxMemoryData
    object ResultDsetstreet_num: TIntegerField
      FieldName = 'street_num'
    end
    object ResultDsethousenum: TStringField
      FieldName = 'housenum'
      Size = 10
    end
    object ResultDsetPorchNum: TStringField
      FieldName = 'PorchNum'
      Size = 10
    end
    object ResultDsetfloornum: TStringField
      FieldName = 'floornum'
      Size = 10
    end
    object ResultDsetapartmentnum: TStringField
      FieldName = 'apartmentnum'
      Size = 10
    end
    object ResultDsetstreet_name: TStringField
      FieldName = 'street_name'
    end
    object ResultDsetstr_type: TStringField
      FieldName = 'str_type'
      Size = 8
    end
  end
  object dset_street: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select st.name s_type, ss.name '
      'from s_streets ss,s_streettypes  st'
      'where ss.fk_streets_streettypes=st.id'
      'and ss.id=:id_street')
    Left = 200
    Top = 216
  end
end
