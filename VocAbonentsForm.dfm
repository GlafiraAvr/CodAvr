inherited frm_VocAbonents: Tfrm_VocAbonents
  Left = 433
  Top = 135
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1072#1073#1086#1085#1077#1085#1090#1086#1074
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_EditFields: TPanel
    Top = 230
    Height = 44
    object lbl_Abonent: TLabel
      Left = 4
      Top = 1
      Width = 50
      Height = 13
      Caption = #1040#1073#1086#1085#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Abonent: TDBEdit
      Left = 5
      Top = 16
      Width = 316
      Height = 21
      DataField = 'NAME_R'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Height = 230
    inherited dbg_MainVoc: TDBGrid
      Left = 2
      Top = 3
      Width = 326
      Height = 223
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_R'
          Title.Alignment = taCenter
          Title.Caption = #1040#1073#1086#1085#1077#1085#1090
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 285
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into S_ABONENTS(id, name_r)'
      'values(:id, :name_r)')
    SelectSQL.Strings = (
      'select id, name_r, activity'
      'from S_ABONENTS'
      'where id<>-1'
      'order by name_r')
    ModifySQL.Strings = (
      'update S_ABONENTS set'
      'name_r=:name_r,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_ABONENTS_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_ABONENTS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME_R: TIBStringField
      FieldName = 'NAME_R'
      Origin = '"S_ABONENTS"."NAME_R"'
      Required = True
      Size = 64
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"S_ABONENTS"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
  end
end
