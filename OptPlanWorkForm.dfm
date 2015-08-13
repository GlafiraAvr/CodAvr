inherited frm_OptPlanWork: Tfrm_OptPlanWork
  Left = 678
  Top = 406
  Width = 279
  Height = 225
  Caption = 'frm_OptPlanWork'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 233
    Height = 121
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 8
      Width = 111
      Height = 13
      Caption = #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086' '#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 96
      Top = 64
      Width = 37
      Height = 13
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object de_Date: TDateEdit
      Left = 56
      Top = 32
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
    end
    object RxDBL_Region: TRxDBLookupCombo
      Left = 16
      Top = 80
      Width = 201
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = DataSource1
      TabOrder = 1
    end
  end
  object btn_OK: TBitBtn
    Left = 8
    Top = 136
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btn_OKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btn_Cancel: TBitBtn
    Left = 152
    Top = 136
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    Kind = bkCancel
  end
  object DataSource1: TDataSource
    DataSet = dset_regions
    Left = 192
    Top = 48
  end
  object dset_regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    SelectSQL.Strings = (
      'select ar.id,ar.name, ar.full_name from all_regions ar')
    Left = 200
    Top = 112
    object dset_regionsID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_regionsNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
    object dset_regionsFULL_NAME: TIBStringField
      FieldKind = fkInternalCalc
      FieldName = 'FULL_NAME'
      Origin = '"ALL_REGIONS"."FULL_NAME"'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
end
