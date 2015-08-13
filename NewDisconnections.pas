unit NewDisconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, ComCtrls, Grids,
  DBGrids, StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DisconnectionsDModule,
  DBCtrlsEh, ToolEdit, RXDBCtrl;

type
  Tfrm_DisconNew = class(Tfrm_BaseGrid)
    mem_Disconnections: TMemo;
    Label1: TLabel;
    dset_mainFK_ID_ORDER: TIntegerField;
    dset_mainFK_ID_STREET: TIntegerField;
    dset_mainHOUSES: TIBStringField;
    dset_mainADDITIONALINFO: TIBStringField;
    dset_mainlook_streets: TStringField;
    gb_DTTMExec: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    de_Discon: TDBDateEdit;
    de_Con: TDBDateEdit;
    te_Discon: TDBDateTimeEditEh;
    te_Con: TDBDateTimeEditEh;
    dbl_Executor: TRxDBLookupCombo;
    dbl_BrigConnect: TRxDBLookupCombo;
    dset_executor: TIBDataSet;
    ds_Executor: TDataSource;
    dset_Brig_connect: TIBDataSet;
    ds_Brig_connect: TDataSource;
    dset_mainDTTM_DISCON: TDateTimeField;
    dset_mainDTTM_CON: TDateTimeField;
    dset_mainFK_DISCON_EXECUTOR: TIntegerField;
    dset_mainFK_DISCON_BRIG_CONNECT: TIntegerField;
    dset_mainlook_discon_exec: TStringField;
    dset_mainlook_brig_connect: TStringField;
    bb_DisconTimeAll: TBitBtn;
    bb_ConnectTimeAll: TBitBtn;
    dset_tmp: TIBDataSet;
    Label2: TLabel;
    Label3: TLabel;
    te_Plan: TDBDateTimeEditEh;
    dset_mainDTTM_PLAN: TDateTimeField;
    de_Plan: TDBDateEdit;
   procedure btn_InsertClick(Sender: TObject);
   procedure btn_EditClick(Sender: TObject);       
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject;  var Action: TCloseAction);
   procedure btn_PostClick(Sender: TObject);
   procedure FormShow(Sender: TObject);
    procedure dset_mainCalcFields(DataSet: TDataSet);
    procedure mem_DisconnectionsChange(Sender: TObject);
    procedure bb_DisconTimeAllClick(Sender: TObject);
    procedure bb_ConnectTimeAllClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
  protected
    class function GetGUID: string; override;
    procedure EnableCtrls(value: boolean); override;
    procedure Enable_ConnectTimeAllFill;
    procedure EnableOpenCtrls(value: boolean);
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    { Private declarations }
    F_DateShift: TDate;
    F_ResultString: string;
    F_ReadOnlyFrm: boolean;
    F_OrderID: integer;
    F_RayonS: string;
    F_IsResStrChange: boolean;
    DM_Disconnection :TDM_Disconnect;

  public
    { Public declarations }
    property ResultString: string read F_ResultString write F_ResultString;
    property ReadOnlyFrm: boolean read F_ReadOnlyFrm write F_ReadOnlyFrm;
    property OrderID: integer read F_OrderID write F_OrderID;
    property RayonS: string read F_RayonS write F_RayonS;
    property DateShift: TDate write F_DateShift;
    procedure LoadData;
  end;

var
  frm_DisconNew: Tfrm_DisconNew;

implementation

{$R *.dfm}

uses AppGUIDS;

procedure Tfrm_DisconNew.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := false;
  EnableOpenCtrls(false);
end;

procedure Tfrm_DisconNew.EnableCtrls(value: boolean);
begin
//  mem_Disconnections.Enabled:=value;
  de_Discon.Enabled := value;
  de_Con.Enabled := value;
  de_Plan.Enabled := value;
  te_Discon.Enabled := value;
  te_Con.Enabled := value;
  te_Plan.Enabled := value;
  dbl_Executor.Enabled := value;
  dbl_BrigConnect.Enabled := value;
  bb_DisconTimeAll.Enabled := value;
//  bb_ConnectTimeAll.Enabled := value;
  inherited EnableCtrls(value);
end;

procedure  Tfrm_DisconNew.Enable_ConnectTimeAllFill;
begin
   //
   bb_ConnectTimeAll.Enabled := (btn_Insert.Enabled)
              and ( dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0 ) 
              and ( dset_main.FieldByName('DTTM_CON').AsDateTime > 0 );

end;

procedure Tfrm_DisconNew.EnableOpenCtrls(value: boolean);
begin
  mem_Disconnections.Enabled:=value;
end;



procedure Tfrm_DisconNew.FormClose (Sender: TObject;  var Action: TCloseAction);
begin
  inherited;

  //DM_Disconnection.Free;
end;

class function Tfrm_DisconNew.GetGUID: string;
begin
  //Result:=DISCONNECTGUID;
  Result:=BOLTSFORMGUID;
end;


procedure Tfrm_DisconNew.LoadData;
begin
    //
//  dset_main.ParamByName('orderid').AsInteger := F_OrderID ;
//  DM_Disconnection.OrderID := F_OrderID;
//  DM_Disconnection.RayonS := F_RayonS;
//  DM_Disconnection.ds_Disconnections.Open;
//  DM_Disconnection.ds_Disconnections.First;

end;

procedure Tfrm_DisconNew.btn_PostClick(Sender: TObject);
begin
inherited;
 ResultString:=mem_Disconnections.Text;
  EnableOpenCtrls(false);
  Enable_ConnectTimeAllFill;
end;


procedure Tfrm_DisconNew.FormShow(Sender: TObject);
begin
 inherited;
//  LoadData;
  dset_executor.Open;
  dset_Brig_connect.Open;


  mem_Disconnections.Text := ResultString;
  mem_Disconnections.ReadOnly  := ReadOnlyFrm;

  F_IsResStrChange := false;

  if mem_Disconnections.Enabled then
    mem_Disconnections.SetFocus;

  Enable_ConnectTimeAllFill;
//  bb_ConnectTimeAll.Enabled := btn_Insert.Enabled;
end;

procedure Tfrm_DisconNew.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_id_order').AsInteger:=F_OrderID;
  dset_Main.FieldByName('fk_id_street').AsInteger:=-1;
  dset_Main.FieldByName('DTTM_DISCON').AsDateTime := Int(Now);
  EnableOpenCtrls(true);
  bb_ConnectTimeAll.Enabled := false;
  dbl_Street.SetFocus;
end;

procedure Tfrm_DisconNew.btn_EditClick(Sender: TObject);
begin
  inherited btn_EditClick(Sender);
  EnableOpenCtrls(true);
  bb_ConnectTimeAll.Enabled := false;  
  dbl_Street.SetFocus;
end;

procedure Tfrm_DisconNew.dset_mainCalcFields(DataSet: TDataSet);
begin
  inherited;
 //DataSet.FieldByName('calc_rayon').AsString := F_RayonS;
end;

procedure Tfrm_DisconNew.mem_DisconnectionsChange(Sender: TObject);
begin
  inherited;
   // F_CtrlsChange := true;
end;



procedure Tfrm_DisconNew.bb_DisconTimeAllClick(Sender: TObject);
var _dttm_discon: TDatetime;
    _executor: integer;

     procedure GetLastValues(_IsInsert: boolean);
       begin
         //
         if dset_tmp.Active then dset_tmp.Close;
         dset_tmp.SelectSQL.Text := ' select di.id, di.DTTM_DISCON '+
                        ', di.FK_DISCON_EXECUTOR '+
                        '  from disconnections di '+
                        '  where di.fk_id_order = ' + IntToStr(F_OrderID)+
                        ' order by 1';
          dset_tmp.Open;
          dset_tmp.Last;
          if not _IsInsert then dset_tmp.Prior;
          _dttm_discon := dset_tmp.FieldByName('DTTM_DISCON').AsDateTime;
          _executor := dset_tmp.FieldByName('FK_DISCON_EXECUTOR').AsInteger;
          dset_tmp.Close;

       end;

begin
  inherited;
//
    if (dset_main.State <> dsEdit)or(dset_main.State <> dsInsert) then dset_main.Edit;
    if dset_main.State = dsInsert then GetLastValues(true);
    if dset_main.State = dsEdit then GetLastValues(false);
    dset_main.FieldByName('DTTM_DISCON').AsDateTime :=  _dttm_discon;
    dset_main.FieldByName('FK_DISCON_EXECUTOR').AsInteger :=  _executor;
    dset_main.Post;

   CtrlsChange(nil);
   if dset_main.State <> dsEdit then dset_main.Edit;
end;

procedure Tfrm_DisconNew.bb_ConnectTimeAllClick(Sender: TObject);
var _dttm_connect: TDatetime;
    _executor: integer;
    _dttm_plan: TDatetime;
begin
  inherited;
//
//  dset_main.First; // тиражируем значение ПЕРВОЙ записи
  _dttm_connect := dset_main.FieldByName('DTTM_CON').AsDateTime;
  _executor := dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger;
  _dttm_plan := dset_main.FieldByName('DTTM_PLAN').AsDateTime;

    if (not IsDateCorrect) and (not IsDataFieldsCorrect) then exit;

      dset_main.First; // тиражируем значение ТЕКУЩЕЙ записи
      while not dset_main.Eof do
      begin
        if dset_main.State <> dsEdit then dset_main.Edit;
        dset_main.FieldByName('DTTM_CON').AsDateTime :=  _dttm_connect;
        dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger :=  _executor;
        dset_main.FieldByName('DTTM_PLAN').AsDateTime :=  _dttm_plan;
        dset_main.Post;
        dset_main.Next;
      end;
      if dset_main.State <> dsEdit then dset_main.Edit;
      CtrlsChange(nil);
      EnableCtrls(true);
      EnableOpenCtrls(true);
      EnableChngBtns;
      bb_ConnectTimeAll.Enabled := false;


end;

function Tfrm_DisconNew.IsDateCorrect: boolean;
var _dttm_connect, _dttm_discon, _dttm_nextshift: TDatetime;
    _dttm_plan: TDatetime;
    _res:boolean;
begin
   //
   _res := true;
   _dttm_nextshift := F_DateShift + 1 + StrToTime('08:00:00');
   _dttm_connect := dset_main.FieldByName('DTTM_CON').AsDateTime;
   _dttm_discon := dset_main.FieldByName('DTTM_DISCON').AsDateTime;
   _dttm_plan := dset_main.FieldByName('DTTM_PLAN').AsDateTime;

   if ((_dttm_connect = 0) and ( dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0))
     then
        begin
          MessageDlg('Проверьте дату включения или нажмите "Отменить"', mtError, [mbOk], 1);
          _res := false;
        end;

   if ((_dttm_connect > 0) and ( _dttm_discon >  _dttm_connect))
         // and  (dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0)
     then
        begin
          MessageDlg('Дата включения должна быть больше даты отключения', mtError, [mbOk], 1);
          _res := false;
        end;

   if ((_dttm_connect >= _dttm_nextshift))
     then
        begin
          MessageDlg('Время включения должно соответствовать дате смены ', mtError, [mbOk], 1);
          _res := false;
        end;

   if ( _dttm_connect > Now)
     then
        begin
          MessageDlg('Время включения больше текущей даты ', mtError, [mbOk], 1);
          _res := false;
        end;

   if ((_dttm_discon >= _dttm_nextshift))
     then
        begin
          MessageDlg('Время выключения должно соответствовать дате смены ', mtError, [mbOk], 1);
          _res := false;
        end;

   if ( _dttm_discon > Now)
     then
        begin
          MessageDlg('Время выключения больше текущей даты ', mtError, [mbOk], 1);
          _res := false;
        end;

 Result := _res;
end;

function Tfrm_DisconNew.IsDataFieldsCorrect: boolean;
var _res: boolean;
begin
  //
  _res := false;
  if dset_main.FieldByName('FK_DISCON_EXECUTOR').AsInteger >0 then _res := true
   else
    begin
      MessageDlg('Не введён исполнитель отключения', mtError, [mbOk], 1);
      _Res := false;
    end;
 if _res then
  if  ((dset_main.FieldByName('DTTM_CON').AsDateTime = 0)
        or (dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0)) then _res:= true
        else
          begin
          MessageDlg('Не введён ответственный за включение', mtError, [mbOk], 1);          
          _res:= false;
          end;
  Result:= _res;

end;

procedure Tfrm_DisconNew.btn_CancelClick(Sender: TObject);
var BMark: string;
begin
  inherited;
  Tr_main.RollbackRetaining;
  BMark:=dset_Main.Bookmark;
  dset_Main.Close;
  dset_Main.Open;
  dset_Main.Bookmark:=BMark;
  Enable_ConnectTimeAllFill;

end;

procedure Tfrm_DisconNew.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
 Enable_ConnectTimeAllFill;
end;

end.
