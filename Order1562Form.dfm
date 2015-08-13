inherited frm_Order1562: Tfrm_Order1562
  Left = 431
  Top = 201
  Width = 723
  Height = 666
  VertScrollBar.Position = 0
  Caption = 'ng'
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 257
    Width = 707
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  inherited gb_Top: TGroupBox
    Left = 0
    Top = 0
    Width = 707
    Height = 257
    Align = alTop
    object Splitter4: TSplitter
      Left = 281
      Top = 15
      Width = 7
      Height = 240
    end
    object About: TLabel
      Left = 424
      Top = 8
      Width = 96
      Height = 13
      Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object vle_Order1562: TValueListEditor
      Left = 2
      Top = 15
      Width = 279
      Height = 240
      Align = alLeft
      Color = clInfoBk
      TabOrder = 0
      TitleCaptions.Strings = (
        #1055#1072#1088#1072#1084#1077#1090#1088
        #1047#1085#1072#1095#1077#1085#1080#1077)
      ColWidths = (
        110
        163)
    end
    object Pnl_Vocs: TPanel
      Left = 688
      Top = 23
      Width = 265
      Height = 296
      TabOrder = 1
      Visible = False
      object l_closedtime: TLabel
        Left = 218
        Top = 263
        Width = 58
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103#13#10#1079#1072#1082#1088#1099#1090#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L_Isp1562: TLabel
        Left = 92
        Top = 46
        Width = 79
        Height = 13
        Alignment = taCenter
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L_Job1562: TLabel
        Left = 43
        Top = 128
        Width = 45
        Height = 13
        Alignment = taCenter
        Caption = #1056#1072#1073#1086#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_DispClose: TLabel
        Left = 123
        Top = 208
        Width = 65
        Height = 13
        Alignment = taCenter
        Caption = #1044#1080#1089#1087#1077#1090#1095#1077#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object l_Regl: TLabel
        Left = 58
        Top = 14
        Width = 65
        Height = 13
        Alignment = taCenter
        Caption = #1056#1077#1075#1083#1072#1084#1077#1085#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBL_Job1562: TRxDBLookupCombo
        Tag = 5
        Left = 40
        Top = 143
        Width = 289
        Height = 27
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_Job1562
        ParentFont = False
        TabOrder = 0
        OnChange = OnChangeControls
      end
      object DBL_Officials1562: TRxDBLookupCombo
        Tag = 3
        Left = 104
        Top = 60
        Width = 225
        Height = 23
        DropDownCount = 9
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_Officials1562
        ParentFont = False
        TabOrder = 1
        OnChange = OnChangeControls
      end
      object dp_End: TDateEdit
        Tag = 8
        Left = 74
        Top = 267
        Width = 104
        Height = 21
        NumGlyphs = 2
        TabOrder = 2
        OnChange = OnChangeControls
      end
      object me_End: TMaskEdit
        Tag = 9
        Left = 178
        Top = 267
        Width = 40
        Height = 21
        EditMask = '!90:00;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
        OnChange = OnChangeControls
      end
      object mem_officials: TMemo
        Tag = 4
        Left = 96
        Top = 87
        Width = 228
        Height = 37
        TabOrder = 4
        OnChange = OnChangeControls
      end
      object mem_job: TMemo
        Tag = 6
        Left = 40
        Top = 169
        Width = 288
        Height = 39
        TabOrder = 5
        OnChange = OnChangeControls
      end
      object DBL_DispClose: TRxDBLookupCombo
        Tag = 7
        Left = 72
        Top = 231
        Width = 217
        Height = 27
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        LookupField = 'NAME'
        LookupDisplay = 'NAME'
        LookupSource = ds_DispClose
        ParentFont = False
        TabOrder = 6
        OnChange = OnChangeControls
      end
      object de_Regl: TDateEdit
        Tag = 1
        Left = 124
        Top = 11
        Width = 104
        Height = 21
        NumGlyphs = 2
        TabOrder = 7
        OnChange = OnChangeControls
      end
      object te_Regl: TMaskEdit
        Tag = 2
        Left = 236
        Top = 11
        Width = 38
        Height = 21
        EditMask = '!90:00;1;0'
        MaxLength = 5
        TabOrder = 8
        Text = '  :  '
        OnChange = OnChangeControls
      end
    end
    object Memo1: TMemo
      Left = 288
      Top = 24
      Width = 401
      Height = 73
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 288
      Top = 104
      Width = 401
      Height = 49
      Caption = #1055#1088#1080#1085#1103#1090#1086
      TabOrder = 3
      object Label1: TLabel
        Left = 7
        Top = 20
        Width = 45
        Height = 13
        Caption = #1052#1072#1089#1090#1077#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object PrinMaster: TBitBtn
        Left = 336
        Top = 18
        Width = 57
        Height = 25
        Caption = #1055#1088#1080#1085#1103#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = PrinMasterClick
      end
      object dp_brig: TDateEdit
        Left = 184
        Top = 18
        Width = 97
        Height = 21
        TabStop = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object dbl_brig: TRxDBLookupCombo
        Left = 51
        Top = 18
        Width = 126
        Height = 23
        DropDownCount = 8
        LookupField = 'id'
        LookupDisplay = 'NAME'
        LookupSource = ds_brig
        TabOrder = 2
        OnChange = dbl_brigChange
      end
      object me_brig: TMaskEdit
        Left = 284
        Top = 18
        Width = 41
        Height = 21
        Enabled = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        TabOrder = 3
        Text = '  :  '
      end
    end
    object GroupBox2: TGroupBox
      Left = 288
      Top = 152
      Width = 401
      Height = 97
      Caption = #1053#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1086' '
      TabOrder = 4
      object Prin_why: TBitBtn
        Left = 317
        Top = 66
        Width = 75
        Height = 25
        Caption = #1055#1088#1080#1085#1103#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Prin_whyClick
      end
      object dp_why_not: TDateEdit
        Left = 8
        Top = 66
        Width = 105
        Height = 21
        TabStop = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object me_why_not: TMaskEdit
        Left = 117
        Top = 66
        Width = 41
        Height = 21
        Enabled = False
        EditMask = '!90:00;1;_'
        MaxLength = 5
        TabOrder = 2
        Text = '  :  '
      end
      object m_why_not: TMemo
        Left = 8
        Top = 16
        Width = 377
        Height = 49
        Lines.Strings = (
          'm_why_not')
        TabOrder = 3
        OnChange = m_why_notChange
      end
    end
  end
  inherited gb_Center: TGroupBox
    Left = 0
    Top = 262
    Width = 707
    Height = 51
    Align = alTop
    object btn_CloseOrder: TBitBtn [0]
      Left = 376
      Top = 48
      Width = 114
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1079#1072#1103#1074#1082#1091' 1562'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = btn_CloseOrderClick
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
    object btn_Previos: TBitBtn [1]
      Left = 24
      Top = 16
      Width = 33
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
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
    end
    object btnnext: TBitBtn [2]
      Left = 64
      Top = 16
      Width = 41
      Height = 25
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnnextClick
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
    end
    object btn_NewOrder: TBitBtn [3]
      Left = 470
      Top = 16
      Width = 108
      Height = 25
      Caption = #1053#1086#1074#1099#1081' '#1085#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_NewOrderClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    inherited btn_Save: TBitBtn
      Left = 584
      Top = 16
      TabOrder = 4
      OnClick = btn_SaveClick
    end
    object Canseled: TButton
      Left = 208
      Top = 16
      Width = 75
      Height = 25
      Caption = #1054#1090#1082#1072#1079
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = CanseledClick
    end
    object btn_Region: TButton
      Left = 128
      Top = 16
      Width = 73
      Height = 25
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object btn_Prepare: TBitBtn
      Left = 376
      Top = 16
      Width = 89
      Height = 25
      Caption = #1057#1074#1103#1079#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = BitBtn1Click
      Glyph.Data = {
        0E060000424D0E06000000000000360000002800000016000000160000000100
        180000000000D8050000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCFCF7F7F7EFF0F0E7E7E7E3E4E4E4E6
        E6EDEEEEF5F5F5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEF1F2F2E5E8E8E1E1E1E0E0E0DFDFE0DB
        DFDDDADCDDD7D8D8D8D8D8DFDEDEEEEFEFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFDFCFCF1EEEEE8E6E6E6E6E6E5E5E5E5E4E4
        E3E1E1E1E0E0E3DEDEE0DCDDDFDBDCDBD9D8D7D7D7E2E2E2FFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFBFBFBECECECE7EAEAE7E8E8E6E7E7E4E5
        E5E3E4E4E1E3E3E1E1E1DEE0E0DCDEDED8DCDBDADCDCD8D9D9D3D3D3DBD9D9FF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFDFDFDF0F0F0EBEEEDE8ECECF3F3F3F3
        F3F3F1F2F2EEF1F1EFF0F0EFEFEFEBEFEDE9EDECE7ECEBE7EBEAE9EBEBDFDFDF
        D5D3D3E5E5E5FFFFFFFFFFFF0000FFFFFFFFFFFFF5F5F5F1F1F1EEF0F0F7F5F6
        B1ACACAEA3A5B5AEB0B2ADADB3ADADB6ABABB7ABACB4ABABB2ABAAA9A3A4AFAB
        ACE7E6E6D8D9D9D5D5D5F3F3F3FFFFFF0000FFFFFFFAFAFAF3F3F3F2F3F3F4F1
        F1F9F5F5968B8CE6DCDDC3B9B9BAB3B2BCAFB1BEAEB0B5A7A8B2A1A3AD9C9DC9
        BCBD979091D5D4D4DBDFDED5D6D6E3E3E3FEFEFE0000FFFFFFF6F6F6F4F4F4F4
        F4F4F2F4F3F4F6F5A49C9CBFB9B8B0AAA9C1BDBCBEB7B79C9393C7C5C3C0BBBB
        A49A9AA09697B5ACAED7D4D4DCDFDED8D7D7D9D9D9FBFBFB0000FDFDFDF3F3F3
        F6F6F6F5F5F5F0F3F4FBFDFD8A7E7F948688E5E1E1FFFFFFB3A8A9A59697ACA5
        A5FFFFFFDFDEDE796E70867A7CD3D0D0DEE0DFDAD9D9D6D6D6F7F7F70000FBFB
        FBF1F1F1FAFAFAF6F5F5F1F6F4F3F6F6E8E3E4EADFE0FCF7F7959595CAC4C4FF
        FAFAB0A9A99A9594FCFAFADFD6D7D7CFD0E3DEDFDDDDDDDCDCDCD6D6D6F3F3F3
        0000FBFBFBEFEFEFFBFBFBF7F8F8F7F6F6F3F3F4F6F8F8EDE8E99D9194CDC6C8
        FFFFFFE6EBE8DCDDDBA99A9C978D8EEEEEEFE5E9E9E0E0DFDFDCDCDDDDDDD8D8
        D8F2F2F20000FCFCFCF0F0F0FBFBFBF9F9F9F9F6F6F8F4F4F9F9F8B0A7A88A7C
        7DB6A7AAB4A8A9F2F2F1A09C9C9B8E8E7B6F70B5B2B2E9EEEDE0E0E0E1DEDEDE
        DEDEDADADAF7F7F70000FEFEFEF1F1F1FAFAFAFBFBFBF8F8F8F6F7F6F7F5F5F9
        F3F4FAF2F3F2EFF1A89D9DEFEAE9968F8EEBEAE9F3F0F0EAE6E8E1E4E3DEE3E2
        E0E1E1DDDDDDDCDCDCFAFAFA0000FFFFFFF1F1F1F5F5F5FDFDFDF9F9F9F5F8F8
        F2F6F6F5F4F4F2F3F3F1F4F3A9A2A2EFE9E99A9090E9E7E7EAEAEAE9E4E5E7E3
        E3E2E2E3E3E2E2DDDDDDE5E6E6FEFEFE0000FFFFFFFBFBFBE9E9E9FFFFFFFBFB
        FBF9F9F9F3F7F6F3F5F5F1F3F2F4F3F3ADA2A4F1EBEB979190E8E6E7E9ECECE3
        E7E6E5E5E5E5E3E3E2E2E2DEDFDFF2F1F1FFFFFF0000FFFFFFFFFFFFECECECF4
        F4F4FFFEFEFCF9F9F6F7F7F5F8F8F6F4F5F8F4F5A49A9BE8E1E28E8888E9E5E6
        EEECEDE4E7E7E6E7E7E8E4E4E1E1E1E7E7E7FEFEFEFFFFFF0000FFFFFFFFFFFF
        FFFFFFE4E6E6F7F7F7FDFDFDFAF9F9F9F9F9F7F6F6FCF8F9B5AFB09791929C97
        96F3EFEFECECECEAEAEAE7E7E7E3E3E3E6E4E4FCFCFCFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFCFCFCEBEBEBF5F5F5FEFEFEF8F8F8F6F6F6F9F5F5FDF9FAF9
        F7F8FBF8F8F1EFEFECEBEBE9E9E9E6E7E7E8E9E9FAF9F9FFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEDEDEDF1F1F1FCFCFCFAFAFAF7F7F7
        F6F5F5F7F4F4F2F2F2EEEEEEE9EBEBE7E8E8EFEEEEFCFCFCFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9EFEFEFF2F2
        F2F5F5F5F4F4F4F1F2F2F1F1F1F1F1F1F2F2F2FBFBFBFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFCFCFCF8F8F8F7F7F7F7F7F7F9F9F9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
      Margin = 1
    end
    object cb_AddExcav: TCheckBox
      Left = 266
      Top = 24
      Width = 105
      Height = 14
      Caption = #1057' '#1088#1072#1089#1082#1086#1087#1082#1086#1081
      Color = clBtnFace
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 8
      WordWrap = True
      OnClick = cb_AddExcavClick
    end
  end
  inherited gb_Bottom: TGroupBox
    Left = 0
    Top = 354
    Width = 707
    Height = 233
    Align = alClient
    object Splitter3: TSplitter
      Left = 2
      Top = 225
      Width = 703
      Height = 6
      Cursor = crVSplit
      Align = alBottom
    end
    object Grid: TStringAlignGrid
      Left = 2
      Top = 15
      Width = 703
      Height = 210
      Align = alClient
      BiDiMode = bdLeftToRight
      Ctl3D = False
      DefaultRowHeight = 18
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnDblClick = GridDblClick
      OnEnter = GridEnter
      OnExit = GridExit
      OnKeyDown = GridKeyDown
      OnSelectCell = GridSelectCell
      SelectedCellColor = clBlue
      RowHeights = (
        18
        18
        18
        18
        18)
      PropCell = ()
      PropCol = ()
      PropRow = ()
      PropFixedCol = ()
      PropFixedRow = ()
    end
  end
  inherited ButtonPanel: TPanel
    Top = 587
    Width = 707
    Height = 41
    Constraints.MaxHeight = 41
    Constraints.MinHeight = 41
    object btn_Exit: TBitBtn
      Left = 624
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
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
    object btn_Order: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #1053#1072#1088#1103#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btn_OrderClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
    end
  end
  object pnl_OptExxcav: TPanel
    Left = 0
    Top = 313
    Width = 707
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object Label2: TLabel
      Left = 179
      Top = 11
      Width = 9
      Height = 13
      Caption = #1057
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 322
      Top = 12
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
    object cb_close: TCheckBox
      Left = 12
      Top = 10
      Width = 133
      Height = 17
      Caption = #1047#1072#1082#1088#1099#1090#1099#1077' '#1085#1072#1088#1103#1076#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cb_closeClick
    end
    object de_StartOrder: TDateEdit
      Left = 195
      Top = 8
      Width = 121
      Height = 21
      Enabled = False
      NumGlyphs = 2
      TabOrder = 1
      OnChange = de_StartOrderChange
    end
    object de_endOrder: TDateEdit
      Left = 339
      Top = 7
      Width = 121
      Height = 21
      Enabled = False
      NumGlyphs = 2
      TabOrder = 2
      OnChange = de_StartOrderChange
    end
    object btn_Seach: TBitBtn
      Left = 608
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1086#1080#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btn_SeachClick
    end
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 408
    Top = 334
  end
  object ib_exec: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 408
    Top = 310
  end
  object tran1562: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase1562_1
    Left = 440
    Top = 310
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 384
    Top = 334
  end
  object dset_Job1562: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, name, id_job1562'
      'from s_job1562'
      'order by name ')
    Left = 680
    Top = 192
  end
  object ds_Job1562: TDataSource
    DataSet = dset_Job1562
    Left = 712
    Top = 192
  end
  object dset_Officials1562: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, id1562,name, id_region'
      'from s_Officials1562'
      'where id_base = 1'
      'order by name ')
    Left = 680
    Top = 72
  end
  object ds_Officials1562: TDataSource
    DataSet = dset_Officials1562
    Left = 712
    Top = 72
  end
  object dset_DispClose: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    SelectSQL.Strings = (
      'select id, name'
      'from s_operators1562'
      'order by name ')
    Left = 680
    Top = 256
  end
  object ds_DispClose: TDataSource
    DataSet = dset_DispClose
    Left = 712
    Top = 256
  end
  object dset_cardwork: TIBDataSet
    Database = DM_Main.IBDatabase1562_1
    Transaction = tran1562
    SelectSQL.Strings = (
      
        'select DTTM_CLOSE, DTTM_IN_WORK, FK_ID_AVR_ORDER, FK_ID_SPISOK15' +
        '62, ID, ID_ISP, ID_JOB, ID_OPERATOR1562, IN_WORK, IS_CLOSED, IS_' +
        'DELETED, ISPA, JOBA, NUM1562')
    Left = 736
    Top = 22
  end
  object ADOQuery1562: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 312
    Top = 358
  end
  object ds_brig: TDataSource
    DataSet = dset_brig
    Left = 288
    Top = 120
  end
  object dset_work: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      '')
    Left = 400
    Top = 144
  end
  object tran_prin: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 432
    Top = 144
  end
  object ds_work: TDataSource
    DataSet = dset_work
    Left = 480
    Top = 144
  end
  object IBS_prin: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tran
    Left = 520
    Top = 152
  end
  object m_brig: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 5
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'name'
        DataType = ftString
        Size = 64
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'fk_brigadiers_regions'
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 248
    Top = 120
    object m_brigid: TIntegerField
      FieldName = 'id'
    end
    object m_brigname: TStringField
      FieldName = 'name'
      Size = 64
    end
    object m_brigactivity: TStringField
      FieldName = 'activity'
      Size = 1
    end
    object m_brigfk_brigadiers_regions: TIntegerField
      FieldName = 'fk_brigadiers_regions'
    end
  end
  object dset_brig: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran_prin
    SelectSQL.Strings = (
      ' select id, name,  activity, fk_brigadiers_regions'
      '    from brigadiers'
      '     order by name')
    Left = 240
    Top = 160
  end
end
