unit NewDisconnections2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, ComCtrls, Grids,
  DBGrids, StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DisconnectionsDModule,
  DBCtrlsEh, ToolEdit, RXDBCtrl, RxDBComb,  workSQL;
const str_add_ppr='Создать ППР';
      str_delete_ppr='Удалить ППР';

type
  state_ppr=(add,delete);
  Tfrm_DisconNew2 = class(Tfrm_BaseGrid)
    mem_Disconnections: TMemo;
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
    Label5: TLabel;
    dset_house_type: TIBDataSet;
    dset_house_typeID: TIntegerField;
    dset_house_typeNAME: TIBStringField;
    dset_house_typeID_1562: TIntegerField;
    ds_house_type: TDataSource;
    dset_addfields: TIBDataSet;
    dset_addfieldsFK_DISKON_ADDINFO_DISCON: TIntegerField;
    dset_addfieldsHOUSE1: TIBStringField;
    dset_addfieldsHOUSE2: TIBStringField;
    dset_addfieldsID_SIDE: TIntegerField;
    dset_addfieldsFK_DISKON_ADDINFO_WORK: TIntegerField;
    dset_addfieldsWORKS: TIBStringField;
    ds_AddFields: TDataSource;
    dset_mainID: TIntegerField;
    dset_addfieldsFK_ID_HOUSE_TYPE: TIntegerField;
    tran_add: TIBTransaction;
    grbox_addinfo: TGroupBox;
    rdbl_discon_type: TRxDBLookupCombo;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dbn_g_zhd: TDBNumberEditEh;
    dbn_g_pod: TDBNumberEditEh;
    dset_discon_type: TIBDataSet;
    ds_discon_type: TDataSource;
    dset_addfieldsFK_DISKON_TYPE: TSmallintField;
    dset_addfieldsCOL_HOUSE: TIntegerField;
    dset_addfieldsCOL_POD: TIntegerField;
    dset_mainG_ZHD: TIntegerField;
    dset_mainG_POD: TIntegerField;
    dset_mainID_SIDE: TIntegerField;
    dset_mainFK_ID_HOUSES_TYPE: TIntegerField;
    dset_mainFK_ID_DISKON_TYPE: TIntegerField;
    dset_mainWORKS: TIBStringField;
    dset_mainHOUSE2: TIBStringField;
    Label18: TLabel;
    DBN_G_stoy: TDBNumberEditEh;
    dset_mainG_STOJ: TIntegerField;
    Create_PPr: TBitBtn;
    dset_mainISPPR: TIBStringField;
    dset_mainID_PPR: TIntegerField;
    dset_mainID2: TIntegerField;
    lbl_PPr: TLabel;
    dset_mainISPRIVATESEC: TSmallintField;
    cb_privSec: TCheckBox;
    dset_mainHOUSE1: TIBStringField;
    Label1: TLabel;
    Label4: TLabel;
    dset_mainG_ATG: TIntegerField;
    dset_mainGOR_VOD: TSmallintField;
    Label7: TLabel;
    db_G_ATG: TDBNumberEditEh;
    cb_isGOr_VOD: TCheckBox;
    dset_mainIsPrivateCalc: TStringField;
    dset_mainGOR_VODCalc: TStringField;
    dset_mainlook_discon_type: TStringField;
    dset_mainWEAK_PRESS: TSmallintField;
    cb_weak_press: TCheckBox;
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
    procedure ed_HouseNumChange(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure Create_PPrClick(Sender: TObject);
    procedure de_PlanChange(Sender: TObject);
    procedure de_ConChange(Sender: TObject);
    procedure dset_mainAfterOpen(DataSet: TDataSet);
    procedure dset_mainBeforePost(DataSet: TDataSet);
    procedure cb_isGOr_VODClick(Sender: TObject);
    procedure cb_privSecClick(Sender: TObject);
    procedure cb_weak_pressClick(Sender: TObject);
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
    F_IDREgion:integer; //для ппр
    isDateEndchange:integer; //для ппр
    st_ppr:state_ppr;
    procedure InitVocDsetList; override;
    procedure INitBtnCreatePPr();
    procedure cbClick(cb:TCheckBox; fieldname:string);
  public
    { Public declarations }
    property ResultString: string read F_ResultString write F_ResultString;
    property ReadOnlyFrm: boolean read F_ReadOnlyFrm write F_ReadOnlyFrm;
    property OrderID: integer read F_OrderID write F_OrderID;
    property RayonS: string read F_RayonS write F_RayonS;
    property DateShift: TDate write F_DateShift;
    procedure LoadData;
    property IDREgion:integer write F_IDREgion;
  end;

var
  frm_DisconNew2: Tfrm_DisconNew2;

implementation

{$R *.dfm}

uses AppGUIDS,StringConsts;

procedure Tfrm_DisconNew2.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsResStrChange := false;
  isDateEndchange:=0;
  EnableOpenCtrls(false);
end;

procedure Tfrm_DisconNew2.EnableCtrls(value: boolean);
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






  rdbl_discon_type.Enabled:=value;
  dbn_g_zhd.Enabled:=value;
  dbn_g_pod.Enabled:=value;

  DBN_G_stoy.Enabled:=value;
  if dset_main.IsEmpty then
   Create_PPr.Caption:=str_add_ppr
  else
   if dset_main.FieldByName('id_ppr').IsNull then
    Create_PPr.Caption:=str_add_ppr
   else
     Create_PPr.Caption:=str_delete_ppr;

  Create_PPr.Enabled:=(not value) and (not dset_main.IsEmpty);
  cb_privSec.Enabled:=value;
  cb_isGOr_VOD.Enabled:=value;
  db_G_ATG.Enabled:=value;
  cb_weak_press.Enabled:=value;
  inherited EnableCtrls(value);
end;

procedure  Tfrm_DisconNew2.Enable_ConnectTimeAllFill;
begin
   //
   bb_ConnectTimeAll.Enabled := (btn_Insert.Enabled)
              and ( dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger > 0 )
              and ( dset_main.FieldByName('DTTM_CON').AsDateTime > 0 );

end;

procedure Tfrm_DisconNew2.EnableOpenCtrls(value: boolean);
begin
///  mem_Disconnections.Enabled:=value;
 mem_Disconnections.ReadOnly:= not value;
end;



procedure Tfrm_DisconNew2.FormClose (Sender: TObject;  var Action: TCloseAction);
begin
  inherited;

  //DM_Disconnection.Free;
end;

class function Tfrm_DisconNew2.GetGUID: string;
begin
  //Result:=DISCONNECTGUID;
  Result:=BOLTSFORMGUID;
end;


procedure Tfrm_DisconNew2.LoadData;
begin
    //
//  dset_main.ParamByName('orderid').AsInteger := F_OrderID ;
//  DM_Disconnection.OrderID := F_OrderID;
//  DM_Disconnection.RayonS := F_RayonS;
//  DM_Disconnection.ds_Disconnections.Open;
//  DM_Disconnection.ds_Disconnections.First;

end;

procedure Tfrm_DisconNew2.btn_PostClick(Sender: TObject);
var BKMARK:string;
    isChMSSQL:boolean;
    newDate:TDateTime;
begin
 isChMSSQL:=false;
 if  not  dset_main.FieldByName('id_ppr').IsNull then
 if dset_main.State=dsEdit then
 begin
  if isDateEndchange=1 then
     begin
      isChMSSQL:=true;
      newDate:=dset_main.fieldbyname('dttm_Plan').AsDateTime;
     end;
  if isDateEndchange=2 then
    begin
     isChMSSQL:=true;
     newDate:=dset_main.fieldbyname('dttm_Con').AsDateTime;
    end;
 end;
 inherited;
 ResultString:=mem_Disconnections.Text;
  EnableOpenCtrls(false);
  Enable_ConnectTimeAllFill;
  if dset_main.FieldByName('G_ZHD').AsInteger=0 then
    ProcessStatus:='Не введено кол-во домов!!!';
  {$ifdef PPr}
  if F_Saved then
  begin
  try
  if isChMSSQL then
     dm_workSQL.UPDatePPr(newDate,dset_main.fieldbyname('FK_ID_ORDER').AsInteger,
                             dset_main.fieldbyname('ID_PPR').AsInteger);
  except on e:exception do
     Application.MessageBox(PAnsiChar('Ошибка изменения ПППР MSSQL'+#13+e.Message),gc_strDispAVR,mb_IConError+mB_OK);
  end;
  isDateEndchange:=0;
  end;
  {$endif}
  { try
   if (dset_addfields.State <> dsBrowse) then
   begin
    if dset_addfields.FieldByName('FK_DISKON_ADDINFO_DISCON').IsNull then
     dset_addfields.FieldByName('FK_DISKON_ADDINFO_DISCON').asinteger:=dset_main.fieldbyname('id').asinteger;
     dset_addfields.FieldByName('FK_ID_ORDER').AsInteger:=F_OrderID;
    dset_addfields.Post;
   end;
  except
    on E:Exception do
    begin
      Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
      Tr_Main.RollbackRetaining;
      dset_addfields.Close;
      dset_addfields.Open;
      dset_addfields.Locate('FK_DISKON_ADDINFO_DISCON',dset_main.fieldbyname('id').asinteger,[loCaseInsensitive]);
      //Raise;
      exit;
    end;
  end;
  tran_add.CommitRetaining;
  BKMARK:=dset_addfields.Bookmark;
  dset_addfields.Close;
  dset_addfields.Open;
  dset_addfields.Bookmark:=BKMARK;
  }


end;


procedure Tfrm_DisconNew2.FormShow(Sender: TObject);
begin


 {if Tran_ADd.InTransaction then
    TRan_add.Rollback;
  TRan_add.StartTransaction;

  dset_addfields.ParamByName('porderid').AsInteger:=F_OrderID;
  dset_addfields.Open;}
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

 { dset_addfields.Locate('FK_DISKON_ADDINFO_DISCON',dset_main.fieldbyname('id').AsInteger,[loCaseInsensitive]);}
  INitBtnCreatePPr();
  lbl_PPr.Visible:=(dset_main.FieldByName('id_ppr').AsInteger>0);
end;

procedure Tfrm_DisconNew2.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_id_order').AsInteger:=F_OrderID;
  dset_Main.FieldByName('fk_id_street').AsInteger:=-1;
  dset_Main.FieldByName('DTTM_DISCON').AsDateTime := Int(Now);
  //доп поля
 dset_Main.FieldByName('id_side').AsInteger:=1;
 dset_Main.FieldByName('FK_ID_HOUSES_TYPE').AsInteger:=1;
 dset_main.FieldByName('FK_ID_DISKON_TYPE').AsInteger:=7;
 EnableOpenCtrls(true);
 bb_ConnectTimeAll.Enabled := false;
 dbl_Street.SetFocus;
 dset_main.FieldByName('ISPRIVATESEC').AsInteger:=0;
 dset_main.FieldByName('GOR_VOD').AsInteger:=0;
 { dset_addFields.Insert;}
end;

procedure Tfrm_DisconNew2.btn_EditClick(Sender: TObject);
begin
  inherited btn_EditClick(Sender);
  EnableOpenCtrls(true);
  bb_ConnectTimeAll.Enabled := false;
  dbl_Street.SetFocus;
{  dset_addfields.Edit;}
end;

procedure Tfrm_DisconNew2.dset_mainCalcFields(DataSet: TDataSet);
begin
  inherited;
 //DataSet.FieldByName('calc_rayon').AsString := F_RayonS;
 if (DataSet.FieldByName('ISPRIVATESEC').AsInteger>0) then
  DataSet.FieldByName('IsPrivateCalc').AsString:='Да'
 else
   DataSet.FieldByName('IsPrivateCalc').AsString:='';
 if (DataSet.FieldByName('GOR_VOD').AsInteger = 1 ) then
   DataSet.FieldByName('GOR_VODCalc').AsString:='Есть'
 else
   DataSet.FieldByName('GOR_VODCalc').AsString:='Нет';



end;

procedure Tfrm_DisconNew2.mem_DisconnectionsChange(Sender: TObject);
begin
  inherited;
   // F_CtrlsChange := true;
end;



procedure Tfrm_DisconNew2.bb_DisconTimeAllClick(Sender: TObject);
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

procedure Tfrm_DisconNew2.bb_ConnectTimeAllClick(Sender: TObject);
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
        if (dset_main.FieldByName('DTTM_CON').IsNull) then begin
          dset_main.FieldByName('DTTM_CON').AsDateTime :=  _dttm_connect;
          dset_main.FieldByName('FK_DISCON_BRIG_CONNECT').AsInteger :=  _executor;
          dset_main.FieldByName('DTTM_PLAN').AsDateTime :=  _dttm_plan;
          dset_main.Post;
        end;
        dset_main.Next;
      end;
      if dset_main.State <> dsEdit then dset_main.Edit;
      CtrlsChange(nil);
      EnableCtrls(true);
      EnableOpenCtrls(true);
      EnableChngBtns;
      bb_ConnectTimeAll.Enabled := false;


end;

function Tfrm_DisconNew2.IsDateCorrect: boolean;
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

function Tfrm_DisconNew2.IsDataFieldsCorrect: boolean;
var _res: boolean;
begin
  //   {нужно дописать проверки}
  _res := false;
  if dset_main.FieldByName('FK_ID_STREET').IsNull then
  begin
     MessageDlg('Нужно ввести улицу!', mtError, [mbOk], 1);
      _Res := false;
     dbl_Street.SetFocus;
  end
  else
  _REs:=true;
  if _Res then
  if length(trim(dset_main.FieldByName('houses').AsString))>64 then
   begin
     MessageDlg('Поле №дома не больше 64 символов!', mtError, [mbOk], 1);
      _Res := false;
     ed_HouseNum.SetFocus;
   end
   else
    _REs:=true;
  if _REs then
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
  if not dset_main.FieldByName('G_ZHD').IsNull  then
     if dset_main.FieldByName('G_ZHD').AsInteger=0 then
       ProcessStatus:='Не введено кол-во домов!!';
  if dset_main.FieldByName('G_ZHD').IsNull then
    ProcessStatus:='Не введено кол-во домов!!';

end;

procedure Tfrm_DisconNew2.btn_CancelClick(Sender: TObject);
var BMark: string;
begin
  inherited;
  Tr_main.RollbackRetaining;
  BMark:=dset_Main.Bookmark;
  dset_Main.Close;
  dset_Main.Open;
  dset_Main.Bookmark:=BMark;
  Enable_ConnectTimeAllFill;
{  BMark:=dset_addfields.Bookmark;
 dset_addfields.Close;
 dset_addfields.Open;
 dset_addfields.Bookmark:=BMark;}

end;

procedure Tfrm_DisconNew2.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Enable_ConnectTimeAllFill;
 { if (not  dset_addfields.IsEmpty) and(dset_addfields.State=dsBrowse) then
  dset_addfields.Locate('FK_DISKON_ADDINFO_DISCON',dset_main.fieldbyname('id').AsInteger,[loCaseInsensitive]);}
  INitBtnCreatePPr();
  lbl_PPr.Visible:=(dset_main.FieldByName('id_ppr').AsInteger>0);
  cb_isGOr_VOD.Checked:=(dset_main.FieldByName('Gor_VOD').AsInteger=1);
  cb_privSec.Checked:=(dset_main.FieldByName('ISPRIVATESEC').AsInteger=1);
  cb_weak_press.Checked:=(dset_main.FieldByName('WEAK_PRESS').AsInteger=1);
end;

procedure Tfrm_DisconNew2.InitVocDsetList;
begin
 inherited;
  F_VocDsetList.Add(dset_house_type);
  F_VocDsetList.Add(dset_discon_type);
end;

procedure Tfrm_DisconNew2.ed_HouseNumChange(Sender: TObject);
begin
  inherited;
CtrlsChange(Sender);
{if dset_addFields.FieldByName('house1').IsNull then
  dset_addFields.FieldByName('house1').AsString:=dset_main.fieldbyname('houses').AsString;}
end;

procedure Tfrm_DisconNew2.btn_DeleteClick(Sender: TObject);
var id_ppr:integer;

begin
  id_ppr:=dset_main.FieldByName('id_ppr').AsInteger;
  inherited;
  {$ifdef PPR}
  if F_IsDeleted then
  try
   if id_ppr>0  then
    begin
      dm_WorkSQL.DeletePPr(F_OrderID,id_ppr)

    end;
  except on e:exception do
    Application.MessageBox(PChar(e.message),gc_strDispAVR, MB_OK+MB_ICONERROR);

  end ;
  {$endif}
  F_IsDeleted:=false;
{if F_IsDeleted then
begin
 dset_addfields.Delete;
 F_IsDeleted:=false;
 Tran_add.CommitRetaining;
end;}
end;

procedure Tfrm_DisconNew2.Create_PPrClick(Sender: TObject);
var _res:boolean;
     BMark:string;
     idPPr:integer;
begin
  inherited;
{$ifdef PPR}
try
 Cursor:=crHourGlass;
 if st_ppr=add then
 begin
  if dset_main.FieldByName('dttm_plan').IsNull then
  begin
   MessageDlg('Чтобы создать ППР нужно вести план дату включения!!', mtError, [mbOk], 1);
   exit;
  end;
  try
    idppr:=dm_workSQL.CreatePPr(  dset_main.fieldbyname('DTTM_Discon').AsDateTime,
    dset_main.fieldbyname('DTTM_PLan').AsDateTime,
    dset_discon_type.fieldbyname('id_1562').AsInteger,
    dset_main.fieldbyname('FK_ID_STREET').AsInteger,
    trim(dset_main.fieldbyname('houses').AsString),
//    trim(dset_main.fieldbyname('house2').AsString),
    dset_main.fieldbyname('ID_SIDE').AsInteger+24, //строна невыбрано 24 четная 25 нечетная 26
    29, //direction 29-NS
     dset_house_type.fieldbyname('id_1562').AsInteger,
    '','',//лдя НС нет этажа  подъезда,
    dset_main.fieldbyname('G_STOJ').AsString,
    dset_main.fieldbyname('G_ZHD').AsString,
    dset_main.fieldbyname('G_Pod').AsString,
    dset_main.fieldbyname('works').AsString,
    F_OrderID,
    dset_main.fieldbyname('id2').asinteger,
    F_IDREgion
   );

  except on e:exception do begin
    Application.MessageBox('Ошибка при создании ППР MSSQL ',gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
    end;
  end;
  if idppr>0 then
  try
   BMark:=dset_main.Bookmark;
   if dset_Main.Eof and dset_Main.Bof then exit;
    dset_Main.Edit;
   dset_main.FieldByName('isppr').AsString:='1';
   dset_main.FieldByName('id_ppr').AsInteger:=idppr;
   dset_Main.Post;
   Tr_Main.CommitRetaining;
   BMark:=dset_Main.Bookmark;
   dset_Main.Close;
   dset_Main.Open;
   dset_Main.Bookmark:=BMark;
   Application.MessageBox('ППР создан!',gc_strDispAVR, MB_OK);
  except
    on E:Exception do
    begin
      Application.MessageBox('Ошибка при создании ППР FireBird!!', gc_strDispAVR, MB_OK+MB_ICONERROR);
      Tr_Main.RollbackRetaining;
      dset_Main.Close;
      dset_Main.Open;
      dset_main.Bookmark:=BMark;
      //Raise;
      _REs:=false;
      exit;
    end;
  end;
end
else
 begin
 if   Application.MessageBox('Удалить ППР? ',gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)=IDYES then
 begin
  {$ifdef PPR}
  try
    dm_worksql.DeletePPr(F_OrderID,dset_main.fieldbyname('id_ppr').AsInteger);
  except on e:exception do
   begin
    Application.MessageBox(PChar(e.Message+#13+'Ошибка при удалении ППР MSSQL!!'), gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
   end;
  end;
  {$endif}
  try
   BMark:=dset_main.Bookmark;
   if dset_Main.Eof and dset_Main.Bof then exit;
   dset_Main.Edit;
   dset_main.FieldByName('id_ppr').AsVariant:=null;
//   dset_main.FieldByName('idppr').AsVariant:=null;
   dset_Main.Post;
   Tr_Main.CommitRetaining;
   BMark:=dset_Main.Bookmark;
   dset_Main.Close;
   dset_Main.Open;
   dset_Main.Bookmark:=BMark;
  except on e:exception do
   begin
    Application.MessageBox(PChar(e.Message+#13+'Ошибка при удалении ППР FireBird!!'), gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
   end;
  end;
 end;
end;
finally
begin
 Cursor:=crDefault;
 INitBtnCreatePPr;
 lbl_PPr.Visible:=(dset_main.FieldByName('id_ppr').AsInteger>0);

end;
end;
{$endif}
end;

procedure Tfrm_DisconNew2.de_PlanChange(Sender: TObject);
begin
  inherited;
 CtrlsChange(Sender);
 if 1>isDateEndchange then
 isDateEndchange:=1; //change dttm_plan
end;

procedure Tfrm_DisconNew2.de_ConChange(Sender: TObject);
begin
  inherited;
  CtrlsChange(Sender);
  isDateEndchange:=2; //change dttm_Con

end;

procedure Tfrm_DisconNew2.INitBtnCreatePPr();
begin
  if dset_main.IsEmpty then
   Create_PPr.Caption:=str_add_ppr
  else
   if dset_main.FieldByName('id_ppr').IsNull then
   begin
    Create_PPr.Caption:=str_add_ppr;
    st_ppr:=add;
   end
   else
   begin
     Create_PPr.Caption:=str_delete_ppr;
     st_ppr:=delete;
   end;

  Create_PPr.Enabled:=(not dset_main.IsEmpty);

end;

procedure Tfrm_DisconNew2.dset_mainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cb_privSec.Checked:= (DataSet.FieldByName('ISPRIVATESEC').AsInteger=1);
  cb_isGOr_VOD.Checked:=(DataSet.FieldByName('GOR_VOD').AsInteger=1);
  cb_weak_press.Checked:=(DataSet.FieldByName('WEAK_PRESS').AsInteger=1);
end;

procedure Tfrm_DisconNew2.dset_mainBeforePost(DataSet: TDataSet);
begin
  inherited;
  if  cb_privSec.Checked then
   DataSet.FieldByName('ISPRIVATESEC').AsInteger:=1
  else
   DataSet.FieldByName('ISPRIVATESEC').AsVariant:=null;
  if  cb_isGOr_VOD.Checked then
    DataSet.FieldByName('GOR_VOD').AsInteger:=1
   else
     DataSet.FieldByName('GOR_VOD').AsVariant:=null;

end;

procedure Tfrm_DisconNew2.cb_isGOr_VODClick(Sender: TObject);
begin
 inherited;

if (dset_main.State in  [dsEdit, dsInsert]) then
 begin
  CtrlsChange(Sender);
if cb_isGOr_VOD.Checked then
  dset_main.FieldByName('GOR_VOD').AsInteger:=1
else
   dset_main.FieldByName('GOR_VOD').AsVariant:=null;

 end;
end;

procedure Tfrm_DisconNew2.cb_privSecClick(Sender: TObject);
begin

inherited;

if (dset_main.State in  [dsEdit, dsInsert]) then
begin
CtrlsChange(Sender);
if cb_privSec.Checked then
   dset_main.FieldByName('ISPRIVATESEC').AsInteger:=1
 else
  dset_main.FieldByName('ISPRIVATESEC').AsVariant:=null;
end;

end;

procedure Tfrm_DisconNew2.cbClick(cb:TCheckBox; fieldname:string);
begin
 if (ds_main.State in [dsEdit, dsInsert]) then
 begin
  CtrlsChange(cb);
  if cb.Checked then
   dset_main.FieldByName(fieldname).AsInteger:=1
 else
    dset_main.FieldByName(fieldname).AsVariant:=null;
end;


end;

procedure Tfrm_DisconNew2.cb_weak_pressClick(Sender: TObject);
begin
  inherited;
  cbClick(cb_weak_press,'weak_press');
end;

end.
