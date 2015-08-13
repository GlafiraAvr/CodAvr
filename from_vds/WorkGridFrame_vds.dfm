inherited frame_WorkGrid_vds: Tframe_WorkGrid_vds
  Width = 422
  Height = 252
  inherited DBGrid: TDBGridEh
    Top = 120
    Columns = <
      item
        FieldName = 'WORK_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
        Width = 167
      end
      item
        FieldName = 'DIAM'
        Footers = <>
        Title.Caption = #1044#1080#1072#1084#1077#1090#1088
      end
      item
        FieldName = 'QUANTITY'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      item
        FieldName = 'boolSenet_1562'
        Footers = <>
        Title.Caption = #1054#1090'-'#1090#1100' '#1074' 1562'
      end>
  end
  inherited pnl_Fields: TPanel
    Height = 109
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 136
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 40
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
    object Label3: TLabel
      Left = 16
      Top = 64
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
    object dbl_Work: TRxDBLookupCombo
      Left = 160
      Top = 8
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPWORK_WORKS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Work
      TabOrder = 0
    end
    object dbl_Diam: TRxDBLookupCombo
      Left = 160
      Top = 40
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPWORK_DIAMETER'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'DIAMETER'
      LookupSource = ds_Diam
      TabOrder = 1
    end
    object ed_Quantity: TDBEdit
      Left = 160
      Top = 64
      Width = 121
      Height = 21
      DataField = 'QUANTITY'
      DataSource = ds_Main
      TabOrder = 2
    end
    object DBCheckBox1: TDBCheckBox
      Left = 264
      Top = 8
      Width = 153
      Height = 17
      Alignment = taLeftJustify
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074' 1562'
      DataField = 'SENT_1562'
      DataSource = ds_Main
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  inherited dset_Main: TIBDataSet
    BeforePost = dset_MainBeforePost
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from DEPARTUREWORK_vds where ID=:OLD_ID')
    InsertSQL.Strings = (
      'insert into DEPARTUREWORK_vds('
      'FK_DEPWORK_ORDERS, '
      'FK_DEPWORK_DEPARTURE,'
      'FK_DEPWORK_WORKS, '
      'FK_DEPWORK_DIAMETER, '
      'QUANTITY, '
      'ISPAYED ,'
      'SENT_1562)'
      ''
      'values('
      ':FK_DEPWORK_ORDERS, '
      ':FK_DEPWORK_DEPARTURE,'
      ':FK_DEPWORK_WORKS, '
      ':FK_DEPWORK_DIAMETER, '
      ':QUANTITY, '
      ':ISPAYED,'
      ':SENT_1562)')
    SelectSQL.Strings = (
      'select ID, FK_DEPWORK_ORDERS, FK_DEPWORK_DEPARTURE,'
      ' FK_DEPWORK_WORKS, FK_DEPWORK_DIAMETER, '
      'QUANTITY, ISPAYED,'
      
        '(select name from s_works where id=dw.fk_depwork_works) WORK_NAM' +
        'E,'
      
        '(select diameter from s_tubediameter where id=dw.fk_depwork_diam' +
        'eter) DIAM, '
      'SENT_1562'
      'from DEPARTUREWORK_vds dw'
      'where (FK_DEPWORK_ORDERS=:pOrderID) and'
      '(FK_DEPWORK_DEPARTURE=:pDepID) ')
    ModifySQL.Strings = (
      'update DEPARTUREWORK_vds set'
      'FK_DEPWORK_WORKS=:FK_DEPWORK_WORKS, '
      'FK_DEPWORK_DIAMETER=:FK_DEPWORK_DIAMETER, '
      'QUANTITY=:QUANTITY,'
      'sent_1562=:sent_1562'
      'where ID=:ID ')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTUREWORK_vds_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREWORK_VDS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_DEPWORK_ORDERS: TIntegerField
      FieldName = 'FK_DEPWORK_ORDERS'
      Origin = '"DEPARTUREWORK_VDS"."FK_DEPWORK_ORDERS"'
    end
    object dset_MainFK_DEPWORK_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPWORK_DEPARTURE'
      Origin = '"DEPARTUREWORK_VDS"."FK_DEPWORK_DEPARTURE"'
    end
    object dset_MainFK_DEPWORK_WORKS: TIntegerField
      FieldName = 'FK_DEPWORK_WORKS'
      Origin = '"DEPARTUREWORK_VDS"."FK_DEPWORK_WORKS"'
    end
    object dset_MainFK_DEPWORK_DIAMETER: TIntegerField
      FieldName = 'FK_DEPWORK_DIAMETER'
      Origin = '"DEPARTUREWORK_VDS"."FK_DEPWORK_DIAMETER"'
    end
    object dset_MainQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREWORK_VDS"."QUANTITY"'
      Precision = 18
      Size = 2
    end
    object dset_MainISPAYED: TSmallintField
      FieldName = 'ISPAYED'
      Origin = '"DEPARTUREWORK_VDS"."ISPAYED"'
    end
    object dset_MainWORK_NAME: TIBStringField
      FieldName = 'WORK_NAME'
      ProviderFlags = []
      Size = 50
    end
    object dset_MainDIAM: TIntegerField
      FieldName = 'DIAM'
      ProviderFlags = []
    end
    object dset_MainboolSenet_1562: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'boolSenet_1562'
      Calculated = True
    end
    object dset_MainSENT_1562: TSmallintField
      FieldName = 'SENT_1562'
      Origin = '"DEPARTUREWORK_VDS"."SENT_1562"'
    end
  end
  inherited tr_Main: TIBTransaction
    Active = True
  end
  object dset_Work: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Voc
    SelectSQL.Strings = (
      'select id, name'
      'from s_works'
      'where (id>0)'
      'and (activity is null)'
      'order by name')
    Left = 216
    Top = 112
  end
  object ds_Diam: TDataSource
    DataSet = dset_Diam
    Left = 288
    Top = 152
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
    Left = 288
    Top = 112
  end
  object ds_Work: TDataSource
    DataSet = dset_Work
    Left = 216
    Top = 144
  end
end
