inherited frm_VocBWork: Tfrm_VocBWork
  Left = 358
  Top = 345
  Width = 510
  Height = 429
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1088#1072#1073#1086#1090
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Left = 391
    Top = 31
    Width = 111
    Height = 158
    Align = alRight
    BevelOuter = bvNone
    inherited btn_Insert: TBitBtn
      Left = 4
      Top = 5
      Width = 104
    end
    inherited btn_Edit: TBitBtn
      Left = 4
      Top = 29
      Width = 104
    end
    inherited btn_Delete: TBitBtn
      Left = 4
      Top = 53
      Width = 104
    end
    inherited btn_Post: TBitBtn
      Left = 4
      Top = 92
      Width = 104
    end
    inherited btn_Cancel: TBitBtn
      Left = 3
      Top = 116
    end
    inherited btn_Exit: TBitBtn
      Left = 8
      Top = 165
      Width = 89
      Visible = False
    end
  end
  inherited pnl_EditFields: TPanel
    Top = 0
    Width = 502
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    object Label1: TLabel
      Left = 7
      Top = 8
      Width = 36
      Height = 13
      Caption = #1056#1072#1073#1086#1090#1072
    end
    object ed_Name: TDBEdit
      Left = 48
      Top = 5
      Width = 289
      Height = 21
      DataField = 'NAME_'
      DataSource = ds_MainVoc
      TabOrder = 0
    end
  end
  inherited pnl_Grid: TPanel
    Top = 31
    Width = 391
    Height = 158
    inherited dbg_MainVoc: TDBGrid
      Left = 1
      Top = 1
      Width = 389
      Height = 156
      Align = alClient
      ParentFont = False
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME_'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
          Width = 263
          Visible = True
        end>
    end
  end
  object pnl_Subwork: TPanel [3]
    Left = 0
    Top = 189
    Width = 502
    Height = 206
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      502
      206)
    object BitBtn1: TBitBtn
      Left = 403
      Top = 179
      Width = 89
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1093#1086#1076
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
    object PageControl1: TPageControl
      Left = 2
      Top = 4
      Width = 391
      Height = 198
      ActivePage = ts_Subworks
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      object ts_Subworks: TTabSheet
        Caption = #1055#1086#1076#1088#1072#1073#1086#1090#1099
        object dbg_Subwork: TDBGrid
          Left = 0
          Top = 0
          Width = 320
          Height = 170
          Align = alClient
          DataSource = ds_Subwork
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1072#1073#1086#1090#1099
              Width = 197
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DIAMETER'
              Title.Alignment = taCenter
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
              Width = 86
              Visible = True
            end>
        end
        object Panel1: TPanel
          Left = 320
          Top = 0
          Width = 63
          Height = 170
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object sb_AddSubworks: TSpeedButton
            Left = 5
            Top = 2
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
              DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
              B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
              9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
              FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
              8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
              FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
              82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FAFAFA000000000000000000000000000000000000000000000000000000
              00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
              00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
              06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
              F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
              E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
              E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
              FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = sb_AddSubworksClick
          end
          object sb_DelSubwork: TSpeedButton
            Left = 35
            Top = 2
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
              FB00F4F4F400E9E9E900DDDDDD00D7D7D700D4D4D400D4D4D400D4D4D400D4D4
              D400D4D4D400D8D8D800E0E0E000EBEBEB00F6F6F600FDFDFD00FFFFFF00F6F6
              F600DFDFDF00BBBBBB0096969600808080007777770077777700777777007777
              7700797979008181810098989800BCBCBC00E1E1E100F7F7F700FFFFFF00F8F8
              F800D3D3D300999999005D5D5D00404040004040400040404000404040004040
              40004040400040404000484848007E7E7E00C2C2C200EEEEEE00FFFFFF00FFFF
              FF00F4F4F40019191900121212000C0C0C000A0A0A0009090900090909000909
              090009090900080808000909090071717100B6B6B600EAEAEA00FFFFFF00FFFF
              FF00FFFFFF00505050002B2B2B00121212000101010000000000000000000000
              00000000000000000000131313009C9C9C00C5C5C500EDEDED00FFFFFF00FFFF
              FF00FFFFFF00939393009C9C9C00949494008C8C8C008C8C8C008C8C8C008B8B
              8B007C7C7C005656560023232300E2E2E200E6E6E600F6F6F600FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = sb_DelSubworkClick
          end
          object BitBtn2: TBitBtn
            Left = 5
            Top = 28
            Width = 54
            Height = 25
            Caption = #1057#1087#1088#1072#1074'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = BitBtn2Click
          end
        end
      end
      object ts_Maters: TTabSheet
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
        ImageIndex = 1
        object dbg_Maters: TDBGrid
          Left = 0
          Top = 0
          Width = 320
          Height = 170
          Align = alClient
          DataSource = ds_Maters
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1072
              Width = 141
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MEASUREMENT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084#1077#1088'.'
              Width = 71
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DIAMETER'
              Title.Alignment = taCenter
              Title.Caption = #1044#1080#1072#1084#1077#1090#1088
              Visible = True
            end>
        end
        object Panel2: TPanel
          Left = 320
          Top = 0
          Width = 63
          Height = 170
          Align = alRight
          TabOrder = 1
          object sb_AddMater: TSpeedButton
            Left = 5
            Top = 6
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FBFBFB00EEEEEE00DADADA00CDCDCD00CDCDCD00DADA
              DA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FBFBFB00E7E7E700C2C2C200A0A0A00097979700B0B0
              B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00F9F9F900EEEEEE000000000000000000000000009696
              9600CDCDCD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
              FB00EFEFEF00E1E1E100E1E1E100EBEBEB000000000000000000000000008787
              8700A7A7A700CDCDCD00DADADA00F2F2F200FFFFFF00FFFFFF00FFFFFF00FCFC
              FC00E8E8E800CBCBCB00C1C1C100D5D5D5000000000000000000000000008282
              82008080800090909000B0B0B000DADADA00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FAFAFA000000000000000000000000000000000000000000000000000000
              00000000000000000000A0A0A000CFCFCF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00313131001B1B1B00151515001313130000000000000000000000
              00000000000000000000B3B3B300D5D5D500FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00878787008686860077777700555555001F1F1F00000000000606
              06000505050000000000DCDCDC00E7E7E700FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00717171002525250000000000F5F5
              F500FFFFFF00FFFFFF00FCFCFC00F8F8F800FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007E7E7E003434340000000000E0E0
              E000FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008D8D8D005858580000000000E6E6
              E600F2F2F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
              FD00FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = sb_AddMaterClick
          end
          object sb_DelMater: TSpeedButton
            Left = 31
            Top = 6
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              20000000000000040000120B0000120B00000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
              FB00F4F4F400E9E9E900DDDDDD00D7D7D700D4D4D400D4D4D400D4D4D400D4D4
              D400D4D4D400D8D8D800E0E0E000EBEBEB00F6F6F600FDFDFD00FFFFFF00F6F6
              F600DFDFDF00BBBBBB0096969600808080007777770077777700777777007777
              7700797979008181810098989800BCBCBC00E1E1E100F7F7F700FFFFFF00F8F8
              F800D3D3D300999999005D5D5D00404040004040400040404000404040004040
              40004040400040404000484848007E7E7E00C2C2C200EEEEEE00FFFFFF00FFFF
              FF00F4F4F40019191900121212000C0C0C000A0A0A0009090900090909000909
              090009090900080808000909090071717100B6B6B600EAEAEA00FFFFFF00FFFF
              FF00FFFFFF00505050002B2B2B00121212000101010000000000000000000000
              00000000000000000000131313009C9C9C00C5C5C500EDEDED00FFFFFF00FFFF
              FF00FFFFFF00939393009C9C9C00949494008C8C8C008C8C8C008C8C8C008B8B
              8B007C7C7C005656560023232300E2E2E200E6E6E600F6F6F600FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = sb_DelMaterClick
          end
          object BitBtn3: TBitBtn
            Left = 5
            Top = 33
            Width = 49
            Height = 25
            Caption = #1057#1087#1088#1072#1074'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = BitBtn3Click
          end
        end
      end
    end
  end
  inherited dset_MainVoc: TIBDataSet
    DeleteSQL.Strings = (
      'delete from s_BWork where id = :old_id')
    InsertSQL.Strings = (
      'insert into s_Bwork(name_)'
      'values(:name_)')
    SelectSQL.Strings = (
      'select id, name_, activity'
      'from s_BWork'
      'where id>0'
      'order by name_')
    ModifySQL.Strings = (
      'update s_bwork set'
      'name_ = :name_,'
      'activity = :activity'
      'where id = :id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_BWORK_ID'
    GeneratorField.ApplyEvent = gamOnServer
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_BWORK"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MainVocNAME_: TIBStringField
      FieldName = 'NAME_'
      Origin = '"S_BWORK"."NAME_"'
      Size = 32
    end
    object dset_MainVocACTIVITY: TSmallintField
      FieldName = 'ACTIVITY'
      Origin = '"S_BWORK"."ACTIVITY"'
    end
  end
  object ds_Subwork: TDataSource
    DataSet = dset_Subwork
    Left = 80
    Top = 272
  end
  object dset_Subwork: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select bww.id, w.name,d.diameter, bww.id_work,  bww.id_diam'
      'from  s_bwork_work bww'
      'left join s_works w on w.id = bww.id_work'
      'left join s_tubediameter d on d.id = bww.id_diam'
      'where ( w.activity is null )'
      'and bww.id_bwork = :id'
      'order by w.name'
      '')
    DataSource = ds_MainVoc
    Left = 128
    Top = 272
    object dset_SubworkID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_BWORK_WORK"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_SubworkNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"S_WORKS"."NAME"'
      Size = 32
    end
    object dset_SubworkDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
      OnGetText = dset_SubworkDIAMETERGetText
    end
    object dset_SubworkID_WORK: TIntegerField
      FieldName = 'ID_WORK'
      Origin = '"S_BWORK_WORK"."ID_WORK"'
    end
    object dset_SubworkID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = '"S_BWORK_WORK"."ID_DIAM"'
    end
  end
  object tr_Exec: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 254
    Top = 281
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = tr_Exec
    Left = 166
    Top = 257
  end
  object dset_Maters: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select m.name, m.measurement, bm.id_mater, bm.id,'
      'bm.id_diam, td.diameter'
      'from s_bwork_mater bm'
      'left join materials m on m.id = bm.id_mater'
      'left join s_tubediameter td on td.id = bm.id_diam'
      'where ( m.activity is null )'
      'and bm.id_bwork = :id'
      'order by m.name')
    DataSource = ds_MainVoc
    Left = 126
    Top = 329
    object dset_MatersID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_BWORK_MATER"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_MatersNAME: TIBStringField
      FieldName = 'NAME'
      Origin = '"MATERIALS"."NAME"'
      FixedChar = True
      Size = 32
    end
    object dset_MatersMEASUREMENT: TIBStringField
      FieldName = 'MEASUREMENT'
      Origin = '"MATERIALS"."MEASUREMENT"'
      FixedChar = True
      Size = 16
    end
    object dset_MatersID_MATER: TIntegerField
      FieldName = 'ID_MATER'
      Origin = '"S_BWORK_MATER"."ID_MATER"'
    end
    object dset_MatersDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      Origin = '"S_TUBEDIAMETER"."DIAMETER"'
      OnGetText = dset_MatersDIAMETERGetText
    end
    object dset_MatersID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = '"S_BWORK_MATER"."ID_DIAM"'
    end
  end
  object ds_Maters: TDataSource
    DataSet = dset_Maters
    Left = 78
    Top = 329
  end
  object dset_WorkTime: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, id_work, id_diam'
      'from s_worktime')
    Left = 206
    Top = 281
    object dset_WorkTimeID: TIntegerField
      FieldName = 'ID'
      Origin = '"S_WORKTIME"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_WorkTimeID_WORK: TIntegerField
      FieldName = 'ID_WORK'
      Origin = '"S_WORKTIME"."ID_WORK"'
    end
    object dset_WorkTimeID_DIAM: TIntegerField
      FieldName = 'ID_DIAM'
      Origin = '"S_WORKTIME"."ID_DIAM"'
    end
  end
  object dset_VocMater: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, name'
      'from materials'
      'where activity is null')
    Left = 358
    Top = 305
  end
  object dset_VocDiam: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_MainVoc
    SelectSQL.Strings = (
      'select id, diameter name'
      'from s_tubediameter'
      'where activity is null')
    Left = 400
    Top = 301
  end
end
