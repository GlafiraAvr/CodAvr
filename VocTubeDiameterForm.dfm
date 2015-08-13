inherited frm_VocTubeDiameter: Tfrm_VocTubeDiameter
  Width = 339
  Height = 245
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1080#1072#1084#1077#1090#1088#1086#1074
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 164
    Width = 331
  end
  inherited pnl_EditFields: TPanel
    Top = 134
    Width = 331
    Height = 30
    object lbl_TubeDiameter: TLabel
      Left = 32
      Top = 11
      Width = 61
      Height = 13
      Caption = #1044#1080#1072#1084#1077#1090#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ed_TubeDiameter: TDBEdit
      Left = 98
      Top = 4
      Width = 121
      Height = 21
      DataField = 'DIAMETER'
      DataSource = ds_MainVoc
      TabOrder = 0
      OnChange = CtrlsChange
    end
  end
  inherited pnl_Grid: TPanel
    Width = 331
    Height = 134
    inherited dbg_MainVoc: TDBGrid
      Top = 0
      Width = 332
      Height = 133
      Columns = <
        item
          Expanded = False
          FieldName = 'DIAMETER'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1044#1080#1072#1084#1077#1090#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 172
          Visible = True
        end>
    end
  end
  inherited dset_MainVoc: TIBDataSet
    InsertSQL.Strings = (
      'insert into s_tubediameter(id, diameter)'
      'values (:id, :diameter)')
    SelectSQL.Strings = (
      'select id, diameter, activity'
      'from s_TubeDiameter'
      'where id<>-1'
      'order by diameter'
      '')
    ModifySQL.Strings = (
      'update s_tubediameter set'
      'diameter=:diameter,'
      'activity=:activity'
      'where id=:id')
    GeneratorField.Field = 'ID'
    GeneratorField.Generator = 'GEN_S_TUBDIAMETER_ID'
    object dset_MainVocID: TIntegerField
      FieldName = 'ID'
      Origin = 'S_TUBEDIAMETER.ID'
      Required = True
    end
    object dset_MainVocDIAMETER: TIntegerField
      FieldName = 'DIAMETER'
      Origin = 'S_TUBEDIAMETER.DIAMETER'
    end
    object dset_MainVocACTIVITY: TIBStringField
      FieldName = 'ACTIVITY'
      Origin = 'S_TUBEDIAMETER.ACTIVITY'
      FixedChar = True
      Size = 1
    end
  end
end
