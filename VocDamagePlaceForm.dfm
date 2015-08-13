inherited frm_VocDamagePlace: Tfrm_VocDamagePlace
  Height = 253
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1077#1089#1090' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 172
  end
  inherited pnl_EditFields: TPanel
    Top = 125
    Height = 47
    object lbl_DamagePlace: TLabel
      Left = 17
      Top = 6
      Width = 121
      Height = 13
      Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_DamagePlace: TDBEdit
      Left = 16
      Top = 22
      Width = 249
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 125
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 124
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 286
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_DamagePlace(id, name)'
      'values(:id, :name)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_damageplace'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_DamagePlace set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_DAMAGEPLACE'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_DAMAGEPLACE.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_DAMAGEPLACE.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_DAMAGEPLACE.ACTIVITY'
      FixedChar = True
      Size = 1
    end
  end
end
