inherited frm_OptBlagRazr: Tfrm_OptBlagRazr
  Left = 488
  Top = 265
  Width = 265
  Height = 125
  Caption = 'frm_OptBlagRazr'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btn_ok: TBitBtn
    Left = 16
    Top = 48
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 0
    OnClick = btn_okClick
    Kind = bkOK
  end
  object btn_cancel: TBitBtn
    Left = 120
    Top = 48
    Width = 83
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    Kind = bkCancel
  end
  inline frame_SelDates: Tframe_SelDatePeriod
    Left = 7
    Top = 7
    Width = 226
    Height = 22
    TabOrder = 2
    inherited Label1: TLabel
      Width = 10
      Caption = 'C '
    end
    inherited Label2: TLabel
      Left = 107
    end
    inherited de_Begin: TDateEdit
      Left = 16
    end
    inherited de_End: TDateEdit
      Left = 130
    end
  end
end
