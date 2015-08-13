object frm_SelectItem: Tfrm_SelectItem
  Left = 284
  Top = 323
  BorderStyle = bsDialog
  Caption = 'frm_SelectItem'
  ClientHeight = 330
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object chlb_Items: TCheckListBox
    Left = 4
    Top = 26
    Width = 237
    Height = 231
    ItemHeight = 13
    TabOrder = 0
  end
  object btn_Ok: TBitBtn
    Left = 32
    Top = 264
    Width = 105
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    TabOrder = 1
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
  object btn_exit: TBitBtn
    Left = 144
    Top = 264
    Width = 97
    Height = 25
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
  object RxDBLookupCombo1: TRxDBLookupCombo
    Left = 4
    Top = 3
    Width = 237
    Height = 21
    DropDownCount = 8
    LookupField = 'ItemName'
    LookupDisplay = 'ItemName'
    LookupSource = ds_Items
    TabOrder = 3
    OnChange = RxDBLookupCombo1Change
  end
  object Cheked_all: TBitBtn
    Left = 32
    Top = 296
    Width = 106
    Height = 25
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 4
    OnClick = Cheked_allClick
  end
  object cansel_all: TBitBtn
    Left = 144
    Top = 296
    Width = 97
    Height = 25
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 5
    OnClick = cansel_allClick
  end
  object dset_Items: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Items
    Left = 280
    Top = 48
  end
  object ds_Items: TDataSource
    DataSet = dset_Items
    Left = 280
    Top = 88
  end
  object tran_Items: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 280
    Top = 144
  end
end
