inherited frm_WorkAndMater: Tfrm_WorkAndMater
  Left = 490
  Top = 256
  Width = 588
  Height = 458
  Caption = 'frm_WorkAndMater'
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 410
    Width = 580
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Panels = <>
    SimplePanel = True
    UseSystemFont = False
  end
  object pnl_Btns: TPanel
    Left = 0
    Top = 369
    Width = 580
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btn_Append: TBitBtn
      Left = 5
      Top = 8
      Width = 89
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_AppendClick
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
    object btn_Delete: TBitBtn
      Left = 183
      Top = 8
      Width = 89
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_DeleteClick
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
    object btn_Post: TBitBtn
      Left = 304
      Top = 8
      Width = 89
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
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
    object btn_Exit: TBitBtn
      Left = 482
      Top = 8
      Width = 89
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
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
    object btn_Edit: TBitBtn
      Left = 94
      Top = 8
      Width = 89
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btn_EditClick
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
    object btn_Cancel: TBitBtn
      Left = 393
      Top = 8
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btn_CancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 580
    Height = 369
    ActivePage = ts_FreeMater
    Align = alClient
    TabOrder = 2
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object ts_FreeMater: TTabSheet
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083
      inline frame_FreeMater: Tframe_MaterGrid_vds
        Left = 0
        Top = 0
        Width = 572
        Height = 341
        Align = alClient
        Color = clSilver
        ParentColor = False
        TabOrder = 0
        inherited DBGrid: TDBGridEh
          Left = 0
          Top = 65
          Width = 572
          Height = 276
          Align = alClient
          Columns = <
            item
              FieldName = 'MATER_NAME'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
              Width = 170
            end
            item
              FieldName = 'QUANTITY'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Width = 100
            end
            item
              FieldName = 'DIAM'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
            end
            item
              FieldName = 'MATPRICES'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1085#1082'. '#1085#1086#1084#1077#1088'/'#1094#1077#1085#1072'/'#1082#1086#1083'-'#1074#1086
              Width = 200
            end>
        end
        inherited pnl_Fields: TPanel
          Left = 0
          Top = 0
          Width = 572
          Height = 65
          Align = alTop
          inherited Label4: TLabel
            Left = 11
            Top = 44
          end
          inherited Label2: TLabel
            Left = 232
            Top = 16
            Width = 41
            Caption = #1050#1086#1083'-'#1074#1086
          end
          inherited Label3: TLabel
            Left = 400
            Top = 16
          end
          inherited dbl_Mater: TRxDBLookupCombo
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_MatPrices: TRxDBLookupCombo
            Left = 189
            Top = 40
            OnEnter = nil
            OnExit = nil
          end
          inherited ed_quantity: TDBEdit
            Left = 275
            Top = 13
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_Diam: TRxDBLookupCombo
            Left = 464
            Top = 13
            OnEnter = nil
            OnExit = nil
          end
        end
        inherited tr_Main: TIBTransaction
          Active = False
        end
        inherited tr_Voc: TIBTransaction
          Active = False
        end
      end
    end
    object ts_PayedMater: TTabSheet
      Caption = #1055#1083#1072#1090#1085#1099#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
      ImageIndex = 1
      inline frame_PayedMater: Tframe_MaterGrid_vds
        Left = 0
        Top = 0
        Width = 572
        Height = 341
        Align = alClient
        Color = clSilver
        ParentColor = False
        TabOrder = 0
        inherited DBGrid: TDBGridEh
          Left = 0
          Top = 73
          Width = 572
          Height = 268
          Align = alClient
          Columns = <
            item
              FieldName = 'MATER_NAME'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
              Width = 170
            end
            item
              FieldName = 'QUANTITY'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Width = 100
            end
            item
              FieldName = 'DIAM'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
            end
            item
              FieldName = 'MATPRICES'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1085#1082'. '#1085#1086#1084#1077#1088'/'#1094#1077#1085#1072'/'#1082#1086#1083'-'#1074#1086
              Width = 200
            end>
        end
        inherited pnl_Fields: TPanel
          Left = 0
          Top = 0
          Width = 572
          Height = 73
          Align = alTop
          inherited Label4: TLabel
            Left = 3
            Top = 48
          end
          inherited Label2: TLabel
            Left = 232
            Top = 16
            Width = 41
            Caption = #1050#1086#1083'-'#1074#1086
          end
          inherited Label3: TLabel
            Left = 408
            Top = 16
          end
          inherited dbl_Mater: TRxDBLookupCombo
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_MatPrices: TRxDBLookupCombo
            Left = 181
            Top = 40
            OnEnter = nil
            OnExit = nil
          end
          inherited ed_quantity: TDBEdit
            Left = 283
            Top = 13
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_Diam: TRxDBLookupCombo
            Left = 472
            Top = 13
            OnEnter = nil
            OnExit = nil
          end
        end
        inherited tr_Main: TIBTransaction
          Active = False
        end
        inherited tr_Voc: TIBTransaction
          Active = False
        end
      end
    end
    object ts_FreeWorks: TTabSheet
      Caption = #1056#1072#1073#1086#1090#1099
      ImageIndex = 2
      inline frame_WorkGrid_vds1: Tframe_WorkGrid_vds
        Left = 0
        Top = 0
        Width = 572
        Height = 341
        Align = alClient
        Color = clSilver
        ParentColor = False
        TabOrder = 0
        inherited DBGrid: TDBGridEh
          Left = 0
          Top = 65
          Width = 572
          Height = 276
          Align = alClient
        end
        inherited pnl_Fields: TPanel
          Left = 0
          Top = 0
          Width = 572
          Height = 65
          Align = alTop
          inherited Label1: TLabel
            Left = 0
          end
          inherited Label2: TLabel
            Left = 295
            Top = 12
          end
          inherited Label3: TLabel
            Left = 64
            Top = 40
          end
          inherited dbl_Work: TRxDBLookupCombo
            Left = 144
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_Diam: TRxDBLookupCombo
            Left = 352
            Top = 8
            OnEnter = nil
            OnExit = nil
          end
          inherited ed_Quantity: TDBEdit
            Left = 144
            Top = 32
            OnEnter = nil
            OnExit = nil
          end
        end
        inherited tr_Main: TIBTransaction
          Active = False
        end
      end
    end
    object ts_PayedWorks: TTabSheet
      Caption = #1055#1083#1072#1090#1085#1099#1077' '#1088#1072#1073#1086#1090#1099
      ImageIndex = 3
      inline frame_WorkGrid_vds2: Tframe_WorkGrid_vds
        Left = 0
        Top = 0
        Width = 572
        Height = 341
        Align = alClient
        Color = clSilver
        ParentColor = False
        TabOrder = 0
        inherited DBGrid: TDBGridEh
          Left = 0
          Top = 65
          Width = 572
          Height = 276
          Align = alClient
        end
        inherited pnl_Fields: TPanel
          Left = 0
          Top = 0
          Width = 572
          Height = 65
          Align = alTop
          inherited Label1: TLabel
            Left = 0
          end
          inherited Label2: TLabel
            Left = 289
            Top = 16
          end
          inherited Label3: TLabel
            Left = 64
            Top = 40
          end
          inherited dbl_Work: TRxDBLookupCombo
            Left = 144
            OnEnter = nil
            OnExit = nil
          end
          inherited dbl_Diam: TRxDBLookupCombo
            Left = 352
            Top = 8
            OnEnter = nil
            OnExit = nil
          end
          inherited ed_Quantity: TDBEdit
            Left = 144
            Top = 32
            OnEnter = nil
            OnExit = nil
          end
        end
        inherited tr_Main: TIBTransaction
          Active = False
        end
      end
    end
    object ts_Equip: TTabSheet
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      ImageIndex = 4
      inline frame_EquipGrid_vds1: Tframe_EquipGrid_vds
        Left = 0
        Top = 0
        Width = 572
        Height = 341
        Align = alClient
        Color = clSilver
        ParentColor = False
        TabOrder = 0
        inherited DBGrid: TDBGridEh
          Left = 0
          Top = 49
          Width = 572
          Height = 292
          Align = alClient
          Columns = <
            item
              FieldName = 'EQUIP_NAME'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
              Width = 300
            end>
        end
        inherited pnl_Fields: TPanel
          Left = 0
          Top = 0
          Width = 572
          Height = 49
          Align = alTop
        end
        inherited tr_Main: TIBTransaction
          Active = False
        end
        inherited tr_Voc: TIBTransaction
          Active = False
        end
      end
    end
  end
end
