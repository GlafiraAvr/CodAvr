object QueryForm: TQueryForm
  Left = 294
  Top = 263
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = #1040#1085#1072#1083#1080#1079' '#1040#1042#1056' '#1087#1086' '#1091#1083#1080#1094#1072#1084
  ClientHeight = 214
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel
    Left = 6
    Top = 176
    Width = 394
    Height = 34
  end
  object lbSreet: TLabel
    Left = 4
    Top = 3
    Width = 173
    Height = 16
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1083#1080#1094#1099':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 22
    Top = 184
    Width = 73
    Height = 16
    Caption = #1044#1080#1072#1084#1077#1090#1088' :'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbNum: TGroupBox
    Left = 181
    Top = 46
    Width = 220
    Height = 62
    Caption = ' '#1053#1086#1084#1077#1088#1072' ('#1076#1086#1084#1072') '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 27
      Width = 9
      Height = 16
      Caption = 'c'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 84
      Top = 27
      Width = 19
      Height = 16
      Caption = #1087#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object seNum1: TSpinEdit
      Left = 23
      Top = 23
      Width = 50
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 999
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
      OnChange = Changing
      OnEnter = seNum1Enter
      OnExit = seNum1Exit
    end
    object seNum2: TSpinEdit
      Left = 110
      Top = 23
      Width = 51
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 999
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 100
      OnChange = Changing
      OnEnter = seNum2Enter
      OnExit = seNum2Exit
    end
    object RB_Chet: TRadioButton
      Left = 168
      Top = 26
      Width = 48
      Height = 15
      Caption = #1063#1077#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Changing
    end
    object RB_Nech: TRadioButton
      Left = 168
      Top = 40
      Width = 49
      Height = 15
      Caption = #1053#1077#1095
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = Changing
    end
    object RB_All: TRadioButton
      Left = 168
      Top = 12
      Width = 49
      Height = 15
      Caption = #1042#1089#1077
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      TabStop = True
      OnClick = Changing
    end
  end
  object gbYear: TGroupBox
    Left = 4
    Top = 46
    Width = 172
    Height = 62
    Caption = ' '#1055#1077#1088#1080#1086#1076' ('#1075#1086#1076#1072') '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 9
      Top = 28
      Width = 9
      Height = 16
      Caption = 'c'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 84
      Top = 28
      Width = 19
      Height = 16
      Caption = #1087#1086
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object seYear1: TSpinEdit
      Left = 23
      Top = 24
      Width = 50
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 2100
      MinValue = 1992
      ParentFont = False
      TabOrder = 0
      Value = 2000
      OnChange = Changing
      OnEnter = seYear1Enter
      OnExit = seYear1Exit
    end
    object seYear2: TSpinEdit
      Left = 110
      Top = 24
      Width = 51
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      MaxValue = 2100
      MinValue = 1992
      ParentFont = False
      TabOrder = 1
      Value = 1999
      OnChange = Changing
      OnEnter = seYear2Enter
      OnExit = seYear2Exit
    end
  end
  object btDiagram: TBitBtn
    Left = 221
    Top = 184
    Width = 79
    Height = 20
    Caption = #1043#1088#1072#1092#1080#1082
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btDiagramClick
  end
  object gbGraph: TGroupBox
    Tag = 1
    Left = 181
    Top = 107
    Width = 221
    Height = 64
    Caption = ' '#1042#1080#1076' '#1075#1088#1072#1092#1080#1082#1072' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 3
    object rbMatrix: TRadioButton
      Tag = 2
      Left = 7
      Top = 31
      Width = 134
      Height = 15
      Caption = #1075#1086#1076#1086#1074#1072#1103' '#1084#1072#1090#1088#1080#1094#1072' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = rbGraphClick
      OnEnter = rbMatrixEnter
      OnExit = rbMatrixExit
    end
    object rbAdd: TRadioButton
      Tag = 3
      Left = 7
      Top = 46
      Width = 163
      Height = 15
      Caption = #1089#1091#1084#1084#1080#1088#1091#1102#1097#1072#1103' '
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = rbGraphClick
      OnEnter = rbAddEnter
      OnExit = rbAddExit
    end
    object rbDinam: TRadioButton
      Tag = 1
      Left = 7
      Top = 16
      Width = 146
      Height = 15
      Caption = #1075#1086#1076#1086#1074#1072#1103' '#1076#1080#1085#1072#1084#1080#1082#1072' '
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rbGraphClick
      OnEnter = rbDinamEnter
      OnExit = rbDinamExit
    end
  end
  object gbCrash: TGroupBox
    Tag = 1
    Left = 4
    Top = 107
    Width = 172
    Height = 64
    Caption = ' '#1042#1080#1076' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103' '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    object cbTypeCrash1: TCheckBox
      Left = 11
      Top = 21
      Width = 143
      Height = 15
      Caption = #1052#1072#1075#1080#1089#1090#1088#1072#1083#1100
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = Changing
      OnEnter = cbTypeCrash1Enter
      OnExit = cbTypeCrash1Exit
    end
    object cbTypeCrash2: TCheckBox
      Tag = 2
      Left = 11
      Top = 42
      Width = 143
      Height = 15
      Caption = #1042#1074#1086#1076
      Checked = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = Changing
      OnEnter = cbTypeCrash2Enter
      OnExit = cbTypeCrash2Exit
    end
  end
  object BitBtn1: TBitBtn
    Left = 325
    Top = 183
    Width = 66
    Height = 22
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object DBL_ul1: TRxDBLookupCombo
    Left = 5
    Top = 19
    Width = 394
    Height = 29
    DropDownCount = 8
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    LookupField = 'NAME'
    LookupDisplay = 'NAME'
    LookupSource = DS_ul1
    ParentFont = False
    TabOrder = 6
    OnChange = DBL_ul1Change
    OnKeyDown = DBL_ul1KeyDown
    OnKeyUp = DBL_ul1KeyUp
  end
  object DiamCB: TRxDBLookupCombo
    Left = 104
    Top = 179
    Width = 83
    Height = 29
    DropDownCount = 8
    EmptyValue = '-1'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    IndexSwitch = False
    LookupField = 'ID'
    LookupDisplay = 'REALDIAMETER'
    LookupSource = ds_diam
    ParentFont = False
    TabOrder = 7
    OnChange = DiamCBChange
  end
  object DS_ul1: TDataSource
    DataSet = dset_ul1
    Left = 72
    Top = 192
  end
  object ds_diam: TDataSource
    DataSet = dset_diam
    Left = 168
    Top = 192
  end
  object dset_ul1: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select * from get_all_streets')
    Left = 32
    Top = 192
  end
  object dset_orders: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 301
    Top = 115
  end
  object dset_diam: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      
        'select a.id, (select strval from tochar(a.diameter))  as realdia' +
        'meter from'
      's_tubediameter a  where a.activity is null order by a.diameter')
    Left = 200
    Top = 192
  end
end
