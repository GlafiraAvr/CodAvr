inherited frm_VocWorks: Tfrm_VocWorks
  Left = 391
  Top = 235
  Width = 528
  Height = 396
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1086#1076#1088#1072#1073#1086#1090
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 315
    Width = 520
  end
  inherited pnl_EditFields: TPanel
    Top = 255
    Width = 520
    Height = 60
    object lbl_work: TLabel
      Left = 15
      Top = 1
      Width = 93
      Height = 26
      Alignment = taCenter
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#13#10#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 38
      Top = 30
      Width = 66
      Height = 26
      Alignment = taCenter
      Caption = #1045#1076#1080#1085#1080#1094#1072#13#10#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 281
      Top = 31
      Width = 44
      Height = 26
      Alignment = taCenter
      Caption = #1058#1080#1087' '#13#10#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_work: TDBEdit
      Left = 110
      Top = 6
      Width = 211
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
    object RxDBLookupCombo1: TRxDBLookupCombo
      Left = 109
      Top = 34
      Width = 156
      Height = 21
      DropDownCount = 8
      DataField = 'ID_MEASUREMENT'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Measurement
      TabOrder = 1
    end
    object RxDBLookupCombo2: TRxDBLookupCombo
      Left = 327
      Top = 34
      Width = 163
      Height = 21
      DropDownCount = 8
      DataField = 'ID_WORKKIND'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_WorkKind
      TabOrder = 2
    end
  end
  inherited pnl_Grid: TPanel
    Width = 520
    Height = 255
    inherited dbg_MainVoc: TDBGrid
      Left = 1
      Top = 1
      Width = 518
      Height = 253
      Align = alClient
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 245
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MEASUREMENT'
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WORKKIND'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1088#1072#1073#1086#1090#1099
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 105
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    AfterInsert = dset_MainVocAfterInsert
    InsertSQL.Strings = (
      'insert into s_works(name, id_measurement, id_workkind)'
      'values(:name, :id_measurement, :id_workkind)')
    SelectSQL.Strings = (
      
        'select sw.id, sw.name, sw.id_measurement, sw.id_workkind, sw.act' +
        'ivity,'
      'sm.name measurement, swk.name workkind'
      'from s_works sw'
      'left join s_measurement sm on sm.id = sw.id_measurement'
      'left join s_workkind swk on swk.id = sw.id_workkind'
      'where sw.id>-1'
      'order by sw.name')
    ModifySQL.Strings = (
      'update s_works set'
      'name=:name,'
      'id_measurement = :id_measurement,'
      'id_workkind = :id_workkind,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_WORKS_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 32
    end
    object dset_MainVocID_MEASUREMENT: TIntegerField
      FieldName = 'ID_MEASUREMENT'
      Origin = '"S_WORKS"."ID_MEASUREMENT"'
    end
    object dset_MainVocID_WORKKIND: TIntegerField
      FieldName = 'ID_WORKKIND'
      Origin = '"S_WORKS"."ID_WORKKIND"'
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"S_WORKS"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
    object dset_MainVocMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
    object dset_MainVocWORKKIND: TIBStringField
      FieldName = 'WORKKIND'
      Origin = '"S_WORKKIND"."NAME"'
      Size = 15
    end
  end
  object ds_Measurement: TDataSource
    DataSet = dset_Measurement
    Left = 280
    Top = 56
  end
  object dset_Measurement: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_measurement'
      'where activity is null'
      'order by name')
    Left = 280
    Top = 88
    object dset_MeasurementID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_MEASUREMENT"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MeasurementNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
  end
  object dset_WorkKind: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_workkind'
      'where activity is null'
      'order by name')
    Left = 360
    Top = 88
    object dset_WorkKindID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKKIND"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorkKindNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_WORKKIND"."NAME"'
      Size = 15
    end
  end
  object ds_WorkKind: TDataSource
    DataSet = dset_WorkKind
    Left = 360
    Top = 56
  end
end
