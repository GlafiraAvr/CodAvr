inherited frame_DepEqipPlanChange: Tframe_DepEqipPlanChange
  Width = 479
  inherited DBGrid: TDBGridEh
    Top = 41
    Width = 479
    Height = 293
    Columns = <
      item
        FieldName = 'EQUIP'
        Footers = <>
        Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Width = 223
      end>
  end
  inherited pnl_Fields: TPanel
    Width = 479
    Height = 41
    Visible = False
    object Label1: TLabel
      Left = 14
      Top = 13
      Width = 19
      Height = 13
      Caption = #1058#1080#1087
    end
    object Label2: TLabel
      Left = 207
      Top = 12
      Width = 73
      Height = 13
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
    end
    object rdbl_equip: TRxDBLookupCombo
      Left = 285
      Top = 10
      Width = 172
      Height = 21
      DropDownCount = 8
      DataField = 'FK_ID_EQUIPMENT'
      DataSource = ds_Main
      Enabled = False
      LookupField = 'id'
      LookupDisplay = 'FullName'
      LookupSource = ds_equip
      TabOrder = 1
      OnEnter = rdbl_equip_typEnter
      OnExit = rdbl_equip_typExit
    end
    object rdbl_equip_typ: TRxDBLookupCombo
      Left = 42
      Top = 9
      Width = 151
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EQUIP_TYP'
      DataSource = ds_Main
      Enabled = False
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_equip_typ
      TabOrder = 0
      OnChange = rdbl_equip_typChange
      OnEnter = rdbl_equip_typEnter
      OnExit = rdbl_equip_typExit
    end
  end
  object ds_equip: TDataSource
    Left = 328
    Top = 32
  end
  object ds_equip_typ: TDataSource
    DataSet = dm_DepPlanEqChange.dset_eqip_type
    Left = 64
    Top = 16
  end
end
