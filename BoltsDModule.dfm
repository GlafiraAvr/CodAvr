inherited dm_Bolts: Tdm_Bolts
  Left = 612
  Top = 360
  Height = 269
  Width = 297
  inherited dset_Main: TIBDataSet
    OnCalcFields = dset_MainCalcFields
    DeleteSQL.Strings = (
      'delete from ClosedBolts'
      'where id=:old_id'
      '')
    InsertSQL.Strings = (
      'insert into closedbolts(fk_closedbolts_orders,'
      'closedate, fk_closedbolts_brigadiersclose, opendate,'
      
        'fk_closedbolts_brigadieropen, fk_closedbolts_tubediam, fk_closed' +
        'bolts_housetype,'
      'fk_closedbolts_streets, housenum,additionaladdress,closeplace,'
      'fk_closedbolts_officialpost_ins)'
      'values (:fk_closedbolts_orders,'
      ':closedate, :fk_closedbolts_brigadiersclose, :opendate,'
      
        ':fk_closedbolts_brigadieropen, :fk_closedbolts_tubediam, :fk_clo' +
        'sedbolts_housetype,'
      
        ':fk_closedbolts_streets, :housenum,:additionaladdress,:closeplac' +
        'e,'
      ':fk_closedbolts_officialpost_ins)'
      '')
    SelectSQL.Strings = (
      
        'select b.id, b.fk_closedbolts_orders,b.closedate, b.fk_closedbol' +
        'ts_brigadiersclose, b.opendate,'
      
        'b.fk_closedbolts_brigadieropen, b.fk_closedbolts_tubediam, b.fk_' +
        'closedbolts_housetype,'
      
        'b.fk_closedbolts_streets, b.housenum, b.additionaladdress, Close' +
        'Place, b.fk_closedbolts_officialpost_ins,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'sclose) BrigClose,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'open) BrigOpen,'
      
        '(select diameter from s_tubediameter where id=b.fk_closedbolts_t' +
        'ubediam) TubeDiam,'
      '(select adres from'
      
        'get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_streets, ' +
        'b.housenum, b.additionaladdress)) as Adres'
      'from closedbolts b'
      'where b.fk_closedbolts_orders=:pOrderID')
    ModifySQL.Strings = (
      'update ClosedBolts set'
      'closedate=:closedate,'
      'fk_closedbolts_brigadiersclose=:fk_closedbolts_brigadiersclose,'
      'opendate=:opendate,'
      'fk_closedbolts_brigadieropen=:fk_closedbolts_brigadieropen,'
      'fk_closedbolts_tubediam=:fk_closedbolts_tubediam,'
      'fk_closedbolts_housetype=:fk_closedbolts_housetype,'
      'fk_closedbolts_streets=:fk_closedbolts_streets,'
      'housenum=:housenum,'
      'additionaladdress=:additionaladdress,'
      'closeplace=:closeplace'
      'where id=:id'
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_CLOSEDBOLTS'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainID: TIntegerField
      FieldName = 'ID'
      Origin = '"CLOSEDBOLTS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainFK_CLOSEDBOLTS_ORDERS: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_ORDERS'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_ORDERS"'
    end
    object dset_MainCLOSEDATE: TDateTimeField
      FieldName = 'CLOSEDATE'
      Origin = '"CLOSEDBOLTS"."CLOSEDATE"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_BRIGADIERSCLOSE"'
    end
    object dset_MainOPENDATE: TDateTimeField
      FieldName = 'OPENDATE'
      Origin = '"CLOSEDBOLTS"."OPENDATE"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_BRIGADIEROPEN"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_CLOSEDBOLTS_TUBEDIAM: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_TUBEDIAM'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_TUBEDIAM"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_CLOSEDBOLTS_HOUSETYPE: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_HOUSETYPE'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_HOUSETYPE"'
      OnChange = OnFieldChange
    end
    object dset_MainFK_CLOSEDBOLTS_STREETS: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_STREETS'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_STREETS"'
      OnChange = OnFieldChange
    end
    object dset_MainHOUSENUM: TIBStringField
      FieldName = 'HOUSENUM'
      Origin = '"CLOSEDBOLTS"."HOUSENUM"'
      OnChange = OnFieldChange
      FixedChar = True
    end
    object dset_MainADDITIONALADDRESS: TIBStringField
      FieldName = 'ADDITIONALADDRESS'
      Origin = '"CLOSEDBOLTS"."ADDITIONALADDRESS"'
      OnChange = OnFieldChange
      FixedChar = True
      Size = 32
    end
    object dset_MainCLOSEPLACE: TIBStringField
      FieldName = 'CLOSEPLACE'
      Origin = '"CLOSEDBOLTS"."CLOSEPLACE"'
      OnChange = OnFieldChange
      FixedChar = True
      Size = 22
    end
    object dset_MainBRIGCLOSE: TIBStringField
      FieldName = 'BRIGCLOSE'
      ProviderFlags = []
      OnGetText = dset_MainBRIGCLOSEGetText
      FixedChar = True
      Size = 64
    end
    object dset_MainBRIGOPEN: TIBStringField
      FieldName = 'BRIGOPEN'
      ProviderFlags = []
      OnGetText = dset_MainBRIGOPENGetText
      FixedChar = True
      Size = 64
    end
    object dset_MainTUBEDIAM: TIntegerField
      FieldName = 'TUBEDIAM'
      ProviderFlags = []
    end
    object dset_MainADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      Size = 190
    end
    object dset_MainFK_CLOSEDBOLTS_OFFICIALPOST_INS: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_OFFICIALPOST_INS'
      Origin = '"CLOSEDBOLTS"."FK_CLOSEDBOLTS_OFFICIALPOST_INS"'
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
  end
  inherited tran_Main: TIBTransaction
    Active = True
  end
end
