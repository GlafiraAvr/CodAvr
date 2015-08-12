object frm_AdresDep: Tfrm_AdresDep
  Left = 849
  Top = 528
  Width = 368
  Height = 272
  Caption = #1040#1076#1088#1077#1089
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Street2: TLabel
    Left = 19
    Top = 75
    Width = 12
    Height = 13
    Caption = #1089' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbl_Housenum: TLabel
    Left = 8
    Top = 71
    Width = 31
    Height = 26
    Alignment = taCenter
    Caption = #8470' '#13#10#1076#1086#1084#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label20: TLabel
    Left = 11
    Top = 20
    Width = 38
    Height = 13
    Caption = #1059#1083#1080#1094#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 5
    Top = 108
    Width = 68
    Height = 13
    Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 7
    Top = 128
    Width = 42
    Height = 26
    Caption = #1052#1077#1089#1090#1085'. '#1087#1086#1074#1088'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object dbl_Street2: TRxDBLookupCombo
    Tag = 11111
    Left = 98
    Top = 73
    Width = 201
    Height = 23
    DropDownCount = 8
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    LookupField = 'id'
    LookupDisplay = 'NAME'
    LookupSource = ds_street_2
    ParentFont = False
    TabOrder = 2
  end
  object dbl_Street: TRxDBLookupCombo
    Left = 97
    Top = 18
    Width = 222
    Height = 23
    DropDownCount = 8
    DataField = 'FK_DEPARURE_ID_STREET'
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    LookupField = 'id'
    LookupDisplay = 'NAME'
    LookupSource = ds_street
    ParentFont = False
    TabOrder = 0
  end
  object btn_Cancel: TBitBtn
    Left = 24
    Top = 168
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Kind = bkCancel
  end
  object btn_Ok: TBitBtn
    Left = 216
    Top = 168
    Width = 89
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btn_OkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object dbl_DamageLocality: TRxDBLookupCombo
    Left = 97
    Top = 132
    Width = 208
    Height = 23
    DropDownCount = 8
    DataField = 'fk_departures_DamageLocality'
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_locality
    ParentFont = False
    TabOrder = 4
  end
  object dbe_dopadress: TDBEdit
    Left = 97
    Top = 104
    Width = 193
    Height = 21
    DataField = 'ADDADRES'
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object dbe_houseNum: TDBEdit
    Left = 97
    Top = 73
    Width = 153
    Height = 21
    DataField = 'housenum'
    DataSource = ds_main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 215
    Width = 352
    Height = 19
    Panels = <>
  end
  object cb_housetype: TComboBox
    Left = 96
    Top = 48
    Width = 145
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    TabOrder = 8
    OnChange = cb_housetypeChange
    Items.Strings = (
      #1059#1083#1080#1094#1072', '#8470' '#1076#1086#1084#1072
      #1055#1077#1088#1077#1089#1077#1095#1077#1085#1080#1077' '#1091#1083#1080#1094
      #1052#1077#1089#1090#1085#1086#1089#1090#1100)
  end
  object ds_main: TDataSource
    DataSet = dm_NGDep.dset_Dep
    Left = 304
    Top = 48
  end
  object ds_street: TDataSource
    DataSet = dm_NGDep.mem_streets
    Left = 264
    Top = 24
  end
  object ds_street_2: TDataSource
    DataSet = dm_NGDep.mem_street_2
    Left = 304
    Top = 112
  end
  object ds_locality: TDataSource
    Left = 248
    Top = 136
  end
end
