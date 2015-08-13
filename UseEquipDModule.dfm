inherited dm_UseEquip: Tdm_UseEquip
  inherited frReport: TfrReport
    Dataset = frDBResult
    ReportForm = {19000000}
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 120
    Top = 24
  end
  object ResultDset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      ' select o.ordernumber, o.datecoming'
      
        '   , (select name from s_Regions where id=o.fk_orders_regions) R' +
        'egions'
      
        '   , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_o' +
        'rders_streets,  o.housenum, o.additionaladdress)) adres'
      '   , (select (select strval from tocharuns(eq.number))'
      
        '            from equipment eq where id=e.fk_excavations_equipmen' +
        't) Equip'
      '   , e.dtime'
      
        '   , (select WorkName from s_ExcavationWorkTypes where id=e.fk_e' +
        'xcavations_excwt) ExcWt'
      ' from excavations e,  orders o'
      ' where ( e.fk_excavations_orders = o.id )'
      '    and ( e.dtime >='#39'01.01.2009'#39' ) and ( e.dtime <'#39'03.01.2009'#39' )'
      ' order by o.datecoming')
    Left = 24
    Top = 96
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
  end
end
