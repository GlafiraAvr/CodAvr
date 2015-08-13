object frm_Work: Tfrm_Work
  Left = 285
  Top = 296
  Width = 756
  Height = 464
  Caption = #1056#1072#1073#1086#1090#1099'/'#1084#1072#1090#1077#1088#1080#1072#1083#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 105
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object dbg_BWork: TDBGridEh
      Left = 1
      Top = 1
      Width = 634
      Height = 103
      Align = alClient
      DataSource = ds_BWork
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbg_BWorkDblClick
      Columns = <
        item
          FieldName = 'lpBWORK'
          Footers = <>
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1073#1086#1090#1072
          Width = 238
        end>
    end
    object Panel3: TPanel
      Left = 635
      Top = 1
      Width = 112
      Height = 103
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btn_DelBWork: TBitBtn
        Left = 5
        Top = 70
        Width = 104
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 0
        OnClick = btn_DelBWorkClick
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
      object btn_AddBWork: TBitBtn
        Left = 4
        Top = 8
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 1
        OnClick = btn_AddBWorkClick
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
      object btn_EditBWork: TBitBtn
        Left = 4
        Top = 38
        Width = 105
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 2
        OnClick = btn_EditBWorkClick
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
  object pnl_WrkMat: TPanel
    Left = 0
    Top = 105
    Width = 748
    Height = 284
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object pc_Details: TPageControl
      Left = 1
      Top = 49
      Width = 633
      Height = 234
      ActivePage = ts_Work
      Align = alClient
      TabOrder = 0
      OnChange = pc_DetailsChange
      object ts_Work: TTabSheet
        Tag = 1
        Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1099
        object dbg_Work: TDBGridEh
          Left = 0
          Top = 35
          Width = 625
          Height = 171
          Align = alClient
          DataSource = ds_Work
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          UseMultiTitle = True
          OnDblClick = dbg_WorkDblClick
          OnDrawColumnCell = dbg_WorkDrawColumnCell
          Columns = <
            item
              AutoFitColWidth = False
              FieldName = 'clcWORK'
              Footers = <>
              Title.Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1072
              Width = 146
            end
            item
              AutoFitColWidth = False
              FieldName = 'lpDIAM'
              Footers = <>
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
              Width = 52
            end
            item
              AutoFitColWidth = False
              FieldName = 'QUANTITY'
              Footers = <>
              Title.Caption = #1050#1086#1083#1080'- '#1095#1077#1089#1090#1074#1086
              Width = 46
            end
            item
              AutoFitColWidth = False
              FieldName = 'WORK_TIME'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1079#1072#1076#1072#1085'. '#1082#1086#1083'-'#1074#1086'  '#1077#1076'.'
              Width = 101
            end
            item
              FieldName = 'MEASUR_QUANTITY'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1050#1086#1083'-'#1074#1086' '#1077#1076#1080#1085#1080#1094
              Width = 44
            end
            item
              FieldName = 'clcFULL_WORKTIME'
              Footers = <>
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099'||'#1054#1073#1097#1080#1077' '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
              Width = 78
            end
            item
              FieldName = 'ADDITIONALINFO'
              Footers = <>
              Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
              Width = 114
            end
            item
              FieldName = 'EXC_LENGTH'
              Footers = <>
              Title.Caption = #1044#1083#1080#1085#1072
              Width = 42
            end
            item
              FieldName = 'EXC_WIDTH'
              Footers = <>
              Title.Caption = #1064#1080#1088#1080#1085#1072
              Width = 42
            end
            item
              FieldName = 'EXC_DEPTH'
              Footers = <>
              Title.Caption = #1043#1083#1091#1073#1080#1085#1072
              Width = 45
            end
            item
              FieldName = 'SQUARE_ASF'
              Footers = <>
              Title.Caption = #1055#1083#1086#1097#1072#1076#1100' '#1072#1089#1092'.'
            end
            item
              Checkboxes = True
              FieldName = 'boolSent_1562'
              Footers = <>
              Title.Caption = #1054#1090'-'#1090#1100' '#1074' 1562'
              Visible = False
              Width = 45
            end
            item
              FieldName = 'Fact_DateTime'
              Footers = <>
              Title.Caption = #1044#1072#1090#1072' '#1074#1085#1077#1089#1077#1085#1080#1103
            end>
        end
        object pnl_WorkBnts: TPanel
          Left = 0
          Top = 0
          Width = 625
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object SB_Up: TSpeedButton
            Left = 176
            Top = 7
            Width = 23
            Height = 25
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333300033
              3333333333FFF33333333333333090333333333333F7F7333333333333309033
              3333333333F7F33333333333333090333333333333F7F3333333333333309033
              3333333333F7F73333333333333090333333333333F3F7333333333300009000
              0333333333F3F77773333333099999990333333FFFF3FFFF7333333330999990
              3333333F37333337333333333099999033333333F73333F73333333333099903
              33333333F37333733333333333099903333333333F733F733333333333309033
              333333333F37373333333333333090333333333333F7F7333333333333330333
              3333333333F37333333333333333033333333333333F73333333}
            NumGlyphs = 2
            OnClick = SB_UpClick
          end
          object SB_Down: TSpeedButton
            Left = 202
            Top = 7
            Width = 23
            Height = 25
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330333
              33333333333F733333333333333303333333333333F373333333333333309033
              3333333333F7F7333333333333309033333333333F3737333333333333099903
              333333333F733F73333333333309990333333333F37333733333333330999990
              33333333F73333F733333333309999903333333F373333373333333309999999
              0333333FFFF3FFFF73333333000090000333333333F3F7777333333333309033
              3333333333F3F73333333333333090333333333333F7F7333333333333309033
              3333333333F7F33333333333333090333333333333F7F3333333333333309033
              3333333333F7F73333333333333000333333333333FFF3333333}
            NumGlyphs = 2
            OnClick = SB_DownClick
          end
          object btn_RecalcWorkTime: TBitBtn
            Left = 4
            Top = 7
            Width = 157
            Height = 25
            Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
            TabOrder = 0
            OnClick = btn_RecalcWorkTimeClick
          end
        end
      end
      object ts_Mater: TTabSheet
        Tag = 2
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
        ImageIndex = 1
        object dbg_Mater: TDBGridEh
          Left = 0
          Top = 0
          Width = 625
          Height = 206
          Align = alClient
          DataSource = ds_Mater
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dbg_MaterDblClick
          Columns = <
            item
              FieldName = 'lpMater'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
              Width = 164
            end
            item
              FieldName = 'lpDiam'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
              Width = 73
            end
            item
              FieldName = 'Quantity'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
            end>
        end
      end
    end
    object pnl_EditWrkAndMat: TPanel
      Left = 634
      Top = 49
      Width = 113
      Height = 234
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btn_AddDetail: TBitBtn
        Left = 5
        Top = 24
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        OnClick = btn_AddDetailClick
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
      object btn_EditDetail: TBitBtn
        Left = 5
        Top = 56
        Width = 105
        Height = 25
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        TabOrder = 1
        OnClick = btn_EditDetailClick
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
      object btn_DelDetail: TBitBtn
        Left = 5
        Top = 88
        Width = 105
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 2
        OnClick = btn_DelDetailClick
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
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 746
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object rg_DetailView: TRadioGroup
        Left = 6
        Top = 6
        Width = 515
        Height = 39
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
          #1055#1088#1080#1074#1103#1079#1072#1085#1085#1099#1077' '#1082' '#1088#1072#1073#1086#1090#1077
          #1057#1074#1086#1073#1086#1076#1085#1099#1077' '#1079#1072#1087#1080#1089#1080)
        TabOrder = 0
        OnClick = rg_DetailViewClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 389
    Width = 748
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    DesignSize = (
      748
      41)
    object btn_FastAdd: TBitBtn
      Left = 8
      Top = 8
      Width = 153
      Height = 25
      Caption = #1041#1099#1089#1090#1088#1086#1077' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077
      TabOrder = 0
      OnClick = btn_FastAddClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 666
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 1
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
  object ds_BWork: TDataSource
    DataSet = dm_Work.dset_BWork
    Left = 48
    Top = 72
  end
  object ds_Work: TDataSource
    Left = 69
    Top = 298
  end
  object ds_Mater: TDataSource
    Left = 189
    Top = 290
  end
end
