inherited frm_UniSearchResult: Tfrm_UniSearchResult
  Left = 238
  Top = 311
  Width = 651
  Height = 356
  Caption = 'frm_UniSearchResult'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_LeakInfo: TPanel
    Left = 0
    Top = 241
    Width = 643
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 182
      Height = 13
      Caption = #1059#1090#1077#1095#1082#1072' '#1087#1086' '#1074#1089#1077#1084' '#1088#1072#1081#1086#1085#1072#1084' ('#1084'3):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_SumLeak: TLabel
      Left = 193
      Top = 5
      Width = 73
      Height = 13
      Caption = 'lbl_SumLeak'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_RegionLeak: TLabel
      Left = 148
      Top = 26
      Width = 89
      Height = 13
      Caption = 'lbl_RegionLeak'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 25
      Width = 138
      Height = 13
      Caption = #1059#1090#1077#1095#1082#1072' '#1087#1086' '#1088#1072#1081#1086#1085#1091' ('#1084'3):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnl_btns: TPanel
    Left = 0
    Top = 286
    Width = 643
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    DesignSize = (
      643
      41)
    object btn_Order: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #1053#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
    end
    object chk_IsPrintAddInfo: TCheckBox
      Left = 162
      Top = 13
      Width = 143
      Height = 17
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1076#1086#1087'. '#1080#1085#1092'.?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object btn_Print: TBitBtn
      Left = 312
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
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
    object btn_Exit: TBitBtn
      Left = 561
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
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
    object btn_Map: TBitBtn
      Left = 390
      Top = 8
      Width = 97
      Height = 25
      Caption = #1056#1072#1079#1084#1077#1090#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
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
  end
  object pnl_RegInfo: TPanel
    Left = 0
    Top = 199
    Width = 643
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lbl_RegionName: TLabel
      Left = 52
      Top = 5
      Width = 93
      Height = 13
      Caption = 'lbl_RegionName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_DmgCount: TLabel
      Left = 230
      Top = 25
      Width = 79
      Height = 13
      Caption = 'lbl_DmgCount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 4
      Width = 41
      Height = 13
      Caption = #1056#1072#1081#1086#1085':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 7
      Top = 24
      Width = 220
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1081' '#1087#1086' '#1088#1072#1081#1086#1085#1091':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Grid: TStringAlignGrid
    Left = 0
    Top = 0
    Width = 643
    Height = 199
    Align = alClient
    BiDiMode = bdLeftToRight
    Ctl3D = False
    DefaultRowHeight = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    OnDblClick = GridDblClick
    OnEnter = GridEnter
    OnExit = GridExit
    OnKeyDown = GridKeyDown
    OnSelectCell = GridSelectCell
    RowHeights = (
      18
      18
      18
      18
      18)
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
  object pnl_Wait: TPanel
    Left = 224
    Top = 56
    Width = 265
    Height = 73
    BevelInner = bvLowered
    Caption = #1048#1076#1077#1090' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
end
