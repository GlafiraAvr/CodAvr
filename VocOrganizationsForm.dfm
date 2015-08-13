inherited frm_VocOrganizations: Tfrm_VocOrganizations
  Height = 261
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1082#1086#1085#1090#1088#1086#1083#1080#1088#1091#1102#1097#1080#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 180
  end
  inherited pnl_EditFields: TPanel
    Top = 136
    Height = 44
    object lbl_Name: TLabel
      Left = 16
      Top = 5
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
    object lbl_Phone: TLabel
      Left = 190
      Top = 4
      Width = 53
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Name: TDBEdit
      Left = 16
      Top = 20
      Width = 163
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object ed_Phone: TDBEdit
      Left = 188
      Top = 20
      Width = 125
      Height = 21
      DataField = 'PHONE'
      DataSource = ds_MainVoc
      TabOrder = 1
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 136
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 135
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
          FieldName = 'PHONE'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
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
      'insert into s_organisations(id, name, phone)'
      'values(:id, :name, :phone)')
    SelectSQL.Strings = (
      'select id, name, phone, activity'
      'from s_organisations'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_organisations set'
      'name=:name,'
      'phone=:phone,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_ORGANISATIONS'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_ORGANISATIONS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_ORGANISATIONS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocPHONE: TIBStringField
      FieldName = 'PHONE'
      Origin = 'S_ORGANISATIONS.PHONE'
      OnGetText = GetText
      FixedChar = True
      Size = 16
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_ORGANISATIONS.ACTIVITY'
      FixedChar = True
      Size = 18
    end
  end
end
