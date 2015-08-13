object dm_SnapShotManager: Tdm_SnapShotManager
  OldCreateOrder = False
  Left = 398
  Top = 317
  Height = 282
  Width = 356
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 48
    Top = 32
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 128
    Top = 32
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 232
    Top = 32
  end
  object dset_Dsets: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name '
      'from snshot_dsets '
      'where id_snapshot=:pShotID')
    Left = 40
    Top = 112
  end
  object dset_Fields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, field_name'
      'from snshot_fields'
      'where id_dset=:pDsetID'
      'order by id')
    Left = 136
    Top = 112
  end
  object dset_Values: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select field_value, row_number'
      'from snshot_values'
      'where id_field=:pFieldID'
      'order by row_number')
    Left = 248
    Top = 104
  end
end
