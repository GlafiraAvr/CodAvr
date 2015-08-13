inherited dm_PlanDep: Tdm_PlanDep
  Left = 846
  Top = 283
  inherited frReport: TfrReport
    Dataset = frDBResult
    Left = 24
    Top = 24
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select o.ordernumber, o.fk_orders_regions, d.id, d.StartDate, d.' +
        'EndDate ,d.fk_departures_orders, d.DepNumber'
      
        '        ,d.PLANSTARTDATE , d.PLANENDDATE, d.fk_departures_equipm' +
        'ent,'
      
        '        (select rtrim(name)||'#39' '#8470#39'||cast(number as char(3)) from ' +
        'equipment  where id = d.fk_departures_equipment) Equip,'
      
        '        (select name from s_regions where id = o.fk_orders_regio' +
        'ns) region,'
      
        '        (select adres from Get_adres(o.fk_orders_housetypes, o.f' +
        'k_orders_streets, o.housenum, o.additionaladdress)) adres,'
      
        '        (select rtrim(sdl.name) from s_damagelocality sdl where ' +
        'sdl.id = o.fk_orders_damagelocality) dlname'
      'from orders o , departures d'
      
        'where ((o.id = d.fk_departures_orders)  and  d.planstartdate < '#39 +
        '20.02.2009'#39' and d.planenddate >= '#39'19.02.2009'#39' and not( d.fk_depa' +
        'rtures_equipment is null) )'
      'order by 12, 1')
    Left = 24
    Top = 96
  end
  object ResultDset: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'PlanStartDate'
        DataType = ftDateTime
      end
      item
        Name = 'Adres'
        DataType = ftString
        Size = 190
      end
      item
        Name = 'OrderNumber'
        DataType = ftInteger
      end
      item
        Name = 'dlname'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Equip'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'region'
        DataType = ftString
        Size = 20
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
    Left = 32
    Top = 184
    object ResultDsetPlanStartDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'PlanStartDate'
    end
    object ResultDsetAdres: TStringField
      FieldName = 'Adres'
      Size = 190
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetdlname: TStringField
      FieldName = 'dlname'
      Size = 30
    end
    object ResultDsetEquip: TStringField
      DisplayWidth = 40
      FieldName = 'Equip'
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
    end
    object ResultDsetPlanStartTime: TStringField
      DisplayWidth = 32
      FieldName = 'PlanStartTime'
      Size = 32
    end
    object ResultDsetBrigName: TStringField
      FieldName = 'BrigName'
      Size = 64
    end
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
  end
  object dset_OrderInfo: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select o.OrderNumber,'
      
        '(select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders' +
        '_streets,'
      '    o.housenum, o.additionaladdress)) adres,'
      
        '(select name from s_region where id = o.fk_orders_regions) regio' +
        'n,'
      
        '(select rtrim(sdl.name) from s_damagelocality sdl where sdl.id =' +
        ' o.fk_orders_damagelocality) dlname'
      'from orders o'
      'where o.id = :pOrderID'
      'order by region')
    Left = 128
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
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_ex
    Left = 184
    Top = 160
  end
  object tran_ex: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 200
    Top = 88
  end
end
