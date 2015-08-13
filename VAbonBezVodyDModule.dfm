inherited dm_VAbonBezVody: Tdm_VAbonBezVody
  Left = 587
  Top = 333
  Height = 330
  Width = 428
  inherited frReport: TfrReport
    Left = 176
    Top = 96
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
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
    object ResultDsetordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object ResultDsetdatecoming: TDateTimeField
      FieldName = 'datecoming'
    end
    object ResultDsetadres: TStringField
      FieldName = 'adres'
      Size = 180
    end
    object ResultDsetregions: TStringField
      FieldName = 'regions'
      Size = 32
    end
    object ResultDsetdisconadres: TStringField
      FieldName = 'disconadres'
      Size = 180
    end
    object ResultDsetdttm_discon: TDateTimeField
      FieldName = 'dttm_discon'
    end
    object ResultDsetdttm_con: TDateTimeField
      FieldName = 'dttm_con'
    end
    object ResultDsetdateclosed: TDateTimeField
      FieldName = 'dateclosed'
    end
    object ResultDsetfk_orders_regions: TIntegerField
      FieldName = 'fk_orders_regions'
    end
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsethours: TIntegerField
      FieldName = 'hours'
    end
    object ResultDsetMonth: TStringField
      FieldName = 'Month'
    end
    object ResultDsetmain_gr: TIntegerField
      FieldName = 'main_gr'
    end
    object ResultDsetMCount: TIntegerField
      FieldName = 'MCount'
    end
    object ResultDsetsdt_open: TStringField
      FieldName = 'sdt_open'
    end
  end
end
