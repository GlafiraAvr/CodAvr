inherited frm_PeriodRegDmgDiamSel: Tfrm_PeriodRegDmgDiamSel
  Left = 331
  Top = 253
  Caption = 'frm_PeriodRegDmgDiamSel'
  ClientHeight = 264
  ClientWidth = 284
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 764
    Top = 266
  end
  inherited Label8: TLabel [1]
    Left = 715
  end
  inherited Label9: TLabel [2]
    Left = 882
  end
  inherited Label10: TLabel [3]
    Left = 1064
  end
  inherited lbl_DateComing2: TLabel [4]
    Left = 141
  end
  inherited lbl_DateComing1: TLabel [5]
    Left = 13
    Top = 10
    Width = 9
    Height = 13
    Caption = 'C'
  end
  inherited lbl_ecavpermis: TLabel [6]
    Top = 272
  end
  inherited lbl_SONum: TLabel [7]
    Left = 368
    Top = 32
  end
  inherited btn_Officials: TBitBtn [8]
    Left = 755
    Top = 314
    TabOrder = 22
  end
  inherited btn_MessageType: TBitBtn [9]
    Left = 767
    Top = 25
    TabOrder = 17
  end
  inherited GroupBox1: TGroupBox [10]
    Left = 616
    Top = 64
    TabOrder = 4
  end
  inherited btn_DamageLocality: TBitBtn [11]
    Left = 23
    Top = 195
    Width = 226
    TabOrder = 12
  end
  inherited cb_OrderType: TComboBox [12]
    Left = 768
    TabOrder = 6
  end
  inherited cb_IsPayed: TComboBox [13]
    Left = 952
    TabOrder = 7
  end
  inherited cb_AreClosures: TComboBox [14]
    Left = 1144
    TabOrder = 8
  end
  inherited GroupBox2: TGroupBox [15]
    Left = 24
    Top = 136
    Width = 225
    Height = 57
    ParentCtl3D = False
    TabOrder = 18
    inherited Label11: TLabel
      Left = 544
      Top = 194
    end
    inherited Label5: TLabel
      Left = 769
      Top = 203
    end
    inherited btn_TubeDiameter: TBitBtn
      Left = 0
      Top = 5
      Width = 225
    end
    inherited btn_TubeMaterial: TBitBtn
      Left = -1
      Top = 33
      Width = 226
    end
    inherited btn_excworktype: TBitBtn
      Left = 760
      Top = 136
    end
    inherited btn_Brigadiers: TButton
      Left = 552
      Top = 48
    end
    inherited btn_DamageType: TBitBtn
      Left = 808
      Top = 56
    end
    inherited btn_OfficialsClosed: TBitBtn
      Left = 360
      Top = 104
    end
    inherited dp_Closed1: TDateEdit
      Left = 656
      Top = 197
    end
    inherited dp_Closed2: TDateEdit
      Left = 790
      Top = 196
    end
  end
  inherited btn_Regions: TBitBtn [16]
    Left = 24
    Top = 82
    Width = 225
    TabOrder = 16
  end
  inherited btn_DamagePlace: TBitBtn [17]
    Left = 24
    Top = 111
    Width = 225
  end
  inherited btn_ok: TBitBtn [18]
    Top = 231
    TabOrder = 10
  end
  inherited btn_cancel: TBitBtn [19]
    Left = 176
    Top = 231
    TabOrder = 13
  end
  inherited dp_Coming1: TDateEdit [20]
    Left = 25
    Top = 6
  end
  inherited dp_Coming2: TDateEdit [21]
    Left = 161
    Top = 6
    TabOrder = 19
  end
  object cb_SortType: TComboBox [22]
    Left = 152
    Top = 43
    Width = 113
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 21
    Text = #1055#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
    Items.Strings = (
      #1055#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
      #1055#1086' '#1091#1073#1099#1074#1072#1085#1080#1102)
  end
  object sp_DamageCount: TRxSpinEdit [23]
    Left = 94
    Top = 43
    Width = 49
    Height = 21
    MaxValue = 100000.000000000000000000
    MinValue = 1.000000000000000000
    Value = 1.000000000000000000
    TabOrder = 15
  end
  inherited sp_NumOrder: TSpinEdit [24]
    Left = 829
    Top = 259
  end
  inherited tp_Coming2: TMaskEdit [25]
  end
  inherited tp_Coming1: TMaskEdit [26]
    Left = 359
    Top = 67
  end
  inherited sp_NumSO: TSpinEdit [27]
    Left = 360
    Top = 11
  end
  inherited btnNaControle: TBitBtn [28]
    TabOrder = 9
  end
  inherited btn_BrigDep1: TBitBtn [29]
    TabOrder = 14
  end
  inherited me_Exorder: TMaskEdit
    Top = 271
  end
  inherited Tr_Voc: TIBTransaction
    Left = 736
    Top = 112
  end
  inherited dset_Street: TIBDataSet
    Left = 800
    Top = 112
  end
  inherited dset_Street2: TIBDataSet
    Left = 888
    Top = 112
  end
  inherited dset_Housetype: TIBDataSet
    Left = 976
    Top = 112
  end
  inherited ds_Street: TDataSource
    Left = 816
    Top = 112
  end
  inherited ds_Street2: TDataSource
    Left = 864
    Top = 112
  end
  inherited ds_HouseType: TDataSource
    Left = 944
    Top = 112
  end
end
