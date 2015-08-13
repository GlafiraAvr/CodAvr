inherited DM_ReportManager: TDM_ReportManager
  OldCreateOrder = True
  Left = 367
  Top = 234
  Height = 361
  Width = 587
  object frReport: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    RebuildPrinter = False
    Left = 24
    Top = 16
    ReportForm = {19000000}
  end
  object Transac: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 128
    Top = 8
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 24
    Top = 152
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = dset_tmp
    Left = 32
    Top = 88
  end
  object dset_tmp2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 128
    Top = 120
  end
  object dset_RecordCount: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 256
    Top = 8
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = dset_tmp2
    Left = 128
    Top = 72
  end
  object pind_Load: TProgressIndicator
    Caption = #1048#1076#1077#1090' '#1079#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
    CancelButton = False
    CancelCaption = 'Cancel'
    Left = 440
    Top = 136
  end
  object dset_tmp3: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 256
    Top = 72
  end
  object IBSQL1: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = Transac_IBSQL
    Left = 440
    Top = 8
  end
  object Transac_IBSQL: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 440
    Top = 72
  end
  object frDBDSMemory: TfrDBDataSet
    DataSet = mt_tmp
    Left = 328
    Top = 216
  end
  object frUDSet1: TfrUserDataset
    Left = 224
    Top = 216
  end
  object mt_tmp: TRxMemoryData
    FieldDefs = <>
    Left = 136
    Top = 240
  end
end
