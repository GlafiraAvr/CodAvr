unit DepsDModule;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBDatabase, DModule, BaseEditDModule,
  GridEditDModule, IBSQL;

type
  Tdm_Deps = class(Tdm_GridEdit)
    dset_MainID: TIntegerField;
    dset_MainSTARTDATE: TDateTimeField;
    dset_MainENDDATE: TDateTimeField;
    dset_MainFK_DEPARTURES_BRIGADIERS: TIntegerField;
    dset_MainFK_DEPARTURES_OFFICIALSOPEN: TIntegerField;
    dset_MainFK_DEPARTURES_OFFICIALSCLOSE: TIntegerField;
    dset_MainFK_DEPARTURES_ORDERS: TIntegerField;
    dset_MainOFFICIALOPEN: TIBStringField;
    dset_MainOFFICIALCLOSE: TIBStringField;
    dset_MainBRIG: TIBStringField;
    dset_MainCALC_IsCanEditRec: TBooleanField;
    dset_MainDEPNUMBER: TSmallintField;
    dset_MainCALC_IsCanDelRec: TBooleanField;
    dset_MainEXCAV_CLOSE_INFO: TIBStringField;
    IBDataSet1: TIBDataSet;
    IBSQL1: TIBSQL;
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure dset_MainSTARTDATEChange(Sender: TField);
    procedure dset_MainENDDATEChange(Sender: TField);
    procedure dset_MainCalcFields(DataSet: TDataSet);
    procedure OnFieldChange(Sender: TField);
    procedure dset_MainAfterOpen(DataSet: TDataSet);
  private
    F_OfficialID: integer;
    F_OnMyAfterOpen:  TDataSetNotifyEvent;
  private
    F_IsHasDep2: boolean;
  public
    property OfficialID: integer read F_OfficialID write F_OfficialID;
    property OnMyAfterOpen: TDataSetNotifyEvent read F_OnMyAfterOpen
      write F_OnMyAfterOpen;
    function GetActiveDepID: integer;
    function GetActiveBrigID: integer;
    function GetActiveStartDate: TDateTime;
    function IsCanEditCurrentRec: boolean;
  end;


implementation

{$R *.dfm}

procedure Tdm_Deps.dset_MainAfterInsert(DataSet: TDataSet);
var
  _DepNum: integer;
begin
  inherited;
  dset_Main.FieldByName('fk_departures_orders').AsInteger := F_OrderID;

  if not F_IsHasDep2 then _DepNum := 2
  else _DepNum := 3;

  dset_Main.FieldByName('depnumber').AsInteger := _DepNum;
end;

procedure Tdm_Deps.dset_MainSTARTDATEChange(Sender: TField);
begin
  OnFieldChange( Sender );

  if dset_Main.State in [dsInsert, dsEdit] then
    dset_Main.FieldByName('fk_departures_OfficialsOpen').AsInteger := F_OfficialID;
end;

procedure Tdm_Deps.dset_MainENDDATEChange(Sender: TField);
begin
  OnFieldChange( Sender );

  if dset_Main.State in [dsInsert, dsEdit] then
    dset_Main.FieldByName('fk_departures_OfficialsClose').AsInteger:=F_OfficialID;
end;

procedure Tdm_Deps.dset_MainCalcFields(DataSet: TDataSet);
var
  _IsCanEdit, _IsCanDel: boolean;
begin
  {
    ѕервичный выезд удал€ть и корректировать нельз€. ≈му присваиваетс€ DepNumber=1.
 он заноситс€ на форме за€вке, а на форме выездов просто высвечиваетс€.
    ¬торой вноситс€ как на форме нар€да так на форме выездов (по случаю).
  ѕричем его нельз€ удалить (как на форме нар€дов,
  так и на форме выездов) если были еще выезды (3, .. ). ¬торичный выезд
  получает DepNumber = 2.
    ¬се остальвые выезды получают DepNumber = 3;
  }

  case DataSet.FieldByName( 'DepNumber' ).AsInteger of
    1:
      begin
        _IsCanEdit := false;
        _IsCanDel := false;
      end;
    2:
      begin
        _IsCanEdit := true;
        _IsCanDel := ( DataSet.RecordCount <= 2 );
      end;
    else
      begin
        _IsCanEdit := true;
        _IsCanEdit := true;
      end;
  end;

  DataSet.FieldByName( 'CALC_IsCanEditRec' ).AsBoolean := _IsCanEdit;
  DataSet.FieldByName( 'CALC_IsCanDelRec' ).AsBoolean := _IsCanDel;
end;

procedure Tdm_Deps.OnFieldChange(Sender: TField);
begin
  if Assigned( F_OnMyFieldChange ) then
    F_OnMyFieldChange( Sender );
end;

function Tdm_Deps.GetActiveDepID: integer;
begin
  if not( dset_Main.Eof and dset_Main.Bof ) and
    ( dset_Main.State <> dsInsert ) then
  begin
    Result := dset_Main.FieldByName( 'ID' ).AsInteger;
  end else Result := -1;
end;

function Tdm_Deps.GetActiveBrigID: integer;
begin
  if not( dset_Main.Eof and dset_Main.Bof ) then
    Result := dset_Main.FieldByName( 'fk_departures_brigadiers' ).AsInteger
  else
    Result := -1;
end;

function Tdm_Deps.IsCanEditCurrentRec: boolean;
begin
  Result := dset_Main.FieldByName('CALC_IsCanEditRec').AsBoolean;
end;

procedure Tdm_Deps.dset_MainAfterOpen(DataSet: TDataSet);
begin
  if Assigned( F_OnMyAfterOpen ) then
    F_OnMyAfterOpen( DataSet );

  DataSet.DisableControls;
  DataSet.First;
  F_IsHasDep2 := false;
  while not DataSet.Eof do
  begin
    if DataSet.FieldByName('DepNumber').AsInteger = 2 then
    begin
      F_IsHasDep2 := true;
      break;
    end;
    DataSet.Next;
  end;
  DataSet.EnableControls;

  inherited;
end;

function Tdm_Deps.GetActiveStartDate: TDateTime;
begin
  Result := dset_Main.FieldByName( 'StartDate' ).AsDateTime;
end;

end.
