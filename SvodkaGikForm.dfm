object frm_SvodkaGik: Tfrm_SvodkaGik
  Left = 338
  Top = 427
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1076#1082#1072' '#1074' '#1043#1048#1050
  ClientHeight = 197
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 266
    Height = 154
  end
  object lbl_Date: TLabel
    Left = 19
    Top = 19
    Width = 155
    Height = 26
    Alignment = taCenter
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1079#1072' '#1082#1086#1090#1086#1088#1091#1102' '#13#10#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1089#1074#1086#1076#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 16
    Top = 17
    Width = 253
    Height = 33
  end
  object dp_Date: TDateEdit
    Left = 174
    Top = 24
    Width = 89
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object chb_ForGen: TCheckBox
    Left = 26
    Top = 141
    Width = 201
    Height = 17
    Caption = #1044#1083#1103' '#1075#1077#1085#1077#1088#1072#1083#1100#1085#1086#1075#1086' '#1076#1080#1088#1077#1082#1090#1086#1088#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object bb_ok: TBitBtn
    Left = 8
    Top = 166
    Width = 81
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bb_okClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object bb_exit: TBitBtn
    Left = 192
    Top = 165
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = bb_exitClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object pnl: TPanel
    Left = 12
    Top = 52
    Width = 258
    Height = 90
    BevelOuter = bvNone
    TabOrder = 4
    object bv_ShiftNumber: TBevel
      Left = 3
      Top = 35
      Width = 252
      Height = 27
    end
    object bv_Equip: TBevel
      Left = 3
      Top = 3
      Width = 252
      Height = 27
    end
    object lbl_Equip: TLabel
      Left = 28
      Top = 10
      Width = 144
      Height = 13
      Caption = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099' '#1087#1077#1095#1072#1090#1072#1090#1100'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_ShiftNumber: TLabel
      Left = 15
      Top = 42
      Width = 155
      Height = 13
      Alignment = taCenter
      Caption = #1053#1086#1084#1077#1088' '#1089#1084#1077#1085#1099' '#1091#1095#1080#1090#1099#1074#1072#1090#1100'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cb_Equip: TComboBox
      Left = 175
      Top = 7
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #1044#1072
      Items.Strings = (
        #1044#1072
        #1053#1077#1090)
    end
    object cb_ShiftNumber: TComboBox
      Left = 174
      Top = 39
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 1
      Text = #1053#1077#1090
      Items.Strings = (
        #1044#1072
        #1053#1077#1090)
    end
    object chb_ReCreate: TCheckBox
      Left = 14
      Top = 72
      Width = 169
      Height = 17
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1085#1086#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
end
