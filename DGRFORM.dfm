object Graph: TGraph
  Left = 306
  Top = 205
  Width = 680
  Height = 490
  Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Diagram: TDiagram
    Left = 0
    Top = 0
    Width = 672
    Height = 431
    Align = alClient
    PopupMenu = PopupMenu
    OnDblClick = DiagramDblClick
    Active = False
    MinMaxAuto = False
    CountColumns = 20
    CountRows = 10
    CountLayers = 5
    PercentSpace = 20
    ShadowRow = 80
    rho = 50.000000000000000000
    LabelCaption = 'Diagram'
    FontCaption.Charset = DEFAULT_CHARSET
    FontCaption.Color = clBlack
    FontCaption.Height = -23
    FontCaption.Name = 'Arial'
    FontCaption.Style = [fsBold, fsItalic]
    FontLabel.Charset = DEFAULT_CHARSET
    FontLabel.Color = clWindowText
    FontLabel.Height = -13
    FontLabel.Name = 'Arial'
    FontLabel.Style = []
    Style = dsMatrix
  end
  object Panel: TPanel
    Left = 0
    Top = 431
    Width = 672
    Height = 32
    Align = alBottom
    TabOrder = 0
    object Button1: TSpeedButton
      Left = 509
      Top = 4
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
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
      OnClick = Button1Click
    end
    object BitBtn1: TSpeedButton
      Left = 589
      Top = 4
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
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
      OnClick = BitBtn1Click
    end
    object pn2: TPanel
      Tag = 1993
      Left = 51
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = pnYearClick
    end
    object pn3: TPanel
      Tag = 1994
      Left = 98
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = pnYearClick
    end
    object pn4: TPanel
      Tag = 1995
      Left = 145
      Top = 6
      Width = 39
      Height = 21
      BevelInner = bvLowered
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = pnYearClick
    end
    object pn5: TPanel
      Tag = 1996
      Left = 193
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = pnYearClick
    end
    object pn1: TPanel
      Tag = 1992
      Left = 7
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clOlive
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnClick = pnYearClick
    end
    object pn6: TPanel
      Tag = 1992
      Left = 241
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = pnYearClick
    end
    object pn7: TPanel
      Tag = 1993
      Left = 285
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clPurple
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Visible = False
      OnClick = pnYearClick
    end
    object pn8: TPanel
      Tag = 1994
      Left = 332
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnClick = pnYearClick
    end
    object pn9: TPanel
      Tag = 1995
      Left = 379
      Top = 6
      Width = 39
      Height = 21
      BevelInner = bvLowered
      Color = clFuchsia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      Visible = False
      OnClick = pnYearClick
    end
    object pn10: TPanel
      Tag = 1996
      Left = 427
      Top = 6
      Width = 40
      Height = 21
      BevelInner = bvLowered
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      Visible = False
      OnClick = pnYearClick
    end
  end
  object Panel_Track: TPanel
    Left = 0
    Top = 3
    Width = 189
    Height = 34
    Caption = 'Panel_Track'
    Enabled = False
    TabOrder = 1
    Visible = False
    object TrackBar: TTrackBar
      Left = 4
      Top = 9
      Width = 182
      Height = 16
      Max = 50
      Min = 1
      PageSize = 5
      Position = 50
      SelEnd = 5
      TabOrder = 0
      OnChange = TrackBarChange
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 150
    OnTimer = TimerTimer
    Left = 296
    Top = 24
  end
  object PopupMenu: TPopupMenu
    Left = 232
    Top = 136
    object track: TMenuItem
      Caption = #1056#1072#1089#1090#1086#1103#1085#1080#1077' '#1085#1072#1073#1083#1102#1076#1077#1085#1080#1103
      OnClick = trackClick
    end
  end
end
