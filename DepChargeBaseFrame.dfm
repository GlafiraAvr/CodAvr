object frame_DepChargeBase: Tframe_DepChargeBase
  Left = 0
  Top = 0
  Width = 615
  Height = 334
  Color = clMoneyGreen
  ParentColor = False
  TabOrder = 0
  object DBGrid: TDBGridEh
    Left = 0
    Top = 153
    Width = 615
    Height = 181
    Align = alClient
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
    Left = 0
    Top = 0
    Width = 615
    Height = 153
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 1
  end
  object ds_Main: TDataSource
    OnStateChange = ds_MainStateChange
    Left = 160
    Top = 200
  end
end
