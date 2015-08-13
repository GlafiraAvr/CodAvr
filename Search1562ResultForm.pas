unit Search1562ResultForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, StdCtrls, Buttons, ExtCtrls, Grids, Aligrid;

type
  Tfrm_Search1562Result = class(Tfrm_BaseResult)
    pnl_btns: TPanel;
    btn_Order: TBitBtn;
    btn_Exit: TBitBtn;
    pnl_RegInfo: TPanel;
    lbl_RegionName: TLabel;
    lbl_DmgCount: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Grid: TStringAlignGrid;
    pnl_Wait: TPanel;
    btn_OrderTo1562: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_OrderTo1562Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure StartWait;
    procedure StopWait;
  end;

var
  frm_Search1562Result: Tfrm_Search1562Result;

implementation

{$R *.dfm}

procedure Tfrm_Search1562Result.btn_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_Search1562Result.btn_OrderTo1562Click(Sender: TObject);
begin
  //F_ResultCondition:=' where FK_ORDERS_REGIONS = ';

  Close;
end;


procedure  Tfrm_Search1562Result.StartWait;
begin
  pnl_Wait.Visible:=true;
  Application.ProcessMessages;
end;


procedure Tfrm_Search1562Result.StopWait;
begin
  pnl_Wait.Visible:=false;
  Application.ProcessMessages;
end;


end.
