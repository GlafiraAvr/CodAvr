inherited frm_ResSvodVed_vds: Tfrm_ResSvodVed_vds
  Left = 219
  Top = 214
  BorderStyle = bsDialog
  Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088
  ClientHeight = 302
  ClientWidth = 667
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_btns: TPanel
    Left = 0
    Top = 261
    Width = 667
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      667
      41)
    object BitBtn1: TBitBtn
      Left = 574
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1044#1072#1083#1077#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FF3333333333333447333333333333377FFF33333333333744473333333
        333337773FF3333333333444447333333333373F773FF3333333334444447333
        33333373F3773FF3333333744444447333333337F333773FF333333444444444
        733333373F3333773FF333334444444444733FFF7FFFFFFF77FF999999999999
        999977777777777733773333CCCCCCCCCC3333337333333F7733333CCCCCCCCC
        33333337F3333F773333333CCCCCCC3333333337333F7733333333CCCCCC3333
        333333733F77333333333CCCCC333333333337FF7733333333333CCC33333333
        33333777333333333333CC333333333333337733333333333333}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 494
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1079#1072#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF3333333333333744333333333333F773333333333337
        44473333333333F777F3333333333744444333333333F7733733333333374444
        4433333333F77333733333333744444447333333F7733337F333333744444444
        433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
        9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
        C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
        CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
        CCC333333333333777FF33333333333333CC3333333333333773}
      NumGlyphs = 2
    end
    object btn_SnapShot: TBitBtn
      Left = 8
      Top = 8
      Width = 129
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1083#1077#1087#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btn_LoadSnapshot: TBitBtn
      Left = 142
      Top = 8
      Width = 119
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1083#1077#1087#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object BitBtn3: TBitBtn
      Left = 270
      Top = 8
      Width = 119
      Height = 25
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = N1Click
    end
    object CB_D: TCheckBox
      Left = 392
      Top = 8
      Width = 97
      Height = 17
      Caption = #1079#1072' '#1090#1077#1082'. '#1089#1084#1077#1085#1091
      TabOrder = 5
      Visible = False
    end
  end
  object DBGridEh: TDBGridEh
    Left = 0
    Top = 0
    Width = 721
    Height = 260
    DataSource = ds_CountByReg
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
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    UseMultiTitle = True
    Columns = <
      item
        FieldName = 'Region'
        Footers = <>
        Title.Caption = #1056#1072#1081#1086#1085#1099
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 117
      end
      item
        FieldName = 'o62_prin'
        Footers = <>
        Title.Caption = #1055#1088#1080#1085#1103#1090#1086'||15-62'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 39
      end
      item
        FieldName = 'zhitel_prin'
        Footers = <>
        Title.Caption = #1055#1088#1080#1085#1103#1090#1086'||'#1046#1080#1090#1077#1083#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 50
      end
      item
        FieldName = 'sum_prin'
        Footers = <>
        Title.Caption = #1055#1088#1080#1085#1103#1090#1086'||'#1042#1089#1077#1075#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 44
      end
      item
        FieldName = 'o62_vip'
        Footers = <>
        Title.Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1086'||15-62'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 36
      end
      item
        FieldName = 'zhitel_vip'
        Footers = <>
        Title.Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1086'||'#1046#1080#1090#1077#1083#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 51
      end
      item
        FieldName = 'sum_vip'
        Footers = <>
        Title.Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1086'||'#1042#1089#1077#1075#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 47
      end
      item
        FieldName = 'percent_vip'
        Footers = <>
        Title.Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1086'||% '#1074#1099#1087#1086#1083#1085'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 68
      end
      item
        FieldName = 'ostalos'
        Footers = <>
        Title.Caption = #1054#1089#1090#1072#1083#1080#1089#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 63
      end
      item
        FieldName = 'ods_prin'
        Footers = <>
        Title.Caption = #1054#1044#1057'||'#1055#1088#1080#1085#1103#1090#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 53
      end
      item
        FieldName = 'ods_vip'
        Footers = <>
        Title.Caption = #1054#1044#1057'||'#1042#1099#1087#1086#1083#1085#1077#1085#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlack
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 73
      end>
  end
  object ds_CountByReg: TDataSource
    DataSet = dm_RepSvodVed_vds.md_CountByReg
    Left = 240
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 392
    Top = 120
    object N1: TMenuItem
      Caption = #1055#1086#1089#1095#1080#1090#1072#1090#1100' '#1074#1089#1077#1075#1086' '#1079#1072' '#1089#1084#1077#1085#1091
      OnClick = N1Click
    end
  end
end
