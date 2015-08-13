object frm_UniversalSearch_vds: Tfrm_UniversalSearch_vds
  Left = 325
  Top = 324
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1087#1086#1080#1089#1082' '#1085#1072#1088#1103#1076#1086#1074
  ClientHeight = 370
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 40
    Width = 505
    Height = 33
  end
  object Label1: TLabel
    Left = 21
    Top = 11
    Width = 59
    Height = 13
    Caption = #8470' '#1085#1072#1088#1103#1076#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_DateComing1: TLabel
    Left = 21
    Top = 48
    Width = 136
    Height = 13
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#1079#1072' '#1087#1077#1088#1080#1086#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_DateComing2: TLabel
    Left = 321
    Top = 49
    Width = 15
    Height = 13
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 172
    Top = 9
    Width = 47
    Height = 13
    Caption = #1053#1072#1088#1103#1076#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_SONum: TLabel
    Left = 360
    Top = 8
    Width = 76
    Height = 26
    Alignment = taCenter
    Caption = #1053#1086#1084#1077#1088' '#13#10#1079#1072#1103#1074#1082#1080'(0-62)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sp_NumOrder: TSpinEdit
    Left = 85
    Top = 7
    Width = 79
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object dp_Coming1: TDateEdit
    Left = 157
    Top = 45
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 2
    OnChange = dp_Coming1Change
  end
  object dp_Coming2: TDateEdit
    Left = 341
    Top = 45
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 3
    OnChange = dp_Coming2Change
  end
  object btn_Officials: TBitBtn
    Left = 19
    Top = 81
    Width = 200
    Height = 25
    Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088' '#1087#1088#1080#1085#1103#1074#1096#1080#1081' '#1079#1072#1103#1074#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_OfficialsClick
  end
  object btn_MessageType: TBitBtn
    Left = 391
    Top = 80
    Width = 185
    Height = 25
    Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btn_MessageTypeClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 111
    Width = 573
    Height = 81
    Caption = #1040#1076#1088#1077#1089
    TabOrder = 6
    object Label4: TLabel
      Left = 8
      Top = 19
      Width = 38
      Height = 13
      Caption = #1059#1083#1080#1094#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 42
      Width = 40
      Height = 26
      Caption = #1053#1086#1084#1077#1088#13#10#1076#1086#1084#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 123
      Top = 41
      Width = 27
      Height = 26
      Alignment = taCenter
      Caption = #1050#1086#1088'-'#13#10#1087#1091#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 212
      Top = 41
      Width = 36
      Height = 26
      Alignment = taCenter
      Caption = #1055#1086#1076#1098'-'#13#10#1077#1079#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 313
      Top = 48
      Width = 31
      Height = 13
      Caption = #1069#1090#1072#1078
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 416
      Top = 40
      Width = 34
      Height = 26
      Caption = #1050#1074#1072#1088'-'#13#10#1090#1080#1088#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Street: TRxDBLookupCombo
      Left = 48
      Top = 16
      Width = 161
      Height = 21
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_Street
      TabOrder = 0
    end
    object ed_HouseNum: TEdit
      Left = 51
      Top = 44
      Width = 57
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object ed_HousingNum: TEdit
      Left = 150
      Top = 44
      Width = 54
      Height = 21
      MaxLength = 10
      TabOrder = 2
    end
    object ed_PorchNum: TEdit
      Left = 249
      Top = 44
      Width = 57
      Height = 21
      MaxLength = 10
      TabOrder = 3
    end
    object ed_FloorNum: TEdit
      Left = 345
      Top = 44
      Width = 57
      Height = 21
      MaxLength = 10
      TabOrder = 4
    end
    object ed_ApartmentNum: TEdit
      Left = 448
      Top = 43
      Width = 49
      Height = 21
      MaxLength = 10
      TabOrder = 5
    end
  end
  object cb_OrderType: TComboBox
    Left = 216
    Top = 7
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = #1042#1057#1045
    Items.Strings = (
      #1042#1057#1045
      #1053#1045#1047#1040#1050#1056#1067#1058#1067#1045
      #1047#1040#1050#1056#1067#1058#1067#1045
      #1054#1058#1050#1051#1070#1063#1045#1053#1048#1071)
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 198
    Width = 572
    Height = 90
    TabOrder = 7
    object Label11: TLabel
      Left = 48
      Top = 58
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103#13#10#1088#1072#1073#1086#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 345
      Top = 64
      Width = 15
      Height = 13
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btn_DamageType: TBitBtn
      Left = 264
      Top = 15
      Width = 113
      Height = 33
      Caption = #1042#1080#1076' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_DamageTypeClick
    end
    object dp_Closed1: TDateEdit
      Left = 160
      Top = 61
      Width = 97
      Height = 21
      NumGlyphs = 2
      TabOrder = 3
    end
    object dp_Closed2: TDateEdit
      Left = 382
      Top = 60
      Width = 97
      Height = 21
      NumGlyphs = 2
      TabOrder = 4
    end
    object btn_Brigadiers: TButton
      Left = 121
      Top = 15
      Width = 140
      Height = 33
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      WordWrap = True
      OnClick = btn_BrigadiersClick
    end
    object tp_Closed1: TMaskEdit
      Left = 257
      Top = 61
      Width = 47
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 5
      Text = '  :  '
    end
    object tp_Closed2: TMaskEdit
      Left = 479
      Top = 61
      Width = 46
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 6
      Text = '  :  '
    end
    object btn_DispCLose: TButton
      Left = 6
      Top = 15
      Width = 113
      Height = 33
      Caption = #1044#1080#1087#1077#1090#1095#1077#1088' '#1079#1072#1082#1088'. '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
      OnClick = btn_DispCLoseClick
    end
    object Button1: TButton
      Left = 380
      Top = 15
      Width = 92
      Height = 33
      Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1082#1086#1085#1090#1088#1086#1083#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      WordWrap = True
      OnClick = btn_BrigadiersClick
    end
    object Button2: TButton
      Left = 475
      Top = 14
      Width = 86
      Height = 33
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088' '#1079#1072#1082#1088'. '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      WordWrap = True
      OnClick = Button2Click
    end
  end
  object btn_ok: TBitBtn
    Left = 16
    Top = 335
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btn_okClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
      300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
      330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
      333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
      339977FF777777773377000BFB03333333337773FF733333333F333000333333
      3300333777333333337733333333333333003333333333333377333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object btn_cancel: TBitBtn
    Left = 504
    Top = 335
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btn_cancelClick
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
  object tp_Coming1: TMaskEdit
    Left = 255
    Top = 45
    Width = 47
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 10
    Text = '  :  '
    OnChange = dp_Coming1Change
  end
  object tp_Coming2: TMaskEdit
    Left = 441
    Top = 45
    Width = 46
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 11
    Text = '  :  '
    OnClick = dp_Coming2Change
  end
  object btn_Region: TBitBtn
    Left = 232
    Top = 80
    Width = 121
    Height = 25
    Caption = #1056#1072#1081#1086#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = btn_RegionClick
  end
  object sp_NumSO: TSpinEdit
    Left = 448
    Top = 11
    Width = 106
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 13
    Value = 0
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 288
    Width = 572
    Height = 45
    Caption = #1056#1072#1073#1086#1090#1099' '#1088#1072#1081#1086#1085#1072
    TabOrder = 14
    object cb_workRegion: TComboBox
      Left = 8
      Top = 16
      Width = 89
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #1042#1089#1077
      OnChange = cb_workRegionChange
      Items.Strings = (
        #1042#1089#1077
        #1053#1077' '#1074' '#1088#1072#1073#1086#1090#1077
        #1042' '#1088#1072#1073#1086#1090#1077
        #1042#1099#1087#1086#1083#1085#1077#1085#1085#1086)
    end
    object btn_brig: TBitBtn
      Left = 465
      Top = 12
      Width = 88
      Height = 25
      Caption = #1052#1072#1089#1090#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_brigClick
    end
  end
  object Tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 280
    Top = 119
  end
  object dset_Street: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name'
      'from s_streets s'
      'where s.activity is null'
      'order by name')
    Left = 240
    Top = 119
  end
  object ds_Street: TDataSource
    DataSet = dset_Street
    Left = 312
    Top = 119
  end
end
