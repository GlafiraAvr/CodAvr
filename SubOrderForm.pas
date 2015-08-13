unit SubOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SubOrderFrame, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  Tfrm_SubOrder = class(TForm)
    frame_In: Tframe_SubOrder;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    StatusBar1: TStatusBar;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure frame_Insb_LoadFromOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    F_OnGetOrderFieldValues: TNotifyEvent;
    procedure ShowMsg( _msg: string );
    procedure SetIsReadOnly(Value: boolean);
  public
    property OnGetOrderFieldValues: TNotifyEvent read F_OnGetOrderFieldValues
      write F_OnGetOrderFieldValues;
    property IsReadOnly: boolean write SetIsReadOnly;
  end;


implementation

{$R *.dfm}

procedure Tfrm_SubOrder.btn_okClick(Sender: TObject);
begin
  if frame_In.IsFieldsCorrect then
    ModalResult := mrOk;
end;

procedure Tfrm_SubOrder.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SubOrder.frame_Insb_LoadFromOrderClick(Sender: TObject);
begin
  if Assigned( F_OnGetOrderFieldValues ) then
    F_OnGetOrderFieldValues( nil );
end;

procedure Tfrm_SubOrder.ShowMsg(_msg: string);
begin
  StatusBar1.SimpleText := _msg;
end;

procedure Tfrm_SubOrder.FormCreate(Sender: TObject);
begin
  frame_In.OnShowMsg := ShowMsg;
end;

procedure Tfrm_SubOrder.SetIsReadOnly(Value: boolean);
begin
  frame_In.IsReadOnly := Value;
  btn_ok.Enabled := not Value;
end;

end.
