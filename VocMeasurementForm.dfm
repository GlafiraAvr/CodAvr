inherited frm_VocMeasurement: Tfrm_VocMeasurement
  Left = 475
  Top = 402
  Width = 336
  Height = 306
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1077#1076#1080#1085#1080#1094' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 225
    Width = 328
  end
  inherited pnl_EditFields: TPanel
    Top = 196
    Width = 328
    Height = 29
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 89
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Name: TDBEdit
      Left = 104
      Top = 4
      Width = 177
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Width = 328
    Height = 196
    inherited dbg_MainVoc: TDBGrid
      Left = 1
      Top = 1
      Width = 326
      Height = 194
      Align = alClient
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 276
          Visible = True
        end>
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Active = True
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_measurement(name)'
      'values(:name)')
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_measurement'
      'where (id > 0)'
      'order by name')
    ModifySQL.Strings = (
      'update s_measurement set'
      'name = :name,'
      'activity = :activity'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_MEASUREMENT_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_MEASUREMENT"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_MEASUREMENT"."ACTIVITY"'
    end
  end
end
