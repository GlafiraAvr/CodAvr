inherited frm_VocProfWorks: Tfrm_VocProfWorks
  Left = 329
  Top = 163
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1074#1080#1076#1086#1074' '#1087#1088#1086#1092#1088#1072#1073#1086#1090
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_EditFields: TPanel
    Top = 229
    Height = 45
    object lbl_ProfWork: TLabel
      Left = 4
      Top = 1
      Width = 100
      Height = 13
      Caption = #1042#1080#1076' '#1087#1088#1086#1092#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_ProfWork: TDBEdit
      Left = 5
      Top = 16
      Width = 305
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Height = 229
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 224
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1042#1080#1076' '#1087#1088#1086#1092#1088#1072#1073#1086#1090#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 290
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_profworks(id, name)'
      'values(:id, :name)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_profworks'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_Profworks set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_PROFWORKS'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_PROFWORKS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_PROFWORKS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 32
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_PROFWORKS.ACTIVITY'
      FixedChar = True
      Size = 1
    end
  end
end
