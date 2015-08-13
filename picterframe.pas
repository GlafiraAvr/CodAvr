unit picterframe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, AvrPictersDModule, StdCtrls, ExtCtrls, DBCtrls, DB, Buttons,jpeg,
   IBCustomDataSet;

type
  TFrame_picters = class(TFrame)
    pnl_buttons: TPanel;
    pnl_filename: TPanel;
    pnl_Img: TPanel;
    ds_main: TDataSource;
    DBNavigator1: TDBNavigator;
    spb_add: TSpeedButton;
    sp_del: TSpeedButton;
    OpenDialog: TOpenDialog;
    Image: TImage;
    blb_head: TLabel;
    SpeedButton1: TSpeedButton;
    lb_mess: TLabel;
    procedure spb_addClick(Sender: TObject);
    procedure sp_delClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    F_DM:Tdm_avrpicter;
    F_typ:integer;
    F_readonly:boolean;
    procedure  SetDM(_DM:Tdm_avrpicter);
    procedure  REdrowPict(FileName:string;num:integer;inputfiel:string);
    procedure MashtabImg;
    procedure SetTyp(typ:integer);
    procedure ClearImage(mes:string='');
    procedure SetReadOnly(v:boolean);
  public
    Last_ResuLt:boolean;
    { Public declarations }
    property _DM: Tdm_avrpicter write SetDM;
    procedure Init();
    property typ:integer  read F_typ write SetTyp ;
    property readOnly :boolean write  SetReadOnly;
    procedure Enabled(value:boolean);
  end;

implementation

{$R *.dfm}

procedure TFrame_picters.spb_addClick(Sender: TObject);
var filename:string;
begin
  Last_ResuLt:=false;
  if OpenDialog.Execute then
  begin
     filename:=OpenDialog.filename;
     Last_ResuLt:=f_DM.Insert(filename);
     if Last_ResuLt then
     sp_del.Enabled:=true;
  end;

end;

procedure  TFrame_picters.SetDM(_DM:Tdm_avrpicter);
begin
  F_DM:=_DM;


end;

procedure TFrame_picters.sp_delClick(Sender: TObject);
 var e:exception;
begin
 Last_ResuLt :=false;
  if   F_DM.DeleteImg then
  begin
  Last_ResuLt:=true;
  if F_DM.Rec=0 then
   sp_del.Enabled:=false;
  end
  else
  begin
   e :=exception.Create('Ошибка удаления!!');
   raise e;
  end;

end;

procedure TFrame_picters.Init();
begin

  F_DM.OnRedraw:= REdrowPict;
  F_DM.ClearProc:=ClearImage;
 if  F_DM.mem_maps.RecordCount=0 then
   sp_del.Enabled:=false
 else
   sp_del.Enabled:=true;

end;

procedure  TFrame_picters.REdrowPict(Filename:String;num:integer;inputfiel:string);
begin
 if FileExists(filename) then
 begin
  Image.Picture.LoadFromFile(filename);
  blb_head.Caption:='№'+IntTOStr(num)+
                ' ('+inputfiel+ ')';
  lb_mess.Visible:=false;
  MashtabImg;
 end;

end;

procedure TFrame_picters.MashtabImg;
var
  prop_pnl, prop_img: double;
begin


  prop_pnl:=pnl_Img.Height/pnl_Img.Width;
  prop_img:=Image.Picture.Height/Image.Picture.Width;
  if prop_img<=prop_pnl then
  begin
    Image.Left:=2;
    Image.Width:=pnl_img.Width-4;
    Image.Height:=Round(prop_img*pnl_Img.Width)-2;
    Image.Top:=((pnl_Img.Height-Image.Height) div 2)-2;
  end else
  begin
    Image.Top:=2;
    Image.Height:=pnl_Img.Height-4;
    Image.Width:=Round(Image.Height/prop_img)-2;
    Image.Left:=((pnl_Img.Width-Image.Width) div 2)-2;
  end;
end;

procedure TFrame_picters.SetTyp(typ:integer);
begin
 F_typ:=typ;
 case f_typ of
  1: ds_main.DataSet:=F_DM.mem_maps;
  2: ds_main.DataSet:=F_DM.mem_before;
  3: ds_main.DataSet:=F_DM.mem_after;
 end;
 f_DM.SetTyp(F_typ);
 sp_del.Enabled:=(F_DM.Rec>0)and(not f_readOnly);

end;

procedure TFrame_picters.ClearImage(mes:string='');
begin
   Image.Picture:=nil;
 { Image.Canvas.Rectangle(0,0,Image.Width, Image.Height );}
 if mes<>'' then
 begin
   lb_mess.Caption:=mes;
   lb_mess.Visible:=true;
 end
else
begin
  lb_mess.Visible:=false;
   lb_mess.Caption:='';
end;

end;

procedure TFrame_picters.SetREadOnly(v:boolean);
begin
  f_readOnly:=v;
  sp_del.Enabled:=(not (v)) and (sp_del.Enabled);
  spb_add.Enabled:=not(v);
end;

procedure TFrame_picters.FrameResize(Sender: TObject);
begin
 MashtabImg;
end;

procedure TFrame_picters.Enabled(value:boolean);
begin
 DBNavigator1.Enabled:=value;
 if not F_readonly then
 begin
    spb_add.Enabled:=value and spb_add.Enabled;
    sp_del.Enabled:=value and sp_del.Enabled;
  end;


end;

end.
