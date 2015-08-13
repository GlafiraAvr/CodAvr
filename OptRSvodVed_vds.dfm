inherited frm_OptRSvod_vds: Tfrm_OptRSvod_vds
  Caption = 'frm_OptRSvod_vds'
  PixelsPerInch = 96
  TextHeight = 13
  object btn_about: TButton
    Left = 184
    Top = 136
    Width = 145
    Height = 25
    Caption = #1054' '#1095#1077#1084' '#1079#1072#1103#1074#1083#1077#1085#1086' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_aboutClick
  end
  object cb_leak: TCheckBox
    Left = 16
    Top = 144
    Width = 97
    Height = 17
    Caption = #1058#1077#1095#1100
    TabOrder = 7
    OnClick = cb_leakClick
  end
  object dset: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = DM_Main.Tr_RCommited
    Left = 104
    Top = 88
  end
end
