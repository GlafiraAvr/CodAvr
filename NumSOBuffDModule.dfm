inherited dm_NumSOBuff: Tdm_NumSOBuff
  OldCreateOrder = True
  Left = 844
  Top = 351
  Height = 416
  inherited mt_BuffData: TkbmMemTable
    FieldDefs = <
      item
        Name = 'REC_STATE'
        DataType = ftSmallint
      end
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'id_order'
        DataType = ftInteger
      end
      item
        Name = 'number'
        DataType = ftInteger
      end>
    OnCalcFields = mt_BuffDataCalcFields
    Left = 32
    object mt_BuffDataid: TIntegerField
      FieldName = 'id'
    end
    object mt_BuffDataid_order: TIntegerField
      FieldName = 'id_order'
    end
    object mt_BuffDatanumber: TIntegerField
      FieldName = 'number'
      OnSetText = mt_BuffDatanumberSetText
    end
    object mt_BuffDataDate_Recive_Request: TDateTimeField
      FieldName = 'Date_Recive_Request'
      DisplayFormat = 'dd.mm.yy hh:mm'
    end
    object mt_BuffDataNUMBER_OUR_REQUEST: TIntegerField
      FieldName = 'NUMBER_OUR_REQUEST'
    end
    object mt_BuffDataDATE_OUR_REQUEST: TDateTimeField
      FieldName = 'DATE_OUR_REQUEST'
      DisplayFormat = 'dd.mm.yy hh:mm'
    end
    object mt_BuffDataRECIVED_FROM: TStringField
      FieldName = 'RECIVED_FROM'
    end
    object mt_BuffDataid_1562: TIntegerField
      FieldName = 'id_1562'
    end
    object mt_BuffDatastate_inner: TIntegerField
      FieldName = 'state_inner'
    end
    object mt_BuffDataDatePrin: TDateTimeField
      FieldName = 'DatePrin'
      DisplayFormat = 'dd.mm.yy hh:mm'
    end
    object mt_BuffDataid_officials: TIntegerField
      FieldName = 'id_officials'
    end
    object mt_BuffDataname_officials: TStringField
      FieldName = 'name_officials'
      LookupDataSet = dset_officials
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'id_officials'
    end
    object mt_BuffDatadel_state: TIntegerField
      FieldName = 'del_state'
    end
    object mt_BuffDatastate_outer: TIntegerField
      FieldName = 'state_outer'
    end
    object mt_BuffDataabonent: TStringField
      FieldName = 'abonent'
      Size = 100
    end
    object mt_BuffDataphone: TStringField
      FieldName = 'phone'
    end
    object mt_BuffDataRegion: TStringField
      FieldName = 'Region'
      Size = 15
    end
    object mt_BuffDataadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object mt_BuffDataabout: TStringField
      FieldName = 'about'
      Size = 1000
    end
    object mt_BuffDataID_OFFICIALS_PHONED: TIntegerField
      FieldName = 'ID_OFFICIALS_PHONED'
    end
    object mt_BuffDatais_phobed: TBooleanField
      FieldName = 'is_phobed'
    end
    object mt_BuffDataadd_excav: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'add_excav'
      Calculated = True
    end
    object mt_BuffDatais_excav: TIntegerField
      FieldName = 'is_excav'
    end
    object mt_BuffDataDateClosed: TDateTimeField
      FieldName = 'DateClosed'
    end
    object mt_BuffDatais_closed: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'is_closed'
      Calculated = True
    end
    object mt_BuffDatastate_excav: TIntegerField
      FieldName = 'state_excav'
    end
    object mt_BuffDatadeleted: TBooleanField
      FieldName = 'is_deleted'
    end
  end
  inherited sql_Insert: TIBSQL
    SQL.Strings = (
      'insert into numsorders(id_order, number)'
      'values(:pOrderID, :pNumber)')
  end
  inherited sql_Update: TIBSQL
    SQL.Strings = (
      'update numsorders set'
      'number = :pNumber,'
      'ID_OFFICIALS_PHONED=:ID_officials'
      ''
      'where id = :pID')
  end
  inherited sql_Delete: TIBSQL
    SQL.Strings = (
      'delete from numsorders where id = :pID')
  end
  object dset_officials: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name,activity '
      'from s_Officials '
      'order by name ')
    Left = 208
    Top = 168
  end
  object ADO_1562: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 224
    Top = 256
  end
  object sql_updelete: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      'update numsorders set'
      'number = :pNumber'
      'where id = :pID')
    Transaction = tran
    Left = 32
    Top = 304
  end
end
