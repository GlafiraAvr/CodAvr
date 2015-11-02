object frm_picters: Tfrm_picters
  Left = 192
  Top = 152
  Width = 535
  Height = 416
  Caption = 'frm_picters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn2: TBitBtn
    Left = 384
    Top = 64
    Width = 75
    Height = 25
    Caption = 'BitBtn2'
    TabOrder = 1
  end
  inline Frame_picters: TFrame_picters
    Left = 0
    Top = 41
    Width = 519
    Height = 318
    Align = alClient
    TabOrder = 2
    inherited pnl_buttons: TPanel
      Top = 284
      Width = 519
      inherited spb_add: TSpeedButton
        Left = 320
        Top = 4
        Width = 25
        Height = 26
        Font.Charset = ANSI_CHARSET
        Font.Height = -19
        Font.Name = 'Bauhaus 93'
        OnClick = Frame_pictersspb_addClick
      end
      inherited sp_del: TSpeedButton
        Top = 4
        Width = 26
        Height = 26
        Font.Charset = ANSI_CHARSET
        Font.Height = -21
        Font.Name = 'Bauhaus 93'
        OnClick = Frame_picterssp_delClick
      end
      inherited SpeedButton1: TSpeedButton
        Left = 379
        Top = 4
        Width = 29
        Height = 26
        OnClick = Frame_pictersSpeedButton1Click
      end
      inherited DBNavigator1: TDBNavigator
        Hints.Strings = ()
        OnClick = Frame_pictersDBNavigator1Click
      end
    end
    inherited pnl_filename: TPanel
      Width = 519
      inherited blb_head: TLabel
        Width = 517
      end
    end
    inherited pnl_Img: TPanel
      Width = 519
      Height = 251
      inherited Image: TImage
        Left = 24
        Top = 0
        Width = 385
        Height = 265
        Stretch = True
      end
      inherited lb_mess: TLabel
        Width = 515
        Height = 247
      end
    end
  end
  object rg_typ: TRadioGroup
    Left = 0
    Top = 0
    Width = 519
    Height = 41
    Align = alTop
    Columns = 3
    Ctl3D = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      #1055#1086#1074#1088#1077#1078#1076#1077#1085#1080#1077)
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnClick = rg_typClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 359
    Width = 519
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end
