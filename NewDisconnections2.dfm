inherited frm_DisconNew2: Tfrm_DisconNew2
  Left = 330
  Top = 130
  Width = 865
  Height = 735
  Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 849
    Height = 441
    inherited pnl_Adres: TGroupBox
      Top = 5
      Width = 713
      Height = 116
      inherited lbl_HouseType: TLabel
        Visible = False
      end
      inherited lbl_Street: TLabel
        Top = 20
      end
      inherited lbl_AddAdres: TLabel
        Left = 9
        Top = 78
        Width = 60
        Caption = #1044#1086#1087'. '#1080#1085#1092'.'
      end
      inherited lbl_HouseNum: TLabel
        Left = 272
        Top = 13
        Width = 88
        Caption = #1053#1086#1084#1077#1088#1072' '#1076#1086#1084#1086#1074
      end
      inherited lbl_Street2: TLabel
        Top = 79
      end
      object Label5: TLabel [5]
        Left = 528
        Top = 19
        Width = 15
        Height = 13
        Caption = #1087#1086
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel [6]
        Left = 272
        Top = 24
        Width = 116
        Height = 13
        Caption = '('#1055#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1077' '#1080#1083#1080' "-")'
      end
      object Label4: TLabel [7]
        Left = 9
        Top = 68
        Width = 3
        Height = 13
      end
      object Label7: TLabel [8]
        Left = 8
        Top = 48
        Width = 65
        Height = 13
        Caption = #1069#1090#1072#1078#1085#1086#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited dbl_HouseType: TRxDBLookupCombo
        Visible = False
      end
      inherited dbl_Street: TRxDBLookupCombo
        Top = 16
        DataField = 'FK_ID_STREET'
        OnKeyDown = FormKeyDown
      end
      inherited dbl_Street2: TRxDBLookupCombo
        Top = 72
      end
      inherited ed_AddAdres: TDBEdit
        Left = 82
        Top = 72
        Width = 431
        DataField = 'ADDITIONALINFO'
        OnKeyDown = FormKeyDown
      end
      inherited ed_HouseNum: TDBEdit
        Left = 403
        Top = 16
        Width = 214
        Hint = '('#1055#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1077' '#1080#1083#1080' "-")'
        DataField = 'HOUSES'
        DataSource = ds_Main
        OnChange = ed_HouseNumChange
        OnKeyDown = FormKeyDown
      end
      object cb_privSec: TCheckBox
        Left = 417
        Top = 43
        Width = 128
        Height = 25
        Alignment = taLeftJustify
        Caption = #1063#1072#1089#1090#1085#1099#1081' '#1089#1077#1082#1090#1086#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        WordWrap = True
        OnClick = cb_privSecClick
      end
      object db_G_ATG: TDBNumberEditEh
        Left = 78
        Top = 44
        Width = 81
        Height = 21
        DataField = 'G_ATG'
        DataSource = ds_Main
        DecimalPlaces = 0
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        MaxValue = 2000.000000000000000000
        TabOrder = 6
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object cb_isGOr_VOD: TCheckBox
        Left = 241
        Top = 43
        Width = 128
        Height = 25
        Alignment = taLeftJustify
        Caption = #1043#1086#1088'. '#1074#1086#1076#1072' '#1077#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        WordWrap = True
        OnClick = cb_isGOr_VODClick
      end
    end
    object mem_Disconnections: TMemo
      Left = 4
      Top = 336
      Width = 846
      Height = 97
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 3
      OnChange = CtrlsChange
      OnKeyDown = FormKeyDown
    end
    object gb_DTTMExec: TGroupBox
      Left = 8
      Top = 217
      Width = 713
      Height = 104
      TabOrder = 2
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
        OnChange = de_ConChange
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
        OnChange = de_PlanChange
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
        OnChange = de_PlanChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
    object grbox_addinfo: TGroupBox
      Left = 8
      Top = 128
      Width = 713
      Height = 81
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      TabOrder = 1
      object Label15: TLabel
        Left = 8
        Top = 18
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1058#1080#1087#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 42
        Top = 52
        Width = 41
        Height = 13
        Caption = #1044#1086#1084#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 378
        Top = 53
        Width = 49
        Height = 13
        Caption = #1055#1086#1076'-'#1076#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 186
        Top = 53
        Width = 50
        Height = 13
        Caption = #1057#1090#1086#1103#1082#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_PPr: TLabel
        Left = 532
        Top = 46
        Width = 106
        Height = 20
        Caption = #1057#1086#1079#1076#1072#1085' '#1055#1055#1056
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rdbl_discon_type: TRxDBLookupCombo
        Left = 87
        Top = 20
        Width = 145
        Height = 21
        DropDownCount = 8
        DataField = 'FK_ID_DISKON_TYPE'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_discon_type
        TabOrder = 0
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object dbn_g_zhd: TDBNumberEditEh
        Left = 88
        Top = 48
        Width = 81
        Height = 21
        DataField = 'G_ZHD'
        DataSource = ds_Main
        DecimalPlaces = 0
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        MaxValue = 2000.000000000000000000
        TabOrder = 1
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object dbn_g_pod: TDBNumberEditEh
        Left = 432
        Top = 48
        Width = 89
        Height = 21
        currency = False
        DataField = 'G_POD'
        DataSource = ds_Main
        DecimalPlaces = 0
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        MaxValue = 2000.000000000000000000
        TabOrder = 3
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object DBN_G_stoy: TDBNumberEditEh
        Left = 248
        Top = 48
        Width = 89
        Height = 21
        currency = False
        DataField = 'G_STOJ'
        DataSource = ds_Main
        DecimalPlaces = 0
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        MaxValue = 2000.000000000000000000
        TabOrder = 2
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object cb_weak_press: TCheckBox
        Left = 376
        Top = 16
        Width = 137
        Height = 17
        Caption = #1057#1083#1072#1073#1086#1077' '#1076#1072#1074#1083#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = cb_weak_pressClick
      end
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 646
    Width = 849
    inherited btn_Post: TBitBtn
      Left = 400
    end
    inherited btn_Cancel: TBitBtn
      Left = 485
    end
    inherited btn_Exit: TBitBtn
      Left = 570
    end
    object Create_PPr: TBitBtn
      Left = 286
      Top = 4
      Width = 99
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1055#1055#1056
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Visible = False
      OnClick = Create_PPrClick
    end
  end
  inherited dbg_Main: TDBGrid
    Top = 441
    Width = 849
    Height = 205
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
        FieldName = 'G_ATG'
        Title.Caption = #1069#1090#1072#1078'.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GOR_VODCalc'
        Title.Caption = #1043#1086#1088'./ '#1074#1086#1076
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IsPrivateCalc'
        Title.Caption = #1063'./'#1089'.'
        Width = 32
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
        FieldName = 'look_discon_type'
        Title.Caption = #1058#1080#1087' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Width = 90
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
    Top = 678
    Width = 849
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
    AfterOpen = dset_mainAfterOpen
    BeforePost = dset_mainBeforePost
    OnCalcFields = dset_mainCalcFields
    DeleteSQL.Strings = (
      'execute procedure DeleteALLDISKONECTIONSPPR (:id)')
    InsertSQL.Strings = (
      ' execute procedure INSERTALLDISKONECTIONSPPR2'
      '(:id,'
      ':FK_ID_ORDER,'
      ':fk_id_street,'
      ':additionalinfo,'
      ':houses,'
      ':dttm_con,'
      ':dttm_discon,'
      ':fk_discon_executor,'
      ' :fk_discon_brig_connect,'
      ' :dttm_plan,'
      ':g_zhd,'
      ' :g_pod,'
      ':house2,'
      ':id_side,'
      ':works,'
      ':fk_id_houses_type,'
      ' :fk_id_diskon_type,'
      ':g_stoj,'
      ':isppr,'
      ':id_ppr,'
      ':ISPrivateSec,'
      ':house1,'
      ':GOR_VOD,'
      ':G_ATG,'
      ':weak_press'
      ')')
    SelectSQL.Strings = (
      'select id_diskon id,fk_id_order, fk_id_street, houses,'
      'additionalinfo, dttm_discon, dttm_con,'
      'fk_discon_executor, fk_discon_brig_connect, dttm_plan,'
      'g_zhd, g_pod,g_stoj,'
      'house2,house1,'
      'id_side, works,fk_id_houses_type, fk_id_diskon_type,'
      'isppr,'
      'id_ppr,'
      'id2,'
      'ISPrivateSec,'
      'G_ATG,'
      'GOR_VOD,'
      'WEAK_PRESS'
      ''
      'from getalldiskonectionsppr(:pOrderID)')
    ModifySQL.Strings = (
      'execute procedure UPDateALLDISKONECTIONSPPR2'
      '(:id,'
      ':porderid,'
      ':fk_id_street,'
      ':additionalinfo,'
      ':houses,'
      ':dttm_con,'
      ':dttm_discon,'
      ':fk_discon_executor,'
      ' :fk_discon_brig_connect,'
      ':DTTM_Plan,'
      ':G_ZHD,'
      ':G_POD,'
      ':HOUSE2,'
      ':id_side,'
      ':works,'
      ':fk_id_houses_type,'
      ' :fk_id_diskon_type,'
      ':g_stoj,'
      ':isppr,'
      ':id_ppr,'
      ':ISPrivateSec,'
      ':house1,'
      ':G_ATG,'
      ':GOR_VOD,'
      ':weak_press)')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DISCONNECTIONS'
    Left = 80
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
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DISCONNECTIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_mainG_ZHD: TIntegerField
      FieldName = 'G_ZHD'
      Origin = '"DISCONNECTIONS"."G_ZHD"'
    end
    object dset_mainG_POD: TIntegerField
      FieldName = 'G_POD'
      Origin = '"DISCONNECTIONS"."G_POD"'
    end
    object dset_mainID_SIDE: TIntegerField
      FieldName = 'ID_SIDE'
      Origin = '"GETALLDISKONECTIONSPPR"."ID_SIDE"'
    end
    object dset_mainFK_ID_HOUSES_TYPE: TIntegerField
      FieldName = 'FK_ID_HOUSES_TYPE'
      Origin = '"GETALLDISKONECTIONSPPR"."FK_ID_HOUSES_TYPE"'
    end
    object dset_mainFK_ID_DISKON_TYPE: TIntegerField
      FieldName = 'FK_ID_DISKON_TYPE'
      Origin = '"GETALLDISKONECTIONSPPR"."FK_ID_DISKON_TYPE"'
    end
    object dset_mainWORKS: TIBStringField
      FieldName = 'WORKS'
      Origin = '"GETALLDISKONECTIONSPPR"."WORKS"'
      Size = 30
    end
    object dset_mainHOUSE2: TIBStringField
      FieldName = 'HOUSE2'
      Origin = '"GETALLDISKONECTIONSPPR"."HOUSE2"'
      FixedChar = True
      Size = 10
    end
    object dset_mainG_STOJ: TIntegerField
      FieldName = 'G_STOJ'
      Origin = '"GETALLDISKONECTIONSPPR"."G_STOJ"'
    end
    object dset_mainISPPR: TIBStringField
      FieldName = 'ISPPR'
      Origin = '"GETALLDISKONECTIONSPPR"."ISPPR"'
      FixedChar = True
      Size = 1
    end
    object dset_mainID_PPR: TIntegerField
      FieldName = 'ID_PPR'
      Origin = '"GETALLDISKONECTIONSPPR"."ID_PPR"'
    end
    object dset_mainID2: TIntegerField
      FieldName = 'ID2'
      Origin = '"GETALLDISKONECTIONSPPR"."ID2"'
    end
    object dset_mainISPRIVATESEC: TSmallintField
      FieldName = 'ISPRIVATESEC'
      Origin = '"GETALLDISKONECTIONSPPR"."ISPRIVATESEC"'
    end
    object dset_mainHOUSE1: TIBStringField
      FieldName = 'HOUSE1'
      Origin = '"GETALLDISKONECTIONSPPR"."HOUSE1"'
      FixedChar = True
      Size = 6
    end
    object dset_mainG_ATG: TIntegerField
      FieldName = 'G_ATG'
      Origin = '"GETALLDISKONECTIONSPPR"."G_ATG"'
    end
    object dset_mainGOR_VOD: TSmallintField
      FieldName = 'GOR_VOD'
      Origin = '"GETALLDISKONECTIONSPPR"."GOR_VOD"'
    end
    object dset_mainIsPrivateCalc: TStringField
      FieldKind = fkCalculated
      FieldName = 'IsPrivateCalc'
      Size = 4
      Calculated = True
    end
    object dset_mainGOR_VODCalc: TStringField
      FieldKind = fkCalculated
      FieldName = 'GOR_VODCalc'
      Size = 4
      Calculated = True
    end
    object dset_mainlook_discon_type: TStringField
      FieldKind = fkLookup
      FieldName = 'look_discon_type'
      LookupDataSet = dset_discon_type
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_ID_DISKON_TYPE'
      Lookup = True
    end
    object dset_mainWEAK_PRESS: TSmallintField
      FieldName = 'WEAK_PRESS'
      Origin = '"GETALLDISKONECTIONSPPR"."WEAK_PRESS"'
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
  object dset_house_type: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      
        'select ID, NAME, ID_1562 from S_HOUSE_TYPE where ACTIVITY is nul' +
        'l')
    Left = 672
    Top = 77
    object dset_house_typeID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_HOUSE_TYPE"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_house_typeNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_HOUSE_TYPE"."NAME"'
      Size = 30
    end
    object dset_house_typeID_1562: TIntegerField
      FieldName = 'ID_1562'
      Origin = '"S_HOUSE_TYPE"."ID_1562"'
      Required = True
    end
  end
  object ds_house_type: TDataSource
    DataSet = dset_house_type
    Left = 720
    Top = 213
  end
  object dset_addfields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_add
    DeleteSQL.Strings = (
      'delete from DISKON_ADDINFO_PPR'
      'where'
      'id=:id')
    InsertSQL.Strings = (
      'insert into DISKON_ADDINFO_PPR  ('
      'fk_Diskon_ADDINFO_order,'
      'fk_DIskon_ADDINFO_Discon,'
      'House1,'
      'id_side,'
      'fk_ID_House_Type ,'
      'FK_DISKON_TYPE,'
      'col_house,'
      'col_pod '
      ')'
      'values'
      '('
      ':fk_Diskon_ADDINFO_order,'
      ':fk_DIskon_ADDINFO_Discon,'
      ':House1,'
      ':id_side,'
      ':fk_ID_House_Type ,'
      ':FK_DISKON_TYPE,'
      ':col_house,'
      ':col_pod '
      ''
      ''
      ')')
    SelectSQL.Strings = (
      
        'select FK_DISKON_ADDINFO_DISCON, HOUSE1, HOUSE2, ID_SIDE, FK_DIS' +
        'KON_ADDINFO_WORK, WORKS,'
      'fk_ID_House_Type,FK_DISKON_TYPE,col_house,col_pod '
      ' from DISKON_ADDINFO_PPR'
      ' where FK_DISKON_ADDINFO_ORDER=:porderid')
    ModifySQL.Strings = (
      'update DISKON_ADDINFO_PPR  set'
      'House1=:House1,'
      'House2=:House2,'
      'id_side=:id_side,'
      'works=:works,'
      'fk_ID_House_Type =:fk_ID_House_Type ,'
      'FK_DISKON_TYPE=:FK_DISKON_TYPE,'
      'col_house=:col_house,'
      'col_pod=:col_pod '
      'where'
      'id=:id')
    Left = 720
    Top = 21
    object dset_addfieldsFK_DISKON_ADDINFO_DISCON: TIntegerField
      FieldName = 'FK_DISKON_ADDINFO_DISCON'
      Origin = '"DISKON_ADDINFO_PPR"."FK_DISKON_ADDINFO_DISCON"'
      Required = True
    end
    object dset_addfieldsHOUSE1: TIBStringField
      FieldName = 'HOUSE1'
      Origin = '"DISKON_ADDINFO_PPR"."HOUSE1"'
      Size = 64
    end
    object dset_addfieldsHOUSE2: TIBStringField
      FieldName = 'HOUSE2'
      Origin = '"DISKON_ADDINFO_PPR"."HOUSE2"'
      Size = 6
    end
    object dset_addfieldsID_SIDE: TIntegerField
      FieldName = 'ID_SIDE'
      Origin = '"DISKON_ADDINFO_PPR"."ID_SIDE"'
      Required = True
    end
    object dset_addfieldsFK_DISKON_ADDINFO_WORK: TIntegerField
      FieldName = 'FK_DISKON_ADDINFO_WORK'
      Origin = '"DISKON_ADDINFO_PPR"."FK_DISKON_ADDINFO_WORK"'
    end
    object dset_addfieldsWORKS: TIBStringField
      FieldName = 'WORKS'
      Origin = '"DISKON_ADDINFO_PPR"."WORKS"'
      Size = 30
    end
    object dset_addfieldsFK_ID_HOUSE_TYPE: TIntegerField
      FieldName = 'FK_ID_HOUSE_TYPE'
      Origin = '"DISKON_ADDINFO_PPR"."FK_ID_HOUSE_TYPE"'
    end
    object dset_addfieldsFK_DISKON_TYPE: TSmallintField
      FieldName = 'FK_DISKON_TYPE'
      Origin = '"DISKON_ADDINFO_PPR"."FK_DISKON_TYPE"'
    end
    object dset_addfieldsCOL_HOUSE: TIntegerField
      FieldName = 'COL_HOUSE'
      Origin = '"DISKON_ADDINFO_PPR"."COL_HOUSE"'
    end
    object dset_addfieldsCOL_POD: TIntegerField
      FieldName = 'COL_POD'
      Origin = '"DISKON_ADDINFO_PPR"."COL_POD"'
    end
  end
  object ds_AddFields: TDataSource
    DataSet = dset_addfields
    Left = 544
    Top = 21
  end
  object tran_add: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 504
    Top = 29
  end
  object dset_discon_type: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id,name, id_1562 from s_discontypeppr')
    Left = 464
    Top = 144
  end
  object ds_discon_type: TDataSource
    DataSet = dset_discon_type
    Left = 432
    Top = 144
  end
end
