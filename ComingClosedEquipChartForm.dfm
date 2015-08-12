inherited frm_ComingClosedEquipChart: Tfrm_ComingClosedEquipChart
  Left = 323
  Top = 210
  Caption = 'frm_ComingClosedEquipChart'
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Bottom: TPanel
    object btn_Vse: TBitBtn
      Left = 112
      Top = 8
      Width = 81
      Height = 25
      Cancel = True
      Caption = #1042#1089#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_VseClick
    end
    object btn_BezVsego: TBitBtn
      Left = 200
      Top = 8
      Width = 81
      Height = 25
      Caption = #1041#1077#1079' "'#1042#1089#1077#1075#1086'"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_BezVsegoClick
    end
  end
end
