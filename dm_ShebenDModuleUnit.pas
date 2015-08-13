unit dm_ShebenDModuleUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB,
  kbmMemTable, IBDatabase, IBCustomDataSet;

type
  Tdm_ShebenDModule = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TkbmMemTable;
    frDBResult: TfrDBDataSet;
    Dset: TIBDataSet;
    dset_reg: TIBDataSet;
    DsetID_ORDER: TIntegerField;
    DsetORDER_NUMBER: TIntegerField;
    DsetADRES: TIBStringField;
    DsetEXC_SQUARE: TFloatField;
    DsetDAMAGELOCALITY: TIBStringField;
    DsetRASKOP_DT: TDateTimeField;
    DsetDT_SHEB: TDateTimeField;
    DsetDT_ASF: TDateTimeField;
    DsetID_DMGLOC: TIntegerField;
    DsetLAST_EXC_WRKTYPE: TIntegerField;
    DsetBLAG_DT: TDateTimeField;
    DsetPPLAN_DT: TDateTimeField;
    ResultDsetID_ORDER: TIntegerField;
    ResultDsetORDER_NUMBER: TIntegerField;
    ResultDsetADRES: TStringField;
    ResultDsetDAMAGELOCALITY: TStringField;
    dset_regID: TIntegerField;
    dset_regNAME: TIBStringField;
    ResultDsetRegion: TStringField;
    ResultDsetRASKOP_DT: TStringField;
    ResultDsetDT_SHEB: TStringField;
    ResultDsetDT_ASF: TStringField;
    ResultDsetEXC_SQUARE: TStringField;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_DtEnd: TDateTime;
    F_RegionsID: string;
    procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    function PrepareDset: boolean;
  end;

var
  dm_ShebenDModule: Tdm_ShebenDModule;

implementation

{$R *.dfm}
uses HelpFunctions;

function Tdm_ShebenDModule.PrepareDset: boolean;
begin
   Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_ShebenDModule.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_ShebenDModule.FillResultDset;
var  _RegID ,RegCondition, SQL_Main, _sql_reg: string;
     _progress_shag: integer;

    function AntiDouble: boolean;
    var _id: integer;
        _res : boolean;
    begin
     // здесь уберЄм повтор€ющиес€ нар€ды, а то задолбалс€ колупатьс€ в базе
     _id := dset.FieldByName( 'id_order' ).AsInteger;
     _res := ResultDset.Locate('id_order', _id, [loCaseInsensitive]);
     Result := not _res;
    end;


    procedure AddToResultDset;
    var i: integer;
        _SQL: string;
    begin
          _RegID := Dset_reg.FieldByName('id').AsString;
          _SQL := Format( SQL_Main ,
          [ _RegID, DateToStr( F_DtBeg - 60 ), DateToStr( F_DtBeg ), DateToStr( F_DtEnd ) ] ) ;

         MyOpenIBDS( Dset, _SQL );

        dset.first;
        while not dset.eof do
          begin
          if AntiDouble then
           begin
             ResultDset.Append;
             for i:= 0 to ResultDset.FieldCount - 2 do
               begin
                 if (dset.FieldByName(ResultDset.Fields[i].FieldName).IsNull) and
                 ( ResultDset.Fields[i].DataType = ftString ) then ResultDset.Fields[i].AsString := ' '
                      else
                      begin
                          if (dset.FieldByName(ResultDset.Fields[i].FieldName).DataType = ftDateTime) then
                           ResultDset.Fields[i].AsDateTime := int(dset.FieldByName(ResultDset.Fields[i].FieldName).AsFloat)
                          else ResultDset.Fields[i].AsString := dset.FieldByName(ResultDset.Fields[i].FieldName).AsString;
                      end;
                end;
                ResultDset.FieldByName('Region').AsString := dset_reg.fieldbyname('name').AsString;
               ResultDset.Post;
           end;
           dset.Next;
          end; //while not dset.eof
    end;


begin

 if F_RegionsID <> '' then RegCondition := ' and (id in '+ F_RegionsID + ') '
      else RegCondition := '';

 _sql_reg := 'select id, name from s_regions '+
    ' where 1=1 '+ RegCondition +
    ' order by id';

 MyOpenIBDS( Dset_reg, _sql_reg );
  dset_reg.Last;
  _progress_shag := GetProgressShagLength( 100, dset_Reg.RecordCount );
  dset_reg.First;
  SQL_Main := 'select id_order, order_number, adres, exc_square,'+
           ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
           ' raskop_dt, ex.dtime dt_sheb,'+
           ' ( select dtime from excavations where fk_excavations_orders = o.id and fk_excavations_excwt = 5 ) dt_asf,'+
           ' id_dmgloc, last_exc_wrktype, blag_dt, pplan_dt'+
           ' from get_blag2( %s,  ''%s'', ''%s'', ''%s'' )'+
           ' join excavations ex on (ex.fk_excavations_orders = id_order and ex.fk_excavations_excwt = 11)'+
           ' left join orders o on ( o.id = id_order )';

 if ResultDset.Active then ResultDset.Close;
 ResultDset.Open;

 Dset_reg.First;
 while not Dset_reg.Eof do
  begin
   if F_IsStopProgress then exit;  
   AddToResultDset;
   IncProgressStatus( _progress_shag );
   Dset_reg.Next;
  end;//while not Dset_reg.Eof



end;


end.
