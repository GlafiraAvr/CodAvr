object dm_MemTableFiller: Tdm_MemTableFiller
  OldCreateOrder = False
  Left = 448
  Top = 234
  Height = 170
  Width = 249
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 24
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 72
  end
end
