inherited frm_UtechkiNaVodosetiRes: Tfrm_UtechkiNaVodosetiRes
  Left = 323
  Top = 249
  Width = 663
  Height = 487
  Caption = 'frm_UtechkiNaVodosetiRes'
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_Podacha: TPanel
    Left = 0
    Top = 0
    Width = 655
    Height = 25
    Align = alTop
    TabOrder = 0
    object lbl_PodachaHeader: TLabel
      Left = 5
      Top = 6
      Width = 112
      Height = 13
      Caption = 'lbl_PodachaHeader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object grd_Podacha: TStringAlignGrid
    Left = 0
    Top = 25
    Width = 655
    Height = 48
    Align = alTop
    DefaultRowHeight = 20
    TabOrder = 1
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
  object grd_Utechka: TStringAlignGrid
    Left = 0
    Top = 103
    Width = 655
    Height = 256
    Align = alClient
    DefaultRowHeight = 20
    RowCount = 12
    TabOrder = 2
    PropCell = ()
    PropCol = ()
    PropRow = ()
    PropFixedCol = ()
    PropFixedRow = ()
  end
  object pnl_Utechka: TPanel
    Left = 0
    Top = 73
    Width = 655
    Height = 30
    Align = alTop
    TabOrder = 3
    object lbl_UtechkaHeader: TLabel
      Left = 3
      Top = 11
      Width = 110
      Height = 13
      Caption = 'lbl_UtechkaHeader'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnl_btns: TPanel
    Left = 0
    Top = 417
    Width = 655
    Height = 41
    Align = alBottom
    TabOrder = 4
    object btn_Print: TBitBtn
      Left = 8
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
    object btn_Excel: TBitBtn
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Excel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        180000000000000300000000000000000000000000000000000039724B39724B
        39724B326C46326C46326C462B65412B65412B6541255C37255C37255C371D52
        301D52301D5230194C2939724B6BA67B65A07665A0765E9B715E9B7157966A57
        966A48935E48935E48935E3C8C563C8C56348C4E348C4E194C29407A566BA67B
        EBF3EBE8F1E8E6F0E6E4EFE4E2EEE3DFECDFDEEBDEDCEADDDCEADBD9E8D9D8E7
        D8D8E7D8348C4E194C29407A5670AA80EDF5EDEBF3EBEAF1E9E6F0E6E4EFE4E2
        EEE3DFECDFDEEBDEDCEADBDCEADBDAE9DAD8E7D83C8C561D523046805C75AF85
        EFF6EFEDF5EDEBF3EBE9F2E9E8F1E8E4EFE481AA8D2B512F2B512F2B512F2B51
        2FDAE9DA3C8C561D52304C87617BB58AF3F8F354A4592B512F2B512F2B512F2B
        512F1C771D6CB67448935E4A964C255C37DCEADB48935E255C37548E6681BC90
        F4F9F4F1F7F154A45962B27554A4591C771D7BC18548935E4A964C255C3781AA
        8DDCEADD48935E255C3757966A8AB795F6FAF6F5F9F5F3F8F354A45931873481
        BC9048935E4A964C255C37609963609963DFECDF48935E255C375E9B7194C79C
        F9FBFAF6FAF6F5F9F531873494C79C5BAA6454A459326C46036803E6F0E6E2EE
        E3E1EDE157966A2B654165A07694C79CFCFDFBF9FBFA3F93469DD0A76CB6745B
        AA6441874854A459318734036803E6F0E6E4EFE457966A2B65416BA67B9DD0A7
        FCFDFC4A964CAAD6B272BB7B72BB7B48935E56825967B06E54A4593187340368
        03E6F0E65E9B71326C4670AA809DD0A7FEFEFE67B06E63AC6863AC68569A5DF6
        F9F6F3F8F3568259568259568259568259E9F2E95E9B71326C4675AF85AAD6B2
        FEFEFEFDFEFDFDFEFDFCFDFBF9FBFAF8FAF8F6F9F6F4F9F4F1F7F1EFF6EFEDF5
        EDEBF3EB65A07639724B7BB58AAAD6B2FFFFFFFFFFFFFEFFFEFDFEFDFCFDFBF9
        FBFAF8FAF8F6FAF6F4F9F4F1F7F1EFF6EFEDF5ED65A07639724B7BB58AAAD6B2
        AAD6B29DD0A79DD0A794C79C94C79C94C79C8AB79581BC907BB58A75AF8570AA
        8070AA806BA67B39724B81BC907BB58A75AF8570AA806BA67B65A0765E9B7157
        966A548E664C87614C876146805C407A56407A5639724B39724B}
    end
    object btn_Word: TBitBtn
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Word'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000AF6234AD6032AA5E30A85B2CA45828A055249C502098
        4D1D9349199045158B4210873F0C843B098138067F35037D3401FFFFFFFFFFFF
        0000B86942EBAE94EBAD92E9AB90E6A98FE4A78BE0A488DDA285D89E81D59B7F
        D1997BCE9677CB9475C89173C790717F3603FFFFFFFFFFFF0000BB6C45ECB096
        FCF6F5FBF4F2FAF3F1FAF1F0F9F0EDF9EEECF8EEEAF8ECE9F8EAE7F7EAE6F6E8
        E5F6E7E3C89172813806FFFFFFFFFFFF0000BE6F49EDB29AFCF7F5FCF6F4FBF5
        F3FBF2F1FAF1F0F9F0EEF9EFEDF9EDEBF8ECE9F7EAE8F7E9E6F7E8E5CA937484
        3B09FFFFFFFFFFFF0000C3724CEEB59DFDF8F7A951268D4F29C0B8ABFAF3F1FA
        F1F0A95126583B14B5AB9CF8ECE9F8EAE8F7E9E7CD9677883F0CFFFFFFFFFFFF
        0000C77650EFB8A1FDFAF9C47B5EDE76448D4F29ECE9E6F5F2EFCD683F8D4F29
        583B14E9DFD9F8ECE9F7EBE8D1987A8B4210FFFFFFFFFFFF0000CC7B55F0BBA5
        FDFAFAC98369E29578DE76448D4F29E3D6CDDB7D58DE76448D4F29998B77F9ED
        EAF8ECE9D39B7D8F4514FFFFFFFFFFFF0000D17F5AF0BEA9FEFBFBD38E72B77F
        65D19B83DE76448D4F29C56E4AC98369B6623A583B14E9DFD9F8EEEBD79D8093
        4918FFFFFFFFFFFF0000D6825EF2C1ADFEFCFCD8977EB77F65E6BBACC98369DE
        7644854624E0AA96D175478D4F29A08F7CF9EFECDAA083984D1CFFFFFFFFFFFF
        0000DB8663F2C4B1FEFEFDDCA088B77F65F5E4E0DCA088E1AC98884927E2CBC2
        DDB9ABB6623A583B14F5F0EDDEA2869C5121FFFFFFFFFFFF0000DF8A68F4C7B5
        DF967CE4A891E4A891AD7A65FFFFFFD18669915030E2CBC2E1AC98C78169B662
        3AD49A81E1A589A05425FFFFFFFFFFFF0000E48E6BF4CAB8D8957FD28C73D28D
        75C87556DFBBAEFEFBFA995739FCF8F7CA7554CB7B5DCE7A5BC66C4AE4A78CA4
        5828FFFFFFFFFFFF0000E7916EF5CCBBFFFFFFFFFFFFFFFEFEFEFEFEFEFDFCFE
        FCFBFEFBFAFDF9F9FCF8F7FCF7F6FCF5F4FBF4F3E6AA8EA75B2DFFFFFFFFFFFF
        0000EB9372F6CEBEFFFFFFFFFFFFFFFFFFFFFFFEFFFEFDFEFDFCFDFCFBFEFAFA
        FDFAF9FCF8F8FCF7F6FBF5F4E9AB91AA5D2FFFFFFFFFFFFF0000ED9674F7CFC0
        F6CEBEF5CCBCF4CAB8F4C7B5F2C4B1F2C1ADF0BEA9F0BBA5EFB8A1EDB59DECB3
        9AECB096EBAE94AD6032FFFFFFFFFFFF0000ED9674ED9674EB9472E8916FE48F
        6DE18C68DD8865D88461D4815CCF7D58CA7953C57550C1714CBD6F48BA6C45AF
        6234FFFFFFFFFFFF0000}
    end
    object btn_Exit: TBitBtn
      Left = 392
      Top = 8
      Width = 75
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
  end
  object pnl_AddInfo: TPanel
    Left = 0
    Top = 359
    Width = 655
    Height = 58
    Align = alBottom
    TabOrder = 5
    object lbl_Podacha: TLabel
      Left = 5
      Top = 8
      Width = 71
      Height = 13
      Caption = 'lbl_Podacha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Utechka: TLabel
      Left = 5
      Top = 24
      Width = 69
      Height = 13
      Caption = 'lbl_Utechka'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_UtechkaPercent: TLabel
      Left = 4
      Top = 40
      Width = 113
      Height = 13
      Caption = 'lbl_UtechkaPercent'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end