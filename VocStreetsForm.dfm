inherited frm_VocStreets: Tfrm_VocStreets
  Left = 310
  Top = 294
  Width = 418
  Height = 372
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1091#1083#1080#1094
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 291
    Width = 410
  end
  inherited pnl_EditFields: TPanel
    Top = 241
    Width = 410
    Height = 50
    object lbl_Streets: TLabel
      Left = 19
      Top = 2
      Width = 99
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1083#1080#1094#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_StreetTypes: TLabel
      Left = 243
      Top = 2
      Width = 63
      Height = 13
      Caption = #1058#1080#1087' '#1091#1083#1080#1094#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Streets: TDBEdit
      Left = 16
      Top = 16
      Width = 201
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object dbl_StreetTypes: TRxDBLookupCombo
      Left = 240
      Top = 17
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_STREETS_STREETTYPES'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Streettypes
      TabOrder = 1
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Width = 410
    Height = 241
    inherited dbg_MainVoc: TDBGrid
      Width = 411
      Height = 200
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1083#1080#1094#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 225
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'luf_StreetTypes'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1091#1083#1080#1094#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
    object dbl_Streets: TRxDBLookupCombo
      Left = 7
      Top = 7
      Width = 209
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_MainVoc
      TabOrder = 1
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_streets(id, name, fk_streets_streettypes)'
      'values(:id, :name, :fk_streets_streettypes)')
    RefreshSQL.Strings = (
      'select id, name, fk_streets_streettypes, activity'
      'from s_streets'
      'where id=:id')
    SelectSQL.Strings = (
      'select id, name, fk_streets_streettypes, activity'
      'from s_streets'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_streets set'
      'name=:name,'
      'fk_streets_streettypes=:fk_streets_streettypes,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_STREETS_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_STREETS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_STREETS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
    object dset_MainVocFK_STREETS_STREETTYPES: TIntegerField
      FieldName = 'FK_STREETS_STREETTYPES'
      Origin = 'S_STREETS.FK_STREETS_STREETTYPES'
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = 'S_STREETS.ACTIVITY'
    end
    object dset_MainVocluf_StreetTypes: TStringField
      FieldKind = fkLookup
      FieldName = 'luf_StreetTypes'
      LookupDataSet = dset_StreetTypes
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_STREETS_STREETTYPES'
      Lookup = True
    end
  end
  object dset_StreetTypes: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_streettypes'
      'where activity is null'
      'order by name')
    Left = 264
    Top = 184
  end
  object ds_Streettypes: TDataSource
    DataSet = dset_StreetTypes
    Left = 304
    Top = 184
  end
end
