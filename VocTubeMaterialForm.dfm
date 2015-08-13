inherited frm_VocTubeMaterial: Tfrm_VocTubeMaterial
  Width = 336
  Height = 265
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1090#1088#1091#1073
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 184
    Width = 328
  end
  inherited pnl_EditFields: TPanel
    Top = 151
    Width = 328
    Height = 33
    object lbl_TubeMaterial: TLabel
      Left = 23
      Top = 13
      Width = 59
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_TubeMaterial: TDBEdit
      Left = 88
      Top = 8
      Width = 225
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Width = 328
    Height = 151
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Width = 329
      Height = 152
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 243
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_tubematerial(id, name)'
      'values(:id, :name)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_tubematerial'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_tubematerial set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_TUBEMATERIAL_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_TUBEMATERIAL.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_TUBEMATERIAL.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 16
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_TUBEMATERIAL.ACTIVITY'
      FixedChar = True
      Size = 1
    end
  end
end
