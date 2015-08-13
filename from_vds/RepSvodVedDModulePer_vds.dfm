inherited dm_RepSvodVedPer_vds: Tdm_RepSvodVedPer_vds
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object md_CountByRegSum: TRxMemoryData
    FieldDefs = <>
    Left = 320
    Top = 48
    object IntegerField1: TIntegerField
      FieldName = 'id_reg'
    end
    object StringField1: TStringField
      FieldName = 'Region'
      Size = 50
    end
    object IntegerField2: TIntegerField
      FieldName = 'o62_prin'
    end
    object IntegerField3: TIntegerField
      FieldName = 'ods_prin'
    end
    object IntegerField4: TIntegerField
      FieldName = 'zhitel_prin'
    end
    object IntegerField5: TIntegerField
      FieldName = 'sum_prin'
    end
    object IntegerField6: TIntegerField
      FieldName = 'o62_vip'
    end
    object IntegerField7: TIntegerField
      FieldName = 'ods_vip'
    end
    object IntegerField8: TIntegerField
      FieldName = 'zhitel_vip'
    end
    object IntegerField9: TIntegerField
      FieldName = 'sum_vip'
    end
    object FloatField1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'percent_vip'
      DisplayFormat = '0.##'
      Calculated = True
    end
    object IntegerField10: TIntegerField
      FieldName = 'ostalos'
    end
  end
end
