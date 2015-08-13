inherited frm_VocSOAbon: Tfrm_VocSOAbon
  Left = 386
  Top = 279
  Height = 259
  Caption = '0-62('#1055#1086#1089#1090#1091#1087#1080#1083#1086' '#1086#1090')'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 171
  end
  inherited pnl_EditFields: TPanel
    Top = 139
    Height = 32
    object ed_Name: TDBEdit
      Left = 4
      Top = 6
      Width = 317
      Height = 21
      DataField = 'NAME_'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Height = 139
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 138
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
  inherited Tr_MainVoc: TIBTransaction
    Active = True
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_suborderabon(id, name_)'
      'values(:id, :name_)')
    SelectSQL.Strings = (
      'select id, name_, activity'
      'from s_suborderabon'
      'where id>0'
      'order by name_')
    ModifySQL.Strings = (
      'update s_suborderabon set'
      'name_=:name_,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_SUBORDERABON_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_SUBORDERABON"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME_: TIBStringField
      FieldName = 'NAME_'
      Origin = '"S_SUBORDERABON"."NAME_"'
      Size = 32
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_SUBORDERABON"."ACTIVITY"'
    end
  end
end
