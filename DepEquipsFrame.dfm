inherited frame_DepEquips: Tframe_DepEquips
  inherited DBGrid: TDBGridEh
    Top = 49
    Height = 285
    UseMultiTitle = True
    OnDrawColumnCell = DBGridDrawColumnCell
    Columns = <
      item
        FieldName = 'EQUIP'
        Footers = <>
        Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Width = 290
      end>
  end
  inherited pnl_Fields: TPanel
    Height = 49
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 86
      Height = 13
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Equips: TRxDBLookupCombo
      Left = 104
      Top = 8
      Width = 489
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPEQUIPS_EQUIP'
      DataSource = ds_Main
      LookupField = 'id'
      LookupDisplay = 'fl_FULL_NAME'
      LookupSource = ds_Equips
      TabOrder = 0
    end
  end
  object ds_Equips: TDataSource
    DataSet = dm_EquipsVocCache.cds_Equips
    Left = 264
    Top = 16
  end
end
