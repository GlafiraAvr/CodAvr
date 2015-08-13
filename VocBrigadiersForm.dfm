inherited frm_VocBrigadiers: Tfrm_VocBrigadiers
  Left = 410
  Top = 205
  Width = 335
  Height = 291
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074' '#1073#1088#1080#1075#1072#1076#1080#1088#1086#1074
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 210
    Width = 327
  end
  inherited pnl_EditFields: TPanel
    Top = 112
    Width = 327
    Height = 98
    object lbl_Name: TLabel
      Left = 25
      Top = 71
      Width = 57
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_reg: TLabel
      Left = 42
      Top = 44
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
    object ed_Name: TDBEdit
      Left = 85
      Top = 69
      Width = 238
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object rg_Type: TRadioGroup
      Left = 8
      Top = 0
      Width = 313
      Height = 34
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        #1058#1055#1054
        #1056#1072#1081#1086#1085#1072
        #1055#1088#1086#1095#1080#1077)
      ParentFont = False
      TabOrder = 1
      OnClick = rg_TypeClick
    end
    object dbl_Reg: TRxDBLookupCombo
      Left = 84
      Top = 40
      Width = 237
      Height = 21
      DropDownCount = 8
      LookupField = 'NAME'
      LookupDisplay = 'NAME'
      LookupSource = ds_Reg
      TabOrder = 2
      OnChange = rg_TypeClick
    end
  end
  inherited pnl_Grid: TPanel
    Width = 327
    Height = 112
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Width = 328
      Height = 111
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1060#1072#1084#1080#1083#1080#1103
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 281
          Visible = True
        end>
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Active = True
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into brigadiers(id, name, fk_brigadiers_regions)'
      'values(:id, :name, :fk_brigadiers_regions)')
    SelectSQL.Strings = (
      'select id, name, activity, fk_brigadiers_regions'
      'from brigadiers'
      'where id<>-1'
      '/*'
      'and fk_brigadiers_regions=:pID_REG'
      '*/'
      'order by name')
    ModifySQL.Strings = (
      'update brigadiers set'
      'name=:name,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_BRIGADIERS'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'BRIGADIERS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'BRIGADIERS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'BRIGADIERS.ACTIVITY'
      FixedChar = True
      Size = 18
    end
    object dset_MainVocFK_BRIGADIERS_REGIONS: TIntegerField
      FieldName = 'FK_BRIGADIERS_REGIONS'
    end
  end
  object dset_Reg: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from s_regions'
      'where (id<>-1)'
      'order by name')
    Left = 200
    Top = 64
  end
  object ds_Reg: TDataSource
    DataSet = dset_Reg
    Left = 256
    Top = 64
  end
end
