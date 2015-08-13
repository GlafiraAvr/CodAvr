object dm_EditWorkVoc: Tdm_EditWorkVoc
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 507
  Top = 260
  Height = 215
  Width = 249
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 16
  end
  object dset_Works: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select sw.id, sw.name, sw.id_workkind,'
      'sm.name measurement, sw.activity'
      'from s_works sw'
      'left join s_measurement sm on sm.id = sw.id_measurement'
      'where ( sw.activity is null ) and (sw.for_plan is null)'
      '/*and ( sw.id in ('
      '        select distinct id_work'
      '        from s_worktime)'
      '    )*/'
      'order by sw.name')
    Left = 104
    Top = 24
    object dset_WorksID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorksNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 50
    end
    object dset_WorksID_WORKKIND: TIntegerField
      FieldName = 'ID_WORKKIND'
      Origin = '"S_WORKS"."ID_WORKKIND"'
    end
    object dset_WorksMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
    object dset_WorksACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"S_WORKS"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
  end
  object dset_Diams: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, diameter, activity,'
      '(select strval from tochar(sd.diameter)) as name'
      'from s_tubediameter sd'
      'where ( activity is null )'
      '/*and ( sd.id in('
      '        select distinct id_diam'
      '        from s_worktime'
      '        where id_work = :id)'
      '    )*/'
      'order by diameter')
    DataSource = ds_Works
    Left = 96
    Top = 112
    object dset_DiamsID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_TUBEDIAMETER"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_DiamsDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
    end
    object dset_DiamsACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"S_TUBEDIAMETER"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
    object dset_DiamsNAME: TIBStringField
      FieldName = 'NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
  end
  object ds_Works: TDataSource
    DataSet = dset_Works
    Left = 176
    Top = 40
  end
end
