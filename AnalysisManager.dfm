inherited DM_AnalysisManager: TDM_AnalysisManager
  OldCreateOrder = True
  Left = 327
  Top = 324
  Height = 303
  Width = 468
  object dset_tmp1: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 16
    Top = 72
  end
  object Transac: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait'
      'read')
    Left = 16
    Top = 8
  end
  object frUDS_tmp: TfrUserDataset
    Left = 232
    Top = 72
  end
  object frReport: TfrReport
    Dataset = frUDS_tmp
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 104
    Top = 8
    ReportForm = {19000000}
  end
  object dset_tmp2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 80
    Top = 72
  end
  object dset_tmp3: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 152
    Top = 72
  end
  object pind_Load: TProgressIndicator
    Caption = #1048#1076#1077#1090' '#1079#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
    CancelButton = False
    CancelCaption = 'Cancel'
    Left = 344
    Top = 72
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = dset_tmp1
    Left = 200
    Top = 8
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = dset_tmp2
    Left = 304
    Top = 8
  end
end
