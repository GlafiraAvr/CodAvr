inherited frm_PeriodRegSelCB: Tfrm_PeriodRegSelCB
  Left = 579
  Top = 314
  Caption = 'frm_PeriodRegSelCB'
  ClientHeight = 227
  ClientWidth = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel2: TBevel
    Height = 135
  end
  inherited btn_ok: TBitBtn
    Top = 184
  end
  inherited btn_exit: TBitBtn
    Top = 184
  end
  inherited btn_asfcompany: TBitBtn
    TabOrder = 8
    Visible = False
  end
  inherited cb_Type: TComboBox
    Left = 7
    Top = 140
    Visible = False
  end
  object CB: TCheckBox
    Left = 8
    Top = 104
    Width = 217
    Height = 17
    Caption = #1044#1083#1103' '#1085#1072#1095'. '#1076#1080#1089#1087' '#1089#1083#1091#1078#1073#1099
    TabOrder = 5
    OnClick = CBClick
  end
  object CB_ALL: TCheckBox
    Left = 8
    Top = 122
    Width = 217
    Height = 17
    Caption = #1042#1089#1077' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
    TabOrder = 7
    OnClick = CB_ALLClick
  end
  object btn_street: TBitBtn
    Left = 16
    Top = 72
    Width = 209
    Height = 25
    Caption = #1059#1083#1080#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btn_streetClick
  end
end
