object DM_StDisp: TDM_StDisp
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 515
  Top = 335
  Height = 224
  Width = 285
  object IBDB_StDisp: TIBDatabase
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = IBDB_StDisp
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 160
    Top = 24
  end
  object dset: TIBDataSet
    Database = IBDB_StDisp
    Transaction = tran
    Left = 168
    Top = 88
  end
end
