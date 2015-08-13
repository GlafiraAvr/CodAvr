inherited frm_VocSOMsg: Tfrm_VocSOMsg
  Left = 419
  Top = 278
  Height = 298
  Caption = '0-62 ('#1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086')'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 210
  end
  inherited pnl_EditFields: TPanel
    Top = 176
    Height = 34
    object ed_Name: TDBEdit
      Left = 8
      Top = 8
      Width = 313
      Height = 21
      DataField = 'NAME_'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Height = 176
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Height = 175
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 299
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_subordermsg(id, name_)'
      'values(:id, :name_)')
    SelectSQL.Strings = (
      'select id, name_, activity'
      'from s_subordermsg'
      'where id>-1'
      'order by name_')
    ModifySQL.Strings = (
      'update s_subordermsg set'
      'name_=:name_,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_SUBORDERMSG_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_SUBORDERMSG"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME_: TIBStringField
      FieldName = 'NAME_'
      Origin = '"S_SUBORDERMSG"."NAME_"'
      Size = 32
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_SUBORDERMSG"."ACTIVITY"'
    end
  end
end
