object frm_ShiftNum: Tfrm_ShiftNum
  Left = 341
  Top = 276
  BorderStyle = bsDialog
  Caption = #1042#1074#1086#1076' '#1085#1086#1084#1077#1088#1072' '#1089#1084#1077#1085#1099
  ClientHeight = 96
  ClientWidth = 196
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
    Top = -2
    Width = 190
    Height = 67
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 13
      Width = 87
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1089#1084#1077#1085#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 13
      Top = 37
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
    object ed_ShiftNum: TSpinEdit
      Left = 95
      Top = 10
      Width = 41
      Height = 22
      MaxValue = 4
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
    object ded_Shift: TDateEdit
      Left = 94
      Top = 34
      Width = 89
      Height = 23
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object btn_Apply: TBitBtn
    Left = 3
    Top = 70
    Width = 191
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
  object dset_Shift: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select shiftnumber, shiftdate '
      'from servanttable')
    Left = 40
    Top = 72
  end
  object sql_Shift: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RWSnapshot
    Left = 8
    Top = 72
  end
end
