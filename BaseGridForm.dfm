inherited frm_BaseGrid: Tfrm_BaseGrid
  Left = 320
  Top = 293
  Width = 600
  Height = 387
  Caption = 'frm_BaseGrid'
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Top: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 217
    Align = alTop
    TabOrder = 0
    object pnl_Adres: TGroupBox
      Left = 8
      Top = 16
      Width = 545
      Height = 77
      Caption = '  '#1040#1076#1088#1077#1089'  '
      TabOrder = 0
      object lbl_HouseType: TLabel
        Left = 21
        Top = 24
        Width = 23
        Height = 13
        Caption = #1058#1080#1087
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_Street: TLabel
        Left = 8
        Top = 52
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
      object lbl_AddAdres: TLabel
        Left = 200
        Top = 22
        Width = 68
        Height = 13
        Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_HouseNum: TLabel
        Left = 241
        Top = 55
        Width = 74
        Height = 13
        Caption = #1053#1086#1084#1077#1088' '#1076#1086#1084#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_Street2: TLabel
        Left = 261
        Top = 55
        Width = 53
        Height = 13
        Caption = #1089' '#1091#1083#1080#1094#1077#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object dbl_HouseType: TRxDBLookupCombo
        Tag = 111
        Left = 48
        Top = 16
        Width = 137
        Height = 21
        DropDownCount = 8
        DataSource = ds_Main
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_HouseType
        ParentFont = False
        TabOrder = 1
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object dbl_Street: TRxDBLookupCombo
        Left = 48
        Top = 48
        Width = 189
        Height = 21
        DropDownCount = 8
        DataSource = ds_Main
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Street
        ParentFont = False
        TabOrder = 0
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object dbl_Street2: TRxDBLookupCombo
        Tag = 222
        Left = 320
        Top = 48
        Width = 218
        Height = 21
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Street2
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
      end
      object ed_AddAdres: TDBEdit
        Left = 273
        Top = 16
        Width = 264
        Height = 21
        DataSource = ds_Main
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnChange = CtrlsChange
        OnEnter = TextFieldEnter
        OnExit = EntryExit
      end
      object ed_HouseNum: TDBEdit
        Left = 323
        Top = 48
        Width = 121
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnChange = CtrlsChange
        OnEnter = TextFieldEnter
        OnExit = EntryExit
      end
    end
  end
  object pnl_Bottom: TPanel
    Left = 0
    Top = 298
    Width = 584
    Height = 32
    Align = alBottom
    TabOrder = 1
    object btn_Insert: TBitBtn
      Left = 6
      Top = 4
      Width = 85
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_InsertClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object btn_Delete: TBitBtn
      Left = 176
      Top = 4
      Width = 85
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_DeleteClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FFF7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEAEFCD6D6FDFFFFFFFFFFFF0101F4
        0101F40101F49898FBF1F1FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0101F4CDCDFDFFFFFFFFFFFF0101F40101F4C6C6FD0101F40101F40101F4CD
        CDFDFFFFFFFFFFFFFFFFFFFFFFFF0101F40101F4F9F9FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF0101F40101F40101F40101F4F3F3FEFFFFFF0101F40101
        F49595FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01
        01F40101F45454F80101F40101F4C8C8FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0101F40101F40101F41A1AF5F4F4FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FFA7A7FB0101F401
        01F46A6AF90101F40101F44646F7E8E8FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF9595FA0101F40101F40101F4FFFFFFFFFFFFFCFCFF0101F46666
        F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E9EFB0101F40101F40101F4FF
        FFFFFFFFFFFFFFFFFFFFFF0101F45656F88D8DFAFFFFFFFFFFFFFFFFFFFFFFFF
        E9E9FE4040F70101F40101F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0101
        F43C3CF7EAEAFEFFFFFFFFFFFFFFFFFF8484FA0101F40101F4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0101F40101F45D5DF8E3E3FEFFFFFF0101F4
        0101F40101F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF0101F40101F4C6C6FDFFFFFF0101F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0101F4FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btn_Edit: TBitBtn
      Left = 91
      Top = 4
      Width = 85
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_EditClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_Post: TBitBtn
      Left = 312
      Top = 4
      Width = 85
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_PostClick
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
    object btn_Cancel: TBitBtn
      Left = 397
      Top = 4
      Width = 85
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btn_CancelClick
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
    object btn_Exit: TBitBtn
      Left = 482
      Top = 4
      Width = 85
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
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
  object dbg_Main: TDBGrid
    Left = 0
    Top = 217
    Width = 584
    Height = 81
    Align = alClient
    DataSource = ds_Main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object sb_ProcessStatus: TStatusBar
    Left = 0
    Top = 330
    Width = 584
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <>
    SimplePanel = True
    UseSystemFont = False
  end
  object Tr_main: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 184
    Top = 256
  end
  object Tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read'
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 120
  end
  object dset_HouseType: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from s_housetype'
      'order by id')
    OnFilterRecord = VocFilterRecord
    Left = 160
    Top = 112
  end
  object dset_Street: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name,'
      's.activity'
      'from s_streets s'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 208
    Top = 112
  end
  object dset_Street2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name,'
      's.activity'
      'from s_streets s'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 256
    Top = 112
  end
  object dset_main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_main
    AfterScroll = dset_mainAfterScroll
    Left = 88
    Top = 256
  end
  object ds_HouseType: TDataSource
    DataSet = dset_HouseType
    Left = 160
    Top = 136
  end
  object ds_Street: TDataSource
    DataSet = dset_Street
    Left = 208
    Top = 136
  end
  object ds_Street2: TDataSource
    DataSet = dset_Street2
    Left = 256
    Top = 136
  end
  object ds_Main: TDataSource
    DataSet = dset_main
    Left = 120
    Top = 256
  end
end
