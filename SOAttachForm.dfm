object frm_SOAttach: Tfrm_SOAttach
  Left = 360
  Top = 335
  Width = 641
  Height = 284
  Caption = #1055#1088#1080#1074#1103#1079#1082#1072' '#1082' '#1085#1072#1088#1103#1076#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Main: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    DesignSize = (
      633
      41)
    object btn_SearchOrder: TBitBtn
      Left = 8
      Top = 8
      Width = 113
      Height = 25
      Caption = #1053#1072#1081#1090#1080' '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_SearchOrderClick
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
    object btn_NewOrder: TBitBtn
      Left = 128
      Top = 8
      Width = 121
      Height = 25
      Caption = #1053#1086#1074#1099#1081' '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_NewOrderClick
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
    object BitBtn1: TBitBtn
      Left = 550
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn1Click
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
  end
  object pnl_Cache: TPanel
    Left = 0
    Top = 41
    Width = 633
    Height = 209
    Align = alClient
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 1
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 629
      Height = 29
      Align = alTop
      Caption = #1050#1077#1096
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 31
      Width = 527
      Height = 176
      Align = alClient
      DataSource = ds_Cache
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      Columns = <
        item
          FieldName = 'OrderNumber'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072
          Width = 77
        end
        item
          FieldName = 'DateComing'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072'\'#1074#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
          Width = 123
        end
        item
          FieldName = 'Region'
          Footers = <>
          Title.Caption = #1056#1072#1081#1086#1085
          Width = 134
        end
        item
          FieldName = 'Adres'
          Footers = <>
          Title.Caption = #1040#1076#1088#1077#1089
          Width = 173
        end
        item
          FieldName = 'DmgPlace'
          Footers = <>
          Title.Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
          Width = 121
        end
        item
          FieldName = 'DateClosed'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072'\'#1074#1088#1077#1084#1103' '#1083#1080#1082#1074#1080#1076#1072#1094#1080#1080
          Width = 100
        end>
    end
    object pnl_CacheBtns: TPanel
      Left = 529
      Top = 31
      Width = 102
      Height = 176
      Align = alRight
      BevelOuter = bvNone
      Color = clMoneyGreen
      TabOrder = 1
      object btn_AttachToCache: TBitBtn
        Left = 5
        Top = 3
        Width = 92
        Height = 25
        Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btn_AttachToCacheClick
      end
      object btn_ClearCache: TBitBtn
        Left = 5
        Top = 32
        Width = 93
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1082#1077#1096
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btn_ClearCacheClick
      end
    end
  end
  object ds_Cache: TDataSource
    Left = 144
    Top = 121
  end
end
