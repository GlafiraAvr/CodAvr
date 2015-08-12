inherited dm_Address: Tdm_Address
  OldCreateOrder = True
  Left = 302
  Top = 269
  Height = 324
  Width = 464
  object cds_HouseType: TClientDataSet
    Aggregates = <>
    CommandText = 'select id, name, activity from s_housetype order by id'
    Params = <>
    Left = 160
    Top = 24
    object cds_HouseTypeid: TIntegerField
      FieldName = 'id'
      OnChange = cds_HouseTypeidChange
    end
    object cds_HouseTypename: TStringField
      FieldName = 'name'
    end
    object cds_HouseTypeactivity: TIntegerField
      FieldName = 'activity'
    end
  end
  object cds_Street1: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select s.id,(select name from Get_FullStreetName(s.id)) as name,' +
      's.activity from s_streets s order by name'
    Params = <>
    Left = 272
    Top = 24
    object cds_Street1id: TIntegerField
      FieldName = 'id'
    end
    object cds_Street1name: TStringField
      FieldName = 'name'
      Size = 100
    end
    object cds_Street1activity: TIntegerField
      FieldName = 'activity'
    end
  end
  object cds_Street2: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select s.id,(select name from Get_FullStreetName(s.id)) as name,' +
      's.activity from s_streets s order by name'
    Params = <>
    Left = 368
    Top = 24
    object cds_Street2id: TIntegerField
      FieldName = 'id'
    end
    object cds_Street2name: TStringField
      FieldName = 'name'
      Size = 100
    end
    object cds_Street2activity: TIntegerField
      FieldName = 'activity'
    end
  end
end
