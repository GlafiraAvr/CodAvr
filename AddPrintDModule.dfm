object dm_AddPrint: Tdm_AddPrint
  OldCreateOrder = False
  Left = 251
  Top = 237
  Height = 309
  Width = 533
  object frReport: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 40
    Top = 16
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 96
    Top = 16
  end
  object tran: TIBTransaction
    Active = True
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 176
    Top = 16
  end
  object frDset: TfrDBDataSet
    DataSet = dset
    Left = 40
    Top = 80
  end
  object dset2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 264
    Top = 25
  end
  object frDset2: TfrDBDataSet
    DataSet = dset2
    Left = 264
    Top = 88
  end
  object dset_Bolts: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select b.closedate, b.opendate, ClosePlace, fk_closedbolts_briga' +
        'dieropen,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'sclose) BrigClose,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'open) BrigOpen,'
      
        '(select diameter from s_tubediameter where id=b.fk_closedbolts_t' +
        'ubediam) TubeDiam,'
      '(select adres from'
      
        '    get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_stree' +
        'ts, b.housenum, b.additionaladdress)) as Adres'
      'from closedbolts b'
      'where b.fk_closedbolts_orders=:pOrderID')
    Left = 392
    Top = 24
    object dset_BoltsCLOSEDATE: TDateTimeField
      FieldName = 'CLOSEDATE'
      Origin = '"CLOSEDBOLTS"."CLOSEDATE"'
    end
    object dset_BoltsOPENDATE: TDateTimeField
      FieldName = 'OPENDATE'
      Origin = '"CLOSEDBOLTS"."OPENDATE"'
    end
    object dset_BoltsCLOSEPLACE: TIBStringField
      FieldName = 'CLOSEPLACE'
      Origin = '"CLOSEDBOLTS"."CLOSEPLACE"'
      FixedChar = True
      Size = 22
    end
    object dset_BoltsBRIGCLOSE: TIBStringField
      FieldName = 'BRIGCLOSE'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_BoltsBRIGOPEN: TIBStringField
      FieldName = 'BRIGOPEN'
      ProviderFlags = []
      OnGetText = dset_BoltsBRIGOPENGetText
      FixedChar = True
      Size = 64
    end
    object dset_BoltsTUBEDIAM: TIntegerField
      FieldName = 'TUBEDIAM'
      ProviderFlags = []
    end
    object dset_BoltsADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      FixedChar = True
      Size = 190
    end
    object dset_BoltsFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_BRIGADIEROPEN"'
    end
  end
  object frDS_Bolts: TfrDBDataSet
    DataSet = dset_Bolts
    Left = 400
    Top = 80
  end
  object dset_discon_vds: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    OnCalcFields = dset_discon_vdsCalcFields
    SelectSQL.Strings = (
      '  select dds.fk_discon_discontype, dds.dttm_con datecon,'
      '       dds.g_zhd, dds.g_pod, dds.g_stoj, dds.g_kv,dds.g_st_sp,'
      
        '(select sdt.name from s_discontype_vds sdt where  dds.fk_discon_' +
        'discontype=sdt.id) discontype,'
      'dds.dttm_discon datediscon,'
      'dds.fk_discon_executor,'
      
        '(select se.name from s_executor_vds se where se.id=dds.fk_discon' +
        '_executor) executor,'
      
        '(select b.name from brigadiers b where dds.fk_discon_brig_connec' +
        't=b.id) brigadir'
      'from disconnections_vds  dds'
      'where dds.fk_discon_order=:id')
    Left = 256
    Top = 176
    object dset_discon_vdsFK_DISCON_DISCONTYPE: TIntegerField
      FieldName = 'FK_DISCON_DISCONTYPE'
      Origin = '"DISCONNECTIONS_VDS"."FK_DISCON_DISCONTYPE"'
    end
    object dset_discon_vdsG_ZHD: TIntegerField
      FieldName = 'G_ZHD'
      Origin = '"DISCONNECTIONS_VDS"."G_ZHD"'
    end
    object dset_discon_vdsG_POD: TIntegerField
      FieldName = 'G_POD'
      Origin = '"DISCONNECTIONS_VDS"."G_POD"'
    end
    object dset_discon_vdsG_STOJ: TIntegerField
      FieldName = 'G_STOJ'
      Origin = '"DISCONNECTIONS_VDS"."G_STOJ"'
    end
    object dset_discon_vdsG_KV: TIntegerField
      FieldName = 'G_KV'
      Origin = '"DISCONNECTIONS_VDS"."G_KV"'
    end
    object dset_discon_vdsG_ST_SP: TIntegerField
      FieldName = 'G_ST_SP'
      Origin = '"DISCONNECTIONS_VDS"."G_ST_SP"'
    end
    object dset_discon_vdsDISCONTYPE: TIBStringField
      FieldName = 'DISCONTYPE'
      ProviderFlags = []
      Size = 30
    end
    object dset_discon_vdsDATEDISCON: TDateTimeField
      FieldName = 'DATEDISCON'
      Origin = '"DISCONNECTIONS_VDS"."DTTM_DISCON"'
    end
    object dset_discon_vdsFK_DISCON_EXECUTOR: TIntegerField
      FieldName = 'FK_DISCON_EXECUTOR'
      Origin = '"DISCONNECTIONS_VDS"."FK_DISCON_EXECUTOR"'
    end
    object dset_discon_vdsEXECUTOR: TIBStringField
      FieldName = 'EXECUTOR'
      ProviderFlags = []
      Size = 30
    end
    object dset_discon_vdsBRIGADIR: TIBStringField
      FieldName = 'BRIGADIR'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_discon_vdsDiscontype_all: TIBStringField
      FieldKind = fkCalculated
      FieldName = 'Discontype_all'
      Size = 200
      Calculated = True
    end
    object dset_discon_vdsDATECON: TDateTimeField
      FieldName = 'DATECON'
      Origin = '"DISCONNECTIONS_VDS"."DTTM_CON"'
    end
  end
  object frDSt_disc: TfrDBDataSet
    DataSet = dset_discon_vds
    Left = 120
    Top = 160
  end
end
