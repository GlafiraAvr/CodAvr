unit FloodingEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FloodingEditDModule, AddOrderInfoForm, StdCtrls, Buttons,
  DBCtrls, DB, ExtCtrls, WarningForm;

type

  Tfrm_Flooding = class(Tfrm_AddOrderInfo)
    ds_main: TDataSource;
    DBM_About: TDBMemo;
    btn_post: TBitBtn;
    btn_Cansel: TBitBtn;
    btn_exit: TBitBtn;
    btn_Delete: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btn_postClick(Sender: TObject);
    procedure btn_CanselClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure ds_mainDataChange(Sender: TObject; Field: TField);
    procedure DBM_AboutKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    F_dM:Tdm_Flooding;
    f_readOnly:boolean;
    F_order_Id:integer;

    procedure SetREadOnly(val:boolean);
  public

    { Public declarations }
    property PreadOnly:boolean read F_readOnly write F_readOnly;
    property Order_Id :integer write  F_order_Id;
  end;

var
  frm_Flooding: Tfrm_Flooding;

implementation

{$R *.dfm}

procedure Tfrm_Flooding.SetREadOnly(val:boolean);
begin
 F_readOnly:=val;
 DBM_About.ReadOnly:=val;
 btn_Delete.Enabled:=not val;
end;


procedure Tfrm_Flooding.btn_postClick(Sender: TObject);
begin
  inherited;
if  length(trim(ds_main.DataSet.FieldByName('about').AsString))>0 then
    ds_main.DataSet.Post
else
  ds_main.DataSet.Cancel;
 btn_Delete.Enabled:= (not ds_main.DataSet.IsEmpty);
 
end;

procedure Tfrm_Flooding.btn_CanselClick(Sender: TObject);
begin
  inherited;
   ds_main.DataSet.Cancel;
    btn_Delete.Enabled:= (not ds_main.DataSet.IsEmpty);

end;

procedure Tfrm_Flooding.btn_DeleteClick(Sender: TObject);
begin
  inherited;
  ds_main.DataSet.Delete;
  btn_Delete.Enabled:= (not ds_main.DataSet.IsEmpty);
end;

procedure Tfrm_Flooding.FormCreate(Sender: TObject);
begin
  inherited;
    F_dM:=Tdm_Flooding.Create(self);
    ds_main.DataSet:=F_DM.dset_Main;
    F_readOnly:=true;
end;

procedure Tfrm_Flooding.FormShow(Sender: TObject);
begin
  inherited;
if F_order_Id<>0 then
begin
  F_DM.Order_id:=F_order_Id;
  F_DM.OpenDset;
  SetREadOnly(F_readOnly);
  btn_Delete.Enabled:= (not ds_main.DataSet.IsEmpty) and  (not F_readOnly);
end
else
begin
 btn_post.Enabled:=false;
 btn_Cansel.Enabled:=false;
 btn_Delete.Enabled:=false;
end;
end;



procedure Tfrm_Flooding.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
if ds_main.State<>dsbrowse then
  case ShowWarningDlg of
        raSave: ds_main.DataSet.Post;

        raNoSave:;
      else
        begin
          Action:=caNone;
          exit;
        end;
      end; //end case

end;

procedure Tfrm_Flooding.FormDestroy(Sender: TObject);
begin
  inherited;
   F_DM.Free;
end;

procedure Tfrm_Flooding.btn_exitClick(Sender: TObject);
begin
  inherited;
Close;
end;

procedure Tfrm_Flooding.ds_mainDataChange(Sender: TObject; Field: TField);
begin
  inherited;
    if ds_main.State <>dsBrowse then
   begin
    btn_Post.Enabled:=true;
    btn_Cansel.Enabled:=true;
   end
   else
   begin
    btn_Post.Enabled:=false;
    btn_Cansel.Enabled:=false;
   end
end;

procedure Tfrm_Flooding.DBM_AboutKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
 if (ds_main.DataSet.State=dsBrowse)and (not F_REadOnly) then
 begin
     if (ds_main.DataSet.IsEmpty) then
         ds_main.DataSet.Append
     else
         ds_main.DataSet.Edit;
  btn_Post.Enabled:=true;
  btn_Cansel.Enabled:=true;
 end; 
end;

end.
