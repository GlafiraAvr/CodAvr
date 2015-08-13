inherited dm_RepDiscon: Tdm_RepDiscon
  Left = 523
  Top = 406
  Height = 359
  Width = 391
  inherited frReport: TfrReport
    Left = 32
    ReportForm = {19000000}
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'DTTM_DISCON'
        DataType = ftDateTime
      end
      item
        Name = 'DTTM_CON'
        DataType = ftDateTime
      end
      item
        Name = 'APPLICANT'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ADRES'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DISCONREASON'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'EXECUTOR'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'REGION'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'WORKS'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'OrderNumber'
        DataType = ftInteger
      end
      item
        Name = 'district'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Time_Diff'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Additionalinfo'
        DataType = ftString
        Size = 60
      end>
    Left = 168
    Top = 8
    object ResultDsetID: TIntegerField
      FieldName = 'ID'
    end
    object ResultDsetDTTM_DISCON: TDateTimeField
      FieldName = 'DTTM_DISCON'
    end
    object ResultDsetDTTM_CON: TDateTimeField
      FieldName = 'DTTM_CON'
    end
    object ResultDsetAPPLICANT: TStringField
      FieldName = 'APPLICANT'
      Size = 30
    end
    object ResultDsetADRES: TStringField
      FieldName = 'ADRES'
      Size = 200
    end
    object ResultDsetDISCONREASON: TStringField
      FieldName = 'DISCONREASON'
      Size = 30
    end
    object ResultDsetEXECUTOR: TStringField
      FieldName = 'EXECUTOR'
      Size = 30
    end
    object ResultDsetREGION: TStringField
      FieldName = 'REGION'
    end
    object ResultDsetWORKS: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
    object ResultDsetOrderNumber: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetdistrict: TStringField
      FieldName = 'district'
    end
    object ResultDsetDistype: TStringField
      FieldName = 'Distype'
      Size = 30
    end
    object ResultDsetTime_Diff: TStringField
      FieldName = 'Time_Diff'
      Size = 10
    end
    object ResultDsetAdditionalinfo: TStringField
      FieldName = 'Additionalinfo'
      Size = 60
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 192
    Top = 120
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 96
    Top = 112
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select distinct sw.name WorksName'
      'from departurework dw'
      'left join s_works sw on sw.id=dw.fk_depwork_works'
      'where dw.fk_depwork_orders=:pOrderID')
    Left = 280
    Top = 128
  end
  object frDS_Result: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 80
  end
  object dset_diff: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select'
      '          o.id'
      '        , d.dttm_discon'
      '        , d.dttm_con'
      '        , o.OrderNumber'
      '        , o.isclosed'
      '        , o.datecoming'
      '        , o.dateclosed'
      'from Disconnections d'
      'left join Orders o'
      '    on o.id=d.fk_discon_order'
      '    where 1=1'
      '        and (o.id = :pOrderID)'
      '        and ('
      '                 (d.DTTM_Con>=:pDttmBeg) '
      '                    or (d.DTTM_Con is null)'
      '                )'
      '        and (d.DTTM_Discon<=:pDttmEnd)'
      'order by 6, 2')
    Left = 280
    Top = 192
  end
  object dset_dep: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 176
    Top = 176
  end
end
