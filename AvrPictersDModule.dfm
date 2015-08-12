object dm_avrpicter: Tdm_avrpicter
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 417
  Top = 336
  Height = 291
  Width = 339
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        'select po.id, po.file_name, po.id_typ,  ServFile_Name from picte' +
        'rs_order po'
      'where po.fk_id_order=:id_order order by 1')
    Left = 54
    Top = 16
    object dsetID: TIntegerField
      FieldName = 'ID'
      Origin = '"PICTERS_ORDER"."ID"'
      Required = True
    end
    object dsetFILE_NAME: TIBStringField
      FieldName = 'FILE_NAME'
      Origin = '"PICTERS_ORDER"."FILE_NAME"'
      Required = True
      Size = 100
    end
    object dsetID_TYP: TIntegerField
      FieldName = 'ID_TYP'
      Origin = '"PICTERS_ORDER"."ID_TYP"'
    end
    object dsetSERVFILE_NAME: TIBStringField
      FieldName = 'SERVFILE_NAME'
      Origin = '"PICTERS_ORDER"."SERVFILE_NAME"'
      Size = 25
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 8
    Top = 16
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 172
    Top = 17
  end
  object mem_maps: TRxMemoryData
    FieldDefs = <>
    AfterScroll = mem_mapsAfterScroll
    Left = 24
    Top = 120
    object mem_mapsid: TIntegerField
      FieldName = 'id'
    end
    object mem_mapsfileName: TStringField
      FieldName = 'fileName'
      Size = 100
    end
    object mem_mapsid_typ: TIntegerField
      FieldName = 'id_typ'
    end
    object mem_mapsPicter: TBlobField
      FieldName = 'Picter'
    end
    object mem_mapssaved_picter: TStringField
      FieldName = 'saved_picter'
      Size = 50
    end
    object mem_mapsServFile_Name: TStringField
      FieldName = 'ServFile_Name'
      Size = 25
    end
  end
  object dset_id: TIBDataSet
    Left = 112
    Top = 16
  end
  object mem_before: TRxMemoryData
    FieldDefs = <>
    AfterScroll = mem_mapsAfterScroll
    Left = 104
    Top = 120
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object StringField1: TStringField
      FieldName = 'fileName'
      Size = 50
    end
    object IntegerField2: TIntegerField
      FieldName = 'id_typ'
    end
    object BlobField1: TBlobField
      FieldName = 'Picter'
    end
    object StringField2: TStringField
      FieldName = 'saved_picter'
      Size = 50
    end
    object mem_beforeServFile_Name: TStringField
      FieldName = 'ServFile_Name'
      Size = 25
    end
  end
  object mem_after: TRxMemoryData
    FieldDefs = <>
    AfterScroll = mem_mapsAfterScroll
    Left = 192
    Top = 120
    object IntegerField3: TIntegerField
      FieldName = 'id'
    end
    object StringField3: TStringField
      FieldName = 'fileName'
      Size = 50
    end
    object IntegerField4: TIntegerField
      FieldName = 'id_typ'
    end
    object BlobField2: TBlobField
      FieldName = 'Picter'
    end
    object StringField4: TStringField
      FieldName = 'saved_picter'
      Size = 50
    end
    object mem_afterServFile_Name: TStringField
      FieldName = 'ServFile_Name'
      Size = 25
    end
  end
end
