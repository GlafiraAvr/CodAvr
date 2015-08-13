inherited frm_Order: Tfrm_Order
  Left = 475
  Top = 285
  BorderStyle = bsDialog
  Caption = #1044#1072#1085#1085#1099#1077' '#1085#1072#1088#1103#1076#1072
  ClientHeight = 468
  ClientWidth = 612
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label27: TLabel
    Left = 632
    Top = 108
    Width = 183
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label11: TLabel
    Left = -44
    Top = 120
    Width = 42
    Height = 32
    Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 257
    Top = 131
    Width = 42
    Height = 26
    Caption = #1052#1077#1089#1090#1085'. '#1087#1086#1074#1088'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object mem_AdditionalInfo: TMemo
    Left = 632
    Top = 124
    Width = 467
    Height = 20
    TabStop = False
    TabOrder = 8
    Visible = False
    OnChange = TopCtrlChange
    OnEnter = EntryEnter
    OnExit = EntryExit
  end
  object btn_NewOrder: TBitBtn
    Left = 350
    Top = 400
    Width = 108
    Height = 25
    Caption = #1053#1086#1074#1099#1081' '#1085#1072#1088#1103#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btn_NewOrderClick
    OnKeyDown = FormKeyDown
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
      333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
      0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
      0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
      33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
      B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
      3BB33773333773333773B333333B3333333B7333333733333337}
    NumGlyphs = 2
  end
  object btn_SaveOrderData: TBitBtn
    Left = 145
    Top = 400
    Width = 96
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btn_SaveOrderDataClick
    OnKeyDown = FormKeyDown
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object btn_CloseOrder: TBitBtn
    Left = 3
    Top = 400
    Width = 142
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1085#1072#1088#1103#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn_CloseOrderClick
    OnKeyDown = FormKeyDown
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object GroupBox2: TGroupBox
    Left = -2
    Top = 224
    Width = 611
    Height = 57
    TabOrder = 1
    object btn_WhatDone: TBitBtn
      Tag = 111
      Left = 7
      Top = 10
      Width = 106
      Height = 21
      Caption = #1063#1090#1086' '#1089#1076#1077#1083#1072#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_WhatDoneClick
      OnKeyDown = FormKeyDown
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
        00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
        00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
        F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
        FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
        0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
        0033333337FFFFFF773333333000000003333333377777777333}
      NumGlyphs = 2
    end
    object btn_Disconnected: TBitBtn
      Tag = 222
      Left = 219
      Top = 10
      Width = 102
      Height = 21
      Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_DisconnectedClick
      OnKeyDown = FormKeyDown
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5000555555555555577755555555555550B0555555555555F7F7555555555550
        00B05555555555577757555555555550B3B05555555555F7F557555555555000
        3B0555555555577755755555555500B3B0555555555577555755555555550B3B
        055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
        555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
        55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
        555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
        55555575FFFF7755555555570000755555555557777775555555}
      NumGlyphs = 2
    end
    object btn_Equipment: TBitBtn
      Tag = 333
      Left = 116
      Top = 10
      Width = 101
      Height = 21
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_EquipmentClick
      OnKeyDown = FormKeyDown
    end
    object btn_Bolts: TBitBtn
      Left = 325
      Top = 10
      Width = 92
      Height = 21
      Caption = #1047#1072#1076#1074#1080#1078#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_BoltsClick
      OnKeyDown = FormKeyDown
    end
    object btn_Deps: TBitBtn
      Left = 505
      Top = 10
      Width = 59
      Height = 21
      Caption = #1042#1099#1077#1079#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = False
      OnClick = btn_DepsClick
    end
    object btn_062: TBitBtn
      Left = 566
      Top = 10
      Width = 38
      Height = 21
      Caption = '15-62'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnClick = btn_062Click
    end
    object bt_Naled: TButton
      Left = 424
      Top = 11
      Width = 75
      Height = 20
      Caption = #1053#1072#1083#1077#1076#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      TabStop = False
      OnClick = bt_NaledClick
      OnKeyDown = FormKeyDown
    end
    object btn_flooding: TBitBtn
      Left = 8
      Top = 32
      Width = 105
      Height = 21
      Caption = #1047#1072#1083#1080#1074#1072#1077#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btn_floodingClick
    end
  end
  object gb_Bottom: TGroupBox
    Left = 0
    Top = 280
    Width = 609
    Height = 119
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label33: TLabel
      Left = 5
      Top = 58
      Width = 59
      Height = 26
      Alignment = taCenter
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#13#10#1090#1088#1091#1073#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label34: TLabel
      Left = 3
      Top = 40
      Width = 93
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088' '#1090#1088#1091#1073#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label35: TLabel
      Left = 3
      Top = 11
      Width = 101
      Height = 26
      Alignment = taCenter
      Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088' '#1079#1072#1082#1088'.'#13#10#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label37: TLabel
      Left = 411
      Top = 36
      Width = 34
      Height = 13
      Caption = #1043#1088#1091#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label38: TLabel
      Left = 200
      Top = 58
      Width = 80
      Height = 26
      Alignment = taCenter
      Caption = #1042#1080#1076' '#13#10#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label39: TLabel
      Left = 278
      Top = 87
      Width = 58
      Height = 26
      Alignment = taCenter
      Caption = #1042#1088#1077#1084#1103#13#10#1079#1072#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label40: TLabel
      Left = 48
      Top = 85
      Width = 58
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#13#10#1079#1072#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 420
      Top = 56
      Width = 186
      Height = 31
    end
    object lbl_Closure: TLabel
      Left = 420
      Top = 89
      Width = 167
      Height = 24
      Caption = #1053#1072#1088#1103#1076' '#1085#1077' '#1079#1072#1082#1088#1099#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_withoutorder: TLabel
      Left = 464
      Top = 16
      Width = 130
      Height = 13
      Caption = #1047#1072#1082#1088#1099#1090' '#1073#1077#1079' '#1088#1072#1089#1082#1086#1087#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object dbl_TubeDiameter: TRxDBLookupCombo
      Left = 103
      Top = 36
      Width = 98
      Height = 23
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_tubediameter
      ParentFont = False
      TabOrder = 2
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_TubeMaterial: TRxDBLookupCombo
      Left = 68
      Top = 61
      Width = 126
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_tubematerial
      TabOrder = 5
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_LastOfficial: TRxDBLookupCombo
      Left = 103
      Top = 11
      Width = 171
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_officialclose
      TabOrder = 1
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object chk_WithoutEquipment: TCheckBox
      Left = 291
      Top = 11
      Width = 137
      Height = 17
      TabStop = False
      Caption = #1041#1077#1079' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chk_WithoutEquipmentClick
      OnKeyDown = FormKeyDown
    end
    object dbl_DamageType: TRxDBLookupCombo
      Left = 285
      Top = 60
      Width = 129
      Height = 23
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_damagetype
      ParentFont = False
      TabOrder = 6
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_End: TDateEdit
      Left = 116
      Top = 90
      Width = 104
      Height = 21
      NumGlyphs = 2
      TabOrder = 7
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Soil: TRxDBLookupCombo
      Left = 452
      Top = 34
      Width = 153
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_soil
      TabOrder = 4
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_LastExcWorkType: TEdit
      Left = 495
      Top = 61
      Width = 106
      Height = 21
      Enabled = False
      TabOrder = 9
      Text = #1053#1077' '#1088#1072#1089#1082#1086#1087#1072#1085#1086
      OnKeyDown = FormKeyDown
    end
    object me_End: TMaskEdit
      Tag = 22222
      Left = 339
      Top = 91
      Width = 40
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 8
      Text = '  :  '
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object pnl_LocationDepth: TPanel
      Left = 256
      Top = 32
      Width = 147
      Height = 28
      TabOrder = 3
      object Label16: TLabel
        Left = 2
        Top = 0
        Width = 66
        Height = 26
        Alignment = taCenter
        Caption = #1043#1083#1091#1073#1080#1085#1072' '#1079#1072#1083#1086#1078#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object sp_LocationDepthMirror: TRxSpinEdit
        Left = 70
        Top = 3
        Width = 74
        Height = 21
        MaxValue = 100000.000000000000000000
        ValueType = vtFloat
        TabOrder = 0
        OnChange = sp_LocationDepthMirrorChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
  end
  object btn_Exit: TBitBtn
    Left = 535
    Top = 400
    Width = 72
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_ExitClick
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
  object gb_Top: TGroupBox
    Left = 0
    Top = -7
    Width = 609
    Height = 224
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 115
      Width = 57
      Height = 26
      Alignment = taCenter
      Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label5: TLabel
      Left = 265
      Top = 113
      Width = 28
      Height = 26
      Caption = #1040#1073#1086'-'#13#10#1085#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 9
      Top = 164
      Width = 38
      Height = 26
      Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label12: TLabel
      Left = 9
      Top = 139
      Width = 42
      Height = 26
      Caption = #1052#1077#1089#1090#1085'. '#1087#1086#1074#1088'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label14: TLabel
      Left = 333
      Top = 163
      Width = 34
      Height = 26
      Caption = #1055#1083#1072#1090'-'#13#10#1085#1099#1081'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 445
      Top = 162
      Width = 63
      Height = 26
      Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1082#1086#1085#1090#1088#1086#1083#1077'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label26: TLabel
      Left = 3
      Top = 200
      Width = 10
      Height = 13
      Alignment = taCenter
      Caption = 'Q'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label21: TLabel
      Left = 213
      Top = 13
      Width = 110
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      FocusControl = ed_Abonent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 4
      Top = 37
      Width = 183
      Height = 13
      Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088', '#1087#1088#1080#1085#1103#1074#1096#1080#1081' '#1079#1072#1103#1074#1082#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 376
      Top = 36
      Width = 37
      Height = 13
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 469
      Top = 6
      Width = 76
      Height = 26
      Alignment = taCenter
      Caption = #1042#1088#1077#1084#1103' '#13#10#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      FocusControl = ed_Abonent
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label30: TLabel
      Left = 9
      Top = 11
      Width = 90
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_OrderNum: TLabel
      Left = 100
      Top = 11
      Width = 96
      Height = 16
      Caption = 'lbl_OrderNum'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sb_DateComing: TRxSpinButton
      Left = 425
      Top = 10
      Width = 20
      Height = 20
      DownGlyph.Data = {
        56000000424D56000000000000003E0000002800000006000000060000000100
        010000000000180000000000000000000000020000000200000000000000FFFF
        FF00CC0000008400000000000000CC000000CC000000CC000000}
      UpGlyph.Data = {
        56000000424D56000000000000003E0000002800000006000000060000000100
        010000000000180000000000000000000000020000000200000000000000FFFF
        FF00CC000000CC000000CC0000000000000084000000CC000000}
      OnBottomClick = sb_DateComingBottomClick
      OnTopClick = sb_DateComingTopClick
    end
    object Label13: TLabel
      Left = 320
      Top = 139
      Width = 42
      Height = 26
      Caption = #1052#1077#1089#1090#1085'. '#1088#1103#1076#1086#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object ed_Abonent: TEdit
      Left = 296
      Top = 116
      Width = 118
      Height = 21
      MaxLength = 31
      TabOrder = 6
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object cb_IsPayed: TComboBox
      Tag = 11
      Left = 369
      Top = 167
      Width = 69
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 10
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
      Items.Strings = (
        #1053#1077#1090
        #1044#1072)
    end
    object sp_FlowSpeed: TRxSpinEdit
      Tag = 11111
      Left = 19
      Top = 196
      Width = 70
      Height = 21
      Decimal = 4
      MaxValue = 9999.000000000000000000
      ValueType = vtFloat
      TabOrder = 12
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_Start: TDateEdit
      Left = 328
      Top = 10
      Width = 97
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Damageplace: TRxDBLookupCombo
      Tag = 222
      Left = 49
      Top = 168
      Width = 171
      Height = 23
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_damageplace
      ParentFont = False
      TabOrder = 8
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_ControlOrgs: TRxDBLookupCombo
      Left = 512
      Top = 165
      Width = 89
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_contorlOrgs
      TabOrder = 11
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_DamageLocality: TRxDBLookupCombo
      Left = 55
      Top = 143
      Width = 250
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_damagelocality
      TabOrder = 7
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_MessageType: TRxDBLookupCombo
      Tag = 333
      Left = 68
      Top = 117
      Width = 184
      Height = 23
      DropDownCount = 8
      LookupField = 'name'
      LookupDisplay = 'name'
      LookupSource = ds_messagetype
      TabOrder = 5
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Regions: TRxDBLookupCombo
      Left = 418
      Top = 34
      Width = 185
      Height = 23
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_regions
      ParentFont = False
      TabOrder = 3
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_FirstOfficial: TRxDBLookupCombo
      Left = 187
      Top = 34
      Width = 163
      Height = 23
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_officialopen
      TabOrder = 2
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object gb_Adres: TGroupBox
      Left = 3
      Top = 55
      Width = 606
      Height = 57
      TabOrder = 4
      object Label2: TLabel
        Left = 5
        Top = 36
        Width = 68
        Height = 13
        Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 3
        Top = 12
        Width = 38
        Height = 13
        Caption = #1059#1083#1080#1094#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_Street2: TLabel
        Left = 395
        Top = 11
        Width = 12
        Height = 13
        Caption = #1089' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lbl_Housenum: TLabel
        Left = 393
        Top = 7
        Width = 31
        Height = 26
        Alignment = taCenter
        Caption = #8470' '#13#10#1076#1086#1084#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object dbl_Street2: TRxDBLookupCombo
        Tag = 11111
        Left = 408
        Top = 8
        Width = 201
        Height = 23
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_street2
        ParentFont = False
        TabOrder = 3
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_Street: TRxDBLookupCombo
        Left = 43
        Top = 9
        Width = 222
        Height = 23
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_street
        ParentFont = False
        TabOrder = 0
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object ed_Housenum: TEdit
        Tag = 11111
        Left = 432
        Top = 8
        Width = 153
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 20
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object ed_AddAdres: TEdit
        Left = 84
        Top = 33
        Width = 197
        Height = 21
        MaxLength = 31
        TabOrder = 4
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_HouseTypes: TRxDBLookupCombo
        Tag = 111
        Left = 267
        Top = 9
        Width = 126
        Height = 23
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_housetype
        ParentFont = False
        TabOrder = 1
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object cb_Pjatihatky: TCheckBox
        Left = 288
        Top = 34
        Width = 97
        Height = 17
        Caption = #1055#1103#1090#1080#1093#1072#1090#1082#1080
        TabOrder = 5
        OnClick = TopCtrlChange
        OnKeyDown = FormKeyDown
      end
    end
    object pnl_HoodCount: TPanel
      Left = 222
      Top = 164
      Width = 97
      Height = 28
      TabOrder = 9
      object Label10: TLabel
        Left = 52
        Top = 1
        Width = 38
        Height = 26
        Alignment = taCenter
        Caption = #1083#1102#1082#1086#1074#13#10#1096#1090'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cb_HoodCount: TComboBox
        Left = 5
        Top = 4
        Width = 44
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = '1'
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8')
      end
    end
    object me_Start: TMaskEdit
      Left = 551
      Top = 10
      Width = 40
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object pnl_LeakCalc: TPanel
      Left = 88
      Top = 192
      Width = 409
      Height = 26
      TabOrder = 13
      object Label1: TLabel
        Left = 10
        Top = 1
        Width = 66
        Height = 26
        Alignment = taCenter
        Caption = #1043#1083#1091#1073#1080#1085#1072' '#1079#1072#1083#1086#1078#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label31: TLabel
        Left = 127
        Top = -1
        Width = 60
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1074#1083#1077#1085#1080#1077#13#10'('#1072#1090#1084')'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 265
        Top = -2
        Width = 62
        Height = 26
        Alignment = taCenter
        Caption = #1055#1083#1086#1097#1072#1076#1100' '#13#10#1090#1077#1095#1080' ('#1089#1084'2)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object sp_Pressure: TRxSpinEdit
        Tag = 111
        Left = 193
        Top = 3
        Width = 73
        Height = 21
        MaxValue = 100000.000000000000000000
        ValueType = vtFloat
        TabOrder = 1
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object sp_Square: TRxSpinEdit
        Tag = 111
        Left = 330
        Top = 3
        Width = 71
        Height = 21
        MaxValue = 100000.000000000000000000
        ValueType = vtFloat
        TabOrder = 2
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object sp_LocationDepth: TRxSpinEdit
        Tag = 111
        Left = 76
        Top = 4
        Width = 51
        Height = 21
        MaxValue = 100000.000000000000000000
        ValueType = vtFloat
        TabOrder = 0
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
  end
  object btn_Excavations: TButton
    Left = 422
    Top = 342
    Width = 69
    Height = 19
    Caption = #1056#1072#1089#1082#1086#1087#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btn_ExcavationsClick
    OnKeyDown = FormKeyDown
  end
  object sb_ProcessStaus: TStatusBar
    Left = 0
    Top = 444
    Width = 612
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <>
    SimplePanel = True
    UseSystemFont = False
  end
  object btn_RestoreOpenState: TBitBtn
    Left = 287
    Top = 400
    Width = 62
    Height = 25
    Caption = #1042#1086#1079#1074#1088#1072#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = btn_RestoreOpenStateClick
  end
  object btn_Print: TBitBtn
    Left = 467
    Top = 400
    Width = 75
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    TabStop = False
    OnClick = btn_PrintClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object btn_AvrOnMap: TBitBtn
    Left = 255
    Top = 376
    Width = 27
    Height = 25
    Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1082#1072#1088#1090#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    TabStop = False
    OnClick = btn_AvrOnMapClick
    Glyph.Data = {
      46050000424D4605000000000000360000002800000012000000120000000100
      20000000000010050000120B0000120B00000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E4DAEC139668A35C7527649B710930CF7A010DF27A01
      0DF2710930CF7527649B9668A35CE4DAEC13FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AA88BA45721E57A873215CF4905E9BF9C0A8
      CFFDECE6F2FFECE6F2FFC0A8CFFD905E9BF973215CF4721E57A8AA88BA45FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D73AB54701345D59A6FA8F9EFE9
      F4FFF6F3F9FFFCFBFDFFFFFFFFFFFFFFFFFFFCFBFDFFF6F3F9FFEFE9F4FF9A6F
      A8F9701345D59D73AB54FFFFFF00FFFFFF00FFFFFF00BDBDFF424242FFD6C7B2
      D5FEE8E0EFFF9667A2FF701346FF790111FF800000FF800000FF730626FF7426
      62FFC6B0D4FFF6F3F9FFC7B2D5FE701142D6AD8CBD42FFFFFF00EDEDFF125757
      FFA8A8A8FFFFFAFAFFFF6A686CFF3E7F06FF604000FF800000FF800000FF8000
      00FF800000FF585000FF39851AFFABA0BAFFFEFDFEFF9A6FA8FF721E57A8E5DC
      ED12AEAEFF515151FFF3F3F3FFFFA8A8FFFF0B2BDFFF00FF00FF28AF00FF8000
      00FF800000FF800000FF800000FF10DF00FF10DF00FF70103FFFC7B2D5FFEEE8
      F3FF711A51F39F77AE516A6AFF959595FFFFFFFFFFFF4949FFFF0000FFFF00CF
      30FF00FF00FF407F00FF407F00FF407F00FF388F00FF00FF00FF388F00FF7F00
      02FF7F3D7DFFFFFFFFFF8C5795FF772C6A953333FFCCCCCCFFFFFFFFFFFF1313
      FFFF0000FFFF00708FFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF
      00FF683000FF800001FF700F3EFFFFFFFFFFBDA3CCFF710A33CC0A0AFFF5F5F5
      FFFFFFFFFFFF0000FFFF0000FFFF0020DFFF00FF00FF009F60FF800000FF8000
      00FF10DF00FF18CF00FF800000FF800000FF780112FFFFFFFFFFF0EBF5FF7B00
      0AF50A0AFFF5F5F5FFFFFFFFFFFF0404FFFF0000FFFF0000FFFF00AF50FF00EF
      10FF0000FFFF683000FF00FF00FF487000FF800000FF800000FF720627FFFFFF
      FFFFF0EBF5FF7B000AF53333FFCCCCCCFFFFFFFFFFFF3232FFFF0000FFFF0000
      FFFF00609FFF00FF00FF0050AFFF008F70FF00FF00FF702000FF800000FF7E00
      05FF742460FFFFFFFFFFBDA3CCFF710A33CC6A6AFF959595FFFFFFFFFFFF7575
      FFFF0101FFFF0000FFFF0010EFFF00FF00FF009F60FF00DF20FF00CF30FF8000
      00FF800000FF770216FF9C71AAFFFFFFFFFF8C5795FF772C6A95AEAEFF515151
      FFF3F3F3FFFFE2E2FFFF4646FFFF0101FFFF0000FFFF00AF50FF00EF10FF00FF
      00FF00609FFF0000FFFF7B010CFF884F8EFFF9F7FBFFEEE8F3FF711A51F39F77
      AE51EDEDFF125757FFA8A8A8FFFFFEFEFFFFD4D4FFFF5151FFFF1010FFFF0151
      AFFF00BF40FF00BF40FF0717EFFF1919FFFF9090FFFFEFE9F4FFFEFDFEFF9A6F
      A8FF721E57A8E5DCED12FFFFFF00BDBDFF424242FFD6D5D5FFFEF8F8FFFFDBDB
      FFFF8383FFFF4141FFFF1212FFFF2323FFFF5B5BFFFFA5A5FFFFF8F8FFFFF9F9
      FFFFC7B2D5FE701142D6AD8CBD42FFFFFF00FFFFFF00FFFFFF00ABABFF544545
      FFD5A8A8FFF9F4F4FFFFF9F9FFFFFDFDFFFFFFFFFFFFFFFFFFFFFDFDFFFFF9F9
      FFFFF4F4FFFFA8A8FFF94545FFD59D73AB54FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00BABAFF455757FFA85C5CFFF49B9BFFF9CFCFFFFDF2F2FFFFF2F2
      FFFFCFCFFFFD9B9BFFF95C5CFFF45757FFA8BABAFF45FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECECFF13A3A3FF5C6464FF9B3030
      FFCF0D0DFFF20D0DFFF23030FFCF6464FF9BA3A3FF5CECECFF13FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00}
  end
  object pnl_AomInfo: TPanel
    Left = 386
    Top = 448
    Width = 225
    Height = 19
    Anchors = [akRight, akBottom]
    BevelInner = bvLowered
    TabOrder = 13
    object Label7: TLabel
      Left = 3
      Top = 2
      Width = 126
      Height = 13
      Caption = #1058#1080#1087' '#1079#1085#1072#1082#1072' '#1072#1074#1088'. '#1085#1072' '#1082#1072#1088#1090#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl_AomInfo: TLabel
      Left = 131
      Top = 2
      Width = 55
      Height = 13
      Caption = 'lbl_AomInfo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object dbl_DamageLocality_2: TRxDBLookupCombo
    Left = 368
    Top = 133
    Width = 209
    Height = 23
    DropDownCount = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    LookupField = 'NAME'
    LookupDisplay = 'NAME'
    LookupSource = ds_DamageLocality_2
    ParentFont = False
    TabOrder = 14
    OnChange = TopCtrlChange
    OnEnter = EntryEnter
    OnExit = EntryExit
    OnKeyDown = FormKeyDown
  end
  object btn_images: TButton
    Left = 112
    Top = 256
    Width = 105
    Height = 21
    Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    Visible = False
    OnClick = btn_imagesClick
  end
  object ds_tubediameter: TDataSource
    DataSet = dm_Order.mt_tubediametr
    Left = 688
    Top = 344
  end
  object ds_tubematerial: TDataSource
    DataSet = dm_Order.md_tubemater
    Left = 680
    Top = 312
  end
  object ds_contorlOrgs: TDataSource
    DataSet = dm_Order.mt_Organisation
    Left = 680
    Top = 288
  end
  object ds_damageplace: TDataSource
    DataSet = dm_Order.mt_DamagePlace
    Left = 680
    Top = 264
  end
  object ds_damagelocality: TDataSource
    DataSet = dm_Order.mt_DamageLocality
    Left = 680
    Top = 240
  end
  object ds_messagetype: TDataSource
    DataSet = dm_Order.mt_messagetype
    Left = 680
    Top = 216
  end
  object ds_street2: TDataSource
    DataSet = dm_Order.mt_street2
    Left = 680
    Top = 184
  end
  object ds_housetype: TDataSource
    DataSet = dm_Order.mt_HouseType
    Left = 680
    Top = 160
  end
  object ds_street: TDataSource
    DataSet = dm_Order.mt_street
    Left = 680
    Top = 128
  end
  object ds_regions: TDataSource
    DataSet = dm_Order.mt_regions
    Left = 680
    Top = 96
  end
  object ds_officialopen: TDataSource
    DataSet = dm_Order.mt_officials_open
    Left = 680
    Top = 72
  end
  object ds_officialclose: TDataSource
    DataSet = dm_Order.mt_officials_close
    Left = 680
    Top = 375
  end
  object ds_soil: TDataSource
    DataSet = dm_Order.mt_soil
    Left = 680
    Top = 400
  end
  object ds_damagetype: TDataSource
    DataSet = dm_Order.mt_Damagetype
    Left = 680
    Top = 424
  end
  object Tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 720
    Top = 160
  end
  object sql_Order: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = Tr_ModifyData
    Left = 56
    Top = 372
  end
  object dset_TopOrderFields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_SelectData
    SelectSQL.Strings = (
      
        'select ordernumber, Datecoming, FK_ORDERS_OFFICIALS,FK_ORDERS_ME' +
        'SSAGETYPES, '
      
        '          ABONENT, FK_ORDERS_DAMAGEPLACE, FK_ORDERS_DAMAGELOCALI' +
        'TY,'
      
        '          IsPayed, LOCATIONDEPTH, PRESSURE, SQUARE, FLOWSPEED, F' +
        'K_ORDERS_REGIONS, FK_ORDERS_STREETS,'
      '          FK_ORDERS_HOUSETYPES,  HOUSENUM,ADDITIONALADDRESS, '
      
        '          FK_ORDERS_ORGANISATIONS, ADDITIONALINFO, Disconnection' +
        's, HoodCount,  ShiftNumber, IS_PJATIHATKY,'
      'FK_ORDERS_ADD_DAMAGELOCALITY'
      ''
      '          from orders WHERE ID = :pID')
    Left = 88
    Top = 388
  end
  object dset_BottomOrderFields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_SelectData
    SelectSQL.Strings = (
      'select DateClosed, FK_ORDERS_OFFICIALCLOSED, WithoutEquipment,'
      '          FK_ORDERS_TUBEMATERIAL, FK_ORDERS_DIAMETERS,'
      
        '          FK_ORDERS_DAMAGETYPE,FK_ORDERS_SOIL,          fk_order' +
        's_Off_WithoutExcav'
      ''
      '          from orders WHERE ID = :pID')
    Left = 120
    Top = 388
  end
  object Tr_ModifyData: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 288
    Top = 388
  end
  object Tr_SelectData: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 336
    Top = 388
  end
  object pm_Print: TPopupMenu
    Left = 408
    Top = 302
    object mi_PrintOrder: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1100' '#1085#1072#1088#1103#1076#1072
      OnClick = mi_PrintOrderClick
    end
    object mi_PrintAom: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1100' '#1072#1074#1072#1088#1080#1080' '#1085#1072' '#1082#1072#1088#1090#1077
      OnClick = mi_PrintAomClick
    end
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_tmp
    Left = 224
    Top = 400
  end
  object ds_DamageLocality_2: TDataSource
    DataSet = dm_Order.mt_DamageLocality_2
    Left = 680
    Top = 240
  end
end
