object dm_WorkRegion: Tdm_WorkRegion
  OldCreateOrder = False
  Left = 582
  Top = 327
  Height = 198
  Width = 279
  object tran: TIBTransaction
    Active = True
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 32
    Top = 16
  end
  object dset_Main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    AfterDelete = dset_MainAfterPost
    AfterPost = dset_MainAfterPost
    BeforePost = dset_MainBeforePost
    DeleteSQL.Strings = (
      
        ' delete from  regions_works_vds rv where rv.fk_id_order=:fk_id_o' +
        'rder')
    InsertSQL.Strings = (
      'insert into regions_works_vds'
      ' ('
      '  fk_id_order,'
      '  fk_id_user,'
      '  startdate,'
      '  fk_id_brig,'
      '  enddate,'
      '  Fk_ID_ClosedUsed'
      ' )'
      ' values'
      ' ('
      '  :fk_id_order,'
      '  :fk_id_user,'
      '  :startdate,'
      '  :fk_id_brig,'
      '  :enddate,'
      '  :Fk_ID_ClosedUsed'
      ' )')
    SelectSQL.Strings = (
      'select  rv.id,'
      '        rv.fk_id_order,'
      '        rv.fk_id_user,'
      '        rv.startdate,'
      '        rv.fk_id_brig,'
      '        rv.enddate,'
      '        rv.fk_id_closedused,'
      
        '        (select name from s_officials so where so.id=rv.fk_id_us' +
        'er) fk_name_user,'
      
        '        (select name from s_officials so where so.id=rv.fk_id_cl' +
        'osedused) fk_name_closedused'
      ' from regions_works_vds rv'
      ' where rv.fk_id_order=:id_order')
    ModifySQL.Strings = (
      ' update  regions_works_vds'
      ' set'
      '  '
      '  fk_id_user=:fk_id_user,'
      '  startdate=:startdate,'
      '  fk_id_brig=:fk_id_brig,'
      '  enddate=:enddate,'
      'Fk_ID_ClosedUsed=:Fk_ID_ClosedUsed'
      'where  fk_id_order=:fk_id_order')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_REGIONS_WORKS_VDS'
    Left = 32
    Top = 72
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"REGIONS_WORKS_VDS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_ID_ORDER: TIntegerField
      FieldName = 'FK_ID_ORDER'
      Origin = '"REGIONS_WORKS_VDS"."FK_ID_ORDER"'
      Required = True
    end
    object dset_MainFK_ID_USER: TIntegerField
      FieldName = 'FK_ID_USER'
      Origin = '"REGIONS_WORKS_VDS"."FK_ID_USER"'
      Required = True
    end
    object dset_MainSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = '"REGIONS_WORKS_VDS"."STARTDATE"'
      Required = True
    end
    object dset_MainFK_ID_BRIG: TIntegerField
      FieldName = 'FK_ID_BRIG'
      Origin = '"REGIONS_WORKS_VDS"."FK_ID_BRIG"'
    end
    object dset_MainENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
      Origin = '"REGIONS_WORKS_VDS"."ENDDATE"'
    end
    object dset_MainFK_ID_CLOSEDUSED: TIntegerField
      FieldName = 'FK_ID_CLOSEDUSED'
      Origin = '"REGIONS_WORKS_VDS"."FK_ID_CLOSEDUSED"'
    end
    object dset_MainFK_NAME_USER: TIBStringField
      FieldName = 'FK_NAME_USER'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_MainFK_NAME_CLOSEDUSED: TIBStringField
      FieldName = 'FK_NAME_CLOSEDUSED'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
  end
  object dset_Brig: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_sel
    SelectSQL.Strings = (
      'select b.id, b.name'
      ' from brigadiers b where  b.activity is null '
      'and ID_REGION=:id_region and PR_NS_VDS=2')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_REGIONS_WORKS_VDS'
    Left = 128
    Top = 72
    object dset_BrigID: TIntegerField
      FieldName = 'ID'
      Origin = '"BRIGADIERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_BrigNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"BRIGADIERS"."NAME"'
      FixedChar = True
      Size = 64
    end
  end
  object tran_sel: TIBTransaction
    Active = True
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 128
    Top = 16
  end
end
