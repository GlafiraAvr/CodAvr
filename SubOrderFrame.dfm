object frame_SubOrder: Tframe_SubOrder
  Left = 0
  Top = 0
  Width = 462
  Height = 295
  TabOrder = 0
  object lbl_BeginDate: TLabel
    Left = 1
    Top = 7
    Width = 93
    Height = 13
    Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lbl_BeginTime: TLabel
    Left = 203
    Top = 8
    Width = 100
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbl_SubOrderMsg: TLabel
    Left = 9
    Top = 154
    Width = 81
    Height = 13
    Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
  end
  object lbl_SubOrderAbon: TLabel
    Left = 241
    Top = 128
    Width = 68
    Height = 13
    Alignment = taCenter
    Caption = #1055#1086#1089#1090#1091#1087#1080#1083#1072' '#1086#1090
  end
  object lbl_Region: TLabel
    Left = 5
    Top = 33
    Width = 31
    Height = 13
    Caption = #1056#1072#1081#1086#1085
  end
  object lbl_PhoneNum: TLabel
    Left = 6
    Top = 129
    Width = 45
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085
  end
  object lbl_AddInfo: TLabel
    Left = 8
    Top = 192
    Width = 86
    Height = 26
    Alignment = taCenter
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object lbl_Official: TLabel
    Left = 6
    Top = 242
    Width = 55
    Height = 13
    Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
  end
  object lbl_Brig: TLabel
    Left = 227
    Top = 244
    Width = 48
    Height = 13
    Caption = #1041#1088#1080#1075#1072#1076#1080#1088
  end
  object lbl_EndDate: TLabel
    Left = 7
    Top = 270
    Width = 91
    Height = 13
    Caption = #1044#1072#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
  end
  object lbl_EndTime: TLabel
    Left = 210
    Top = 272
    Width = 98
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
  end
  object de_Begin: TDBDateEdit
    Left = 98
    Top = 4
    Width = 97
    Height = 21
    DataField = 'DTTM_BEGIN'
    DataSource = ds_Main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 0
  end
  object te_Begin: TDBDateTimeEditEh
    Left = 308
    Top = 4
    Width = 73
    Height = 21
    DataField = 'DTTM_BEGIN'
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
  end
  object gb_Address: TGroupBox
    Left = 3
    Top = 50
    Width = 454
    Height = 72
    Caption = #1040#1076#1088#1077#1089
    TabOrder = 3
    object lbl_Street: TLabel
      Left = 13
      Top = 21
      Width = 32
      Height = 13
      Caption = #1059#1083#1080#1094#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 39
      Width = 34
      Height = 26
      Alignment = taCenter
      Caption = #1053#1086#1084#1077#1088#13#10#1076#1086#1084#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 191
      Top = 46
      Width = 48
      Height = 13
      Caption = #1050#1074#1072#1088#1090#1080#1088#1072
    end
    object dbl_Street: TRxDBLookupCombo
      Left = 48
      Top = 17
      Width = 318
      Height = 21
      DropDownCount = 8
      DataField = 'ID_STREET'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_Street
      TabOrder = 0
    end
    object ed_HouseNum: TDBEdit
      Left = 48
      Top = 43
      Width = 113
      Height = 21
      DataField = 'HOUSE_NUM'
      DataSource = ds_Main
      TabOrder = 1
    end
    object ed_ApartMent: TDBEdit
      Left = 244
      Top = 43
      Width = 121
      Height = 21
      DataField = 'APARTMENT_NUM'
      DataSource = ds_Main
      TabOrder = 2
    end
  end
  object dbl_SubOrderMsg: TRxDBLookupCombo
    Left = 95
    Top = 150
    Width = 279
    Height = 21
    DropDownCount = 8
    DataField = 'ID_SUBORDERMSG'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_SubOrderMsg
    TabOrder = 6
  end
  object dbl_SubOrderAbon: TRxDBLookupCombo
    Left = 313
    Top = 125
    Width = 142
    Height = 21
    DropDownCount = 8
    DataField = 'ID_SUBORDERABON'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_SubOrderAbon
    TabOrder = 5
  end
  object dbl_Region: TRxDBLookupCombo
    Left = 40
    Top = 30
    Width = 289
    Height = 21
    DropDownCount = 8
    DataField = 'ID_REGION'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_Region
    TabOrder = 2
  end
  object ed_PhoneNum: TDBEdit
    Left = 54
    Top = 126
    Width = 182
    Height = 21
    DataField = 'PHONE_NUM'
    DataSource = ds_Main
    TabOrder = 4
  end
  object mem_AddInfo: TDBMemo
    Left = 96
    Top = 176
    Width = 361
    Height = 57
    DataField = 'ADD_INFO'
    DataSource = ds_Main
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object dbl_Official: TRxDBLookupCombo
    Left = 64
    Top = 240
    Width = 145
    Height = 21
    DropDownCount = 8
    DataField = 'ID_OFFICIAL_CLOSED'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_Official
    TabOrder = 8
  end
  object dbl_Brig: TRxDBLookupCombo
    Left = 280
    Top = 241
    Width = 177
    Height = 21
    DropDownCount = 8
    DataField = 'ID_BRIG'
    DataSource = ds_Main
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_Brig
    TabOrder = 9
  end
  object de_End: TDBDateEdit
    Left = 103
    Top = 267
    Width = 95
    Height = 21
    DataField = 'DTTM_END'
    DataSource = ds_Main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 10
  end
  object te_End: TDBDateTimeEditEh
    Left = 311
    Top = 270
    Width = 73
    Height = 21
    DataField = 'DTTM_END'
    DataSource = ds_Main
    EditButton.Style = ebsUpDownEh
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = dtkTimeEh
    ParentFont = False
    TabOrder = 11
  end
  object ds_Street: TDataSource
    DataSet = dm_SuborderVA.mt_Streets
    Left = 339
    Top = 48
  end
  object ds_SubOrderMsg: TDataSource
    DataSet = dm_SuborderVA.mt_Msg
    Left = 299
    Top = 80
  end
  object ds_SubOrderAbon: TDataSource
    DataSet = dm_SuborderVA.mt_Abon
    Left = 323
    Top = 120
  end
  object ds_Main: TDataSource
    DataSet = dm_SubOrder.dset_Main
    Left = 19
    Top = 80
  end
  object ds_Brig: TDataSource
    DataSet = dm_SuborderVA.mt_Brig
    Left = 347
    Top = 120
  end
  object ds_Official: TDataSource
    DataSet = dm_SuborderVA.mt_Offic
    Left = 411
    Top = 192
  end
  object ds_Region: TDataSource
    DataSet = dm_SuborderVA.mt_Region
    Left = 248
    Top = 32
  end
end
