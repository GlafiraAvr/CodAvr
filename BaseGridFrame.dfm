object frame_BaseGrid: Tframe_BaseGrid
  Left = 0
  Top = 0
  Width = 429
  Height = 240
  Color = clSilver
  ParentColor = False
  TabOrder = 0
  object DBGrid: TDBGridEh
    Left = 16
    Top = 104
    Width = 401
    Height = 129
    DataSource = ds_Main
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
  end
  object pnl_Fields: TPanel
    Left = 18
    Top = 4
    Width = 398
    Height = 96
    BevelInner = bvLowered
    TabOrder = 1
  end
  object dset_Main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_Main
    AfterCancel = dset_MainAfterCancel
    AfterDelete = dset_MainAfterDelete
    AfterEdit = dset_MainAfterEdit
    AfterInsert = dset_MainAfterInsert
    AfterOpen = dset_MainAfterOpen
    AfterPost = dset_MainAfterPost
    Left = 168
    Top = 144
  end
  object tr_Main: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 128
    Top = 144
  end
  object ds_Main: TDataSource
    DataSet = dset_Main
    Left = 88
    Top = 144
  end
  object tr_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 360
    Top = 136
  end
end
