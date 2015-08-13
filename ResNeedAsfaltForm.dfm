inherited frm_ResNeedAsfalt: Tfrm_ResNeedAsfalt
  Left = 149
  Top = 260
  Width = 984
  Height = 471
  Caption = 'frm_ResNeedAsfalt'
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_top: TPanel
    Left = 0
    Top = 0
    Width = 976
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object lbl_Caption: TLabel
      Left = 17
      Top = 10
      Width = 64
      Height = 13
      Caption = 'lbl_Caption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnl_grid: TPanel
    Left = 0
    Top = 41
    Width = 976
    Height = 362
    Align = alClient
    TabOrder = 1
    object Grid: TDBGridEh
      Left = 1
      Top = 1
      Width = 974
      Height = 360
      Align = alClient
      DataSource = ds_Result
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
      OnTitleBtnClick = GridTitleBtnClick
      Columns = <
        item
          FieldName = 'line_num'
          Footers = <>
          Title.Caption = #8470' '#1087'.'#1087'.'
          Width = 25
        end
        item
          FieldName = 'region'
          Footers = <>
          Title.Caption = #1056#1072#1081#1086#1085
          Width = 123
        end
        item
          FieldName = 'need_restore_count'
          Footers = <>
          Tag = 1
          Title.Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %beg '#1075'.||'#1074#1089#1077#1075#1086'||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 43
        end
        item
          FieldName = 'need_restore_square'
          Footers = <>
          Title.Caption = #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %beg '#1075'.||'#1074#1089#1077#1075#1086'||'#1084'2'
          Width = 40
        end
        item
          FieldName = 'need_restore_gran_count'
          Footers = <>
          Tag = 2
          Title.Caption = 
            #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %beg '#1075'.||'#1074' '#1090'.'#1095'. '#1076#1086' %gran' +
            ' '#1075'.||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 44
        end
        item
          FieldName = 'need_restore_gran_square'
          Footers = <>
          Title.Caption = 
            #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %beg '#1075'.||'#1074' '#1090'.'#1095'. '#1076#1086' %gran' +
            ' '#1075'.||'#1084'2'
          Width = 36
        end
        item
          FieldName = 'plan_restore_count'
          Footers = <>
          Tag = 3
          Title.Caption = #1055#1083#1072#1085#1080#1088#1091#1077#1090#1089#1103' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089' %beg '#1075'. '#1087#1086' %end  '#1075'.||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 42
        end
        item
          FieldName = 'plan_restore_square'
          Footers = <>
          Title.Caption = #1055#1083#1072#1085#1080#1088#1091#1077#1090#1089#1103' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089' %beg '#1075'. '#1087#1086' %end  '#1075'.||'#1084'2'
          Width = 41
        end
        item
          FieldName = 'restored_plan_count'
          Footers = <>
          Tag = 4
          Title.Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1087#1086' '#1087#1083#1072#1085#1091'||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 42
        end
        item
          FieldName = 'restored_plan_square'
          Footers = <>
          Title.Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1087#1086' '#1087#1083#1072#1085#1091'||'#1084'2'
          Width = 41
        end
        item
          FieldName = 'new_exc_count'
          Footers = <>
          Tag = 5
          Title.Caption = 
            #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1099#1087#1086#1083#1085#1077#1085#1086' '#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1088#1072#1079#1088#1099#1090#1080#1081'||'#1096#1090 +
            '.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 36
        end
        item
          FieldName = 'new_exc_square'
          Footers = <>
          Title.Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1099#1087#1086#1083#1085#1077#1085#1086' '#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1088#1072#1079#1088#1099#1090#1080#1081'||'#1084'2'
          Width = 39
        end
        item
          FieldName = 'restored_noplan_count'
          Footers = <>
          Tag = 6
          Title.Caption = 
            #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1080' '#1074#1085#1077#1087#1083#1072 +
            #1085#1086#1074#1099#1093' '#1088#1072#1079#1088#1099#1090#1080#1081'||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 35
        end
        item
          FieldName = 'restored_noplan_square'
          Footers = <>
          Title.Caption = 
            #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1072#1074#1072#1088#1080#1081#1085#1099#1093' '#1080' '#1074#1085#1077#1087#1083#1072 +
            #1085#1086#1074#1099#1093' '#1088#1072#1079#1088#1099#1090#1080#1081'||'#1084'2'
          Width = 41
        end
        item
          FieldName = 'in_work_count'
          Footers = <>
          Tag = 7
          Title.Caption = #1054#1089#1090#1072#1077#1090#1089#1103' '#1074' '#1085#1072#1083#1080#1095#1080#1080' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %end '#1075'.||'#1074#1089#1077#1075#1086'||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 36
        end
        item
          FieldName = 'in_work_square'
          Footers = <>
          Title.Caption = #1054#1089#1090#1072#1077#1090#1089#1103' '#1074' '#1085#1072#1083#1080#1095#1080#1080' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %end '#1075'.||'#1074#1089#1077#1075#1086'||'#1084'2'
          Width = 36
        end
        item
          FieldName = 'ostat_gran_count'
          Footers = <>
          Tag = 8
          Title.Caption = 
            #1054#1089#1090#1072#1077#1090#1089#1103' '#1074' '#1085#1072#1083#1080#1095#1080#1080' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %end '#1075'.||'#1074' '#1090'.'#1095'. '#1076#1086' %gran '#1075'.||' +
            #1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 36
        end
        item
          FieldName = 'ostat_gran_square'
          Footers = <>
          Title.Caption = 
            #1054#1089#1090#1072#1077#1090#1089#1103' '#1074' '#1085#1072#1083#1080#1095#1080#1080' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102' '#1085#1072' %end '#1075'.||'#1074' '#1090'.'#1095'. '#1076#1086' %gran '#1075'.||' +
            #1084'2'
          Width = 32
        end
        item
          FieldName = 'total_restored_count'
          Footers = <>
          Tag = 9
          Title.Caption = #1042#1089#1077#1075#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1087#1086#1082#1088#1099#1090#1080#1103' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1096#1090'.'
          Title.Color = clMoneyGreen
          Title.TitleButton = True
          Width = 39
        end
        item
          FieldName = 'total_restored_square'
          Footers = <>
          Title.Caption = #1042#1089#1077#1075#1086' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1086' '#1087#1086#1082#1088#1099#1090#1080#1103' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||'#1084'2'
          Width = 41
        end
        item
          FieldName = 'percent_exc'
          Footers = <>
          Title.Caption = '% '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1089' %beg '#1075'. '#1087#1086' %end '#1075'.||%'
          Width = 70
        end>
    end
  end
  object pnl_btns: TPanel
    Left = 0
    Top = 403
    Width = 976
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btn_Print: TBitBtn
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btn_PrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 888
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
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
  object ds_Result: TDataSource
    DataSet = dm_RepNeedAsfalt.ResultDset
    Left = 112
    Top = 185
  end
end
