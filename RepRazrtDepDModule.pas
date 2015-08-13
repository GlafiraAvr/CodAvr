unit RepRazrtDepDModule;     //Сводка по местам разрытия

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB,
  kbmMemTable, IBDatabase, IBCustomDataSet;

type
  Tdm_RazrtDep = class(Tdm_NGReportBase)
    dset_OrderInfo: TIBDataSet;
    tran: TIBTransaction;
    dset: TIBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetPlanStartDate: TDateTimeField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetregion: TStringField;
    ResultDsetPlanStartTime: TStringField;
    frDBResult: TfrDBDataSet;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_RegionID: integer;
     procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property RegionID: integer read F_RegionID write F_RegionID;
    function PrepareDset: boolean;
  end;

var
  dm_RazrtDep: Tdm_RazrtDep;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tdm_RazrtDep.FillResultDset;
var _on, _ton : integer;
    _RegCond, _SQL: string;
begin
  _on := 0;
  ResultDset.Close;
  ResultDset.Open;


  if F_RegionID > 0 then
     _RegCond := ' and o.fk_orders_regions = '+ IntToStr( F_RegionID )
     else _RegCond := '';

  _SQL := 'select o.ordernumber,'+
    '(select s.name from s_regions s where s.id=o.fk_orders_regions) region,'+
    '(select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets, o.housenum, o.additionaladdress)) adres, '+
    '( select min(d.startdate) from departures d, departureworks dw '+
    ' where dw.fk_depworks_departure = d.id and o.id=dw.fk_depworks_order and dw.fk_depworks_work in (1,268435481,266435476)) startdate'+
    ' from orders o '+
    ' where not (o.fk_orders_damagelocality in (-1, 4))'+
    ' and (o.DateComing>''01.01.2004'')'+
    ' and (o.IsClosed=1)'+
    ' and (o.lastexcwrktype in (2,3,9))'+
    ' and (o.fk_orders_damageplace in (1,2))'+
    ' order by 2';

   MyOpenIBDS( dset, _SQL);
   
  dset.First;
  while not dset.Eof do
  begin
    _ton := dset.FieldByName( 'OrderNumber' ).AsInteger;
    if _on <>  _ton then
    begin
      _on := _ton;
      with ResultDset do
      begin
        Append;
        FieldByName( 'PlanStartDate' ).AsString :=formatdatetime('dd.mm.yy hh:mm', dset.FieldByName( 'startdate' ).AsDateTime);

        FieldByName( 'Adres' ).AsString := dset.FieldByName( 'adres' ).AsString;
        FieldByName( 'OrderNumber' ).AsInteger := _on;  // dset.FieldByName( 'OrderNumber' ).AsInteger;
        FieldByName( 'region' ).AsString := dset.FieldByName( 'region' ).AsString;
        Post;
      end;
    end;
    dset.Next;
  end;
  dset.Close;
end;

function Tdm_RazrtDep.PrepareDset: boolean;
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
      raise Exception.Create( E.Message + '(Tdm_PlanDep.PrepareDset)' );
    end;
  end;
end;





end.
