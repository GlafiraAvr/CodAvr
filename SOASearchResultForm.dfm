object frm_SOASearchRes: Tfrm_SOASearchRes
  Left = 292
  Top = 275
  Width = 634
  Height = 288
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1087#1086#1080#1089#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TDBGridEh
    Left = 0
    Top = 0
    Width = 626
    Height = 194
    Align = alClient
    DataSource = ds_Search
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
    OnDrawColumnCell = GridDrawColumnCell
    OnMouseDown = GridMouseDown
    Columns = <
      item
        FieldName = 'ordernumber'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072
        Width = 73
      end
      item
        FieldName = 'DateComing'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072'\'#1074#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
        Width = 125
      end
      item
        FieldName = 'Region'
        Footers = <>
        Title.Caption = #1056#1072#1081#1086#1085
        Width = 131
      end
      item
        FieldName = 'Adres'
        Footers = <>
        Title.Caption = #1040#1076#1088#1077#1089
        Width = 233
      end
      item
        FieldName = 'DmgPlace'
        Footers = <>
        Title.Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
        Width = 135
      end
      item
        FieldName = 'DateClosed'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072'\'#1074#1088#1077#1084#1103' '#1083#1080#1082#1074#1080#1076#1072#1094#1080#1080
        Width = 117
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 194
    Width = 626
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btn_Exit: TBitBtn
      Left = 544
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
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
    object btn_Attach: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_AttachClick
    end
    object btn_AddToCache: TBitBtn
      Left = 96
      Top = 8
      Width = 129
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1082#1077#1096
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_AddToCacheClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 235
    Width = 626
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ds_Search: TDataSource
    Left = 40
    Top = 80
  end
end
