inherited frm_OptRSvod: Tfrm_OptRSvod
  Left = 590
  Top = 397
  Width = 401
  Height = 256
  Caption = 'frm_OptRSvod'
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_SelDateTimePeriod1: Tframe_SelDateTimePeriod
    Left = 8
    Top = 8
    Width = 369
    Height = 33
    TabOrder = 0
    inherited Label2: TLabel
      Left = 176
      Top = 7
    end
    inherited de_End: TDateEdit
      Left = 197
      Top = 4
    end
    inherited tp_Begin: TDateTimePicker
      Width = 72
      Date = 39665.541666666660000000
      Time = 39665.541666666660000000
    end
    inherited tp_End: TDateTimePicker
      Left = 287
      Top = 4
      Width = 74
    end
  end
  inline frame_SelRegion1: Tframe_SelRegion
    Left = 184
    Top = 56
    Width = 161
    Height = 41
    TabOrder = 1
    inherited btn_Region: TBitBtn
      Left = 0
      Top = 0
      Width = 145
      OnClick = frame_SelRegion1btn_RegionClick
    end
  end
  object rg_typ: TRadioGroup
    Left = 16
    Top = 48
    Width = 145
    Height = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      #1053#1077#1079#1072#1082#1088#1099#1099#1077
      #1047#1072#1082#1088#1099#1090#1099#1077
      #1042#1089#1077)
    ParentFont = False
    TabOrder = 2
  end
  object Butt_onControl: TButton
    Left = 184
    Top = 96
    Width = 145
    Height = 25
    Caption = #1053#1072' '#1082#1086#1085#1090#1088#1086#1083#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Butt_onControlClick
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 176
    Width = 80
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 176
    Width = 80
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
    Kind = bkOK
  end
end
