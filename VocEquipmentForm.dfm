inherited frm_VocEquipment: Tfrm_VocEquipment
  Left = 240
  Top = 283
  Width = 669
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Width = 661
  end
  inherited pnl_EditFields: TPanel
    Top = 233
    Width = 661
    Height = 48
    object lbl_EquipName: TLabel
      Left = 8
      Top = 5
      Width = 146
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_EquipNumber: TLabel
      Left = 206
      Top = 5
      Width = 100
      Height = 13
      Caption = #8470' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Region: TLabel
      Left = 329
      Top = 5
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
    object lbl_VocRecType: TLabel
      Left = 484
      Top = 5
      Width = 69
      Height = 13
      Caption = #1058#1080#1087' '#1079#1072#1087#1080#1089#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_EquipName: TDBEdit
      Left = 8
      Top = 21
      Width = 186
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object ed_EquipNumber: TDBEdit
      Left = 212
      Top = 21
      Width = 101
      Height = 21
      DataField = 'NUMBER'
      DataSource = ds_MainVoc
      TabOrder = 1
      OnChange = CtrlsChange
    end
    object dbl_Region: TRxDBLookupCombo
      Left = 328
      Top = 21
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'ID_REGION'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Region
      TabOrder = 2
    end
    object dbl_VocRecType: TRxDBLookupCombo
      Left = 484
      Top = 20
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'ID_VOCRECTYPE'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_VocRecType
      TabOrder = 3
    end
  end
  inherited pnl_Grid: TPanel
    Width = 661
    Height = 233
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Width = 662
      Height = 232
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMBER'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #8470' '#1086#1073#1086#1088'.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'luf_REGION'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1081#1086#1085
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 152
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'luf_VOCRECTYPE'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1079#1072#1087#1080#1089#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 124
          Visible = True
        end>
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Active = True
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      
        'insert into equipment(id, name, number, id_region, id_vocrectype' +
        ')'
      'values(:id, :name, :number, :id_region, :id_vocrectype)')
    SelectSQL.Strings = (
      'select e.id, e.name, e.number,'
      'e.id_region, e.id_vocrectype, e.activity'
      'from equipment e'
      'left join s_regions sr on sr.id = e.id_region'
      'left join s_vocrectype svrt on svrt.id = e.id_vocrectype'
      'where e.id<>-1'
      'order by sr.name, svrt.name, e.name, e.number')
    ModifySQL.Strings = (
      'update equipment set'
      'name=:name,'
      'number=:number,'
      'id_region=:id_region,'
      'id_vocrectype=:id_vocrectype,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_EQUIPMENT'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'EQUIPMENT.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'EQUIPMENT.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 36
    end
    object dset_MainVocNUMBER: TIntegerField
      FieldName = 'NUMBER'
      Origin = 'EQUIPMENT.NUMBER'
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'EQUIPMENT.ACTIVITY'
      FixedChar = True
      Size = 1
    end
    object dset_MainVocID_REGION: TIntegerField
      FieldName = 'ID_REGION'
      Origin = '"EQUIPMENT"."ID_REGION"'
    end
    object dset_MainVocID_VOCRECTYPE: TIntegerField
      FieldName = 'ID_VOCRECTYPE'
      Origin = '"EQUIPMENT"."ID_VOCRECTYPE"'
    end
    object dset_MainVocluf_REGION: TStringField
      FieldKind = fkLookup
      FieldName = 'luf_REGION'
      LookupDataSet = dset_Region
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'ID_REGION'
      Size = 32
      Lookup = True
    end
    object dset_MainVocluf_VOCRECTYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'luf_VOCRECTYPE'
      LookupDataSet = dset_VocRecType
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'ID_VOCRECTYPE'
      Size = 25
      Lookup = True
    end
  end
  object dset_Region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_regions'
      'where activity is null'
      'order by name')
    Left = 304
    Top = 144
    object dset_RegionID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_REGIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_RegionNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_REGIONS"."NAME"'
      FixedChar = True
      Size = 32
    end
  end
  object dset_VocRecType: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_vocrectype'
      'order by name')
    Left = 480
    Top = 144
    object dset_VocRecTypeID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_VOCRECTYPE"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_VocRecTypeNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_VOCRECTYPE"."NAME"'
      Size = 25
    end
  end
  object ds_Region: TDataSource
    DataSet = dset_Region
    Left = 336
    Top = 160
  end
  object ds_VocRecType: TDataSource
    DataSet = dset_VocRecType
    Left = 520
    Top = 160
  end
end
