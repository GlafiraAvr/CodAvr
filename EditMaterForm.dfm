object frm_EditMater: Tfrm_EditMater
  Left = 361
  Top = 343
  BorderStyle = bsDialog
  Caption = #1052#1072#1090#1077#1088#1080#1072#1083
  ClientHeight = 110
  ClientWidth = 316
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
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 316
    Height = 78
    Align = alTop
  end
  object Label1: TLabel
    Left = 18
    Top = 8
    Width = 50
    Height = 13
    Caption = #1052#1072#1090#1077#1088#1080#1072#1083
  end
  object Label2: TLabel
    Left = 21
    Top = 32
    Width = 46
    Height = 13
    Caption = #1044#1080#1072#1084#1077#1090#1088
  end
  object Label3: TLabel
    Left = 8
    Top = 57
    Width = 59
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object dbl_Mater: TRxDBLookupCombo
    Left = 72
    Top = 5
    Width = 241
    Height = 21
    DropDownCount = 8
    DataField = 'FK_DEPMATERS_MATER'
    DataSource = ds_Mater
    LookupField = 'ID'
    LookupDisplay = 'FULL_NAME'
    LookupSource = ds_MaterAtt
    TabOrder = 0
  end
  object ed_Quantity: TDBEdit
    Left = 72
    Top = 53
    Width = 145
    Height = 21
    DataField = 'QUANTITY'
    DataSource = ds_Mater
    TabOrder = 1
  end
  object dbl_Diam: TRxDBLookupCombo
    Left = 72
    Top = 29
    Width = 145
    Height = 21
    DropDownCount = 8
    DataField = 'FK_DEPMATERS_DIAMETER'
    DataSource = ds_Mater
    LookupField = 'ID'
    LookupDisplay = 'DIAMETER'
    LookupSource = ds_DiamAtt
    TabOrder = 2
  end
  object btn_ok: TBitBtn
    Left = 148
    Top = 82
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
    Left = 231
    Top = 82
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
  object ds_DiamAtt: TDataSource
    Left = 240
    Top = 40
  end
  object ds_Mater: TDataSource
    Left = 256
  end
  object ds_MaterAtt: TDataSource
    Left = 216
  end
end
