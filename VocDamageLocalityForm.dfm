inherited frm_VocDamageLocality: Tfrm_VocDamageLocality
  Height = 263
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1089#1090#1085#1086#1089#1090#1077#1081' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 182
  end
  inherited pnl_EditFields: TPanel
    Top = 139
    Height = 43
    object lbl_DamageLocality: TLabel
      Left = 8
      Top = 3
      Width = 148
      Height = 13
      Caption = #1052#1077#1089#1090#1085#1086#1089#1090#1100' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_DamageLocality: TDBEdit
      Left = 8
      Top = 18
      Width = 289
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 139
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 138
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1085#1086#1089#1090#1100' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 273
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_damagelocality(id, name)'
      'values(:id, :name)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_damagelocality'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_damagelocality set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_DAMAGELOCALITY'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_DAMAGELOCALITY.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_DAMAGELOCALITY.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_DAMAGELOCALITY.ACTIVITY'
      FixedChar = True
      Size = 1
    end
  end
end
