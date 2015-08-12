inherited frm_BoltsNG: Tfrm_BoltsNG
  Left = 296
  Top = 226
  Height = 468
  Caption = #1047#1072#1076#1074#1080#1078#1082#1080
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Fields: TPanel [0]
    Left = 0
    Top = 0
    Width = 667
    Height = 172
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 278
      Top = 110
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 280
      Top = 139
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1086#1090#1082#1088#1099#1090#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 141
      Width = 83
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103#13#10#1086#1090#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 110
      Width = 83
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103#13#10#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 14
      Top = 90
      Width = 54
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 170
      Top = 90
      Width = 38
      Height = 13
      Caption = #1052#1077#1089#1090#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inline frame_Address: Tframe_Address
      Left = 7
      Top = 6
      Width = 655
      Height = 83
      TabOrder = 0
      inherited gb_Address: TGroupBox
        Left = 1
        Top = 1
        Width = 648
        Height = 76
        Font.Style = [fsBold]
        ParentFont = False
        inherited lbl_Street1: TLabel
          Top = 18
          Width = 38
        end
        inherited lbl_Street2: TLabel
          Left = 373
          Top = 18
          Width = 53
        end
        inherited lbl_HouseNum: TLabel
          Left = 376
          Top = 13
          Width = 44
          Height = 26
          Caption = #1053#1086#1084#1077#1088' '#13#10#1076#1086#1084#1072
        end
        inherited lbl_AddAddress: TLabel
          Left = 8
          Top = 50
          Width = 68
        end
        inherited dbl_Street1: TRxDBLookupCombo
          Left = 49
          Top = 15
          Width = 188
          Font.Style = [fsBold]
          ParentFont = False
          OnKeyDown = FormKeyDown
        end
        inherited dbl_HouseType: TRxDBLookupCombo
          Left = 244
          Top = 15
          Width = 117
          Font.Style = [fsBold]
          ParentFont = False
          OnKeyDown = FormKeyDown
        end
        inherited dbl_Street2: TRxDBLookupCombo
          Left = 432
          Width = 209
          Font.Style = [fsBold]
          ParentFont = False
          OnKeyDown = FormKeyDown
        end
        inherited ed_HouseNum: TDBEdit
          Left = 432
          Top = 16
          Font.Style = [fsBold]
          ParentFont = False
          OnKeyDown = FormKeyDown
        end
        inherited ed_AddAddress: TDBEdit
          Left = 80
          Top = 46
          Width = 321
          Font.Style = [fsBold]
          ParentFont = False
          OnKeyDown = FormKeyDown
        end
      end
    end
    object dbl_BrigOpen: TRxDBLookupCombo
      Left = 379
      Top = 140
      Width = 148
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_BrigOpen
      TabOrder = 8
      OnKeyDown = FormKeyDown
    end
    object dbl_BrigClose: TRxDBLookupCombo
      Left = 379
      Top = 112
      Width = 149
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_BrigClose
      TabOrder = 5
      OnKeyDown = FormKeyDown
    end
    object tp_Open: TDBDateTimeEditEh
      Left = 200
      Top = 142
      Width = 69
      Height = 21
      DataField = 'OPENDATE'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTimeEh
      ParentFont = False
      TabOrder = 7
      OnChange = tp_CloseChange
      OnKeyDown = FormKeyDown
    end
    object tp_Close: TDBDateTimeEditEh
      Left = 199
      Top = 113
      Width = 70
      Height = 21
      DataField = 'CLOSEDATE'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Kind = dtkTimeEh
      TabOrder = 4
      OnChange = tp_CloseChange
      OnKeyDown = FormKeyDown
    end
    object dp_Close: TDBDateEdit
      Left = 95
      Top = 113
      Width = 102
      Height = 21
      DataField = 'CLOSEDATE'
      DataSource = ds_Main
      DefaultToday = True
      NumGlyphs = 2
      TabOrder = 3
      OnKeyDown = FormKeyDown
    end
    object dp_Open: TDBDateEdit
      Left = 95
      Top = 142
      Width = 103
      Height = 21
      DataField = 'OPENDATE'
      DataSource = ds_Main
      NumGlyphs = 2
      TabOrder = 6
      OnKeyDown = FormKeyDown
    end
    object dbl_Diameter: TRxDBLookupCombo
      Left = 71
      Top = 87
      Width = 77
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_TUBEDIAM'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Diam
      TabOrder = 1
      OnKeyDown = FormKeyDown
    end
    object ed_ClosePlace: TDBEdit
      Left = 212
      Top = 88
      Width = 225
      Height = 21
      DataField = 'CLOSEPLACE'
      DataSource = ds_Main
      TabOrder = 2
      OnKeyDown = FormKeyDown
    end
  end
  object pnl_Grid: TPanel [1]
    Left = 0
    Top = 172
    Width = 667
    Height = 217
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object DBGrid: TDBGridEh
      Left = 2
      Top = 2
      Width = 663
      Height = 213
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
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      OnDrawColumnCell = DBGridDrawColumnCell
      Columns = <
        item
          FieldName = 'ADRES'
          Footers = <>
          Title.Caption = #1040#1076#1088#1077#1089
          Width = 266
        end
        item
          FieldName = 'CLOSEPLACE'
          Footers = <>
          Title.Caption = #1052#1077#1089#1090#1086
        end
        item
          FieldName = 'TUBEDIAM'
          Footers = <>
          Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          Width = 75
        end
        item
          FieldName = 'CLOSEDATE'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
          Width = 84
        end
        item
          FieldName = 'BRIGCLOSE'
          Footers = <>
          Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1077
          Width = 150
        end
        item
          FieldName = 'OPENDATE'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1088#1099#1090#1080#1103
          Width = 92
        end
        item
          FieldName = 'BRIGOPEN'
          Footers = <>
          Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1086#1090#1082#1088#1099#1090#1080#1077
          Width = 136
        end>
    end
  end
  object StatusBar: TStatusBar [2]
    Left = 0
    Top = 422
    Width = 667
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  inherited pnl_Btns: TPanel
    Top = 389
    inherited btn_Insert: TBitBtn
      Caption = #1055#1077#1088#1077#1082#1088#1099#1090#1100
      TabOrder = 1
    end
    inherited btn_Edit: TBitBtn
      Caption = #1054#1090#1082#1088#1099#1090#1100
      TabOrder = 2
    end
    inherited btn_Delete: TBitBtn
      TabOrder = 3
    end
    inherited btn_Post: TBitBtn
      TabOrder = 0
    end
  end
  inherited ds_Main: TDataSource
    DataSet = dm_Bolts.dset_Main
    Left = 232
    Top = 288
  end
  object ds_Diam: TDataSource
    DataSet = dm_BoltsVocCache.cds_Diam
    Left = 152
    Top = 216
  end
  object ds_BrigClose: TDataSource
    DataSet = dm_BoltsVocCache.cds_BrigClose
    Left = 224
    Top = 216
  end
  object ds_BrigOpen: TDataSource
    DataSet = dm_BoltsVocCache.cds_BrigOpen
    Left = 312
    Top = 216
  end
end
