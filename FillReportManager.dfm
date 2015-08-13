object DM_FillReportManager: TDM_FillReportManager
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 495
  Top = 350
  Height = 275
  Width = 335
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 48
    Top = 16
  end
  object tran: TIBTransaction
    Active = True
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 104
    Top = 16
  end
  object dset_PrepRepSaves: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    InsertSQL.Strings = (
      'insert into prep_saves(dt, id_preport, preport)'
      'values(:dt, :id_preport, :preport)')
    SelectSQL.Strings = (
      'select * from prep_saves'
      'where  id=:pID')
    ModifySQL.Strings = (
      'update prep_saves'
      'set preport=:preport'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_PREP_SAVES_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 144
    Top = 96
    object dset_PrepRepSavesID: TIntegerField
      FieldName = 'ID'
      Origin = '"PREP_SAVES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_PrepRepSavesDT: TDateField
      FieldName = 'DT'
      Origin = '"PREP_SAVES"."DT"'
    end
    object dset_PrepRepSavesID_PREPORT: TIntegerField
      FieldName = 'ID_PREPORT'
      Origin = '"PREP_SAVES"."ID_PREPORT"'
    end
    object dset_PrepRepSavesPREPORT: TBlobField
      FieldName = 'PREPORT'
      Origin = '"PREP_SAVES"."PREPORT"'
      ProviderFlags = [pfInUpdate]
      Size = 8
    end
  end
end
