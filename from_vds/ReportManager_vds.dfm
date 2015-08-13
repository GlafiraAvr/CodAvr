inherited DM_ReportManager_vds: TDM_ReportManager_vds
  OldCreateOrder = True
  Left = 532
  Top = 247
  Height = 306
  Width = 526
  object frReport: TfrReport
    Dataset = frDBDataSet
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit]
    ShowProgress = False
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
    DataSet = RxMemoryClosed
    Left = 32
    Top = 88
  end
  object dset_tmp2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Transac
    Left = 128
    Top = 152
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
    Left = 224
    Top = 200
  end
  object RxMemoryClosed: TRxMemoryData
    FieldDefs = <>
    Left = 352
    Top = 8
    object RxMemoryClosedFullOrderNum: TStringField
      FieldName = 'FullOrderNum'
      Size = 10
    end
    object RxMemoryClosedDateComing: TStringField
      FieldName = 'DateComing'
    end
    object RxMemoryClosedDateClosed: TStringField
      FieldName = 'DateClosed'
    end
    object RxMemoryClosedid: TIntegerField
      FieldName = 'id'
    end
    object RxMemoryClosedRegions: TStringField
      FieldName = 'Regions'
    end
    object RxMemoryClosedadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
  end
  object RxMemoryAll: TRxMemoryData
    FieldDefs = <>
    Left = 400
    Top = 64
    object RxMemoryAllid: TIntegerField
      FieldName = 'id'
    end
    object RxMemoryAllFullorderNum: TStringField
      FieldName = 'FullorderNum'
      Size = 10
    end
    object RxMemoryAllDateComing: TStringField
      FieldName = 'DateComing'
    end
    object RxMemoryAllRegions: TStringField
      FieldName = 'Regions'
      Size = 18
    end
    object RxMemoryAlladres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object RxMemoryAllisClosed: TStringField
      FieldName = 'isClosed'
      Size = 15
    end
    object RxMemoryAllMainGr: TStringField
      FieldName = 'MainGr'
      Size = 2
    end
  end
  object RxMemoryOpend: TRxMemoryData
    FieldDefs = <>
    Left = 456
    Top = 8
    object RxMemoryOpendFullOrderNum: TStringField
      FieldName = 'FullOrderNum'
      Size = 10
    end
    object RxMemoryOpendDateComing: TStringField
      FieldName = 'DateComing'
    end
    object RxMemoryOpendid: TIntegerField
      FieldName = 'id'
    end
    object RxMemoryOpendRegions: TStringField
      FieldName = 'Regions'
    end
    object RxMemoryOpendadres: TStringField
      FieldName = 'adres'
      Size = 100
    end
    object RxMemoryOpenddistrict: TStringField
      FieldName = 'district'
      Size = 4
    end
  end
end
