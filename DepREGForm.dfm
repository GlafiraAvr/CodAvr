object frm_DepREG: Tfrm_DepREG
  Left = 318
  Top = 114
  Width = 771
  Height = 710
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1042#1099#1077#1079#1076#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_Dep: Tframe_Dep
    Left = 0
    Top = 28
    Width = 755
    Height = 585
    Align = alClient
    TabOrder = 0
    inherited tc_Deps: TmpTabControl
      Width = 755
      Height = 585
      Align = alClient
      inherited lbl_DateRegl: TLabel
        Left = 574
        Top = 67
      end
      inherited gb_BegWork: TGroupBox
        Width = 444
        inherited dbt_DispOpen: TDBText
          Width = 149
        end
      end
      inherited gb_EndWork: TGroupBox
        Width = 444
        inherited dbt_DispClose: TDBText
          Width = 149
        end
        inherited te_EndTime: TDBDateTimeEditEh
          Left = 180
        end
      end
      inherited mem_AddInfo: TDBMemo
        Height = 159
      end
      inherited gb_empting: TGroupBox
        Left = 453
        Width = 105
      end
      inherited gb_PlanWork: TGroupBox
        Width = 740
        inherited Label12: TLabel
          Left = 603
        end
        inherited dbt_Plan: TDBText
          Left = 639
          DataField = 'lp_DispPlan'
        end
        inherited dbl_Equipment: TRxDBLookupCombo
          Left = 416
          Width = 176
        end
      end
      inherited dbe_ReplPlan: TDBDateEdit
        Left = 656
        Top = 72
        Width = 90
      end
      inherited dbl_Region_brig: TRxDBLookupCombo
        Left = 584
        Top = 308
        Width = 161
      end
      inherited pnl_closeExcav: TPanel
        Left = 0
        Top = 344
        Width = 753
        Height = 257
        inherited Label13: TLabel
          Left = 8
          Top = 40
        end
        inherited Label14: TLabel
          Top = 16
        end
        inherited Label17: TLabel
          Left = 224
          Top = 13
        end
        inherited btn_Close1562: TButton
          Left = 584
          Top = 24
          OnClick = frame_Depbtn_Close1562Click
        end
        inherited dbm_ClosedExcavInfo: TDBMemo
          Top = 37
          Width = 401
        end
        inherited de_dateclose_info: TDBDateEdit
          Left = 129
          Top = 11
        end
      end
      inherited pnl_closedCapRem: TPanel
        Left = 0
        Top = 458
        Width = 753
        inherited Label18: TLabel
          Left = 230
          Top = 14
        end
        inherited btn_caprem1562: TButton
          Left = 584
          OnClick = frame_Depbtn_caprem1562Click
        end
      end
    end
    inherited gb_Diameter: TGroupBox
      Left = 452
      Width = 109
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 613
    Width = 755
    Height = 40
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object btn_Post: TBitBtn
      Left = 280
      Top = 8
      Width = 99
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 0
      OnClick = btn_PostClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
    object btn_Cancel: TBitBtn
      Left = 384
      Top = 8
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btn_CancelClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 512
      Top = 8
      Width = 83
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 2
      OnClick = btn_ExitClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
    end
  end
  object btn_DepWorkers: TBitBtn
    Left = 584
    Top = 270
    Width = 121
    Height = 25
    BiDiMode = bdRightToLeftReadingOnly
    Caption = #1051#1102#1076#1080
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = btn_DepWorkersClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050FF00055555
      555558070F00555555550800FFF8055555550880000F800555555007FFF08800
      055555500FF800BBB0055555500BBBBBBBB05555500000000BB855500BBBBBBB
      B000550BB000000B000F50B00BBBBB0B0B50500BBBBBBB0B0B55550BBBBBB0B0
      B0555550BBBB0B0B055555550000B00055555555550000555555}
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 653
    Width = 755
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Pnl_year: TPanel
    Left = 0
    Top = 0
    Width = 755
    Height = 28
    Align = alTop
    TabOrder = 4
    object Label2: TLabel
      Left = 40
      Top = 8
      Width = 18
      Height = 13
      Caption = #1043#1086#1076
    end
    object spe_year: TSpinEdit
      Left = 79
      Top = 4
      Width = 74
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 1
      OnChange = spe_yearChange
    end
    object dbl_region: TRxDBLookupCombo
      Left = 240
      Top = 3
      Width = 176
      Height = 21
      DropDownCount = 8
      DataField = 'FK_DEPARTURE_REGIONS'
      DataSource = frame_Dep.ds_Dep
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_Region
      ReadOnly = True
      TabOrder = 1
      Visible = False
    end
  end
  object btn_Adress: TBitBtn
    Left = 584
    Top = 304
    Width = 121
    Height = 25
    Caption = #1040#1076#1088#1077#1089
    TabOrder = 5
    OnClick = btn_AdressClick
  end
  object PageControl1: TPageControl
    Left = 576
    Top = 128
    Width = 169
    Height = 137
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 6
    object TabSheet1: TTabSheet
      Caption = #1042' '#1088#1072#1073#1086#1090#1077
      object Panel2: TPanel
        Left = 8
        Top = 4
        Width = 145
        Height = 101
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = 'pnl_workEquips'
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object btn_DepCharge: TBitBtn
          Left = 16
          Top = 8
          Width = 121
          Height = 25
          Caption = #1056#1072#1073#1086#1090#1099'/'#1084#1072#1090#1077#1088#1080#1072#1083#1099
          TabOrder = 0
          OnClick = btn_DepChargeClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
            1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
            1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
            193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
            11155557F755F777777555000755033305555577755F75F77F55555555503335
            0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
            05555757F75F75557F5505000333555505557F777FF755557F55000000355557
            07557777777F55557F5555000005555707555577777FF5557F55553000075557
            0755557F7777FFF5755555335000005555555577577777555555}
          NumGlyphs = 2
        end
        object btn_DepEquips: TBitBtn
          Left = 16
          Top = 40
          Width = 121
          Height = 25
          Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          TabOrder = 1
          OnClick = btn_DepEquipsClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086
      ImageIndex = 1
      object Gb_Plan: TGroupBox
        Left = 6
        Top = 0
        Width = 145
        Height = 105
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object Label1: TLabel
          Left = 19
          Top = 81
          Width = 42
          Height = 13
          Caption = #1041#1088#1080#1075#1072#1076#1072
        end
        object PlanWorkMat: TBitBtn
          Left = 18
          Top = 12
          Width = 121
          Height = 25
          BiDiMode = bdLeftToRight
          Caption = #1056#1072#1073#1086#1090#1099'/'#1084#1072#1090#1077#1088#1080#1072#1083#1099
          ParentBiDiMode = False
          TabOrder = 0
          WordWrap = True
          OnClick = PlanWorkMatClick
          Layout = blGlyphRight
          Margin = 3
        end
        object Plan_Equip: TBitBtn
          Left = 16
          Top = 44
          Width = 121
          Height = 25
          Caption = #1054#1073#1091#1088#1091#1076#1086#1074#1072#1085#1080#1077
          TabOrder = 1
          OnClick = Plan_EquipClick
        end
        object dbn_Brigada: TDBNumberEditEh
          Left = 72
          Top = 77
          Width = 50
          Height = 19
          DataField = 'PLAN_PEOPLE'
          DataSource = frame_Dep.ds_Dep
          EditButton.Style = ebsUpDownEh
          EditButton.Visible = True
          TabOrder = 2
          OnChange = dbn_BrigadaChange
        end
      end
    end
  end
  object DataSource1: TDataSource
    Left = 176
    Top = 16
  end
  object ds_Region: TDataSource
    DataSet = dm_NGDep.mem_Region
    Left = 200
    Top = 40
  end
end
