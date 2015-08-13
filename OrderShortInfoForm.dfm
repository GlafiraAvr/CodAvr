inherited frm_OrderShortInfo: Tfrm_OrderShortInfo
  Left = 457
  Top = 379
  BorderStyle = bsDialog
  Caption = #1050#1088#1072#1090#1082#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1085#1072#1088#1103#1076#1091
  ClientHeight = 247
  ClientWidth = 431
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 24
    Width = 90
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbl_OrderNumber: TLabel
    Left = 100
    Top = 24
    Width = 95
    Height = 13
    Caption = 'lbl_OrderNumber'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 208
    Top = 24
    Width = 114
    Height = 13
    Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbl_DateComing: TLabel
    Left = 322
    Top = 24
    Width = 89
    Height = 13
    Caption = 'lbl_DateComing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 10
    Top = 48
    Width = 76
    Height = 13
    Caption = #1063#1090#1086' '#1089#1076#1077#1083#1072#1085#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 68
    Top = 3
    Width = 247
    Height = 16
    Caption = #1053#1072#1088#1103#1076' '#1089' '#1090#1072#1082#1080#1084' '#1072#1076#1088#1077#1089#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object mem_WhatIsDone: TMemo
    Left = 8
    Top = 61
    Width = 417
    Height = 81
    TabStop = False
    TabOrder = 1
  end
  object btn_Exit: TBitBtn
    Left = 352
    Top = 187
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Default = True
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
  object Grid: TStringAlignGrid
    Left = -42
    Top = 45
    Width = 473
    Height = 137
    Ctl3D = False
    DefaultRowHeight = 18
    ParentCtl3D = False
    TabOrder = 2
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
end
