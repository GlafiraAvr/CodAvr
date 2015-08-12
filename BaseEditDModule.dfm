object dm_BaseEdit: Tdm_BaseEdit
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 622
  Top = 470
  Height = 228
  Width = 276
  object dset_Main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Main
    AfterCancel = dset_MainAfterCancel
    AfterDelete = dset_MainAfterPost
    AfterEdit = dset_MainAfterEdit
    AfterInsert = dset_MainAfterInsert
    AfterOpen = dset_MainAfterOpen
    AfterPost = dset_MainAfterPost
    AfterScroll = dset_MainAfterScroll
    BeforeClose = dset_MainBeforeClose
    BeforeOpen = dset_MainBeforeOpen
    Left = 32
    Top = 16
  end
  object tran_Main: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 96
  end
end
