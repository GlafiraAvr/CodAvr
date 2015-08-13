object frm_options1562: Tfrm_options1562
  Left = 485
  Top = 273
  Width = 223
  Height = 140
  Caption = #1053#1072#1089#1090#1088#1075#1086#1081#1082#1080'  1562'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 75
    Top = 44
    Width = 93
    Height = 13
    Caption = #1048#1085#1090#1077#1088#1074#1072#1083' ('#1084#1080#1085')'
  end
  object Automat: TCheckBox
    Left = 24
    Top = 8
    Width = 169
    Height = 17
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1086#1087#1088#1086#1089
    TabOrder = 0
    OnClick = AutomatClick
  end
  object Interval: TSpinEdit
    Left = 24
    Top = 40
    Width = 41
    Height = 22
    MaxValue = 30
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end
