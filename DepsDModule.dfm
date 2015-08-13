inherited dm_Deps: Tdm_Deps
  Left = 357
  Top = 296
  Height = 303
  Width = 373
  inherited dset_Main: TIBDataSet
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from departures where id=:old_id')
    InsertSQL.Strings = (
      'insert into Departures('
      'fk_departures_orders, StartDate,'
      'EndDate, fk_departures_Brigadiers,'
      'fk_departures_OfficialsOpen,'
      'fk_departures_OfficialsClose,'
      'DepNumber)'
      'values('
      ':fk_departures_orders, :StartDate,'
      ':EndDate, :fk_departures_Brigadiers,'
      ':fk_departures_OfficialsOpen,'
      ':fk_departures_OfficialsClose,'
      ':DepNumber)')
    SelectSQL.Strings = (
      'select d.id, d.StartDate, d.EndDate, d.fk_departures_Brigadiers,'
      'd.fk_departures_OfficialsOpen, d.fk_departures_OfficialsClose,'
      'd.fk_departures_orders, d.DepNumber,'
      'so_op.name OfficialOpen,'
      'so_cl.name OfficialClose,'
      'b.name Brig,'
      'd.excav_close_info'
      'from Departures d'
      
        'left join s_officials so_op on so_op.id = d.fk_departures_offici' +
        'alsopen'
      
        'left join s_officials so_cl on so_cl.id = d.fk_departures_offici' +
        'alsclose'
      'left join brigadiers b on b.id = d.fk_departures_brigadiers'
      'where fk_departures_orders=:pOrderID'
      'order by DepNumber, StartDate')
    ModifySQL.Strings = (
      'update Departures set'
      'StartDate=:StartDate,'
      'EndDate=:EndDate,'
      'fk_departures_Brigadiers=:fk_departures_Brigadiers,'
      'fk_departures_OfficialsOpen=:fk_departures_OfficialsOpen,'
      'fk_departures_OfficialsClose=:fk_departures_OfficialsClose'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTURES'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 24
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTURES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = '"DEPARTURES"."STARTDATE"'
      OnChange = dset_MainSTARTDATEChange
    end
    object dset_MainENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
      Origin = '"DEPARTURES"."ENDDATE"'
      OnChange = dset_MainENDDATEChange
    end
    object dset_MainFK_DEPARTURES_BRIGADIERS: TIntegerField
      FieldName = 'FK_DEPARTURES_BRIGADIERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_BRIGADIERS"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_DEPARTURES_OFFICIALSOPEN: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSOPEN'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSOPEN"'
    end
    object dset_MainFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSCLOSE'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSCLOSE"'
    end
    object dset_MainFK_DEPARTURES_ORDERS: TIntegerField
      FieldName = 'FK_DEPARTURES_ORDERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_ORDERS"'
    end
    object dset_MainOFFICIALOPEN: TIBStringField
      FieldName = 'OFFICIALOPEN'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_MainOFFICIALCLOSE: TIBStringField
      FieldName = 'OFFICIALCLOSE'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_MainBRIG: TIBStringField
      FieldName = 'BRIG'
      ProviderFlags = []
      OnChange = OnFieldChange
      FixedChar = True
      Size = 64
    end
    object dset_MainDEPNUMBER: TSmallintField
      FieldName = 'DEPNUMBER'
      Origin = '"DEPARTURES"."DEPNUMBER"'
    end
    object dset_MainCALC_IsCanEditRec: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'CALC_IsCanEditRec'
      Calculated = True
    end
    object dset_MainCALC_IsCanDelRec: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'CALC_IsCanDelRec'
      Calculated = True
    end
    object dset_MainEXCAV_CLOSE_INFO: TIBStringField
      FieldName = 'EXCAV_CLOSE_INFO'
      Origin = '"DEPARTURES"."EXCAV_CLOSE_INFO"'
      Size = 500
    end
  end
  inherited tran_Main: TIBTransaction
    Active = True
    Left = 24
    Top = 80
  end
  object IBDataSet1: TIBDataSet
    Left = 136
    Top = 72
  end
  object IBSQL1: TIBSQL
    Left = 208
    Top = 72
  end
end
