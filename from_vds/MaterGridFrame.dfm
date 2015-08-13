inherited frame_MaterGrid: Tframe_MaterGrid
  Width = 535
  inherited DBGrid: TDBGridEh
    Left = 8
    Columns = <
      item
        FieldName = 'MATER_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
        Width = 218
      end
      item
        FieldName = 'QUANTITY'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 101
      end
      item
        FieldName = 'DIAM'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1080#1072#1084#1077#1090#1088
      end
      item
        FieldName = 'MATPRICES'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1085#1082'.'#1085#1086#1084#1077#1088'/'#1094#1077#1085#1072'/'#1082#1086#1083'-'#1074#1086
        Width = 183
      end>
  end
  inherited pnl_Fields: TPanel
    Left = 8
    Width = 497
    object Label1: TLabel
      Left = 8
      Top = 16
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
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 70
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 72
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
    object Label4: TLabel
      Left = 264
      Top = 16
      Width = 171
      Height = 13
      Caption = #1053#1086#1084#1077#1085#1082'. '#1085#1086#1084#1077#1088'/'#1094#1077#1085#1072'/'#1082#1086#1083'-'#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbl_Mater: TRxDBLookupCombo
      Left = 80
      Top = 13
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_USEDMATERIALS_MATERIALS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Mater
      TabOrder = 0
      OnChange = dbl_MaterChange
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object ed_quantity: TDBEdit
      Left = 83
      Top = 41
      Width = 121
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Main
      TabOrder = 1
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 80
      Top = 69
      Width = 97
      Height = 21
      DropDownCount = 8
      DataField = 'FK_USEDMATERIALS_DIAMETER'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'DIAMETER'
      LookupSource = ds_Diam
      TabOrder = 2
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object dbl_MatPrices: TRxDBLookupCombo
      Left = 296
      Top = 32
      Width = 145
      Height = 21
      DropDownCount = 8
      LookupField = 'ID'
      LookupDisplay = 'NUMBER'
      LookupSource = ds_MatPrices
      TabOrder = 3
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
  end
  inherited dset_Main: TIBDataSet
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from DEPARTUREMATERIALS where id=:old_id')
    InsertSQL.Strings = (
      'insert into DEPARTUREMATERIALS('
      'FK_USEDMATERIALS_ORDERS, '
      'FK_USEDMATERIALS_DEPARTURE, '
      'FK_USEDMATERIALS_MATERIALS,'
      'ISPAYED, '
      'QUANTITY,'
      'FK_USEDMATERIALS_DIAMETER,'
      'NOMENNUMBER, '
      'PRICE, '
      'MATPRICES_QUANTITY'
      ') '
      'values('
      ':FK_USEDMATERIALS_ORDERS, '
      ':FK_USEDMATERIALS_DEPARTURE, '
      ':FK_USEDMATERIALS_MATERIALS,'
      ':ISPAYED, '
      ':QUANTITY,'
      ':FK_USEDMATERIALS_DIAMETER,'
      ':NOMENNUMBER, '
      ':PRICE, '
      ':MATPRICES_QUANTITY'
      ')')
    SelectSQL.Strings = (
      
        'select ID, FK_USEDMATERIALS_ORDERS, FK_USEDMATERIALS_DEPARTURE, ' +
        'FK_USEDMATERIALS_MATERIALS, '
      
        'ISPAYED, QUANTITY, FK_USEDMATERIALS_DIAMETER, NOMENNUMBER, PRICE' +
        ', MATPRICES_QUANTITY,'
      
        '(select rtrim(name)||'#39' ('#39'||rtrim(measurement)||'#39')'#39' from material' +
        's where id=dm.fk_usedmaterials_materials) MATER_NAME,'
      
        '(select diameter from s_tubediameter where id=dm.fk_usedmaterial' +
        's_diameter) DIAM'
      'from DEPARTUREMATERIALS dm'
      'where (FK_USEDMATERIALS_ORDERS=:pOrderID) and'
      '(FK_USEDMATERIALS_DEPARTURE=:pDepID) ')
    ModifySQL.Strings = (
      'update DEPARTUREMATERIALS set'
      'FK_USEDMATERIALS_MATERIALS=:FK_USEDMATERIALS_MATERIALS,'
      'QUANTITY=:QUANTITY,'
      'FK_USEDMATERIALS_DIAMETER=:FK_USEDMATERIALS_DIAMETER,'
      'NOMENNUMBER=:NOMENNUMBER, '
      'PRICE=:PRICE, '
      'MATPRICES_QUANTITY=:MATPRICES_QUANTITY'
      'where ID=:ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPMATERIALS'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREMATERIALS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_USEDMATERIALS_ORDERS: TIntegerField
      FieldName = 'FK_USEDMATERIALS_ORDERS'
      Origin = '"DEPARTUREMATERIALS"."FK_USEDMATERIALS_ORDERS"'
      Required = True
    end
    object dset_MainFK_USEDMATERIALS_DEPARTURE: TIntegerField
      FieldName = 'FK_USEDMATERIALS_DEPARTURE'
      Origin = '"DEPARTUREMATERIALS"."FK_USEDMATERIALS_DEPARTURE"'
      Required = True
    end
    object dset_MainFK_USEDMATERIALS_MATERIALS: TIntegerField
      FieldName = 'FK_USEDMATERIALS_MATERIALS'
      Origin = '"DEPARTUREMATERIALS"."FK_USEDMATERIALS_MATERIALS"'
      Required = True
    end
    object dset_MainFK_USEDMATERIALS_DIAMETER: TIntegerField
      FieldName = 'FK_USEDMATERIALS_DIAMETER'
      Origin = '"DEPARTUREMATERIALS"."FK_USEDMATERIALS_DIAMETER"'
    end
    object dset_MainQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREMATERIALS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MainISPAYED: TSmallintField
      FieldName = 'ISPAYED'
      Origin = '"DEPARTUREMATERIALS"."ISPAYED"'
    end
    object dset_MainMATER_NAME: TIBStringField
      FieldName = 'MATER_NAME'
      ProviderFlags = []
      FixedChar = True
      Size = 50
    end
    object dset_MainDIAM: TIntegerField
      FieldName = 'DIAM'
      ProviderFlags = []
    end
    object dset_MainNOMENNUMBER: TIBStringField
      FieldName = 'NOMENNUMBER'
      Origin = '"DEPARTUREMATERIALS"."NOMENNUMBER"'
      Size = 15
    end
    object dset_MainPRICE: TIBBCDField
      FieldName = 'PRICE'
      Origin = '"DEPARTUREMATERIALS"."PRICE"'
      Precision = 18
      Size = 2
    end
    object dset_MainMATPRICES_QUANTITY: TIBBCDField
      FieldName = 'MATPRICES_QUANTITY'
      Origin = '"DEPARTUREMATERIALS"."MATPRICES_QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MainMATPRICES: TStringField
      FieldKind = fkCalculated
      FieldName = 'MATPRICES'
      Calculated = True
    end
  end
  object ds_Mater: TDataSource
    DataSet = dset_Mater
    Left = 424
    Top = 152
  end
  object dset_Mater: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, rtrim(name)||'#39' ('#39'||rtrim(measurement)||'#39')'#39' name'
      'from materials'
      'where (id>0)'
      'and (activity is null)'
      'order by name')
    Left = 424
    Top = 120
  end
  object dset_Diam: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, diameter'
      'from s_tubediameter'
      'where (id>0)'
      'and (activity is null)'
      'order by diameter')
    Left = 488
    Top = 120
  end
  object ds_Diam: TDataSource
    DataSet = dset_Diam
    Left = 496
    Top = 152
  end
  object dset_MatPrices: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id,'
      'number, price, quantity, quantityrest'
      'from materialprices'
      'where fk_matprices_materials=:id'
      'order by price')
    DataSource = ds_Mater
    Left = 456
    Top = 16
    object dset_MatPricesID: TIntegerField
      FieldName = 'ID'
      Origin = '"MATERIALPRICES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MatPricesNUMBER: TIBStringField
      FieldName = 'NUMBER'
      Origin = '"MATERIALPRICES"."NUMBER"'
      OnGetText = dset_MatPricesNUMBERGetText
      Size = 15
    end
    object dset_MatPricesPRICE: TIBBCDField
      FieldName = 'PRICE'
      Origin = '"MATERIALPRICES"."PRICE"'
      Precision = 18
      Size = 2
    end
    object dset_MatPricesQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"MATERIALPRICES"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MatPricesQUANTITYREST: TIBBCDField
      FieldName = 'QUANTITYREST'
      Origin = '"MATERIALPRICES"."QUANTITYREST"'
      Precision = 18
      Size = 2
    end
  end
  object ds_MatPrices: TDataSource
    DataSet = dset_MatPrices
    Left = 456
    Top = 48
  end
end
