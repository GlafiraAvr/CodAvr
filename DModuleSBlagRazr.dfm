inherited dm_SBlagRazr: Tdm_SBlagRazr
  Top = 538
  inherited frReport: TfrReport
    Dataset = frDBD_md_res
    Left = 24
    ReportForm = {19000000}
  end
  object md_result: TRxMemoryData
    FieldDefs = <>
    OnCalcFields = md_resultCalcFields
    Left = 24
    Top = 144
    object md_resultData: TStringField
      FieldName = 'Data'
    end
    object md_resultnb_All: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'nb_All'
      Calculated = True
    end
    object md_resultnb_Asf: TIntegerField
      FieldName = 'nb_Asf'
    end
    object md_resultnb_GrZone: TIntegerField
      FieldName = 'nb_GrZone'
    end
    object md_resultraz_All: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'raz_All'
      Calculated = True
    end
    object md_resultraz_Asf: TIntegerField
      FieldName = 'raz_Asf'
    end
    object md_resultraz_GrZone: TIntegerField
      FieldName = 'raz_GrZone'
    end
    object md_resultbr_All: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'br_All'
      Calculated = True
    end
    object md_resultbr_Asf: TIntegerField
      FieldName = 'br_Asf'
    end
    object md_resultbr_GrZaone: TIntegerField
      FieldName = 'br_GrZone'
    end
    object md_resultExkav: TIntegerField
      FieldName = 'Exkav'
    end
    object md_resulttech_mag: TIntegerField
      FieldName = 'tech_mag'
    end
    object md_resulttech_vvod: TIntegerField
      FieldName = 'tech_vvod'
    end
    object md_resulttech_all: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'tech_all'
      Calculated = True
    end
    object md_resultlikv_mag: TIntegerField
      FieldName = 'likv_mag'
    end
    object md_resultlikv_vvod: TIntegerField
      FieldName = 'likv_vvod'
    end
    object md_resultlikv_all: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'likv_all'
      Calculated = True
    end
    object md_resultpost_mag: TIntegerField
      FieldName = 'post_mag'
    end
    object md_resultpost_vvod: TIntegerField
      FieldName = 'post_vvod'
    end
    object md_resultpost_all: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'post_all'
      Calculated = True
    end
  end
  object frDBD_md_res: TfrDBDataSet
    DataSet = md_result
    Left = 24
    Top = 72
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 96
    Top = 80
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran_insert
    Left = 112
    Top = 144
  end
  object tran_insert: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 176
    Top = 72
  end
end
