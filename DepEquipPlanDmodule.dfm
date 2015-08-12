inherited dm_DepPlanEqChange: Tdm_DepPlanEqChange
  Left = 516
  Top = 362
  inherited dset_Main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from EQUIP_PALN_DEPARTURE where id=:old_id')
    InsertSQL.Strings = (
      'insert into EQUIP_PALN_DEPARTURE (Fk_id_order,'
      'FK_ID_DEPARTURES,'
      'FK_ID_EQUIPMENT,'
      'fk_id_equiptyp)'
      ' values '
      '(:FK_ID_ORDER,'
      ':FK_ID_DEPARTURES,'
      ':FK_ID_EQUIPMENT,'
      ':fk_id_equiptyp)')
    SelectSQL.Strings = (
      'select'
      
        '(select  full_name from GET_EQUIP_FULL_NAME(de.fk_id_equipment )' +
        ') equip,'
      
        'de.id, de.fk_id_order, de.fk_id_departures, de.fk_id_equipment ,' +
        ' de.fk_id_equiptyp,'
      
        '(select se.name from s_equipment_typ se where se.id=de.fk_id_equ' +
        'iptyp) typname'
      'from EQUIP_PALN_DEPARTURE de , EQUIPMENT e'
      'where de.fk_id_departures=:pDepID and  de.fk_id_equipment=e.id'
      'order by 1')
    ModifySQL.Strings = (
      'update  EQUIP_PALN_DEPARTURE set'
      ' FK_ID_EQUIPMENT=:FK_ID_EQUIPMENT,'
      'fk_id_equiptyp=:fk_id_equiptyp'
      ' where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_EQUIP_PALN_DEPARTURE_VDS_ID'
    Top = 24
    object dset_MainEQUIP: TIBStringField
      FieldName = 'EQUIP'
      ProviderFlags = []
      Size = 2000
    end
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"EQUIP_PALN_DEPARTURE"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_ID_ORDER: TIntegerField
      FieldName = 'FK_ID_ORDER'
      Origin = '"EQUIP_PALN_DEPARTURE"."FK_ID_ORDER"'
      Required = True
    end
    object dset_MainFK_ID_DEPARTURES: TIntegerField
      FieldName = 'FK_ID_DEPARTURES'
      Origin = '"EQUIP_PALN_DEPARTURE"."FK_ID_DEPARTURES"'
      Required = True
    end
    object dset_MainFK_ID_EQUIPMENT: TIntegerField
      FieldName = 'FK_ID_EQUIPMENT'
      Origin = '"EQUIP_PALN_DEPARTURE"."FK_ID_EQUIPMENT"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_ID_EQUIPTYP: TIntegerField
      FieldName = 'FK_ID_EQUIPTYP'
      Origin = '"EQUIP_PALN_DEPARTURE"."FK_ID_EQUIPTYP"'
    end
    object dset_MainTYPNAME: TIBStringField
      FieldName = 'TYPNAME'
      ProviderFlags = []
      OnChange = dset_MainFK_EQUIP_TYPChange
      FixedChar = True
      Size = 36
    end
  end
  inherited tran_Main: TIBTransaction
    Active = True
  end
  object dset_eqip_type: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Main
    SelectSQL.Strings = (
      'select se.id, se.name from s_equipment_typ se')
    Left = 112
    Top = 16
    object dset_eqip_typeID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_EQUIPMENT_TYP"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_eqip_typeNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_EQUIPMENT_TYP"."NAME"'
      FixedChar = True
      Size = 36
    end
  end
end
