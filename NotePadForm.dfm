object frm_NotePad: Tfrm_NotePad
  Left = 407
  Top = 327
  Width = 437
  Height = 352
  Caption = #1041#1083#1086#1082#1085#1086#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object mem_Page: TDBMemo
    Left = 0
    Top = 0
    Width = 429
    Height = 284
    Align = alClient
    DataField = 'NOTEPAD'
    DataSource = ds_NotePad
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
  end
  object pnl: TPanel
    Left = 0
    Top = 284
    Width = 429
    Height = 41
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object sp_Now: TSpeedButton
      Left = 8
      Top = 11
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
        F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
        F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
        F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
        F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
        F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
        F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
        333337FFFFFFFF77333330000000000333333777777777733333}
      NumGlyphs = 2
      OnClick = sp_NowClick
    end
    object btn_exit: TBitBtn
      Left = 344
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 0
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
  end
  object dset_NotePad: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_NotePad
    InsertSQL.Strings = (
      'insert into servanttable(NotePad)'
      'values(:NotePad)')
    SelectSQL.Strings = (
      'select NotePad'
      'from servanttable')
    ModifySQL.Strings = (
      'update ServantTable set'
      'NotePad=:NotePad ')
    Left = 48
    Top = 88
    object dset_NotePadNOTEPAD: TMemoField
      FieldName = 'NOTEPAD'
      Origin = '"SERVANTTABLE"."NOTEPAD"'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 8
    end
  end
  object tran_NotePad: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 96
    Top = 88
  end
  object ds_NotePad: TDataSource
    DataSet = dset_NotePad
    Left = 160
    Top = 88
  end
end