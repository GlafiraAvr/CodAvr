inherited dm_DepartureVocCache: Tdm_DepartureVocCache
  OldCreateOrder = True
  Left = 337
  Top = 436
  Height = 250
  Width = 274
  object cds_Brig: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select ID, NAME, ACTIVITY from BRIGADIERS where ID>0 order by NA' +
      'ME'
    Params = <>
    Left = 144
    Top = 24
    object cds_BrigID: TIntegerField
      FieldName = 'ID'
    end
    object cds_BrigNAME: TStringField
      FieldName = 'NAME'
    end
    object cds_BrigACTIVITY: TStringField
      FieldName = 'ACTIVITY'
      Size = 1
    end
  end
end
