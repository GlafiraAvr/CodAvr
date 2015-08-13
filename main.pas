unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, DModule, AvrPictersDModule,
  picterframe;

 const Title='Программа';
type
  Tfrm_picters = class(TForm)
    BitBtn2: TBitBtn;
    Frame_picters: TFrame_picters;
    rg_typ: TRadioGroup;
 
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rg_typClick(Sender: TObject);
    procedure Frame_pictersSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    SS:TStringStream;
    dm_Picters:Tdm_avrpicter;
    F_OrderId:integer;
    F_readOnly:boolean;
  public
    { Public declarations }
    property Order_id:integer  read F_orderID write F_orderId ;
    property _ReadOnly:boolean read F_readOnly write F_readOnly;
  end;

var
  frm_picters: Tfrm_picters;

implementation

{$R *.dfm}



procedure Tfrm_picters.FormShow(Sender: TObject);
var st:string;
   SL:TStringList;
begin
  if F_OrderID >0 then
     dm_Picters.F_ID_order:=F_OrderID
   else
     dm_Picters.F_ID_order:=1;
  dm_Picters.f_typ:=1;

  dm_Picters.OpenDset;
  Frame_picters.Init;
  Frame_picters.typ:=1;
  Frame_picters.readOnly:= F_readOnly;
  dm_Picters.mem_maps.First;
end;

procedure Tfrm_picters.FormDestroy(Sender: TObject);
begin
  SS.Free;
  dm_Picters.Free;

end;

procedure Tfrm_picters.FormCreate(Sender: TObject);
begin
 F_readOnly:=false;
 F_OrderID:=1;
 dm_Picters:=Tdm_avrpicter.Create(nil);
 Frame_picters._DM:=dm_Picters;
end;

procedure Tfrm_picters.rg_typClick(Sender: TObject);
begin
if Frame_picters.typ<>rg_typ.ItemIndex+1 then
 Frame_picters.typ:=rg_typ.ItemIndex+1;
end;

procedure Tfrm_picters.Frame_pictersSpeedButton1Click(Sender: TObject);
begin
 Close;
end;

end.
