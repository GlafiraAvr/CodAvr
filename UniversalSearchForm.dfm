object frm_UniversalSearch: Tfrm_UniversalSearch
  Left = 359
  Top = 250
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1087#1086#1080#1089#1082' '#1085#1072#1088#1103#1076#1086#1074
  ClientHeight = 408
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 1
    Width = 43
    Height = 26
    Alignment = taCenter
    Caption = #8470' '#13#10#1085#1072#1088#1103#1076#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_SONum: TLabel
    Left = 120
    Top = 0
    Width = 76
    Height = 26
    Alignment = taCenter
    Caption = #1053#1086#1084#1077#1088' '#13#10#1079#1072#1103#1074#1082#1080'(0-62)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_DateComing2: TLabel
    Left = 231
    Top = 38
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
  object lbl_DateComing1: TLabel
    Left = 5
    Top = 32
    Width = 72
    Height = 26
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#13#10#1079#1072' '#1087#1077#1088#1080#1086#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 186
    Top = 189
    Width = 60
    Height = 13
    Caption = #1055#1083#1072#1090#1085#1099#1081'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 11
    Top = 189
    Width = 47
    Height = 13
    Caption = #1053#1072#1088#1103#1076#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 368
    Top = 189
    Width = 81
    Height = 13
    Caption = #1055#1077#1088#1077#1082#1088#1099#1090#1080#1077'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_ecavpermis: TLabel
    Left = 8
    Top = 216
    Width = 153
    Height = 13
    Caption = #1056#1072#1079#1088#1077#1096#1077#1085#1080#1077' '#1085#1072' '#1088#1072#1079#1088#1099#1090#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object tp_Coming2: TMaskEdit
    Left = 337
    Top = 35
    Width = 46
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 5
    Text = '  :  '
    OnClick = dp_Coming2Change
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object tp_Coming1: TMaskEdit
    Left = 167
    Top = 35
    Width = 47
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
    OnChange = dp_Coming1Change
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object sp_NumSO: TSpinEdit
    Left = 200
    Top = 3
    Width = 106
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object sp_NumOrder: TSpinEdit
    Left = 50
    Top = 3
    Width = 62
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object GroupBox2: TGroupBox
    Left = 5
    Top = 240
    Width = 572
    Height = 109
    TabOrder = 17
    object Label11: TLabel
      Left = 8
      Top = 75
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103#13#10#1088#1072#1073#1086#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 281
      Top = 81
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
    object btn_TubeDiameter: TBitBtn
      Left = 10
      Top = 47
      Width = 153
      Height = 25
      Caption = #1044#1080#1072#1084#1077#1090#1088' '#1090#1088#1091#1073#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = btn_TubeDiameterClick
    end
    object btn_TubeMaterial: TBitBtn
      Left = 185
      Top = 47
      Width = 193
      Height = 25
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083' '#1090#1088#1091#1073#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = btn_TubeMaterialClick
    end
    object btn_excworktype: TBitBtn
      Left = 386
      Top = 47
      Width = 177
      Height = 25
      Caption = #1047#1072#1089#1099#1087#1072#1085#1086'('#1088#1072#1089#1082#1086#1087#1072#1085#1086')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = btn_excworktypeClick
    end
    object btn_Brigadiers: TButton
      Left = 184
      Top = 12
      Width = 193
      Height = 33
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088#1099', '#1074#1099#1077#1079#1078#1072#1074#1096#1080#1077' '#1085#1072' '#1084#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      WordWrap = True
      OnClick = btn_BrigadiersClick
    end
    object btn_DamageType: TBitBtn
      Left = 384
      Top = 12
      Width = 177
      Height = 25
      Caption = #1042#1080#1076' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btn_DamageTypeClick
    end
    object btn_OfficialsClosed: TBitBtn
      Left = 8
      Top = 12
      Width = 153
      Height = 25
      Caption = #1044#1080#1087#1077#1090#1095#1077#1088' '#1079#1072#1082#1088'. '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btn_OfficialsClosedClick
    end
    object dp_Closed1: TDateEdit
      Left = 112
      Top = 78
      Width = 97
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_Closed2: TDateEdit
      Left = 302
      Top = 77
      Width = 97
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object tp_Closed1: TMaskEdit
      Left = 209
      Top = 78
      Width = 47
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object tp_Closed2: TMaskEdit
      Left = 399
      Top = 77
      Width = 46
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object chk_IsCalcLeak: TCheckBox
      Left = 474
      Top = 79
      Width = 81
      Height = 17
      Caption = #1056#1072#1089#1095#1077#1090' Q'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 96
    Width = 573
    Height = 49
    TabOrder = 9
    object lbl_po: TLabel
      Left = 480
      Top = 22
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
    object Label4: TLabel
      Left = 8
      Top = 22
      Width = 38
      Height = 13
      Caption = #1059#1083#1080#1094#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_vid: TLabel
      Left = 384
      Top = 22
      Width = 8
      Height = 13
      Caption = #1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_withstreet: TLabel
      Left = 384
      Top = 24
      Width = 12
      Height = 13
      Caption = #1089' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object dbl_HouseType: TRxDBLookupCombo
      Left = 247
      Top = 16
      Width = 121
      Height = 21
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_HouseType
      TabOrder = 1
      OnChange = dbl_HouseTypeChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Street2: TRxDBLookupCombo
      Left = 402
      Top = 16
      Width = 169
      Height = 21
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_Street2
      TabOrder = 2
      Visible = False
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Street: TRxDBLookupCombo
      Left = 55
      Top = 17
      Width = 185
      Height = 21
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_Street
      TabOrder = 0
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_HouseNum1: TEdit
      Left = 400
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 3
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_HouseNum2: TEdit
      Left = 504
      Top = 16
      Width = 57
      Height = 21
      TabOrder = 4
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
  end
  object dp_Coming2: TDateEdit
    Left = 249
    Top = 35
    Width = 89
    Height = 21
    NumGlyphs = 2
    TabOrder = 4
    OnChange = dp_Coming2Change
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object cb_OrderType: TComboBox
    Left = 64
    Top = 185
    Width = 105
    Height = 21
    ItemHeight = 13
    TabOrder = 14
    Text = #1042#1057#1045
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
    Items.Strings = (
      #1042#1057#1045
      #1053#1045#1047#1040#1050#1056#1067#1058#1067#1045
      #1047#1040#1050#1056#1067#1058#1067#1045
      #1054#1058#1050#1051#1070#1063#1045#1053#1048#1071)
  end
  object cb_IsPayed: TComboBox
    Left = 256
    Top = 185
    Width = 97
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 15
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
    Items.Strings = (
      ''
      #1053#1045#1058
      #1044#1040)
  end
  object cb_AreClosures: TComboBox
    Left = 448
    Top = 185
    Width = 97
    Height = 21
    Enabled = False
    ItemHeight = 13
    TabOrder = 16
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
    Items.Strings = (
      ''
      #1053#1045#1058
      #1044#1040)
  end
  object btnNaControle: TBitBtn
    Left = 312
    Top = 151
    Width = 129
    Height = 25
    Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1082#1086#1085#1090#1088#1086#1083#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = btnNaControleClick
  end
  object btn_ok: TBitBtn
    Left = 8
    Top = 360
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
    OnClick = btn_okClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
      300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
      330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
      333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
      339977FF777777773377000BFB03333333337773FF733333333F333000333333
      3300333777333333337733333333333333003333333333333377333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object btn_DamagePlace: TBitBtn
    Left = 176
    Top = 151
    Width = 129
    Height = 25
    Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = btn_DamagePlaceClick
  end
  object btn_DamageLocality: TBitBtn
    Left = 8
    Top = 151
    Width = 161
    Height = 25
    Caption = #1052#1077#1089#1090#1085#1086#1089#1090#1100' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = btn_DamageLocalityClick
  end
  object btn_cancel: TBitBtn
    Left = 502
    Top = 366
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    OnClick = btn_cancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object btn_BrigDep1: TBitBtn
    Left = 448
    Top = 151
    Width = 129
    Height = 25
    Caption = #1041#1088#1080#1075#1072#1076#1080#1088
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = btn_BrigDep1Click
  end
  object btn_MessageType: TBitBtn
    Left = 383
    Top = 64
    Width = 185
    Height = 25
    Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btn_MessageTypeClick
  end
  object btn_Regions: TBitBtn
    Left = 229
    Top = 64
    Width = 144
    Height = 25
    Caption = #1056#1072#1081#1086#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btn_RegionsClick
  end
  object btn_Officials: TBitBtn
    Left = 11
    Top = 64
    Width = 200
    Height = 25
    Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088' '#1087#1088#1080#1085#1103#1074#1096#1080#1081' '#1079#1072#1103#1074#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_OfficialsClick
  end
  object dp_Coming1: TDateEdit
    Left = 78
    Top = 35
    Width = 89
    Height = 21
    NumGlyphs = 2
    TabOrder = 2
    OnChange = dp_Coming1Change
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object me_Exorder: TMaskEdit
    Left = 169
    Top = 215
    Width = 121
    Height = 21
    TabOrder = 20
    Text = '0'
  end
  object Tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 128
    Top = 227
  end
  object dset_Street: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name'
      'from s_streets s'
      'where s.activity is null'
      'order by name')
    Left = 200
    Top = 235
  end
  object dset_Street2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name'
      'from s_streets s'
      'where s.activity is null'
      'order by name')
    Left = 296
    Top = 235
  end
  object dset_Housetype: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name '
      'from s_housetype'
      'where activity is null '
      'order by id')
    Left = 376
    Top = 235
  end
  object ds_Street: TDataSource
    DataSet = dset_Street
    Left = 232
    Top = 235
  end
  object ds_Street2: TDataSource
    DataSet = dset_Street2
    Left = 264
    Top = 235
  end
  object ds_HouseType: TDataSource
    DataSet = dset_Housetype
    Left = 344
    Top = 251
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 280
    Top = 119
  end
  object dset_street_vds: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = IBTransaction1
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name'
      'from s_streets s'
      'where s.activity is null'
      'order by name')
    Left = 240
    Top = 119
  end
  object DataSource1: TDataSource
    DataSet = dset_street_vds
    Left = 312
    Top = 119
  end
end
