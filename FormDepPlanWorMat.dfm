object frm_DepPlanWorkMat: Tfrm_DepPlanWorkMat
  Left = 470
  Top = 320
  Width = 675
  Height = 352
  Caption = '\'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 659
    Height = 273
    ActivePage = Works
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    object Works: TTabSheet
      Caption = #1056#1072#1073#1086#1090#1099
      object dbg_works: TDBGridEh
        Left = 0
        Top = 0
        Width = 651
        Height = 245
        Align = alClient
        DataSource = ds_works
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        Columns = <
          item
            Alignment = taCenter
            FieldName = 'WORKNAME'
            Footers = <>
            Title.Caption = #1056#1072#1073#1086#1090#1099
            Width = 190
          end
          item
            FieldName = 'DIAM'
            Footers = <>
            Title.Caption = #1044#1080#1072#1084#1077#1090#1088
            Width = 52
          end
          item
            FieldName = 'QUANTITY'
            Footers = <>
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 43
          end
          item
            FieldName = 'ADDITIONALINFO'
            Footers = <>
            Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103'  '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
            Width = 132
          end
          item
            FieldName = 'EXC_DEPTH'
            Footers = <>
            Title.Caption = #1043#1083#1091#1073#1080#1085#1072
            Width = 46
          end
          item
            FieldName = 'EXC_WIDTH'
            Footers = <>
            Title.Caption = #1064#1080#1088#1080#1085#1072
            Width = 43
          end
          item
            FieldName = 'EXC_LENGTH'
            Footers = <>
            Title.Caption = #1044#1083#1080#1085#1085#1072
            Width = 47
          end
          item
            FieldName = 'SQUARE_ASF'
            Footers = <>
            Title.Caption = #1055#1083#1086#1097#1072#1076#1100' '#1072#1089#1092
          end>
      end
    end
    object Maters: TTabSheet
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
      ImageIndex = 1
      object dbg_maters: TDBGridEh
        Left = 0
        Top = 0
        Width = 651
        Height = 245
        Align = alClient
        DataSource = ds_maters
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            FieldName = 'MATERNAME'
            Footers = <>
            Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
          end
          item
            FieldName = 'DIAM'
            Footers = <>
            Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          end
          item
            FieldName = 'QUANTITY'
            Footers = <>
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 46
          end>
      end
    end
  end
  object pnl_EditWrkAndMat: TPanel
    Left = 0
    Top = 273
    Width = 659
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      659
      41)
    object btn_AddDetail: TBitBtn
      Left = 5
      Top = 8
      Width = 105
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = btn_AddDetailClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_EditDetail: TBitBtn
      Left = 117
      Top = 8
      Width = 105
      Height = 25
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = btn_EditDetailClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object btn_DelDetail: TBitBtn
      Left = 229
      Top = 8
      Width = 105
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btn_DelDetailClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 576
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
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
  end
  object ds_works: TDataSource
    DataSet = dm_DepPlanWorMat.dset_works
    Left = 28
    Top = 40
  end
  object ds_maters: TDataSource
    DataSet = dm_DepPlanWorMat.dset_maters
    Left = 96
    Top = 40
  end
end
