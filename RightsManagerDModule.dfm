object DM_RightsManager: TDM_RightsManager
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 843
  Top = 418
  Height = 316
  Width = 349
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 32
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 96
    Top = 32
  end
  object IBDB: TIBDatabase
    Params.Strings = (
      'user_name=avr_vds'
      'password=avr_vds_pwd'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    Left = 144
    Top = 32
  end
  object md_Users: TRxMemoryData
    FieldDefs = <>
    Left = 224
    Top = 32
    object md_UsersID: TIntegerField
      FieldName = 'ID'
    end
    object md_UsersUSER_NAME: TStringField
      FieldName = 'USER_NAME'
    end
    object md_UsersIB_NAME: TStringField
      FieldName = 'IB_NAME'
      Size = 50
    end
    object md_UsersIB_PWD: TStringField
      FieldName = 'IB_PWD'
      Size = 10
    end
    object md_UsersID_GROUP: TIntegerField
      FieldName = 'ID_GROUP'
    end
    object md_UsersEXTERNAL_ID: TIntegerField
      FieldName = 'EXTERNAL_ID'
    end
    object md_UsersGROUP_NAME: TStringField
      FieldName = 'GROUP_NAME'
      Size = 30
    end
  end
  object dset2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 96
  end
  object tran_repname: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 72
    Top = 176
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    SQL.Strings = (
      
        'update  or  insert into Static_Reports (names,userID) values(:na' +
        'me, :iduser)'
      'matching ( names,userID)')
    Transaction = tran_repname
    Left = 176
    Top = 176
  end
end
