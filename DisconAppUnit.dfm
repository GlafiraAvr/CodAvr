object AVRDisconnResultForm: TAVRDisconnResultForm
  Left = 301
  Top = 176
  Width = 910
  Height = 703
  Align = alTop
  Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1074' '#1044#1050#1061
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pBottom: TPanel
    Left = 0
    Top = 624
    Width = 894
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btLoadSnapShot: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 25
      Caption = 'btLoadSnapShot'
      TabOrder = 0
      Visible = False
    end
    object btSendAndSave: TButton
      Left = 264
      Top = 8
      Width = 145
      Height = 25
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      TabOrder = 1
    end
    object btClose: TButton
      Left = 768
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 2
      OnClick = btCloseClick
    end
    object DBNavigator1: TDBNavigator
      Left = 416
      Top = 8
      Width = 240
      Height = 25
      TabOrder = 3
    end
    object btSave: TButton
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btSave'
      TabOrder = 4
      Visible = False
    end
  end
  object pMain: TPanel
    Left = 0
    Top = 41
    Width = 894
    Height = 583
    Align = alClient
    TabOrder = 1
    object grid: TDBGridEh
      Left = 1
      Top = 1
      Width = 892
      Height = 581
      Align = alClient
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Visible = False
      Columns = <
        item
          FieldName = 'Podrazd'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Width = 103
        end
        item
          FieldName = 'region'
          Footers = <>
          Title.Caption = #1056#1072#1081#1086#1085
          Width = 82
        end
        item
          FieldName = 'Adres'
          Footers = <>
          Title.Caption = #1040#1076#1088#1077#1089
        end
        item
          FieldName = 'Zhd'
          Footers = <>
          Title.Caption = #1046'/'#1044
        end
        item
          FieldName = 'G_ATG'
          Footers = <>
          Title.Caption = #1069#1090#1072#1078
        end
        item
          FieldName = 'Pod'
          Footers = <>
          Title.Caption = #1055#1086#1076
        end
        item
          FieldName = 'Stojak'
          Footers = <>
          Title.Caption = #1057#1090#1086#1103#1082
        end
        item
          FieldName = 'Kv'
          Footers = <>
          Title.Caption = #1082#1074
        end
        item
          FieldName = 'DK'
          Footers = <>
          Title.Caption = #1076'/'#1082
        end
        item
          FieldName = 'ShK'
          Footers = <>
          Title.Caption = #1096#1082
        end
        item
          FieldName = 'LU'
          Footers = <>
          Title.Caption = #1083'/'#1091
        end
        item
          FieldName = 'G_GV'
          Footers = <>
          Title.Caption = #1043#1086#1088'/'#1074#1086#1076
        end
        item
          FieldName = 'Ved'
          Footers = <>
          Title.Caption = #1074#1077#1076
        end
        item
          FieldName = 'DisconReason'
          Footers = <>
          Title.Caption = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        end
        item
          FieldName = 'Dttm_Discon'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083'.'
        end
        item
          FieldName = 'Dttm_ConnWait'
          Footers = <>
          Title.Caption = #1054#1078#1080#1076#1072#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1074#1082#1083'.'
        end
        item
          FieldName = 'dttm_con'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1074#1082#1083'.'
        end>
    end
  end
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 894
    Height = 41
    Align = alTop
    TabOrder = 2
  end
end
