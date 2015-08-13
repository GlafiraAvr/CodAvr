object frm_NumSO: Tfrm_NumSO
  Left = 394
  Top = 302
  Width = 851
  Height = 480
  Caption = '15-62'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Btns: TPanel
    Left = 0
    Top = 386
    Width = 835
    Height = 37
    Align = alBottom
    TabOrder = 0
    object btn_ok: TBitBtn
      Left = 45
      Top = 6
      Width = 86
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
      Left = 135
      Top = 6
      Width = 86
      Height = 25
      Cancel = True
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
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
  end
  object Grid: TDBGridEh
    Left = 0
    Top = 137
    Width = 835
    Height = 249
    Align = alClient
    AllowedOperations = [alopInsertEh, alopUpdateEh, alopAppendEh]
    DataSource = ds_BuffData
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    UseMultiTitle = True
    OnDrawDataCell = GridDrawDataCell
    OnKeyDown = GridKeyDown
    Columns = <
      item
        FieldName = 'number'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 74
      end
      item
        Checkboxes = False
        EndEllipsis = True
        FieldName = 'Date_Recive_Request'
        Footers = <>
        ImeMode = imDisable
        Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 91
      end
      item
        FieldName = 'NUMBER_OUR_REQUEST'
        Footers = <>
        Title.Caption = #8470' '#1074' '#1073#1072#1079#1077' '#1079#1072#1103#1074#1086#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
      end
      item
        FieldName = 'DATE_OUR_REQUEST'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1074' '#1073#1072#1079#1077' '#1079#1072#1103#1074#1086#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 91
      end
      item
        FieldName = 'RECIVED_FROM'
        Footers = <>
        Title.Caption = #1054#1090#1082#1091#1076#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 89
      end
      item
        FieldName = 'DatePrin'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1080#1085#1103#1090#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 91
      end
      item
        FieldName = 'name_officials'
        Footers = <>
        Title.Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
      end
      item
        FieldName = 'is_phobed'
        Footers = <>
        ReadOnly = False
        Title.Caption = #1054#1073#1079#1074'-'#1083#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 55
      end
      item
        Checkboxes = True
        EndEllipsis = True
        FieldName = 'add_excav'
        Footers = <>
        Title.Caption = ' C '#1088#1072#1089' -'#1082#1086#1081
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 45
      end
      item
        FieldName = 'is_closed'
        Footers = <>
        Title.Caption = #1047#1072#1082' -'#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 35
      end
      item
        FieldName = 'is_deleted'
        Footers = <>
        Title.Caption = #1059#1076'-'#1085#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 41
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 835
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '"Ctrl+Delete" - '#1091#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1087#1080#1089#1080
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 835
    Height = 137
    Align = alTop
    TabOrder = 3
    object L1: TLabel
      Left = 86
      Top = 12
      Width = 37
      Height = 13
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label1: TLabel
      Left = 272
      Top = 11
      Width = 50
      Height = 13
      Caption = #1040#1073#1086#1085#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 496
      Top = 12
      Width = 53
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 32
      Top = 44
      Width = 37
      Height = 13
      Caption = #1040#1076#1088#1077#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 79
      Width = 57
      Height = 26
      Caption = #1054' '#1095#1077#1084' '#13#10#1079#1072#1103#1074#1083#1077#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBE_Region: TDBEdit
      Left = 128
      Top = 8
      Width = 121
      Height = 21
      DataField = 'Region'
      DataSource = ds_BuffData
      TabOrder = 0
      Visible = False
    end
    object DBE_abonent: TDBEdit
      Left = 328
      Top = 8
      Width = 121
      Height = 21
      DataField = 'abonent'
      DataSource = ds_BuffData
      ReadOnly = True
      TabOrder = 1
    end
    object dbe_phone: TDBEdit
      Left = 552
      Top = 8
      Width = 121
      Height = 21
      DataField = 'phone'
      DataSource = ds_BuffData
      ReadOnly = True
      TabOrder = 2
    end
    object dbe_adres: TDBEdit
      Left = 80
      Top = 40
      Width = 614
      Height = 21
      DataField = 'adress'
      DataSource = ds_BuffData
      ReadOnly = True
      TabOrder = 3
    end
    object dme_about: TDBMemo
      Left = 80
      Top = 64
      Width = 617
      Height = 65
      DataField = 'about'
      DataSource = ds_BuffData
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 4
    end
  end
  object ds_BuffData: TDataSource
    DataSet = dm_NumSOBuff.mt_BuffData
    Left = 200
    Top = 88
  end
end
