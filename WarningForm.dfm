object frm_Warning: Tfrm_Warning
  Left = 412
  Top = 255
  BorderStyle = bsDialog
  ClientHeight = 88
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 55
    Top = 9
    Width = 194
    Height = 20
    Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1085#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1099'!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Tag = 1
    Left = 12
    Top = 48
    Width = 91
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
    Kind = bkYes
  end
  object BitBtn2: TBitBtn
    Tag = 2
    Left = 114
    Top = 48
    Width = 97
    Height = 25
    Caption = #1053#1077' '#1089#1086#1093#1088#1072#1085#1103#1090#1100
    TabOrder = 1
    OnClick = Button1Click
    Kind = bkNo
  end
  object BitBtn3: TBitBtn
    Tag = 3
    Left = 221
    Top = 48
    Width = 85
    Height = 25
    Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103
    TabOrder = 2
    OnClick = Button1Click
    Kind = bkCancel
  end
end
