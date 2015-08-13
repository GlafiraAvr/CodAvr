inherited dm_SvodkaGek_vds: Tdm_SvodkaGek_vds
  Left = 518
  Top = 257
  Width = 303
  inherited frReport: TfrReport
    Dataset = frDBDataSet1
    ReportForm = {19000000}
  end
  object Dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 40
    Top = 160
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = ResultDset
    Left = 16
    Top = 80
  end
  object ResultDset: TRxMemoryData
    FieldDefs = <>
    Left = 96
    Top = 136
    object ResultDsetid: TIntegerField
      FieldName = 'id'
    end
    object ResultDsetordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object ResultDsetregion: TStringField
      FieldName = 'region'
      Size = 15
    end
    object ResultDsetdateComing: TStringField
      FieldName = 'dateComing'
    end
    object ResultDsetadress: TStringField
      DisplayWidth = 120
      FieldName = 'adress'
      Size = 120
    end
    object ResultDsetapplicantfio: TStringField
      FieldName = 'applicantfio'
      Size = 15
    end
    object ResultDsetapplicantphone: TStringField
      FieldName = 'applicantphone'
      Size = 10
    end
    object ResultDsetdistrict: TStringField
      FieldName = 'district'
      Size = 3
    end
    object ResultDsetmessagename: TStringField
      FieldName = 'messagename'
      Size = 30
    end
    object ResultDsetadditionalinfo: TStringField
      DisplayWidth = 600
      FieldName = 'additionalinfo'
      Size = 600
    end
    object ResultDsetdateclosed: TStringField
      DisplayWidth = 20
      FieldName = 'dateclosed'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 80
    Top = 64
  end
end
