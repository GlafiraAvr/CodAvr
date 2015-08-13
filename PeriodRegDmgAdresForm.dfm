inherited frm_PeriodRegDmgAdresSel: Tfrm_PeriodRegDmgAdresSel
  Left = 303
  Top = 180
  Caption = 'frm_PeriodRegDmgAdresSel'
  ClientHeight = 230
  ClientWidth = 383
  TransparentColor = True
  TransparentColorValue = clNavy
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 628
    Top = 18
  end
  inherited lbl_SONum: TLabel
    Left = 464
    Top = 48
  end
  inherited lbl_DateComing2: TLabel
    Left = 221
    Top = 14
  end
  inherited lbl_DateComing1: TLabel
    Top = 8
  end
  inherited Label9: TLabel
    Left = 834
    Top = 167
  end
  inherited Label8: TLabel
    Left = 667
    Top = 167
  end
  inherited Label10: TLabel
    Left = 1016
    Top = 167
  end
  inherited lbl_ecavpermis: TLabel
    Top = 224
    Visible = False
  end
  inherited tp_Coming2: TMaskEdit
    Top = 11
  end
  inherited tp_Coming1: TMaskEdit
    Top = 11
  end
  inherited sp_NumSO: TSpinEdit
    Left = 520
    Top = 11
  end
  inherited sp_NumOrder: TSpinEdit
    Left = 693
    Top = 11
  end
  inherited GroupBox2: TGroupBox
    Left = 712
    Top = 232
  end
  inherited GroupBox1: TGroupBox
    Width = 369
    Height = 97
    inherited lbl_po: TLabel
      Left = 128
      Top = 70
    end
    inherited Label4: TLabel
      Left = 16
    end
    inherited lbl_vid: TLabel
      Left = 48
      Top = 70
    end
    inherited lbl_withstreet: TLabel
      Left = 8
      Top = 70
    end
    object lbl_Adres: TLabel [4]
      Left = 8
      Top = 0
      Width = 83
      Height = 13
      Caption = #1040#1076#1088#1077#1089' '#1072#1074#1072#1088#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited dbl_HouseType: TRxDBLookupCombo
      Left = 64
      Top = 40
    end
    inherited dbl_Street2: TRxDBLookupCombo
      Left = 64
      Top = 64
      Width = 233
    end
    inherited dbl_Street: TRxDBLookupCombo
      Left = 64
      Width = 233
    end
    inherited ed_HouseNum1: TEdit
      Left = 64
      Top = 64
    end
    inherited ed_HouseNum2: TEdit
      Left = 144
      Top = 64
    end
  end
  inherited dp_Coming2: TDateEdit
    Left = 241
    Top = 11
  end
  inherited cb_OrderType: TComboBox
    Left = 720
    Top = 160
  end
  inherited cb_IsPayed: TComboBox
    Left = 904
    Top = 160
  end
  inherited cb_AreClosures: TComboBox
    Left = 720
    Top = 192
  end
  inherited btnNaControle: TBitBtn
    Left = 472
    Top = 79
  end
  inherited btn_ok: TBitBtn
    Top = 200
  end
  inherited btn_DamagePlace: TBitBtn
    Left = 8
    Top = 64
    Width = 369
  end
  inherited btn_DamageLocality: TBitBtn
    Left = 680
    Top = 120
  end
  inherited btn_cancel: TBitBtn
    Left = 296
    Top = 200
  end
  inherited btn_MessageType: TBitBtn
    Left = 679
    Top = 89
  end
  inherited btn_Regions: TBitBtn
    Left = 5
    Width = 372
  end
  inherited btn_Officials: TBitBtn
    Left = 675
    Top = 50
  end
  object rg_closed: TRadioGroup [27]
    Left = 7
    Top = 32
    Width = 281
    Height = 30
    Columns = 2
    Ctl3D = True
    ItemIndex = 1
    Items.Strings = (
      #1047#1072#1082#1088#1099#1090#1099#1077
      #1042#1089#1077' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103)
    ParentCtl3D = False
    TabOrder = 21
    OnClick = rg_closedClick
  end
  inherited dp_Coming1: TDateEdit
    Left = 81
    Top = 11
  end
  inherited me_Exorder: TMaskEdit
    Left = 177
    Top = 231
  end
  inherited Tr_Voc: TIBTransaction
    Top = 184
  end
  inherited dset_Street: TIBDataSet
    Top = 192
  end
  inherited dset_Street2: TIBDataSet
    Left = 288
    Top = 192
  end
  inherited dset_Housetype: TIBDataSet
    Left = 320
    Top = 192
  end
  inherited ds_Street: TDataSource
    Left = 216
    Top = 200
  end
  inherited ds_Street2: TDataSource
    Top = 192
  end
  inherited ds_HouseType: TDataSource
    Left = 312
    Top = 200
  end
end
