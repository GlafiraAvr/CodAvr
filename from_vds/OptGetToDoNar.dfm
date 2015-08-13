inherited frm_OptGetToDoNar: Tfrm_OptGetToDoNar
  Left = 463
  Top = 443
  Width = 282
  Height = 234
  Caption = 'frm_OptGetToDoNar'
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_SelDatePeriod1: Tframe_SelDatePeriod
    Left = 13
    Top = 8
    Width = 236
    Height = 73
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    inherited Label1: TLabel
      Left = 8
      Width = 73
    end
    inherited Label2: TLabel
      Left = 67
      Top = 37
      Width = 15
    end
    inherited de_Begin: TDateEdit
      Left = 96
      Width = 113
    end
    inherited de_End: TDateEdit
      Left = 98
      Top = 33
      Width = 111
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 144
    Width = 89
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 136
    Top = 144
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object rg_system: TRadioGroup
    Left = 8
    Top = 96
    Width = 217
    Height = 38
    Caption = #1057#1080#1089#1090#1077#1084#1072
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      #1053#1057
      #1042#1044#1057)
    TabOrder = 3
  end
end
