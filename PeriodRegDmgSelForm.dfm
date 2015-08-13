inherited frm_PeriodRegDmgSel: Tfrm_PeriodRegDmgSel
  Left = 462
  Top = 307
  Caption = 'frm_PeriodRegDmgSel'
  ClientHeight = 167
  ClientWidth = 254
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 604
    Top = 418
  end
  inherited lbl_SONum: TLabel
    Left = 416
    Top = 64
  end
  inherited lbl_DateComing2: TLabel
    Left = 133
    Top = 6
  end
  inherited lbl_DateComing1: TLabel
    Left = 13
    Top = 8
    Width = 9
    Height = 13
    Caption = #1057
  end
  inherited Label9: TLabel
    Left = 722
    Top = 199
  end
  inherited Label8: TLabel
    Left = 555
    Top = 199
  end
  inherited Label10: TLabel
    Left = 904
    Top = 199
  end
  inherited tp_Coming2: TMaskEdit
    TabOrder = 4
  end
  inherited tp_Coming1: TMaskEdit
    Enabled = False
    TabOrder = 2
    Visible = False
  end
  inherited sp_NumSO: TSpinEdit
    Left = 408
    Top = 11
  end
  inherited sp_NumOrder: TSpinEdit
    Left = 669
    Top = 411
  end
  inherited GroupBox2: TGroupBox
    Left = 576
    TabOrder = 19
  end
  inherited GroupBox1: TGroupBox
    Left = 600
    Top = 80
    TabOrder = 11
  end
  inherited dp_Coming2: TDateEdit
    Left = 153
    Top = 3
    TabOrder = 3
  end
  inherited cb_OrderType: TComboBox
    Left = 608
    Top = 192
    TabOrder = 13
  end
  inherited cb_IsPayed: TComboBox
    Left = 792
    Top = 192
  end
  inherited cb_AreClosures: TComboBox
    Left = 984
    Top = 192
    TabOrder = 22
  end
  inherited btnNaControle: TBitBtn
    TabOrder = 5
  end
  inherited btn_ok: TBitBtn
    Top = 134
    TabOrder = 6
  end
  inherited btn_DamagePlace: TBitBtn
    Left = 30
    Top = 26
    Width = 195
    TabOrder = 7
  end
  object chk_IsShort: TCheckBox [21]
    Left = 8
    Top = 88
    Width = 169
    Height = 17
    Caption = #1059#1082'.'#1089#1074#1086#1076'.'#1074#1077#1076#1086#1084#1086#1089#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
    Visible = False
    OnClick = chk_IsShortClick
  end
  inherited btn_DamageLocality: TBitBtn
    Left = 632
    Top = 160
    TabOrder = 8
  end
  inherited btn_cancel: TBitBtn
    Left = 176
    Top = 134
    TabOrder = 9
  end
  inherited btn_BrigDep1: TBitBtn
    TabOrder = 10
  end
  inherited btn_MessageType: TBitBtn
    Left = 591
    Top = 41
    TabOrder = 12
  end
  inherited btn_Regions: TBitBtn
    Left = 29
    Top = 55
    Width = 196
    TabOrder = 14
  end
  inherited btn_Officials: TBitBtn
    Left = 595
    Top = 10
    TabOrder = 16
  end
  object chk_IsMiddle: TCheckBox [28]
    Left = 8
    Top = 110
    Width = 241
    Height = 17
    Caption = #1057#1088#1077#1076#1085#1077' '#1091#1082#1086#1088#1086#1095#1077#1085#1085#1072#1103' '#1089#1074#1086#1076'.'#1074#1077#1076'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 21
    Visible = False
  end
  inherited dp_Coming1: TDateEdit
    Left = 25
    Top = 3
    TabOrder = 17
  end
  inherited Tr_Voc: TIBTransaction
    Left = 600
  end
  inherited dset_Street: TIBDataSet
    Left = 664
  end
  inherited dset_Street2: TIBDataSet
    Left = 752
  end
  inherited dset_Housetype: TIBDataSet
    Left = 832
  end
  inherited ds_Street: TDataSource
    Left = 680
  end
  inherited ds_Street2: TDataSource
    Left = 728
  end
  inherited ds_HouseType: TDataSource
    Left = 808
  end
end
