object Spisok1562_Frame: TSpisok1562_Frame
  Left = 0
  Top = 0
  Width = 636
  Height = 450
  TabOrder = 0
  object p_MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 636
    Height = 392
    Align = alClient
    TabOrder = 0
    object Grid: TRxDBGrid
      Left = 1
      Top = 1
      Width = 634
      Height = 390
      Align = alClient
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawDataCell = GridDrawDataCell
      OnTitleClick = GridTitleClick
      OnGetCellProps = GridGetCellProps
      OnGetCellParams = GridGetCellParams
    end
  end
  object p_BottomPanel: TPanel
    Left = 0
    Top = 392
    Width = 636
    Height = 58
    Align = alBottom
    TabOrder = 1
    object lbl_DateComing2: TLabel
      Left = 147
      Top = 16
      Width = 15
      Height = 13
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 3
      Top = 16
      Width = 8
      Height = 13
      Caption = 'c'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object L_Regions: TLabel
      Left = 11
      Top = 40
      Width = 3
      Height = 13
    end
    object dp_Coming1: TDateEdit
      Left = 12
      Top = 13
      Width = 87
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
      Text = '05.11.2011'
    end
    object tp_Coming1: TMaskEdit
      Left = 101
      Top = 13
      Width = 47
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
    end
    object dp_Coming2: TDateEdit
      Left = 164
      Top = 13
      Width = 87
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
      Text = '25.12.2011'
    end
    object tp_Coming2: TMaskEdit
      Left = 253
      Top = 13
      Width = 46
      Height = 21
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
    end
    object rb_InWorkAndNot: TRadioButton
      Left = 384
      Top = 8
      Width = 113
      Height = 17
      Caption = #1053#1091#1078#1085#1086' '#1087#1088#1080#1085#1103#1090#1100' '
      TabOrder = 4
      OnClick = rb_InWorkAndNotClick
    end
    object rb_All: TRadioButton
      Left = 384
      Top = 40
      Width = 113
      Height = 17
      Caption = #1042#1089#1077
      TabOrder = 5
      OnClick = rb_AllClick
    end
    object rg_where: TRadioGroup
      Left = 544
      Top = 0
      Width = 57
      Height = 57
      BiDiMode = bdLeftToRight
      Ctl3D = True
      ItemIndex = 2
      Items.Strings = (
        #1053#1057
        #1042#1044#1057
        #1042#1089#1077)
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 6
    end
    object Regions: TButton
      Left = 305
      Top = 12
      Width = 75
      Height = 25
      Caption = #1056#1072#1081#1086#1085
      TabOrder = 7
      OnClick = RegionsClick
    end
    object rb_inworknot: TRadioButton
      Left = 384
      Top = 24
      Width = 153
      Height = 17
      Caption = #1053#1091#1078#1085#1086' '#1080' '#1085#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077
      TabOrder = 8
    end
    object BitBtn1: TBitBtn
      Left = 682
      Top = 3
      Width = 73
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 9
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 680
      Top = 32
      Width = 75
      Height = 25
      Caption = #1055#1077#1088#1077#1087#1088#1080#1085#1103#1090#1100
      TabOrder = 10
    end
  end
  object dset_region: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Voc
    SelectSQL.Strings = (
      'select id,iif(name='#39#39','#39#1042'c'#1077#39',name)  name, activity from s_regions'
      'where name is not null'
      'order by name '
      '')
    Left = 456
    Top = 216
  end
  object tran_Voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 496
    Top = 216
  end
  object ds_region: TDataSource
    DataSet = dset_region
    Left = 424
    Top = 216
  end
  object dset_region2: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Voc
    SelectSQL.Strings = (
      'select id,iif(name='#39#39','#39#1042'c'#1077#39',name)  name, activity from s_regions'
      'where name is not null'
      'order by name '
      '')
    Left = 592
    Top = 216
  end
  object ds_region2: TDataSource
    DataSet = dset_region2
    Left = 552
    Top = 216
  end
  object DSET_UCHASTOK: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_Voc
    SelectSQL.Strings = (
      'SELECT SHOT_NAME from s_uchastok')
    Left = 264
    Top = 192
  end
end
