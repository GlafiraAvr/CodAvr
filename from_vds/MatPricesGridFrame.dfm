inherited frame_MatPricesGrid: Tframe_MatPricesGrid
  Width = 468
  Height = 304
  inherited DBGrid: TDBGridEh
    Top = 208
    Height = 89
    UseMultiTitle = True
    Columns = <
      item
        FieldName = 'REGIONS'
        Footers = <>
        Title.Caption = #1056#1072#1081#1086#1085
        Width = 130
      end
      item
        FieldName = 'NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#1085#1086#1084#1077#1088
        Width = 138
      end
      item
        FieldName = 'PRICE'
        Footers = <>
        Title.Caption = #1062#1077#1085#1072
      end
      item
        FieldName = 'QUANTITY'
        Footers = <>
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      item
        FieldName = 'QUANTITYREST'
        Footers = <>
        Title.Caption = #1054#1089#1090#1072#1090#1086#1082
      end>
  end
  inherited pnl_Fields: TPanel
    Left = 16
    Top = 43
    Height = 150
    Color = clMoneyGreen
    object Label2: TLabel
      Left = 24
      Top = 8
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
    object Label3: TLabel
      Left = 8
      Top = 32
      Width = 107
      Height = 26
      Alignment = taCenter
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1099#1081' '#13#10#1085#1086#1084#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 56
      Top = 64
      Width = 31
      Height = 13
      Caption = #1062#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Top = 88
      Width = 41
      Height = 13
      Caption = #1050#1086#1083'-'#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 32
      Top = 112
      Width = 50
      Height = 13
      Caption = #1054#1089#1090#1072#1090#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Regions: TRxDBLookupCombo
      Left = 112
      Top = 8
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_MATPRICES_REGIONS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Regions
      TabOrder = 0
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object ed_Number: TDBEdit
      Left = 112
      Top = 32
      Width = 89
      Height = 21
      DataField = 'NUMBER'
      DataSource = ds_Main
      TabOrder = 1
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object ed_Price: TDBEdit
      Left = 112
      Top = 56
      Width = 121
      Height = 21
      DataField = 'PRICE'
      DataSource = ds_Main
      TabOrder = 2
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object ed_Quantity: TDBEdit
      Left = 80
      Top = 80
      Width = 121
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Main
      TabOrder = 3
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object ed_QuantityRest: TDBEdit
      Left = 80
      Top = 104
      Width = 121
      Height = 21
      DataField = 'QUANTITYREST'
      DataSource = ds_Main
      TabOrder = 4
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
  end
  object pnl_Master: TPanel [2]
    Left = 16
    Top = 2
    Width = 401
    Height = 41
    BevelInner = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 59
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Mater: TRxDBLookupCombo
      Left = 80
      Top = 6
      Width = 161
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'name;measurement'
      LookupSource = ds_Mater
      TabOrder = 0
    end
  end
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from materialprices where id=:old_id')
    InsertSQL.Strings = (
      'insert into materialprices('
      '   fk_matprices_regions,'
      '   fk_matprices_materials,'
      '   number, '
      '   price, '
      '   quantity, '
      '   quantityrest)'
      'values('
      '   :fk_matprices_regions,'
      '   :fk_matprices_materials,'
      '   :number, '
      '   :price, '
      '   :quantity, '
      '   :quantityrest)')
    SelectSQL.Strings = (
      'select id,'
      'fk_matprices_regions,'
      
        '(select name from s_regions where id=mp.fk_matprices_regions) re' +
        'gions,'
      'fk_matprices_materials,'
      'number, price, quantity, quantityrest'
      'from materialprices mp'
      'where fk_matprices_materials=:id'
      'order by 2')
    ModifySQL.Strings = (
      'update materialprices set'
      '   fk_matprices_regions=:fk_matprices_regions,'
      '   fk_matprices_materials=:fk_matprices_materials,'
      '   number=:number, '
      '   price=:price, '
      '   quantity=:quantity, '
      '   quantityrest=:quantityrest'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_MATERIALPRICES_ID'
    GeneratorField.ApplyEvent = gamOnServer
    DataSource = ds_Mater
    Left = 176
    Top = 224
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"MATERIALPRICES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_MATPRICES_REGIONS: TIntegerField
      FieldName = 'FK_MATPRICES_REGIONS'
      Origin = '"MATERIALPRICES"."FK_MATPRICES_REGIONS"'
    end
    object dset_MainREGIONS: TIBStringField
      FieldName = 'REGIONS'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object dset_MainFK_MATPRICES_MATERIALS: TIntegerField
      FieldName = 'FK_MATPRICES_MATERIALS'
      Origin = '"MATERIALPRICES"."FK_MATPRICES_MATERIALS"'
    end
    object dset_MainNUMBER: TIBStringField
      FieldName = 'NUMBER'
      Origin = '"MATERIALPRICES"."NUMBER"'
      Size = 15
    end
    object dset_MainPRICE: TIBBCDField
      FieldName = 'PRICE'
      Origin = '"MATERIALPRICES"."PRICE"'
      Precision = 18
      Size = 2
    end
    object dset_MainQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"MATERIALPRICES"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MainQUANTITYREST: TIBBCDField
      FieldName = 'QUANTITYREST'
      Origin = '"MATERIALPRICES"."QUANTITYREST"'
      Precision = 18
      Size = 2
    end
  end
  inherited tr_Main: TIBTransaction
    Top = 224
  end
  inherited ds_Main: TDataSource
    Left = 64
    Top = 224
  end
  inherited tr_Voc: TIBTransaction
    Left = 376
    Top = 232
  end
  object dset_Mater: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      
        'select id, rtrim(name)||'#39' ('#39'||rtrim(measurement)||'#39')'#39' name,  mea' +
        'surement'
      'from materials'
      'where (activity is null)'
      'order by name')
    Left = 280
    Top = 8
  end
  object ds_Mater: TDataSource
    DataSet = dset_Mater
    Left = 312
    Top = 8
  end
  object dset_Regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, name '
      'from s_regions ')
    Left = 264
    Top = 232
  end
  object ds_Regions: TDataSource
    DataSet = dset_Regions
    Left = 312
    Top = 232
  end
end
