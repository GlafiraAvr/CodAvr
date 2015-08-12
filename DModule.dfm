object DM_Main: TDM_Main
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 588
  Top = 186
  Height = 524
  Width = 482
  object IBDatabase: TIBDatabase
    DatabaseName = 'E:\bases\avr_13.07.2015\AVR_KH_NEW.GDB'
    Params.Strings = (
      'user_name=avr_ib'
      'password=avr_ib_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    BeforeDisconnect = IBDatabaseBeforeDisconnect
    Left = 24
    Top = 8
  end
  object Tr_RCommited: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 224
    Top = 8
  end
  object Tr_RWSnapshot: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 8
  end
  object Tr_ROTableStab: TIBTransaction
    DefaultDatabase = IBDatabase
    Left = 328
    Top = 8
  end
  object Tr_RWCommited: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 232
    Top = 72
  end
  object dset_tmp: TIBDataSet
    Database = IBDatabase
    Transaction = Tr_tmp
    Left = 336
    Top = 221
  end
  object Tr_tmp: TIBTransaction
    DefaultDatabase = IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 331
    Top = 161
  end
  object IBDatabaseVDS: TIBDatabase
    DatabaseName = 'G:\!DEVS\AVR_VDS\AVR_KH_NEW2.GDB'
    Params.Strings = (
      'user_name=AVR_VDS'
      'password=avr_vds_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    Left = 32
    Top = 88
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 240
    Top = 160
  end
  object dset_tmp2: TIBDataSet
    Database = IBDatabase
    Transaction = Tr_RCommited
    Left = 323
    Top = 274
  end
  object IBQSmena: TIBQuery
    Database = IBDatabase
    Transaction = Tr_RCommited
    SQL.Strings = (
      
        'select  o.ordernumber as numborder, o.datecoming as dateorder   ' +
        ',1 pris'
      'from departures d, orders o'
      
        'where (STARTDATE>=:PSTARTDATE)  and (STARTDATE<:PSTARTDATE+1) an' +
        'd (ENDDATE is Null)       '
      '           and (d.fk_departures_orders=o.id)       '
      ''
      'union'
      
        'select   (select FULLORDERNUM from get_fullordernum( ov.ordernum' +
        'ber, ov.fk_orders_district)) as numborder,'
      'ov.datecoming as dateorder, 1 pris'
      ' from orders_vds  ov , departures_vds ds'
      ' where  (ds.startdate>=:PSTARTDATE)   and'
      '(ds.startdate<:PSTARTDATE+1)'
      'and (ds.enddate is Null)'
      '  and (ds.fk_departures_orders=ov.id)            '
      'union'
      'select sr.name,d.startdate , 2 pris'
      
        ' from departures d left join s_regions  sr on sr.id =d.FK_DEPART' +
        'URE_REGIONS'
      'where'
      'd.startdate>=:PStartDate and d.endDate is null'
      'and  d.FK_DEPARTURE_REGIONS is not null'
      ''
      '')
    Left = 35
    Top = 272
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'PSTARTDATE'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'PSTARTDATE+1'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'PSTARTDATE'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'PSTARTDATE+1'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'PStartDate'
        ParamType = ptInput
      end>
  end
  object IBQNewHost: TIBQuery
    Database = IBDatabase
    Transaction = Tr_RWCommited
    SQL.Strings = (
      'insert into new_hosts(name,mac,ip)'
      'values(:pname,:pmac,:pip)')
    Left = 125
    Top = 270
    ParamData = <
      item
        DataType = ftString
        Name = 'pname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pmac'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pip'
        ParamType = ptInput
      end>
  end
  object ADOConn_1562: TADOConnection
    ConnectionString = 'FILE NAME=111.udl'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 328
  end
  object ADOQ_ost1562: TADOQuery
    Parameters = <>
    Left = 32
    Top = 384
  end
end
