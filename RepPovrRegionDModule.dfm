inherited dm_RepPovrRegion: Tdm_RepPovrRegion
  Left = 313
  Top = 243
  inherited frReport: TfrReport
    Top = 24
    ReportForm = {19000000}
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select o.ordernumber, sr.name region_name,'
      
        '(select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders' +
        '_streets,'
      '    o.housenum, o.additionaladdress)) adres,'
      
        'sw.name work_name, dw2.additionalinfo exc_info, std.diameter, o.' +
        'datecoming'
      'from departureworks dw1'
      
        '    left join departureworks dw2 on (dw2.fk_depworks_departure =' +
        ' dw1.fk_depworks_departure) and'
      
        '                                    (dw2.fk_depworks_work = :pRa' +
        'skopID)'
      '    left join orders o on o.id = dw1.fk_depworks_order'
      '    left join departures d on d.id = dw1.fk_depworks_departure'
      '    left join s_works sw on sw.id = dw1.fk_depworks_work'
      '    left join s_regions sr on sr.id = o.fk_orders_regions'
      
        '    left join s_tubediameter std on std.id = dw1.fk_depworks_dia' +
        'meter'
      'where'
      '(sw.is_first_dep = 1) and'
      '(dw1.FK_DEPWORKS_WORK <> :pRaskopID ) and'
      '(d.depnumber = 1) and'
      '(o.DateComing >= :pDtBeg) and'
      '(o.DateComing < :pDtEnd)')
    Left = 32
    Top = 112
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 200
    Top = 16
  end
  object frDBResult: TfrDBDataSet
    DataSet = dset_tmp
    Left = 32
    Top = 160
  end
  object dset_tmp2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 104
    Top = 112
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = dset_tmp2
    Left = 104
    Top = 160
  end
end
