object frm_KolvoOtkazGraph: Tfrm_KolvoOtkazGraph
  Left = 233
  Top = 175
  Width = 650
  Height = 423
  Caption = #1043#1088#1072#1092#1080#1082
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
  object Panel1: TPanel
    Left = 0
    Top = 364
    Width = 642
    Height = 32
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      642
      32)
    object bb_Exit: TBitBtn
      Left = 562
      Top = 4
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
      TabOrder = 0
      OnClick = bb_ExitClick
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
    object bb_print: TBitBtn
      Left = 5
      Top = 4
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bb_printClick
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
  end
  object Panel2: TPanel
    Left = 488
    Top = 0
    Width = 154
    Height = 364
    Align = alRight
    TabOrder = 1
    DesignSize = (
      154
      364)
    object chlb_Series: TCheckListBox
      Left = 8
      Top = 8
      Width = 138
      Height = 319
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      PopupMenu = pm_Group
      TabOrder = 0
      OnClick = chlb_SeriesClick
    end
    object Panel3: TPanel
      Left = 1
      Top = 329
      Width = 152
      Height = 34
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object CheckBox1: TCheckBox
        Left = 8
        Top = 1
        Width = 97
        Height = 33
        Caption = #1055#1086#1076#1087#1080#1089#1099#1074#1072#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 0
        WordWrap = True
        OnClick = CheckBox1Click
      end
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 488
    Height = 364
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    Align = alClient
    Color = clWhite
    TabOrder = 2
  end
  object pm_Group: TPopupMenu
    Left = 552
    Top = 80
  end
end
