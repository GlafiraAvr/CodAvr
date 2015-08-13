inherited dm_EquipsVocCache: Tdm_EquipsVocCache
  OldCreateOrder = True
  object cds_Equips: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select id, name, number, activity,iif (e.gos_number is null , rt' +
      'rim(name)||'#39' '#8470#39'||number,'#39' '#8470#39'||rtrim(e.gos_number)||'#39'('#39'||rtrim(na' +
      'me)||'#39' '#8470#39'||number||'#39')-'#39'||e.v_kovsh||'#39#1084'3'#39') name_r from equipment ' +
      'e order by name, number'
    Params = <>
    Left = 160
    Top = 24
    object cds_Equipsid: TIntegerField
      FieldName = 'id'
    end
    object cds_Equipsname_r: TStringField
      FieldName = 'name_r'
      OnGetText = cds_Equipsname_rGetText
      Size = 50
    end
    object cds_Equipsactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
  end
end
