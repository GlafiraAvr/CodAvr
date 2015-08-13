unit Image_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, DModule, AvrPictersDModule,
  picterframe, ComCtrls, DBCtrls;

 const Title='Программа';
type
  Tfrm_picters = class(TForm)
    BitBtn2: TBitBtn;
    Frame_picters: TFrame_picters;
    rg_typ: TRadioGroup;
    StatusBar: TStatusBar;
                                                                   
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rg_typClick(Sender: TObject);
    procedure Frame_pictersSpeedButton1Click(Sender: TObject);
    procedure Frame_picterssp_delClick(Sender: TObject);
    procedure Frame_pictersspb_addClick(Sender: TObject);
    procedure Frame_pictersDBNavigator1Click(Sender: TObject;
      Button: TNavigateBtn);
  private
    { Private declarations }
    SS:TStringStream;
    dm_Picters:Tdm_avrpicter;
    F_OrderId:integer;
    F_readOnly:boolean;
    F_orderNumber:integer;
    F_year:integer;
    procedure ClearStatus();
    procedure Showstate(mes:string);
    procedure ShowMess(s:string);
  public
    { Public declarations }
    property Order_id:integer  read F_orderID write F_orderId ;
    property _ReadOnly:boolean read F_readOnly write F_readOnly;
    property OrderNumber:integer write F_orderNumber;
    property year:integer write F_year;
  end;

var
  frm_picters: Tfrm_picters;

implementation

{$R *.dfm}



procedure Tfrm_picters.FormShow(Sender: TObject);

begin
 try
  if F_OrderID >0 then
     dm_Picters.F_ID_order:=F_OrderID
   else
     dm_Picters.F_ID_order:=1;
  dm_Picters.f_typ:=1;
  if F_year=0 then
     F_year:=2014;
  dm_Picters.Year:=F_year;
  if F_orderNumber=0 then
   F_OrderNumber:=1;
  dm_Picters.Ordernumber:=F_orderNumber;
  Caption:='Фотографии наряд №'+IntToStr(F_orderNumber);

  if dm_Picters.OpenDset then
  begin
  Frame_picters.Init;
  Frame_picters.typ:=1;
  Frame_picters.readOnly:= F_readOnly;

  dm_Picters.mem_maps.First;
  end
  else
  begin
    Frame_picters.Enabled(false);
  Showstate('Ошибка открытия!');
  end

 except
  Frame_picters.Enabled(false);
  Showstate('Ошибка открытия!');
 end;

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
 dm_Picters.Showmes:=ShowMess;
end;

procedure Tfrm_picters.rg_typClick(Sender: TObject);
begin
 ClearStatus;
if Frame_picters.typ<>rg_typ.ItemIndex+1 then
 Frame_picters.typ:=rg_typ.ItemIndex+1;
end;

procedure Tfrm_picters.Frame_pictersSpeedButton1Click(Sender: TObject);
begin
 Close;
end;

procedure Tfrm_picters.Frame_picterssp_delClick(Sender: TObject);
begin
 if Application.MessageBox('Удалить текущее изображение?','',MB_YESNO+MB_ICONQUESTION)=mrYes
 then
 begin
  try
   Frame_picters.sp_delClick(Sender);
   if Frame_picters.Last_ResuLt then
   ShowState('Изображение удалено!')
   else
    ShowState('Ошибка при удалении');
  except
   ShowState('Ошибка при удалении');
  end;

 end;

end;

procedure Tfrm_picters.Showstate(mes:string);
begin
 StatusBar.Panels[0].Text:=mes;
end;

procedure Tfrm_picters.ClearStatus();
begin
 StatusBar.Panels[0].Text:='';
end;

procedure Tfrm_picters.Frame_pictersspb_addClick(Sender: TObject);
begin

try
  Frame_picters.spb_addClick(Sender);
  if Frame_picters.Last_ResuLt then
    ShowState('Изображение добавлено!')
  else
   ShowState('Ошибка при сохранении');
except
  ShowState('Ошибка при сохранении');
end;

end;

procedure Tfrm_picters.Frame_pictersDBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
 ClearStatus ;

end;

 procedure Tfrm_picters.ShowMess(s:string);
 begin
 Showmessage(s);
 end;

end.
