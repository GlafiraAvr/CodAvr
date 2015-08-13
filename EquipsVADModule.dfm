inherited dm_EquipsVA: Tdm_EquipsVA
  OldCreateOrder = True
  Left = 567
  Top = 278
  Height = 213
  Width = 238
  object mt_Equips: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_Equipment
    AttachedAutoRefresh = True
    AttachMaxCount = 5
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'id_region'
        DataType = ftInteger
      end
      item
        Name = 'id_vocrectype'
        DataType = ftInteger
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'is_visible_for_cur_district'
        DataType = ftSmallint
      end
      item
        Name = 'fl_FULL_NAME'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'v_kovsh'
        DataType = ftFloat
      end
      item
        Name = 'gos_number'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'shot_name'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'id_typ'
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 16
    Top = 8
    object mt_EquipsFULL_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'FULL_NAME'
      Size = 40
      Calculated = True
    end
  end
end
