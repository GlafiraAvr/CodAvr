object Frame_picters: TFrame_picters
  Left = 0
  Top = 0
  Width = 427
  Height = 346
  TabOrder = 0
  OnResize = FrameResize
  object pnl_buttons: TPanel
    Left = 0
    Top = 312
    Width = 427
    Height = 34
    Align = alBottom
    TabOrder = 0
    object spb_add: TSpeedButton
      Left = 322
      Top = 4
      Width = 23
      Height = 22
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spb_addClick
    end
    object sp_del: TSpeedButton
      Left = 351
      Top = 8
      Width = 23
      Height = 18
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sp_delClick
    end
    object SpeedButton1: TSpeedButton
      Left = 384
      Top = 3
      Width = 23
      Height = 22
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFF626FA2091D6B0B1B5A0C1A520C1A520B
        1A540B1A5309195406185605175604155501145400104C383F5CFFFFFFFFFFFF
        0000FFFFFFFFFFFF1031B81937AD1E379A1F358E1F358F1D358F1B358F183491
        1331920E2F92092C92042489011B72001255FFFFFFFFFFFF0000FFFFFFFFFFFF
        193FD52C4FDD3555D73E5ACD7284D4CACFE0E4E4E4E4E4E4C5CCE06683D71244
        D00938C0032795021764FFFFFFFFFFFF0000FFFFFFFFFFFF254ADF6580E96882
        E9A2B2F2FFFFFFBBC8F6738FEE708FEFBACAF8FFFFFF98B1F60E44D8072EA403
        1A6BFFFFFFFFFFFF0000FFFFFFFFFFFF2F53E16D85EAA1B1F1FFFFFF8398EE47
        6AE64167E73864E82D5EE97394F1FFFFFF6482DE0C32A4071D6BFFFFFFFFFFFF
        0000FFFFFFFFFFFF385AE2748BEBEFF2FDBBC6F54F6EE64A6BE6FFFFFFFFFFFF
        2E5DE82557E8B6C7F8CBD2E81235A30B206BFFFFFFFFFFFF0000FFFFFFFFFFFF
        4161E47A90ECFFFFFF8195ED516EE64969E5FFFFFFFFFFFF2D59E62453E66687
        EEECECEC1738A30E226AFFFFFFFFFFFF0000FFFFFFFFFFFF4766E58095EDFFFF
        FF8195ED516DE64968E5FFFFFFFFFFFF2D56E42551E46583ECECECEC1C3AA211
        236AFFFFFFFFFFFF0000FFFFFFFFFFFF516EE6879BEDF2F4FDB7C2F5526DE649
        66E4FFFFFFFFFFFF2D53E2274FE2B0BFF5CFD5E81F3BA013246AFFFFFFFFFFFF
        0000FFFFFFFFFFFF5571E78EA0EFABBAF4FFFFFF8193ED4D68E54362E43B5CE3
        3155E26D86EBFFFFFF6A80DA223CA0142569FFFFFFFFFFFF0000FFFFFFFFFFFF
        607BE899AAF08CA0EFA6B5F2FFFFFFB1BDF47186EA6C83E9B0BDF4FFFFFF95A8
        F02D4ED0233DA0142569FFFFFFFFFFFF0000FFFFFFFFFFFF889CEEC3CDF7BEC9
        F69CADF1B7C3F5F3F5FDFFFFFFFFFFFFF0F3FDAEBBF37D93EC3C5EE32744B113
        2672FFFFFFFFFFFF0000FFFFFFFFFFFFBBC6F5E5E9FBDBE1FAC1CBF6BDC8F6BA
        C5F5B8C3F5B6C2F5B4C0F4B1BEF4ADBBF37D93EC2C4CC9132A88FFFFFFFFFFFF
        0000FFFFFFFFFFFFE9EDFCD8DEF9BCC7F6A4B3F2A0AFF29DADF19AABF19BABF0
        98A9F094A6EF92A5EF758CEB2549D87988C3FFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000}
    end
    object DBNavigator1: TDBNavigator
      Left = 13
      Top = 4
      Width = 144
      Height = 25
      DataSource = ds_main
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
    end
  end
  object pnl_filename: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 33
    Align = alTop
    TabOrder = 1
    object blb_head: TLabel
      Left = 1
      Top = 1
      Width = 425
      Height = 31
      Align = alClient
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnl_Img: TPanel
    Left = 0
    Top = 33
    Width = 427
    Height = 279
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clAppWorkSpace
    TabOrder = 2
    object Image: TImage
      Left = 8
      Top = 8
      Width = 281
      Height = 217
    end
    object lb_mess: TLabel
      Left = 2
      Top = 2
      Width = 423
      Height = 275
      Align = alClient
      Alignment = taCenter
      Caption = 'lb_mess'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object ds_main: TDataSource
    DataSet = dm_avrpicter.mem_maps
    Left = 336
    Top = 56
  end
  object OpenDialog: TOpenDialog
    Filter = #39'All (*.jpg;*.jpeg)|*.jpg;*.jpeg|JPEG Image File (*.jpg)|*.jpg'
    Left = 352
    Top = 72
  end
end
