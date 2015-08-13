inherited frm_MiniSearchOpt: Tfrm_MiniSearchOpt
  Left = 376
  Top = 430
  BorderStyle = bsDialog
  Caption = 'frm_MiniSearchOpt'
  ClientHeight = 292
  ClientWidth = 300
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 300
    Height = 145
    Align = alTop
  end
  object mem_SelParams: TMemo
    Left = 0
    Top = 200
    Width = 300
    Height = 92
    Align = alBottom
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  inline frame_StreetSel: Tframe_VocItemSel
    Left = 55
    Top = 78
    Width = 193
    Height = 34
    TabOrder = 1
    inherited btn_sel: TBitBtn
      Caption = #1059#1083#1080#1094#1072
      OnClick = frame_StreetSelbtn_selClick
    end
    inherited mt_VocAttach: TkbmMemTable
      AttachedTo = dm_GlobalVocCache.mt_s_streets
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
          DataType = ftSmallint
        end>
    end
  end
  inline frame_RegSel: Tframe_VocItemSel
    Left = 55
    Top = 46
    Width = 193
    Height = 34
    TabOrder = 2
    inherited btn_sel: TBitBtn
      Caption = #1056#1072#1081#1086#1085
      OnClick = frame_RegSelbtn_selClick
    end
    inherited mt_VocAttach: TkbmMemTable
      AttachedTo = dm_GlobalVocCache.mt_s_regions
      AttachMaxCount = 5
      FieldDefs = <
        item
          Name = 'id'
          DataType = ftInteger
        end
        item
          Name = 'name'
          DataType = ftString
          Size = 32
        end
        item
          Name = 'activity'
          DataType = ftString
          Size = 1
        end>
    end
  end
  inline frame_DmgPlaceSel: Tframe_VocItemSel
    Left = 55
    Top = 110
    Width = 193
    Height = 34
    TabOrder = 3
    inherited btn_sel: TBitBtn
      Caption = #1052#1077#1089#1090#1086' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1103
    end
    inherited mt_VocAttach: TkbmMemTable
      AttachedTo = dm_GlobalVocCache.mt_s_damageplace
      AttachMaxCount = 5
      FieldDefs = <
        item
          Name = 'id'
          DataType = ftInteger
        end
        item
          Name = 'name'
          DataType = ftString
          Size = 32
        end
        item
          Name = 'activity'
          DataType = ftString
          Size = 1
        end>
    end
  end
  inline frame_Dates: Tframe_SelDatePeriod
    Left = 3
    Top = 4
    Width = 302
    Height = 37
    TabOrder = 4
    inherited Label1: TLabel
      Top = 5
      Width = 87
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#13#10#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1089
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited Label2: TLabel
      Left = 189
      Top = 13
      Width = 15
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited de_Begin: TDateEdit
      Left = 98
      Top = 9
    end
    inherited de_End: TDateEdit
      Left = 206
      Top = 9
    end
  end
  object btn_ok: TBitBtn
    Left = 8
    Top = 152
    Width = 90
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btn_okClick
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
  object btn_exit: TBitBtn
    Left = 202
    Top = 152
    Width = 90
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_exitClick
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