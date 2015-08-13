inherited frame_EquipGrid_vds: Tframe_EquipGrid_vds
  inherited DBGrid: TDBGridEh
    Columns = <
      item
        FieldName = 'EQUIP_NAME'
        Footers = <>
        Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Width = 100
      end>
  end
  inherited pnl_Fields: TPanel
    Top = 12
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 86
      Height = 13
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Equip: TRxDBLookupCombo
      Left = 120
      Top = 16
      Width = 209
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPEQUIPMENT_EQUIPMENT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Equip
      TabOrder = 0
    end
  end
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from DEPARTUREEQUIPMENTS_vds where ID=:OLD_ID')
    InsertSQL.Strings = (
      'insert into DEPARTUREEQUIPMENTS_vds('
      'FK_DEPEQUIPMENT_ORDERS, '
      'FK_DEPEQUIPMENT_DEPARTURES,'
      'FK_DEPEQUIPMENT_EQUIPMENT'
      ')'
      'values('
      ':FK_DEPEQUIPMENT_ORDERS, '
      ':FK_DEPEQUIPMENT_DEPARTURES,'
      ':FK_DEPEQUIPMENT_EQUIPMENT'
      ')')
    SelectSQL.Strings = (
      'select ID, FK_DEPEQUIPMENT_ORDERS, '
      'FK_DEPEQUIPMENT_DEPARTURES,'
      'FK_DEPEQUIPMENT_EQUIPMENT,'
      '(select full_name from '
      'get_equip_full_name(de.fk_depequipment_equipment))'
      ' EQUIP_NAME'
      'from DEPARTUREEQUIPMENTS_vds de'
      'where (FK_DEPEQUIPMENT_ORDERS=:pOrderID) and'
      '(FK_DEPEQUIPMENT_DEPARTURES=:pDepID) ')
    ModifySQL.Strings = (
      'update DEPARTUREEQUIPMENTS_vds set'
      'FK_DEPEQUIPMENT_EQUIPMENT=:FK_DEPEQUIPMENT_EQUIPMENT'
      'where ID=:ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPEQUIPMENT_VDS'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREEQUIPMENTS_VDS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_DEPEQUIPMENT_ORDERS: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_ORDERS'
      Origin = '"DEPARTUREEQUIPMENTS_VDS"."FK_DEPEQUIPMENT_ORDERS"'
    end
    object dset_MainFK_DEPEQUIPMENT_DEPARTURES: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_DEPARTURES'
      Origin = '"DEPARTUREEQUIPMENTS_VDS"."FK_DEPEQUIPMENT_DEPARTURES"'
    end
    object dset_MainFK_DEPEQUIPMENT_EQUIPMENT: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_EQUIPMENT'
      Origin = '"DEPARTUREEQUIPMENTS_VDS"."FK_DEPEQUIPMENT_EQUIPMENT"'
    end
    object dset_MainEQUIP_NAME: TIBStringField
      DisplayWidth = 13
      FieldName = 'EQUIP_NAME'
      ProviderFlags = []
      Size = 93
    end
  end
  object dset_Equip: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, (select full_name from get_equip_full_name(id)) name'
      'from equipment'
      'where (id>0)'
      'and (activity is null)'
      'order by 2')
    Left = 288
    Top = 56
  end
  object ds_Equip: TDataSource
    DataSet = dset_Equip
    Left = 248
    Top = 56
  end
end
