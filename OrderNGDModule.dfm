object dm_OrderNG: Tdm_OrderNG
  OldCreateOrder = False
  Left = 253
  Top = 289
  Height = 342
  Width = 365
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
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
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 32
    Top = 152
  end
end
