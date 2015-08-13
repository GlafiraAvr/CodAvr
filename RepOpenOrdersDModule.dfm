inherited dm_RepOpenOrders: Tdm_RepOpenOrders
  Left = 790
  Top = 244
  Width = 345
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 16
    Top = 160
    object ResultDsetID: TIntegerField
      FieldName = 'ID'
    end
    object ResultDsetDateComing: TDateTimeField
      FieldName = 'DateComing'
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetREGION: TStringField
      FieldName = 'REGION'
    end
    object ResultDsetAPPLICANT: TStringField
      FieldName = 'APPLICANT'
      Size = 30
    end
    object ResultDsetADRES: TStringField
      FieldName = 'ADRES'
      Size = 150
    end
    object ResultDsetdistrict: TStringField
      FieldName = 'district'
    end
    object ResultDsetDisAdres: TStringField
      FieldName = 'DisAdres'
      Size = 250
    end
    object ResultDsetDistype: TStringField
      FieldName = 'Distype'
      Size = 250
    end
    object ResultDsetDateClosed: TDateTimeField
      FieldName = 'DateClosed'
    end
    object ResultDsetMT: TStringField
      FieldName = 'MT'
      Size = 32
    end
    object ResultDsetdttm_discon: TStringField
      DisplayWidth = 250
      FieldName = 'dttm_discon'
      Size = 250
    end
    object ResultDsetWORKS: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 88
    Top = 96
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 144
    Top = 96
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.name WorksName'
      'from departurework dw'
      'left join s_works sw on sw.id=dw.fk_depwork_works'
      'where dw.fk_depwork_orders=:pOrderID')
    Left = 232
    Top = 96
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 96
  end
  object OLD_ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 128
    Top = 160
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object StringField1: TStringField
      FieldName = 'APPLICANT'
      Size = 30
    end
    object StringField2: TStringField
      FieldName = 'ADRES'
      Size = 150
    end
    object StringField3: TStringField
      FieldName = 'REGION'
    end
    object StringField4: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
    object IntegerField2: TIntegerField
      FieldName = 'OrderNumber'
    end
    object StringField5: TStringField
      FieldName = 'district'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DateComing'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DateClosed'
    end
  end
  object dset_disconnections: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      ' select  d.dttm_discon'
      
        '      , (select adres from get_adres2(d.fk_discon_street, d.hous' +
        'enum,     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum))' +
        ' DisAdres'
      
        '      , (select name from s_discontype where id=d.fk_discon_disc' +
        'ontype) Distype'
      ' from Disconnections d'
      ' left join Orders o on o.id=d.fk_discon_order'
      ' where d.fk_discon_order = :pOrderID'
      ' order by 1')
    Left = 232
    Top = 168
  end
end
