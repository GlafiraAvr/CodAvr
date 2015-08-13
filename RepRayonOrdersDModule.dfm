inherited dm_RepRayonOrders: Tdm_RepRayonOrders
  Height = 271
  Width = 295
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 96
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
    Left = 184
    Top = 160
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.name WorksName'
      'from departurework dw'
      'left join s_works sw on sw.id=dw.fk_depwork_works'
      'where dw.fk_depwork_orders=:pOrderID')
    Left = 200
    Top = 104
  end
  object dset_dep: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 169
    Top = 48
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
    object ResultDsetMessageTypes: TStringField
      FieldName = 'MessageTypes'
      Size = 32
    end
    object ResultDsetBrigadier: TStringField
      AutoGenerateValue = arDefault
      DefaultExpression = #39#39
      FieldName = 'Brigadier'
      Size = 64
    end
    object ResultDsetadditionalinfo: TStringField
      DisplayWidth = 200
      FieldName = 'additionalinfo'
      Size = 1000
    end
    object ResultDsetAPPLICANTPHONE: TStringField
      FieldName = 'APPLICANTPHONE'
      Size = 15
    end
    object ResultDsetAPPLICANTFIO: TStringField
      FieldName = 'APPLICANTFIO'
    end
    object ResultDsetWORKS: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
  end
end
