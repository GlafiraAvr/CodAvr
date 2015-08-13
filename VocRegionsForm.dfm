inherited frm_VocRegions: Tfrm_VocRegions
  Height = 282
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1080#1074#1085#1099#1093' '#1088#1072#1081#1086#1085#1086#1074
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 201
  end
  inherited pnl_EditFields: TPanel
    Top = 167
    Height = 34
    object lbl_Name: TLabel
      Left = 16
      Top = 16
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
    object ed_Name: TDBEdit
      Left = 80
      Top = 8
      Width = 217
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 167
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 166
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
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_regions(id, name, activity)'
      'values(:id, :name, :activity)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_regions'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_regions set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_REGIONS_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_REGIONS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_REGIONS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_REGIONS.ACTIVITY'
      FixedChar = True
      Size = 18
    end
  end
end
