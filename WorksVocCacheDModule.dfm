inherited dm_WorksVocCache: Tdm_WorksVocCache
  OldCreateOrder = True
  Left = 434
  Top = 352
  Height = 352
  Width = 497
  object cds_Works: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_works order by name'
    Params = <>
    Left = 144
    Top = 24
    object cds_Worksid: TIntegerField
      FieldName = 'id'
    end
    object cds_Worksactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object cds_Worksname: TStringField
      FieldName = 'name'
    end
  end
  object cds_Diam: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, diameter, activity from s_tubediameter order by diame' +
      'ter'
    Params = <>
    Left = 264
    Top = 24
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
end
