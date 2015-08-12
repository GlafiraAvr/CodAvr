inherited dm_AvarOnMapReport: Tdm_AvarOnMapReport
  Left = 459
  Top = 410
  Height = 269
  Width = 372
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 96
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 16
  end
  object dset_Order: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select OrderNumber, DateComing, '
      
        '(select orderworks from get_orderworks( o.id, 1, 0 )) What_Is_Do' +
        'ne_In_First_Dep, '
      
        'Pressure, FlowSpeed, Abonent, brig1.name Dep1Brig, d1.startdate ' +
        'Dep1Dttm,'
      
        '(select name from s_Officials where id=o.fk_orders_officials) Of' +
        'ficial,'
      
        '(select name from s_regions where id=o.fk_orders_regions) Region' +
        ','
      
        '(select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders' +
        '_streets,'
      '  o.housenum, o.additionaladdress)) adres,'
      
        '(select MessageName from s_MessageTypes where id=o.fk_orders_mes' +
        'sagetypes) MessageType,'
      
        '(select name from s_DamagePlace where id=o.fk_orders_damageplace' +
        ') DamagePlace,'
      
        '(select diameter from s_Tubediameter where id=o.fk_orders_diamet' +
        'ers) Diameter'
      'from orders o'
      'left join departures d1 on'
      
        '    ( ( d1.fk_departures_orders = o.id ) and (d1.depnumber =1 ) ' +
        ' )'
      'left join brigadiers brig1 on'
      '    ( brig1.id = d1.fk_departures_brigadiers )'
      'where o.id=:pOrderID')
    Left = 280
    Top = 16
  end
  object dset_Bolts: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterOpen = dset_BoltsAfterOpen
    SelectSQL.Strings = (
      'select b.closedate,  b.opendate, '
      'FK_CLOSEDBOLTS_BRIGADIEROPEN, FK_CLOSEDBOLTS_BRIGADIERSCLOSE,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'sclose) BrigClose,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'open) BrigOpen,'
      
        '(select diameter from s_tubediameter where id=b.fk_closedbolts_t' +
        'ubediam) TubeDiam,'
      '(select adres from'
      
        '    get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_stree' +
        'ts, b.housenum, b.additionaladdress)) as Adres'
      'from closedbolts b'
      'where b.fk_closedbolts_orders=:pOrderID')
    Left = 24
    Top = 88
    object dset_BoltsCLOSEDATE: TDateTimeField
      FieldName = 'CLOSEDATE'
      Origin = '"CLOSEDBOLTS"."CLOSEDATE"'
    end
    object dset_BoltsOPENDATE: TDateTimeField
      FieldName = 'OPENDATE'
      Origin = '"CLOSEDBOLTS"."OPENDATE"'
    end
    object dset_BoltsBRIGCLOSE: TIBStringField
      FieldName = 'BRIGCLOSE'
      ProviderFlags = []
      OnGetText = dset_BoltsBRIGCLOSEGetText
      FixedChar = True
      Size = 64
    end
    object dset_BoltsBRIGOPEN: TIBStringField
      FieldName = 'BRIGOPEN'
      ProviderFlags = []
      OnGetText = dset_BoltsBRIGOPENGetText
      FixedChar = True
      Size = 64
    end
    object dset_BoltsTUBEDIAM: TIntegerField
      FieldName = 'TUBEDIAM'
      ProviderFlags = []
    end
    object dset_BoltsADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      Size = 190
    end
    object dset_BoltsFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_BRIGADIEROPEN"'
    end
    object dset_BoltsFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_BRIGADIERSCLOSE"'
    end
  end
  object dset_Maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterOpen = dset_MatersAfterOpen
    OnCalcFields = dset_MatersCalcFields
    SelectSQL.Strings = (
      'select sum(dm.quantity) kol,'
      'm.name as mater, td.diameter,'
      'm.measurement'
      'from departurematers dm'
      'left join materials m on'
      'dm.fk_depmaters_mater=m.id'
      'left join s_TubeDiameter td on'
      'dm.fk_depmaters_diameter=td.id'
      'where fk_depmaters_order=:pOrderID'
      'group by m.name, td.diameter, m.measurement'
      'order by m.name')
    Left = 88
    Top = 88
    object dset_MatersKOL: TIBBCDField
      FieldName = 'KOL'
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object dset_MatersMATER: TIBStringField
      FieldName = 'MATER'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object dset_MatersDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      ProviderFlags = []
    end
    object dset_MatersMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      ProviderFlags = []
      FixedChar = True
      Size = 16
    end
    object dset_MatersMATER_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'MATER_NAME'
      Size = 50
      Calculated = True
    end
  end
  object dset_Workers: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterOpen = dset_WorkersAfterOpen
    SelectSQL.Strings = (
      'select distinct w.name, wp.name_ post'
      'from departureworkers dw'
      'left join workers w on'
      'dw.fk_depworkers_worker=w.id'
      'left join s_workerpost wp on'
      'wp.id = w.id_workerpost'
      'where dw.fk_depworkers_order = :pOrderID'
      'order by w.name'
      '')
    Left = 168
    Top = 88
    object dset_WorkersNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"WORKERS"."NAME"'
      Size = 64
    end
    object dset_WorkersPOST: TIBStringField
      FieldName = 'POST'
      Origin = '"S_WORKERPOST"."NAME_"'
      Size = 40
    end
  end
  object dset_Equips: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterOpen = dset_EquipsAfterOpen
    OnCalcFields = dset_EquipsCalcFields
    SelectSQL.Strings = (
      'select distinct e.name, e.number'
      'from departureequips de'
      'left join equipment e on'
      'de.fk_depequips_equip=e.id'
      'where de.fk_depequips_order = :pOrderID'
      'order by e.name')
    Left = 264
    Top = 88
    object dset_EquipsNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"EQUIPMENT"."NAME"'
      FixedChar = True
      Size = 36
    end
    object dset_EquipsNUMBER: TIntegerField
      FieldName = 'NUMBER'
      Origin = '"EQUIPMENT"."NUMBER"'
    end
    object dset_EquipsEQUIP_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'EQUIP_NAME'
      Size = 50
      Calculated = True
    end
  end
end
