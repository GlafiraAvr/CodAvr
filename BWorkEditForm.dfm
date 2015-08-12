inherited frm_BWorkEdit: Tfrm_BWorkEdit
  Left = 425
  Top = 450
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 173
  ClientWidth = 285
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 285
    Height = 141
  end
  inherited dbl_BWork: TRxDBLookupCombo
    Width = 230
  end
  inherited btn_ok: TBitBtn
    Left = 128
    Top = 144
  end
  inherited btn_exit: TBitBtn
    Left = 208
    Top = 144
  end
  object GroupBox1: TGroupBox [5]
    Left = 8
    Top = 32
    Width = 273
    Height = 50
    TabOrder = 3
    object chb_AddNewWork: TCheckBox
      Left = 5
      Top = 29
      Width = 257
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1088#1072#1073#1086#1090#1099' '#1089#1086#1086#1090'. '#1085#1086#1074#1086#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chb_DelOldWork: TCheckBox
      Left = 5
      Top = 10
      Width = 249
      Height = 17
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1076#1088#1072#1073#1086#1090#1099' '#1089#1086#1086#1090'. '#1089#1090#1072#1088#1086#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox [6]
    Left = 8
    Top = 81
    Width = 273
    Height = 52
    TabOrder = 4
    object chb_AddNewMater: TCheckBox
      Left = 4
      Top = 31
      Width = 257
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1077#1090#1077#1088#1080#1072#1083#1099' '#1089#1086#1086#1090'. '#1085#1086#1074#1086#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chb_DelOldMater: TCheckBox
      Left = 5
      Top = 10
      Width = 257
      Height = 17
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1084#1077#1090#1077#1088#1080#1072#1083#1099' '#1089#1086#1086#1090'. '#1089#1090#1072#1088#1086#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  inherited ds_BWork: TDataSource
    Left = 96
    Top = 0
  end
  inherited ds_BWorkAtt: TDataSource
    Left = 144
    Top = 0
  end
end
