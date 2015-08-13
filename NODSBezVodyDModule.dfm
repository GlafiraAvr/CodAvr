inherited dm_NODSBezVody: Tdm_NODSBezVody
  Width = 438
  inherited frReport: TfrReport
    Left = 160
    Top = 104
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 40
    Top = 24
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 40
    Top = 88
  end
  object md_res: TRxMemoryData
    FieldDefs = <>
    Left = 176
    Top = 24
    object md_resid: TIntegerField
      FieldName = 'id'
    end
    object md_resdatecoming: TDateTimeField
      FieldName = 'datecoming'
    end
    object md_resdateclosed: TDateTimeField
      FieldName = 'dateclosed'
    end
    object md_resordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object md_resadres: TStringField
      FieldName = 'adres'
      Size = 180
    end
    object md_resdisconnections: TStringField
      FieldName = 'disconnections'
      Size = 800
    end
    object md_resfk_orders_regions: TIntegerField
      FieldName = 'fk_orders_regions'
    end
    object md_resisclosed: TIntegerField
      FieldName = 'isclosed'
    end
    object md_resregions: TStringField
      FieldName = 'regions'
      Size = 32
    end
    object md_resdt_bolt_close: TDateTimeField
      FieldName = 'dt_bolt_close'
    end
    object md_resdt_bolt_open: TDateTimeField
      FieldName = 'dt_bolt_open'
    end
    object md_reshours: TIntegerField
      FieldName = 'hours'
    end
    object md_resmain_gr: TIntegerField
      FieldName = 'main_gr'
    end
  end
  object frDS_res: TfrDBDataSet
    DataSet = ResultDset
    Left = 264
    Top = 32
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 240
    Top = 128
    object IntegerField1: TIntegerField
      FieldName = 'id'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'datecoming'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'dateclosed'
    end
    object IntegerField2: TIntegerField
      FieldName = 'ordernumber'
    end
    object StringField1: TStringField
      FieldName = 'adres'
      Size = 180
    end
    object StringField2: TStringField
      FieldName = 'disconnections'
      Size = 800
    end
    object IntegerField3: TIntegerField
      FieldName = 'fk_orders_regions'
    end
    object IntegerField4: TIntegerField
      FieldName = 'isclosed'
    end
    object StringField3: TStringField
      FieldName = 'regions'
      Size = 32
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'dt_bolt_close'
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'dt_bolt_open'
    end
    object IntegerField5: TIntegerField
      FieldName = 'hours'
    end
    object IntegerField6: TIntegerField
      FieldName = 'main_gr'
    end
    object ResultDsets_dt_bolt_close: TStringField
      FieldName = 's_dt_bolt_close'
      Size = 200
    end
    object ResultDsets_dt_bolt_open: TStringField
      FieldName = 's_dt_bolt_open'
      Size = 200
    end
    object ResultDsetBoltAdres: TStringField
      FieldName = 'BoltAdres'
      Size = 240
    end
    object ResultDsetdiameter: TStringField
      FieldName = 'diameter'
      Size = 50
    end
    object ResultDsets_hours: TStringField
      FieldName = 's_hours'
      Size = 200
    end
  end
end
