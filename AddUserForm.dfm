object frm_AddUser: Tfrm_AddUser
  Left = 436
  Top = 291
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  ClientHeight = 159
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 7
    Top = 32
    Width = 292
    Height = 93
  end
  object Label1: TLabel
    Left = 47
    Top = 40
    Width = 26
    Height = 13
    Caption = #1048#1084#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 31
    Top = 67
    Width = 45
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 30
    Top = 88
    Width = 48
    Height = 26
    Caption = #1055#1086#1074#1090#1086#1088' '#13#10#1087#1072#1088#1086#1083#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 13
    Top = 8
    Width = 42
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ed_Name: TEdit
    Left = 78
    Top = 38
    Width = 218
    Height = 21
    MaxLength = 30
    TabOrder = 0
  end
  object dbl_Name: TRxDBLookupCombo
    Left = 79
    Top = 38
    Width = 212
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME'
    LookupSource = ds_Lookup
    TabOrder = 1
  end
  object btn_ok: TBitBtn
    Left = 128
    Top = 129
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
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
  object btn_cancel: TBitBtn
    Left = 214
    Top = 129
    Width = 83
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btn_cancelClick
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
  object ed_pwd: TEdit
    Left = 79
    Top = 64
    Width = 217
    Height = 21
    MaxLength = 10
    PasswordChar = '*'
    TabOrder = 2
  end
  object ed_ConfPwd: TEdit
    Left = 79
    Top = 92
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object dbl_Groups: TRxDBLookupCombo
    Left = 59
    Top = 6
    Width = 241
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME'
    LookupSource = ds_groups
    TabOrder = 6
    OnChange = dbl_GroupsChange
  end
  object dset_Lookup: TIBDataSet
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_sel
    SelectSQL.Strings = (
      'select id, name '
      'from s_Officials '
      'where activity is null '
      'order by name ')
    Left = 352
    Top = 8
  end
  object tran_sel: TIBTransaction
    DefaultDatabase = dm_AvrUserManager.IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 352
    Top = 40
  end
  object ds_Lookup: TDataSource
    DataSet = dset_Lookup
    Left = 376
    Top = 80
  end
  object IBSQL: TIBSQL
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_Exec
    Left = 384
    Top = 32
  end
  object tran_Exec: TIBTransaction
    DefaultDatabase = dm_AvrUserManager.IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 408
    Top = 112
  end
  object dset_tmp: TIBDataSet
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_sel
    Left = 315
    Top = 112
  end
  object dset_Groups: TIBDataSet
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_sel
    SelectSQL.Strings = (
      'select id, name, '
      'external_table, external_condition '
      'from sec_groups'
      'order by id')
    Left = 336
    Top = 168
  end
  object ds_groups: TDataSource
    DataSet = dset_Groups
    Left = 376
    Top = 168
  end
end
