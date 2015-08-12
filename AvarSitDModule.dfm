inherited dm_AvarSit: Tdm_AvarSit
  Left = 530
  Top = 281
  Height = 391
  Width = 264
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
  object Dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select o.ordernumber'
      
        '   , (select name from s_Regions where id=o.fk_orders_regions) R' +
        'egions'
      
        '   , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_o' +
        'rders_streets,  o.housenum, o.additionaladdress)) adres'
      '   , o.datecoming, o.dateclosed'
      
        '   , (select d.additionalinfo from departures d where d.fk_depar' +
        'tures_orders = o.id and d.depnumber = 1) reason'
      ' from orders o'
      ' where (o.fk_orders_damageplace in (1,2))'
      '    and (o.datecoming < '#39'28.03.2009'#39' )'
      '    and ((o.dateclosed >= '#39'26.03.2009'#39' ) or (o.isclosed = 0))'
      'order by 2,4')
    Left = 24
    Top = 96
  end
  object frDBResult: TfrDBDataSet
    DataSet = ResultDset
    Left = 120
    Top = 184
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 32
    Top = 176
    object ResultDsetordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object ResultDsetRegions: TStringField
      FieldName = 'Regions'
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 200
    end
    object ResultDsetdatecoming: TDateTimeField
      FieldName = 'datecoming'
    end
    object ResultDsetdateclosed: TDateTimeField
      FieldName = 'dateclosed'
    end
    object ResultDsetreason: TStringField
      FieldName = 'reason'
      Size = 60
    end
    object ResultDsetplandateregl: TStringField
      FieldName = 'plandateregl'
    end
    object ResultDsetwithoutExcav: TStringField
      FieldName = 'withoutExcav'
      Size = 50
    end
  end
  object ResultSvod: TRxMemoryData
    FieldDefs = <>
    Left = 32
    Top = 232
    object ResultSvoddata: TDateField
      FieldName = 'data'
    end
    object ResultSvodVsego: TIntegerField
      FieldName = 'Vsego'
    end
    object ResultSvodPostup: TIntegerField
      FieldName = 'Postup'
    end
    object ResultSvodvipoln: TIntegerField
      FieldName = 'vipoln'
    end
  end
  object frDBResultSvod: TfrDBDataSet
    DataSet = ResultSvod
    Left = 128
    Top = 240
  end
  object IBSQL_inst: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 296
  end
end
