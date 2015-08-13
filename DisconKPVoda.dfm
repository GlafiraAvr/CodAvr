inherited dm_DisconKPVoda: Tdm_DisconKPVoda
  Left = 427
  Top = 260
  Height = 272
  Width = 315
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object Dset_DisconNS: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select (select (select name from s_regions where id = o.fk_order' +
        's_regions) from orders o where o.id = d.fk_id_order) regions'
      
        ',(select o.ordernumber from orders o where o.id = d.fk_id_order)' +
        ' ordernumber'
      
        ', ( select adres from get_adres(0, d.fk_id_street, d.houses, d.a' +
        'dditionalinfo) ) adres'
      ',  d.dttm_discon, d.dttm_con'
      'from disconnections d'
      'where'
      '  (d.dttm_discon>='#39'24.06.2009'#39')'
      '  and (d.dttm_con <'#39'25.06.2009'#39')'
      '')
    Left = 32
    Top = 96
  end
  object Dset_DisconVDS: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tranVDS
    SelectSQL.Strings = (
      '  select d.id'
      
        '  , (select (select name from s_regions where id = o.fk_orders_r' +
        'egions) from orders o where o.id = d.fk_discon_order) regions'
      
        '  ,(select o.ordernumber from orders o where o.id = d.fk_discon_' +
        'order ) ordernumber'
      
        '  , (select adres from get_adres2(d.fk_discon_street,d.housenum,' +
        ' d.housingnum,d.porchnum, d.floornum,d.apartmentnum)) adres'
      '  , d.dttm_discon'
      '  , d.dttm_con'
      '    from disconnections d where'
      '     (d.dttm_discon>='#39'01.01.2009'#39')'
      '    and (d.dttm_con <'#39'02.01.2009'#39')')
    Left = 32
    Top = 152
  end
  object mt_Disconnections: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortFields = 'regions'
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
    Left = 216
    Top = 16
    object mt_Disconnectionsordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object mt_Disconnectionsregions: TStringField
      FieldName = 'regions'
    end
    object mt_Disconnectionsadres: TStringField
      FieldName = 'adres'
      Size = 120
    end
    object mt_Disconnectionsdttm_discon: TDateTimeField
      FieldName = 'dttm_discon'
    end
    object mt_Disconnectionsdttm_con: TDateTimeField
      FieldName = 'dttm_con'
    end
    object mt_Disconnectionsbase_prin: TStringField
      FieldName = 'base_prin'
      Size = 4
    end
    object mt_Disconnectionsstr_dttm_con: TStringField
      FieldName = 'str_dttm_con'
      Size = 24
    end
    object mt_Disconnectionshow_long: TStringField
      DisplayWidth = 8
      FieldName = 'how_long'
      Size = 8
    end
  end
  object frDS_Disconnections: TfrDBDataSet
    DataSet = mt_Disconnections
    Left = 216
    Top = 72
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 96
    Top = 88
  end
  object tranVDS: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 96
    Top = 144
  end
  object dset_Regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name from s_regions'
      'where id > 0')
    Left = 208
    Top = 160
  end
end
