inherited frm_OptSvodVedPer_vds: Tfrm_OptSvodVedPer_vds
  Caption = 'frm_OptSvodVedPer_vds'
  ClientHeight = 178
  ClientWidth = 247
  PixelsPerInch = 96
  TextHeight = 13
  inherited Bevel1: TBevel
    Width = 233
    Height = 133
  end
  inherited Label1: TLabel
    Left = 18
    Width = 9
    Caption = 'C'
  end
  object Label2: TLabel [2]
    Left = 121
    Top = 13
    Width = 15
    Height = 13
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited btn_ok: TBitBtn
    Top = 149
  end
  inherited btn_exit: TBitBtn
    Top = 149
  end
  inherited de_Date: TDateEdit
    Left = 28
  end
  inherited chb_IsShowPreview: TCheckBox
    Left = 27
    Top = 49
  end
  inherited frame_SelRegion: Tframe_SelRegion
    Left = 30
  end
  object de_end: TDateEdit
    Left = 148
    Top = 10
    Width = 89
    Height = 21
    DefaultToday = True
    NumGlyphs = 2
    TabOrder = 5
  end
  object cb_o62: TCheckBox
    Left = 16
    Top = 76
    Width = 97
    Height = 17
    Caption = '062'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cb_Peoples: TCheckBox
    Left = 16
    Top = 96
    Width = 97
    Height = 17
    Caption = #1046#1080#1090#1077#1083#1080
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cb_ODS: TCheckBox
    Left = 16
    Top = 116
    Width = 97
    Height = 17
    Caption = #1054#1044#1057
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
end
