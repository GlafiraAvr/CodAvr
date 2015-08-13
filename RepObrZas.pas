unit RepObrZas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, IBDatabase, IBCustomDataSet, FR_DSet,
  FR_DBSet, DB, kbmMemTable, FR_Class;

type
  Tdm_RepObrZas = class(Tdm_NGReportBase)
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
    ResultDsetwork_type: TStringField;
    ResultDsetraskop_dt: TDateTimeField;
    ResultDsetpplan_dt: TDateTimeField;
    ResultDsetblag_dt: TDateTimeField;
    ResultDsetorder_number: TIntegerField;
    ResultDsetid_order: TIntegerField;
    ResultDsetexcnumber: TStringField;
    ResultDsetexcorder: TStringField;
    ResultDsetdttm_excord: TDateTimeField;
    ResultDsetdttm_planendwork: TDateTimeField;
    ResultDsetstype: TStringField;
    ResultDsetstreet: TStringField;
    ResultDsethnum: TStringField;
    ResultDsetorientir: TStringField;
    ResultDsetsblag_dt: TStringField;
    ResultDsetsdt_excord: TStringField;
    ResultDsetsdt_planendwork: TStringField;
    frDBResult: TfrDBDataSet;
    dset_tmp: TIBDataSet;
    dset_Region: TIBDataSet;
    dset_RegionID: TIntegerField;
    dset_RegionNAME: TIBStringField;
    tran: TIBTransaction;
    ResultDsetdt_cheb: TDateTimeField;
    ResultDsetdamage_locacity: TStringField;
  private
    { Private declarations }
    F_BegDate,
    F_EndDate: TDateTime;

    function _PrepBaseInfo( percent: integer ): boolean; virtual;
    procedure _AddReg( _RegID: integer; _RegName: string );
    function  AntiDouble: boolean;
  public
    { Public declarations }
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    function PrepareDset: boolean;
  end;

const n_damegelocacity: array [1..2] of string =('Проезжая магистраль','Тротуар магистраль');

var
  dm_RepObrZas: Tdm_RepObrZas;

implementation

{$R *.dfm}

uses HelpFunctions;

function Tdm_RepObrZas.PrepareDset: boolean;
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
      raise Exception.Create( E.Message + '(Tdm_RepBlag3.PrepareDset)' );
    end;
  end;
end;


function Tdm_RepObrZas._PrepBaseInfo(percent: integer): boolean;
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

procedure Tdm_RepObrZas._AddReg( _RegID: integer; _RegName: string );
var  _fieldlist, _join, _SQL, where: string;






  procedure _From_dset_tmp_to_ResultDset;
    var
      _square: double;

    begin
      _square := dset_tmp.FieldByName( 'exc_square' ).AsFloat;


      ResultDset.FieldByName( 'order_number' ).AsInteger := dset_tmp.FieldByName( 'order_number' ).AsInteger;
      ResultDset.FieldByName( 'region' ).AsString := _RegName;
      ResultDset.FieldByName( 'adres' ).AsString := dset_tmp.FieldByName( 'adres' ).AsString;
      //ResultDset.FieldByName( 'total_count' ).AsInteger := 1;

      ResultDset.FieldByName( 'total_square' ).AsFloat := _square;

      ResultDset.FieldByName( 'raskop_dt' ).AsDateTime := dset_tmp.FieldByName( 'raskop_dt' ).AsDateTime;
      ResultDset.FieldByName( 'dt_cheb' ).AsDateTime :=dset_tmp.FieldByName( 'CHEB_DT' ).AsDateTime;
      ResultDset.FieldByName( 'pplan_dt' ).AsDateTime := dset_tmp.FieldByName( 'pplan_dt' ).AsDateTime;

      ResultDset.FieldByName( 'damage_locacity' ).AsString :=n_damegelocacity[dset_tmp.FieldByName( 'ID_DMGLOC' ).AsInteger];


    end;


begin

   _fieldlist := 'gb.ID_ORDER, gb.ORDER_NUMBER, gb.ADRES,'+
               ' gb.EXC_SQUARE, gb.ID_DMGLOC, gb.LAST_EXC_WRKTYPE, gb.RASKOP_DT, gb.Cheb_dt, '+
               ', gb.BLAG_DT, gb.PPLAN_DT, ''V''||lpad(e.excnumber, 5, ''0'') excnumber, e.excorder, e.dttm_excord, e.dttm_planendwork'+
               ', (select name from s_streettypes where id = (select ss.fk_streets_streettypes from s_streets ss where ss.id = o.fk_orders_streets)) stype '+
               ', (select name from s_streets where id = o.fk_orders_streets) street, rtrim(o.housenum) hnum , trim(o.additionaladdress) orientir, e.excnumber exn ';


    where :='where ID_DMGLOC in (1,2) and LAST_EXC_WRKTYPE<>5';



   _SQL := Format( 'select distinct * from get_blag2( %d, ''%s'', ''%s'', ''%s'' ) %s'
                                ,[ _RegID, DateToStr( F_BegDate - 120 ), DateToStr( F_BegDate ), DateToStr( F_EndDate ), where] );

    MyOpenIBDS( dset_tmp, _SQL );


    {2 магистраль}

    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 1,2 ])
      and AntiDouble then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.Post;
      end;
      dset_tmp.Next;
    end;
    {/2}
    dset_tmp.Close;
end;


function Tdm_RepObrZas.AntiDouble: boolean;
    var _id: integer;
        _res : boolean;
    begin
     // здесь уберём повторяющиеся наряды, а то задолбался колупаться в базе
     _id := dset_tmp.FieldByName( 'id_order' ).AsInteger;
     _res := ResultDset.Locate('id_order', _id, [loCaseInsensitive]);
     Result := not _res;
    end;
end.
