unit RepTrudoZatratDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, IBDatabase, DB,
  IBCustomDataSet, kbmMemTable, FR_DSet, FR_DBSet;

type
  TfrValueRec=record
    Adres, OrderNumber, DepID: variant;
  end;

  Tdm_RepTrudoZatrat = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    dset_OrderInfo: TIBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetid_order: TIntegerField;
    ResultDsetid_dep: TIntegerField;
    ResultDsetStartDate: TDateTimeField;
    ResultDsetWorkName: TStringField;
    ResultDsetDiam: TIntegerField;
    ResultDsetWorkTime: TFloatField;
    ResultDsetAdres: TStringField;
    ResultDsetOrderNumber: TIntegerField;
    frDBResult: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    F_DtBeg,
    F_DtEnd: TDateTime;
    F_RegionID: integer;
    F_frValueRec: TfrValueRec;
    procedure FillResultDset;
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
  public
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    property RegionID: integer read F_RegionID write F_RegionID;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepTrudoZatrat }

procedure Tdm_RepTrudoZatrat.FillResultDset;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS( dset,
    ' select dw.fk_depworks_order, dw.fk_depworks_departure, d.startdate,' +
    ' sw.name work_name, std.diameter,' +
    ' sum((dw.work_time/dw.measur_quantity)*dw.quantity) work_time' +
    ' from departures d, departureworks dw' +
    ' left join orders o on o.id = dw.fk_depworks_order' +
    ' left join s_streets ss on ss.id = o.fk_orders_streets' +
    ' left join s_works sw on sw.id = dw.fk_depworks_work' +
    ' left join s_tubediameter std on std.id = dw.fk_depworks_diameter' +
    ' where ( d.id = dw.fk_depworks_departure )' +
    ' and ( d.startdate >= ''' + DateToStr( F_DtBeg ) + ''' )' +
    ' and ( d.startdate <= ''' + DateToStr( F_DtEnd + 1 ) + ''' )' +
    ' and ( o.fk_orders_regions = ' + IntToStr( F_RegionID ) + ' )' +
    ' and ( d.depnumber <> 1 )' +
    ' group by dw.fk_depworks_order, dw.fk_depworks_departure, d.startdate,' +
    ' sw.name, std.diameter' );//+
{    ' order by ss.name, o.housenum, o.id,' +
    ' d.startdate, dw.fk_depworks_departure,' +
    ' sw.name, std.diameter' );
 }
  dset.First;
  while not dset.Eof do
  begin
    dset_OrderInfo.Close;
    dset_OrderInfo.ParamByName( 'pOrderID' ).AsInteger :=
      dset.FieldByName( 'fk_depworks_order' ).AsInteger;
    dset_OrderInfo.Open;

    with ResultDset do
    begin
      Append;
      FieldByName( 'id_order' ).AsInteger := dset.FieldByName( 'fk_depworks_order' ).AsInteger;
      FieldByName( 'id_dep' ).AsInteger := dset.FieldByName( 'fk_depworks_departure' ).AsInteger;
      FieldByName( 'StartDate' ).AsDateTime := dset.FieldByName( 'startdate' ).AsDateTime;
      FieldByName( 'WorkName' ).AsString := dset.FieldByName( 'work_name' ).AsString;
      FieldByName( 'WorkTime' ).AsFloat := dset.FieldByName( 'work_time' ).AsFloat;
      FieldByName( 'Diam' ).AsInteger := dset.FieldByName( 'diameter' ).AsInteger;
      FieldByName( 'Adres' ).AsString := dset_OrderInfo.FieldByName( 'adres' ).AsString;
      FieldByName( 'OrderNumber' ).AsInteger := dset_OrderInfo.FieldByName( 'OrderNumber' ).AsInteger;
      Post;
    end;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_RepTrudoZatrat.frReportGetValue(const ParName: String;
  var ParValue: Variant);

  procedure _PrepValue( var _OldValue: variant; var _NewValue: variant; _view: TfrView );
  begin
    if _view <> nil then
    begin
      if _OldValue <> _NewValue then
      begin
        (_view as TfrMemoView).FrameTyp := 13;
        _OldValue := _NewValue;
      end else
      begin
        (_view as TfrMemoView).FrameTyp := 5;
        _NewValue := '';
      end;
    end;
  end;
var
  _view: TfrView;
  _DepID: integer;
begin
  if Pos( 'ORDERNUMBER', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'OrderNumber' ).AsInteger;
    _PrepValue( F_frValueRec.OrderNumber, ParValue,
      frReport.FindObject( 'mem_OrderNumber' ) );
  end else
  if Pos( 'ADRES', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    ParValue := ResultDset.FieldByName( 'Adres' ).AsString;
    _PrepValue( F_frValueRec.Adres, ParValue,
      frReport.FindObject( 'mem_Adres' ) );
  end else
  if Pos( 'STARTDATE', AnsiUpperCase( ParName ) ) <> 0 then
  begin
    _view := frReport.FindObject( 'mem_StartDate' );
    if _view <> nil then
    begin
      _DepID := ResultDset.FieldByName( 'id_dep' ).AsInteger;
      if F_frValueRec.DepID <> _DepID then
      begin
        (_view as TfrMemoView).FrameTyp := 13;
        F_frValueRec.DepID := _DepID;
        ParValue := ResultDset.FieldByName( 'StartDate' ).AsDateTime;
      end else
      begin
        ParValue := 0;
        (_view as TfrMemoView).FrameTyp := 5;
      end;
    end;
  end;
end;

function Tdm_RepTrudoZatrat.PrepareDset: boolean;
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
      raise Exception.Create( E.Message + '(Tdm_RepTrudoZatrat.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_RepTrudoZatrat.DataModuleCreate(Sender: TObject);
begin
  inherited;
  frReport.OnGetValue := frReportGetValue;

  F_frValueRec.OrderNumber := -1;
  F_frValueRec.Adres := '';
  F_frValueRec.DepID := -1;
end;

end.
