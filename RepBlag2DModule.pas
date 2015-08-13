unit RepBlag2DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, kbmMemTable, IBDatabase,
  IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  Tdm_RepBlag2 = class(Tdm_NGReportBase)
    ResultDset: TkbmMemTable;
    ResultDsetregion: TStringField;
    ResultDsetadres: TStringField;
    ResultDsettotal_count: TIntegerField;
    ResultDsettotal_square: TFloatField;
    ResultDsetmagistr_count: TIntegerField;
    ResultDsetmagistr_square: TFloatField;
    ResultDsetvnutr_count: TIntegerField;
    ResultDsetvnutr_square: TFloatField;
    ResultDsetzelen_count: TIntegerField;
    ResultDsetzelen_square: TFloatField;
    ResultDsetraskop_dt: TDateTimeField;
    ResultDsetpplan_dt: TDateTimeField;
    ResultDsetblag_dt: TDateTimeField;
    dset_Region: TIBDataSet;
    tran: TIBTransaction;
    dset_RegionID: TIntegerField;
    dset_RegionNAME: TIBStringField;
    dset_tmp: TIBDataSet;
    ResultDsetwork_type: TStringField;
    frDBResult: TfrDBDataSet;
    ResultDsetorder_number: TIntegerField;
    dset_tmp2: TIBDataSet;
    ResultDsetid_order: TIntegerField;
  private
    F_BegDate,
    F_EndDate: TDateTime;
    F_BLAG: integer;
    F_GZ: boolean;
    F_ASF: boolean;
    function AntiDouble: boolean;
    function AddItGreen: boolean;
    function _PrepBaseInfo( percent: integer ): boolean; virtual;
    procedure _AddReg( _RegID: integer; _RegName: string );
  public
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property blag: integer read F_BLAG write F_BLAG;
    property GZ: boolean read F_GZ write F_GZ;
    property ASF: boolean read F_ASF write F_ASF;
    function PrepareDset: boolean;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepBlag2 }

function Tdm_RepBlag2.PrepareDset: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try

    ResultDset.Close;
    ResultDset.Open;

    Result := _PrepBaseInfo( 100 );

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepBlag2.PrepareDset)' );
    end;
  end;
end;

function Tdm_RepBlag2._PrepBaseInfo(percent: integer): boolean;
var
  _progress_shag: integer;
begin
  Result := false;

  dset_Region.Close;
  dset_Region.Open;
  dset_Region.Last;

  _progress_shag := GetProgressShagLength( percent, dset_Region.RecordCount );

  dset_Region.First;
  while not dset_Region.Eof do
  begin
    if F_IsStopProgress then exit;
    _AddReg( dset_Region.FieldByName( 'ID' ).AsInteger, dset_Region.FieldByName( 'NAME' ).AsString );
    IncProgressStatus( _progress_shag );
    dset_Region.Next;
  end;
  dset_Region.Close;

  Result := true;
end;

procedure Tdm_RepBlag2._AddReg( _RegID: integer; _RegName: string );
     function AddItMag: boolean;
      var _wt :integer;
      begin
       _wt := dset_tmp.FieldByName( 'last_exc_wrktype' ).AsInteger;
       case blag of
        0: Result := true;
        1: begin
             if ASF then
               begin //если асфальтировка, то только без асфальт.
                if (_wt <> 5) then Result := true else Result := false;
               end;
             if not ASF then //если щебенение, то только без асфальт. и без щебёнки
               begin
                if (_wt <> 5) and (_wt <> 11) and (_wt <> 7) then Result := true else Result := false;
               end;
           end;
        2: begin
             if ASF then
               begin //если асфальтировка, то только асфальт.
                if _wt = 5 then Result := true else Result := false;
               end;
             if not ASF then //если щебенение, то асфальт. или  щебёнка
               begin
                if (_wt = 5) or (_wt = 11) or (_wt = 7) then Result := true else Result := false;
               end;
           end;
       end; //case

      end;

  procedure _From_dset_tmp_to_ResultDset;
    var
      _square, _sq_asf: double;
    begin
      _square := dset_tmp.FieldByName( 'exc_square' ).AsFloat;



      ResultDset.FieldByName( 'order_number' ).AsInteger := dset_tmp.FieldByName( 'order_number' ).AsInteger;
      ResultDset.FieldByName( 'region' ).AsString := _RegName;
      ResultDset.FieldByName( 'adres' ).AsString := dset_tmp.FieldByName( 'adres' ).AsString;
      ResultDset.FieldByName( 'total_count' ).AsInteger := 1;
      ResultDset.FieldByName( 'total_square' ).AsFloat := _square;
      case dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger of
        1,2:
          begin
            ResultDset.FieldByName( 'magistr_count' ).AsInteger := 1;
            ResultDset.FieldByName( 'magistr_square' ).AsFloat := _square;
          end;
        6,7,8:
          begin
            ResultDset.FieldByName( 'vnutr_count' ).AsInteger := 1;
            ResultDset.FieldByName( 'vnutr_square' ).AsFloat := _square;
          end;
        3,5:
          begin
            ResultDset.FieldByName( 'zelen_count' ).AsInteger := 1;
            ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square;
          end;
      end;

      case dset_tmp.FieldByName( 'last_exc_wrktype' ).AsInteger of
        1: //засыпано
          ResultDset.FieldByName( 'work_type' ).AsString := 'ШЗ';
        6: //спланировано
          ResultDset.FieldByName( 'work_type' ).AsString := 'ШС';
        7,11: //защебенено
          ResultDset.FieldByName( 'work_type' ).AsString := 'ШЩ';
        5: //асфальтировка
          ResultDset.FieldByName( 'work_type' ).AsString := 'ША';
        else
          ResultDset.FieldByName( 'work_type' ).AsString := 'ШР';
      end;

      ResultDset.FieldByName( 'raskop_dt' ).AsDateTime := dset_tmp.FieldByName( 'raskop_dt' ).AsDateTime;
      ResultDset.FieldByName( 'pplan_dt' ).AsDateTime := dset_tmp.FieldByName( 'pplan_dt' ).AsDateTime;
      ResultDset.FieldByName( 'blag_dt' ).AsDateTime := dset_tmp.FieldByName( 'blag_dt' ).AsDateTime;
      ResultDset.FieldByName( 'id_order' ).AsInteger := dset_tmp.FieldByName( 'id_order' ).AsInteger;
    end;


  begin
    MyOpenIBDS( dset_tmp,
      Format( 'select * from get_blag2( %d, ''%s'', ''%s'', ''%s'' )',
        [ _RegID, DateToStr( F_BegDate - 60 ), DateToStr( F_BegDate ), DateToStr( F_EndDate ) ] ) );

    {1 внутриквартальная, отмостка}
    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 6,7,8 ]) and AddItMag
      and AntiDouble then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.Post;
      end;
      dset_tmp.Next;
    end;
    {/1}

    {2 магистраль}

    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 1,2 ]) and AddItMag
      and AntiDouble then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.Post;
      end;
      dset_tmp.Next;
    end;
    {/2}


    {3 зелёная зона}
   if GZ then
    begin
      dset_tmp.First;
      while not dset_tmp.Eof do
      begin
       if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 3,5 ]) and AddItGreen
       and AntiDouble then
        begin
          ResultDset.Append;
          _From_dset_tmp_to_ResultDset;
          ResultDset.Post;
        end;
        dset_tmp.Next;
      end;
    end;
    {/3}

    dset_tmp.Close;
  end;



function Tdm_RepBlag2.AddItGreen: boolean;
     var _sql: string;
         _ct: integer;
     begin  // проверяем, а есть ли для наряда "спланировано" (6)
       _sql := 'select count(fk_excavations_excwt) ct'+
        ' from excavations '+
        ' where fk_excavations_excwt = 6 '+
        ' and fk_excavations_orders = ' + dset_tmp.FieldByName( 'id_order' ).AsString;
       if dset_tmp2.Active then dset_tmp2.Close;
       MyOpenIBDS( dset_tmp2, _sql);
       dset_tmp2.First;
       _ct := dset_tmp2.FieldByName('ct').AsInteger;
       dset_tmp2.Close;
       case blag of
        0: Result := true;
        1: if _ct = 0 then Result := true
            else Result := false;
        2: if _ct > 0 then Result := true
            else Result := false;
       end;
     end;

function Tdm_RepBlag2.AntiDouble: boolean;
    var _id: integer;
        _res : boolean;
    begin
     // здесь уберём повторяющиеся наряды, а то задолбался колупаться в базе
     _id := dset_tmp.FieldByName( 'id_order' ).AsInteger;
     _res := ResultDset.Locate('id_order', _id, [loCaseInsensitive]);
     Result := not _res;
    end;



end.
