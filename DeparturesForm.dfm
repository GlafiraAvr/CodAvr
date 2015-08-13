inherited frm_Departures: Tfrm_Departures
  Left = 321
  Top = 212
  Width = 583
  Height = 405
  Caption = 'frm_Departures'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Top: TPanel
    Width = 575
    Height = 186
    object TabC: TTabControl
      Left = 1
      Top = 1
      Width = 573
      Height = 184
      Align = alClient
      TabOrder = 0
      OnChange = TabCChange
      OnChanging = TabCChanging
      object DBT_OffOpen: TDBText
        Left = 320
        Top = 33
        Width = 89
        Height = 17
        DataField = 'OFFOPEN'
        DataSource = ds_Main
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBT_OffClose: TDBText
        Left = 320
        Top = 57
        Width = 89
        Height = 17
        DataField = 'OFFCLOSE'
        DataSource = ds_Main
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 32
        Width = 82
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 13
        Top = 58
        Width = 75
        Height = 13
        Caption = #1050#1086#1085#1077#1094' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 286
        Top = 34
        Width = 33
        Height = 13
        Caption = #1076#1080#1089#1087'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 285
        Top = 58
        Width = 33
        Height = 13
        Caption = #1076#1080#1089#1087'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 9
        Top = 89
        Width = 115
        Height = 26
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081' '#1079#1072' '#13#10#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 288
        Top = 88
        Width = 49
        Height = 26
        Alignment = taCenter
        Caption = #1050#1086#1083'-'#1074#1086#13#10#1095#1077#1083#1086#1074#1077#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 6
        Top = 144
        Width = 101
        Height = 26
        Alignment = taCenter
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103#13#10#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object de_Start: TDBDateEdit
        Left = 93
        Top = 30
        Width = 92
        Height = 21
        DataField = 'STARTDATE'
        DataSource = ds_Main
        DefaultToday = True
        NumGlyphs = 2
        TabOrder = 0
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object de_End: TDBDateEdit
        Left = 92
        Top = 57
        Width = 93
        Height = 21
        DataField = 'ENDDATE'
        DataSource = ds_Main
        NumGlyphs = 2
        TabOrder = 2
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object dbl_Brig: TRxDBLookupCombo
        Left = 128
        Top = 93
        Width = 145
        Height = 21
        DropDownCount = 8
        DataField = 'FK_DEPARTURES_BRIGADIERS'
        DataSource = ds_Main
        LookupField = 'ID'
        LookupDisplay = 'NAME'
        LookupSource = ds_Brig
        TabOrder = 4
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_Start: TDBDateTimeEditEh
        Left = 208
        Top = 32
        Width = 73
        Height = 21
        DataField = 'STARTDATE'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 1
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object te_End: TDBDateTimeEditEh
        Left = 208
        Top = 56
        Width = 73
        Height = 21
        DataField = 'ENDDATE'
        DataSource = ds_Main
        EditButton.Style = ebsUpDownEh
        Kind = dtkTimeEh
        TabOrder = 3
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object mem_AddInfo: TDBMemo
        Left = 112
        Top = 126
        Width = 455
        Height = 51
        DataField = 'ADDITIONALINFO'
        DataSource = ds_Main
        ScrollBars = ssVertical
        TabOrder = 6
        WantReturns = False
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object ed_WorkersCount: TDBEdit
        Left = 341
        Top = 91
        Width = 57
        Height = 21
        DataField = 'WORKERSCOUNT'
        DataSource = ds_Main
        TabOrder = 5
        OnChange = CtrlsChange
        OnEnter = EntryEnter
        OnExit = EntryExit
        OnKeyDown = FormKeyDown
      end
      object btn_WorkAndMater: TBitBtn
        Left = 427
        Top = 61
        Width = 142
        Height = 24
        Caption = #1056#1072#1073#1086#1090#1099'/'#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        TabStop = False
        OnClick = btn_WorkAndMaterClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
          1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
          1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
          193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
          11155557F755F777777555000755033305555577755F75F77F55555555503335
          0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
          05555757F75F75557F5505000333555505557F777FF755557F55000000355557
          07557777777F55557F5555000005555707555577777FF5557F55553000075557
          0755557F7777FFF5755555335000005555555577577777555555}
        NumGlyphs = 2
      end
      object btn_Workers: TBitBtn
        Left = 427
        Top = 90
        Width = 142
        Height = 22
        Caption = #1051#1102#1076#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        TabStop = False
        OnClick = btn_WorkersClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050FF00055555
          555558070F00555555550800FFF8055555550880000F800555555007FFF08800
          055555500FF800BBB0055555500BBBBBBBB05555500000000BB855500BBBBBBB
          B000550BB000000B000F50B00BBBBB0B0B50500BBBBBBB0B0B55550BBBBBB0B0
          B0555550BBBB0B0B055555550000B00055555555550000555555}
      end
    end
  end
  inherited pnl_Bottom: TPanel
    Top = 320
    Width = 575
  end
  inherited dbg_Main: TDBGrid
    Top = 186
    Width = 575
    Height = 134
    OnDrawColumnCell = dbg_MainDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'STARTDATE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OFFOPEN'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1080#1089#1087'. '#1086#1090#1082#1088'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDDATE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1085#1077#1094' '#1088#1072#1073#1086#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OFFCLOSE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1044#1080#1089#1087'. '#1079#1072#1082#1088'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BRIG'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1074#1077#1090'. '#1079#1072' '#1087#1088#1086#1074#1077#1076'. '#1088#1072#1073#1086#1090
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 198
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WORKERSCOUNT'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1095#1077#1083#1086#1074#1077#1082
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  inherited sb_ProcessStatus: TStatusBar
    Top = 352
    Width = 575
  end
  inherited Tr_main: TIBTransaction
    Top = 280
  end
  inherited Tr_Voc: TIBTransaction
    Left = 328
    Top = 280
  end
  inherited dset_main: TIBDataSet
    AfterDelete = dset_mainAfterDelete
    AfterOpen = dset_mainAfterOpen
    BeforeDelete = dset_mainBeforeDelete
    DeleteSQL.Strings = (
      'delete from departures where id=:old_id')
    InsertSQL.Strings = (
      
        'insert into Departures(fk_departures_orders, StartDate, EndDate,' +
        ' '
      'fk_departures_brigadiers, fk_departures_OfficialsOpen, '
      'fk_departures_OfficialsClose, AdditionalInfo, WorkersCount)'
      'values(:fk_departures_orders, :StartDate, :EndDate, '
      ':fk_departures_brigadiers, :fk_departures_OfficialsOpen, '
      ':fk_departures_OfficialsClose, :AdditionalInfo, :WorkersCount)'
      '')
    SelectSQL.Strings = (
      'select id, StartDate, EndDate,'
      'fk_departures_Brigadiers,'
      'fk_departures_OfficialsOpen, fk_departures_OfficialsClose,'
      'AdditionalInfo, fk_Departures_Orders, WorkersCount,'
      
        '(select name from s_officials where id=d.fk_departures_officials' +
        'open) OffOpen,'
      
        '(select name from s_officials where id=d.fk_departures_officials' +
        'close) OffClose,'
      
        '(select name from brigadiers where id=d.fk_departures_brigadiers' +
        ') BRIG'
      'from Departures d'
      'where fk_departures_orders=:pOrderID'
      'order by StartDate')
    ModifySQL.Strings = (
      'update Departures set'
      'StartDate=:StartDate,'
      'EndDate=:EndDate,'
      'fk_departures_Brigadiers=:fk_departures_Brigadiers,'
      'fk_departures_OfficialsOpen=:fk_departures_OfficialsOpen,'
      'fk_departures_OfficialsClose=:fk_departures_OfficialsClose,'
      'AdditionalInfo=:AdditionalInfo,'
      'WorkersCount=:WorkersCount'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_DEPARTURES'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 96
    Top = 280
    object dset_mainID: TIntegerField
      FieldName = 'ID'
      Origin = '"DEPARTURES"."ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object dset_mainSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
      Origin = '"DEPARTURES"."STARTDATE"'
    end
    object dset_mainENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
      Origin = '"DEPARTURES"."ENDDATE"'
    end
    object dset_mainFK_DEPARTURES_BRIGADIERS: TIntegerField
      FieldName = 'FK_DEPARTURES_BRIGADIERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_BRIGADIERS"'
    end
    object dset_mainFK_DEPARTURES_OFFICIALSOPEN: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSOPEN'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSOPEN"'
    end
    object dset_mainFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField
      FieldName = 'FK_DEPARTURES_OFFICIALSCLOSE'
      Origin = '"DEPARTURES"."FK_DEPARTURES_OFFICIALSCLOSE"'
    end
    object dset_mainADDITIONALINFO: TIBStringField
      FieldName = 'ADDITIONALINFO'
      Origin = '"DEPARTURES"."ADDITIONALINFO"'
      Size = 800
    end
    object dset_mainFK_DEPARTURES_ORDERS: TIntegerField
      FieldName = 'FK_DEPARTURES_ORDERS'
      Origin = '"DEPARTURES"."FK_DEPARTURES_ORDERS"'
    end
    object dset_mainOFFOPEN: TIBStringField
      FieldName = 'OFFOPEN'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainOFFCLOSE: TIBStringField
      FieldName = 'OFFCLOSE'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
    object dset_mainWORKERSCOUNT: TIntegerField
      FieldName = 'WORKERSCOUNT'
      Origin = '"DEPARTURES"."WORKERSCOUNT"'
    end
    object dset_mainBRIG: TIBStringField
      FieldName = 'BRIG'
      ProviderFlags = []
      FixedChar = True
      Size = 64
    end
  end
  inherited ds_Main: TDataSource
    Left = 144
    Top = 280
  end
  object dset_Brig: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_Voc
    SelectSQL.Strings = (
      'select ID, NAME, ACTIVITY '
      'from BRIGADIERS'
      'where ID>0 and  ACTIVITY  is NULL'
      'order by NAME')
    OnFilterRecord = VocFilterRecord
    Left = 416
    Top = 296
  end
  object ds_Brig: TDataSource
    DataSet = dset_Brig
    Left = 384
    Top = 296
  end
  object dset_tmp: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = Tr_main
    Left = 280
    Top = 224
  end
  object IBSQL: TIBSQL
    Database = DM_Main.IBDatabase
    Transaction = Tr_main
    Left = 240
    Top = 272
  end
end
