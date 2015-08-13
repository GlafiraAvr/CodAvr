inherited frm_Discon: Tfrm_Discon
  Left = 343
  Top = 229
  Width = 627
  Height = 510
  Caption = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1103
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 619
    Height = 281
    object TabC: TTabControl
      Left = 1
      Top = 1
      Width = 617
      Height = 279
      Align = alClient
      TabOrder = 0
      OnChange = TabCChange
      OnChanging = TabCChanging
      object Bevel2: TBevel
        Left = 9
        Top = 176
        Width = 582
        Height = 30
      end
      object Bevel1: TBevel
        Left = 9
        Top = 141
        Width = 582
        Height = 33
      end
      object Label7: TLabel
        Left = 8
        Top = 113
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1058#1080#1087' '#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 13
        Top = 145
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1090#1072' '#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 16
        Top = 178
        Width = 65
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1090#1072#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 184
        Top = 144
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 184
        Top = 178
        Width = 65
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 220
        Top = 112
        Width = 71
        Height = 26
        Alignment = taCenter
        Caption = #1055#1088#1080#1095#1080#1085#1072#13#10#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 364
        Top = 144
        Width = 79
        Height = 26
        Alignment = taCenter
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100#13#10#1086#1090#1082#1083'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 350
        Top = 177
        Width = 97
        Height = 26
        Alignment = taCenter
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1074#1082#1083'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object l_addinfo: TLabel
        Left = 16
        Top = 216
        Width = 60
        Height = 13
        Caption = #1044#1086#1087'. '#1080#1085#1092'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 8
        Top = 235
        Width = 69
        Height = 26
        Alignment = taCenter
        Caption = #1044#1072#1090#1072' '#1087#1083#1072#1085'.'#13#10' '#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 184
        Top = 235
        Width = 75
        Height = 26
        Alignment = taCenter
        Caption = #1042#1088#1077#1084#1103' '#1087#1083#1072#1085'.'#13#10#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbl_DisconType: TRxDBLookupCombo
        Left = 88
        Top = 115
        Width = 125
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_DISCONTYPE'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_DisconType
        TabOrder = 1
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object de_Discon: TDBDateEdit
        Left = 88
        Top = 148
        Width = 89
        Height = 21
        DataField = 'DTTM_DISCON'
        DataSource = ds_Main
        DefaultToday = True
        NumGlyphs = 2
        TabOrder = 3
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object de_Con: TDBDateEdit
        Left = 88
        Top = 181
        Width = 89
        Height = 21
        DataField = 'DTTM_CON'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 6
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object gb_Adres: TGroupBox
        Left = 9
        Top = 23
        Width = 544
        Height = 85
        Caption = #1040#1076#1088#1077#1089
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 38
          Height = 13
          Caption = #1059#1083#1080#1094#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 7
          Top = 49
          Width = 44
          Height = 26
          Alignment = taCenter
          Caption = #1053#1086#1084#1077#1088' '#13#10#1076#1086#1084#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 120
          Top = 56
          Width = 43
          Height = 13
          Caption = #1050#1086#1088#1087#1091#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 231
          Top = 57
          Width = 53
          Height = 13
          Caption = #1055#1086#1076#1098#1077#1079#1076
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 352
          Top = 56
          Width = 31
          Height = 13
          Caption = #1069#1090#1072#1078
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 448
          Top = 56
          Width = 20
          Height = 13
          Caption = #1050#1074'.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbl_street_: TRxDBLookupCombo
          Left = 51
          Top = 20
          Width = 326
          Height = 21
          DropDownCount = 8
          DataField = 'FK_DISCON_STREET'
          DataSource = ds_Main
          LookupField = 'ID'
          LookupDisplay = 'NAME'
          LookupSource = ds_Street_
          TabOrder = 0
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
        object dbe_HouseNum: TDBEdit
          Left = 57
          Top = 53
          Width = 57
          Height = 21
          DataField = 'HOUSENUM'
          DataSource = ds_Main
          TabOrder = 1
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
        object dbe_HousingNum: TDBEdit
          Left = 168
          Top = 54
          Width = 57
          Height = 21
          DataField = 'HOUSINGNUM'
          DataSource = ds_Main
          TabOrder = 2
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
        object dbe_PorchNum: TDBEdit
          Left = 287
          Top = 54
          Width = 57
          Height = 21
          DataField = 'PORCHNUM'
          DataSource = ds_Main
          TabOrder = 3
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
        object dbe_FloorNum: TDBEdit
          Left = 384
          Top = 54
          Width = 57
          Height = 21
          DataField = 'FLOORNUM'
          DataSource = ds_Main
          TabOrder = 4
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
        object dbe_ApartmentNum: TDBEdit
          Left = 470
          Top = 54
          Width = 65
          Height = 21
          DataField = 'APARTMENTNUM'
          DataSource = ds_Main
          TabOrder = 5
          OnChange = CtrlsChange
          OnEnter = EntryEnter
          OnExit = EntryExit
          OnKeyDown = FormKeyDown
        end
      end
      object te_Discon: TDBDateTimeEditEh
        Left = 261
        Top = 148
        Width = 73
        Height = 21
        DataField = 'DTTM_DISCON'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 4
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_Con: TDBDateTimeEditEh
        Left = 261
        Top = 181
        Width = 73
        Height = 21
        DataField = 'DTTM_CON'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 7
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_DisconReason: TRxDBLookupCombo
        Left = 296
        Top = 113
        Width = 229
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_DISCONREASON'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_DisconReason
        TabOrder = 2
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_Executor: TRxDBLookupCombo
        Left = 456
        Top = 147
        Width = 129
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_EXECUTOR'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Executor
        TabOrder = 5
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_BrigConnect: TRxDBLookupCombo
        Left = 456
        Top = 180
        Width = 129
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DISCON_BRIG_CONNECT'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_BrigConnect
        TabOrder = 8
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object DBE_Addinfo: TDBEdit
        Left = 88
        Top = 210
        Width = 254
        Height = 21
        DataField = 'ADDITIONALINFO'
        DataSource = ds_Main
        TabOrder = 9
      end
      object de_plan: TDBDateEdit
        Left = 88
        Top = 238
        Width = 82
        Height = 21
        DataField = 'DTTM_PLAN'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 10
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_plan: TDBDateTimeEditEh
        Left = 269
        Top = 238
        Width = 73
        Height = 21
        DataField = 'DTTM_PLAN'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 11
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 430
    Width = 619
  end
  inherited dbg_Main: TDBGrid
    Top = 288
    Width = 602
    Height = 119
    Align = alCustom
    OnDrawColumnCell = dbg_MainDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ADRES'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1040#1076#1088#1077#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 256
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_DISCON'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTTM_CON'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1074#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCONTYPE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DISCONREASON'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EXECUTOR'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' '#1086#1090#1082#1083'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 123
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIG_CONNECT'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090'. '#1079#1072' '#1074#1082#1083'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 127
        Visible = True
      end>
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 462
    Width = 619
  end
  inherited Tr_main: TIBTransaction
    Active = True
    Left = 440
    Top = 232
  end
  inherited Tr_Voc: TIBTransaction
    Left = 136
    Top = 312
  end
  inherited dset_main: TIBDataSet
    AfterDelete = dset_mainAfterDelete
    AfterOpen = dset_mainAfterOpen
    DeleteSQL.Strings = (
      'delete from disconnections where id=:old_id'
      '')
    InsertSQL.Strings = (
      'insert into disconnections('
      '    FK_DISCON_STREET,'
      '    HOUSENUM,'
      '    HOUSINGNUM,'
      '    PORCHNUM,'
      '    FLOORNUM,'
      '    APARTMENTNUM,'
      '    FK_DISCON_ORDER,'
      '    FK_DISCON_DISCONTYPE,'
      '    FK_DISCON_DISCONREASON,'
      '    FK_DISCON_EXECUTOR,'
      '    FK_DISCON_BRIG_CONNECT,'
      '    DTTM_DISCON,'
      '    DTTM_CON,'
      '    DTTM_PLAN,'
      '    ADDITIONALINFO,'
      '   G_KV,'
      '   G_Pod,'
      '   G_ZHD,'
      '   G_STOJ)'
      'values('
      '    :FK_DISCON_STREET,'
      '    :HOUSENUM,'
      '    :HOUSINGNUM,'
      '    :PORCHNUM,'
      '    :FLOORNUM,'
      '    :APARTMENTNUM,'
      '    :FK_DISCON_ORDER,'
      '    :FK_DISCON_DISCONTYPE,'
      '    :FK_DISCON_DISCONREASON,'
      '    :FK_DISCON_EXECUTOR,'
      '    :FK_DISCON_BRIG_CONNECT,'
      '    :DTTM_DISCON,'
      '    :DTTM_CON,'
      '    :DTTM_PLAN,'
      '    :ADDITIONALINFO,'
      '    :G_KV,'
      '    :G_Pod,'
      '    :G_ZHD,'
      '    :G_STOJ)')
    SelectSQL.Strings = (
      'select'
      '    ID,'
      '    FK_DISCON_STREET,'
      '    HOUSENUM,'
      '    HOUSINGNUM,'
      '    PORCHNUM,'
      '    FLOORNUM,'
      '    APARTMENTNUM,'
      '    FK_DISCON_ORDER,'
      '    FK_DISCON_DISCONTYPE,'
      '    DTTM_DISCON,'
      '    DTTM_CON,'
      '    FK_DISCON_DISCONREASON,'
      '    FK_DISCON_EXECUTOR,'
      '    FK_DISCON_BRIG_CONNECT,'
      
        '    (select adres from get_adres2(d.fk_discon_street, d.housenum' +
        ','
      
        '         d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) ' +
        'adres,'
      
        '    (select name from s_discontype where id=d.fk_discon_disconty' +
        'pe) DISCONTYPE,'
      
        '    (select name from s_disconreason where id=d.fk_discon_discon' +
        'reason) DISCONREASON,'
      
        '    (select name from s_executor where id=d.fk_discon_executor) ' +
        'EXECUTOR,'
      
        '    (select name from Brigadiers where id=d.fk_discon_brig_conne' +
        'ct) BRIG_CONNECT,'
      'ADDITIONALINFO,'
      ' DTTM_PLAN,'
      'G_KV,G_Pod, G_ZHD, G_STOJ'
      'from disconnections d'
      'where fk_discon_order=:pOrderID')
    ModifySQL.Strings = (
      'update disconnections set'
      '    FK_DISCON_STREET=:FK_DISCON_STREET,'
      '    HOUSENUM=:HOUSENUM,'
      '    HOUSINGNUM=:HOUSINGNUM,'
      '    PORCHNUM=:PORCHNUM,'
      '    FLOORNUM=:FLOORNUM,'
      '    APARTMENTNUM=:APARTMENTNUM,'
      '    FK_DISCON_DISCONTYPE=:FK_DISCON_DISCONTYPE,'
      '    FK_DISCON_DISCONREASON=:FK_DISCON_DISCONREASON,'
      '    FK_DISCON_EXECUTOR=:FK_DISCON_EXECUTOR,'
      '    FK_DISCON_BRIG_CONNECT=:FK_DISCON_BRIG_CONNECT,'
      '    DTTM_DISCON=:DTTM_DISCON,'
      '    DTTM_CON=:DTTM_CON,'
      '    DTTM_PLAN=:DTTM_PLAN,'
      '    ADDITIONALINFO=:ADDITIONALINFO,'
      '    G_KV=:G_KV,'
      '    G_Pod=:G_POD,'
      '    G_ZHD=:G_ZHD,'
      '    G_STOJ=:G_STOJ'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DISCONNECTIONS_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 472
    Top = 232
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DISCONNECTIONS"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_mainFK_DISCON_STREET: TIntegerField
      FieldName = 'FK_DISCON_STREET'
      Origin = '"DISCONNECTIONS"."FK_DISCON_STREET"'
    end
    object dset_mainHOUSENUM: TIBStringField
      FieldName = 'HOUSENUM'
      Origin = '"DISCONNECTIONS"."HOUSENUM"'
      Size = 10
    end
    object dset_mainHOUSINGNUM: TIBStringField
      FieldName = 'HOUSINGNUM'
      Origin = '"DISCONNECTIONS"."HOUSINGNUM"'
      Size = 10
    end
    object dset_mainPORCHNUM: TIBStringField
      FieldName = 'PORCHNUM'
      Origin = '"DISCONNECTIONS"."PORCHNUM"'
      Size = 10
    end
    object dset_mainFLOORNUM: TIBStringField
      FieldName = 'FLOORNUM'
      Origin = '"DISCONNECTIONS"."FLOORNUM"'
      Size = 10
    end
    object dset_mainAPARTMENTNUM: TIBStringField
      FieldName = 'APARTMENTNUM'
      Origin = '"DISCONNECTIONS"."APARTMENTNUM"'
      Size = 10
    end
    object dset_mainFK_DISCON_ORDER: TIntegerField
      FieldName = 'FK_DISCON_ORDER'
      Origin = '"DISCONNECTIONS"."FK_DISCON_ORDER"'
    end
    object dset_mainFK_DISCON_DISCONTYPE: TIntegerField
      FieldName = 'FK_DISCON_DISCONTYPE'
      Origin = '"DISCONNECTIONS"."FK_DISCON_DISCONTYPE"'
    end
    object dset_mainDTTM_DISCON: TDateTimeField
      FieldName = 'DTTM_DISCON'
      Origin = '"DISCONNECTIONS"."DTTM_DISCON"'
    end
    object dset_mainDTTM_CON: TDateTimeField
      FieldName = 'DTTM_CON'
      Origin = '"DISCONNECTIONS"."DTTM_CON"'
    end
    object dset_mainADRES: TIBStringField
      FieldName = 'ADRES'
      ProviderFlags = []
      FixedChar = True
      Size = 180
    end
    object dset_mainDISCONTYPE: TIBStringField
      FieldName = 'DISCONTYPE'
      ProviderFlags = []
      Size = 30
    end
    object dset_mainFK_DISCON_DISCONREASON: TIntegerField
      FieldName = 'FK_DISCON_DISCONREASON'
      Origin = '"DISCONNECTIONS"."FK_DISCON_DISCONREASON"'
    end
    object dset_mainFK_DISCON_EXECUTOR: TIntegerField
      FieldName = 'FK_DISCON_EXECUTOR'
      Origin = '"DISCONNECTIONS"."FK_DISCON_EXECUTOR"'
    end
    object dset_mainDISCONREASON: TIBStringField
      FieldName = 'DISCONREASON'
      ProviderFlags = []
      Size = 30
    end
    object dset_mainEXECUTOR: TIBStringField
      FieldName = 'EXECUTOR'
      ProviderFlags = []
      Size = 10
    end
    object dset_mainFK_DISCON_BRIG_CONNECT: TIntegerField
      FieldName = 'FK_DISCON_BRIG_CONNECT'
      Origin = '"DISCONNECTIONS"."FK_DISCON_BRIG_CONNECT"'
    end
    object dset_mainBRIG_CONNECT: TIBStringField
      FieldName = 'BRIG_CONNECT'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainADDITIONALINFO: TStringField
      FieldName = 'ADDITIONALINFO'
      Size = 60
    end
    object dset_mainDTTM_PLAN: TDateTimeField
      FieldName = 'DTTM_PLAN'
      Origin = '"DISCONNECTIONS"."DTTM_PLAN"'
    end
    object dset_mainG_KV: TIntegerField
      FieldName = 'G_KV'
      Origin = '"DISCONNECTIONS"."G_KV"'
    end
    object dset_mainG_POD: TIntegerField
      FieldName = 'G_POD'
      Origin = '"DISCONNECTIONS"."G_POD"'
    end
    object dset_mainG_ZHD: TIntegerField
      FieldName = 'G_ZHD'
      Origin = '"DISCONNECTIONS"."G_ZHD"'
    end
    object dset_mainG_STOJ: TIntegerField
      FieldName = 'G_STOJ'
      Origin = '"DISCONNECTIONS"."G_STOJ"'
    end
  end
  inherited ds_Main: TDataSource
    Left = 504
    Top = 232
  end
  object dset_DisconType: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from s_DisconType'
      'where name is not null'
      'or id=-1'
      'order by name ')
    OnFilterRecord = VocFilterRecord
    Left = 368
    Top = 264
  end
  object dset_street_: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select s.id,'
      '(select name from Get_FullStreetName(s.id)) as name,'
      's.activity'
      'from s_streets s'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 320
    Top = 264
  end
  object ds_Street_: TDataSource
    DataSet = dset_street_
    Left = 320
    Top = 296
  end
  object ds_DisconType: TDataSource
    DataSet = dset_DisconType
    Left = 368
    Top = 296
  end
  object dset_DisconReason: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_disconreason'
      'where name is not null'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 424
    Top = 264
  end
  object dset_Executor: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from s_executor'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 480
    Top = 264
  end
  object ds_DisconReason: TDataSource
    DataSet = dset_DisconReason
    Left = 424
    Top = 296
  end
  object ds_Executor: TDataSource
    DataSet = dset_Executor
    Left = 480
    Top = 296
  end
  object dset_BrigConnect: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity'
      'from brigadiers'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 536
    Top = 264
  end
  object ds_BrigConnect: TDataSource
    DataSet = dset_BrigConnect
    Left = 536
    Top = 296
  end
end
