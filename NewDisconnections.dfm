inherited frm_DisconNew: Tfrm_DisconNew
  Left = 529
  Top = 211
  Width = 672
  Height = 679
  Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 664
    Height = 300
    object Label1: TLabel [0]
      Left = 6
      Top = 154
      Width = 222
      Height = 16
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnl_Adres: TGroupBox
      Top = 5
      Width = 649
      inherited lbl_HouseType: TLabel
        Visible = False
      end
      inherited lbl_Street: TLabel
        Top = 20
      end
      inherited lbl_AddAdres: TLabel
        Left = 9
        Top = 54
        Width = 60
        Caption = #1044#1086#1087'. '#1080#1085#1092'.'
      end
      inherited lbl_HouseNum: TLabel
        Top = 20
      end
      inherited dbl_HouseType: TRxDBLookupCombo
        Visible = False
      end
      inherited dbl_Street: TRxDBLookupCombo
        Top = 16
        DataField = 'FK_ID_STREET'
        OnKeyDown = FormKeyDown
      end
      inherited ed_AddAdres: TDBEdit
        Left = 82
        Top = 48
        Width = 431
        DataField = 'ADDITIONALINFO'
        OnKeyDown = FormKeyDown
      end
      inherited ed_HouseNum: TDBEdit
        Top = 16
        Width = 310
        DataField = 'HOUSES'
        OnKeyDown = FormKeyDown
      end
    end
    object mem_Disconnections: TMemo
      Left = 4
      Top = 190
      Width = 653
      Height = 95
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'Memo1')
      TabOrder = 2
      OnChange = CtrlsChange
      OnKeyDown = FormKeyDown
    end
    object gb_DTTMExec: TGroupBox
      Left = 8
      Top = 81
      Width = 649
      Height = 103
      TabOrder = 1
      object Label8: TLabel
        Left = 2
        Top = 11
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1090#1072' '#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 5
        Top = 39
        Width = 65
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1090#1072#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 173
        Top = 9
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 174
        Top = 42
        Width = 65
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 330
        Top = 11
        Width = 79
        Height = 26
        Alignment = taCenter
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100#13#10#1086#1090#1082#1083'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 328
        Top = 40
        Width = 97
        Height = 26
        Alignment = taCenter
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1074#1082#1083'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 67
        Width = 66
        Height = 26
        Caption = #1055#1083#1072#1085'. '#1076#1072#1090#1072#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 172
        Top = 75
        Width = 76
        Height = 26
        Caption = #1055#1083#1072#1085'. '#1074#1088#1077#1084#1103#13#10'  '#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object de_Discon: TDBDateEdit
        Left = 77
        Top = 11
        Width = 87
        Height = 21
        DataField = 'DTTM_DISCON'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 0
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object de_Con: TDBDateEdit
        Left = 77
        Top = 42
        Width = 87
        Height = 21
        DataField = 'DTTM_CON'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 3
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_Discon: TDBDateTimeEditEh
        Left = 250
        Top = 12
        Width = 73
        Height = 21
        DataField = 'DTTM_DISCON'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 1
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_Con: TDBDateTimeEditEh
        Left = 250
        Top = 44
        Width = 73
        Height = 21
        DataField = 'DTTM_CON'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 4
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_Executor: TRxDBLookupCombo
        Left = 427
        Top = 13
        Width = 129
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_EXECUTOR'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Executor
        TabOrder = 2
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_BrigConnect: TRxDBLookupCombo
        Left = 426
        Top = 42
        Width = 129
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_BRIG_CONNECT'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Brig_connect
        TabOrder = 5
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object bb_DisconTimeAll: TBitBtn
        Left = 561
        Top = 12
        Width = 75
        Height = 25
        Caption = #1050#1086#1087#1080#1103' '#1087#1088#1077#1076'.'
        TabOrder = 8
        OnClick = bb_DisconTimeAllClick
        OnEnter = EntryEnter
        OnExit = EntryExit
        NumGlyphs = 2
      end
      object bb_ConnectTimeAll: TBitBtn
        Left = 561
        Top = 40
        Width = 75
        Height = 25
        Caption = #1042#1082#1083'. '#1089#1087#1080#1089#1086#1082
        TabOrder = 9
        OnClick = bb_ConnectTimeAllClick
        OnEnter = EntryEnter
        OnExit = EntryExit
        NumGlyphs = 2
      end
      object te_Plan: TDBDateTimeEditEh
        Left = 250
        Top = 76
        Width = 73
        Height = 21
        DataField = 'DTTM_PLAN'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 7
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object de_Plan: TDBDateEdit
        Left = 77
        Top = 73
        Width = 87
        Height = 21
        DataField = 'DTTM_PLAN'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 6
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 594
    Width = 664
  end
  inherited dbg_Main: TDBGrid
    Top = 300
    Width = 664
    Height = 294
    ReadOnly = True
    Columns = <
      item
        Expanded = False
        FieldName = 'look_streets'
        Title.Alignment = taCenter
        Title.Caption = #1059#1083#1080#1094#1072
        Width = 217
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HOUSES'
        Title.Caption = #8470' '#1076#1086#1084#1072
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADDITIONALINFO'
        Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_DISCON'
        Title.Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1086
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'look_discon_exec'
        Title.Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' '#1086#1090#1082#1083'.'
        Width = 122
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_CON'
        Title.Caption = #1042#1082#1083#1102#1095#1077#1085#1086
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'look_brig_connect'
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1074#1082#1083'.'
        Width = 130
        Visible = True
      end>
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 626
    Width = 664
  end
  inherited Tr_Voc: TIBTransaction
    Top = 200
  end
  inherited dset_HouseType: TIBDataSet
    Top = 192
  end
  inherited dset_Street: TIBDataSet
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name,'
      's.activity'
      'from s_streets s'
      'where s.id>0 '
      'order by name')
    Top = 192
  end
  inherited dset_Street2: TIBDataSet
    Top = 192
  end
  inherited dset_main: TIBDataSet
    OnCalcFields = dset_mainCalcFields
    DeleteSQL.Strings = (
      'delete'
      ' from disconnections '
      ' where id=:id')
    InsertSQL.Strings = (
      'insert into disconnections'
      '('
      '  fk_id_order,'
      '  fk_id_street,'
      '  houses,'
      '  additionalinfo ,'
      '  DTTM_DISCON,'
      '  DTTM_CON,'
      '  FK_DISCON_EXECUTOR,'
      '  FK_DISCON_BRIG_CONNECT,'
      '  DTTM_PLAN'
      ')'
      'values ('
      '  :fk_id_order,'
      '  :fk_id_street,'
      '  :houses,'
      '  :additionalinfo,'
      '  :DTTM_DISCON,'
      '  :DTTM_CON,'
      '  :FK_DISCON_EXECUTOR,'
      '  :FK_DISCON_BRIG_CONNECT,'
      '  :DTTM_PLAN'
      ')')
    SelectSQL.Strings = (
      'select'
      '  di.id'
      ' , di.fk_id_order'
      ' , di.fk_id_street'
      ' , di.houses '
      ' , di.additionalinfo'
      ' , di.DTTM_DISCON'
      ' , di.DTTM_CON'
      ' , di.FK_DISCON_EXECUTOR'
      ' , di.FK_DISCON_BRIG_CONNECT'
      ' ,di.DTTM_plan'
      'from disconnections di'
      'where di.fk_id_order = :porderid')
    ModifySQL.Strings = (
      'update disconnections set'
      'fk_id_order=:fk_id_order,'
      'fk_id_street=:fk_id_street,'
      'houses=:houses,'
      'additionalinfo=:additionalinfo,'
      'DTTM_DISCON = :DTTM_DISCON,'
      'DTTM_CON=:DTTM_CON,'
      'FK_DISCON_EXECUTOR=:FK_DISCON_EXECUTOR,'
      'FK_DISCON_BRIG_CONNECT=:FK_DISCON_BRIG_CONNECT,'
      'DTTM_PLAN = :DTTM_PLAN'
      'where id=:id')
    object dset_mainFK_ID_ORDER: TIntegerField
      FieldName = 'FK_ID_ORDER'
      Origin = '"DISCONNECTIONS"."FK_ID_ORDER"'
      Required = True
    end
    object dset_mainFK_ID_STREET: TIntegerField
      FieldName = 'FK_ID_STREET'
      Origin = '"DISCONNECTIONS"."FK_ID_STREET"'
    end
    object dset_mainHOUSES: TIBStringField
      FieldName = 'HOUSES'
      Origin = '"DISCONNECTIONS"."HOUSES"'
      FixedChar = True
      Size = 64
    end
    object dset_mainADDITIONALINFO: TIBStringField
      FieldName = 'ADDITIONALINFO'
      Origin = '"DISCONNECTIONS"."ADDITIONALINFO"'
      FixedChar = True
      Size = 64
    end
    object dset_mainlook_streets: TStringField
      FieldKind = fkLookup
      FieldName = 'look_streets'
      LookupDataSet = dset_Street
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_ID_STREET'
      Size = 40
      Lookup = True
    end
    object dset_mainDTTM_DISCON: TDateTimeField
      FieldName = 'DTTM_DISCON'
      Origin = '"DISCONNECTIONS"."DTTM_DISCON"'
    end
    object dset_mainDTTM_CON: TDateTimeField
      FieldName = 'DTTM_CON'
      Origin = '"DISCONNECTIONS"."DTTM_CON"'
    end
    object dset_mainFK_DISCON_EXECUTOR: TIntegerField
      FieldName = 'FK_DISCON_EXECUTOR'
      Origin = '"DISCONNECTIONS"."FK_DISCON_EXECUTOR"'
    end
    object dset_mainFK_DISCON_BRIG_CONNECT: TIntegerField
      FieldName = 'FK_DISCON_BRIG_CONNECT'
      Origin = '"DISCONNECTIONS"."FK_DISCON_BRIG_CONNECT"'
    end
    object dset_mainlook_discon_exec: TStringField
      FieldKind = fkLookup
      FieldName = 'look_discon_exec'
      LookupDataSet = dset_executor
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_DISCON_EXECUTOR'
      Size = 64
      Lookup = True
    end
    object dset_mainlook_brig_connect: TStringField
      FieldKind = fkLookup
      FieldName = 'look_brig_connect'
      LookupDataSet = dset_Brig_connect
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_DISCON_BRIG_CONNECT'
      Size = 64
      Lookup = True
    end
    object dset_mainDTTM_PLAN: TDateTimeField
      FieldName = 'DTTM_PLAN'
      Origin = '"DISCONNECTIONS"."DTTM_PLAN"'
    end
  end
  inherited ds_HouseType: TDataSource
    Top = 216
  end
  inherited ds_Street: TDataSource
    Top = 216
  end
  inherited ds_Street2: TDataSource
    Top = 216
  end
  object dset_executor: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from brigadiers'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 328
    Top = 192
  end
  object ds_Executor: TDataSource
    DataSet = dset_executor
    Left = 328
    Top = 216
  end
  object dset_Brig_connect: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from brigadiers'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 368
    Top = 192
  end
  object ds_Brig_connect: TDataSource
    DataSet = dset_Brig_connect
    Left = 368
    Top = 216
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    Left = 256
    Top = 288
  end
end
