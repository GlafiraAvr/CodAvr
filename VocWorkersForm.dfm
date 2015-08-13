inherited frm_VocWorkers: Tfrm_VocWorkers
  Left = 361
  Top = 224
  Width = 339
  Height = 385
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1089#1083#1077#1089#1072#1088#1077#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 304
    Width = 331
  end
  inherited pnl_EditFields: TPanel
    Top = 252
    Width = 331
    Height = 52
    object lbl_Name: TLabel
      Left = 46
      Top = 8
      Width = 31
      Height = 13
      Caption = #1060#1048#1054
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Post: TLabel
      Left = 8
      Top = 30
      Width = 68
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_Name: TDBEdit
      Left = 80
      Top = 4
      Width = 241
      Height = 21
      DataField = 'NAME'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
    object dbl_Post: TRxDBLookupCombo
      Left = 80
      Top = 27
      Width = 241
      Height = 21
      DropDownCount = 8
      DataField = 'ID_WORKERPOST'
      DataSource = ds_MainVoc
      LookupField = 'ID'
      LookupDisplay = 'NAME_'
      LookupSource = ds_WorkerPost
      TabOrder = 1
    end
  end
  inherited pnl_Grid: TPanel
    Width = 331
    Height = 252
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 243
      Anchors = [akLeft]
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1060#1048#1054
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 186
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lp_WorkerPost'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 126
          Visible = True
        end>
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Left = 24
    Top = 32
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into workers(name, id_workerpost)'
      'values(:name, :id_workerpost)')
    SelectSQL.Strings = (
      'select id, name, id_workerpost, activity'
      'from workers'
      'where id>0'
      'order by name')
    ModifySQL.Strings = (
      'update workers set'
      'name=:name,'
      'id_workerpost=:id_workerpost,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_WORKERS_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 72
    Top = 40
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"WORKERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"WORKERS"."NAME"'
      FixedChar = True
      Size = 64
    end
    object dset_MainVocID_WORKERPOST: TIntegerField
      FieldName = 'ID_WORKERPOST'
      Origin = '"WORKERS"."ID_WORKERPOST"'
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = '"WORKERS"."ACTIVITY"'
      FixedChar = True
      Size = 1
    end
    object dset_MainVoclp_WorkerPost: TStringField
      FieldKind = fkLookup
      FieldName = 'lp_WorkerPost'
      LookupDataSet = dset_WorkerPost
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME_'
      KeyFields = 'ID_WORKERPOST'
      Lookup = True
    end
  end
  inherited ds_MainVoc: TDataSource
    Top = 40
  end
  object dset_WorkerPost: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name_'
      'from s_workerpost'
      'where activity is null'
      'order by name_')
    Left = 200
    Top = 160
    object dset_WorkerPostID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKERPOST"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorkerPostNAME_: TIBStringField
      FieldName = 'NAME_'
      Origin = '"S_WORKERPOST"."NAME_"'
      Size = 40
    end
  end
  object ds_WorkerPost: TDataSource
    DataSet = dset_WorkerPost
    Left = 240
    Top = 176
  end
end
