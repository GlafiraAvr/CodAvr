inherited frm_PeriodRegSelCB_vds: Tfrm_PeriodRegSelCB_vds
  Caption = 'frm_PeriodRegSelCB_vds'
  ClientHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited btn_ok: TBitBtn
    Top = 144
  end
  inherited btn_exit: TBitBtn
    Top = 144
    OnClick = btn_exitClick
  end
  object CB: TCheckBox
    Left = 8
    Top = 120
    Width = 233
    Height = 17
    Caption = #1044#1083#1103' '#1085#1072#1095'. '#1076#1080#1089#1087' '#1089#1083#1091#1078#1073#1099
    TabOrder = 5
  end
  object btn_Streets: TBitBtn
    Left = 24
    Top = 88
    Width = 193
    Height = 25
    Caption = #1059#1083#1080#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_StreetsClick
  end
end
