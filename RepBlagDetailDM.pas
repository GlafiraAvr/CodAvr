unit RepBlagDetailDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, kbmMemTable, IBDatabase,
  IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  TDetailInfo = (
    diNull,
    diNeedRestore,
    diNeedRestoreGran,
    diPlanRestore,
    diRestoredPlan,
    diNewExc,
    diRestoredNoplan,
    diInWork,
    diOstatGran,
    diTotalRestored);

  Tdm_RepBlagDetail = class(Tdm_NGReportBase)
    ResultDset: TkbmMemTable;
    ResultDsetid_order: TIntegerField;
    ResultDsetbit_mask: TIntegerField;
    ResultDsetraskop_dt: TDateTimeField;
    ResultDsetordernumber: TIntegerField;
    ResultDsetdatecoming: TDateTimeField;
    ResultDsetregion: TStringField;
    ResultDsetdamageplace: TStringField;
    ResultDsetdamagelocality: TStringField;
    ResultDsetadres: TStringField;
    dset: TIBDataSet;
    tran: TIBTransaction;
    ResultDsetmain_gr: TIntegerField;
    frDBResult: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    F_DetailInfo: TDetailInfo;
    F_SessionID: integer;
    procedure FillResultDset;
  public
    property DetailInfo: TDetailInfo read F_DetailInfo write F_DetailInfo;
    property SessionID: integer read F_SessionID write F_SessionID;
    procedure PrepareDset;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepBlagDetail }

procedure Tdm_RepBlagDetail.FillResultDset;
var
  i: integer;
  _cond: string;
begin
  if F_DetailInfo = diNull then exit;

  ResultDset.Close;
  ResultDset.Open;

  case F_DetailInfo of
    diNeedRestore:     _cond:= '( bin_and( b.bit_mask, 1 ) = 1 )';
    diNeedRestoreGran: _cond:= '( bin_and( b.bit_mask, 2 ) = 2 )';
    diPlanRestore:     _cond:= '( bin_and( b.bit_mask, 4 ) = 4 )';
    diRestoredPlan:    _cond:= '( bin_and( b.bit_mask, 8 ) = 8 )';
    diNewExc:          _cond:= '( bin_and( b.bit_mask, 16 ) = 16 )';
    diRestoredNoplan:  _cond:= '( bin_and( b.bit_mask, 32 ) = 32 )';
    diInWork:          _cond:= '(' +
                               '   ( (bin_and( b.bit_mask, 1 ) = 1 ) and (bin_and( b.bit_mask, 8 ) = 0 ) and' +
                               '     (bin_and( b.bit_mask, 32 ) = 0 ) )' +
                               '   or' +
                               '   ( (bin_and( b.bit_mask, 16 ) = 16 ) and (bin_and( b.bit_mask, 32 ) = 0 ) )'+
                               ')';
    diOstatGran:       _cond:= '( bin_and( b.bit_mask, 64 ) = 64 )';
    diTotalRestored:   _cond:= '( (bin_and( b.bit_mask, 8 ) = 8 ) or (bin_and( b.bit_mask, 32 ) = 32 ) )';
  end;

  MyOpenIBDS( dset,
    ' select b.id_order, b.bit_mask,  b.raskop_dt,' +
    ' o.ordernumber, o.datecoming,' +
    ' sr.name as region, sdp.name as DamagePlace,' +
    ' sdl.name as DamageLocality,' +
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,' +
    '     o.housenum, o.additionaladdress)) adres' +
    ' from tmp_blag b' +
    ' left join orders o on o.id = b.id_order' +
    ' left join s_regions sr on sr.id = o.fk_orders_regions' +
    ' left join s_damageplace sdp on sdp.id = o.fk_orders_damageplace' +
    ' left join s_damagelocality sdl on sdl.id = o.fk_orders_damagelocality' +
    ' where ( b.session_id = ' + IntToStr( F_SessionID ) + ' ) and ' +
    _cond +
    ' order by sr.name, o.datecoming' );

  dset.First;
  while not dset.Eof do
  begin
    ResultDset.Append;
    for i:=0 to dset.FieldCount -1 do
      ResultDset.FieldByName( dset.Fields[i].FieldName ).Value := dset.Fields[i].Value;
    ResultDset.FieldByName( 'main_gr' ).AsInteger := 1;
    ResultDset.Post;
    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepBlagDetail.PrepareDset;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_RepBlagDetail.PrepareDset)';
      raise;
    end;
  end;
end;

procedure Tdm_RepBlagDetail.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_DetailInfo := diNull;
  F_SessionID := -1;
end;

end.
