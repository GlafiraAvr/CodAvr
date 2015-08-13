object frm_EditWork: Tfrm_EditWork
  Left = 676
  Top = 463
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1072
  ClientHeight = 252
  ClientWidth = 311
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
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 311
    Height = 217
    Align = alTop
  end
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 55
    Height = 13
    Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1072
  end
  object Label4: TLabel
    Left = 4
    Top = 167
    Width = 75
    Height = 13
    Alignment = taCenter
    Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099':'
  end
  object dbt_Info: TDBText
    Left = 80
    Top = 167
    Width = 225
    Height = 17
    DataField = 'clcWT_INFO'
    DataSource = ds_Work
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 10
    Top = 132
    Width = 64
    Height = 26
    Alignment = taCenter
    Caption = #1044#1086#1087'. '#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object btn_ok: TBitBtn
    Left = 136
    Top = 221
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 0
    OnClick = btn_okClick
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
  object btn_exit: TBitBtn
    Left = 224
    Top = 221
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btn_exitClick
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
  object dbl_work: TRxDBLookupCombo
    Left = 80
    Top = 6
    Width = 228
    Height = 21
    DropDownCount = 8
    DataField = 'FK_DEPWORKS_WORK'
    DataSource = ds_Work
    LookupField = 'ID'
    LookupDisplay = 'NAME'
    LookupSource = ds_WorkAtt
    TabOrder = 1
    OnChange = dbl_workChange
    OnCloseUp = dbl_workCloseUp
    OnDropDown = dbl_workDropDown
    OnContextPopup = dbl_workContextPopup
  end
  object ed_AddInfo: TDBEdit
    Left = 78
    Top = 137
    Width = 226
    Height = 21
    DataField = 'ADDITIONALINFO'
    DataSource = ds_Work
    TabOrder = 3
  end
  object pnl_Exc: TPanel
    Left = 8
    Top = 27
    Width = 289
    Height = 102
    BevelOuter = bvNone
    TabOrder = 4
    object Label6: TLabel
      Left = 15
      Top = 7
      Width = 33
      Height = 13
      Caption = #1044#1083#1080#1085#1072
    end
    object Label7: TLabel
      Left = 9
      Top = 30
      Width = 39
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object Label8: TLabel
      Left = 7
      Top = 54
      Width = 41
      Height = 13
      Caption = #1043#1083#1091#1073#1080#1085#1072
    end
    object Label9: TLabel
      Left = 7
      Top = 78
      Width = 73
      Height = 13
      Caption = #1055#1083#1086#1097#1072#1076#1100' '#1072#1089#1092'.'
    end
    object ed_Width: TDBEdit
      Left = 84
      Top = 28
      Width = 85
      Height = 21
      DataField = 'EXC_WIDTH'
      DataSource = ds_Work
      TabOrder = 1
    end
    object ed_Depth: TDBEdit
      Left = 84
      Top = 52
      Width = 85
      Height = 21
      DataField = 'EXC_DEPTH'
      DataSource = ds_Work
      TabOrder = 2
    end
    object ed_Length: TDBEdit
      Left = 84
      Top = 4
      Width = 85
      Height = 21
      DataField = 'EXC_LENGTH'
      DataSource = ds_Work
      TabOrder = 0
    end
    object ed_SQIARE_ASF: TDBEdit
      Left = 84
      Top = 76
      Width = 85
      Height = 21
      DataField = 'SQUARE_ASF'
      DataSource = ds_Work
      TabOrder = 3
    end
  end
  object pnl_Other: TPanel
    Left = 14
    Top = 27
    Width = 186
    Height = 49
    BevelOuter = bvNone
    TabOrder = 5
    object Label2: TLabel
      Left = 13
      Top = 4
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object Label3: TLabel
      Left = 2
      Top = 28
      Width = 59
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object dbl_diam: TRxDBLookupCombo
      Left = 65
      Top = 2
      Width = 117
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPWORKS_DIAMETER'
      DataSource = ds_Work
      LookupField = 'ID'
      LookupDisplay = 'DIAMETER'
      LookupSource = ds_DiamAtt
      TabOrder = 0
    end
    object ed_quantity: TDBEdit
      Left = 64
      Top = 26
      Width = 118
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Work
      TabOrder = 1
    end
  end
  object DBCheckBox1: TDBCheckBox
    Left = 8
    Top = 192
    Width = 121
    Height = 17
    Alignment = taLeftJustify
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074' 1562'
    DataField = 'Sent_1562'
    DataSource = ds_Work
    TabOrder = 6
    ValueChecked = '1'
    ValueUnchecked = '0'
    Visible = False
  end
  object ds_WorkAtt: TDataSource
    DataSet = dm_DepPlanWorMat.dset_works
    Left = 224
    Top = 8
  end
  object ds_DiamAtt: TDataSource
    DataSet = dm_DepPlanWorMat.mt_diametr
    Left = 240
    Top = 48
  end
  object ds_Work: TDataSource
    Left = 280
    Top = 32
  end
end
