unit SOAttachForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, DB;

type
  Tfrm_SOAttach = class(TForm)
    pnl_Main: TPanel;
    btn_SearchOrder: TBitBtn;
    btn_NewOrder: TBitBtn;
    pnl_Cache: TPanel;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    pnl_CacheBtns: TPanel;
    ds_Cache: TDataSource;
    BitBtn1: TBitBtn;
    btn_AttachToCache: TBitBtn;
    btn_ClearCache: TBitBtn;
    procedure btn_SearchOrderClick(Sender: TObject);
    procedure btn_AttachToCacheClick(Sender: TObject);
    procedure btn_ClearCacheClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btn_NewOrderClick(Sender: TObject);
  private
    F_OnSearchOrder: TNotifyEvent;
    F_OnAttachToValueFromCache: TNotifyEvent;
    F_OnClearCache: TNotifyEvent;
    f_OnNewOrder: TNotifyEvent;
  public
    property OnSearchOrder: TNotifyEvent read F_OnSearchOrder
      write F_OnSearchOrder;
    property OnAttachToValueFromCache: TNotifyEvent read F_OnAttachToValueFromCache
      write F_OnAttachToValueFromCache;
    property OnClearCache: TNotifyEvent read F_OnClearCache
      write F_OnClearCache;
    property OnNewOrder: TNotifyEvent read F_OnNewOrder write F_OnNewOrder;
  end;


implementation

{$R *.dfm}

procedure Tfrm_SOAttach.btn_SearchOrderClick(Sender: TObject);
begin
  if Assigned( F_OnSearchOrder ) then
    F_OnSearchOrder( nil );
end;

procedure Tfrm_SOAttach.btn_AttachToCacheClick(Sender: TObject);
begin
  if Assigned( F_OnAttachToValueFromCache ) then
    F_OnAttachToValueFromCache( nil );
end;

procedure Tfrm_SOAttach.btn_ClearCacheClick(Sender: TObject);
begin
  if Assigned( F_OnClearCache ) then
    F_OnClearCache( nil );
end;

procedure Tfrm_SOAttach.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SOAttach.btn_NewOrderClick(Sender: TObject);
begin
  if Assigned( F_OnNewOrder ) then
    F_OnNewOrder( nil );
end;

end.
