object DM_AomComClient: TDM_AomComClient
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 550
  Top = 346
  Height = 265
  Width = 285
  object AomClientManager: TAomClientManager
    OnAskAvarInfo = AomClientManagerAskAvarInfo
    OnChangeTypeOfAvar = AomClientManagerChangeTypeOfAvar
    OnHide = AomClientManagerHide
    OnShow = AomClientManagerShow
    OnEndLoad = AomClientManagerEndLoad
    Left = 48
    Top = 24
  end
  object tran_sel: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 192
    Top = 24
  end
  object dset_sel: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_sel
    Left = 192
    Top = 96
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_sel
    Left = 200
    Top = 160
  end
end
