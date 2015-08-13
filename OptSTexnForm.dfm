inherited frm_SOptTexn: Tfrm_SOptTexn
  Width = 217
  Height = 148
  Caption = 'frm_SOptTexn'
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 8
    Width = 111
    Height = 13
    Caption = #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086' '#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 4
    Top = 3
    Width = 177
    Height = 63
  end
  object de_Date: TDateEdit
    Left = 40
    Top = 32
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
end
