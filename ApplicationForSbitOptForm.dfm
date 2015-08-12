inherited frm_OptApplicationForSbit: Tfrm_OptApplicationForSbit
  Left = 614
  Top = 306
  Width = 261
  Height = 188
  Caption = 'frm_OptApplicationForSbit'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_SelDateTimePeriod1: Tframe_SelDateTimePeriod
    Left = 22
    Top = 24
    Width = 195
    Height = 73
    TabOrder = 0
    inherited Label1: TLabel
      Width = 9
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited Label2: TLabel
      Left = 4
      Top = 46
      Width = 15
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited de_Begin: TDateEdit
      Left = 25
      Top = 4
    end
    inherited de_End: TDateEdit
      Left = 25
      Top = 43
    end
    inherited tp_Begin: TDateTimePicker
      Left = 115
      Top = 4
    end
    inherited tp_End: TDateTimePicker
      Left = 115
      Top = 43
    end
  end
  object bitbtn_Ok: TBitBtn
    Left = 16
    Top = 112
    Width = 89
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 1
    OnClick = bitbtn_OkClick
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 112
    Width = 81
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
end
