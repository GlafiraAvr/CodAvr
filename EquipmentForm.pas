unit EquipmentForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, RxLookup, Mask,
  DBGrids, IBCustomDataSet, DModule, IBDatabase, IBSQL, kbmMemTable;

type
  TDataType=(dtEquipID, dtEquipWorkID, dtEquipWorkCount);

  Tfrm_Equipment = class(TForm)
    btn_Save: TBitBtn;
    btn_Close: TBitBtn;
    ds_equip: TDataSource;
    dset_Equip: TIBDataSet;
    dbl_Equip: TRxDBLookupCombo;
    tr_exec: TIBTransaction;
    dset_tmp: TIBDataSet;
    tr_voc: TIBTransaction;
    tr_tmp: TIBTransaction;
    sql_exec: TIBSQL;
    Label1: TLabel;
    mem_Equip: TkbmMemTable;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbl_EquipChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    F_RegionID: integer;
    F_ReadOnlyFrm: boolean;
    F_OrderID: integer;
    F_ShiftDate: TDate;
    F_IsChange: boolean;

    function GetShiftDate: TDate;
    function GetData(DataType: TDataType): integer;

    procedure InsertEquipWork(id_equip: integer);
    procedure DeleteEquipWork(id_equip_work: integer);
    procedure UpdateEquipWork(id_equip_work, id_equip: integer);
    procedure ExecSQL(sql: string);
    function IsEquipPlanned(id_equip: integer): boolean;
  public
    property RegionID: integer read F_RegionID write F_RegionID;
    property ReadOnlyFrm: boolean read F_ReadOnlyFrm write F_ReadOnlyFrm;
    property OrderID: integer read F_OrderID write F_OrderID;
    property IsChange: boolean read F_IsChange write F_IsChange;
  end;
implementation

{$R *.dfm}

uses HelpFunctions, HelpClasses, StringConsts,GlobalVocCacheDModule;

procedure Tfrm_Equipment.btn_CloseClick(Sender: TObject);
begin
  Close();
end;

procedure Tfrm_Equipment.btn_SaveClick(Sender: TObject);
var
  id_equip, id_equip_work: integer;
begin
  id_equip:=mem_Equip.FieldByName('id').AsInteger;//dset_Equip.FieldByName('id').AsInteger;

  if (id_equip<>-1) and (dbl_Equip.Text<>'') then
  begin
     /// пока что отключим проверку запланированного оборудования by Vadim 15.06.2010
   {
    if not IsEquipPlanned(id_equip) then
      Application.MessageBox('Внесите данное оборудование в запланированное по данному району!',
                              gc_strDispAVR, MB_OK+MB_ICONWARNING);
    }
      if GetData(dtEquipWorkCount)>0 then
        UpdateEquipWork(GetData(dtEquipWorkID), id_equip)
      else
        InsertEquipWork(id_equip);
  end else
  begin
    id_equip_work:=GetData(dtEquipWorkID);
    if id_equip_work<>-1 then
      DeleteEquipWork(id_equip_work);
  end;

  btn_Save.Enabled:=false;
  F_IsChange:=true;
  Close;
end;

procedure Tfrm_Equipment.FormShow(Sender: TObject);
begin
  if not tr_voc.InTransaction then
    tr_voc.StartTransaction;
  dset_equip.Open;

  FixDBLValue(GetData(dtEquipID), dbl_Equip);

  F_ShiftDate:=GetShiftDate;
  F_IsChange:=false;

  dbl_Equip.Enabled:=not F_ReadOnlyFrm;

  btn_Save.Enabled:=false;

  if dbl_Equip.Enabled then dbl_Equip.SetFocus;
end;

procedure Tfrm_Equipment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if tr_voc.InTransaction then
    tr_voc.Commit;
end;

procedure Tfrm_Equipment.InsertEquipWork(id_equip: integer);
var
  ins_sql: string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['DateWork']:= DateTime2Str(F_ShiftDate, Time);
      ValueByFieldName['fk_eqwork_orders']:=IntToStr(F_OrderID);
      ValueByFieldName['fk_eqwork_equip']:=IntToStr(id_equip);

      TableName:='EquipWork';
      ins_sql:=GenInsertQuery;
    finally
      Free;
    end;
  end; //end with

  ExecSQL(ins_sql);
end;

function Tfrm_Equipment.GetShiftDate: TDate;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp, 'select ShiftDate from ServantTable');
    Result:=dset_tmp.FieldByName('ShiftDate').AsDateTime;
    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_Equipment.GetShiftDate)');
    end;
  end;
end;

procedure Tfrm_Equipment.ExecSQL(sql: string);
begin
  if tr_exec.InTransaction then
    tr_exec.Rollback;
  tr_exec.StartTransaction;
  try
    MyExecSQL(sql_exec, sql);
    tr_exec.Commit;
  except
    on E: Exception do
    begin
      tr_exec.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_Equipment.ExecSQL)');
    end;
  end;
end;

procedure Tfrm_Equipment.UpdateEquipWork(id_equip_work, id_equip: integer);
var
  upd_sql: string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['DateWork']:= DateTime2Str(F_ShiftDate, Time);
      ValueByFieldName['fk_eqwork_orders']:=IntToStr(F_OrderID);
      ValueByFieldName['fk_eqwork_equip']:=IntToStr(id_equip);

      TableName:='EquipWork';
      Condition:='id='+IntToStr(id_equip_work);

      upd_sql:=GenUpdateQuery;
    finally
      Free;
    end;
  end; // end with

  ExecSQL(upd_sql);
end;


function Tfrm_Equipment.IsEquipPlanned(id_equip: integer): boolean;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try
    MyOpenIBDS(dset_tmp,
      ' select id'+
      ' from equipplanned'+
      ' where'+
      ' fk_equipplanned_equip='+IntToStr(id_equip)+
      ' and cast(eqdate as Date)='''+DateToStr(F_ShiftDate)+''''+
      ' and fk_equipplanned_regions='+IntToStr(F_RegionID));

    Result:=not dset_tmp.Eof;

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_Equipment.IsEquipPlanned)');
    end;
  end
end;

function Tfrm_Equipment.GetData(DataType: TDataType): integer;
begin
  if tr_tmp.InTransaction then
    tr_tmp.Rollback;
  tr_tmp.StartTransaction;
  try

    case DataType of
      dtEquipID:
        begin
          MyOpenIBDS(dset_tmp,
            ' select fk_eqwork_equip from equipwork'+
            ' where fk_eqwork_orders='+IntToStr(F_OrderID));
          if not dset_tmp.Eof then Result:=dset_tmp.FieldByName('fk_eqwork_equip').AsInteger
          else Result:=-1;
        end;
      dtEquipWorkID:
        begin
          MyOpenIBDS(dset_tmp,
            ' select id from equipwork'+
            ' where fk_eqwork_orders='+IntToStr(F_OrderID));
          if not dset_tmp.Eof then Result:=dset_tmp.FieldByName('id').AsInteger
          else Result:=-1;
        end;
      dtEquipWorkCount:
        begin
          MyOpenIBDS(dset_tmp,
            'select count(*) kol from EquipWork'+
            ' where fk_EqWork_orders='+IntToStr(F_OrderID));
          Result:=dset_tmp.FieldByName('kol').AsInteger;
        end;
    end;

    tr_tmp.Commit;
  except
    on E: Exception do
    begin
      tr_tmp.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_Equipment.GetData)');
    end;
  end;
end;

procedure Tfrm_Equipment.DeleteEquipWork(id_equip_work: integer);
begin
  ExecSQL('delete from EquipWork where id='+IntToStr(id_equip_work));
end;

procedure Tfrm_Equipment.dbl_EquipChange(Sender: TObject);
begin
  btn_Save.Enabled:=true;
end;

procedure Tfrm_Equipment.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_Equipment.FormCreate(Sender: TObject);
var Lis:TList;
begin
Lis:=TList.Create;
Lis.Add(mem_Equip);
dm_GlobalVocCache.CheckVocs(Lis);
TDataSet(Lis.First).open;
Lis.Free;


end;

end.
