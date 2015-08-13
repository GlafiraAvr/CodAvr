object dm_NumSONG: Tdm_NumSONG
  OldCreateOrder = False
  Left = 257
  Top = 116
  Height = 283
  Width = 434
  object tran1562: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562_1
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    Left = 128
    Top = 120
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'Num1562'
        DataType = ftInteger
      end
      item
        Name = 'Datatime'
        DataType = ftDateTime
      end
      item
        Name = 'phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'street_name'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'house'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'appartment'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'nfloor'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'podesd'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'kodpodesd'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'PLACE'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ABONENT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Region'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'kodclass'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ABOUT'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'WORKS'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'AVAR'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'REGL'
        DataType = ftDateTime
      end
      item
        Name = 'id_order'
        DataType = ftInteger
      end
      item
        Name = 'is_closed'
        DataType = ftInteger
      end
      item
        Name = 'dttm_in_work'
        DataType = ftDateTime
      end
      item
        Name = 'dttm_in'
        DataType = ftDateTime
      end
      item
        Name = 'fk_id_stat'
        DataType = ftInteger
      end
      item
        Name = 'checked'
        DataType = ftInteger
      end
      item
        Name = 'dttm_out'
        DataType = ftDateTime
      end
      item
        Name = 'ordernumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'mhid'
        DataType = ftInteger
      end>
    Left = 256
    Top = 24
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetNum1562: TIntegerField
      FieldName = 'Num1562'
    end
    object ResultDsetDatatime: TDateTimeField
      FieldName = 'Datatime'
    end
    object ResultDsetphone: TStringField
      FieldName = 'phone'
    end
    object ResultDsetadres: TStringField
      FieldName = 'street_name'
      Size = 64
    end
    object ResultDsethouse: TStringField
      FieldName = 'house'
    end
    object ResultDsetappartment: TStringField
      FieldName = 'appartment'
      Size = 10
    end
    object ResultDsetnfloor: TStringField
      FieldName = 'nfloor'
    end
    object ResultDsetpodesd: TStringField
      FieldName = 'podesd'
      Size = 10
    end
    object ResultDsetkodpodesd: TStringField
      FieldName = 'kodpodesd'
      Size = 10
    end
    object ResultDsetPLACE: TStringField
      FieldName = 'PLACE'
      Size = 30
    end
    object ResultDsetABONENT: TStringField
      FieldName = 'ABONENT'
      Size = 50
    end
    object ResultDsetRegions: TStringField
      FieldName = 'Region'
      Size = 32
    end
    object ResultDsetkodclass: TStringField
      FieldName = 'kodclass'
      Size = 10
    end
    object ResultDsetABOUT: TStringField
      FieldName = 'ABOUT'
      Size = 200
    end
    object ResultDsetWORKS: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
    object ResultDsetSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 30
    end
    object ResultDsetAVAR: TStringField
      FieldName = 'AVAR'
      Size = 2
    end
    object ResultDsetREGL: TDateTimeField
      FieldName = 'REGL'
    end
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetis_closed: TIntegerField
      FieldName = 'is_closed'
    end
    object ResultDsetdttm_in_work: TDateTimeField
      FieldName = 'dttm_in_work'
    end
    object ResultDsetdttm_in: TDateTimeField
      FieldName = 'dttm_in'
    end
    object ResultDsetfk_id_stat: TIntegerField
      FieldName = 'fk_id_s_stat'
    end
    object ResultDsetchecked: TIntegerField
      FieldName = 'checked'
    end
    object ResultDsetdttm_out: TDateTimeField
      FieldName = 'dttm_out'
    end
    object ResultDsetordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object ResultDsetmhid: TIntegerField
      FieldName = 'mhid'
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 208
    Top = 128
  end
end
