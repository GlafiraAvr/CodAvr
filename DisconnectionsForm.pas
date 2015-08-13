unit DisconnectionsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, AddOrderInfoForm, Grids, DBGrids,
  RXDBCtrl, DB, DisconnectionsDModule, DBNavPlus, DBCtrls, DBGridEh, Mask,
  RxLookup;

type
Tfrm_Disconnection = class(Tfrm_AddOrderInfo)
    pnl_btns: TPanel;
    btn_Exit: TBitBtn;
    ds_Disconnections: TDataSource;
    btn_AddWork: TBitBtn;
    btn_EditWork: TBitBtn;
    btn_DeleteWork: TBitBtn;
    btn_DeleteDep: TBitBtn;
    btn_Post: TBitBtn;
    btn_Cancel: TBitBtn;
    pnl_Top: TPanel;
    mem_Disconnections: TMemo;
    Label1: TLabel;
    pnl_Grid: TPanel;
    DBG_DisconnectionsEh: TDBGridEh;
    pAddAdr: TPanel;
    l_street: TLabel;
    l_house: TLabel;
    l_dop: TLabel;
    dbl_Street: TRxDBLookupCombo;
    ed_house: TDBEdit;
    ed_dop: TDBEdit;
    btn_ok: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddWorkClick(Sender: TObject);
    procedure btn_EditWorkClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DeleteWorkClick(Sender: TObject);
    procedure DBG_DisconnectionsEhKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mem_DisconnectionsChange(Sender: TObject);
    procedure ds_DisconnectionsStateChange(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    F_ResultString: string;
    F_ReadOnlyFrm: boolean;
    F_OrderID: integer;
    F_RayonS: string;
    F_IsResStrChange: boolean;
    DM_Disconnection :TDM_Disconnect;
  public
    property ResultString: string read F_ResultString write F_ResultString;
    property ReadOnlyFrm: boolean read F_ReadOnlyFrm write F_ReadOnlyFrm;
    property OrderID: integer read F_OrderID write F_OrderID;
    property RayonS: string read F_RayonS write F_RayonS;
    procedure LoadData;
  end;

implementation


{$R *.dfm}

uses EditDisconnectionsFormUnit;

procedure Tfrm_Disconnection.FormShow(Sender: TObject);
begin
  LoadData;

  mem_Disconnections.Text := ResultString;
  mem_Disconnections.ReadOnly  := ReadOnlyFrm;
  DBG_DisconnectionsEh.ReadOnly := F_ReadOnlyFrm;
  btn_AddWork.Enabled := not F_ReadOnlyFrm;
  btn_DeleteWork.Enabled := not F_ReadOnlyFrm;
  btn_Post.Enabled := not F_ReadOnlyFrm;

  F_IsResStrChange := false;

  if mem_Disconnections.Enabled then
    mem_Disconnections.SetFocus;
end;

procedure Tfrm_Disconnection.LoadData;
begin
    //
  DM_Disconnection.ds_Disconnections.ParamByName('orderid').AsInteger := F_OrderID ;
  DM_Disconnection.OrderID := F_OrderID;
  DM_Disconnection.RayonS := F_RayonS;
  DM_Disconnection.ds_Disconnections.Open;
  DM_Disconnection.ds_Disconnections.First;

end;

procedure Tfrm_Disconnection.btn_ExitClick(Sender: TObject);
begin
  Close();
end;

procedure Tfrm_Disconnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if F_IsResStrChange and ( not F_ReadOnlyFrm ) then
    if Application.MessageBox( 'Сохранить изменения?',
      'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES then
    begin
      btn_PostClick( nil );
    end;


  if (ds_Disconnections.DataSet.State = dsEdit)
    or (ds_Disconnections.DataSet.State = dsInsert) then
   ds_Disconnections.DataSet.Cancel;
  DM_Disconnection.tran.Rollback;
  //ResultString:=mem_Disconnections.Text;
  DM_Disconnection.ds_Disconnections.Close;
  DM_Disconnection.Free;
end;

procedure Tfrm_Disconnection.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := false;
  DM_Disconnection := TDM_Disconnect.Create( self );
end;

procedure Tfrm_Disconnection.btn_AddWorkClick(Sender: TObject);
var
  _frm: TEditDisconnectionsForm;
begin
  inherited;
//
  pAddAdr.Visible:=true;
  pnl_Top.Visible:=False;

     if ds_Disconnections.DataSet.State <> dsEdit then
      ds_Disconnections.DataSet.Insert;
 dbl_Street.SetFocus;

{  _frm := TEditDisconnectionsForm.Create( nil );
  try
     _frm.ed_house.DataSource:= ds_Disconnections;
     _frm.ed_dop.DataSource:= ds_Disconnections;
     _frm.dbl_Street.DataSource:= ds_Disconnections;
     if ds_Disconnections.DataSet.State <> dsEdit then
      ds_Disconnections.DataSet.Insert;
      _frm.ShowModal;
  finally
   _frm.free;
  end;}
end;

procedure Tfrm_Disconnection.btn_EditWorkClick(Sender: TObject);
var
  _frm: TEditDisconnectionsForm;
begin
  inherited;

  pAddAdr.Visible:=true;
  pnl_Top.Visible:=False;

 if ds_Disconnections.DataSet.State <> dsEdit then
  ds_Disconnections.DataSet.Edit;
 dbl_Street.SetFocus;
{  _frm := TEditDisconnectionsForm.Create( nil );
  try
     _frm.ed_house.DataSource:= ds_Disconnections;
     _frm.ed_dop.DataSource:= ds_Disconnections;
     _frm.dbl_Street.DataSource:= ds_Disconnections;
     if ds_Disconnections.DataSet.State <> dsEdit then
      ds_Disconnections.DataSet.Edit;
      _frm.ShowModal;
  finally
   _frm.free;
  end;
 }
end;

procedure Tfrm_Disconnection.btn_PostClick(Sender: TObject);
begin
  inherited;
 //
 if (ds_Disconnections.DataSet.State = dsEdit)
    or (ds_Disconnections.DataSet.State = dsInsert) then
   if ds_Disconnections.DataSet.FieldByName('fk_id_street').AsInteger > 0 then
     ds_Disconnections.DataSet.Post
   else ds_Disconnections.DataSet.Cancel;
 ds_Disconnections.DataSet.Close;
 DM_Disconnection.tran.Commit;
 ResultString:=mem_Disconnections.Text;
 DM_Disconnection.tran.StartTransaction;
 LoadData;

 F_IsResStrChange := false;
end;

procedure Tfrm_Disconnection.btn_CancelClick(Sender: TObject);
begin
  inherited;
 if (ds_Disconnections.DataSet.State = dsEdit)
    or (ds_Disconnections.DataSet.State = dsInsert) then
   ds_Disconnections.DataSet.Cancel;
end;

procedure Tfrm_Disconnection.btn_DeleteWorkClick(Sender: TObject);
begin
  inherited;

  if Application.MessageBox( 'Вы уверены, что хотите удалить данную запись?',
    'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES then
    ds_Disconnections.DataSet.Delete;
end;

procedure Tfrm_Disconnection.DBG_DisconnectionsEhKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

  procedure _SelBtn;
  begin
    if btn_Post.Enabled then btn_Post.SetFocus
    else  btn_Exit.SetFocus;
  end;
  
begin
  case Key of
    VK_TAB: _SelBtn;
  end;
end;

procedure Tfrm_Disconnection.mem_DisconnectionsChange(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := true;
end;


procedure Tfrm_Disconnection.ds_DisconnectionsStateChange(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := true;
end;


procedure Tfrm_Disconnection.btn_okClick(Sender: TObject);
begin
  inherited;
//
  ds_Disconnections.DataSet.Post;
  pAddAdr.Visible:=False;
  pnl_Top.Visible:=true;
end;

procedure Tfrm_Disconnection.BitBtn1Click(Sender: TObject);
begin
  inherited;
  ds_Disconnections.DataSet.Cancel;
  pAddAdr.Visible:=False;
  pnl_Top.Visible:=true;
end;

end.
