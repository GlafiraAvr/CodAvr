inherited frm_PeriodTimeRegDmgSel: Tfrm_PeriodTimeRegDmgSel
  Left = 382
  Top = 272
  Caption = 'frm_PeriodTimeRegDmgSel'
  ClientHeight = 132
  ClientWidth = 312
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 668
  end
  inherited lbl_DateComing1: TLabel
    Top = 10
    Width = 42
    Height = 13
    Caption = #1057' 8:00 '
  end
  inherited lbl_DateComing2: TLabel
    Left = 162
    Top = 9
    Width = 44
    Caption = #1087#1086' 8:00'
  end
  inherited Label8: TLabel
    Left = 667
    Top = 174
  end
  inherited Label9: TLabel
    Left = 834
    Top = 174
  end
  inherited Label10: TLabel
    Left = 1016
    Top = 174
  end
  inherited lbl_SONum: TLabel
    Left = 416
    Top = 16
  end
  inherited sp_NumOrder: TSpinEdit
    Left = 733
  end
  inherited dp_Coming1: TDateEdit
    Left = 985
  end
  inherited dp_Coming2: TDateEdit
    Left = 1129
  end
  inherited btn_Officials: TBitBtn
    Left = 667
  end
  inherited btn_Regions: TBitBtn
    Left = 63
    Top = 32
    Width = 196
  end
  inherited btn_MessageType: TBitBtn
    Left = 1039
  end
  inherited GroupBox1: TGroupBox
    Left = 664
    Top = 80
  end
  inherited btn_DamageLocality: TBitBtn
    Left = 776
  end
  inherited btn_DamagePlace: TBitBtn
    Left = 64
    Top = 71
    Width = 196
  end
  inherited cb_OrderType: TComboBox
    Left = 720
    Top = 167
  end
  inherited cb_IsPayed: TComboBox
    Left = 904
    Top = 167
    TabOrder = 17
  end
  inherited cb_AreClosures: TComboBox
    Left = 1096
    Top = 167
    TabOrder = 20
  end
  inherited GroupBox2: TGroupBox
    Left = 656
    Top = 207
    TabOrder = 18
  end
  inherited btn_ok: TBitBtn
    Top = 103
    TabOrder = 21
  end
  object dp_Date1: TDateEdit [21]
    Left = 48
    Top = 4
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 15
  end
  object dp_Date2: TDateEdit [22]
    Left = 210
    Top = 4
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 16
  end
  inherited btn_cancel: TBitBtn
    Left = 232
    Top = 103
  end
  inherited sp_NumSO: TSpinEdit
    Left = 432
    Top = 51
  end
  inherited tp_Coming1: TMaskEdit
    Enabled = False
    Visible = False
  end
  inherited Tr_Voc: TIBTransaction
    Left = 784
    Top = 128
  end
  inherited dset_Street: TIBDataSet
    Left = 848
    Top = 128
  end
  inherited dset_Street2: TIBDataSet
    Left = 936
    Top = 128
  end
  inherited dset_Housetype: TIBDataSet
    Left = 1024
    Top = 128
  end
  inherited ds_Street: TDataSource
    Left = 864
    Top = 128
  end
  inherited ds_Street2: TDataSource
    Left = 912
    Top = 128
  end
  inherited ds_HouseType: TDataSource
    Left = 992
    Top = 128
  end
end
