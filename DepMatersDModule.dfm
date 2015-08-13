inherited dm_DepMaters: Tdm_DepMaters
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from departurematers where id=:old_id')
    InsertSQL.Strings = (
      'insert into departurematers('
      'fk_depmaters_departure,'
      'fk_depmaters_order, fk_depmaters_mater,'
      'fk_depmaters_diameter, quantity)'
      'values('
      ':fk_depmaters_departure,'
      ':fk_depmaters_order, :fk_depmaters_mater,'
      ':fk_depmaters_diameter, :quantity)')
    SelectSQL.Strings = (
      'select'
      
        '(select rtrim(name)||'#39' ('#39'||rtrim(measurement)||'#39')'#39' from material' +
        's where id=dm.fk_depmaters_mater) Mater,'
      
        '(select diameter from s_tubediameter where id=dm.fk_depmaters_di' +
        'ameter) Diam,'
      'id, fk_depmaters_departure,'
      'fk_depmaters_order, fk_depmaters_mater,'
      'fk_depmaters_diameter, quantity'
      'from departurematers dm'
      'where fk_depmaters_departure = :pDepID'
      'order by 1'
      '')
    ModifySQL.Strings = (
      'update departurematers set'
      'fk_depmaters_mater=:fk_depmaters_mater,'
      'fk_depmaters_diameter=:fk_depmaters_diameter,'
      'quantity=:quantity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTUREMATERS_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainMATER: TIBStringField
      FieldName = 'MATER'
      ProviderFlags = []
      Size = 163
    end
    object dset_MainDIAM: TIntegerField
      FieldName = 'DIAM'
      ProviderFlags = []
    end
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREMATERS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_DEPMATERS_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPMATERS_DEPARTURE'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_DEPARTURE"'
      Required = True
    end
    object dset_MainFK_DEPMATERS_ORDER: TIntegerField
      FieldName = 'FK_DEPMATERS_ORDER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_ORDER"'
      Required = True
    end
    object dset_MainFK_DEPMATERS_MATER: TIntegerField
      FieldName = 'FK_DEPMATERS_MATER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_MATER"'
      Required = True
      OnChange = OnFieldChange
    end
    object dset_MainFK_DEPMATERS_DIAMETER: TIntegerField
      FieldName = 'FK_DEPMATERS_DIAMETER'
      Origin = '"DEPARTUREMATERS"."FK_DEPMATERS_DIAMETER"'
      OnChange = OnFieldChange
    end
    object dset_MainQUANTITY: TIBBCDField
      FieldName = 'QUANTITY'
      Origin = '"DEPARTUREMATERS"."QUANTITY"'
      OnChange = OnFieldChange
      Precision = 18
      Size = 2
    end
  end
end
