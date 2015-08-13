unit RepNeedAsfaltDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DModule, DB, RxMemDS,
  IBCustomDataSet, FR_DSet, FR_DBSet, IBSQL;

type
  TExcType = (etNull, etAsfalt, etZelen);

  Tdm_RepNeedAsfalt = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TRxMemoryData;
    ResultDsetid_region: TIntegerField;
    ResultDsetregion: TStringField;
    ResultDsetneed_restore_count: TIntegerField;
    ResultDsetneed_restore_square: TFloatField;
    ResultDsetrestored_plan_count: TIntegerField;
    ResultDsetrestored_plan_square: TFloatField;
    ResultDsetrestored_noplan_count: TIntegerField;
    ResultDsetrestored_noplan_square: TFloatField;
    ResultDsetnew_exc_count: TIntegerField;
    ResultDsetnew_exc_square: TFloatField;
    dset: TIBDataSet;
    dset2: TIBDataSet;
    frDBResult: TfrDBDataSet;
    ResultDsetin_work_count: TIntegerField;
    ResultDsetin_work_square: TFloatField;
    ResultDsetneed_restore_gran_count: TIntegerField;
    ResultDsetneed_restore_gran_square: TFloatField;
    ResultDsetplan_restore_count: TIntegerField;
    ResultDsetplan_restore_square: TFloatField;
    ResultDsettotal_restored_count: TIntegerField;
    ResultDsettotal_restored_square: TFloatField;
    ResultDsetpercent_exc: TFloatField;
    ResultDsetostat_gran_count: TIntegerField;
    ResultDsetostat_gran_square: TFloatField;
    ResultDsetline_num: TStringField;
    IBSQL: TIBSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure ResultDsetneed_restore_countGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_StartDate,
    F_NeedRestoreDate,
    F_BegDate,
    F_EndDate: TDateTime;
    F_ExcType: TExcType;
    F_BlagProcedureName: string;
    F_SessionID: integer;
    function _PrepBaseInfo( _percent: integer ): boolean;
    procedure SetExcType(const Value: TExcType);
    procedure ClearTMP_BLAG;
  public
    property StartDate: TDateTime read F_StartDate write F_StartDate;
    property NeedRestoreDate: TDateTime read F_NeedRestoreDate write F_NeedRestoreDate;
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property ExcType: TExcType read F_ExcType write SetExcType;
    property SessionID: integer read F_SessionID;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepNeedAsfalt }

function Tdm_RepNeedAsfalt.PrepareDset: boolean;
begin
  ResetProgressFields;

  ClearTMP_BLAG;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try

    ResultDset.Close;
    ResultDset.Open;

    if not _PrepBaseInfo( 100 ) then
      Result := false
    else
      Result := true;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepNeedAsfalt.PrepareDset)' );
    end;
  end;
end;

function Tdm_RepNeedAsfalt._PrepBaseInfo(_percent: integer): boolean;
  procedure _CalcFields;
  var
    _need_restore_count, _restored_count: integer;
    _need_restore_square, _restored_square: double;
  begin
    with ResultDset do
    begin
      _need_restore_count :=
        FieldByName( 'need_restore_count' ).AsInteger +
        FieldByName( 'new_exc_count' ).AsInteger;
      _need_restore_square :=
        FieldByName( 'need_restore_square' ).AsFloat +
        FieldByName( 'new_exc_square' ).AsFloat;
      _restored_count :=
        FieldByName( 'restored_plan_count' ).AsInteger +
        FieldByName( 'restored_noplan_count' ).AsInteger;
      _restored_square :=
        FieldByName( 'restored_plan_square' ).AsFloat +
        FieldByName( 'restored_noplan_square' ).AsFloat;
      //
      FieldByName( 'in_work_count' ).AsInteger :=
        _need_restore_count - _restored_count;

      FieldByName( 'in_work_square' ).AsFloat :=
        _need_restore_square - _restored_square;

      FieldByName( 'total_restored_count' ).AsInteger := _restored_count;
      FieldByName( 'total_restored_square' ).AsFloat := _restored_square;

      if _need_restore_count <> 0 then
        FieldByName( 'percent_exc' ).AsFloat := 100*(_restored_count/_need_restore_count);
    end;
  end;


  procedure _AddReg(_line_num, _reg_id: integer; _reg_name: string);
  var
    i: integer;
  begin
    MyOpenIBDS( dset2,
      Format( 'select * from ' + F_BlagProcedureName + '(%d, %d, ''%s'', ''%s'', ''%s'', ''%s'')',
      [ F_SessionID,
        _reg_id,
        DateToStr( F_StartDate ),
        DateToStr( F_NeedRestoreDate ),
        DateToStr( F_BegDate ),
        DateToStr( F_EndDate ) ] ) );

    with dset2 do
    begin
      ResultDset.Append;
      ResultDset.FieldByName( 'line_num' ).AsString := IntToStr( _line_num );
      ResultDset.FieldByName( 'id_region' ).AsInteger := _reg_id;
      ResultDset.FieldByName( 'region' ).AsString := _reg_name;
      for i:=0 to FieldCount-1 do
        ResultDset.FieldByName( Fields[i].FieldName ).Value := Fields[i].Value;
      _CalcFields;
      ResultDset.Post;
    end;
  end;

  procedure _AddItogo;
  var
    i: integer;
    _sum: variant;
  begin
    with ResultDset do
    begin
      Append;
      FieldByName( 'line_num' ).AsString := '';
      FieldByName( 'id_region' ).AsInteger := -1;
      FieldByName( 'region' ).AsString := 'хрнцн:';
      Post;

      for i:= 3 to ResultDset.FieldCount - 2 do
      begin
        _sum := 0;
        First;
        while not ResultDset.Eof do
        begin
          if FieldByName( 'id_region' ).AsInteger >0 then
            _sum := _sum + Fields[ i ].Value;
          Next;
        end;
        if Locate( 'id_region', -1, [] ) then
        begin
          Edit;
          Fields[ i ].Value := _sum;
          Post;
        end;
      end;

      if Locate( 'id_region', -1, [] ) then
      begin
        Edit;
        _CalcFields;
        Post;
      end;
    end;
  end;

var
  _ind: integer;
  _progress_shag: integer;
begin
  Result := false;

  MyOpenIBDS( dset,
    ' select id, name'+
    ' from s_regions'+
    ' where (id>0) and (activity is null)'+
    ' order by name' );
  dset.Last;

  _progress_shag := GetProgressShagLength( _percent, dset.RecordCount );

  dset.First;
  for _ind:=0 to dset.RecordCount-1 do
  begin
    if F_IsStopProgress then exit;
    _AddReg( _ind + 1, dset.FieldByName( 'id' ).AsInteger, dset.FieldByName( 'name' ).AsString );
    IncProgressStatus( _progress_shag );
    dset.Next;
  end;
  _AddItogo;

  Result := true;
end;

procedure Tdm_RepNeedAsfalt.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_BlagProcedureName := '';
  F_SessionID := DM_Main.GetNewSessionID;
end;

procedure Tdm_RepNeedAsfalt.SetExcType(const Value: TExcType);
begin
  F_ExcType := Value;

  case F_ExcType of
    etAsfalt: F_BlagProcedureName := 'get_blag_asfalt';
    etZelen: F_BlagProcedureName := 'get_blag_zelen';
  end;
end;

procedure Tdm_RepNeedAsfalt.ResultDsetneed_restore_countGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsFloat > 0.001 then
    Text := FormatFloat( '0.', Sender.AsFloat )
  else
    Text := '';
end;

procedure Tdm_RepNeedAsfalt.ClearTMP_BLAG;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    MyExecIBSQL( IBSQL, 'delete from tmp_blag where session_id = ' + IntToStr( F_SessionID ) );
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(ClearTMP_BLAG)';
      raise;
    end;
  end;
end;

procedure Tdm_RepNeedAsfalt.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ClearTMP_BLAG;
end;

end.
