inherited dm_RepClosedOrders: Tdm_RepClosedOrders
  Left = 466
  Top = 359
  inherited frReport: TfrReport
    ReportForm = {19000000}
  end
  inherited ResultDset: TRxMemoryData
    object ResultDsetMessageTypes: TStringField [12]
      FieldName = 'MessageTypes'
      Size = 32
    end
    object ResultDsetBrigadier: TStringField [13]
      FieldName = 'Brigadier'
      Size = 64
    end
    object ResultDsetadditionalinfo: TStringField [14]
      DisplayWidth = 200
      FieldName = 'additionalinfo'
      Size = 1000
    end
    object ResultDsetAPPLICANTPHONE: TStringField [15]
      FieldName = 'APPLICANTPHONE'
      Size = 15
    end
    object ResultDsetAPPLICANTFIO: TStringField [16]
      FieldName = 'APPLICANTFIO'
    end
  end
  object dset_dep: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 264
    Top = 152
  end
end
