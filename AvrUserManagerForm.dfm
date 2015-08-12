object frm_AvrUserManager: Tfrm_AvrUserManager
  Left = 369
  Top = 290
  BorderStyle = bsDialog
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 354
  ClientWidth = 519
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Btns: TPanel
    Left = 0
    Top = 313
    Width = 519
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object btn_Apply: TBitBtn
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_ApplyClick
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
    object btn_Exit: TBitBtn
      Left = 423
      Top = 8
      Width = 89
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 313
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object Bevel2: TBevel
      Left = 214
      Top = 8
      Width = 299
      Height = 299
    end
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 201
      Height = 298
    end
    object Label1: TLabel
      Left = 16
      Top = 63
      Width = 86
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 224
      Top = 14
      Width = 38
      Height = 13
      Caption = #1055#1088#1072#1074#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 16
      Width = 44
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lb_Users: TListBox
      Left = 14
      Top = 78
      Width = 187
      Height = 221
      ItemHeight = 13
      PopupMenu = pm_Users
      TabOrder = 0
      OnClick = lb_UsersClick
    end
    object chlb_Rights: TCheckListBox
      Left = 221
      Top = 28
      Width = 285
      Height = 273
      OnClickCheck = chlb_RightsClickCheck
      ItemHeight = 13
      PopupMenu = pm_Rights
      TabOrder = 1
    end
    object dbl_Groups: TRxDBLookupCombo
      Left = 16
      Top = 32
      Width = 185
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Groups
      TabOrder = 2
      OnChange = dbl_GroupsChange
    end
  end
  object dset: TIBDataSet
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_sel
    Left = 448
    Top = 32
  end
  object tran_sel: TIBTransaction
    Active = True
    DefaultDatabase = dm_AvrUserManager.IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 448
    Top = 64
  end
  object pm_Users: TPopupMenu
    Left = 72
    Top = 176
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnClick = N2Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Caption = #1047#1072#1076#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
      OnClick = N6Click
    end
  end
  object dset2: TIBDataSet
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_sel
    Left = 448
    Top = 8
  end
  object tran_exec: TIBTransaction
    DefaultDatabase = dm_AvrUserManager.IBDB
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 464
    Top = 232
  end
  object IBSQL: TIBSQL
    Database = dm_AvrUserManager.IBDB
    Transaction = tran_exec
    Left = 512
    Top = 232
  end
  object pm_Rights: TPopupMenu
    Left = 248
    Top = 176
    object N3: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
      OnClick = N4Click
    end
  end
  object ds_Groups: TDataSource
    DataSet = dset_Groups
    Left = 256
    Top = 104
  end
  object dset_Groups: TRxMemoryData
    FieldDefs = <>
    Left = 256
    Top = 64
    object dset_Groupsid: TIntegerField
      FieldName = 'id'
    end
    object dset_Groupsname: TStringField
      FieldName = 'name'
      Size = 30
    end
  end
end
