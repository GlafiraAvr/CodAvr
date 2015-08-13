object EditDisconnectionsForm: TEditDisconnectionsForm
  Left = 398
  Top = 297
  Width = 569
  Height = 154
  Caption = #1042#1074#1086#1076' '#1072#1076#1088#1077#1089#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 553
    Height = 81
    Align = alTop
  end
  object l_street: TLabel
    Left = 5
    Top = 12
    Width = 47
    Height = 16
    Caption = #1059#1083#1080#1094#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object l_house: TLabel
    Left = 5
    Top = 36
    Width = 66
    Height = 16
    Caption = #8470' '#1076#1086#1084#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object l_dop: TLabel
    Left = 2
    Top = 59
    Width = 130
    Height = 16
    Caption = #1044#1086#1087'. '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbl_Street: TRxDBLookupCombo
    Left = 144
    Top = 8
    Width = 385
    Height = 21
    DropDownCount = 8
    DataField = 'look_streets'
    DataSource = DataSource1
    TabOrder = 0
    OnKeyDown = FormKeyDown
  end
  object ed_house: TDBEdit
    Left = 144
    Top = 32
    Width = 297
    Height = 21
    DataField = 'HOUSES'
    DataSource = DataSource1
    TabOrder = 1
    OnKeyDown = FormKeyDown
  end
  object ed_dop: TDBEdit
    Left = 144
    Top = 56
    Width = 385
    Height = 21
    DataField = 'ADDITIONALINFO'
    DataSource = DataSource1
    TabOrder = 2
    OnKeyDown = FormKeyDown
  end
  object btn_ok: TBitBtn
    Left = 300
    Top = 90
    Width = 80
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 3
    OnClick = btn_okClick
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
  object btn_exit: TBitBtn
    Left = 383
    Top = 90
    Width = 80
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 4
    OnClick = btn_exitClick
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
  object DataSource1: TDataSource
    DataSet = DM_Disconnect.ds_Disconnections
    Left = 88
    Top = 24
  end
end
