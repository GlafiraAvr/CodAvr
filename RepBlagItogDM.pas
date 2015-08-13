unit RepBlagItogDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, IBDatabase, DB,
  kbmMemTable, IBCustomDataSet, FR_DSet, FR_DBSet;

type
  Tdm_RepBlagItog = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TkbmMemTable;
    ResultDsetid_region: TIntegerField;
    ResultDsetregion: TStringField;
    ResultDsetasf_need_restore_count: TIntegerField;
    ResultDsetasf_need_restore_square: TFloatField;
    ResultDsetasf_restored_plan_count: TIntegerField;
    ResultDsetasf_restored_plan_square: TFloatField;
    ResultDsetasf_restored_noplan_count: TIntegerField;
    ResultDsetasf_restored_noplan_square: TFloatField;
    ResultDsetzel_need_restore_count: TIntegerField;
    ResultDsetzel_need_restore_square: TFloatField;
    ResultDsetzel_restored_plan_count: TIntegerField;
    ResultDsetzel_restored_plan_square: TFloatField;
    ResultDsetzel_restored_noplan_count: TIntegerField;
    ResultDsetzel_restored_noplan_square: TFloatField;
    dset: TIBDataSet;
    dset2: TIBDataSet;
    frDBResult: TfrDBDataSet;
  private
    F_StartDate,
    F_BegDate,
    F_EndDate: TDateTime;
    function FillResultDset( _percent: integer ): boolean;
  public
    property StartDate: TDateTime read F_StartDate write F_StartDate;
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepBlagItog }

function Tdm_RepBlagItog.FillResultDset(_percent: integer): boolean;
  procedure _AddReg(_reg_id: integer; _reg_name: string);
  var
    i: integer;
    str:string;
  begin
  str:=Format( 'select * from GET_BLAG_ITOG (%d, ''%s'', ''%s'', ''%s'')',
      [ _reg_id, DateToStr( F_StartDate ), DateToStr( F_BegDate ), DateToStr( F_EndDate ) ] );
    MyOpenIBDS( dset2,
      Format( 'select * from GET_BLAG_ITOG (%d, ''%s'', ''%s'', ''%s'')',
      [ _reg_id, DateToStr( F_StartDate ), DateToStr( F_BegDate ), DateToStr( F_EndDate ) ] ) );

    with dset2 do
    begin
      ResultDset.Append;
      ResultDset.FieldByName( 'id_region' ).AsInteger := _reg_id;
      ResultDset.FieldByName( 'region' ).AsString := _reg_name;
      for i:=0 to FieldCount-1 do
        ResultDset.FieldByName( Fields[i].FieldName ).Value := Fields[i].Value;
      ResultDset.Post;
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
    _AddReg( dset.FieldByName( 'id' ).AsInteger, dset.FieldByName( 'name' ).AsString );
    IncProgressStatus( _progress_shag );
    dset.Next;
  end;

  Result := true;
end;

function Tdm_RepBlagItog.PrepareDset: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try

    ResultDset.Close;
    ResultDset.Open;

    if not FillResultDset( 100 ) then
      Result := false
    else
      Result := true;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_RepBlagItog.PrepareDset)';
      raise;
    end;
  end;
end;

end.
