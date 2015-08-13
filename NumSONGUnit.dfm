object NumSONGForm: TNumSONGForm
  Left = 316
  Top = 186
  Width = 623
  Height = 437
  Caption = 'NumSONGForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 223
    Width = 615
    Height = 185
    Align = alBottom
    TabOrder = 0
    object L_Isp1562: TLabel
      Left = 12
      Top = 6
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
      Left = 19
      Top = 80
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
    object BtOK: TButton
      Left = 528
      Top = 136
      Width = 75
      Height = 25
      Caption = 'BtOK'
      TabOrder = 0
    end
    object DBL_Officials1562: TRxDBLookupCombo
      Tag = 3
      Left = 99
      Top = 7
      Width = 318
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
    end
    object mem_officials: TMemo
      Tag = 4
      Left = 99
      Top = 33
      Width = 313
      Height = 37
      TabOrder = 2
    end
    object DBL_Job1562: TRxDBLookupCombo
      Tag = 5
      Left = 99
      Top = 79
      Width = 318
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
      TabOrder = 3
    end
    object mem_job: TMemo
      Tag = 6
      Left = 99
      Top = 111
      Width = 317
      Height = 39
      TabOrder = 4
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 223
    Align = alClient
    TabOrder = 1
    inline Spisok1562_Frame1: TSpisok1562_Frame
      Left = 1
      Top = 1
      Width = 613
      Height = 221
      Align = alClient
      TabOrder = 0
      inherited p_MainPanel: TPanel
        Width = 613
        Height = 187
        inherited Grid: TRxDBGrid
          Width = 611
          Height = 185
          DataSource = ds_Main
        end
      end
      inherited p_BottomPanel: TPanel
        Top = 187
        Width = 613
        Visible = False
      end
    end
  end
  object ds_Main: TDataSource
    DataSet = dm_NumSONG.ResultDset
    Left = 320
    Top = 112
  end
  object dset_Officials1562: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = dm_OrderNG1562.tran1562
    SelectSQL.Strings = (
      'select id, id1562,name, id_region'
      'from s_Officials1562'
      'where id_base = 1'
      'order by name ')
    Left = 381
    Top = 222
  end
  object ds_Officials1562: TDataSource
    DataSet = dset_Officials1562
    Left = 413
    Top = 222
  end
  object dset_Job1562: TIBDataSet
    Database = DM_Main.IBDatabase1562
    Transaction = dm_OrderNG1562.tran1562
    SelectSQL.Strings = (
      'select id, name, id_job1562'
      'from s_job1562'
      'order by name ')
    Left = 384
    Top = 312
  end
  object ds_Job1562: TDataSource
    DataSet = dset_Job1562
    Left = 416
    Top = 312
  end
end
