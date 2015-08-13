inherited frm_VocTeams: Tfrm_VocTeams
  Left = 313
  Top = 250
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1073#1088#1080#1075#1072#1076
  ClientHeight = 338
  ClientWidth = 348
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Buttons: TPanel
    Top = 308
    Width = 348
    Height = 30
    inherited btn_Insert: TBitBtn
      Left = 417
      Visible = False
    end
    inherited btn_Edit: TBitBtn
      Left = 522
      Visible = False
    end
    inherited btn_Delete: TBitBtn
      Left = 635
      Visible = False
    end
    inherited btn_Post: TBitBtn
      Top = 5
      Width = 88
    end
    inherited btn_Cancel: TBitBtn
      Left = 99
      Top = 5
      Width = 86
    end
    inherited btn_Exit: TBitBtn
      Left = 264
      Top = 5
      Width = 77
    end
  end
  inherited pnl_EditFields: TPanel
    Top = 302
    Width = 348
    Height = 6
  end
  inherited pnl_Grid: TPanel
    Width = 348
    Height = 302
    inherited dbg_MainVoc: TDBGrid
      Left = 544
      Top = 34
      Width = 330
      Height = 262
      Anchors = [akLeft]
      Visible = False
    end
    inline frame: Tframe_Team
      Left = 5
      Top = 6
      Width = 340
      Height = 291
      Color = clBtnFace
      ParentColor = False
      TabOrder = 1
      inherited Bevel2: TBevel [0]
        Left = 192
        Top = 40
        Width = 137
      end
      inherited Bevel1: TBevel [1]
        Left = 8
        Top = 40
        Width = 134
        Height = 241
      end
      inherited Label1: TLabel [2]
        Left = 8
        Top = 8
      end
      inherited Label2: TLabel [3]
        Left = 62
        Top = 46
      end
      inherited Label3: TLabel [4]
        Left = 227
        Top = 47
        Width = 61
        Caption = #1042' '#1073#1088#1080#1075#1072#1076#1077
      end
      inherited dbl_Brig: TRxDBLookupCombo
        Left = 69
        Top = 5
        Width = 180
      end
      inherited lb_Src: TListBox
        Left = 14
        Top = 64
        Width = 121
      end
      inherited lb_Des: TListBox
        Left = 200
        Top = 64
        Width = 121
      end
      inherited btn_Add: TBitBtn
        Left = 149
        Top = 136
        Width = 36
        OnClick = framebtn_AddClick
      end
      inherited btn_Del: TBitBtn
        Left = 149
        Top = 164
        Width = 36
        OnClick = framebtn_DelClick
      end
      inherited btn_AddTeam: TBitBtn
        Left = 152
        Top = 88
        Width = 33
      end
      inherited tran: TIBTransaction
        Active = False
      end
    end
  end
  inherited Tr_MainVoc: TIBTransaction
    Left = 592
    Top = 208
  end
  inherited dset_MainVoc: TIBDataSet
    Left = 584
    Top = 160
  end
  inherited ds_MainVoc: TDataSource
    Left = 656
    Top = 144
  end
end
