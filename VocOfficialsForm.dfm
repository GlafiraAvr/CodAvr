inherited frm_VocOfficials: Tfrm_VocOfficials
  Left = 604
  Top = 159
  Height = 289
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1086#1083#1078#1085#1086#1089#1090#1085#1099#1093' '#1083#1080#1094
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 201
    inherited btn_Cancel: TBitBtn
      Top = 28
    end
    inherited btn_Exit: TBitBtn
      Top = 28
    end
  end
  inherited pnl_EditFields: TPanel
    Top = 155
    Height = 46
    object lbl_Name: TLabel
      Left = 16
      Top = 1
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
    object lbl_Post: TLabel
      Left = 168
      Top = 1
      Width = 23
      Height = 13
      Caption = #1058#1080#1087
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Name: TDBEdit
      Left = 16
      Top = 15
      Width = 145
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
    object dbl_Post: TRxDBLookupCombo
      Left = 167
      Top = 15
      Width = 154
      Height = 21
      DropDownCount = 8
      DataField = 'FK_OFFIC_OFFICPOST'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Post
      TabOrder = 1
    end
  end
  inherited pnl_Grid: TPanel
    Height = 155
    DesignSize = (
      332
      155)
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 161
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
          Width = 163
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lufPOST'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 144
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_officials(id,name, FK_OFFIC_OFFICPOST)'
      'values(:id,:name, :FK_OFFIC_OFFICPOST)')
    SelectSQL.Strings = (
      'select id, name, FK_OFFIC_OFFICPOST, activity'
      'from s_officials'
      'where id<>-1'
      'order by name')
    ModifySQL.Strings = (
      'update s_officials set'
      'name=:name,'
      'FK_OFFIC_OFFICPOST=:FK_OFFIC_OFFICPOST,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_OFFICIALS_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_OFFICIALS.ID'
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = 'S_OFFICIALS.NAME'
      OnGetText = GetText
      FixedChar = True
      Size = 64
    end
    object dset_MainVocFK_OFFIC_OFFICPOST: TIntegerField
      FieldName = 'FK_OFFIC_OFFICPOST'
      Origin = '"S_OFFICIALS"."FK_OFFIC_OFFICPOST"'
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_OFFICIALS.ACTIVITY'
      FixedChar = True
      Size = 18
    end
    object dset_MainVoclufPOST: TStringField
      FieldKind = fkLookup
      FieldName = 'lufPOST'
      LookupDataSet = dset_Post
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'FK_OFFIC_OFFICPOST'
      Lookup = True
    end
  end
  object dset_Post: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name from s_officialposts')
    Left = 256
    Top = 120
  end
  object ds_Post: TDataSource
    DataSet = dset_Post
    Left = 216
    Top = 120
  end
end
