object dm_saveSVGikXML: Tdm_saveSVGikXML
  OldCreateOrder = False
  Left = 288
  Top = 109
  Height = 252
  Width = 306
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 24
    Top = 24
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 160
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 88
    Top = 160
  end
  object dset_byregions: TIBDataSet
    Left = 80
    Top = 80
  end
  object dset_bystreet: TIBDataSet
    Left = 168
    Top = 80
  end
  object md_DmgByRegion: TRxMemoryData
    FieldDefs = <>
    Left = 88
    Top = 24
    object md_DmgByRegionreg_name: TStringField
      FieldName = 'reg_name'
      Size = 15
    end
    object md_DmgByRegionvseti: TIntegerField
      FieldName = 'vseti'
    end
    object md_DmgByRegionvvody: TIntegerField
      FieldName = 'vvody'
    end
    object md_DmgByRegionkolodcy: TIntegerField
      FieldName = 'kolodcy'
    end
    object md_DmgByRegionkolonky: TIntegerField
      FieldName = 'kolonky'
    end
    object md_DmgByRegionkanal: TIntegerField
      FieldName = 'kanal'
    end
    object md_DmgByRegionPodtopTepSetei: TIntegerField
      FieldName = 'PodtopTepSetei'
    end
    object md_DmgByRegionluk: TIntegerField
      FieldName = 'luk'
    end
    object md_DmgByRegionNetLukov: TIntegerField
      FieldName = 'NetLukov'
    end
    object md_DmgByRegionid_reg: TIntegerField
      FieldName = 'id_reg'
    end
  end
  object md_DmgByStreet: TRxMemoryData
    FieldDefs = <>
    Left = 168
    Top = 24
    object md_DmgByStreetgroup_number: TIntegerField
      FieldName = 'group_number'
    end
    object md_DmgByStreetcount: TIntegerField
      FieldName = 'count'
    end
  end
end
