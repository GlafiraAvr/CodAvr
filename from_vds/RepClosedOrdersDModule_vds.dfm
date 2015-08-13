inherited dm_RepClosedOrders_vds: Tdm_RepClosedOrders_vds
  Height = 336
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  inherited ResultDset: TRxMemoryData
    object ResultDsetMessageTypes: TStringField [12]
      FieldName = 'MessageTypes'
      Size = 32
    end
    object ResultDsetBrigadier: TStringField [13]
      FieldName = 'Brigadier'
      Size = 64
    end
    object ResultDsetadditionalinfo: TStringField [14]
      FieldName = 'additionalinfo'
      Size = 200
    end
    object ResultDsetAPPLICANTPHONE: TStringField [15]
      FieldName = 'APPLICANTPHONE'
      Size = 15
    end
    object ResultDsetAPPLICANTFIO: TStringField [16]
      FieldName = 'APPLICANTFIO'
    end
  end
  inherited dset_disconnections: TIBDataSet
    SelectSQL.Strings = (
      ' select  d.dttm_discon'
      
        '      , (select adres from get_adres2(d.fk_discon_street, d.hous' +
        'enum,     d.housingnum, d.PorchNum, d.floornum, d.apartmentnum))' +
        ' DisAdres'
      
        '      , (select name from s_discontype_vds where id=d.fk_discon_' +
        'discontype) Distype'
      ' from Disconnections_vds d'
      ' left join Orders_vds o on o.id=d.fk_discon_order'
      ' where d.fk_discon_order = :pOrderID'
      ' order by 1')
  end
  object dset_dep: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 120
    Top = 216
  end
end
