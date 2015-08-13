object frm_DepWorkers: Tfrm_DepWorkers
  Left = 377
  Top = 233
  BorderStyle = bsDialog
  Caption = #1051#1102#1076#1080
  ClientHeight = 325
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frame: Tframe_Team
    Left = 0
    Top = 0
    Width = 333
    Height = 284
    Align = alClient
    TabOrder = 0
    inherited Bevel2: TBevel [0]
      Left = 195
      Top = 44
      Width = 131
      Height = 235
    end
    inherited Bevel1: TBevel [1]
      Left = 11
      Top = 45
      Width = 131
      Height = 233
    end
    inherited Label1: TLabel [2]
      Left = 9
      Top = 13
    end
    inherited Label2: TLabel [3]
      Left = 65
      Top = 48
    end
    inherited Label3: TLabel [4]
      Left = 234
      Top = 48
    end
    inherited dbl_Brig: TRxDBLookupCombo
      Left = 70
      Top = 10
      Width = 187
    end
    inherited lb_Src: TListBox
      Left = 16
      Top = 64
      Width = 121
    end
    inherited lb_Des: TListBox
      Left = 200
      Top = 64
      Width = 121
    end
    inherited btn_Add: TBitBtn
      Left = 151
      Top = 112
      Width = 34
    end
    inherited btn_Del: TBitBtn
      Left = 151
      Top = 140
      Width = 34
    end
    inherited btn_AddTeam: TBitBtn
      Left = 151
      Top = 60
      Width = 32
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1088#1080#1075#1072#1076#1091
      ParentShowHint = False
      ShowHint = True
      OnClick = framebtn_AddTeamClick
    end
    inherited dset_brig: TIBDataSet
      Left = 176
      Top = 8
    end
    inherited dset_tmp: TIBDataSet
      Left = 80
      Top = 8
    end
    inherited tran: TIBTransaction
      Left = 216
      Top = 0
    end
    inherited ds_Brig: TDataSource
      Left = 136
      Top = 0
    end
    inherited IBSQL: TIBSQL
      Left = 272
      Top = 24
    end
  end
  object pnl_btns: TPanel
    Left = 0
    Top = 284
    Width = 333
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btn_Save: TBitBtn
      Left = 144
      Top = 8
      Width = 91
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_SaveClick
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
      Left = 240
      Top = 8
      Width = 83
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
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
  end
end
