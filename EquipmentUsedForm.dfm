inherited frm_EquipmentUsed: Tfrm_EquipmentUsed
  Top = 281
  Width = 570
  Height = 302
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1086' '#1076#1083#1103' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Left = -3
    Top = 192
    Width = 425
    Height = 50
    Align = alNone
    BevelOuter = bvNone
    object lbl_Info: TLabel [0]
      Left = 9
      Top = 8
      Width = 361
      Height = 26
      Caption = 
        #1047#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1085#1086#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1088#1080' '#1073#1083#1072#1075#1086#1091#1089#1090#1088#1086#1081#1089#1090#1074#1077' '#1084#1077#1089#1090' '#13#10#1072#1074#1072#1088#1080#1081#1085#1086 +
        '-'#1074#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1077#1083#1100#1085#1099#1093' '#1088#1072#1073#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Time: TLabel [1]
      Left = 9
      Top = 11
      Width = 39
      Height = 13
      Caption = #1042#1088#1077#1084#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbl_Region: TLabel [2]
      Left = 90
      Top = 11
      Width = 37
      Height = 13
      Caption = #1056#1072#1081#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl_Equipment: TLabel [3]
      Left = 284
      Top = 10
      Width = 61
      Height = 13
      Caption = #1052#1077#1093#1072#1085#1080#1079#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnl_Adres: TGroupBox
      Top = 56
      Visible = False
    end
    object tp_Time: TDBDateTimeEditEh
      Left = 8
      Top = 26
      Width = 73
      Height = 21
      DataField = 'USEDDATE'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Kind = dtkTimeEh
      TabOrder = 1
      Visible = False
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object dbl_Regions: TRxDBLookupCombo
      Left = 88
      Top = 26
      Width = 185
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EQUIPUSED_REGIONS'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Regions
      TabOrder = 2
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
    object dbl_Equipments: TRxDBLookupCombo
      Left = 280
      Top = 25
      Width = 145
      Height = 21
      DropDownCount = 8
      DataField = 'FK_EQUIPUSED_EQUIPMENT'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_Equipments
      TabOrder = 3
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
    end
  end
  inherited pnl_Bottom: TPanel
    Left = 459
    Top = 0
    Width = 95
    Height = 245
    Align = alRight
    BevelOuter = bvNone
    inherited btn_Insert: TBitBtn
      Left = 3
    end
    inherited btn_Delete: TBitBtn
      Left = 3
      Top = 30
    end
    inherited btn_Edit: TBitBtn
      Left = 3
      Top = 57
    end
    inherited btn_Post: TBitBtn
      Left = 3
      Top = 194
    end
    inherited btn_Cancel: TBitBtn
      Left = 3
      Top = 220
    end
    inherited btn_Exit: TBitBtn
      Left = 3
      Top = 167
    end
  end
  inherited dbg_Main: TDBGrid
    Left = -1
    Top = -1
    Width = 422
    Height = 193
    Align = alNone
    Columns = <
      item
        Expanded = False
        FieldName = 'USEDDATE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1042#1088#1077#1084#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'REGION'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1081#1086#1085
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 192
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EQUIP'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1052#1077#1093#1072#1085#1080#1079#1084
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 70
        Visible = True
      end>
  end
  object dp_Time: TDBDateEdit [3]
    Left = 32
    Top = 64
    Width = 121
    Height = 21
    DataField = 'USEDDATE'
    DataSource = ds_Main
    NumGlyphs = 2
    TabOrder = 3
    Visible = False
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 245
    Width = 554
  end
  inherited Tr_main: TIBTransaction
    Left = 56
    Top = 144
  end
  inherited Tr_Voc: TIBTransaction
    Left = 208
    Top = 96
  end
  inherited dset_HouseType: TIBDataSet
    Left = 688
    Top = 152
  end
  inherited dset_Street: TIBDataSet
    Left = 728
    Top = 152
  end
  inherited dset_Street2: TIBDataSet
    Left = 784
    Top = 152
  end
  inherited dset_main: TIBDataSet
    DeleteSQL.Strings = (
      'delete '
      'from equipused'
      'where id=:old_id ')
    InsertSQL.Strings = (
      
        'insert into EquipUsed(useddate, FK_EQUIPUSED_REGIONS, FK_EQUIPUS' +
        'ED_EQUIPMENT)'
      
        'values(:useddate, :FK_EQUIPUSED_REGIONS, :FK_EQUIPUSED_EQUIPMENT' +
        ')')
    SelectSQL.Strings = (
      'select eu.id, eu.useddate,'
      'eu.FK_EQUIPUSED_REGIONS, eu.FK_EQUIPUSED_EQUIPMENT,'
      
        '(select name from s_regions where id=eu.fk_equipused_regions) RE' +
        'GION,'
      '(select (select strval from tocharuns(eq.number))'
      '    from equipment eq where id=eu.fk_equipused_equipment) Equip'
      'from equipused eu'
      'where useddate >=:pDate1  and useddate<:pDate2'
      'order by useddate')
    ModifySQL.Strings = (
      'update equipused set'
      'useddate=:useddate,'
      'FK_EQUIPUSED_REGIONS=:FK_EQUIPUSED_REGIONS,'
      'FK_EQUIPUSED_EQUIPMENT=:FK_EQUIPUSED_EQUIPMENT'
      'where ID=:ID')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_EQUIPUSED'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 56
    Top = 104
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = 'EQUIPUSED.ID'
      Required = True
    end
    object dset_mainUSEDDATE: TDateTimeField
      FieldName = 'USEDDATE'
      Origin = 'EQUIPUSED.USEDDATE'
      DisplayFormat = 'hh:mm:ss'
    end
    object dset_mainFK_EQUIPUSED_REGIONS: TIntegerField
      FieldName = 'FK_EQUIPUSED_REGIONS'
      Origin = 'EQUIPUSED.FK_EQUIPUSED_REGIONS'
    end
    object dset_mainFK_EQUIPUSED_EQUIPMENT: TIntegerField
      FieldName = 'FK_EQUIPUSED_EQUIPMENT'
      Origin = 'EQUIPUSED.FK_EQUIPUSED_EQUIPMENT'
    end
    object dset_mainREGION: TIBStringField
      FieldName = 'REGION'
      ProviderFlags = []
      FixedChar = True
      Size = 32
    end
    object dset_mainEQUIP: TIBStringField
      FieldName = 'EQUIP'
      ProviderFlags = []
      FixedChar = True
      Size = 10
    end
  end
  inherited ds_HouseType: TDataSource
    Left = 688
    Top = 176
  end
  inherited ds_Street: TDataSource
    Left = 728
    Top = 176
  end
  inherited ds_Street2: TDataSource
    Left = 784
    Top = 176
  end
  inherited ds_Main: TDataSource
    Left = 88
    Top = 104
  end
  object dset_Regions: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from s_regions '
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 256
    Top = 96
  end
  object dset_Equipments: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      
        'select e.id, (select full_name from get_equip_full_name(e.id)) a' +
        's name, e.activity'
      'from equipment e'
      ''
      'inner join db_consts const on ( 1 = 1 )'
      
        'inner join db_districtvoc dv on ( dv.id_district = const.id_dist' +
        'rict )'
      '    and (dv.id_region = e.id_region)'
      '    and (dv.id_vocrectype = e.id_vocrectype )'
      ''
      'where e.activity is null'
      'order by number'
      '')
    OnFilterRecord = VocFilterRecord
    Left = 312
    Top = 96
  end
  object ds_Regions: TDataSource
    DataSet = dset_Regions
    Left = 256
    Top = 136
  end
  object ds_Equipments: TDataSource
    DataSet = dset_Equipments
    Left = 312
    Top = 136
  end
end
