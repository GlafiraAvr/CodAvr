object frm_DepCDP: Tfrm_DepCDP
  Left = 384
  Top = 198
  Width = 767
  Height = 540
  Caption = #1063#1090#1086' '#1089#1076#1077#1083#1072#1085#1086
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frame_Dep: Tframe_Dep
    Left = 0
    Top = 0
    Width = 759
    Height = 233
    Align = alTop
    TabOrder = 0
    inherited tc_Deps: TmpTabControl
      Width = 759
      Align = alClient
      OnChange = frame_Deptc_DepsChange
      OnChanging = frame_Deptc_DepsChanging
      OnKeyDown = FormKeyDown
      inherited Label1: TLabel
        Top = 158
      end
      inherited Label8: TLabel
        Top = 178
      end
      inherited dbt_RecInfo: TDBText
        Top = 24
      end
      inherited gb_BegWork: TGroupBox
        Top = 63
        inherited de_BegDate: TDBDateEdit
          OnEnter = CtrlEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
        inherited te_BegTime: TDBDateTimeEditEh
          OnEnter = CtrlEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
      end
      inherited gb_EndWork: TGroupBox
        Top = 109
        inherited de_EndDate: TDBDateEdit
          OnEnter = frame_Depde_EndDateEnter
          OnExit = CtrlWithClearMsgExit
          OnKeyDown = frame_Depde_EndDateKeyDown
        end
        inherited te_EndTime: TDBDateTimeEditEh
          OnEnter = frame_Depte_EndTimeEnter
          OnExit = CtrlWithClearMsgExit
          OnKeyDown = frame_Depde_EndDateKeyDown
        end
      end
      inherited dbl_Brig: TRxDBLookupCombo
        Top = 155
        OnEnter = CtrlEnter
        OnExit = CtrlExit
        OnKeyDown = FormKeyDown
      end
      inherited mem_AddInfo: TDBMemo
        Top = 176
        Height = 54
        OnEnter = frame_Depmem_AddInfoEnter
        OnExit = CtrlWithClearMsgExit
        OnKeyDown = FormKeyDown
      end
      inherited dbl_MessType: TRxDBLookupCombo
        OnEnter = CtrlEnter
        OnExit = CtrlExit
        OnKeyDown = FormKeyDown
      end
      inherited gb_empting: TGroupBox
        inherited dbn_empting: TDBNumberEditEh
          Increment = 0.010000000000000000
          MinValue = 0.001000000000000000
          OnEnter = CtrlEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
      end
      inherited gb_PlanWork: TGroupBox
        Top = 18
        Width = 748
        inherited Label12: TLabel
          Left = 603
        end
        inherited dbt_Plan: TDBText
          Left = 639
          DataField = 'lp_DispPlan'
        end
        inherited de_PBegDate: TDBDateEdit
          OnEnter = frame_Depde_EndDateEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
        inherited de_PBegTime: TDBDateTimeEditEh
          OnEnter = frame_Depde_EndDateEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
        inherited de_PEndDate: TDBDateEdit
          Left = 236
          OnEnter = frame_Depde_EndDateEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
        inherited de_PEndTime: TDBDateTimeEditEh
          OnEnter = frame_Depte_EndTimeEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
        inherited dbl_Equipment: TRxDBLookupCombo
          Left = 408
          Width = 193
          OnEnter = CtrlEnter
          OnExit = CtrlExit
          OnKeyDown = FormKeyDown
        end
      end
      inherited dbe_ReplPlan: TDBDateEdit
        Left = 648
        Top = 160
      end
    end
    inherited pm_Deps: TPopupMenu
      inherited mi_DelDep: TMenuItem
        OnClick = frame_Depmi_DelDepClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 487
    Width = 759
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pnl_DepWorks: TPanel
    Left = 0
    Top = 233
    Width = 759
    Height = 212
    Align = alClient
    TabOrder = 2
    object dbg_DepWorks: TDBGridEh
      Left = 1
      Top = 1
      Width = 757
      Height = 177
      Align = alClient
      DataSource = ds_DepWorks
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      PopupMenu = pm_DepWorks
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      UseMultiTitle = True
      OnDblClick = dbg_DepWorksDblClick
      OnDrawColumnCell = dbg_DepWorksDrawColumnCell
      OnEnter = dbg_DepWorksEnter
      OnExit = CtrlWithClearMsgExit
      OnKeyDown = dbg_DepWorksKeyDown
      Columns = <
        item
          FieldName = 'lp_Work'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1056#1072#1073#1086#1090#1072
          Width = 234
        end
        item
          FieldName = 'lp_Diam'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1044#1080#1072#1084#1077#1090#1088
          Width = 54
        end
        item
          FieldName = 'Quantity'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 69
        end
        item
          FieldName = 'AddInfo'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
          Width = 106
        end
        item
          FieldName = 'exc_length'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1044#1083#1080#1085#1072
          Width = 51
        end
        item
          FieldName = 'exc_width'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1064#1080#1088#1080#1085#1072
          Width = 52
        end
        item
          FieldName = 'exc_depth'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1043#1083#1091#1073#1080#1085#1072
          Width = 50
        end
        item
          FieldName = 'SQUARE_ASF'
          Footers = <>
          Title.Caption = #1055#1083#1086#1097#1072#1076#1100' '#1072#1089#1092'.'
        end
        item
          Checkboxes = True
          FieldName = 'sentto1562'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1086#1089#1083#1072#1090#1100' '#1074' 1562'
          Width = 48
        end
        item
          FieldName = 'Fact_DateTime'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1074#1085#1077#1089#1077#1085#1080#1103' '
        end>
    end
    object pnl_WorkBtns: TPanel
      Left = 1
      Top = 178
      Width = 757
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object btn_AddWork: TBitBtn
        Left = 342
        Top = 4
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        TabStop = False
        OnClick = btn_AddWorkClick
        OnEnter = CtrlEnter
        OnExit = CtrlExit
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object btn_DeleteWork: TBitBtn
        Left = 562
        Top = 4
        Width = 105
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 1
        TabStop = False
        OnClick = btn_DeleteWorkClick
        OnEnter = CtrlEnter
        OnExit = CtrlExit
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
      end
      object btn_EditWork: TBitBtn
        Left = 452
        Top = 4
        Width = 105
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 2
        TabStop = False
        OnClick = btn_EditWorkClick
        OnEnter = CtrlEnter
        OnExit = CtrlExit
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
      end
    end
  end
  object pnl_Btns: TPanel
    Left = 0
    Top = 451
    Width = 759
    Height = 36
    Align = alBottom
    TabOrder = 3
    object btn_Post: TBitBtn
      Left = 219
      Top = 5
      Width = 91
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_PostClick
      OnEnter = CtrlEnter
      OnExit = CtrlExit
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
      Left = 312
      Top = 5
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_CancelClick
      OnEnter = CtrlEnter
      OnExit = CtrlExit
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
      Left = 449
      Top = 5
      Width = 105
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btn_ExitClick
      OnEnter = CtrlEnter
      OnExit = CtrlExit
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
    object btn_DeleteDep: TBitBtn
      Left = 9
      Top = 6
      Width = 112
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1077#1079#1076
      TabOrder = 3
      TabStop = False
      OnClick = btn_DeleteDepClick
      OnEnter = CtrlEnter
      OnExit = CtrlExit
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 445
    Width = 759
    Height = 6
    Align = alBottom
    BevelInner = bvRaised
    TabOrder = 4
  end
  object btn_DepEquips: TBitBtn
    Left = 568
    Top = 193
    Width = 121
    Height = 25
    Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
    TabOrder = 5
    OnClick = btn_DepEquipsClick
  end
  object ds_DepWorks: TDataSource
    DataSet = dm_WorkBuff.mt_DepWorks
    Left = 40
    Top = 265
  end
  object pm_DepWorks: TPopupMenu
    OnPopup = pm_DepWorksPopup
    Left = 248
    Top = 286
    object mi_DelWork: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1073#1086#1090#1091
      OnClick = mi_DelWorkClick
    end
  end
end
