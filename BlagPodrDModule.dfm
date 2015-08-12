inherited dm_BlagPodr: Tdm_BlagPodr
  Left = 633
  Top = 486
  Height = 396
  Width = 298
  inherited frReport: TfrReport
    Dataset = frDBResult
    ReportForm = {19000000}
  end
  object Dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      '   select o.ordernumber'
      
        '   , (select sr.name from s_regions sr where sr.id = o.fk_orders' +
        '_regions ) Rayon'
      
        '   , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_o' +
        'rders_streets,  o.housenum, o.additionaladdress)) adres'
      
        '   , (select dl.name from s_damagelocality dl where dl.id = o.fk' +
        '_orders_damagelocality) dlname'
      '   , e.square, e.dtime'
      
        '   , (select sa.name from s_asfcompany sa where sa.id = e.fk_exc' +
        'avations_asfcompany ) asfcompany'
      '    from excavations e'
      '    left join orders o on (e.fk_excavations_orders = o.id )'
      '    where (e.dtime > '#39'15.11.2009'#39' and e.square > 0 )'
      '')
    Left = 24
    Top = 96
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 24
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 88
    Top = 160
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'ordernumber'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Regions'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'adres'
        DataType = ftString
        Size = 190
      end
      item
        Name = 'dlname'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'square'
        DataType = ftInteger
      end
      item
        Name = 'dtime'
        DataType = ftDateTime
      end
      item
        Name = 'asfcompany'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'month'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nummonth'
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
    Left = 24
    Top = 160
    object ResultDsetordernumber: TStringField
      FieldName = 'ordernumber'
      Size = 8
    end
    object ResultDsetRegions: TStringField
      DisplayWidth = 20
      FieldName = 'Regions'
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 190
    end
    object ResultDsetdlname: TStringField
      FieldName = 'dlname'
      Size = 30
    end
    object ResultDsetsquare: TIntegerField
      FieldName = 'square'
    end
    object ResultDsetdtime: TDateTimeField
      FieldName = 'dtime'
    end
    object ResultDsetasfcompany: TStringField
      FieldName = 'asfcompany'
    end
    object ResultDsetid_asfcompany: TIntegerField
      FieldName = 'fk_excavations_asfcompany'
    end
    object ResultDsetmonth: TStringField
      FieldName = 'month'
    end
    object ResultDsetnummonth: TIntegerField
      FieldName = 'nummonth'
    end
  end
  object memSvod: TkbmMemTable
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
    Left = 24
    Top = 232
  end
  object frDbSvod: TfrDBDataSet
    DataSet = memSvod
    Left = 96
    Top = 232
  end
  object memasfcompany: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 2
    FieldDefs = <
      item
        Name = 'asfcompany'
        DataType = ftString
        Size = 30
      end>
    IndexFieldNames = 'asfcompany'
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
    Left = 176
    Top = 232
    object memasfcompanyasfcompany: TStringField
      FieldName = 'asfcompany'
      Size = 30
    end
    object memasfcompanyid_asfcomp: TIntegerField
      FieldName = 'id_asfcomp'
    end
  end
  object frDBmemasfcompany: TfrDBDataSet
    DataSet = memasfcompany
    Left = 176
    Top = 176
  end
end
