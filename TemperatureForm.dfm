object frm_Temperature: Tfrm_Temperature
  Left = 348
  Top = 273
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1090#1077#1084#1087#1077#1088#1072#1090#1091#1088#1099' '#1074#1086#1076#1099
  ClientHeight = 90
  ClientWidth = 230
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 3
    Top = -1
    Width = 223
    Height = 58
    TabOrder = 1
    object Label1: TLabel
      Left = 46
      Top = 12
      Width = 78
      Height = 13
      Caption = #1044#1072#1090#1072' '#1089#1084#1077#1085#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 33
      Width = 117
      Height = 13
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072' '#1074#1086#1076#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_WaterTemp: TRxSpinEdit
      Left = 128
      Top = 31
      Width = 89
      Height = 21
      MaxValue = 200.000000000000000000
      ValueType = vtFloat
      MaxLength = 7
      TabOrder = 1
    end
    object ded_Shift: TDateEdit
      Left = 128
      Top = 9
      Width = 89
      Height = 20
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object btn_Apply: TBitBtn
    Left = 5
    Top = 62
    Width = 220
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btn_ApplyClick
    Kind = bkOK
  end
  object dset_Temper: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 128
    Top = 40
  end
  object sql_Temper: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RWSnapshot
    Left = 16
    Top = 48
  end
end
