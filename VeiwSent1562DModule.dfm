object dm_Closed1562View: Tdm_Closed1562View
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 491
  Top = 278
  Height = 294
  Width = 396
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = IBTran
    SelectSQL.Strings = (
      
        'select ns.id, ns.id_order, ns.number, ns.date_our_request, ns.id' +
        '_1562, ns.number_our_request, ns.date_recive_request,'
      
        'ns.recived_from, ns.id_officials, ns.dateprin, ns.why_not, ns.ad' +
        'd_info, so.name disp'
      
        ' from numsorders ns  join s_officials so on so.id=ns.id_official' +
        's'
      'where ns.date_our_request>:d1 and ns.date_our_request<:d2')
    Left = 24
    Top = 104
  end
  object mt_table: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'our_number'
        DataType = ftInteger
      end
      item
        Name = 'abonent'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'phone'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'Region'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'adress'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'about'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'chek'
        DataType = ftBoolean
      end
      item
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'opened'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    SortFields = 'number'
    SortOptions = [mtcoIgnoreLocale]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = True
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 88
    Top = 104
    object mt_tableid: TIntegerField
      FieldName = 'id'
    end
    object mt_tableour_number: TIntegerField
      FieldName = 'our_number'
    end
    object mt_tableabpnenet: TStringField
      FieldName = 'abonent'
      Size = 50
    end
    object mt_tablephone: TStringField
      FieldName = 'phone'
      Size = 18
    end
    object mt_tableRegion: TStringField
      FieldName = 'Region'
    end
    object mt_tableadress: TStringField
      FieldName = 'adress'
      Size = 200
    end
    object mt_tableabour: TStringField
      DisplayWidth = 33
      FieldName = 'about'
      Size = 1000
    end
    object mt_tablechek: TBooleanField
      FieldName = 'chek'
    end
    object mt_tablenumber: TIntegerField
      FieldName = 'number'
    end
    object mt_tableopened: TStringField
      DisplayWidth = 20
      FieldName = 'opened'
      Size = 200
    end
    object mt_tableopened_typ: TIntegerField
      FieldName = 'opened_typ'
    end
    object mt_tableid_officials: TIntegerField
      FieldName = 'id_officials'
    end
    object mt_tableis_phome: TBooleanField
      FieldName = 'is_phome'
    end
    object mt_tableadd_excav: TBooleanField
      FieldName = 'add_excav'
    end
  end
  object IBTran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 32
    Top = 56
  end
  object ADOQry: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 168
    Top = 104
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = IBTran
    Left = 32
    Top = 176
  end
  object dset_ClosedInfo: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = IBTran
    Left = 272
    Top = 136
  end
end
