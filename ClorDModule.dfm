object dm_Clor: Tdm_Clor
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 611
  Top = 332
  Height = 234
  Width = 348
  object IBDB_Clor: TIBDatabase
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = IBDB_Clor
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 16
  end
  object dset: TIBDataSet
    Database = IBDB_Clor
    Transaction = tran
    Left = 224
    Top = 24
  end
end
