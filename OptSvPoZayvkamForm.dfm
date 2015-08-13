inherited frm_OptSvPoZayvkam: Tfrm_OptSvPoZayvkam
  Left = 405
  Top = 304
  BorderStyle = bsDialog
  Caption = 'frm_OptSvPoZayvkam'
  ClientHeight = 219
  ClientWidth = 482
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 4
    Top = 59
    Width = 469
    Height = 29
  end
  object Bevel1: TBevel
    Left = 4
    Top = 5
    Width = 469
    Height = 49
  end
  object lbl_DateType: TLabel
    Left = 9
    Top = 8
    Width = 76
    Height = 13
    Caption = 'lbl_DateType'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object LZayv: TLabel
    Left = 10
    Top = 66
    Width = 37
    Height = 13
    Caption = #1047#1072#1103#1074#1082#1080
  end
  object Label2: TLabel
    Left = 16
    Top = 96
    Width = 37
    Height = 13
    Caption = #1056#1072#1081#1086#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btn_ok: TBitBtn
    Left = 8
    Top = 176
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 2
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
    Left = 120
    Top = 176
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
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
  inline frame_SelDateTime: Tframe_SelDateTimePeriod
    Left = 7
    Top = 23
    Width = 352
    Height = 25
    TabOrder = 0
    inherited Label1: TLabel
      Width = 6
      Caption = #1089
    end
  end
  object cb_zayv: TComboBox
    Left = 56
    Top = 64
    Width = 185
    Height = 21
    DropDownCount = 9
    ItemHeight = 13
    TabOrder = 1
    Text = #1042#1089#1077
    OnChange = cb_zayvChange
    Items.Strings = (
      #1042#1089#1077
      #1053#1077' '#1087#1088#1080#1074#1103#1079#1072#1085#1085#1099#1077
      #1055#1088#1080#1074#1103#1079#1072#1085#1085#1099#1077
      #1053#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077
      #1053#1077' '#1074#1099#1087' '#1087#1086' '#1073#1083#1072#1075'.'
      #1042#1099#1087#1086#1083#1085#1077#1085'. '#1087#1086' '#1073#1083#1072#1075'.'
      #1053#1077' '#1074#1099#1087' '#1072#1074#1072#1088' '#1087#1086' '#1073#1083#1072#1075
      #1053#1091#1078#1085#1086' '#1074#1077#1088#1085#1091#1090#1100' '#1080#1079' '#1082#1072#1087'-'#1088#1077#1084#1086#1085#1090)
  end
  object Panel1: TPanel
    Left = 248
    Top = 62
    Width = 217
    Height = 25
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 40
      Height = 13
      Caption = #1053#1072#1088#1103#1076#1099
    end
    object cb_OrderType: TComboBox
      Left = 55
      Top = 1
      Width = 162
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 0
      Text = #1047#1072#1082#1088#1099#1090#1099#1077
      OnChange = cb_OrderTypeChange
      Items.Strings = (
        #1042#1089#1077
        #1054#1090#1082#1088#1099#1090#1099#1077
        #1047#1072#1082#1088#1099#1090#1099#1077)
    end
  end
  object RxDBL_region: TRxDBLookupCombo
    Left = 58
    Top = 92
    Width = 167
    Height = 21
    DropDownCount = 8
    LookupField = 'ID'
    LookupDisplay = 'NAME'
    LookupSource = ds_region
    TabOrder = 5
  end
  object rg_sort: TRadioGroup
    Left = 8
    Top = 120
    Width = 273
    Height = 49
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1055#1086' '#1076#1072#1090#1077' '#1087#1086#1083#1091#1095#1077#1085#1080#1103
      #1055#1086' '#1072#1076#1088#1077#1089#1091)
    TabOrder = 6
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, iif(id<0,'#39#1042#1089#1077#39',name) name from s_regions')
    Left = 288
    Top = 88
    object dset_regionID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_regionNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 248
    Top = 88
  end
  object ds_region: TDataSource
    DataSet = dset_region
    Left = 184
    Top = 88
  end
end
