object frame_Dep: Tframe_Dep
  Left = 0
  Top = 0
  Width = 700
  Height = 511
  TabOrder = 0
  object tc_Deps: TmpTabControl
    Left = 0
    Top = 0
    Width = 697
    Height = 509
    PopupMenu = pm_Deps
    TabOrder = 0
    OnChange = tc_DepsChange
    OnChanging = tc_DepsChanging
    object Label1: TLabel
      Left = 22
      Top = 157
      Width = 48
      Height = 13
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088
    end
    object Label8: TLabel
      Left = 8
      Top = 185
      Width = 64
      Height = 26
      Alignment = taCenter
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090'.'#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    end
    object dbt_RecInfo: TDBText
      Left = 8
      Top = 40
      Width = 457
      Height = 17
      DataField = 'clc_RecInfo'
      DataSource = ds_Dep
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbl_DateRegl: TLabel
      Left = 568
      Top = 160
      Width = 75
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072#13#10' '#1088#1077#1075#1083#1072#1084#1077#1085#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gb_BegWork: TGroupBox
      Left = 5
      Top = 61
      Width = 549
      Height = 46
      Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 20
        Width = 26
        Height = 13
        Caption = #1044#1072#1090#1072
      end
      object Label3: TLabel
        Left = 137
        Top = 19
        Width = 33
        Height = 13
        Caption = #1042#1088#1077#1084#1103
      end
      object dbt_DispOpen: TDBText
        Left = 284
        Top = 20
        Width = 165
        Height = 17
        DataField = 'lp_DispOpen'
        DataSource = ds_Dep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 248
        Top = 20
        Width = 33
        Height = 13
        Caption = #1044#1080#1089#1087'.:'
      end
      object de_BegDate: TDBDateEdit
        Left = 38
        Top = 17
        Width = 89
        Height = 21
        DataField = 'STARTDATE'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 0
        OnChange = dbl_BrigChange
      end
      object te_BegTime: TDBDateTimeEditEh
        Left = 172
        Top = 17
        Width = 70
        Height = 21
        DataField = 'STARTDATE'
        DataSource = ds_Dep
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 1
        OnChange = te_BegTimeChange
      end
    end
    object gb_EndWork: TGroupBox
      Left = 5
      Top = 106
      Width = 549
      Height = 46
      Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090
      TabOrder = 1
      object Label4: TLabel
        Left = 9
        Top = 20
        Width = 26
        Height = 13
        Caption = #1044#1072#1090#1072
      end
      object Label5: TLabel
        Left = 137
        Top = 19
        Width = 33
        Height = 13
        Caption = #1042#1088#1077#1084#1103
      end
      object dbt_DispClose: TDBText
        Left = 286
        Top = 20
        Width = 163
        Height = 17
        DataField = 'lp_DispClose'
        DataSource = ds_Dep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 249
        Top = 19
        Width = 33
        Height = 13
        Caption = #1044#1080#1089#1087'.:'
      end
      object de_EndDate: TDBDateEdit
        Left = 38
        Top = 17
        Width = 89
        Height = 21
        DataField = 'ENDDATE'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 0
        OnChange = dbl_BrigChange
        OnKeyDown = de_EndDateKeyDown
      end
      object te_EndTime: TDBDateTimeEditEh
        Left = 172
        Top = 17
        Width = 70
        Height = 21
        DataField = 'ENDDATE'
        DataSource = ds_Dep
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 1
        OnChange = te_BegTimeChange
        OnKeyDown = de_EndDateKeyDown
      end
    end
    object dbl_Brig: TRxDBLookupCombo
      Left = 74
      Top = 154
      Width = 215
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPARTURES_BRIGADIERS'
      DataSource = ds_Dep
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_BrigAtt
      TabOrder = 2
      OnChange = dbl_BrigChange
      OnEnter = dbl_BrigEnter
      OnExit = dbl_BrigExit
    end
    object mem_AddInfo: TDBMemo
      Left = 66
      Top = 178
      Width = 484
      Height = 43
      DataField = 'ADDITIONALINFO'
      DataSource = ds_Dep
      MaxLength = 800
      ScrollBars = ssVertical
      TabOrder = 4
      WantReturns = False
      OnChange = dbl_BrigChange
    end
    object dbl_MessType: TRxDBLookupCombo
      Left = 291
      Top = 154
      Width = 265
      Height = 21
      DropDownCount = 8
      LookupField = 'name'
      LookupDisplay = 'name'
      LookupSource = ds_MessType
      TabOrder = 3
      OnChange = dbl_MessTypeChange
    end
    object cb_PLAN: TCheckBox
      Left = 76
      Top = 9
      Width = 97
      Height = 17
      Caption = #1057#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086
      TabOrder = 6
      Visible = False
      OnClick = cb_PLANClick
    end
    object gb_empting: TGroupBox
      Left = 557
      Top = 62
      Width = 121
      Height = 44
      Caption = #1054#1087#1086#1088#1086#1078#1085#1077#1085#1080#1103
      TabOrder = 7
      object dbn_empting: TDBNumberEditEh
        Left = 11
        Top = 17
        Width = 78
        Height = 21
        currency = False
        DataField = 'EMPTING'
        DataSource = ds_Dep
        DisplayFormat = '#,##0.00'
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        Increment = 0.100000000000000000
        TabOrder = 0
        OnChange = dbn_emptingChange
      end
    end
    object gb_PlanWork: TGroupBox
      Left = 5
      Top = 21
      Width = 676
      Height = 42
      Caption = #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086
      TabOrder = 5
      object Label9: TLabel
        Left = 3
        Top = 20
        Width = 37
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1086
      end
      object Label10: TLabel
        Left = 209
        Top = 19
        Width = 31
        Height = 13
        Caption = #1050#1086#1085#1077#1094
      end
      object Label11: TLabel
        Left = 412
        Top = 20
        Width = 60
        Height = 13
        Caption = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088
      end
      object Label12: TLabel
        Left = 539
        Top = 19
        Width = 33
        Height = 13
        Caption = #1044#1080#1089#1087'.:'
      end
      object dbt_Plan: TDBText
        Left = 575
        Top = 19
        Width = 95
        Height = 17
        DataField = 'lp_DispOpen'
        DataSource = ds_Dep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object de_PBegDate: TDBDateEdit
        Tag = 123
        Left = 44
        Top = 17
        Width = 89
        Height = 21
        DataField = 'PLANSTARTDATE'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 0
        OnChange = dbl_BrigChange
      end
      object de_PBegTime: TDBDateTimeEditEh
        Left = 134
        Top = 17
        Width = 70
        Height = 21
        DataField = 'PLANSTARTDATE'
        DataSource = ds_Dep
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 1
        OnChange = te_BegTimeChange
      end
      object de_PEndDate: TDBDateEdit
        Left = 244
        Top = 17
        Width = 88
        Height = 21
        DataField = 'PLANENDDATE'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 2
        OnChange = dbl_BrigChange
      end
      object de_PEndTime: TDBDateTimeEditEh
        Left = 334
        Top = 17
        Width = 70
        Height = 21
        DataField = 'PLANENDDATE'
        DataSource = ds_Dep
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 3
        OnChange = te_BegTimeChange
      end
      object dbl_Equipment: TRxDBLookupCombo
        Left = 476
        Top = 16
        Width = 61
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DEPARTURES_EQUIPMENT'
        DataSource = ds_Dep
        LookupField = 'id'
        LookupDisplay = 'snumber'
        LookupSource = ds_equipment
        TabOrder = 4
        OnChange = te_BegTimeChange
      end
    end
    object dbe_ReplPlan: TDBDateEdit
      Left = 552
      Top = 192
      Width = 97
      Height = 21
      DataField = 'PLANDATEREGL'
      DataSource = ds_Dep
      NumGlyphs = 2
      TabOrder = 8
      OnChange = dbe_ReplPlanChange
    end
    object dbl_Region_brig: TRxDBLookupCombo
      Left = 560
      Top = 228
      Width = 121
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPARTURES_REGION_BRIG'
      DataSource = ds_Dep
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_RegionID_brig
      TabOrder = 9
      OnChange = dbl_Region_brigChange
    end
    object pnl_closeExcav: TPanel
      Left = 8
      Top = 240
      Width = 689
      Height = 262
      BevelInner = bvLowered
      BevelOuter = bvSpace
      TabOrder = 10
      object Label13: TLabel
        Left = 16
        Top = 56
        Width = 119
        Height = 39
        Caption = #1044#1086#1087'. '#1080#1085#1092#1083#1088#1084#1072#1094#1080#1103#13#10#1087#1086' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1091#13#10'('#1079#1072#1082#1088#1099#1090#1080#1077' 1562)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 32
        Top = 24
        Width = 92
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 232
        Top = 21
        Width = 230
        Height = 16
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1091'!!!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btn_Close1562: TButton
        Left = 528
        Top = 32
        Width = 129
        Height = 41
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1079#1072#1103#1074#1082#1080' '#1087#1086' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        WordWrap = True
        OnClick = btn_Close1562Click
      end
      object dbm_ClosedExcavInfo: TDBMemo
        Left = 128
        Top = 48
        Width = 377
        Height = 65
        DataField = 'EXCAV_CLOSE_INFO'
        DataSource = ds_Dep
        ScrollBars = ssVertical
        TabOrder = 1
        OnChange = dbm_ClosedExcavInfoChange
      end
      object de_dateclose_info: TDBDateEdit
        Left = 129
        Top = 19
        Width = 89
        Height = 21
        DataField = 'DATE_CLOSE_INFO'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 2
        OnChange = dbm_ClosedExcavInfoChange
        OnKeyDown = de_EndDateKeyDown
      end
    end
    object pnl_closedCapRem: TPanel
      Left = 8
      Top = 370
      Width = 689
      Height = 130
      BevelInner = bvLowered
      BevelOuter = bvSpace
      TabOrder = 11
      object Label15: TLabel
        Left = 16
        Top = 56
        Width = 107
        Height = 39
        Caption = #1044#1086#1087'. '#1080#1085#1092#1083#1088#1084#1072#1094#1080#1103#13#10#1082#1072#1087' '#1088#1077#1084#1086#1085#1090#13#10'('#1079#1072#1082#1088#1099#1090#1080#1077' 1562)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 32
        Top = 16
        Width = 92
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 240
        Top = 8
        Width = 162
        Height = 16
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1082#1072#1087' '#1088#1077#1084#1086#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btn_caprem1562: TButton
        Left = 528
        Top = 32
        Width = 129
        Height = 41
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1079#1072#1103#1074#1082#1080' '#1082#1072#1087' '#1088#1077#1084#1086#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        WordWrap = True
        OnClick = btn_caprem1562Click
      end
      object dbm_CAPREM_CLOSEDINFO: TDBMemo
        Left = 136
        Top = 40
        Width = 377
        Height = 65
        DataField = 'CAPREP_CLOSEDINFO'
        DataSource = ds_Dep
        ScrollBars = ssVertical
        TabOrder = 1
        OnChange = dbm_CAPREM_CLOSEDINFOChange
      end
      object db_Date_CapRem: TDBDateEdit
        Left = 137
        Top = 11
        Width = 89
        Height = 21
        DataField = 'CAPREM_DATE'
        DataSource = ds_Dep
        NumGlyphs = 2
        TabOrder = 2
        OnChange = dbm_CAPREM_CLOSEDINFOChange
        OnKeyDown = de_EndDateKeyDown
      end
    end
  end
  object gb_Diameter: TGroupBox
    Left = 556
    Top = 106
    Width = 125
    Height = 45
    Caption = #1044#1080#1072#1084#1077#1090#1088
    TabOrder = 1
    object dbl_Diameter: TRxDBLookupCombo
      Left = 8
      Top = 14
      Width = 89
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DIAMETER'
      DataSource = ds_Dep
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_diameter
      TabOrder = 0
      OnChange = dbl_DiameterChange
    end
  end
  object pm_Deps: TPopupMenu
    OnPopup = pm_DepsPopup
    Left = 264
    Top = 48
    object mi_DelDep: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1077#1079#1076
      OnClick = mi_DelDepClick
    end
  end
  object ds_Dep: TDataSource
    DataSet = dm_NGDep.dset_Dep
    Left = 312
    Top = 48
  end
  object ds_BrigAtt: TDataSource
    Left = 248
    Top = 144
  end
  object ds_MessType: TDataSource
    DataSet = dm_NGDep.mem_MessagetypesAtt
    Left = 376
    Top = 144
  end
  object ds_equipment: TDataSource
    DataSet = dm_NGDep.mem_LookupEquip
    Left = 496
    Top = 16
  end
  object ds_equipment_do: TDataSource
    DataSet = dm_NGDep.mem_EquipmentAtt
    Left = 576
    Top = 152
  end
  object ds_diameter: TDataSource
    DataSet = dm_NGDep.mem_diameter
    Left = 800
    Top = 192
  end
  object ds_RegionID_brig: TDataSource
    DataSet = dm_NGDep.mem_region_brig
    Left = 560
    Top = 208
  end
end
