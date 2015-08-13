object dm_OrderNG1562: Tdm_OrderNG1562
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 460
  Top = 222
  Height = 468
  Width = 810
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 32
    Top = 24
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 88
  end
  object IBSQL1562: TIBSQL
    Database = DM_Main.IBDatabase1562
    Transaction = tran1562
    Left = 96
    Top = 160
  end
  object tran1562: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562
    Left = 88
    Top = 94
  end
  object dset1562: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = tran1562
    Left = 88
    Top = 24
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
    Left = 168
    Top = 8
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
    object ResultDsetdttm_in_work: TDateTimeField
      FieldName = 'dttm_in_work'
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
    object ResultDsetmhid: TIntegerField
      FieldName = 'mhid'
    end
    object ResultDsetid_order: TIntegerField
      FieldName = 'id_order'
    end
    object ResultDsetis_closed: TIntegerField
      FieldName = 'is_closed'
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
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 160
  end
  object dset_Officials1562: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, id1562,name, id_region'
      'from s_Officials1562'
      'where id_base = 1'
      'order by name ')
    Left = 272
    Top = 32
  end
  object dset_Job1562: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, name, id_job1562'
      'from s_job1562'
      'order by name ')
    Left = 272
    Top = 88
  end
  object dset_DispClose: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, name'
      'from s_operators1562'
      'order by name ')
    Left = 272
    Top = 144
  end
  object AVROrdersDset: TRxMemoryData
    FieldDefs = <>
    Left = 176
    Top = 96
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object IntegerField2: TIntegerField
      FieldName = 'OrderNumber'
    end
    object ResultDsetDateComing: TDateField
      FieldName = 'DateComing'
    end
    object ResultDsetFlowSpeed: TFloatField
      FieldName = 'FlowSpeed'
    end
    object StringField1: TStringField
      FieldName = 'Regions'
      Size = 32
    end
    object ResultDsetDamagePlace: TStringField
      FieldName = 'DamagePlace'
      Size = 32
    end
    object ResultDsetDamageType: TStringField
      FieldName = 'DamageType'
    end
    object ResultDsetDiameter: TIntegerField
      FieldName = 'Diameter'
    end
    object StringField2: TStringField
      FieldName = 'Adres'
      Size = 180
    end
    object ResultDsetid_region: TIntegerField
      FieldName = 'id_region'
    end
    object ResultDsetptr_add_info: TIntegerField
      FieldName = 'ptr_add_info'
    end
    object ResultDsetwhatisdone: TStringField
      FieldName = 'whatisdone'
      Size = 1000
    end
    object ResultDsetDateClosed: TDateField
      FieldName = 'DateClosed'
    end
    object ResultDsetHouseType: TIntegerField
      FieldName = 'HouseType'
    end
    object ResultDsetHouseNum: TStringField
      FieldName = 'HouseNum'
    end
    object ResultDsetStreetID: TIntegerField
      FieldName = 'StreetID'
    end
    object ResultDsetAddAddr: TStringField
      FieldName = 'AddAddr'
      Size = 32
    end
    object ResultDsetAomTypeOfAvar: TIntegerField
      FieldName = 'AomTypeOfAvar'
    end
    object ResultDsetisclosed: TIntegerField
      FieldName = 'isclosed'
    end
    object ResultDsetsDateClosed: TStringField
      FieldName = 'sDateClosed'
    end
  end
end
