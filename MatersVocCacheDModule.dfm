inherited dm_MatersVocCache: Tdm_MatersVocCache
  OldCreateOrder = True
  Left = 387
  Top = 330
  object cds_Diam: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, diameter, activity from s_tubediameter order by diame' +
      'ter'
    Params = <>
    Left = 288
    Top = 32
    object cds_Diamid: TIntegerField
      FieldName = 'id'
    end
    object cds_Diamdiameter: TIntegerField
      FieldName = 'diameter'
    end
    object cds_Diamactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
  object cds_Maters: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, rtrim(name)||'#39' ('#39'||rtrim(measurement)||'#39')'#39'  name_r, a' +
      'ctivity from materials order by 2'
    Params = <>
    Left = 152
    Top = 32
    object cds_Matersid: TIntegerField
      FieldName = 'id'
    end
    object cds_Matersname_r: TStringField
      FieldName = 'name_r'
      OnGetText = cds_Matersname_rGetText
    end
    object cds_Matersactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
end
