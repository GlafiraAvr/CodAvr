inherited dm_BoltsVocCache: Tdm_BoltsVocCache
  OldCreateOrder = True
  object cds_Diam: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select sd.id, (select strval from tochar(sd.diameter)) as name, ' +
      'sd.activity from s_tubediameter sd order by sd.diameter'
    Params = <>
    Left = 128
    Top = 16
    object cds_Diamid: TIntegerField
      FieldName = 'id'
    end
    object cds_Diamname: TStringField
      FieldName = 'name'
    end
    object cds_Diamactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object cds_BrigClose: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, name, activity from brigadiers where id>0 order by na' +
      'me'
    Params = <>
    Left = 224
    Top = 16
    object cds_BrigCloseid: TIntegerField
      FieldName = 'id'
    end
    object cds_BrigClosename: TStringField
      FieldName = 'name'
    end
    object cds_BrigCloseactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object cds_BrigOpen: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, name, activity from brigadiers where id>0 order by na' +
      'me'
    Params = <>
    Left = 328
    Top = 16
    object cds_BrigOpenid: TIntegerField
      FieldName = 'id'
    end
    object cds_BrigOpenname: TStringField
      FieldName = 'name'
    end
    object cds_BrigOpenactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
end
