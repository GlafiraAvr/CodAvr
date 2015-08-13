unit OrderNG1562Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OrderNGForm, StdCtrls, Buttons, ExtCtrls, Grids, Aligrid, Mask,
  ToolEdit, RxLookup, ValEdit, DB;

type
  Tfrm_OrderNG1562 = class(Tfrm_OrderNG)
    vle_Order1562: TValueListEditor;
    Pnl_Vocs: TPanel;
    l_Regl: TLabel;
    de_Regl: TDateEdit;
    te_Regl: TMaskEdit;
    GB_Grid: TGroupBox;
    Grid: TStringAlignGrid;
    pnl_filter: TPanel;
    btn_NewOrder: TBitBtn;
    btn_Order: TBitBtn;
    Label1: TLabel;
    dp_Coming1: TDateEdit;
    tp_Coming1: TMaskEdit;
    lbl_DateComing2: TLabel;
    dp_Coming2: TDateEdit;
    tp_Coming2: TMaskEdit;
    sb_OK: TSpeedButton;
    sb_Cancel: TSpeedButton;
    btnCancel: TBitBtn;
    btnExit: TBitBtn;
    btnInWork: TBitBtn;
    btnLink: TBitBtn;

    procedure CtrlChange(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    F_OnCtrlChange: TNotifyEvent;
  public
    { Public declarations }
    property OnCtrlChange: TNotifyEvent read F_OnCtrlChange write F_OnCtrlChange;
    procedure AfterSave;
  end;

var
  frm_OrderNG1562: Tfrm_OrderNG1562;

implementation

{$R *.dfm}

procedure Tfrm_OrderNG1562.btnExitClick(Sender: TObject);
begin
  inherited;
 Close;
end;

procedure Tfrm_OrderNG1562.AfterSave;
begin
    btn_Save.Enabled := false;
    btnCancel.Enabled := false;
end;

procedure Tfrm_OrderNG1562.FormCreate(Sender: TObject);
begin
  inherited;
 //
 de_Regl.OnChange := OnCtrlChange;
 te_Regl.OnChange := OnCtrlChange;

end;

procedure Tfrm_OrderNG1562.CtrlChange(Sender: TObject);
begin
   if Assigned(F_OnCtrlChange) then F_OnCtrlChange(Sender);
end;


end.
