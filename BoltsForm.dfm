inherited frm_Bolts: Tfrm_Bolts
  Left = 332
  Top = 159
  Width = 637
  Height = 461
  Caption = #1047#1072#1076#1074#1080#1078#1082#1080
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 629
    Height = 167
    Font.Style = [fsBold]
    ParentFont = False
    object Label1: TLabel [0]
      Left = 6
      Top = 107
      Width = 83
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103#13#10#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel [1]
      Left = 275
      Top = 107
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel [2]
      Left = 11
      Top = 87
      Width = 54
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel [3]
      Left = 6
      Top = 138
      Width = 83
      Height = 26
      Alignment = taCenter
      Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103#13#10#1086#1090#1082#1088#1099#1090#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [4]
      Left = 277
      Top = 136
      Width = 97
      Height = 26
      Alignment = taCenter
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#13#10#1079#1072' '#1086#1090#1082#1088#1099#1090#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [5]
      Left = 169
      Top = 86
      Width = 38
      Height = 13
      Caption = #1052#1077#1089#1090#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnl_Adres: TGroupBox
      Left = 4
      Top = 4
      Width = 837
      inherited lbl_HouseType: TLabel
        Left = 661
        Top = 48
        Visible = False
      end
      inherited lbl_Street: TLabel
        Top = 18
      end
      inherited lbl_AddAdres: TLabel
        Left = 9
        Top = 49
      end
      inherited lbl_HouseNum: TLabel
        Left = 383
        Top = 13
        Width = 40
        Height = 26
        Alignment = taCenter
        Caption = #1053#1086#1084#1077#1088#13#10#1076#1086#1084#1072
      end
      inherited lbl_Street2: TLabel
        Left = 369
        Top = 21
      end
      inherited dbl_HouseType: TRxDBLookupCombo
        Left = 248
        Width = 113
        DataField = 'FK_CLOSEDBOLTS_HOUSETYPE'
        OnKeyDown = FormKeyDown
      end
      inherited dbl_Street: TRxDBLookupCombo
        Top = 16
        Width = 193
        DataField = 'FK_CLOSEDBOLTS_STREETS'
        OnKeyDown = FormKeyDown
      end
      inherited dbl_Street2: TRxDBLookupCombo
        Left = 426
        Top = 16
        Width = 191
        OnKeyDown = FormKeyDown
      end
      inherited ed_AddAdres: TDBEdit
        Left = 81
        Top = 46
        Width = 320
        DataField = 'ADDITIONALADDRESS'
        OnKeyDown = FormKeyDown
      end
      inherited ed_HouseNum: TDBEdit
        Left = 426
        Top = 16
        Width = 71
        DataField = 'HOUSENUM'
        OnKeyDown = FormKeyDown
      end
    end
    object dbl_BrigClose: TRxDBLookupCombo
      Left = 376
      Top = 109
      Width = 151
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_BrigClose
      TabOrder = 5
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_Close: TDBDateEdit
      Left = 92
      Top = 110
      Width = 102
      Height = 21
      DataField = 'CLOSEDATE'
      DataSource = ds_Main
      NumGlyphs = 2
      TabOrder = 3
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object tp_Close: TDBDateTimeEditEh
      Left = 196
      Top = 110
      Width = 70
      Height = 21
      DataField = 'CLOSEDATE'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Kind = dtkTimeEh
      TabOrder = 4
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_Diameter: TRxDBLookupCombo
      Left = 68
      Top = 84
      Width = 77
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_TUBEDIAM'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_diameter
      TabOrder = 1
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dp_Open: TDBDateEdit
      Left = 92
      Top = 139
      Width = 103
      Height = 21
      DataField = 'OPENDATE'
      DataSource = ds_Main
      NumGlyphs = 2
      TabOrder = 6
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object dbl_BrigOpen: TRxDBLookupCombo
      Left = 376
      Top = 137
      Width = 150
      Height = 21
      DropDownCount = 8
      DataField = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      DataSource = ds_Main
      LookupField = 'ID'
      LookupDisplay = 'NAME'
      LookupSource = ds_BrigOpen
      TabOrder = 8
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object ed_ClosePlace: TDBEdit
      Left = 209
      Top = 84
      Width = 225
      Height = 21
      DataField = 'CLOSEPLACE'
      DataSource = ds_Main
      TabOrder = 2
      OnChange = CtrlsChange
      OnEnter = TextFieldEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
    object tp_Open: TDBDateTimeEditEh
      Left = 197
      Top = 139
      Width = 70
      Height = 21
      DataField = 'OPENDATE'
      DataSource = ds_Main
      EditButton.Style = ebsUpDownEh
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = dtkTimeEh
      ParentFont = False
      TabOrder = 7
      OnChange = CtrlsChange
      OnEnter = EntryEnter
      OnExit = EntryExit
      OnKeyDown = FormKeyDown
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 383
    Width = 629
    inherited btn_Insert: TBitBtn
      Width = 95
      Caption = #1055#1077#1088#1077#1082#1088#1099#1090#1100
      TabOrder = 1
    end
    inherited btn_Delete: TBitBtn
      Left = 181
      TabOrder = 3
    end
    inherited btn_Edit: TBitBtn
      Left = 101
      Caption = #1054#1090#1082#1088#1099#1090#1100
    end
    inherited btn_Post: TBitBtn
      TabOrder = 0
    end
  end
  inherited dbg_Main: TDBGrid
    Top = 167
    Width = 629
    Height = 216
    OnDrawColumnCell = dbg_MainDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'ADRES'
        Title.Alignment = taCenter
        Title.Caption = #1040#1076#1088#1077#1089
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 257
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLOSEPLACE'
        Title.Alignment = taCenter
        Title.Caption = #1052#1077#1089#1090#1086
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TUBEDIAM'
        Title.Alignment = taCenter
        Title.Caption = #1044#1080#1072#1084#1077#1090#1088
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLOSEDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIGCLOSE'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPENDATE'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1090#1082#1088#1099#1090#1080#1103
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIGOPEN'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#1086#1090#1082#1088#1099#1090#1080#1077
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 415
    Width = 629
  end
  inherited Tr_main: TIBTransaction
    Left = 80
    Top = 264
  end
  inherited Tr_Voc: TIBTransaction
    Left = 184
    Top = 184
  end
  inherited dset_HouseType: TIBDataSet
    Left = 184
    Top = 224
  end
  inherited dset_Street: TIBDataSet
    Left = 216
    Top = 224
  end
  inherited dset_Street2: TIBDataSet
    Left = 248
    Top = 224
  end
  inherited dset_main: TIBDataSet
    DeleteSQL.Strings = (
      'delete from ClosedBolts'
      'where id=:old_id'
      '')
    InsertSQL.Strings = (
      'insert into closedbolts(fk_closedbolts_orders,'
      'closedate, fk_closedbolts_brigadiersclose, opendate,'
      
        'fk_closedbolts_brigadieropen, fk_closedbolts_tubediam, fk_closed' +
        'bolts_housetype,'
      'fk_closedbolts_streets, housenum,additionaladdress,closeplace)'
      'values (:fk_closedbolts_orders,'
      ':closedate, :fk_closedbolts_brigadiersclose, :opendate,'
      
        ':fk_closedbolts_brigadieropen, :fk_closedbolts_tubediam, :fk_clo' +
        'sedbolts_housetype,'
      
        ':fk_closedbolts_streets, :housenum,:additionaladdress,:closeplac' +
        'e)'
      '')
    SelectSQL.Strings = (
      
        'select b.id, b.fk_closedbolts_orders,b.closedate, b.fk_closedbol' +
        'ts_brigadiersclose, b.opendate,'
      
        'b.fk_closedbolts_brigadieropen, b.fk_closedbolts_tubediam, b.fk_' +
        'closedbolts_housetype,'
      
        'b.fk_closedbolts_streets, b.housenum, b.additionaladdress, Close' +
        'Place,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'sclose) BrigClose,'
      
        '(select name from brigadiers where id=b.fk_closedbolts_brigadier' +
        'open) BrigOpen,'
      
        '(select diameter from s_tubediameter where id=b.fk_closedbolts_t' +
        'ubediam) TubeDiam,'
      '(select adres from'
      
        'get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_streets, ' +
        'b.housenum, b.additionaladdress)) as Adres'
      'from closedbolts b'
      'where b.fk_closedbolts_orders=:pOrderID')
    ModifySQL.Strings = (
      'update ClosedBolts set'
      'closedate=:closedate,'
      'fk_closedbolts_brigadiersclose=:fk_closedbolts_brigadiersclose,'
      'opendate=:opendate,'
      'fk_closedbolts_brigadieropen=:fk_closedbolts_brigadieropen,'
      'fk_closedbolts_tubediam=:fk_closedbolts_tubediam,'
      'fk_closedbolts_housetype=:fk_closedbolts_housetype,'
      'fk_closedbolts_streets=:fk_closedbolts_streets,'
      'housenum=:housenum,'
      'additionaladdress=:additionaladdress,'
      'closeplace=:closeplace'
      'where id=:id'
      '')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_CLOSEDBOLTS'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 80
    Top = 200
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = 'CLOSEDBOLTS.ID'
      Required = True
    end
    object dset_mainFK_CLOSEDBOLTS_ORDERS: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_ORDERS'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_ORDERS'
    end
    object dset_mainCLOSEDATE: TDateTimeField
      FieldName = 'CLOSEDATE'
      Origin = 'CLOSEDBOLTS.CLOSEDATE'
    end
    object dset_mainFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_BRIGADIERSCLOSE'
    end
    object dset_mainOPENDATE: TDateTimeField
      FieldName = 'OPENDATE'
      Origin = 'CLOSEDBOLTS.OPENDATE'
    end
    object dset_mainFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_BRIGADIEROPEN'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_BRIGADIEROPEN'
    end
    object dset_mainFK_CLOSEDBOLTS_TUBEDIAM: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_TUBEDIAM'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_TUBEDIAM'
    end
    object dset_mainFK_CLOSEDBOLTS_HOUSETYPE: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_HOUSETYPE'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_HOUSETYPE'
    end
    object dset_mainFK_CLOSEDBOLTS_STREETS: TIntegerField
      FieldName = 'FK_CLOSEDBOLTS_STREETS'
      Origin = 'CLOSEDBOLTS.FK_CLOSEDBOLTS_STREETS'
    end
    object dset_mainHOUSENUM: TIBStringField
      FieldName = 'HOUSENUM'
      Origin = 'CLOSEDBOLTS.HOUSENUM'
      FixedChar = True
    end
    object dset_mainADDITIONALADDRESS: TIBStringField
      FieldName = 'ADDITIONALADDRESS'
      Origin = 'CLOSEDBOLTS.ADDITIONALADDRESS'
      FixedChar = True
      Size = 32
    end
    object dset_mainADRES: TIBStringField
      FieldName = 'ADRES'
      FixedChar = True
      Size = 190
    end
    object dset_mainCLOSEPLACE: TIBStringField
      FieldName = 'CLOSEPLACE'
      Origin = '"CLOSEDBOLTS"."CLOSEPLACE"'
      FixedChar = True
      Size = 22
    end
    object dset_mainBRIGCLOSE: TIBStringField
      FieldName = 'BRIGCLOSE'
      ProviderFlags = []
      OnGetText = dset_mainBRIGCLOSEGetText
      FixedChar = True
      Size = 64
    end
    object dset_mainBRIGOPEN: TIBStringField
      FieldName = 'BRIGOPEN'
      ProviderFlags = []
      OnGetText = dset_mainBRIGOPENGetText
      FixedChar = True
      Size = 64
    end
    object dset_mainTUBEDIAM: TIntegerField
      FieldName = 'TUBEDIAM'
      ProviderFlags = []
    end
  end
  inherited ds_HouseType: TDataSource
    Left = 184
    Top = 248
  end
  inherited ds_Street: TDataSource
    Left = 216
    Top = 248
  end
  inherited ds_Street2: TDataSource
    Left = 248
    Top = 248
  end
  inherited ds_Main: TDataSource
    Left = 80
    Top = 232
  end
  object dset_BrigClose: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from brigadiers'
      'where id>0'
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 336
    Top = 224
  end
  object dset_BrigOpen: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select id, name, activity '
      'from brigadiers'
      'where id>0 '
      'order by name')
    OnFilterRecord = VocFilterRecord
    Left = 368
    Top = 224
  end
  object dset_Diameter: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      
        'select sd.id, (select strval from tochar(sd.diameter)) as name, ' +
        'sd.activity'
      'from s_tubediameter sd'
      'order by sd.diameter')
    OnFilterRecord = VocFilterRecord
    Left = 400
    Top = 224
  end
  object ds_BrigClose: TDataSource
    DataSet = dset_BrigClose
    Left = 336
    Top = 248
  end
  object ds_BrigOpen: TDataSource
    DataSet = dset_BrigOpen
    Left = 368
    Top = 248
  end
  object ds_diameter: TDataSource
    DataSet = dset_Diameter
    Left = 400
    Top = 248
  end
end
