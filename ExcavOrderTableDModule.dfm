inherited dm_ExcavOrderTable: Tdm_ExcavOrderTable
  Left = 885
  Top = 632
  inherited frReport: TfrReport
    Dataset = frDBresult
    ReportForm = {19000000}
  end
  object rm_result: TRxMemoryData
    FieldDefs = <>
    Left = 32
    Top = 96
    object rm_resultregion_id: TIntegerField
      FieldName = 'region_id'
    end
    object rm_resultregion: TStringField
      FieldName = 'region'
    end
    object rm_resultcount_all: TIntegerField
      FieldName = 'count_all'
    end
    object rm_resultexorder_count: TIntegerField
      FieldName = 'exorder_count'
    end
    object rm_resultclosed_order_count: TIntegerField
      FieldName = 'closed_order_count'
    end
    object rm_resultcount_taken: TIntegerField
      FieldName = 'count_taken'
    end
    object rm_resultcount_closedOrder: TIntegerField
      FieldName = 'count_closedOrder'
    end
    object rm_resultcount_form3: TIntegerField
      FieldName = 'count_form3'
    end
    object rm_resultcount_form7: TIntegerField
      FieldName = 'count_form7'
    end
    object rm_resultclosed_keeper_id_1: TIntegerField
      FieldName = 'closed_keeper_id_1'
    end
    object rm_resultclosed_keeper_id_2: TIntegerField
      FieldName = 'closed_keeper_id_2'
    end
    object rm_resultclosed_keeper_id_3: TIntegerField
      FieldName = 'closed_keeper_id_3'
    end
    object rm_resultclosed_keeper_id_4: TIntegerField
      FieldName = 'closed_keeper_id_4'
    end
    object rm_resultclosed_keeper_null: TIntegerField
      FieldName = 'closed_keeper_null'
    end
    object rm_resultbalancekeeper_nulll: TIntegerField
      FieldName = 'balancekeeper_nulll'
    end
    object rm_resultbalancekeeper_1: TIntegerField
      FieldName = 'balancekeeper_1'
    end
    object rm_resultbalancekeeper_2: TIntegerField
      FieldName = 'balancekeeper_2'
    end
    object rm_resultbalancekeeper_3: TIntegerField
      FieldName = 'balancekeeper_3'
    end
    object rm_resultbalancekeeper_4: TIntegerField
      FieldName = 'balancekeeper_4'
    end
  end
  object frDBresult: TfrDBDataSet
    DataSet = rm_result
    Left = 80
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 160
    Top = 24
  end
  object dset_closedOrder: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 168
    Top = 96
  end
end
