object frame_Address: Tframe_Address
  Left = 0
  Top = 0
  Width = 704
  Height = 145
  TabOrder = 0
  object gb_Address: TGroupBox
    Left = 16
    Top = 8
    Width = 673
    Height = 121
    Caption = #1040#1076#1088#1077#1089
    TabOrder = 0
    object lbl_Street1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = #1059#1083#1080#1094#1072
    end
    object lbl_Street2: TLabel
      Left = 392
      Top = 16
      Width = 44
      Height = 13
      Caption = #1089' '#1091#1083#1080#1094#1077#1081
    end
    object lbl_HouseNum: TLabel
      Left = 16
      Top = 48
      Width = 63
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1084#1072
    end
    object lbl_AddAddress: TLabel
      Left = 200
      Top = 56
      Width = 57
      Height = 13
      Caption = #1044#1086#1087'. '#1072#1076#1088#1077#1089
    end
    object dbl_Street1: TRxDBLookupCombo
      Left = 48
      Top = 16
      Width = 201
      Height = 21
      DropDownCount = 8
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_Street1
      TabOrder = 0
    end
    object dbl_HouseType: TRxDBLookupCombo
      Left = 264
      Top = 16
      Width = 105
      Height = 21
      DropDownCount = 8
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_HouseType
      TabOrder = 1
      OnChange = dbl_HouseTypeChange
    end
    object dbl_Street2: TRxDBLookupCombo
      Left = 472
      Top = 16
      Width = 169
      Height = 21
      DropDownCount = 8
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_Street2
      TabOrder = 2
      OnChange = dbl_Street2Change
    end
    object ed_HouseNum: TDBEdit
      Left = 88
      Top = 48
      Width = 89
      Height = 21
      TabOrder = 3
    end
    object ed_AddAddress: TDBEdit
      Left = 8
      Top = 80
      Width = 561
      Height = 21
      TabOrder = 4
    end
  end
  object ds_Street1: TDataSource
    DataSet = dm_Address.cds_Street1
    Left = 128
    Top = 16
  end
  object ds_HouseType: TDataSource
    DataSet = dm_Address.cds_HouseType
    Left = 272
    Top = 24
  end
  object ds_Street2: TDataSource
    DataSet = dm_Address.cds_Street2
    Left = 456
    Top = 24
  end
end
