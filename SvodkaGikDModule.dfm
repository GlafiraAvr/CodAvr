inherited dm_SvodkaGik: Tdm_SvodkaGik
  Left = 424
  Top = 378
  Height = 522
  Width = 833
  inherited frReport: TfrReport
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbExit]
    Top = 152
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 16
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 88
    Top = 8
  end
  object md_DmgByRegion: TRxMemoryData
    FieldDefs = <>
    Left = 184
    Top = 8
    object md_DmgByRegionreg_name: TStringField
      FieldName = 'reg_name'
    end
    object md_DmgByRegionVSeti: TIntegerField
      FieldName = 'VSeti'
    end
    object md_DmgByRegionVvody: TIntegerField
      FieldName = 'Vvody'
    end
    object md_DmgByRegionKolodcy: TIntegerField
      FieldName = 'Kolodcy'
    end
    object md_DmgByRegionKolonky: TIntegerField
      FieldName = 'Kolonky'
    end
    object md_DmgByRegionKanal: TIntegerField
      FieldName = 'Kanal'
    end
    object md_DmgByRegionPodtopTepSetei: TIntegerField
      FieldName = 'PodtopTepSetei'
    end
    object md_DmgByRegionLuk: TIntegerField
      FieldName = 'Luk'
    end
    object md_DmgByRegionNetLukov: TIntegerField
      FieldName = 'NetLukov'
    end
    object md_DmgByRegionid_reg: TIntegerField
      FieldName = 'id_reg'
    end
  end
  object frDS_DmgByRegion: TfrDBDataSet
    DataSet = md_DmgByRegion
    Left = 184
    Top = 72
  end
  object md_DmgByStreet: TRxMemoryData
    FieldDefs = <>
    Left = 280
    Top = 8
    object md_DmgByStreetgroup_number: TIntegerField
      FieldName = 'group_number'
    end
    object md_DmgByStreetgroup_name: TStringField
      FieldName = 'group_name'
      Size = 40
    end
    object md_DmgByStreetregion: TStringField
      FieldName = 'region'
    end
    object md_DmgByStreetequip: TStringField
      FieldName = 'equip'
    end
    object md_DmgByStreetadres: TStringField
      FieldName = 'adres'
      Size = 180
    end
    object md_DmgByStreetwithoutexcav: TStringField
      FieldName = 'withoutexcav'
      Size = 50
    end
  end
  object frDS_DmgByStreet: TfrDBDataSet
    DataSet = md_DmgByStreet
    Left = 288
    Top = 72
  end
  object md_EquipLikvid: TRxMemoryData
    FieldDefs = <>
    Left = 384
    Top = 8
    object md_EquipLikviddz_zap: TStringField
      FieldName = 'dz_zap'
    end
    object md_EquipLikviddz_rab: TStringField
      FieldName = 'dz_rab'
    end
    object md_EquipLikvidki_zap: TStringField
      FieldName = 'ki_zap'
    end
    object md_EquipLikvidki_rab: TStringField
      FieldName = 'ki_rab'
    end
    object md_EquipLikvidko_zap: TStringField
      FieldName = 'ko_zap'
    end
    object md_EquipLikvidko_rab: TStringField
      FieldName = 'ko_rab'
    end
    object md_EquipLikvidle_zap: TStringField
      FieldName = 'le_zap'
    end
    object md_EquipLikvidle_rab: TStringField
      FieldName = 'le_rab'
    end
    object md_EquipLikvidmo_zap: TStringField
      FieldName = 'mo_zap'
    end
    object md_EquipLikvidmo_rab: TStringField
      FieldName = 'mo_rab'
    end
    object md_EquipLikvidok_zap: TStringField
      FieldName = 'ok_zap'
    end
    object md_EquipLikvidok_rab: TStringField
      FieldName = 'ok_rab'
    end
    object md_EquipLikvidor_zap: TStringField
      FieldName = 'or_zap'
    end
    object md_EquipLikvidor_rab: TStringField
      FieldName = 'or_rab'
    end
    object md_EquipLikvidfr_zap: TStringField
      FieldName = 'fr_zap'
    end
    object md_EquipLikvidfr_rab: TStringField
      FieldName = 'fr_rab'
    end
    object md_EquipLikvidch_zap: TStringField
      FieldName = 'ch_zap'
    end
    object md_EquipLikvidch_rab: TStringField
      FieldName = 'ch_rab'
    end
  end
  object frDS_EquipLikvid: TfrDBDataSet
    DataSet = md_EquipLikvid
    Left = 384
    Top = 72
  end
  object md_EquipBlago_old: TRxMemoryData
    FieldDefs = <>
    Left = 504
    Top = 128
    object md_EquipBlago_olddz: TStringField
      FieldName = 'dz'
    end
    object md_EquipBlago_oldki: TStringField
      FieldName = 'ki'
    end
    object md_EquipBlago_oldko: TStringField
      FieldName = 'ko'
    end
    object md_EquipBlago_oldle: TStringField
      FieldName = 'le'
    end
    object md_EquipBlago_oldmo: TStringField
      FieldName = 'mo'
    end
    object md_EquipBlago_oldok: TStringField
      FieldName = 'ok'
    end
    object md_EquipBlago_oldor: TStringField
      FieldName = 'or'
    end
    object md_EquipBlago_oldfr: TStringField
      FieldName = 'fr'
    end
    object md_EquipBlago_oldch: TStringField
      FieldName = 'ch'
    end
  end
  object frDS_EquipBlago: TfrDBDataSet
    DataSet = md_EquipBlago
    Left = 488
    Top = 72
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 88
    Top = 64
  end
  object mt_Disconnections: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 608
    Top = 8
  end
  object frDS_Disconnections: TfrDBDataSet
    DataSet = mt_Disconnections
    Left = 608
    Top = 72
  end
  object mt_Meteo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 736
    Top = 8
    object mt_Meteomydate: TDateTimeField
      FieldName = 'mydate'
    end
    object mt_Meteomytime: TDateTimeField
      FieldName = 'mytime'
    end
    object mt_Meteotemperate: TIntegerField
      FieldName = 'temperate'
    end
    object mt_Meteotemperate_night: TIntegerField
      FieldName = 'temperate_night'
    end
    object mt_Meteospeed: TIntegerField
      FieldName = 'speed'
    end
    object mt_Meteocloudsn: TStringField
      FieldName = 'cloudsn'
      Size = 25
    end
    object mt_Meteoosadkin: TStringField
      FieldName = 'osadkin'
    end
    object mt_Meteoshtormn: TStringField
      FieldName = 'shtormn'
      Size = 25
    end
    object mt_Meteowindn: TStringField
      FieldName = 'windn'
      Size = 25
    end
  end
  object frDS_Meteo: TfrDBDataSet
    DataSet = mt_Meteo
    Left = 736
    Top = 72
  end
  object md_EquipBlagoForGen: TRxMemoryData
    FieldDefs = <>
    Left = 496
    Top = 248
    object StringField1: TStringField
      FieldName = 'dz'
    end
    object StringField2: TStringField
      FieldName = 'ki'
    end
    object StringField3: TStringField
      FieldName = 'ko'
    end
    object StringField4: TStringField
      FieldName = 'le'
    end
    object StringField5: TStringField
      FieldName = 'mo'
    end
    object StringField6: TStringField
      FieldName = 'ok'
    end
    object StringField7: TStringField
      FieldName = 'or'
    end
    object StringField8: TStringField
      FieldName = 'fr'
    end
    object StringField9: TStringField
      FieldName = 'ch'
    end
  end
  object frDS_EquipBlagoForGen: TfrDBDataSet
    DataSet = md_EquipBlagoForGen
    Left = 496
    Top = 304
  end
  object md_DmgByStreetForGen: TRxMemoryData
    FieldDefs = <>
    Left = 296
    Top = 216
    object IntegerField1: TIntegerField
      FieldName = 'group_number'
    end
    object StringField10: TStringField
      FieldName = 'group_name'
      Size = 40
    end
    object StringField11: TStringField
      FieldName = 'region'
    end
    object StringField12: TStringField
      FieldName = 'equip'
    end
    object StringField13: TStringField
      FieldName = 'adres'
      Size = 180
    end
  end
  object frDS_DmgByStreetForGen: TfrDBDataSet
    DataSet = md_DmgByStreetForGen
    Left = 296
    Top = 272
  end
  object md_EquipBlago: TRxMemoryData
    FieldDefs = <>
    Left = 488
    Top = 16
    object StringField14: TStringField
      FieldName = 'dz_zap'
    end
    object StringField15: TStringField
      FieldName = 'dz_rab'
    end
    object StringField16: TStringField
      FieldName = 'ki_zap'
    end
    object StringField17: TStringField
      FieldName = 'ki_rab'
    end
    object StringField18: TStringField
      FieldName = 'ko_zap'
    end
    object StringField19: TStringField
      FieldName = 'ko_rab'
    end
    object StringField20: TStringField
      FieldName = 'le_zap'
    end
    object StringField21: TStringField
      FieldName = 'le_rab'
    end
    object StringField22: TStringField
      FieldName = 'mo_zap'
    end
    object StringField23: TStringField
      FieldName = 'mo_rab'
    end
    object StringField24: TStringField
      FieldName = 'ok_zap'
    end
    object StringField25: TStringField
      FieldName = 'ok_rab'
    end
    object StringField26: TStringField
      FieldName = 'or_zap'
    end
    object StringField27: TStringField
      FieldName = 'or_rab'
    end
    object StringField28: TStringField
      FieldName = 'fr_zap'
    end
    object StringField29: TStringField
      FieldName = 'fr_rab'
    end
    object StringField30: TStringField
      FieldName = 'ch_zap'
    end
    object StringField31: TStringField
      FieldName = 'ch_rab'
    end
  end
  object frDS_OpenOrdersGenDir: TfrDBDataSet
    DataSet = mt_OpenOrdersGenDir
    Left = 664
    Top = 312
  end
  object mt_OpenOrdersGenDir: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 664
    Top = 248
    object mt_OpenOrdersGenDirOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object mt_OpenOrdersGenDirDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object mt_OpenOrdersGenDirfk_orders_regions: TIntegerField
      FieldName = 'fk_orders_regions'
    end
    object mt_OpenOrdersGenDirRegions: TStringField
      FieldName = 'Regions'
    end
    object mt_OpenOrdersGenDiradres: TStringField
      FieldName = 'adres'
      Size = 200
    end
  end
  object frds_DmgByStreet2: TfrDBDataSet
    DataSet = md_DmgByStreet2
    Left = 192
    Top = 288
  end
  object md_DmgByStreet2: TRxMemoryData
    FieldDefs = <>
    Left = 184
    Top = 224
    object IntegerField2: TIntegerField
      FieldName = 'group_number'
    end
    object StringField32: TStringField
      FieldName = 'group_name'
      Size = 100
    end
    object StringField33: TStringField
      FieldName = 'region'
    end
    object StringField34: TStringField
      FieldName = 'equip'
    end
    object StringField35: TStringField
      FieldName = 'adres'
      Size = 180
    end
    object md_DmgByStreet2withoutexcav: TStringField
      FieldName = 'withoutexcav'
      Size = 50
    end
  end
  object md_ByRegions_six: TRxMemoryData
    FieldDefs = <>
    Left = 72
    Top = 224
    object StringField36: TStringField
      FieldName = 'reg_name'
    end
    object IntegerField3: TIntegerField
      FieldName = 'VodoSetiVsego'
    end
    object IntegerField4: TIntegerField
      FieldName = 'VvodyVsego'
    end
    object IntegerField5: TIntegerField
      FieldName = 'KolodtsyVsego'
    end
    object IntegerField6: TIntegerField
      FieldName = 'KolonkiVsego'
    end
    object IntegerField7: TIntegerField
      FieldName = 'kanal_vsego'
    end
    object IntegerField8: TIntegerField
      FieldName = 'PodtopTepSetei'
    end
    object IntegerField9: TIntegerField
      FieldName = 'LukovVsego'
    end
    object IntegerField10: TIntegerField
      FieldName = 'NetLukov'
    end
    object IntegerField11: TIntegerField
      FieldName = 'id_reg'
    end
  end
  object frDS_byRegionsSix: TfrDBDataSet
    DataSet = md_ByRegions_six
    Left = 64
    Top = 288
  end
  object md_ByRegionDeteil: TRxMemoryData
    FieldDefs = <>
    Left = 64
    Top = 352
    object md_ByRegionDeteilgroup_number: TIntegerField
      FieldName = 'group_number'
    end
    object md_ByRegionDeteilgrou_name: TStringField
      DisplayWidth = 36
      FieldName = 'group_name'
      Size = 35
    end
    object md_ByRegionDeteiladress: TStringField
      FieldName = 'adress'
      Size = 50
    end
    object md_ByRegionDeteilRegion: TStringField
      FieldName = 'Region'
    end
    object md_ByRegionDeteilDATECOMING: TDateTimeField
      FieldName = 'DATECOMING'
    end
  end
  object frDBByRegionDeteil: TfrDBDataSet
    DataSet = md_ByRegionDeteil
    Left = 64
    Top = 408
  end
  object ADOQ_ComingZayv: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 200
    Top = 424
  end
  object ADODset: TADODataSet
    Parameters = <>
    Left = 296
    Top = 424
  end
end
