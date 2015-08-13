unit WorksRegionForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SecurityBaseForm, WorksRegionDModule, DB, StdCtrls, Buttons,
  ToolEdit, RXDBCtrl, Mask, DBCtrlsEh, RxLookup, DBCtrls, ComCtrls;

type
  state=(Browse , Edit );
  Tfrm_WorksRegions = class(Tfrm_SecurityBase)
    btn_Start: TButton;
    rdbl_Brig: TRxDBLookupCombo;
    dte_start: TDBDateTimeEditEh;
    dte_end: TDBDateTimeEditEh;
    GroupBox1: TGroupBox;
    de_sart: TDBDateEdit;
    de_end: TDBDateEdit;
    GroupBox2: TGroupBox;
    btn_End: TButton;
    btn_Cansel: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    ds_Brig: TDataSource;
    ds_main: TDataSource;
    dbt_name_user: TDBText;
    DBT_FK_name_CLOSEDUSED: TDBText;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_CanselClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdbl_BrigChange(Sender: TObject);
  private
    { Private declarations }
    Fk_Id_order:integer;
    fk_Id_region:integer;
    F_Dm:Tdm_WorkRegion;
    F_State:state;
    F_State_Begin:boolean;
    F_State_End:boolean;
    F_ReadOnly:boolean;
    F_StartDate:string;
    F_EndDate:string;
    F_IsClosed:integer;
    procedure Init();
    procedure SetSate_Begin(sbegin:boolean);
    procedure SetState_End(send:boolean);
    procedure SetState(ss:state);
    procedure SetStatus(str:string);

  public
     class function GetGUID: string; override;
    { Public declarations }
    property  State_Begin:boolean read F_State_Begin;  //16.09.2013 Glasha
//    property  State_End:boolean read F_State_End write SetState_Begin;


    constructor Create (AOwner: TComponent; id_order:integer; id_region:integer; is_closed:integer=0);
  end;
const vvod1='Начало работы';
      vvod2='Окончание работы';
      del1='Отказ';
      del2='Отказ';
      del='Удалить';
var
  frm_WorksRegions: Tfrm_WorksRegions;

implementation

{$R *.dfm}
uses GlobalData, AppGUIDS, RightsManagerDModule ;


constructor Tfrm_WorksRegions.Create(AOwner: TComponent;id_order:integer; id_region:integer; is_closed:integer);
begin
 inherited Create(AOwner);
 Fk_Id_order:=id_order;
 fk_Id_region:=id_region;
 F_IsClosed:=is_closed;

end;

class function Tfrm_WorksRegions.GetGUID: string;
begin
REsult:=WorksRegion;
end;

procedure Tfrm_WorksRegions.Init;
begin
  F_Dm.openDsets(fk_id_order,fk_Id_region);
  if  F_IsClosed=1 then
   F_readOnly:=true
  else
   F_readOnly:=not (IsCurrentUserCanEdit and IsCurrentDistrictCanAccessRegion(Fk_Id_Region));
  SetState(Browse);

  if not F_ReadOnly then
  begin

     SetSate_Begin(F_Dm.isData);
     SetState_End(F_Dm.IsBottomData);
  end
  else
  begin
    btn_Start.Enabled:=false;
    btn_End.Enabled:=false;
    rdbl_Brig.Enabled:=false;
  end;




end;

procedure Tfrm_WorksRegions.FormCreate(Sender: TObject);
begin
  inherited;
  F_Dm:=Tdm_WorkRegion.Create(Self);

end;

procedure Tfrm_WorksRegions.SetState(ss:state);
begin

 btn_save.Enabled:=(ss=Edit);
 btn_Cansel.Enabled:=btn_save.Enabled;
 //SetSate_Begin(F_Dm.isData);
 //SetState_End(F_Dm.IsBottomData);
 F_State:=ss;

end;

procedure Tfrm_WorksRegions.SetSate_Begin(sbegin:boolean); //Есть данные
begin
  rdbl_Brig.Enabled:=true;
  F_State_Begin:=sbegin;
  btn_Start.Enabled:=true;
  if sbegin then
  begin

    btn_Start.Caption:=Del1;
    btn_End.Enabled:=true;
  end
  else
   begin
    btn_Start.Caption:=vvod1;
    btn_End.Enabled:=false;
    rdbl_Brig.Enabled:=false;
   end;
end;

procedure  Tfrm_WorksRegions.SetState_End(send:boolean); //Ecnm данные
begin
 if F_State_Begin then
 begin

  F_State_End:=send;
  if send then
  begin
   btn_End.Caption:=Del2;
   rdbl_Brig.Enabled:=true;
   btn_Start.Enabled:=false;
  end
  else
  begin
    btn_End.Caption:=Vvod2;
    rdbl_Brig.Enabled:=true;
    btn_Start.Enabled:=true;
  end
 end ;

end;

procedure Tfrm_WorksRegions.FormDestroy(Sender: TObject);
begin
  inherited;
  F_Dm.Free;
end;

procedure Tfrm_WorksRegions.btn_StartClick(Sender: TObject);
begin
  inherited;
  SetStatus('');
  if not( F_State_Begin) then
   if F_DM.AddTop then
   begin
    de_sart.Date:=Now();
    dte_start.Text:=FormatDateTime('hh:mm:ss',Now());
    rdbl_Brig.Enabled:=true;
    SetState(Edit);
    btn_Start.Enabled:=false;
    rdbl_Brig.SetFocus;
   end
   else
    SetStatus(F_Dm.MyError)
  else
  begin
  if Application.MessageBox('Удалить запись?', '',MB_YESNO+MB_ICONQUESTION) =mrYes then
    if not f_Dm.DelTop then
      SetStatus(F_Dm.MyError)
    else
    begin
     SetSate_Begin(false );
      rdbl_Brig.Enabled:=false;
    end;

  end

end;

procedure  Tfrm_WorksRegions.SetStatus(str:string);
begin
  StatusBar.SimpleText:=str;
end;

procedure Tfrm_WorksRegions.btn_EndClick(Sender: TObject);
begin
  inherited;
   SetStatus('');
   if not F_State_End then
   begin
    if not  F_Dm.addBottom then
      SetStatus(F_Dm.MyError)
    else
      SetState_End(true);
   end
   else
    if Application.MessageBox('Удалить запись?', '',MB_YESNO+MB_ICONQUESTION) =mrYes then
     if not F_Dm.DellBottom then
      SetStatus(F_Dm.MyError)
     else
      SetState_End(false);
end;

procedure Tfrm_WorksRegions.btn_SaveClick(Sender: TObject);
begin
  inherited;
 if  F_Dm.PostMain then
 begin
   SetSate_Begin(true);
   SetState_End(F_Dm.IsBottomData);
   SetState(browse);
   SetStatus('Запись сохранена!');
 end
 else
  if F_Dm.F_IsNeedBrig then
   begin
    rdbl_Brig.SetFocus;
    SetStatus('Введите Бригадира!');
   end
  else
   SetStatus(F_Dm.MyError);
end;

procedure Tfrm_WorksRegions.btn_ExitClick(Sender: TObject);
begin
  inherited;
   if F_State=Edit then
   case   Application.MessageBox('Сохранить Данные?','',MB_YESNOCANCEL+MB_ICONQUESTION) of
      mrYes: begin btn_SaveClick(Self);{ exit;} end;
      mrNo:begin btn_CanselClick(self); {exit;} end;
      mrCancel:Exit;
   end;


  Close;
end;

procedure Tfrm_WorksRegions.btn_CanselClick(Sender: TObject);
begin
  inherited;
  F_Dm.RallBackMain;
  SetState(Browse);
  SetSate_Begin(f_Dm.isData);
  SetState_End(f_Dm.IsBottomData);
end;

procedure Tfrm_WorksRegions.FormShow(Sender: TObject);
begin
  inherited;
  Init();
end;

procedure Tfrm_WorksRegions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   F_DM.CloseAll;

end;

procedure Tfrm_WorksRegions.rdbl_BrigChange(Sender: TObject);
begin
  inherited;
  if F_Dm.Change then
   SetState(Edit)
  else
   SetStatus(F_Dm.MyError);

end;

end.
