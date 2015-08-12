object frm_AddWork: Tfrm_AddWork
  Left = 845
  Top = 315
  Width = 289
  Height = 277
  Caption = #1056#1072#1073#1086#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 11
    Width = 36
    Height = 13
    Caption = #1056#1072#1073#1086#1090#1072
  end
  object Label7: TLabel
    Left = 8
    Top = 176
    Width = 89
    Height = 26
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#13#10' '#1080#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object dbl_work: TRxDBLookupCombo
    Left = 72
    Top = 8
    Width = 193
    Height = 25
    DropDownCount = 8
    DataField = 'FK_DEPWORKS_WORK'
    DataSource = ds_main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_work
    TabOrder = 0
    OnChange = dbl_workChange
    OnCloseUp = dbl_workCloseUp
    OnDropDown = dbl_workDropDown
    OnKeyDown = FormKeyDown
    OnContextPopup = dbl_workContextPopup
  end
  object pn_Exc: TPanel
    Left = 0
    Top = 40
    Width = 257
    Height = 65
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object Label3: TLabel
      Left = 14
      Top = 36
      Width = 34
      Height = 13
      Caption = #1050#1086#1083'-'#1074#1086
    end
    object db_Quntity: TDBNumberEditEh
      Left = 72
      Top = 32
      Width = 121
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_main
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
    object dbL_diam: TRxDBLookupCombo
      Left = 72
      Top = 0
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'IDDIAM'
      DataSource = ds_main
      LookupField = 'id'
      LookupDisplay = 'diameter'
      LookupSource = ds_diam
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
  end
  object pn_Other: TPanel
    Left = 8
    Top = 40
    Width = 257
    Height = 129
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 13
      Caption = #1044#1083#1080#1085#1085#1072
    end
    object Label5: TLabel
      Left = 8
      Top = 40
      Width = 39
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object Label6: TLabel
      Left = 8
      Top = 72
      Width = 41
      Height = 13
      Caption = #1043#1083#1091#1073#1080#1085#1072
    end
    object Label8: TLabel
      Left = 8
      Top = 104
      Width = 49
      Height = 26
      Caption = #1055#1083#1086#1097#1072#1076#1100#13#10#1072#1089#1092#1072#1083#1100#1090#1072
    end
    object db_Lengt: TDBEdit
      Left = 72
      Top = 8
      Width = 121
      Height = 21
      DataField = 'EXC_LENGTH'
      DataSource = ds_main
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
    object dbe_Width: TDBEdit
      Left = 72
      Top = 40
      Width = 121
      Height = 21
      DataField = 'EXC_WIDTH'
      DataSource = ds_main
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
    object dbe_Depth: TDBEdit
      Left = 72
      Top = 72
      Width = 121
      Height = 21
      DataField = 'EXC_DEPTH'
      DataSource = ds_main
      TabOrder = 2
      OnKeyDown = FormKeyDown
    end
    object dbe_asf: TDBEdit
      Left = 72
      Top = 104
      Width = 121
      Height = 21
      DataField = 'SQUARE_ASF'
      DataSource = ds_main
      TabOrder = 3
      OnKeyDown = FormKeyDown
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 216
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 4
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 184
    Top = 216
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object dbe_additionalInfo: TDBEdit
    Left = 88
    Top = 176
    Width = 169
    Height = 21
    DataField = 'ADDITIONALINFO'
    DataSource = ds_main
    TabOrder = 2
    OnKeyDown = FormKeyDown
  end
  object ds_main: TDataSource
    DataSet = dm_DepPlanWorMat.dset_works
    Left = 224
    Top = 152
  end
  object ds_work: TDataSource
    DataSet = dm_DepPlanWorMat.mt_works
    Left = 248
    Top = 16
  end
  object ds_diam: TDataSource
    DataSet = dm_DepPlanWorMat.mt_diametr
    Left = 216
    Top = 40
  end
end
