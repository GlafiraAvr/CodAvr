inherited frm_OptPlanDep: Tfrm_OptPlanDep
  Caption = 'frm_OptPlanDep'
  ClientHeight = 156
  ClientWidth = 324
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited dp_Date: TDateEdit
    OnChange = dp_DateChange
  end
  inherited btn_Ok: TBitBtn
    Top = 128
  end
  inherited btn_Exit: TBitBtn
    Left = 200
    Top = 128
  end
  object pnl_opt: TPanel
    Left = 0
    Top = 48
    Width = 321
    Height = 65
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 8
      Width = 80
      Height = 13
      Caption = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 176
      Top = 8
      Width = 69
      Height = 13
      Caption = #1057#1072#1084#1086#1089#1074#1072#1083#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 32
      Width = 90
      Height = 26
      Caption = #1054#1090#1082#1072#1095#1080#1074#1072#1102#1097#1080#1077#13#10#1084#1077#1093#1072#1085#1080#1079#1084#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sp_excav: TSpinEdit
      Left = 104
      Top = 0
      Width = 60
      Height = 22
      MaxValue = 200
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object sp_Tripper: TSpinEdit
      Left = 248
      Top = 3
      Width = 60
      Height = 22
      MaxValue = 200
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object sp_pumping: TSpinEdit
      Left = 104
      Top = 35
      Width = 60
      Height = 22
      MaxValue = 200
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
  end
  object ds_main: TDataSource
    DataSet = dset
    Left = 232
    Top = 16
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        ' select sp1.saveddate, sp1.val excav, sp2.val tipper, sp3.val pu' +
        'mping'
      
        ' from Svod_plan_Equip sp1 join Svod_plan_Equip sp2 on sp1.savedd' +
        'ate=sp2.saveddate  and sp2.field='#39'Tripper'#39
      
        'join   Svod_plan_Equip sp3 on sp1.saveddate=sp3.saveddate  and s' +
        'p3.field='#39'Pumping'#39
      'where sp1.field='#39'Excav'#39
      'order by 1')
    Left = 200
    Top = 16
    object dsetSAVEDDATE: TDateField
      FieldName = 'SAVEDDATE'
      Origin = '"SVOD_PLAN_EQUIP"."SAVEDDATE"'
      Required = True
    end
    object dsetEXCAV: TIntegerField
      FieldName = 'EXCAV'
      Origin = '"SVOD_PLAN_EQUIP"."VAL"'
    end
    object dsetTIPPER: TIntegerField
      FieldName = 'TIPPER'
      Origin = '"SVOD_PLAN_EQUIP"."VAL"'
    end
    object dsetPUMPING: TIntegerField
      FieldName = 'PUMPING'
      Origin = '"SVOD_PLAN_EQUIP"."VAL"'
    end
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 152
    Top = 32
  end
end
