object frame_SelRegion: Tframe_SelRegion
  Left = 0
  Top = 0
  Width = 217
  Height = 59
  TabOrder = 0
  object btn_Region: TBitBtn
    Left = 8
    Top = 8
    Width = 193
    Height = 25
    Caption = #1056#1072#1081#1086#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btn_RegionClick
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 48
    Top = 48
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 96
    Top = 48
  end
end
