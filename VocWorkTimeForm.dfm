inherited frm_VocWorkTime: Tfrm_VocWorkTime
  Left = 314
  Top = 272
  Width = 584
  Height = 338
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 257
    Width = 576
  end
  inherited pnl_EditFields: TPanel
    Top = 205
    Width = 576
    Height = 52
    object lbl_Work: TLabel
      Left = 5
      Top = 8
      Width = 55
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1072
    end
    object lbl_Diam: TLabel
      Left = 288
      Top = 6
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object lbl_HourSummer: TLabel
      Left = 7
      Top = 32
      Width = 89
      Height = 13
      Caption = #1063#1077#1083'./'#1095#1072#1089#1086#1074' ('#1083#1077#1090#1086')'
    end
    object lbl_HourWinter: TLabel
      Left = 199
      Top = 32
      Width = 92
      Height = 13
      Caption = #1063#1077#1083'./'#1095#1072#1089#1086#1074' ('#1079#1080#1084#1072')'
    end
    object Label1: TLabel
      Left = 387
      Top = 31
      Width = 59
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object dbl_Work: TRxDBLookupCombo
      Left = 64
      Top = 4
      Width = 209
      Height = 21
      DropDownCount = 8
      DataField = 'ID_WORK'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'clcFULL_WORK_NAME'
      LookupSource = ds_Work
      TabOrder = 0
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 337
      Top = 4
      Width = 108
      Height = 21
      DropDownCount = 8
      DataField = 'ID_DIAM'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME_'
      LookupSource = ds_Diam
      TabOrder = 1
    end
    object ed_HourSummer: TDBEdit
      Left = 100
      Top = 28
      Width = 92
      Height = 21
      DataField = 'HOUR_SUMMER'
      DataSource = ds_MainVoc
      TabOrder = 2
    end
    object ed_HourWinter: TDBEdit
      Left = 293
      Top = 28
      Width = 90
      Height = 21
      DataField = 'HOUR_WINTER'
      DataSource = ds_MainVoc
      TabOrder = 3
    end
    object ed_MeasurQuantity: TDBEdit
      Left = 448
      Top = 28
      Width = 92
      Height = 21
      DataField = 'MEASUR_QUANTITY'
      DataSource = ds_MainVoc
      TabOrder = 4
    end
  end
  inherited pnl_Grid: TPanel
    Width = 576
    Height = 205
    inherited dbg_MainVoc: TDBGrid
      Left = 1
      Top = 1
      Width = 574
      Height = 203
      Align = alClient
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'clcFULL_WORK_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1072
          Width = 206
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DIAMETER'
          Title.Alignment = taCenter
          Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOUR_SUMMER'
          Title.Alignment = taCenter
          Title.Caption = #1063#1077#1083'./'#1095#1072#1089#1086#1074' ('#1083#1077#1090#1086')'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOUR_WINTER'
          Title.Alignment = taCenter
          Title.Caption = #1063#1077#1083'./'#1095#1072#1089#1086#1074' ('#1079#1080#1084#1072')'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MEASUR_QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Visible = True
        end>
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Active = True
  end
  inherited dset_MainVoc: TIBDataSet
    OnCalcFields = dset_MainVocCalcFields
    InsertSQL.Strings = (
      'insert into s_worktime('
      'id_work,'
      'id_diam,'
      'hour_summer,'
      'hour_winter,'
      'measur_quantity)'
      'values('
      ':id_work,'
      ':id_diam,'
      ':hour_summer,'
      ':hour_winter,'
      ':measur_quantity)')
    SelectSQL.Strings = (
      'select wt.id, wt.id_work, wt.id_diam,'
      'wt.hour_summer, wt.hour_winter,'
      'wt.measur_quantity, wt.activity,'
      'w.name work_name, td.diameter,'
      'sm.name measurement'
      'from s_worktime wt'
      'left join s_works w on w.id = wt.id_work'
      'left join s_tubediameter td on td.id = wt.id_diam'
      'left join s_measurement sm on sm.id = w.id_measurement'
      'where wt.id>0'
      'order by w.name, td.diameter')
    ModifySQL.Strings = (
      'update s_worktime set'
      'id_work = :id_work,'
      'id_diam = :id_diam,'
      'hour_summer = :hour_summer,'
      'hour_winter = :hour_winter,'
      'measur_quantity = :measur_quantity,'
      'activity = :activity'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_WORKTIME_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKTIME"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocID_WORK: TIntegerField
      FieldName = 'ID_WORK'
      Origin = '"S_WORKTIME"."ID_WORK"'
      OnChange = dset_MainVocID_WORKChange
    end
    object dset_MainVocID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = '"S_WORKTIME"."ID_DIAM"'
      OnChange = dset_MainVocID_WORKChange
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_WORKTIME"."ACTIVITY"'
    end
    object dset_MainVocHOUR_SUMMER: TIBBCDField
      FieldName = 'HOUR_SUMMER'
      Origin = '"S_WORKTIME"."HOUR_SUMMER"'
      Precision = 9
      Size = 2
    end
    object dset_MainVocHOUR_WINTER: TIBBCDField
      FieldName = 'HOUR_WINTER'
      Origin = '"S_WORKTIME"."HOUR_WINTER"'
      Precision = 9
      Size = 2
    end
    object dset_MainVocMEASUR_QUANTITY: TIBBCDField
      FieldName = 'MEASUR_QUANTITY'
      Origin = '"S_WORKTIME"."MEASUR_QUANTITY"'
      Precision = 9
      Size = 2
    end
    object dset_MainVocDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
    end
    object dset_MainVocMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
    object dset_MainVocWORK_NAME: TIBStringField
      FieldName = 'WORK_NAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 32
    end
    object dset_MainVocclcFULL_WORK_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcFULL_WORK_NAME'
      Size = 50
      Calculated = True
    end
  end
  object dset_Work: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    OnCalcFields = dset_MainVocCalcFields
    SelectSQL.Strings = (
      'select sw.id, sw.name work_name, sm.name measurement'
      'from s_works sw'
      'left join s_measurement sm on sm.id = sw.id_measurement'
      'where sw.activity is null'
      'order by sw.name')
    Left = 88
    Top = 120
    object dset_WorkID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorkWORK_NAME: TIBStringField
      FieldName = 'WORK_NAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 32
    end
    object dset_WorkMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = '"S_MEASUREMENT"."NAME"'
      Size = 15
    end
    object dset_WorkclcFULL_WORK_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'clcFULL_WORK_NAME'
      Size = 50
      Calculated = True
    end
  end
  object dset_Diam: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select sd.id,'
      '(select strval from tochar(sd.diameter)) as name_'
      'from s_tubediameter sd'
      'order by sd.diameter'
      '')
    Left = 280
    Top = 136
    object dset_DiamID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_TUBEDIAMETER"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_DiamNAME_: TIBStringField
      FieldName = 'NAME_'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
  end
  object ds_Work: TDataSource
    DataSet = dset_Work
    Left = 88
    Top = 168
  end
  object ds_Diam: TDataSource
    DataSet = dset_Diam
    Left = 280
    Top = 176
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    Left = 280
    Top = 64
  end
end
