inherited dm_DepBuff: Tdm_DepBuff
  OldCreateOrder = True
  Left = 462
  Top = 251
  Height = 319
  Width = 469
  inherited mt_BuffData: TkbmMemTable
    AfterInsert = mt_BuffDataAfterInsert
    object mt_BuffDataID: TIntegerField
      FieldName = 'ID'
    end
    object mt_BuffDataStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object mt_BuffDataEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object mt_BuffDataBrigID: TIntegerField
      FieldName = 'BrigID'
    end
    object mt_BuffDataAddInfo: TStringField
      FieldName = 'AddInfo'
      Size = 800
    end
  end
  inherited tran: TIBTransaction
    Top = 96
  end
end
