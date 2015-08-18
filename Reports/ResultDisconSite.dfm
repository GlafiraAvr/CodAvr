inherited DisconnSiteResult: TDisconnSiteResult
  Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1074' '#1044#1050#1061' '#1085#1072' '#1089#1072#1081#1090
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pBottom: TPanel
    inherited DBNavigator1: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited pMain: TPanel
    inherited grid: TDBGridEh
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
          Visible = False
        end
        item
          FieldName = 'Pod'
          Footers = <>
          Title.Caption = #1055#1086#1076
          Visible = False
        end
        item
          FieldName = 'Stojak'
          Footers = <>
          Title.Caption = #1057#1090#1086#1103#1082
          Visible = False
        end
        item
          FieldName = 'Kv'
          Footers = <>
          Title.Caption = #1082#1074
          Visible = False
        end
        item
          FieldName = 'DK'
          Footers = <>
          Title.Caption = #1076'/'#1082
          Visible = False
        end
        item
          FieldName = 'ShK'
          Footers = <>
          Title.Caption = #1096#1082
          Visible = False
        end
        item
          FieldName = 'LU'
          Footers = <>
          Title.Caption = #1083'/'#1091
          Visible = False
        end
        item
          FieldName = 'G_GV'
          Footers = <>
          Title.Caption = #1043#1086#1088'/'#1074#1086#1076
          Visible = False
        end
        item
          FieldName = 'Ved'
          Footers = <>
          Title.Caption = #1074#1077#1076
          Visible = False
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
        end
        item
          Checkboxes = True
          FieldName = 'weak_press'
          Footers = <>
          Title.Caption = #1057'-'#1073#1086#1077' '#1076'-'#1085#1080#1077
        end>
    end
  end
end
