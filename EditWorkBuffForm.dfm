object frm_EditWorkBuff: Tfrm_EditWorkBuff
  Left = 313
  Top = 190
  BorderStyle = bsDialog
  Caption = #1056#1072#1073#1086#1090#1072
  ClientHeight = 236
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 356
    Height = 185
    Align = alTop
  end
  object Label1: TLabel
    Left = 53
    Top = 8
    Width = 36
    Height = 13
    Caption = #1056#1072#1073#1086#1090#1072
  end
  object Label4: TLabel
    Left = 5
    Top = 131
    Width = 86
    Height = 26
    Alignment = taCenter
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object pnl_Exc: TPanel
    Left = 16
    Top = 27
    Width = 273
    Height = 102
    BevelOuter = bvNone
    TabOrder = 2
    object Label5: TLabel
      Left = 43
      Top = 5
      Width = 33
      Height = 13
      Caption = #1044#1083#1080#1085#1072
    end
    object Label6: TLabel
      Left = 37
      Top = 31
      Width = 39
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object Label7: TLabel
      Left = 35
      Top = 56
      Width = 41
      Height = 13
      Caption = #1043#1083#1091#1073#1080#1085#1072
    end
    object Label8: TLabel
      Left = 3
      Top = 80
      Width = 73
      Height = 13
      Caption = #1055#1083#1086#1097#1072#1076#1100' '#1072#1089#1092'.'
    end
    object ed_Length: TDBEdit
      Left = 80
      Top = 2
      Width = 84
      Height = 21
      DataField = 'exc_length'
      DataSource = ds_Main
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
    object ed_Width: TDBEdit
      Left = 80
      Top = 28
      Width = 84
      Height = 21
      DataField = 'exc_width'
      DataSource = ds_Main
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
    object ed_Depth: TDBEdit
      Left = 79
      Top = 54
      Width = 85
      Height = 21
      DataField = 'exc_depth'
      DataSource = ds_Main
      TabOrder = 2
      OnKeyDown = FormKeyDown
    end
    object ed_SQUARE_ASF: TDBEdit
      Left = 79
      Top = 77
      Width = 85
      Height = 21
      DataField = 'SQUARE_ASF'
      DataSource = ds_Main
      TabOrder = 3
      OnKeyDown = FormKeyDown
    end
  end
  object btn_ok: TBitBtn
    Left = 165
    Top = 179
    Width = 91
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
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
  object btn_exit: TBitBtn
    Left = 259
    Top = 179
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 5
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
  object dbl_Work: TRxDBLookupCombo
    Left = 95
    Top = 4
    Width = 250
    Height = 21
    DropDownCount = 8
    DataField = 'WorkID'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_WorkAtt
    TabOrder = 0
    OnChange = dbl_WorkChange
    OnKeyDown = FormKeyDown
  end
  object ed_AddInfo: TDBEdit
    Left = 93
    Top = 133
    Width = 250
    Height = 21
    DataField = 'AddInfo'
    DataSource = ds_Main
    TabOrder = 3
    OnKeyDown = FormKeyDown
  end
  object pnl_Other: TPanel
    Left = 27
    Top = 27
    Width = 177
    Height = 62
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 5
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object Label3: TLabel
      Left = 3
      Top = 33
      Width = 59
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 66
      Top = 3
      Width = 106
      Height = 21
      DropDownCount = 8
      DataField = 'DiamID'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_DiamAtt
      TabOrder = 0
      OnKeyDown = FormKeyDown
    end
    object ed_Quantity: TDBEdit
      Left = 66
      Top = 30
      Width = 106
      Height = 21
      DataField = 'quantity'
      DataSource = ds_Main
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
  end
  object DBCheckBox2: TDBCheckBox
    Left = 8
    Top = 160
    Width = 137
    Height = 17
    Alignment = taLeftJustify
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074' 1562'
    DataField = 'sentto1562'
    DataSource = ds_Main
    TabOrder = 6
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object ds_WorkAtt: TDataSource
    Left = 224
    Top = 56
  end
  object ds_DiamAtt: TDataSource
    Left = 160
    Top = 48
  end
  object ds_Main: TDataSource
    Left = 144
    Top = 8
  end
end
