object frm_ViewClosed1562: Tfrm_ViewClosed1562
  Left = 369
  Top = 210
  Width = 673
  Height = 496
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1079#1072#1103#1074#1086#1082' '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 417
    Width = 657
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btn_Ok: TBitBtn
      Left = 440
      Top = 8
      Width = 105
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
      OnClick = btn_OkClick
      Kind = bkOK
    end
    object btn_Cansel: TBitBtn
      Left = 56
      Top = 8
      Width = 153
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1088#1099#1090#1080#1077
      TabOrder = 1
      OnClick = btn_CanselClick
      Kind = bkCancel
    end
  end
  object DBGE_main: TDBGridEh
    Left = 0
    Top = 217
    Width = 657
    Height = 200
    Align = alClient
    AllowedOperations = [alopUpdateEh, alopAppendEh]
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    UseMultiTitle = True
    OnCellClick = DBGE_mainCellClick
    Columns = <
      item
        Color = clWhite
        FieldName = 'id'
        Footers = <>
        ReadOnly = True
        Visible = False
      end
      item
        FieldName = 'chek'
        Footers = <>
        Title.Caption = #1054#1090'-'#1074#1080#1090#1100
        Visible = False
        Width = 50
      end
      item
        FieldName = 'number'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1053#1086#1084#1077#1088' 1562'
        Width = 76
      end
      item
        FieldName = 'our_number'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1053#1072#1096' '#1085#1086#1084#1077#1088
        Width = 72
      end
      item
        FieldName = 'opened'
        Footers = <>
        Title.Caption = #1054#1090#1082#1091#1076#1072
        Width = 90
      end
      item
        FieldName = 'abonent'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1040#1073#1086#1085#1077#1085#1090
        Width = 145
      end
      item
        FieldName = 'phone'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1058#1077#1083#1077#1092#1086#1085
        Width = 78
      end
      item
        FieldName = 'Region'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1056#1072#1081#1086#1085
        Visible = False
      end
      item
        Checkboxes = True
        FieldName = 'chek'
        Footers = <>
        Title.Caption = #1054#1073#1079#1074'-'#1083#1080
        Width = 52
      end
      item
        Checkboxes = True
        FieldName = 'add_excav'
        Footers = <>
        ReadOnly = True
        Title.Caption = #1057' '#1088#1072#1089' -'#1082#1086#1081
        Width = 43
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 217
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 2
    object Label1: TLabel
      Left = 13
      Top = 27
      Width = 44
      Height = 13
      Caption = #1040#1076#1088#1077#1089#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 57
      Height = 26
      Alignment = taCenter
      Caption = #1054' '#1095#1077#1084' '#13#10#1079#1072#1103#1074#1083#1077#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 0
      Top = 152
      Width = 81
      Height = 26
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#13#10#1079#1072#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBE_Adress: TDBEdit
      Left = 80
      Top = 24
      Width = 521
      Height = 21
      DataField = 'adress'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBM_About: TDBMemo
      Left = 80
      Top = 48
      Width = 521
      Height = 73
      DataField = 'about'
      DataSource = DataSource1
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object mem_closed: TMemo
      Left = 80
      Top = 128
      Width = 518
      Height = 81
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = dm_Closed1562View.mt_table
    Left = 40
    Top = 256
  end
end
