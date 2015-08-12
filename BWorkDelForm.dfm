inherited frm_BWorkDel: Tfrm_BWorkDel
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 104
  ClientWidth = 232
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 232
  end
  inherited Label1: TLabel
    Left = 7
    Width = 205
    Caption = #1042#1099' '#1091#1074#1077#1088#1077#1085#1099', '#1095#1090#1086' '#1093#1086#1090#1080#1090#1077' '#1091#1076#1072#1083#1080#1090#1100' '#1088#1072#1073#1086#1090#1091'?'
  end
  inherited dbl_BWork: TRxDBLookupCombo
    Left = 280
    Width = 33
    Visible = False
  end
  inherited btn_ok: TBitBtn
    Left = 73
    Top = 77
    Caption = #1044#1072
  end
  inherited btn_exit: TBitBtn
    Left = 152
    Top = 76
    Caption = #1053#1077#1090
  end
  object chb_work: TCheckBox [5]
    Left = 7
    Top = 32
    Width = 313
    Height = 17
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1077' '#1087#1086#1076#1088#1072#1073#1086#1090#1099
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object chb_mater: TCheckBox [6]
    Left = 7
    Top = 49
    Width = 305
    Height = 17
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1091#1102#1097#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  inherited ds_BWork: TDataSource
    DataSet = nil
    Left = 40
    Top = 88
  end
  inherited ds_BWorkAtt: TDataSource
    Left = 112
    Top = 88
  end
end
