inherited frm_WorksRegions: Tfrm_WorksRegions
  Left = 567
  Top = 372
  Width = 546
  Height = 252
  Caption = #1056#1072#1073#1086#1090#1072' '#1056#1072#1081#1086#1085#1072
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 505
    Height = 81
    Caption = #1053#1072#1095#1072#1083#1086' '#1056#1072#1073#1086#1090#1099
    TabOrder = 0
    object Label1: TLabel
      Left = 69
      Top = 56
      Width = 45
      Height = 13
      Caption = #1052#1072#1089#1090#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbt_name_user: TDBText
      Left = 213
      Top = 20
      Width = 132
      Height = 17
      DataField = 'FK_NAME_USER'
      DataSource = ds_main
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rdbl_Brig: TRxDBLookupCombo
      Left = 135
      Top = 51
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_ID_BRIG'
      DataSource = ds_main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Brig
      TabOrder = 3
      OnChange = rdbl_BrigChange
    end
    object dte_start: TDBDateTimeEditEh
      Left = 135
      Top = 19
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'STARTDATE'
      DataSource = ds_main
      EditButton.Visible = False
      Kind = dtkTimeEh
      ReadOnly = True
      TabOrder = 0
    end
    object de_sart: TDBDateEdit
      Left = 7
      Top = 19
      Width = 121
      Height = 21
      TabStop = False
      DataField = 'STARTDATE'
      DataSource = ds_main
      ReadOnly = True
      NumGlyphs = 2
      TabOrder = 1
    end
    object btn_Start: TButton
      Left = 373
      Top = 19
      Width = 124
      Height = 21
      Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_StartClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 104
    Width = 505
    Height = 57
    Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077
    TabOrder = 1
    object DBT_FK_name_CLOSEDUSED: TDBText
      Left = 214
      Top = 21
      Width = 147
      Height = 17
      DataField = 'FK_NAME_CLOSEDUSED'
      DataSource = ds_main
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object de_end: TDBDateEdit
      Left = 8
      Top = 20
      Width = 121
      Height = 21
      TabStop = False
      DataField = 'ENDDATE'
      DataSource = ds_main
      ReadOnly = True
      NumGlyphs = 2
      TabOrder = 0
    end
    object dte_end: TDBDateTimeEditEh
      Left = 136
      Top = 20
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'ENDDATE'
      DataSource = ds_main
      EditButton.Visible = False
      Kind = dtkTimeEh
      ReadOnly = True
      TabOrder = 1
    end
    object btn_End: TButton
      Left = 376
      Top = 16
      Width = 121
      Height = 21
      Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_EndClick
    end
  end
  object btn_Cansel: TBitBtn
    Left = 192
    Top = 168
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btn_CanselClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btn_Save: TBitBtn
    Left = 104
    Top = 168
    Width = 81
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btn_SaveClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object btn_Exit: TBitBtn
    Left = 288
    Top = 168
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btn_ExitClick
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 199
    Width = 538
    Height = 19
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Panels = <>
    ParentShowHint = False
    ShowHint = False
    SimplePanel = True
    UseSystemFont = False
  end
  object ds_Brig: TDataSource
    DataSet = dm_WorkRegion.dset_Brig
    Left = 296
    Top = 56
  end
  object ds_main: TDataSource
    DataSet = dm_WorkRegion.dset_Main
    Left = 384
    Top = 168
  end
end
