object frm_Equipment: Tfrm_Equipment
  Left = 547
  Top = 308
  Width = 249
  Height = 152
  Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 20
    Width = 11
    Height = 13
    Caption = #8470
  end
  object btn_Save: TBitBtn
    Left = 57
    Top = 48
    Width = 107
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 1
    OnClick = btn_SaveClick
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
  object btn_Close: TBitBtn
    Left = 57
    Top = 82
    Width = 107
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = btn_CloseClick
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
  object dbl_Equip: TRxDBLookupCombo
    Left = 24
    Top = 16
    Width = 185
    Height = 21
    DropDownCount = 8
    LookupField = 'id'
    LookupDisplay = 'fl_FULL_NAME'
    LookupSource = ds_equip
    TabOrder = 0
    OnChange = dbl_EquipChange
    OnKeyDown = FormKeyDown
  end
  object ds_equip: TDataSource
    DataSet = mem_Equip
    Left = 160
    Top = 8
  end
  object dset_Equip: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_voc
    SelectSQL.Strings = (
      'select e.id, e.id as EquipID,'
      
        'iif (gos_number is null , rtrim(name)||'#39' '#8470#39'||number,'#39' '#8470#39'||rtrim(' +
        'gos_number)||'#39'('#39'||number||'#39')-'#39'||v_kovsh||'#39#1084'3'#39')'
      ' as name'
      'from equipment e'
      '/*'
      'inner join db_consts const on ( 1 = 1 )'
      
        'inner join db_districtvoc dv on ( dv.id_district = const.id_dist' +
        'rict )'
      '   and (dv.id_region = e.id_region)'
      '   and (dv.id_vocrectype = e.id_vocrectype )'
      '*/'
      'where (e.activity is null)'
      'and e.FK_EQUIP_TYP=1'
      'order by e.number')
    Left = 200
    Top = 8
  end
  object tr_exec: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'concurrency'
      'nowait')
    Left = 24
    Top = 144
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tr_tmp
    Left = 112
    Top = 184
  end
  object tr_voc: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 232
    Top = 8
  end
  object tr_tmp: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait'
      'read')
    Left = 112
    Top = 144
  end
  object sql_exec: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tr_exec
    Left = 24
    Top = 184
  end
  object mem_Equip: TkbmMemTable
    DesignActivation = True
    AttachedTo = dm_GlobalVocCache.mt_Equipment
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
        Name = 'number'
        DataType = ftInteger
      end
      item
        Name = 'id_region'
        DataType = ftInteger
      end
      item
        Name = 'id_vocrectype'
        DataType = ftInteger
      end
      item
        Name = 'activity'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'is_visible_for_cur_district'
        DataType = ftSmallint
      end
      item
        Name = 'fl_FULL_NAME'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'v_kovsh'
        DataType = ftFloat
      end
      item
        Name = 'gos_number'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'shot_name'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'id_typ'
        DataType = ftInteger
      end>
    Filtered = True
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    Filter = 'id_typ=1'
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 184
    Top = 56
  end
end
