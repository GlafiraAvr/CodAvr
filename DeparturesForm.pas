unit DeparturesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrlsEh, StdCtrls, Mask, ToolEdit, RXDBCtrl,
  RxLookup, DModule, IBDatabase, DB, IBCustomDataSet, BaseGridForm, Grids,
  DBGrids, Buttons, DBCtrls, ExtCtrls, IBSQL;


type
  Tfrm_Departures = class(Tfrm_BaseGrid)
    TabC: TTabControl;
    de_Start: TDBDateEdit;
    de_End: TDBDateEdit;
    dbl_Brig: TRxDBLookupCombo;
    te_Start: TDBDateTimeEditEh;
    te_End: TDBDateTimeEditEh;
    dset_Brig: TIBDataSet;
    ds_Brig: TDataSource;
    dset_mainID: TIntegerField;
    dset_mainSTARTDATE: TDateTimeField;
    dset_mainENDDATE: TDateTimeField;
    dset_mainFK_DEPARTURES_BRIGADIERS: TIntegerField;
    dset_mainFK_DEPARTURES_OFFICIALSOPEN: TIntegerField;
    dset_mainFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField;
    dset_mainADDITIONALINFO: TIBStringField;
    dset_mainFK_DEPARTURES_ORDERS: TIntegerField;
    mem_AddInfo: TDBMemo;
    DBT_OffOpen: TDBText;
    DBT_OffClose: TDBText;
    dset_mainOFFOPEN: TIBStringField;
    dset_mainOFFCLOSE: TIBStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ed_WorkersCount: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    dset_mainWORKERSCOUNT: TIntegerField;
    btn_WorkAndMater: TBitBtn;
    dset_mainBRIG: TIBStringField;
    dset_tmp: TIBDataSet;
    IBSQL: TIBSQL;
    btn_Workers: TBitBtn;
    procedure btn_InsertClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure dset_mainAfterOpen(DataSet: TDataSet);
    procedure dset_mainAfterDelete(DataSet: TDataSet);
    procedure TabCChange(Sender: TObject);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
    procedure dbg_MainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btn_WorkAndMaterClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure TabCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dset_mainBeforeDelete(DataSet: TDataSet);
    procedure btn_WorkersClick(Sender: TObject);
  protected
    class function GetGUID: string; override;
  protected
    procedure InitVocDsetList; override;
    procedure EnableCtrls(value: boolean); override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    F_RecordCount: integer;
    F_IsWorkAndMaterExists: boolean;
    F_IsWorkersExists: boolean;
    procedure SetIsWorkAndMaterExists;
    procedure SetIsWorkersExists;
    procedure SetRecordCount(value: integer);
  private
    F_IDOfficials: integer;
  public
    property IDOfficials: integer read F_IDOfficials write F_IDOfficials;
  end;


implementation

{$R *.dfm}

uses WorkAndMaterForm, HelpFunctions, DepWorkersForm, AppGUIDS;

{ Tfrm_Departures }


procedure Tfrm_Departures.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  de_Start.Enabled:=value;
  te_Start.Enabled:=value;
  de_End.Enabled:=value;
  te_End.Enabled:=value;
  dbl_brig.Enabled:=value;
  mem_AddInfo.Enabled:=value;
  ed_WorkersCount.Enabled:=value;
end;

procedure Tfrm_Departures.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_Departures_orders').AsInteger:=F_OrderID;
  dset_Main.FieldByName('fk_departures_OfficialsOpen').AsInteger:=F_IDOfficials;

  TabC.Tabs.Add('Новый');
  TabC.TabIndex:=TabC.Tabs.Count-1;
end;

function Tfrm_Departures.IsDateCorrect: boolean;
begin
  Result:=false;

  if dset_Main.FieldByName('StartDate').IsNull then
  begin
    ProcessStatus:='Введите дату и время начала работ';
    ActiveControl:=de_Start;
    exit;
  end;

  if dset_Main.FieldByName('StartDate').AsDateTime>Now then
  begin
    ProcessStatus:='Дата и время начала работ не могут быть больше текущих';
    ActiveControl:=te_Start;
    exit;
  end;

  if (not dset_Main.FieldByName('EndDate').IsNull)
    and (dset_Main.FieldByName('EndDate').AsDateTime>Now) then
  begin
    ProcessStatus:='Дата и время окончания работ не могут быть больше текущих';
    ActiveControl:=te_End;
    exit;
  end;

  if (not dset_Main.FieldByName('EndDate').IsNull)
  and (dset_Main.FieldByName('EndDate').AsDateTime<dset_Main.FieldByName('StartDate').AsDateTime) then
  begin
    ProcessStatus:='Дата начала работ не может быть больше даты конца работ';
    ActiveControl:=de_End;
    exit;
  end;

  Result:=true;
end;

function Tfrm_Departures.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Brig) then
  begin
    ActiveControl:=dbl_Brig;
    SetProcessStatus('Введите ответственного за проведение работ');
    exit;
  end;

  Result:=true;
end;

procedure Tfrm_Departures.btn_PostClick(Sender: TObject);
begin
  if not dset_Main.FieldByName('EndDate').IsNull then
    dset_Main.FieldByName('fk_departures_OfficialsClose').AsInteger:=F_IDOfficials;
  inherited btn_PostClick(Sender);
end;

procedure Tfrm_Departures.dset_mainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dset_Main.Last;
  SetRecordCount(dset_main.RecordCount);
  dset_Main.First;
end;

procedure Tfrm_Departures.dset_mainAfterDelete(DataSet: TDataSet);
begin
  inherited;
  SetRecordCount(dset_main.RecordCount);
end;

procedure Tfrm_Departures.SetRecordCount(value: integer);
var
  i: integer;
begin
  F_RecordCount:=value;

  TabC.Tabs.Clear;
  for i:=1 to F_RecordCount do
  begin
    if i=1 then
      TabC.Tabs.Add('Первичный')
    else
      TabC.Tabs.Add('N'+IntToStr(i));
  end;
  TabC.TabIndex:=dset_Main.RecNo-1;

  Caption:='Выезды - Всего выездов: '+IntToStr(F_RecordCount);
end;

procedure Tfrm_Departures.TabCChange(Sender: TObject);
begin
  inherited;
  dset_Main.RecNo:=TabC.TabIndex+1;
end;

procedure Tfrm_Departures.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  TabC.TabIndex:=dset_Main.RecNo-1;
  SetIsWorkAndMaterExists;
  SetIsWorkersExists;
end;

procedure Tfrm_Departures.dbg_MainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  with (Sender as TDBGrid) do
  begin
    if dset_Main.FieldByName('EndDate').IsNull then
      Canvas.Brush.Color:=clWindow
    else
      Canvas.Brush.Color:=clGrayText;
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure Tfrm_Departures.btn_WorkAndMaterClick(Sender: TObject);
var
  WrkFrm: Tfrm_WorkAndMater;
begin
  inherited;

  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
    WrkFrm:=Tfrm_WorkAndMater.Create(nil, F_OrderID, dset_Main.FieldByName('ID').AsInteger, F_ReadOnly);
    try
      WrkFrm.ShowModal;
      SetIsWorkAndMaterExists;
    finally
      WrkFrm.Free
    end;
  end else
    if not F_ReadOnly then
      Application.MessageBox('Для ввода данной информации необходимо зарегистрировать выезд',
                              'Внимание', MB_OK+MB_ICONWARNING);
end;

procedure Tfrm_Departures.btn_CancelClick(Sender: TObject);
begin
  if (dset_Main.State=dsInsert) and (TabC.Tabs.Count>0) then
    TabC.Tabs.Delete(TabC.Tabs.Count-1);

  inherited btn_CancelClick(Sender);
end;

procedure Tfrm_Departures.TabCChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if dset_Main.State in [dsInsert, dsEdit] then
  begin
    AllowChange:=false;
    SetProcessStatus('Отмените или сохраните изменения');
  end else
  begin
    AllowChange:=true;
  end;
end;

procedure Tfrm_Departures.SetIsWorkAndMaterExists;
const
  ARR_SQL: array [1..3] of string=
  (
    'select count(*) kol from departurematerials where fk_usedmaterials_departure=%d',
    'select count(*) kol from departurework  where fk_depwork_departure=%d',
    'select count(*) kol from departureequipments  where fk_depequipment_departures=%d'
  );
var
  i: integer;
begin
  F_IsWorkAndMaterExists:=false;
  if not (dset_Main.Eof and dset_Main.Bof) and
    not (dset_Main.State in [dsInsert]) then
  begin
    for i:=low(ARR_SQL) to high(ARR_SQL) do
    begin
      MyOpenIBDS(dset_tmp, Format(ARR_SQL[i], [dset_Main.FieldByName('ID').AsInteger]));
      if dset_tmp.FieldByName('kol').AsInteger>0 then
      begin
        F_IsWorkAndMaterExists:=true;
        break;
      end;
    end;
    dset_tmp.Close;
  end;

///
  if F_IsWorkAndMaterExists then
    btn_WorkAndMater.Font.Color:=clGreen
  else
    btn_WorkAndMater.Font.Color:=clBlack;
end;

procedure Tfrm_Departures.dset_mainBeforeDelete(DataSet: TDataSet);
const
  ARR_SQL: array [1..3] of string=
  (
    'delete from departurematerials where fk_usedmaterials_departure=%d',
    'delete from departurework  where fk_depwork_departure=%d',
    'delete from departureequipments  where fk_depequipment_departures=%d'
  );
var
  i: integer;
begin
  inherited;

  for i:=low(ARR_SQL) to High(ARR_SQL) do
    MyExecIBSQL(IBSQL, Format(ARR_SQL[i], [dset_Main.FieldByName('ID').AsInteger]));
end;

procedure Tfrm_Departures.btn_WorkersClick(Sender: TObject);
var
  frm: Tfrm_DepWorkers;
begin
  if not(dset_main.Eof and dset_main.Bof) and
     not (dset_main.State in [dsInsert]) then
  begin
    frm:=Tfrm_DepWorkers.Create(nil, F_OrderID, dset_Main.FieldByName('ID').AsInteger,
          dset_Brig.FieldByName('ID').AsInteger, F_ReadOnly);
    try
      frm.ShowModal;
    finally
      frm.Free;
    end;
    SetIsWorkersExists;
  end else
    if not F_ReadOnly then
      Application.MessageBox('Для ввода данной информации необходимо зарегистрировать выезд',
                              'Внимание', MB_OK+MB_ICONWARNING);
end;

procedure Tfrm_Departures.SetIsWorkersExists;
const
  SQL='select count(*) kol from departureworkers where fk_depworkers_departure=%d';
begin
  F_IsWorkersExists:=false;
  if not (dset_Main.Eof and dset_Main.Bof) and
    not (dset_Main.State in [dsInsert]) then
  begin
    MyOpenIBDS(dset_tmp, Format(SQL, [dset_Main.FieldByName('ID').AsInteger]));
    F_IsWorkersExists:=(dset_tmp.FieldByName('kol').AsInteger>0);
    dset_tmp.Close;
  end;
///
  if F_IsWorkersExists then
    btn_Workers.Font.Color:=clGreen
  else
    btn_Workers.Font.Color:=clBlack;
end;

class function Tfrm_Departures.GetGUID: string;
begin
  Result:=DEPARTUREFORMGUID;
end;

procedure Tfrm_Departures.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_Brig);
end;

end.
