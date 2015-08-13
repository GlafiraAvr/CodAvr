object frm_SearchOrderByNumber: Tfrm_SearchOrderByNumber
  Left = 534
  Top = 387
  ActiveControl = sp_OrderNumber
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1086#1084#1077#1088#1091
  ClientHeight = 137
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 257
    Height = 65
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 16
      Width = 90
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1085#1072#1088#1103#1076#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 67
      Top = 39
      Width = 26
      Height = 13
      Caption = #1043#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_District: TRxDBLookupCombo
      Left = 178
      Top = 11
      Width = 71
      Height = 22
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupDisplayIndex = 1
      LookupSource = ds_district
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
  end
  object sp_Year: TSpinEdit
    Left = 103
    Top = 77
    Width = 154
    Height = 22
    MaxLength = 6
    MaxValue = 999999
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnKeyDown = FormKeyDown
  end
  object sp_OrderNumber: TSpinEdit
    Left = 104
    Top = 51
    Width = 81
    Height = 22
    MaxLength = 6
    MaxValue = 999999
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnKeyDown = FormKeyDown
  end
  object btn_ok: TBitBtn
    Left = 9
    Top = 109
    Width = 75
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
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
  object btn_exit: TBitBtn
    Left = 169
    Top = 109
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
    OnClick = btn_exitClick
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
  object VDS_NS_Group: TRadioGroup
    Left = 8
    Top = 0
    Width = 257
    Height = 33
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1053#1057
      #1042#1044#1057)
    TabOrder = 5
    OnClick = VDS_NS_GroupClick
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 16
    Top = 72
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 64
    Top = 8
  end
  object dset_district: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select id, name'
      'from s_district_vds'
      'where id>0'
      'order by id')
    Left = 104
    Top = 56
  end
  object ds_district: TDataSource
    DataSet = dset_district
    Left = 144
    Top = 56
  end
end
