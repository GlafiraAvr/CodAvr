inherited frm_OptBlag2: Tfrm_OptBlag2
  Left = 620
  Top = 177
  BorderStyle = bsDialog
  Caption = ''
  ClientHeight = 493
  ClientWidth = 295
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 40
    Width = 281
    Height = 209
    Brush.Style = bsClear
    Pen.Color = clGray
  end
  object btn_ok: TBitBtn
    Left = 8
    Top = 464
    Width = 91
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 9
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
  object btn_close: TBitBtn
    Left = 184
    Top = 464
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 10
    OnClick = btn_closeClick
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
  inline frame_SelDates: Tframe_SelDatePeriod
    Left = 7
    Top = 7
    Width = 259
    Height = 22
    TabOrder = 0
    inherited de_Begin: TDateEdit
      OnChange = frame_SelDatesde_BeginChange
    end
    inherited de_End: TDateEdit
      OnChange = frame_SelDatesde_EndChange
    end
  end
  object cb_GreenZone: TCheckBox
    Left = 8
    Top = 264
    Width = 257
    Height = 17
    Caption = #1074#1082#1083#1102#1095#1080#1090#1100' '#1047#1077#1083#1105#1085#1091#1102' '#1047#1086#1085#1091
    Checked = True
    State = cbChecked
    TabOrder = 6
    Visible = False
  end
  object rg_Asfalt: TRadioGroup
    Left = 12
    Top = 490
    Width = 265
    Height = 47
    ItemIndex = 0
    Items.Strings = (
      #1040#1089#1092#1072#1083#1100#1090#1080#1088#1086#1074#1072#1085#1080#1077
      #1065#1077#1073#1077#1085#1077#1085#1080#1077)
    TabOrder = 1
    Visible = False
  end
  object rb1: TRadioButton
    Left = 16
    Top = 48
    Width = 113
    Height = 17
    Caption = #1042#1089#1077
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = rb2Click
  end
  object rb2: TRadioButton
    Left = 16
    Top = 72
    Width = 201
    Height = 17
    Caption = #1053#1077' '#1079#1072#1082#1086#1085#1095#1077#1085#1085#1086#1077' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
    TabOrder = 3
    OnClick = rb2Click
  end
  object rb3: TRadioButton
    Left = 16
    Top = 216
    Width = 177
    Height = 17
    Caption = #1055#1086#1083#1085#1086#1077' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086
    TabOrder = 5
    OnClick = rb2Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 96
    Width = 265
    Height = 113
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    inline frame_SelDateP1: Tframe_SelDatePeriod
      Left = 14
      Top = 31
      Width = 227
      Height = 22
      Enabled = False
      TabOrder = 1
      inherited Label1: TLabel
        Width = 7
        Caption = 'C'
      end
      inherited Label2: TLabel
        Left = 107
      end
      inherited de_Begin: TDateEdit
        Left = 16
        Enabled = False
        OnChange = frame_SelDateP1de_BeginChange
      end
      inherited de_End: TDateEdit
        Left = 122
        Enabled = False
      end
    end
    object cb_Blag: TCheckBox
      Left = 8
      Top = 8
      Width = 233
      Height = 17
      Caption = #1057' '#1086#1082#1086#1085#1095#1072#1085#1080#1077#1084' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      TabOrder = 0
      OnClick = cb_BlagClick
    end
    object cb_notfar: TCheckBox
      Left = 8
      Top = 64
      Width = 201
      Height = 17
      Caption = #1053#1077#1076#1086#1074#1085#1086' '#1087#1086#1089#1090#1091#1087#1080#1074#1096#1080#1077
      TabOrder = 2
      OnClick = cb_BlagClick
    end
    inline frame_SelDateP2: Tframe_SelDatePeriod
      Left = 14
      Top = 87
      Width = 227
      Height = 22
      Enabled = False
      TabOrder = 3
      inherited Label1: TLabel
        Width = 7
        Caption = 'C'
      end
      inherited Label2: TLabel
        Left = 107
      end
      inherited de_Begin: TDateEdit
        Left = 16
        Enabled = False
      end
      inherited de_End: TDateEdit
        Left = 122
        Enabled = False
      end
    end
  end
  object cb_DopAsf: TCheckBox
    Left = 8
    Top = 280
    Width = 257
    Height = 17
    Caption = #1076#1086#1087'. '#1058#1072#1073#1083#1080#1094#1072' '#1087#1086' '#1072#1089#1092#1072#1083#1100#1090#1080#1088#1086#1074#1082#1080
    TabOrder = 7
    Visible = False
  end
  object cb_adress: TCheckBox
    Left = 8
    Top = 296
    Width = 257
    Height = 17
    Caption = #1055#1086#1082#1072#1079#1072#1082#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1072#1076#1088#1077#1089#1086#1074
    Checked = True
    State = cbChecked
    TabOrder = 8
    Visible = False
  end
  inline frame_SelRegion1: Tframe_SelRegion
    Left = 32
    Top = 360
    Width = 217
    Height = 41
    TabOrder = 11
    inherited btn_Region: TBitBtn
      Top = 0
    end
  end
  object rg_Excav: TRadioGroup
    Left = 8
    Top = 312
    Width = 265
    Height = 41
    Caption = #1056#1072#1089#1082#1086#1087#1082#1072
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1042#1089#1077
      #1045#1089#1090#1100
      #1053#1077#1090)
    TabOrder = 12
  end
  object rg_ClosedOrder: TRadioGroup
    Left = 8
    Top = 392
    Width = 265
    Height = 41
    Caption = #1054#1088#1076#1077#1088
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1042#1089#1077
      #1047#1072#1082#1088#1099#1090#1099#1077
      #1054#1090#1082#1088#1099#1090#1099#1077)
    TabOrder = 13
    Visible = False
  end
  object cb_prosroch: TCheckBox
    Left = 8
    Top = 440
    Width = 113
    Height = 17
    Caption = #1055#1088#1086#1089#1088#1086#1095#1077#1085#1085#1099#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object dset_date: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select curyear, curdate  from GREENSPRINGDATE')
    Left = 32
    Top = 16
  end
end
