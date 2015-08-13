inherited frame_EquipGrid: Tframe_EquipGrid
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
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPEQUIPMENT_EQUIPMENT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      TabOrder = 0
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
  object ds_Equip: TDataSource
    DataSet = dset_Equip
    Left = 248
    Top = 56
  end
end
