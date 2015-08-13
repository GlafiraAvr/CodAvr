inherited frame_EquipGrid: Tframe_EquipGrid
  inherited DBGrid: TDBGridEh
    Columns = <
      item
        FieldName = 'EQUIP_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Width = 200
      end>
  end
  inherited pnl_Fields: TPanel
    object Label1: TLabel
      Left = 16
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
      Left = 112
      Top = 16
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPEQUIPMENT_EQUIPMENT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Equip
      TabOrder = 0
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
  end
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from DEPARTUREEQUIPMENTS where ID=:OLD_ID')
    InsertSQL.Strings = (
      'insert into DEPARTUREEQUIPMENTS('
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
      
        '(select rtrim(name)||'#39' '#8470#39'||number from equipment where id=de.fk_' +
        'depequipment_equipment) EQUIP_NAME'
      'from DEPARTUREEQUIPMENTS de'
      'where (FK_DEPEQUIPMENT_ORDERS=:pOrderID) and'
      '(FK_DEPEQUIPMENT_DEPARTURES=:pDepID) ')
    ModifySQL.Strings = (
      'update DEPARTUREEQUIPMENTS set'
      'FK_DEPEQUIPMENT_EQUIPMENT=:FK_DEPEQUIPMENT_EQUIPMENT'
      'where ID=:ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPEQUIPMENT'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREEQUIPMENTS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_DEPEQUIPMENT_ORDERS: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_ORDERS'
      Origin = '"DEPARTUREEQUIPMENTS"."FK_DEPEQUIPMENT_ORDERS"'
    end
    object dset_MainFK_DEPEQUIPMENT_DEPARTURES: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_DEPARTURES'
      Origin = '"DEPARTUREEQUIPMENTS"."FK_DEPEQUIPMENT_DEPARTURES"'
    end
    object dset_MainFK_DEPEQUIPMENT_EQUIPMENT: TIntegerField
      FieldName = 'FK_DEPEQUIPMENT_EQUIPMENT'
      Origin = '"DEPARTUREEQUIPMENTS"."FK_DEPEQUIPMENT_EQUIPMENT"'
    end
    object dset_MainEQUIP_NAME: TIBStringField
      FieldName = 'EQUIP_NAME'
      ProviderFlags = []
      Size = 93
    end
  end
  inherited tr_Main: TIBTransaction
    Active = True
  end
  inherited tr_Voc: TIBTransaction
    Active = True
  end
  object ds_Equip: TDataSource
    DataSet = dset_Equip
    Left = 248
    Top = 56
  end
  object dset_Equip: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, rtrim(name)||'#39' '#8470#39'||number name'
      'from equipment'
      'where (id>0)'
      'and (activity is null)'
      'order by 2')
    Left = 288
    Top = 56
  end
end
