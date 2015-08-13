inherited frm_OptVipolNaryad: Tfrm_OptVipolNaryad
  Left = 523
  Top = 282
  BorderStyle = bsDialog
  Caption = 'frm_OptVipolNaryad'
  ClientHeight = 102
  ClientWidth = 388
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 388
    Height = 72
    Align = alTop
  end
  object Label3: TLabel
    Left = 33
    Top = 27
    Width = 31
    Height = 13
    Caption = #1056#1072#1081#1086#1085
  end
  object Label4: TLabel
    Left = 4
    Top = 50
    Width = 59
    Height = 13
    Alignment = taCenter
    Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090#1099
  end
  object btn_ok: TBitBtn
    Left = 97
    Top = 75
    Width = 83
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Default = True
    TabOrder = 0
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
    Left = 181
    Top = 75
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 1
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
  object dbl_Region: TRxDBLookupCombo
    Left = 67
    Top = 24
    Width = 196
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_RegAttach
    TabOrder = 2
  end
  object dbl_WorkType: TRxDBLookupCombo
    Left = 67
    Top = 47
    Width = 196
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'name'
    LookupSource = ds_WorkTypeAttach
    TabOrder = 3
  end
  inline frame_SelDates: Tframe_SelDatePeriod
    Left = 3
    Top = 1
    Width = 259
    Height = 22
    TabOrder = 4
  end
  object RBG_Sort: TRadioGroup
    Left = 264
    Top = 0
    Width = 121
    Height = 65
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086':'
    ItemIndex = 0
    Items.Strings = (
      #1072#1076#1088#1077#1089#1091
      #1076#1072#1090#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
      #1085#1086#1084#1077#1088#1091' '#1085#1072#1088#1103#1076#1072)
    TabOrder = 5
  end
  object mt_RegAttach: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_regions
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
        Size = 32
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 1
      end>
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = 'activity is null'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 203
  end
  object ds_RegAttach: TDataSource
    DataSet = mt_RegAttach
    Left = 163
    Top = 8
  end
  object mt_WorkTypeAttach: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_s_worktype
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
        Size = 40
      end
      item
        Name = 'activity'
        DataType = ftSmallint
      end>
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = 'activity is null'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 139
    Top = 48
  end
  object ds_WorkTypeAttach: TDataSource
    DataSet = mt_WorkTypeAttach
    Left = 91
    Top = 40
  end
end
