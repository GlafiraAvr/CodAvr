inherited frm_Deps: Tfrm_Deps
  Left = 312
  Top = 299
  Width = 700
  Height = 424
  Caption = #1042#1099#1077#1079#1076#1099
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Btns: TPanel
    Top = 343
    Width = 692
    inherited btn_Exit: TBitBtn
      Left = 519
    end
  end
  object StatusBar: TStatusBar [1]
    Left = 0
    Top = 376
    Width = 692
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pnl_Fields: TPanel [2]
    Left = 0
    Top = 0
    Width = 692
    Height = 177
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 2
    object tc_Deps: TTabControl
      Left = 2
      Top = 2
      Width = 688
      Height = 173
      Align = alClient
      TabOrder = 0
      OnChange = tc_DepsChange
      OnChanging = tc_DepsChanging
      object lbl_Brig: TLabel
        Left = 8
        Top = 136
        Width = 115
        Height = 26
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#13#10#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbl_Brig: TRxDBLookupCombo
        Left = 124
        Top = 139
        Width = 217
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DEPARTURES_BRIGADIERS'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Brig
        TabOrder = 2
        OnKeyDown = FormKeyDown
      end
      object gb_StartWork: TGroupBox
        Left = 8
        Top = 32
        Width = 457
        Height = 45
        Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object dbt_OfficialOpen: TDBText
          Left = 324
          Top = 21
          Width = 126
          Height = 17
          DataField = 'OFFICIALOPEN'
          DataSource = ds_Main
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl_StartDate: TLabel
          Left = 11
          Top = 21
          Width = 31
          Height = 13
          Caption = #1044#1072#1090#1072
        end
        object lbl_StartTime: TLabel
          Left = 152
          Top = 20
          Width = 39
          Height = 13
          Caption = #1042#1088#1077#1084#1103
        end
        object lbl_OfficialOpen: TLabel
          Left = 280
          Top = 21
          Width = 40
          Height = 13
          Caption = #1044#1080#1089#1087'.:'
        end
        object de_StartDate: TDBDateEdit
          Left = 45
          Top = 18
          Width = 97
          Height = 21
          DataField = 'STARTDATE'
          DataSource = ds_Main
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 0
          OnKeyDown = FormKeyDown
        end
        object te_StartTime: TDBDateTimeEditEh
          Left = 194
          Top = 17
          Width = 73
          Height = 21
          DataField = 'STARTDATE'
          DataSource = ds_Main
          EditButton.Style = ebsUpDownEh
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkTimeEh
          ParentFont = False
          TabOrder = 1
          OnChange = te_StartTimeChange
          OnKeyDown = FormKeyDown
        end
      end
      object gb_EndWork: TGroupBox
        Left = 8
        Top = 79
        Width = 457
        Height = 46
        Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object dbt_OfficialClose: TDBText
          Left = 323
          Top = 21
          Width = 126
          Height = 17
          DataField = 'OFFICIALCLOSE'
          DataSource = ds_Main
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl_EndDate: TLabel
          Left = 10
          Top = 21
          Width = 31
          Height = 13
          Caption = #1044#1072#1090#1072
        end
        object lbl_EndTime: TLabel
          Left = 152
          Top = 20
          Width = 39
          Height = 13
          Caption = #1042#1088#1077#1084#1103
        end
        object lbl_OfficialClose: TLabel
          Left = 280
          Top = 20
          Width = 40
          Height = 13
          Caption = #1044#1080#1089#1087'.:'
        end
        object de_EndDate: TDBDateEdit
          Left = 43
          Top = 18
          Width = 97
          Height = 21
          DataField = 'ENDDATE'
          DataSource = ds_Main
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 0
          OnKeyDown = FormKeyDown
        end
        object te_EndTime: TDBDateTimeEditEh
          Left = 195
          Top = 16
          Width = 73
          Height = 21
          DataField = 'ENDDATE'
          DataSource = ds_Main
          EditButton.Style = ebsUpDownEh
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkTimeEh
          ParentFont = False
          TabOrder = 1
          OnChange = te_StartTimeChange
          OnKeyDown = FormKeyDown
        end
      end
      object btn_DepCharge: TBitBtn
        Left = 472
        Top = 40
        Width = 137
        Height = 25
        Caption = #1056#1072#1073#1086#1090#1099'/'#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = False
        OnClick = btn_DepChargeClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
          1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
          1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
          193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
          11155557F755F777777555000755033305555577755F75F77F55555555503335
          0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
          05555757F75F75557F5505000333555505557F777FF755557F55000000355557
          07557777777F55557F5555000005555707555577777FF5557F55553000075557
          0755557F7777FFF5755555335000005555555577577777555555}
        NumGlyphs = 2
      end
      object btn_DepWorkers: TBitBtn
        Left = 472
        Top = 96
        Width = 137
        Height = 25
        Caption = #1051#1102#1076#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        TabStop = False
        OnClick = btn_DepWorkersClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050FF00055555
          555558070F00555555550800FFF8055555550880000F800555555007FFF08800
          055555500FF800BBB0055555500BBBBBBBB05555500000000BB855500BBBBBBB
          B000550BB000000B000F50B00BBBBB0B0B50500BBBBBBB0B0B55550BBBBBB0B0
          B0555550BBBB0B0B055555550000B00055555555550000555555}
      end
      object btn_DepEquip: TBitBtn
        Left = 472
        Top = 68
        Width = 137
        Height = 25
        Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btn_DepEquipClick
      end
    end
  end
  object pnl_Grid: TPanel [3]
    Left = 0
    Top = 177
    Width = 692
    Height = 166
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 3
    object DBG_Deps: TDBGridEh
      Left = 2
      Top = 2
      Width = 688
      Height = 162
      Align = alClient
      DataSource = ds_Main
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
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      OnDrawColumnCell = DBG_DepsDrawColumnCell
      Columns = <
        item
          FieldName = 'STARTDATE'
          Footers = <>
          Title.Alignment = taLeftJustify
          Title.Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090'||'#1044#1072#1090#1072'/'#1074#1088#1077#1084#1103
          Width = 121
        end
        item
          FieldName = 'OFFICIALOPEN'
          Footers = <>
          Title.Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090'||'#1044#1080#1089#1087#1077#1090#1095#1077#1088
          Width = 119
        end
        item
          FieldName = 'ENDDATE'
          Footers = <>
          Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090'||'#1044#1072#1090#1072'/'#1074#1088#1077#1084#1103
          Width = 128
        end
        item
          FieldName = 'OFFICIALCLOSE'
          Footers = <>
          Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090'||'#1044#1080#1089#1087#1077#1090#1095#1077#1088
          Width = 123
        end
        item
          FieldName = 'BRIG'
          Footers = <>
          Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1088#1072#1073#1086#1090
          Width = 130
        end>
    end
  end
  inherited ds_Main: TDataSource
    OnDataChange = ds_MainDataChange
    Left = 160
    Top = 248
  end
  object ds_Brig: TDataSource
    DataSet = dm_DepartureVocCache.cds_Brig
    Left = 216
    Top = 176
  end
end
