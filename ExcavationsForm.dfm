inherited frm_Excavations: Tfrm_Excavations
  Left = 324
  Top = 148
  Width = 752
  Height = 655
  Caption = #1056#1072#1089#1082#1086#1087#1082#1080
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 736
    Height = 249
    Font.Style = [fsBold]
    ParentFont = False
    object Bevel1: TBevel [0]
      Left = 5
      Top = 5
      Width = 729
      Height = 276
    end
    object Label1: TLabel [1]
      Left = 11
      Top = 13
      Width = 31
      Height = 13
      Caption = #1044#1072#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel [2]
      Left = 151
      Top = 12
      Width = 39
      Height = 13
      Caption = #1042#1088#1077#1084#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel [3]
      Left = 289
      Top = 12
      Width = 65
      Height = 13
      Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [4]
      Left = 487
      Top = 11
      Width = 57
      Height = 13
      Caption = #1041#1088#1080#1075#1072#1076#1080#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel [5]
      Left = 7
      Top = 43
      Width = 75
      Height = 13
      Caption = #1050#1090#1086' '#1087#1077#1088#1077#1076#1072#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [6]
      Left = 272
      Top = 43
      Width = 45
      Height = 13
      Caption = #1056#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel [7]
      Left = 20
      Top = 73
      Width = 61
      Height = 13
      Caption = #1052#1077#1093#1072#1085#1080#1079#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [8]
      Left = 264
      Top = 70
      Width = 55
      Height = 13
      Caption = #1055#1083#1086#1097#1072#1076#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel [9]
      Left = 414
      Top = 70
      Width = 101
      Height = 13
      Caption = #1040#1089#1092#1072#1083#1100#1090#1080#1088#1086#1074#1072#1083#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object l_Exnum: TLabel [10]
      Left = 16
      Top = 109
      Width = 73
      Height = 13
      Caption = #8470' '#1088#1072#1089#1082#1086#1087#1082#1080
      Visible = False
    end
    object L_Planendwork: TLabel [11]
      Left = 16
      Top = 99
      Width = 85
      Height = 26
      Caption = #1044#1072#1090#1072' '#1087#1083#1072#1085#1080#1088'. '#13#10#1086#1082#1086#1085#1095'. '#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape1: TShape [12]
      Left = 6
      Top = 6
      Width = 729
      Height = 123
      Brush.Style = bsClear
      ParentShowHint = False
      Pen.Mode = pmNotCopy
      ShowHint = False
    end
    object Label17: TLabel [13]
      Left = 256
      Top = 104
      Width = 115
      Height = 13
      Caption = #1041#1072#1083#1072#1085#1089#1086#1076#1077#1088#1078#1072#1090#1077#1083#1100
    end
    inherited pnl_Adres: TGroupBox
      Left = 744
      Top = 24
      TabOrder = 17
      Visible = False
      inherited dbl_HouseType: TRxDBLookupCombo
        DataField = 'FK_EXCAVATIONS_HOUSETYPE'
      end
      inherited dbl_Street: TRxDBLookupCombo
        DataField = 'FK_EXCAVATIONS_STREETS'
      end
      inherited ed_AddAdres: TDBEdit
        DataSource = nil
      end
      inherited ed_HouseNum: TDBEdit
        DataField = 'HOUSENUM'
      end
    end
    object dp_Start: TDBDateEdit
      Left = 46
      Top = 9
      Width = 99
      Height = 21
      DataField = 'DTIME'
      DataSource = ds_Main
      NumGlyphs = 2
      TabOrder = 0
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_brigadiers: TRxDBLookupCombo
      Tag = 333
      Left = 552
      Top = 9
      Width = 177
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_BRIGADIERS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Brigadiers
      TabOrder = 3
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_brigadiersend: TRxDBLookupCombo
      Left = 82
      Top = 40
      Width = 176
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_BRIGADIERSEND'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Brigadiersend
      TabOrder = 4
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Officials: TRxDBLookupCombo
      Left = 358
      Top = 9
      Width = 123
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_OFFICIALS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_officials
      TabOrder = 2
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Equipment: TRxDBLookupCombo
      Left = 82
      Top = 70
      Width = 176
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_EQUIPMENT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Equipment
      TabOrder = 6
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_WorkType: TRxDBLookupCombo
      Tag = 111
      Left = 320
      Top = 40
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_EXCWT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_WorkType
      TabOrder = 5
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object tp_Start: TDBDateTimeEditEh
      Left = 195
      Top = 9
      Width = 86
      Height = 21
      DataField = 'DTIME'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Kind = dtkTimeEh
      TabOrder = 1
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_Square: TDBNumberEditEh
      Left = 320
      Top = 66
      Width = 87
      Height = 21
      DataField = 'SQUARE'
      DataSource = ds_Main
      DisplayFormat = '#,##0.00'
      EditButton.Style = ebsUpDownEh
      EditButton.Visible = True
      TabOrder = 7
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object DBL_AsfCompany: TRxDBLookupCombo
      Left = 520
      Top = 66
      Width = 201
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EXCAVATIONS_ASFCOMPANY'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_AsfCompany
      TabOrder = 8
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object DBE_Exnumber: TDBEdit
      Left = 96
      Top = 104
      Width = 121
      Height = 21
      DataField = 'EXCNUMBER'
      DataSource = ds_Main
      TabOrder = 9
      Visible = False
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 200
      Width = 161
      Height = 44
      Caption = #1060#1086#1088#1084#1072'7'
      TabOrder = 14
      object Label11: TLabel
        Left = 7
        Top = 20
        Width = 31
        Height = 13
        Caption = #1044#1072#1090#1072
      end
      object de_Form7: TDateEdit
        Left = 51
        Top = 16
        Width = 102
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
      end
    end
    object GroupBox2: TGroupBox
      Left = 176
      Top = 200
      Width = 161
      Height = 44
      Caption = #1060#1086#1090#1084#1072'3'
      TabOrder = 15
      object Label12: TLabel
        Left = 10
        Top = 20
        Width = 31
        Height = 13
        Caption = #1044#1072#1090#1072
      end
      object de_form3: TDateEdit
        Left = 47
        Top = 15
        Width = 92
        Height = 25
        NumGlyphs = 2
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
      end
    end
    object de_DTTM_PLANENDWORK: TDateEdit
      Left = 97
      Top = 101
      Width = 104
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 10
      OnChange = de_DTTM_PLANENDWORKChange
      OnEnter = de_Form7Enter
      OnExit = de_Form7Exit
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 136
      Width = 289
      Height = 65
      Caption = #1056#1072#1079#1088#1077#1096#1077#1085#1080#1077' '#1085#1072' '#1088#1072#1079#1088#1099#1090#1080#1077
      TabOrder = 11
      object L_Exorder: TLabel
        Left = 8
        Top = 22
        Width = 13
        Height = 13
        Caption = #8470
      end
      object L_DTTM_Exord: TLabel
        Left = 152
        Top = 22
        Width = 35
        Height = 13
        Caption = #1044#1072#1090#1072' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBE_Exorder: TEdit
        Left = 24
        Top = 20
        Width = 121
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
        OnKeyDown = DBE_ExorderKeyDown
      end
      object DE_DTTM_Exord: TDateEdit
        Left = 185
        Top = 18
        Width = 96
        Height = 21
        NumGlyphs = 2
        TabOrder = 1
        OnChange = mem_AdditionalInfoChange
        OnClick = DE_DTTM_ExordClick
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
        OnKeyDown = DE_DTTM_ExordKeyDown
      end
    end
    object GroupBox4: TGroupBox
      Left = 304
      Top = 136
      Width = 161
      Height = 65
      Caption = #1055#1086#1076#1072#1095#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      TabOrder = 12
      object Label13: TLabel
        Left = 7
        Top = 20
        Width = 31
        Height = 13
        Caption = #1044#1072#1090#1072
      end
      object de_Date_readability: TDateEdit
        Left = 48
        Top = 20
        Width = 105
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
      end
    end
    object GroupBox5: TGroupBox
      Left = 464
      Top = 136
      Width = 193
      Height = 65
      Caption = #1041#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1086' '#1087#1086#1076#1090#1074#1077#1088#1076#1080#1083' '
      TabOrder = 13
      object Label15: TLabel
        Left = 8
        Top = 16
        Width = 134
        Height = 13
        Caption = '('#1079#1077#1083#1077#1085#1072#1103', '#1075#1088#1091#1085#1090#1086#1074#1072#1103'  )'
      end
      object Label16: TLabel
        Left = 8
        Top = 38
        Width = 35
        Height = 13
        Caption = #1044#1072#1090#1072' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object de_Confirm: TDateEdit
        Left = 56
        Top = 36
        Width = 105
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
      end
    end
    object GroupBox6: TGroupBox
      Left = 336
      Top = 200
      Width = 185
      Height = 44
      Caption = #1054#1088#1076#1077#1088' '#1079#1072#1082#1088#1099#1090
      TabOrder = 16
      object Label14: TLabel
        Left = 6
        Top = 22
        Width = 35
        Height = 13
        Caption = #1044#1072#1090#1072' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object de_OrderClosed: TDateEdit
        Left = 40
        Top = 17
        Width = 105
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
        OnChange = mem_AdditionalInfoChange
        OnEnter = de_Form7Enter
        OnExit = de_Form7Exit
      end
    end
    object cb_withexcav: TCheckBox
      Left = 528
      Top = 208
      Width = 113
      Height = 17
      Caption = #1073#1077#1079' '#1088#1072#1089#1082#1086#1087#1086#1082
      TabOrder = 18
      OnClick = mem_AdditionalInfoChange
      OnEnter = de_Form7Enter
      OnExit = de_Form7Exit
    end
    object dbl_banceKeeper: TRxDBLookupCombo
      Left = 378
      Top = 99
      Width = 145
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_BalanceKeeper
      TabOrder = 19
      OnEnter = de_Form7Enter
      OnExit = de_Form7Exit
    end
    object btn_image: TButton
      Left = 528
      Top = 96
      Width = 97
      Height = 25
      Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      TabOrder = 20
      OnClick = btn_imageClick
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 566
    Width = 736
    TabOrder = 3
    inherited btn_Delete: TBitBtn
      TabOrder = 3
    end
    inherited btn_Post: TBitBtn
      Top = 8
      Height = 21
      TabOrder = 1
    end
  end
  inherited dbg_Main: TDBGrid
    Top = 249
    Width = 736
    Height = 236
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    Columns = <
      item
        Expanded = False
        FieldName = 'EXCWT'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1073#1086#1090#1099
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTIME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OFFICIALS'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIG'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1041#1088#1080#1075#1072#1076#1080#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 97
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIGSEND'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1050#1090#1086' '#1087#1077#1088#1077#1076#1072#1083
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EQUIP'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1052#1077#1093#1072#1085#1080#1079#1084
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SQUARE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1083#1086#1097#1072#1076#1100
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADRES'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1040#1076#1088#1077#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ASFCOMPANY'
        ReadOnly = True
        Title.Caption = #1040#1089#1092#1072#1083#1100#1090#1080#1088#1086#1074#1072#1083#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 127
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXCNUMBER'
        ReadOnly = True
        Title.Caption = #8470' '#1088#1072#1089#1082#1086#1087#1082#1080
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXCORDER'
        ReadOnly = True
        Title.Caption = #1054#1088#1076#1077#1088' '#1085#1072' '#1088#1072#1079#1088#1099#1090#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_EXCORD'
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072' '#1086#1088#1076#1077#1088#1072
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_PLANENDWORK'
        ReadOnly = True
        Title.Caption = #1044#1072#1090#1072' '#1087#1083#1072#1085'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object pnl_Additional: TPanel [3]
    Left = 0
    Top = 485
    Width = 736
    Height = 81
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      736
      81)
    object lbl_AddInfo: TLabel
      Left = 599
      Top = 11
      Width = 134
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1052#1086#1078#1085#1086' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label9: TLabel
      Left = 4
      Top = 11
      Width = 126
      Height = 13
      Caption = #1055#1088#1080#1095#1080#1085#1099' '#1085#1077' '#1079#1072#1089#1099#1087#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mem_AdditionalInfo: TMemo
      Left = 2
      Top = 24
      Width = 739
      Height = 53
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = mem_AdditionalInfoChange
      OnEnter = mem_AdditionalInfoEnter
      OnExit = mem_AdditionalInfoExit
    end
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 598
    Width = 736
    Panels = <
      item
        Width = 50
      end>
  end
  inherited Tr_main: TIBTransaction
    Left = 120
    Top = 272
  end
  inherited Tr_Voc: TIBTransaction
    Left = 248
    Top = 272
  end
  inherited dset_HouseType: TIBDataSet
    Left = 680
    Top = 32
  end
  inherited dset_Street: TIBDataSet
    Left = 712
    Top = 32
  end
  inherited dset_Street2: TIBDataSet
    Left = 744
    Top = 32
  end
  inherited dset_main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from excavations'
      'where id=:old_id'
      '')
    InsertSQL.Strings = (
      
        'insert into excavations(fk_excavations_orders, dtime, fk_excavat' +
        'ions_officials,'
      'fk_excavations_brigadiers,fk_excavations_brigadiersend,'
      'fk_excavations_excwt,fk_excavations_equipment, square,'
      
        'fk_excavations_housetype, fk_excavations_streets, housenum, fk_e' +
        'xcavations_asfcompany'
      ', EXCNUMBER, EXCORDER, DTTM_EXCORD)'
      
        'values(:fk_excavations_orders, :dtime, :fk_excavations_officials' +
        ','
      ':fk_excavations_brigadiers,:fk_excavations_brigadiersend,'
      ':fk_excavations_excwt,:fk_excavations_equipment, :square,'
      
        ':fk_excavations_housetype, :fk_excavations_streets, :housenum, :' +
        'fk_excavations_asfcompany'
      ', :EXCNUMBER, :EXCORDER, :DTTM_EXCORD)'
      '')
    SelectSQL.Strings = (
      
        'select e.id, e.dtime, e.fk_excavations_orders, e.fk_excavations_' +
        'officials,'
      
        'e.fk_excavations_brigadiers,e.fk_excavations_brigadiersend, e.fk' +
        '_excavations_asfcompany,'
      'e.fk_excavations_excwt,e.fk_excavations_equipment, e.square,'
      
        'e.fk_excavations_housetype, e.fk_excavations_streets, e.housenum' +
        ','
      
        '(select name from s_Officials where id=e.fk_excavations_official' +
        's) Officials,'
      
        '(select fk_offic_officpost from s_Officials where id=e.fk_excava' +
        'tions_officials) OfficialPost,'
      
        '(select name from brigadiers where id=e.fk_excavations_brigadier' +
        's) Brig,'
      
        '(select name from brigadiers where id=e.fk_excavations_brigadier' +
        'send) BrigSend,'
      
        '(select WorkName from s_ExcavationWorkTypes where id=e.fk_excava' +
        'tions_excwt) ExcWt,'
      '(select (select strval from tocharuns(eq.number))'
      
        '    from equipment eq where id=e.fk_excavations_equipment) Equip' +
        ','
      '(select adres from Get_Adres(e.fk_excavations_housetype,'
      '    e.fk_excavations_streets, e.housenum, null)) as Adres,'
      
        '(select name from s_asfcompany where id=e.fk_excavations_asfcomp' +
        'any) Asfcompany'
      ', EXCNUMBER, EXCORDER, DTTM_EXCORD'
      'from excavations e'
      'where e.fk_excavations_orders=:pOrderID'
      'order by e.dtime, e.id')
    ModifySQL.Strings = (
      'update excavations set'
      'fk_excavations_officials=:fk_excavations_officials,'
      'fk_excavations_brigadiers=:fk_excavations_brigadiers,'
      'fk_excavations_brigadiersend=:fk_excavations_brigadiersend,'
      'fk_excavations_excwt=:fk_excavations_excwt,'
      'fk_excavations_equipment=:fk_excavations_equipment,'
      'square=:square,'
      'fk_excavations_housetype=:fk_excavations_housetype,'
      'fk_excavations_streets=:fk_excavations_streets,'
      'fk_excavations_asfcompany=:fk_excavations_asfcompany,'
      'housenum=:housenum,'
      'dtime=:dtime,'
      'EXCNUMBER = :EXCNUMBER,'
      'EXCORDER = :EXCORDER,'
      'DTTM_EXCORD = :DTTM_EXCORD'
      'where id=:id'
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_EXCAVATIONS'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 48
    Top = 272
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = 'EXCAVATIONS.ID'
      Required = True
    end
    object dset_mainDTIME: TDateTimeField
      FieldName = 'DTIME'
      Origin = 'EXCAVATIONS.DTIME'
    end
    object dset_mainFK_EXCAVATIONS_ORDERS: TIntegerField
      FieldName = 'FK_EXCAVATIONS_ORDERS'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_ORDERS'
    end
    object dset_mainFK_EXCAVATIONS_OFFICIALS: TIntegerField
      FieldName = 'FK_EXCAVATIONS_OFFICIALS'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_OFFICIALS'
    end
    object dset_mainFK_EXCAVATIONS_BRIGADIERS: TIntegerField
      FieldName = 'FK_EXCAVATIONS_BRIGADIERS'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_BRIGADIERS'
    end
    object dset_mainFK_EXCAVATIONS_BRIGADIERSEND: TIntegerField
      FieldName = 'FK_EXCAVATIONS_BRIGADIERSEND'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_BRIGADIERSEND'
    end
    object dset_mainFK_EXCAVATIONS_EXCWT: TIntegerField
      FieldName = 'FK_EXCAVATIONS_EXCWT'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_EXCWT'
    end
    object dset_mainFK_EXCAVATIONS_EQUIPMENT: TIntegerField
      FieldName = 'FK_EXCAVATIONS_EQUIPMENT'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_EQUIPMENT'
    end
    object dset_mainSQUARE: TFloatField
      FieldName = 'SQUARE'
      Origin = 'EXCAVATIONS.SQUARE'
      DisplayFormat = '#,##0.00'
    end
    object dset_mainFK_EXCAVATIONS_HOUSETYPE: TIntegerField
      FieldName = 'FK_EXCAVATIONS_HOUSETYPE'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_HOUSETYPE'
    end
    object dset_mainFK_EXCAVATIONS_STREETS: TIntegerField
      FieldName = 'FK_EXCAVATIONS_STREETS'
      Origin = 'EXCAVATIONS.FK_EXCAVATIONS_STREETS'
    end
    object dset_mainHOUSENUM: TIBStringField
      FieldName = 'HOUSENUM'
      Origin = 'EXCAVATIONS.HOUSENUM'
      FixedChar = True
    end
    object dset_mainADRES: TIBStringField
      FieldName = 'ADRES'
      FixedChar = True
      Size = 180
    end
    object dset_mainOFFICIALS: TIBStringField
      FieldName = 'OFFICIALS'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainBRIG: TIBStringField
      FieldName = 'BRIG'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainBRIGSEND: TIBStringField
      FieldName = 'BRIGSEND'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainEXCWT: TIBStringField
      FieldName = 'EXCWT'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object dset_mainEQUIP: TIBStringField
      FieldName = 'EQUIP'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
    object dset_mainOFFICIALPOST: TIntegerField
      FieldName = 'OFFICIALPOST'
      ProviderFlags = []
    end
    object dset_mainAsfcompany: TStringField
      FieldName = 'ASFCOMPANY'
      Size = 32
    end
    object dset_mainFK_EXCAVATIONS_ASFCOMPANY: TIntegerField
      FieldName = 'FK_EXCAVATIONS_ASFCOMPANY'
      Origin = '"EXCAVATIONS"."FK_EXCAVATIONS_ASFCOMPANY"'
    end
    object dset_mainEXCNUMBER: TIntegerField
      FieldName = 'EXCNUMBER'
      Origin = '"EXCAVATIONS"."EXCNUMBER"'
    end
    object dset_mainEXCORDER: TIBStringField
      FieldName = 'EXCORDER'
      Origin = '"EXCAVATIONS"."EXCORDER"'
      Size = 10
    end
    object dset_mainDTTM_EXCORD: TDateTimeField
      FieldName = 'DTTM_EXCORD'
      Origin = '"EXCAVATIONS"."DTTM_EXCORD"'
    end
  end
  inherited ds_HouseType: TDataSource
    Left = 680
    Top = 64
  end
  inherited ds_Street: TDataSource
    Left = 712
    Top = 64
  end
  inherited ds_Street2: TDataSource
    Left = 744
    Top = 56
  end
  inherited ds_Main: TDataSource
    Left = 88
    Top = 272
  end
  object dset_Officials: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, fk_offic_officpost, activity'
      'from s_Officials '
      'order by name ')
    OnFilterRecord = dset_OfficialsFilterRecord
    Left = 280
    Top = 272
  end
  object dset_Brigadiers: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from brigadiers '
      'where id>0 '
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 320
    Top = 272
  end
  object dset_Brigadiersend: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from brigadiers '
      'where id>0'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 360
    Top = 272
  end
  object dset_WorkType: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, workname as name, activity'
      'from s_excavationworktypes '
      'where id<>12'
      'order by workname ')
    OnFilterRecord = VocFilterRecord
    Left = 392
    Top = 272
  end
  object dset_Equipment: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      
        '/*select e.id,  (select strval from tochar(e.number)) as name, a' +
        'ctivity'
      'from equipment  e'
      'order by number'
      ''
      'select id,'
      'iif (e.number=0 , rtrim(shot_name)||'#39' '#39'||rtrim(gos_number),'
      
        'iif (e.gos_number is null , rtrim(e.name)||'#39' - ('#39'||e.number||'#39')'#39 +
        ','
      ''
      '  iif (e.shot_name is null, '
      
        '         rtrim(name)||'#39' '#39'||rtrim(gos_number)||'#39' - ('#39'||number||'#39' ' +
        ')- '#39'||v_kovsh,'
      
        '         rtrim(shot_name)||'#39' '#39'||rtrim(gos_number)||'#39' - ('#39'||numbe' +
        'r||'#39' )- '#39'||v_kovsh'
      '       ))) as name,'
      'e.activity'
      ' from equipment e'
      ' where e.activity is null'
      'order by number*/'
      ''
      
        'select id,(select full_name from  get_equip_full_name(id)) as na' +
        'me,'
      'e.activity'
      ' from equipment e'
      ' where e.activity is null'
      'order by number')
    OnFilterRecord = VocFilterRecord
    Left = 424
    Top = 272
  end
  object ds_officials: TDataSource
    DataSet = dset_Officials
    Left = 280
    Top = 304
  end
  object ds_Brigadiers: TDataSource
    DataSet = dset_Brigadiers
    Left = 320
    Top = 304
  end
  object ds_Brigadiersend: TDataSource
    DataSet = dset_Brigadiersend
    Left = 360
    Top = 304
  end
  object ds_WorkType: TDataSource
    DataSet = dset_WorkType
    Left = 392
    Top = 304
  end
  object ds_Equipment: TDataSource
    DataSet = dset_Equipment
    Left = 424
    Top = 304
  end
  object dset_AsfCompany: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_AsfCompany '
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 456
    Top = 272
  end
  object ds_AsfCompany: TDataSource
    DataSet = dset_AsfCompany
    Left = 456
    Top = 304
  end
  object dset_balanceKeeper: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      
        'select ID, NAME from S_BALANCEKEEPER where ACTIVITY is null orde' +
        'r by 1')
    Left = 496
    Top = 272
  end
  object ds_BalanceKeeper: TDataSource
    DataSet = dset_balanceKeeper
    Left = 496
    Top = 304
  end
end
