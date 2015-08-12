inherited frm_BWorkInsert: Tfrm_BWorkInsert
  Left = 347
  Top = 369
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
  ClientWidth = 282
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 282
    Height = 89
  end
  inherited Label1: TLabel
    Left = 10
    Top = 9
  end
  inherited dbl_BWork: TRxDBLookupCombo
    Left = 49
    Width = 232
  end
  inherited btn_ok: TBitBtn
    Left = 119
    Top = 96
  end
  inherited btn_exit: TBitBtn
    Left = 199
    Top = 96
  end
  object chb_work: TCheckBox [5]
    Left = 8
    Top = 40
    Width = 265
    Height = 17
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1077' '#1087#1086#1076#1088#1072#1073#1086#1090#1099
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object chb_mater: TCheckBox [6]
    Left = 8
    Top = 59
    Width = 273
    Height = 17
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  inherited ds_BWork: TDataSource
    Left = 120
    Top = 0
  end
  inherited ds_BWorkAtt: TDataSource
    Left = 152
    Top = 0
  end
end
