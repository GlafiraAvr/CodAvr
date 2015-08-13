inherited frm_PeriodCloseDmgExcSel: Tfrm_PeriodCloseDmgExcSel
  Left = 340
  Top = 218
  Caption = 'frm_PeriodCloseDmgExcSel'
  ClientHeight = 178
  ClientWidth = 275
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 652
    Top = 26
  end
  inherited lbl_DateComing2: TLabel
    Left = 741
  end
  inherited lbl_DateComing1: TLabel
    Left = 613
    Width = 9
    Height = 13
    Caption = 'C'
  end
  inherited Label9: TLabel
    Left = 642
    Top = 190
  end
  inherited Label8: TLabel
    Left = 475
    Top = 190
  end
  inherited Label10: TLabel
    Left = 824
    Top = 190
  end
  inherited sp_NumSO: TSpinEdit
    Left = 344
    Top = 11
  end
  inherited sp_NumOrder: TSpinEdit
    Left = 717
    Top = 19
  end
  inherited GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 273
    Height = 177
    inherited Label11: TLabel
      Left = 16
      Top = 18
      Width = 9
      Height = 13
      Caption = #1057
    end
    inherited Label5: TLabel
      Left = 137
      Top = 19
    end
    inherited btn_excworktype: TBitBtn [2]
      Left = 24
      Top = 78
      Width = 225
      Caption = #1058#1080#1087' '#1088#1072#1089#1082#1086#1087#1086#1082
    end
    inherited btn_OfficialsClosed: TBitBtn [3]
      Left = 536
      Top = 40
    end
    inherited btn_DamageType: TBitBtn [4]
      Left = 520
      Top = 8
    end
    inherited btn_TubeDiameter: TBitBtn [5]
      Left = 528
      Top = 41
    end
    inherited btn_TubeMaterial: TBitBtn [6]
      Left = 511
      Top = 65
    end
    inherited btn_Brigadiers: TButton [7]
      Left = 520
      Top = 56
    end
    inherited dp_Closed1: TDateEdit
      Left = 32
      Top = 13
      OnChange = dp_Closed1Change
    end
    inherited dp_Closed2: TDateEdit
      Left = 158
      Top = 12
      OnChange = dp_Closed2Change
    end
    inherited tp_Closed1: TMaskEdit
      Left = 273
      Top = 158
      TabOrder = 10
    end
    inherited tp_Closed2: TMaskEdit
      TabOrder = 8
    end
    inherited chk_IsCalcLeak: TCheckBox
      TabOrder = 9
    end
  end
  inherited GroupBox1: TGroupBox
    Left = 464
  end
  inherited dp_Coming2: TDateEdit
    Left = 761
  end
  inherited cb_OrderType: TComboBox
    Left = 528
    Top = 183
  end
  inherited cb_IsPayed: TComboBox
    Left = 712
    Top = 183
  end
  inherited cb_AreClosures: TComboBox
    Left = 904
    Top = 183
  end
  inherited btn_ok: TBitBtn
    Top = 127
  end
  inherited btn_DamagePlace: TBitBtn
    Left = 24
    Top = 47
    Width = 225
  end
  inherited btn_DamageLocality: TBitBtn
    Left = 552
  end
  inherited btn_cancel: TBitBtn
    Left = 176
    Top = 127
  end
  inherited btn_MessageType: TBitBtn
    Left = 543
    Top = 73
  end
  inherited btn_Regions: TBitBtn
    Left = 845
    Top = 218
  end
  inherited btn_Officials: TBitBtn
    Left = 651
    Top = 50
  end
  inherited dp_Coming1: TDateEdit
    Left = 633
  end
  inherited Tr_Voc: TIBTransaction
    Left = 584
    Top = 144
  end
  inherited dset_Street: TIBDataSet
    Left = 648
    Top = 144
  end
  inherited dset_Street2: TIBDataSet
    Left = 736
    Top = 144
  end
  inherited dset_Housetype: TIBDataSet
    Left = 824
    Top = 144
  end
  inherited ds_Street: TDataSource
    Left = 664
    Top = 144
  end
  inherited ds_Street2: TDataSource
    Left = 712
    Top = 144
  end
  inherited ds_HouseType: TDataSource
    Left = 792
    Top = 144
  end
end
