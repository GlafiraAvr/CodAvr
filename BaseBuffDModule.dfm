object dm_BaseBuff: Tdm_BaseBuff
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 942
  Top = 548
  Height = 382
  Width = 338
  object mt_BuffData: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = mt_BuffDataBeforePost
    AfterPost = mt_BuffDataAfterPost
    OnFilterRecord = mt_BuffDataFilterRecord
    Left = 40
    Top = 32
    object mt_BuffDataREC_STATE: TSmallintField
      FieldName = 'REC_STATE'
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 208
    Top = 32
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 208
    Top = 104
  end
  object sql_Insert: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 104
  end
  object sql_Update: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 176
  end
  object sql_Delete: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 248
  end
end
