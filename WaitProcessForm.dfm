object frm_WaitProcess: Tfrm_WaitProcess
  Left = 654
  Top = 423
  BorderStyle = bsDialog
  Caption = #1048#1076#1077#1090' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
  ClientHeight = 127
  ClientWidth = 340
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
  object Label1: TLabel
    Left = 32
    Top = 64
    Width = 243
    Height = 24
    Caption = #1055#1086#1078#1072#1083#1091#1081#1089#1090#1072' '#1087#1086#1076#1086#1078#1076#1080#1090#1077'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_info: TLabel
    Left = 8
    Top = 96
    Width = 42
    Height = 13
    Caption = 'lbl_info'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Animate1: TAnimate
    Left = 8
    Top = 8
    Width = 321
    Height = 49
    HelpContext = 1
    Active = True
    AutoSize = False
    CommonAVI = aviCopyFile
    StopFrame = 1
    Timers = True
  end
end
