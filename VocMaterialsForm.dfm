inherited frm_VocMaterials: Tfrm_VocMaterials
  Left = 454
  Top = 266
  Height = 309
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 221
  end
  inherited pnl_EditFields: TPanel
    Top = 177
    Height = 44
    object lbl_name: TLabel
      Left = 16
      Top = 4
      Width = 59
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_measurement: TLabel
      Left = 184
      Top = 3
      Width = 89
      Height = 13
      Caption = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Name: TDBEdit
      Left = 13
      Top = 18
      Width = 156
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object ed_measurement: TDBEdit
      Left = 176
      Top = 19
      Width = 121
      Height = 21
      DataField = 'MEASUREMENT'
      DataSource = ds_MainVoc
      TabOrder = 1
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 177
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 183
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MEASUREMENT'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'.'#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into materials(id, name, measurement)'
      'values(:id, :name, :measurement)')
    SelectSQL.Strings = (
      'select id, name, measurement, activity'
      'from materials'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update materials set'
      'name=:name,'
      'measurement=:measurement,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_MATERIALS'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'MATERIALS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'MATERIALS.NAME'
      Required = True
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = 'MATERIALS.MEASUREMENT'
      OnGetText = GetText
      FixedChar = True
      Size = 16
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'MATERIALS.ACTIVITY'
      FixedChar = True
      Size = 18
    end
  end
end
