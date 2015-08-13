inherited dm_ReportAll1: Tdm_ReportAll1
  Left = 504
  Top = 318
  Width = 393
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object rm_Plan: TRxMemoryData
    FieldDefs = <>
    Left = 72
    Top = 16
    object rm_Planresult: TStringField
      FieldName = 'result'
      Size = 500
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 160
    Top = 16
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 112
    Top = 16
  end
  object rm_PlanTwo: TRxMemoryData
    FieldDefs = <>
    Left = 72
    Top = 80
    object rm_PlanTworesult: TStringField
      FieldName = 'result'
      Size = 500
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = rm_Plan
    Left = 24
    Top = 80
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = rm_PlanTwo
    Left = 24
    Top = 144
  end
end
