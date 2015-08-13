inherited frm_LeakDiamChart: Tfrm_LeakDiamChart
  Left = 293
  Top = 196
  Caption = 'frm_LeakDiamChart'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Bottom: TPanel
    inherited btn_Print: TBitBtn
      Left = 368
      Anchors = [akRight, akBottom]
    end
    object btn_count: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #1050#1086#1083'-'#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_countClick
    end
    object btn_percent: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_percentClick
    end
  end
end
