inherited frame_DepMaters: Tframe_DepMaters
  inherited DBGrid: TDBGridEh
    UseMultiTitle = True
    Columns = <
      item
        FieldName = 'MATER'
        Footers = <>
        Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
        Width = 180
      end
      item
        FieldName = 'DIAM'
        Footers = <>
        Title.Caption = #1044#1080#1072#1084#1077#1090#1077#1088
        Width = 88
      end
      item
        FieldName = 'QUANTITY'
        Footers = <>
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 73
      end>
  end
  inherited pnl_Fields: TPanel
    Left = 64
    Width = 513
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 50
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 46
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
    end
    object Label3: TLabel
      Left = 16
      Top = 88
      Width = 59
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
    end
    object dbl_Maters: TRxDBLookupCombo
      Left = 72
      Top = 16
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPMATERS_MATER'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'name_r'
      LookupSource = ds_Maters
      TabOrder = 0
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 72
      Top = 48
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPMATERS_DIAMETER'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'diameter'
      LookupSource = ds_Diam
      TabOrder = 1
    end
    object ed_Quantity: TDBEdit
      Left = 80
      Top = 88
      Width = 121
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Main
      TabOrder = 2
    end
  end
  inherited ds_Main: TDataSource
    Left = 368
    Top = 104
  end
  object ds_Maters: TDataSource
    DataSet = dm_MatersVocCache.cds_Maters
    Left = 232
    Top = 8
  end
  object ds_Diam: TDataSource
    DataSet = dm_MatersVocCache.cds_Diam
    Left = 232
    Top = 48
  end
end
