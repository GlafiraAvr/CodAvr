inherited frm_Order_vds: Tfrm_Order_vds
  Left = 335
  Top = 283
  BorderStyle = bsDialog
  Caption = #1044#1072#1085#1085#1099#1077' '#1085#1072#1088#1103#1076#1072
  ClientHeight = 522
  ClientWidth = 626
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label11: TLabel
    Left = -44
    Top = 120
    Width = 42
    Height = 32
    Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btn_NewOrder: TBitBtn
    Left = 345
    Top = 432
    Width = 108
    Height = 25
    Caption = #1053#1086#1074#1099#1081' '#1085#1072#1088#1103#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
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
    Top = 432
    Width = 96
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    Top = 432
    Width = 142
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1085#1072#1088#1103#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
  object gb_Bottom: TGroupBox
    Left = -3
    Top = 331
    Width = 826
    Height = 91
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label34: TLabel
      Left = 715
      Top = 18
      Width = 93
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088' '#1090#1088#1091#1073#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label35: TLabel
      Left = 3
      Top = 13
      Width = 101
      Height = 26
      Alignment = taCenter
      Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088' '#1079#1072#1082#1088'.'#13#10#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label39: TLabel
      Left = 234
      Top = 44
      Width = 109
      Height = 26
      Alignment = taCenter
      Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#13#10#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label40: TLabel
      Left = 8
      Top = 43
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103#13#10#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_TubeDiameter: TRxDBLookupCombo
      Left = 727
      Top = 38
      Width = 162
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_tubediameter
      ParentFont = False
      TabOrder = 1
      TabStop = False
      Visible = False
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_LastOfficial: TRxDBLookupCombo
      Left = 103
      Top = 15
      Width = 171
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_officialclose
      ParentFont = False
      TabOrder = 0
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_End: TDateEdit
      Left = 108
      Top = 46
      Width = 104
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object me_End: TMaskEdit
      Tag = 22222
      Left = 347
      Top = 46
      Width = 40
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Text = '  :  '
      OnChange = BottomCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object bt_cansel_inf: TButton
      Left = 296
      Top = 16
      Width = 73
      Height = 25
      Caption = #1048#1085#1092' '#1086#1090#1082#1072#1079#1072
      TabOrder = 4
      TabStop = False
      Visible = False
      OnClick = bt_cansel_infClick
    end
    object btn_RegionWork: TBitBtn
      Left = 382
      Top = 12
      Width = 113
      Height = 21
      Caption = #1056#1072#1073#1086#1090#1099' '#1088#1072#1081#1086#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btn_RegionWorkClick
    end
    object pnl_regionWork: TPanel
      Left = 416
      Top = 32
      Width = 201
      Height = 49
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 6
      Visible = False
      object lbl_work: TLabel
        Left = 4
        Top = 4
        Width = 9
        Height = 13
        Caption = #1056
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_User: TLabel
        Left = 20
        Top = 5
        Width = 47
        Height = 13
        Caption = 'lbl_User'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_endwork: TLabel
        Left = 171
        Top = 4
        Width = 9
        Height = 13
        Caption = #1042
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 17
        Height = 22
        Brush.Style = bsClear
        ParentShowHint = False
        Pen.Color = clGray
        Pen.Mode = pmMask
        ShowHint = False
        Visible = False
      end
      object Shape2: TShape
        Left = 16
        Top = 0
        Width = 121
        Height = 22
        Brush.Style = bsClear
        ParentShowHint = False
        Pen.Color = clGray
        ShowHint = False
        Visible = False
      end
      object Shape3: TShape
        Left = 136
        Top = 0
        Width = 13
        Height = 22
        Brush.Style = bsClear
        Pen.Color = clGray
        Visible = False
      end
      object Shape4: TShape
        Left = 148
        Top = 0
        Width = 53
        Height = 22
        Brush.Style = bsClear
        Pen.Color = clGray
        Visible = False
      end
      object Shape5: TShape
        Left = 0
        Top = 21
        Width = 98
        Height = 27
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object Shape6: TShape
        Left = 97
        Top = 21
        Width = 104
        Height = 27
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object me_startwork: TMaskEdit
        Left = 3
        Top = 24
        Width = 89
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        EditMask = '!99/99/00 !90:00;1;_'
        MaxLength = 14
        TabOrder = 0
        Text = '  .  .     :  '
      end
      object me_endwork: TMaskEdit
        Left = 109
        Top = 24
        Width = 89
        Height = 21
        BorderStyle = bsNone
        Color = clBtnFace
        EditMask = '!99/99/00 !90:00;1;_'
        MaxLength = 14
        TabOrder = 1
        Text = '  .  .     :  '
        Visible = False
      end
    end
  end
  object btn_Exit: TBitBtn
    Left = 528
    Top = 432
    Width = 76
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    Top = 28
    Width = 617
    Height = 261
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 178
      Width = 57
      Height = 26
      Alignment = taCenter
      Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label15: TLabel
      Left = 394
      Top = 180
      Width = 66
      Height = 26
      Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1082#1086#1085#1090#1088#1086#1083#1077'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label21: TLabel
      Left = 8
      Top = 10
      Width = 110
      Height = 13
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 4
      Top = 44
      Width = 183
      Height = 13
      Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088', '#1087#1088#1080#1085#1103#1074#1096#1080#1081' '#1079#1072#1103#1074#1082#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 378
      Top = 44
      Width = 37
      Height = 13
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 263
      Top = 12
      Width = 118
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 6
      Top = 74
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
    object lbl_Housenum: TLabel
      Left = 223
      Top = 68
      Width = 44
      Height = 26
      Alignment = taCenter
      Caption = #1053#1086#1084#1077#1088' '#13#10#1076#1086#1084#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 321
      Top = 68
      Width = 27
      Height = 26
      Alignment = taCenter
      Caption = #1050#1086#1088'-'#13#10#1087#1091#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 479
      Top = 74
      Width = 31
      Height = 13
      Caption = #1069#1090#1072#1078
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 555
      Top = 75
      Width = 20
      Height = 13
      Caption = #1050#1074'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 398
      Top = 69
      Width = 36
      Height = 26
      Alignment = taCenter
      Caption = #1055#1086#1076#1098'-'#13#10#1077#1079#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label27: TLabel
      Left = 11
      Top = 220
      Width = 105
      Height = 26
      Alignment = taCenter
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 105
      Width = 84
      Height = 13
      Caption = #1050#1086#1076' '#1087#1086#1076#1098#1077#1079#1076#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dp_Start: TDateEdit
      Left = 121
      Top = 9
      Width = 97
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnChange = dp_StartChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_ControlOrgs: TRxDBLookupCombo
      Left = 461
      Top = 183
      Width = 140
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_contorlOrgs
      ParentFont = False
      TabOrder = 13
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_MessageType: TRxDBLookupCombo
      Tag = 333
      Left = 68
      Top = 182
      Width = 309
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'MESSAGENAME'
      LookupDisplay = 'MESSAGENAME'
      LookupSource = ds_messagetype
      ParentFont = False
      TabOrder = 12
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Regions: TRxDBLookupCombo
      Tag = 111
      Left = 418
      Top = 41
      Width = 185
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
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
      Left = 192
      Top = 41
      Width = 163
      Height = 21
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_officialopen
      ParentFont = False
      TabOrder = 2
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object me_Start: TMaskEdit
      Left = 385
      Top = 10
      Width = 40
      Height = 21
      EditMask = '!90:00;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
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
    object dbl_Street: TRxDBLookupCombo
      Tag = 123
      Left = 45
      Top = 72
      Width = 173
      Height = 20
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_street
      ParentFont = False
      TabOrder = 4
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_Housenum: TEdit
      Tag = 123
      Left = 264
      Top = 71
      Width = 53
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      TabOrder = 5
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object gb_Applicant: TGroupBox
      Left = 13
      Top = 127
      Width = 595
      Height = 47
      Caption = #1047#1072#1103#1074#1080#1090#1077#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      object Label3: TLabel
        Left = 151
        Top = 21
        Width = 57
        Height = 13
        Caption = #1060#1072#1084#1080#1083#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 431
        Top = 19
        Width = 53
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbl_Applicant: TRxDBLookupCombo
        Left = 7
        Top = 18
        Width = 130
        Height = 21
        DropDownCount = 8
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_Applicant
        TabOrder = 0
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object ed_ApplicantFio: TEdit
        Left = 214
        Top = 16
        Width = 179
        Height = 21
        MaxLength = 20
        TabOrder = 1
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object ed_ApplicantPhone: TEdit
        Left = 488
        Top = 16
        Width = 81
        Height = 21
        MaxLength = 15
        TabOrder = 2
        OnChange = TopCtrlChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
    object ed_HousingNum: TEdit
      Tag = 123
      Left = 350
      Top = 71
      Width = 39
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 6
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_FloorNum: TEdit
      Tag = 123
      Left = 512
      Top = 72
      Width = 37
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 8
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_ApartmentNum: TEdit
      Tag = 123
      Left = 575
      Top = 72
      Width = 39
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 9
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_PorchNum: TEdit
      Tag = 123
      Left = 435
      Top = 72
      Width = 39
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 7
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object mem_AdditionalInfo: TMemo
      Left = 120
      Top = 212
      Width = 481
      Height = 41
      MaxLength = 950
      ScrollBars = ssVertical
      TabOrder = 14
      WantReturns = False
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_PorchKod: TEdit
      Left = 96
      Top = 102
      Width = 161
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 10
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
  end
  object sb_ProcessStaus: TStatusBar
    Left = 0
    Top = 498
    Width = 626
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <>
    SimplePanel = True
    UseSystemFont = False
  end
  object btn_RestoreOpenState: TBitBtn
    Left = 274
    Top = 432
    Width = 71
    Height = 25
    Caption = #1042#1086#1079#1074#1088#1072#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btn_RestoreOpenStateClick
  end
  object btn_Print: TBitBtn
    Left = 453
    Top = 432
    Width = 75
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 626
    Height = 30
    Align = alTop
    TabOrder = 10
    object Label30: TLabel
      Left = 5
      Top = 5
      Width = 128
      Height = 20
      Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Closure: TLabel
      Left = 450
      Top = 1
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
    object st_OrderNum: TStaticText
      Left = 134
      Top = 5
      Width = 124
      Height = 22
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'st_OrderNum'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object st_District: TStaticText
      Left = 259
      Top = 5
      Width = 62
      Height = 22
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'st_District'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object st_from: TStaticText
      Left = 329
      Top = 4
      Width = 65
      Height = 24
      BorderStyle = sbsSunken
      Caption = 'st_from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object gb_btns: TGroupBox
    Left = -1
    Top = 282
    Width = 618
    Height = 59
    TabOrder = 1
    object lbl_Brigadiers: TLabel
      Left = 7
      Top = 19
      Width = 115
      Height = 26
      Alignment = taCenter
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#13#10#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_DamageType: TLabel
      Left = 281
      Top = 17
      Width = 80
      Height = 26
      Alignment = taCenter
      Caption = #1042#1080#1076' '#13#10#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btn_Disconnected: TBitBtn
      Tag = 222
      Left = 496
      Top = 10
      Width = 113
      Height = 21
      Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
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
    object btn_Departures: TBitBtn
      Left = 496
      Top = 34
      Width = 65
      Height = 21
      Caption = #1042#1099#1077#1079#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_DeparturesClick
    end
    object dbl_Brigadiers: TRxDBLookupCombo
      Left = 131
      Top = 22
      Width = 142
      Height = 20
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_brigadiers
      ParentFont = False
      TabOrder = 0
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_DamageType: TRxDBLookupCombo
      Left = 368
      Top = 23
      Width = 121
      Height = 20
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_damagetype
      ParentFont = False
      TabOrder = 1
      OnChange = TopCtrlChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
  end
  object BitBtn1: TBitBtn
    Left = 561
    Top = 316
    Width = 49
    Height = 20
    Caption = '1562'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = BitBtn1Click
  end
  object ds_tubediameter: TDataSource
    DataSet = dm_order_vds.mt_tubediametr
    Left = 558
    Top = 232
  end
  object ds_contorlOrgs: TDataSource
    DataSet = dm_order_vds.mt_organisation
    Left = 558
    Top = 234
  end
  object ds_messagetype: TDataSource
    DataSet = dm_order_vds.mt_Message
    Left = 558
    Top = 202
  end
  object ds_street: TDataSource
    DataSet = dm_order_vds.mt_street
    Left = 552
    Top = 170
  end
  object ds_regions: TDataSource
    DataSet = dset_Regions
    Left = 550
    Top = 138
  end
  object ds_officialopen: TDataSource
    DataSet = dm_order_vds.mt_officials_open
    Left = 550
    Top = 114
  end
  object ds_officialclose: TDataSource
    DataSet = dm_order_vds.mt_official_closed
    Left = 558
    Top = 263
  end
  object ds_damagetype: TDataSource
    DataSet = dm_order_vds.mt_damagetype
    Left = 566
    Top = 288
  end
  object dset_Regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    RefreshSQL.Strings = (
      '   select dd.id_region id, sr.name, sr.activity'
      '   from db_districtregion dd'
      '    join s_regions sr on ( dd.id_region = sr.id )'
      '   where id_district= :id_district'
      '   order by name')
    SelectSQL.Strings = (
      '   select dd.id_region id, sr.name, sr.activity'
      '   from db_districtregion dd'
      '    join s_regions sr on ( dd.id_region = sr.id )'
      '   where id_district= :id_district'
      '   order by name'
      '')
    OnFilterRecord = VocFilterRecord
    Left = 526
    Top = 138
  end
  object Tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 606
    Top = 178
  end
  object sql_Order: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = Tr_ModifyData
    Left = 72
    Top = 453
  end
  object dset_TopOrderFields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_SelectData
    SelectSQL.Strings = (
      
        'select ordernumber, (select name from s_District_vds where o.FK_' +
        'ORDERS_DISTRICT=s_District_vds.id) District,'
      
        'Datecoming, FK_ORDERS_OFFICIALS, FK_ORDERS_MESSAGETYPES,FK_ORDER' +
        'S_REGIONS, FK_ORDERS_STREETS,'
      'FK_ORDERS_BRIGADIERS,'
      'HOUSENUM, HOUSINGNUM, PORCHNUM, FLOORNUM, APARTMENTNUM,'
      'PORCHKOD,'
      'FK_ORDERS_ORGANISATIONS, '
      'FK_ORDERS_APPLICANT,  APPLICANTFIO, APPLICANTPHONE,'
      'ADDITIONALINFO,'
      'FK_ORDERS_DAMAGETYPE'
      'from orders_vds o'
      'where ID = :pID')
    Left = 112
    Top = 453
  end
  object dset_BottomOrderFields: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_SelectData
    SelectSQL.Strings = (
      'select DateClosed, FK_ORDERS_OFFICIALCLOSED,FK_ORDERS_DIAMETERS'
      'from orders_vds '
      'WHERE ID = :pID')
    Left = 144
    Top = 453
  end
  object Tr_ModifyData: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 256
    Top = 461
  end
  object Tr_SelectData: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 296
    Top = 453
  end
  object ds_Applicant: TDataSource
    DataSet = dm_order_vds.mt_Applicant_vds
    Left = 556
    Top = 82
  end
  object ds_brigadiers: TDataSource
    DataSet = dm_order_vds.mt_brigadiers
    Left = 556
    Top = 50
  end
  object dset_cansel: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_SelectData
    SelectSQL.Strings = (
      
        'select *  from numsorders_vds where  cansel_reason is not null a' +
        'nd id_order=:id')
    Left = 343
    Top = 342
  end
end
