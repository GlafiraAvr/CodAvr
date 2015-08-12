inherited dm_DepEquips: Tdm_DepEquips
  OnCreate = DataModuleCreate
  Left = 499
  Top = 278
  inherited dset_Main: TIBDataSet
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from departureequips where id=:old_id')
    InsertSQL.Strings = (
      'insert into departureequips('
      
        'fk_depequips_order, fk_depequips_departure, fk_depequips_equip, ' +
        'fk_depequips_officpost_ins)'
      'values('
      
        ':fk_depequips_order, :fk_depequips_departure, :fk_depequips_equi' +
        'p, :fk_depequips_officpost_ins)')
    SelectSQL.Strings = (
      ' select'
      
        '(select full_name from get_equip_full_name(fk_depequips_equip)) ' +
        ' equip,'
      
        'id, fk_depequips_order, fk_depequips_departure, fk_depequips_equ' +
        'ip,'
      'de.fk_depequips_officpost_ins'
      'from departureequips de'
      'where fk_depequips_departure=:pDepID'
      'order by 1')
    ModifySQL.Strings = (
      'update departureequips set'
      'fk_depequips_equip = :fk_depequips_equip'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTUREEQUIPS_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainEQUIP: TIBStringField
      FieldName = 'EQUIP'
      ProviderFlags = []
      Size = 93
    end
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTUREEQUIPS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_DEPEQUIPS_ORDER: TIntegerField
      FieldName = 'FK_DEPEQUIPS_ORDER'
      Origin = '"DEPARTUREEQUIPS"."FK_DEPEQUIPS_ORDER"'
      Required = True
    end
    object dset_MainFK_DEPEQUIPS_DEPARTURE: TIntegerField
      FieldName = 'FK_DEPEQUIPS_DEPARTURE'
      Origin = '"DEPARTUREEQUIPS"."FK_DEPEQUIPS_DEPARTURE"'
      Required = True
    end
    object dset_MainFK_DEPEQUIPS_EQUIP: TIntegerField
      FieldName = 'FK_DEPEQUIPS_EQUIP'
      Origin = '"DEPARTUREEQUIPS"."FK_DEPEQUIPS_EQUIP"'
      Required = True
      OnChange = OnFieldChange
    end
    object dset_MainFK_DEPEQUIPS_OFFICPOST_INS: TIntegerField
      FieldName = 'FK_DEPEQUIPS_OFFICPOST_INS'
      Origin = '"DEPARTUREEQUIPS"."FK_DEPEQUIPS_OFFICPOST_INS"'
    end
    object dset_Mainclc_IsCanDel: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'clc_IsCanDel'
      Calculated = True
    end
    object dset_Mainclc_IsCanEdit: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'clc_IsCanEdit'
      Calculated = True
    end
  end
end
