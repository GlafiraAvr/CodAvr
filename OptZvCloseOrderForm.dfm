inherited frm_OptZvCloseOrder: Tfrm_OptZvCloseOrder
  Left = 477
  Top = 334
  Width = 258
  Height = 153
  Caption = 'frm_OptZvCloseOrder'
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_SelDatePeriod1: Tframe_SelDatePeriod
    Left = 5
    Top = 8
    Width = 220
    Height = 57
    TabOrder = 0
    inherited Label1: TLabel
      Left = 24
    end
    inherited Label2: TLabel
      Left = 72
      Top = 37
    end
    inherited de_Begin: TDateEdit
      Left = 96
    end
    inherited de_End: TDateEdit
      Left = 96
      Top = 33
    end
  end
  object btn_ok: TBitBtn
    Left = 16
    Top = 80
    Width = 81
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btn_okClick
    Kind = bkOK
  end
  object btn_Cancel: TBitBtn
    Left = 128
    Top = 80
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn_CancelClick
    Kind = bkCancel
  end
end
