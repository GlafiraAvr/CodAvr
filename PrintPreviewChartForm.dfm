object PrintPreviewChartFrm: TPrintPreviewChartFrm
  Left = 193
  Top = 115
  Width = 504
  Height = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image2: TImage
    Left = 1
    Top = 1
    Width = 285
    Height = 403
  end
  object GroupBox1: TGroupBox
    Left = 289
    Top = -1
    Width = 205
    Height = 240
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 14
      Width = 55
      Height = 13
      Caption = #1055#1088#1080#1085#1090#1077#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 4
      Top = 31
      Width = 52
      Height = 13
      Caption = 'AdobePDF'
    end
    object Label3: TLabel
      Left = 4
      Top = 49
      Width = 144
      Height = 13
      Caption = '1200x1200 dpi, 2 '#1094#1074', 210x297'
    end
    object Label4: TLabel
      Left = 4
      Top = 65
      Width = 46
      Height = 13
      Caption = #1052#1072#1089#1096#1090#1072#1073
    end
    object Label5: TLabel
      Left = 49
      Top = 84
      Width = 52
      Height = 13
      Caption = '% '#1088#1072#1079#1084#1077#1088':'
    end
    object Label6: TLabel
      Left = 2
      Top = 108
      Width = 42
      Height = 13
      Caption = #1054#1090#1089#1090#1091#1087
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 4
      Top = 122
      Width = 79
      Height = 13
      Caption = #1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080
    end
    object Label8: TLabel
      Left = 4
      Top = 147
      Width = 68
      Height = 13
      Caption = #1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
    end
    object Label9: TLabel
      Left = 130
      Top = 124
      Width = 19
      Height = 13
      Caption = 'mm.'
    end
    object Label10: TLabel
      Left = 130
      Top = 148
      Width = 19
      Height = 13
      Caption = 'mm.'
    end
    object BitBtn1: TBitBtn
      Left = 120
      Top = 205
      Width = 77
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 6
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
    object PrintBtn: TBitBtn
      Left = 7
      Top = 205
      Width = 77
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
      TabOrder = 5
      OnClick = PrintBtnClick
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
    object BitBtn3: TBitBtn
      Left = 120
      Top = 172
      Width = 77
      Height = 25
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 4
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 7
      Top = 172
      Width = 77
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 3
      OnClick = BitBtn4Click
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
    object ScaleEdit: TSpinEdit
      Left = 5
      Top = 79
      Width = 42
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 100
      MinValue = 0
      TabOrder = 0
      Value = 100
      OnChange = ScaleEditChange
    end
    object HorzOffsetEdit: TSpinEdit
      Left = 88
      Top = 118
      Width = 41
      Height = 22
      MaxLength = 4
      MaxValue = 1000
      MinValue = -1000
      TabOrder = 1
      Value = 0
      OnChange = HorzOffsetEditChange
    end
    object VertOffsetEdit: TSpinEdit
      Left = 88
      Top = 142
      Width = 41
      Height = 22
      MaxLength = 4
      MaxValue = 1000
      MinValue = -1000
      TabOrder = 2
      Value = 0
      OnChange = VertOffsetEditChange
    end
  end
  object svdlg: TSaveDialog
    Left = 414
    Top = 105
  end
  object psdlg: TPrinterSetupDialog
    Left = 376
    Top = 312
  end
end
