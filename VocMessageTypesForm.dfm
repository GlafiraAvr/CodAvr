inherited frm_VocMessageTypes: Tfrm_VocMessageTypes
  Left = 177
  Top = 72
  Height = 376
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 288
  end
  inherited pnl_EditFields: TPanel
    Top = 209
    Height = 79
    object lbl_MessageType: TLabel
      Left = 4
      Top = 2
      Width = 68
      Height = 13
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_MtCategory: TLabel
      Left = 5
      Top = 39
      Width = 93
      Height = 13
      Caption = #1058#1080#1087' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_MessageType: TDBEdit
      Left = 4
      Top = 18
      Width = 297
      Height = 21
      DataField = 'MESSAGENAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object dbl_MtCategory: TRxDBLookupCombo
      Left = 5
      Top = 53
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'S_MT_CATEGORY_ID'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME_R'
      LookupSource = ds_MtCategory
      TabOrder = 1
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 209
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 205
      Columns = <
        item
          Expanded = False
          FieldName = 'MESSAGENAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end
        item
          DropDownRows = 5
          Expanded = False
          FieldName = 'listMTCategory'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 92
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_MessageTypes(id, messagename,S_MT_CATEGORY_ID)'
      'values(:id, :messagename,:S_MT_CATEGORY_ID)')
    SelectSQL.Strings = (
      'select id, messagename, activity, S_MT_CATEGORY_ID'
      'from s_MessageTypes'
      'where id<>-1'
      'order by messagename')
    ModifySQL.Strings = (
      'update s_MessageTypes set'
      'messagename=:messagename,'
      'activity=:activity,'
      'S_MT_CATEGORY_ID = :S_MT_CATEGORY_ID'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_MESSAGETYPES'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_MESSAGETYPES.ID'
      Required = True
    end
    object dset_MainVocMESSAGENAME: TIBStringField
      FieldName = 'MESSAGENAME'
      Origin = 'S_MESSAGETYPES.MESSAGENAME'
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_MESSAGETYPES.ACTIVITY'
      FixedChar = True
      Size = 1
    end
    object dset_MainVocS_MT_CATEGORY_ID: TIntegerField
      FieldName = 'S_MT_CATEGORY_ID'
      Origin = '"S_MESSAGETYPES"."S_MT_CATEGORY_ID"'
    end
    object dset_MainVoclistMTCategory: TStringField
      FieldKind = fkLookup
      FieldName = 'listMTCategory'
      LookupDataSet = dset_MtCategory
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_R'
      KeyFields = 'S_MT_CATEGORY_ID'
      Size = 64
      Lookup = True
    end
  end
  object dset_MtCategory: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name_r'
      'from S_MT_CATEGORY'
      'where activity is null'
      'order by name_r')
    Left = 248
    Top = 152
  end
  object ds_MtCategory: TDataSource
    DataSet = dset_MtCategory
    Left = 280
    Top = 152
  end
end
