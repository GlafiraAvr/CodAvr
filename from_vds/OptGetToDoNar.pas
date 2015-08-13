unit OptGetToDoNar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDatePeriodFrame, StdCtrls, Buttons, ExtCtrls;

type
  Tfrm_OptGetToDoNar = class(Tfrm_BaseOption)
    frame_SelDatePeriod1: Tframe_SelDatePeriod;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    rg_system: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function getSystemTable:string;
    function getSysname:string;
  public
    { Public declarations }
    property selSystem:string read getSystemTable;
    property systemName:string read getSysname;
  end;

var
  frm_OptGetToDoNar: Tfrm_OptGetToDoNar;

implementation

{$R *.dfm}

procedure Tfrm_OptGetToDoNar.BitBtn1Click(Sender: TObject);
begin
  inherited;
if frame_SelDatePeriod1.IsDatesCorrect then
  ModaLResult:=mrOk
else
  ModalResult:=mrNone;
end;

procedure Tfrm_OptGetToDoNar.BitBtn2Click(Sender: TObject);
begin
  inherited;
ModalResult:=mrCancel;

end;

function Tfrm_OptGetToDoNar.getSysname: string;
begin
result:=rg_System.Items[rg_System.ItemIndex];
end;

function Tfrm_OptGetToDoNar.getSystemTable: string;
begin
  result:='';
  if rg_System.ItemIndex=0 then
   result:='orders';
  if rg_system.ItemIndex=1 then
   result:='orders_vds';

end;

procedure Tfrm_OptGetToDoNar.FormCreate(Sender: TObject);
begin
  inherited;
  frame_SelDatePeriod1.de_Begin.Date:=Date()-30;
  frame_SelDatePeriod1.de_End.Date:=Date();

end;

end.
