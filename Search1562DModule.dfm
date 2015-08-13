inherited dm_Search1562: Tdm_Search1562
  Left = 370
  Top = 410
  Height = 314
  Width = 569
  inherited frReport: TfrReport
    PreviewButtons = [pbZoom, pbSave, pbPrint]
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    Left = 136
    Top = 120
  end
  object frDS_Result: TfrDBDataSet
    Left = 24
    Top = 88
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 248
    Top = 24
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetNumberOurRequest: TIntegerField
      FieldName = 'NumberOurRequest'
    end
    object ResultDsetAppurtenanceState: TIntegerField
      FieldName = 'AppurtenanceState'
    end
    object ResultDsetNumberReceivedRequest: TIntegerField
      FieldName = 'NumberReceivedRequest'
    end
    object ResultDsetState: TIntegerField
      FieldName = 'State'
    end
    object ResultDsetid_rayon: TIntegerField
      FieldName = 'id_rayon'
    end
    object ResultDsetid_street: TIntegerField
      FieldName = 'id_street'
    end
    object ResultDsetHOUSE: TStringField
      FieldName = 'HOUSE'
      Size = 10
    end
    object ResultDsetAPPARTMENT: TStringField
      FieldName = 'APPARTMENT'
      Size = 10
    end
    object ResultDsetPlace: TStringField
      FieldName = 'Place'
    end
    object ResultDsetABOUT: TStringField
      FieldName = 'ABOUT'
      Size = 1000
    end
    object ResultDsetAppurtenance: TIntegerField
      FieldName = 'Appurtenance'
    end
    object ResultDsetstate_1: TIntegerField
      FieldName = 'state_1'
    end
    object ResultDsetRegion: TStringField
      FieldName = 'Region'
    end
    object ResultDsetDateOurRequest: TDateTimeField
      FieldName = 'DateOurRequest'
    end
    object ResultDsetDateReceivedRequest: TDateTimeField
      FieldName = 'DateReceivedRequest'
    end
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetNumOrder: TStringField
      FieldName = 'NumOrder'
      Size = 10
    end
    object ResultDsetopened: TStringField
      FieldName = 'opened'
    end
    object ResultDsetis_closed: TIntegerField
      FieldName = 'is_closed'
    end
    object ResultDsetappuartenan_str: TStringField
      FieldName = 'appuartenan_str'
      Size = 5
    end
    object ResultDsetdateclosed: TDateTimeField
      FieldName = 'dateclosed'
    end
    object ResultDsetNumberFloor: TStringField
      FieldName = 'NumberFloor'
      Size = 10
    end
    object ResultDsetPodesd: TStringField
      FieldName = 'Podesd'
      Size = 10
    end
    object ResultDsetphone: TStringField
      FieldName = 'phone'
      Size = 15
    end
    object ResultDsetabonent: TStringField
      FieldName = 'abonent'
    end
    object ResultDsetavar: TStringField
      FieldName = 'avar'
      Size = 2
    end
    object ResultDsetrayon_name: TStringField
      FieldName = 'rayon_name'
      Size = 15
    end
    object ResultDsetname_street: TStringField
      FieldName = 'name_street'
    end
    object ResultDsetNumber_Order: TStringField
      FieldName = 'Number_Order'
      Size = 10
    end
    object ResultDsets_types_name: TStringField
      FieldName = 's_types_name'
      Size = 6
    end
  end
  object tran1562: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562_1
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 16
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 192
    Top = 120
  end
  object IBEvents: TIBEvents
    AutoRegister = False
    Database = DM_Main.IBDatabase1562
    Events.Strings = (
      'new_message')
    Registered = False
    OnEventAlert = IBEventsEventAlert
    Left = 312
    Top = 96
  end
  object ADOQ_1562: TADOQuery
    Connection = DM_Main.ADOConn_1562
    CursorType = ctStatic
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'EXEC spNew_KhNew_Select ')
    Left = 16
    Top = 192
  end
  object rrr: TRxMemoryData
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
    Left = 128
    Top = 216
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object IntegerField2: TIntegerField
      FieldName = 'Num1562'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'Datatime'
    end
    object StringField1: TStringField
      FieldName = 'phone'
    end
    object StringField2: TStringField
      FieldName = 'street_name'
      Size = 64
    end
    object StringField3: TStringField
      FieldName = 'house'
    end
    object StringField4: TStringField
      FieldName = 'appartment'
      Size = 10
    end
    object StringField5: TStringField
      FieldName = 'nfloor'
    end
    object StringField6: TStringField
      FieldName = 'podesd'
      Size = 10
    end
    object StringField7: TStringField
      FieldName = 'kodpodesd'
      Size = 10
    end
    object StringField8: TStringField
      FieldName = 'PLACE'
      Size = 30
    end
    object StringField9: TStringField
      FieldName = 'ABONENT'
      Size = 50
    end
    object StringField10: TStringField
      FieldName = 'Region'
      Size = 32
    end
    object StringField11: TStringField
      FieldName = 'kodclass'
      Size = 10
    end
    object StringField12: TStringField
      FieldName = 'ABOUT'
      Size = 200
    end
    object StringField13: TStringField
      FieldName = 'WORKS'
      Size = 200
    end
    object StringField14: TStringField
      FieldName = 'STATUS'
      Size = 30
    end
    object StringField15: TStringField
      FieldName = 'AVAR'
      Size = 2
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'REGL'
    end
    object IntegerField3: TIntegerField
      FieldName = 'id_order'
    end
    object IntegerField4: TIntegerField
      FieldName = 'is_closed'
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'dttm_in_work'
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'dttm_in'
    end
    object IntegerField5: TIntegerField
      FieldName = 'fk_id_s_stat'
    end
    object IntegerField6: TIntegerField
      FieldName = 'checked'
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'dttm_out'
    end
    object IntegerField7: TIntegerField
      FieldName = 'ordernumber'
    end
    object IntegerField8: TIntegerField
      FieldName = 'mhid'
    end
  end
  object dset_regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_s
    SelectSQL.Strings = (
      'select * from s_regions')
    Left = 400
    Top = 48
  end
  object tran_s: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 392
    Top = 112
  end
  object dset_street: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_s
    SelectSQL.Strings = (
      'select id,name from get_all_streets')
    Left = 352
    Top = 192
    object dset_streetID: TIntegerField
      FieldName = 'ID'
      Origin = '"GET_ALL_STREETS"."ID"'
    end
    object dset_streetNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"GET_ALL_STREETS"."NAME"'
      FixedChar = True
      Size = 72
    end
  end
  object dset_orders: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_s
    Left = 464
    Top = 56
  end
  object dset_orders_vds: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_s
    Left = 464
    Top = 120
  end
  object ADO_resived: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 208
    Top = 216
  end
  object IB_setstate: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_s
    Left = 248
    Top = 120
  end
end
