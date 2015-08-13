object dm_GreenSpringGetDate: Tdm_GreenSpringGetDate
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 291
  Top = 152
  Height = 150
  Width = 215
  object dset_date: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select curyear, curdate  from GREENSPRINGDATE')
    Left = 32
    Top = 16
  end
end
