unit DepWorkersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeamFrame, StdCtrls, Buttons;

type
  Tfrm_DepWorkers = class(TForm)
    frame: Tframe_Team;
    pnl_btns: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure framebtn_AddTeamClick(Sender: TObject);
  private
    F_IsReadOnly: boolean;
  public
    constructor Create(AOwner: TComponent; AOrderID, ADepID, ABrigID: integer; AReadOnly: boolean;for_Vds:boolean=false; F_Region_id:integer=0);
  end;


implementation

{$R *.dfm}

procedure Tfrm_DepWorkers.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_DepWorkers.btn_SaveClick(Sender: TObject);
begin
  frame.Save;
  ModalResult:=mrOk;
end;

constructor Tfrm_DepWorkers.Create(AOwner: TComponent; AOrderID,
  ADepID, ABrigID: integer; AReadOnly: boolean; for_Vds:boolean=false; F_Region_id:integer=0);
begin
  inherited Create(AOwner);
  F_IsReadOnly:=AReadOnly;

  frame.IsReadOnly:=AReadOnly;
  frame.OrderID:=AOrderID;
  frame.DepID:=ADepID;
  frame.IDBrig:=ABrigID;
  frame.Mode:=ftmDep;
  frame.Is_for_vds:=for_Vds;
  frame.REgion_ID:=F_Region_id;
  frame.Start;
end;

procedure Tfrm_DepWorkers.FormDestroy(Sender: TObject);
begin
  frame.Stop;
end;

procedure Tfrm_DepWorkers.FormShow(Sender: TObject);
begin
  btn_Save.Enabled:=not F_IsReadOnly;
end;

procedure Tfrm_DepWorkers.framebtn_AddTeamClick(Sender: TObject);
begin
  frame.btn_AddTeamClick(Sender);

end;

end.
