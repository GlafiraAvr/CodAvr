inherited frm_VocWorkerPost: Tfrm_VocWorkerPost
  Left = 436
  Top = 386
  Height = 273
  Caption = #1057#1087#1088#1074#1086#1095#1085#1080#1082' '#1082#1072#1090#1077#1075#1086#1088#1080#1081' '#1089#1083#1077#1089#1072#1088#1077#1081
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 192
  end
  inherited pnl_EditFields: TPanel
    Top = 164
    Height = 28
    object ed_Name: TDBEdit
      Left = 4
      Top = 3
      Width = 325
      Height = 21
      DataField = 'NAME_'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Height = 164
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 156
      ReadOnly = True
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 305
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into'
      's_workerpost(id, name_)'
      'values(:id, :name_)')
    SelectSQL.Strings = (
      'select id, name_, activity'
      'from s_workerpost'
      'where id>0'
      'order by name_')
    ModifySQL.Strings = (
      'update s_workerpost set'
      'name_ = :name_,'
      'activity = :activity'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_WORKERPOST_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKERPOST"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME_: TIBStringField
      FieldName = 'NAME_'
      Origin = '"S_WORKERPOST"."NAME_"'
      Size = 40
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_WORKERPOST"."ACTIVITY"'
    end
  end
end
