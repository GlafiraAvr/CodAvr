inherited dm_Flooding: Tdm_Flooding
  OldCreateOrder = True
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from flooding where id=:id')
    InsertSQL.Strings = (
      'insert into FLOODING'
      '(FK_ID_ORDER, '
      ' ABOUT) '
      'values'
      '(:FK_ID_ORDER,'
      ':ABOUT'
      ')')
    SelectSQL.Strings = (
      
        'select  ID,FK_ID_ORDER, ABOUT  from FLOODING where FK_ID_ORDER=:' +
        'id_order')
    ModifySQL.Strings = (
      'update FLOODING set'
      ' ABOUT=:ABOUT'
      'where'
      'id=:ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_FLOODING_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainFK_ID_ORDER: TIntegerField
      FieldName = 'FK_ID_ORDER'
      Origin = '"FLOODING"."FK_ID_ORDER"'
      Required = True
    end
    object dset_MainABOUT: TIBStringField
      FieldName = 'ABOUT'
      Origin = '"FLOODING"."ABOUT"'
      Size = 2000
    end
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"FLOODING"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  inherited tran_Main: TIBTransaction
    Active = True
  end
end
