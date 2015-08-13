unit OptBlag2Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, SelDatePeriodFrame, ExtCtrls,ToolEdit , StringConsts,
  SelRegionFrame, DB, IBCustomDataSet, IB, IBErrorCodes, DModule;

type
  Tfrm_OptBlag2 = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_close: TBitBtn;
    frame_SelDates: Tframe_SelDatePeriod;
    cb_GreenZone: TCheckBox;
    rg_Asfalt: TRadioGroup;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    Panel1: TPanel;
    frame_SelDateP1: Tframe_SelDatePeriod;
    cb_Blag: TCheckBox;
    cb_notfar: TCheckBox;
    frame_SelDateP2: Tframe_SelDatePeriod;
    Shape1: TShape;
    cb_DopAsf: TCheckBox;
    cb_adress: TCheckBox;
    frame_SelRegion1: Tframe_SelRegion;
    dset_date: TIBDataSet;
    rg_Excav: TRadioGroup;
    rg_ClosedOrder: TRadioGroup;
    cb_prosroch: TCheckBox;
    procedure btn_closeClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure cb_BlagClick(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure frame_SelDateP1de_BeginChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frame_SelDatesde_BeginChange(Sender: TObject);
    procedure frame_SelDatesde_EndChange(Sender: TObject);
  private
   F_RGBLAG: integer;
   F_GZ: boolean;
   F_RGASF: boolean;
   F_id_region,F_strREgion:string;
   F_Spring:boolean;
   procedure EnabledFrame(Frame:Tframe_SelDatePeriod;value:boolean);
   function  GetDopBegDatte():TDate;
   function  GetDopEndDatte():TDate;
   function  GetFinishBegDatte():TDate;
   function  GetFinishpEndDatte():TDate;
   procedure setRGBLag(rg_blag:integer);
   procedure setGZ(v:boolean);
   procedure setDopBeginDate(sd:TDate);
   procedure setDopEndDate(sd:TDate);
   procedure setFinishBeginDate(sd:TDate);
   procedure setFinishEndDate(sd:TDate);
   function GetDate(year:integer):TDateTime;
   function chageDate(year:integer):boolean;
   function Get_WithouExcav:integer;
   procedure Set_WithouExcav(v:integer);
   function ReadOverDude ():boolean;
  public
   property rgblag: integer read F_RGBLAG write setRGBLag;
   property GZ: boolean read F_GZ write setGZ;
   property RGASF: boolean read F_RGASF;
   property DopBegDate:TDate read GetDopBegDatte write setDopBeginDate;
   property DopEndDate:TDate read GetDopEndDatte write setDopEndDate;
   property FinishBegDatte:TDate  read GetFinishBegDatte write setFinishBeginDate;
   property FinishpEndDatte:TDate read GetFinishpEndDatte write setFinishEndDate;
   property IDREgions:string read  F_id_region;
   function PrepareGreemSpring:boolean;
   property WithoutExcav:integer read  Get_WithouExcav write Set_WithouExcav;
   property overd:boolean read ReadOverDude;
  end;

implementation

{$R *.dfm}

 uses HelpFunctions;
procedure Tfrm_OptBlag2.btn_closeClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptBlag2.btn_okClick(Sender: TObject);
begin
  inherited;
   if  not Frame_SelDates.IsDatesCorrect then
     exit;
   if frame_SelDateP1.Enabled then
   if  not frame_SelDateP1.IsDatesCorrect then
     exit;

   if frame_SelDateP2.Enabled then
   if  not frame_SelDateP2.IsDatesCorrect then
     exit;
   if frame_SelDateP1.Enabled then  
   if frame_SelDateP1.BeginDate>0 then
   begin
  { if  frame_SelDateP1.BeginDate<Frame_SelDates.BeginDate then
    begin
    Application.MessageBox('Не правильно введен период окончания благоустройства!! Период окончания благоустройства дожен бать внутри основного периода!',  gc_strDispAVR, mB_OK+MB_ICONWarning);
     frame_SelDateP1.de_Begin.SetFocus;
     exit;
   end;
    if frame_SelDateP1.EndDate>Frame_SelDates.EndDate then
    begin
    Application.MessageBox('Не правильно введен период окончания благоустройства!! Период окончания благоустройства дожен бать внутри основного периода!',  gc_strDispAVR, mB_OK+MB_ICONWarning);
     frame_SelDateP1.de_End.SetFocus;
     exit;
   end;}
   end;

   if frame_SelDateP2.Enabled then
   if  frame_SelDateP2.BeginDate>0 then
   begin
   if  frame_SelDateP2.BeginDate<Frame_SelDates.BeginDate then
    begin
    Application.MessageBox('Не правильно введен период недано поступившие!! Период недано поступившие дожен бать внутри основного периода!' ,   gc_strDispAVR, mB_OK+MB_ICONWarning);
     frame_SelDateP2.de_Begin.SetFocus;
     exit;
   end;
    if frame_SelDateP2.EndDate>Frame_SelDates.EndDate then
    begin
    Application.MessageBox('Не правильно введен период недано поступившие!! Период недано поступившие дожен бать внутри основного периода!',   gc_strDispAVR, mB_OK+MB_ICONWarning);
     frame_SelDateP2.de_End.SetFocus;
     exit;
   end;
   end;

     {дописать проверки!!!!}
   if rb1.Checked then F_RGBLAG:=0;
   if rb2.Checked then F_RGBLAG:=1;
   if rb3.Checked then F_RGBLAG:=2;


   F_GZ := cb_GreenZone.Checked;
   if rg_Asfalt.ItemIndex=0 then F_RGASF := true else F_RGASF := false;

  frame_SelRegion1.SetRegions( F_id_region,F_strREgion);
  if frame_SelDates.IsDatesCorrect then
    ModalResult := mrOk;
end;

procedure Tfrm_OptBlag2.cb_BlagClick(Sender: TObject);
begin
  inherited;
if cb_Blag.Checked then
begin

  EnabledFrame(Frame_SelDateP1,true);
end
else
begin
  EnabledFrame(Frame_SelDateP1,false);
end;
if cb_notfar.Checked then
begin
 EnabledFrame(Frame_SelDateP2,true);
end
else
begin
 EnabledFrame(Frame_SelDateP2,false);

end

end;

procedure Tfrm_OptBlag2.rb2Click(Sender: TObject);
begin
  inherited;
if rb2.Checked then
  Panel1.Visible:=true
 else
 begin
   Panel1.Visible:=false;
   cb_blag.Checked:=false;
   cb_notfar.Checked:=false;

   EnabledFrame(frame_SelDateP1,false);
   EnabledFrame(frame_SelDateP2,false);
 end
end;

procedure Tfrm_OptBlag2.EnabledFrame(Frame:Tframe_SelDatePeriod;value:boolean);
var i:integer;
begin
Frame.Enabled:=value;
Frame.de_Begin.Enabled:=value;
Frame.de_End.Enabled:=value;

{
for i:=0 to  Frame.ControlCount-1 do
begin
 if  Frame.Controls[i] is TDateEdit then
  ( Frame.Controls[i] as  TDateEdit).Enabled :=value;
end;}
end;


function  Tfrm_OptBlag2.GetDopBegDatte():TDate;
begin
if cb_notFar.Checked then
 Result:=frame_SelDateP2.BeginDate
else
 Result:=0;
end;

function  Tfrm_OptBlag2.GetDopEndDatte():TDate;
begin
if cb_notFar.Checked then
 Result:=frame_SelDateP2.EndDate
else
 Result:=0;

end;

function  Tfrm_OptBlag2.GetFinishBegDatte():TDate;
begin
if (Frame_selDateP1.Enabled) and (cb_Blag.Checked) then
 REsult:=Frame_selDateP1.BeginDate
else
 Result:=0;
end;

function  Tfrm_OptBlag2.GetFinishpEndDatte():TDate;
begin
if (Frame_selDateP1.Enabled)and (cb_Blag.Checked) then
 REsult:=Frame_selDateP1.EndDate
else
 Result:=0;

end;

procedure Tfrm_OptBlag2.setRGBLag(rg_blag:integer);
begin
 frame_SelDateP1.Enabled:=false;
       frame_SelDateP2.Enabled:=false;
       cb_Blag.Checked:=false;
       cb_notfar.Checked:=false;
       frame_SelDateP1.de_Begin.Text:=frame_SelDateP1.de_Begin.EditMask;
       frame_SelDateP1.de_End.Text:=frame_SelDateP1.de_Begin.EditMask;
       frame_SelDateP2.de_Begin.Text:=frame_SelDateP1.de_Begin.EditMask;
       frame_SelDateP2.de_End.Text:=frame_SelDateP1.de_Begin.EditMask;
       Panel1.Visible:=false;
 case rg_blag of
  0: begin
       rb1.Checked:=true;
       rb2.Checked:=false;
       rb3.Checked:=false;

     end;
  1: begin
       rb1.Checked:=false;
       rb2.Checked:=true;
       rb3.Checked:=false;
       Panel1.Visible:=true;
     end;
  2: begin
       rb1.Checked:=false;
       rb2.Checked:=false;
       rb3.Checked:=true;
      end;

  end;
  f_RGBLag:=rg_blag;

end;

procedure Tfrm_OptBlag2.setGZ(v:boolean);
begin
  cb_GreenZone.Checked:=v;
  F_Gz:=v;
end;

procedure Tfrm_OptBlag2.setDopBeginDate(sd:TDate);
begin
 if  f_RGBLag<>1 then  setRGBLag(1);
 cb_notFar.Checked:=true;
 frame_SelDateP2.Enabled:=true;
 frame_SelDateP2.de_Begin.Date:=sd;
end;


procedure Tfrm_OptBlag2.setDopEndDate(sd:TDate);
begin
 if  f_RGBLag<>1 then  setRGBLag(1);
 cb_notFar.Checked:=true;
 frame_SelDateP2.Enabled:=true;
 frame_SelDateP2.de_End.Date:=sd;
end;


procedure Tfrm_OptBlag2.setFinishBeginDate(sd:TDate);
begin
 if  f_RGBLag<>1 then  setRGBLag(1);
 cb_blag.Checked:=true;
 frame_SelDateP1.Enabled:=true;
 frame_SelDateP1.de_Begin.Date:=sd;
end;

procedure Tfrm_OptBlag2.setFinishEndDate(sd:TDate);
begin
 if  f_RGBLag<>1 then  setRGBLag(1);
 cb_blag.Checked:=true;
 frame_SelDateP1.Enabled:=true;
 frame_SelDateP1.de_End.Date:=sd;
end;



procedure Tfrm_OptBlag2.frame_SelDateP1de_BeginChange(Sender: TObject);
begin
  inherited;
  if cb_notfar.Checked then
   frame_SelDateP2.BeginDate:=frame_SelDateP1.de_Begin.Date;
end;

procedure Tfrm_OptBlag2.FormShow(Sender: TObject);
begin
  inherited;
  F_id_region:='';

end;

function Tfrm_OptBlag2.PrepareGreemSpring:boolean;
const datespring='01.03.2014';
begin
 result:=false;
 try
  rb1.Visible:=false;

  rb2.Visible:=true;
  rb2.Checked:=true;
  rb3.Visible:=false;
  cb_adress.Visible:=false;
  cb_dopasf.Visible:=false;
//  cb_GreenZone.Visible:=false;
  cb_notfar.Visible:=false;
  frame_SelDateP2.Visible:=false;
  cb_Blag.Visible:=true;
  cb_Blag.Checked:=true;
  frame_SelDateP1.Visible:=true;
  cb_Blag.Enabled:=false;
  frame_SelDateP1.EndDate:=Date;
  frame_SelDateP1.BeginDate:=GetDate(GetYear(date()));
  frame_SelDates.de_Begin.Date:=StrToDate('01.01.'+IntToStr(GetYear(date())-1));
  frame_SelDates.EndDate:=frame_SelDateP1.BeginDate;
  frame_SelDates.de_End.Enabled:=false;
  rg_Excav.Visible:=false;
  F_Spring:=true;
  result:=true;
  except
    result:=false;
  end;
end;

function Tfrm_OptBlag2.GetDate(year:integer):TDateTime;
var V:variant;
ei:integer;
begin
 if not dset_date.Database.Connected then
   dset_date.Database.Connected:=true;
try
if  not dset_date.Active then
 dset_date.Open;
except
on e:EIBInterBaseError do
begin
  if e.IBErrorCode=isc_network_error then
   if not ReconnectAll(dset_date.Database) then
     exit
   else
     dset_date.Open;
end;
end ;
 V:=dset_date.Lookup('Curyear',VarArrayOf([year]),'curdate');
 if not (VarType(V) in [varNull]) then
  result:=V
 else
   result:=StrToDate('15.02.'+IntToStr(year));
 

end;

procedure Tfrm_OptBlag2.FormDestroy(Sender: TObject);
begin
  inherited;
  if dset_date.Active then
   dset_date.Close;
end;

procedure Tfrm_OptBlag2.FormCreate(Sender: TObject);
begin
  inherited;
 F_Spring:=false;
end;

function Tfrm_OptBlag2.chageDate(year:integer):boolean;
begin
 result:=false;
 try
 if  F_Spring then
 begin
   frame_SelDates.BeginDate:=StrToDate('01.01.'+IntToStr(year));
   frame_SelDates.EndDate:=Getdate(year+1);
   frame_SelDateP1.BeginDate:=frame_SelDates.EndDate;
   if Date()<StrToDate('31.12.'+IntTostr(year+1)) then
     frame_SelDateP1.EndDate:=Date()
   else
      frame_SelDateP1.EndDate:=StrToDate('31.12.'+IntTostr(year+1));
   result:=true;
 end;
 except
  result:=false;
 end;
end;

procedure Tfrm_OptBlag2.frame_SelDatesde_BeginChange(Sender: TObject);
var year:integer;
begin
  inherited;
if  F_Spring then
begin
  year:=GetYear(frame_SelDates.BeginDate);
  chageDate(year);
end;
end;

procedure Tfrm_OptBlag2.frame_SelDatesde_EndChange(Sender: TObject);
var year:integer;
begin
  inherited;
 { if F_Spring then
  begin
   year:=GetYear(frame_SelDates.EndDate)-1;
   chageDate(year);
  end;}
end;

function Tfrm_OptBlag2.Get_WithouExcav:integer;
begin
   result:=rg_Excav.ItemIndex;
end;

procedure Tfrm_OptBlag2.Set_WithouExcav(v:integer);
begin
 rg_Excav.ItemIndex:=v;
end;

function Tfrm_OptBlag2.ReadOverDude ():boolean;
begin
result:=cb_prosroch.Checked;
end;

end.
