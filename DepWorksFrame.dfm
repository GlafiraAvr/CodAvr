inherited frame_DepWorks: Tframe_DepWorks
  Width = 675
  Height = 427
  inherited DBGrid: TDBGridEh
    Top = 121
    Width = 675
    Height = 306
    UseMultiTitle = True
    Columns = <
      item
        FieldName = 'WORKNAME'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
        Width = 129
      end
      item
        FieldName = 'DIAM'
        Footers = <>
        Title.Caption = #1044#1080#1072#1084#1077#1090#1088
      end
      item
        FieldName = 'QUANTITY'
        Footers = <>
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 74
      end
      item
        FieldName = 'WORK_TIME'
        Footers = <>
        Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' ('#1095#1077#1083'./'#1095#1072#1089')'
        Width = 92
      end>
  end
  inherited pnl_Fields: TPanel
    Width = 675
    Height = 121
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 76
      Height = 26
      Alignment = taCenter
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#13#10#1088#1072#1073#1086#1090
    end
    object Label2: TLabel
      Left = 32
      Top = 56
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object Label3: TLabel
      Left = 24
      Top = 92
      Width = 59
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object dbt_WorkTime: TDBText
      Left = 280
      Top = 40
      Width = 105
      Height = 17
      DataField = 'clcWT_INFO'
      DataSource = ds_Main
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 272
      Top = 80
      Width = 32
      Height = 13
      Caption = 'Label4'
    end
    object dbl_Work: TRxDBLookupCombo
      Left = 88
      Top = 8
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPWORKS_WORK'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_Works
      TabOrder = 0
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 88
      Top = 48
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPWORKS_DIAMETER'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'diameter'
      LookupSource = ds_Diams
      TabOrder = 1
    end
    object ed_Quantity: TDBEdit
      Left = 88
      Top = 84
      Width = 145
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Main
      TabOrder = 2
    end
  end
  inherited ds_Main: TDataSource
    Left = 280
  end
  object ds_Works: TDataSource
    DataSet = dm_WorksVocCache.cds_Works
    Left = 168
    Top = 8
  end
  object ds_Diams: TDataSource
    DataSet = dm_WorksVocCache.cds_Diam
    Left = 168
    Top = 48
  end
end
