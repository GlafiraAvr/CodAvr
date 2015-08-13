unit RepVipolNaryadDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, IBDatabase, DB,
  kbmMemTable, IBCustomDataSet, DateUtils, FR_DSet, FR_DBSet;

type

  TRV_SortType = ( srAdres, srDateComing, srOrdrerNumber );


  Tdm_RepVipolNaryad = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TkbmMemTable;
    dset: TIBDataSet;
    ResultDsetid_order: TIntegerField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetAdres: TStringField;
    ResultDsetWorkTime: TFloatField;
    ResultDsetkol: TFloatField;
    ResultDsetDiam: TStringField;
    dset_OrderInfo: TIBDataSet;
    frDBResult: TfrDBDataSet;
    ResultDsetFullWorkTime: TFloatField;
    ResultDsetkol_norm: TFloatField;
    ResultDsetWorkName: TStringField;
    ResultDsetrow_num: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure frReportBeginPage(pgNo: Integer);
    procedure frReportBeforePrint(Memo: TStringList; View: TfrView);
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
  private
    F_RegionID,
    F_work_kol,
    F_WorkTypeID: integer;
    F_BeginDate,
    F_EndDate: TDateTime;
    F_SortType: TRV_SortType;
    procedure FillResultDset;
  public
    property work_kol: integer read F_work_kol write F_work_kol;
    property RegionID: integer read F_RegionID write F_RegionID;
    property WorkTypeID: integer read F_WorkTypeID write F_WorkTypeID;
    property BeginDate: TDateTime read F_BeginDate write F_BeginDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property SortType: TRV_SortType read F_SortType write F_SortType;
    procedure PrepareDset;
    function GetRecordCount():integer;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepVipolNaryad }

procedure Tdm_RepVipolNaryad.FillResultDset;
var
  _works,_sort: string;
  i{, work_kol}: integer;
  _old_id_order, _id_order, _row_num: integer;
  //_view: TfrView;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS( dset,
    ' select id_work' +
    ' from s_worktype_work' +
    ' where id_worktype = ' + IntToStr( F_WorkTypeID ) );

  if not dset.IsEmpty then
  begin
    {Работы}
    _works := '';
    dset.First;
    work_kol:=0;
    while not dset.Eof do
    begin
      _works := _works + ',' + dset.FieldByName( 'id_work' ).AsString;
      work_kol:=work_kol+1;
      dset.Next;
    end;
 //   if work_kol=1 then
{      begin
       _view := frReport.FindObject( 'SumKol' );
       if _view <> nil then
          if work_kol=1 then
          (_view as TfrMemoView).Visible := True ;
          else
          (_view as TfrMemoView).Visible := false;
      end;}

    System.Delete( _works, 1, 1);
    {/Работы}
    {Сортировка}
    case SortType of
        srAdres       : _sort:=' order by ss.name, o.housenum , o.id,' +
                                ' sw.name, std.diameter, dw.work_time';
        srDateComing  : _sort:=' order by  d.enddate , ss.name, o.housenum, o.id,' +
                                ' sw.name, std.diameter';
        srOrdrerNumber: _sort:=' order by o.id , ss.name, o.housenum, ' +
                                ' sw.name, std.diameter, dw.work_time';
    end;
    {/Сортировка}     
    //
    MyOpenIBDS( dset,
      ' select dw.fk_depworks_order,' +
      ' sw.name work_name, std.diameter, dw.work_time,' +
      ' dw.measur_quantity,ss.name,o.housenum,o.id,'+
      '  o.ordernumber,  d.enddate,'+
      ' sum( dw.quantity ) kol' +
      ' from departures d, departureworks dw' +
      ' left join orders o on o.id = dw.fk_depworks_order' +
      ' left join s_streets ss on ss.id = o.fk_orders_streets' +
      ' left join s_works sw on sw.id = dw.fk_depworks_work' +
      ' left join s_tubediameter std on std.id = dw.fk_depworks_diameter' +
      ' where ( d.id = dw.fk_depworks_departure )' +
      ' and ( d.startdate >= ''' + DateToStr( F_BeginDate ) + ''' )' +
      ' and ( d.startdate <= ''' + DateToStr( F_EndDate + 1 ) + ''' )' +
      ' and dw.fk_depworks_work in (' + _works + ')' +
      ' and ( o.fk_orders_regions = ' + IntToStr( F_RegionID ) + ' )' +
      ' and ( d.depnumber <> 1 )' +
      ' group by 1,2,3,4,5,6,7,8,9,10' +  _sort);
//      ' order by ss.name, o.housenum, o.id,' +
//      ' sw.name, std.diameter, dw.work_time' );

    _old_id_order := -1;
    _row_num := 0;
    dset.First;

    while not dset.Eof do
    begin
      ResultDset.Append;

      dset_OrderInfo.Close;
      dset_OrderInfo.ParamByName( 'pOrderID' ).AsInteger := dset.FieldByName( 'fk_depworks_order' ).AsInteger;
      dset_OrderInfo.Open;

      _id_order := dset.FieldByName( 'fk_depworks_order' ).AsInteger;
      ResultDset.FieldByName( 'id_order' ).AsInteger := _id_order;
//      if (_old_id_order <> _id_order) or (SortType<>srAdres) then
      begin
        inc( _row_num );
        _old_id_order := _id_order;
        ResultDset.FieldByName( 'row_num' ).AsInteger := _row_num;
        ResultDset.FieldByName( 'OrderNumber' ).AsInteger := dset_OrderInfo.FieldByName( 'OrderNumber' ).AsInteger;
        ResultDset.FieldByName( 'Adres' ).AsString := dset_OrderInfo.FieldByName( 'Adres' ).AsString;
      end;

      ResultDset.FieldByName( 'WorkTime' ).AsFloat := dset.FieldByName( 'work_time' ).AsFloat;
      ResultDset.FieldByName( 'kol' ).AsFloat := dset.FieldByName( 'kol' ).AsFloat;
      ResultDset.FieldByName( 'kol_norm' ).AsFloat := dset.FieldByName( 'measur_quantity' ).AsFloat;;
      if work_kol=1 then  // чтобы не повторять одно и то-же во всех строках
          ResultDset.FieldByName( 'WorkName' ).AsString := ''
        else
          ResultDset.FieldByName( 'WorkName' ).AsString := dset.FieldByName( 'work_name' ).AsString;
      if dset.FieldByName( 'diameter' ).AsInteger > 0 then
        ResultDset.FieldByName( 'Diam' ).AsString := '(d= ' + dset.FieldByName( 'diameter' ).AsString + ')';
      ResultDset.FieldByName( 'FullWorkTime' ).AsFloat :=
        ( dset.FieldByName( 'work_time' ).AsFloat/dset.FieldByName( 'measur_quantity' ).AsFloat ) * dset.FieldByName( 'kol' ).AsFloat;

      ResultDset.Post;
      dset.Next;
    end;
    dset_OrderInfo.Close;
  end;
  dset.Close;
end;

procedure Tdm_RepVipolNaryad.PrepareDset;
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
      raise Exception.Create( E.Message + '(Tdm_RepVipolNaryad.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_RepVipolNaryad.DataModuleCreate(Sender: TObject);
begin
  inherited;
//
//  frReport.OnBeforePrint:=Tdm_RepVipolNaryad.frReportGetValue;

end;

procedure Tdm_RepVipolNaryad.frReportBeginPage(pgNo: Integer);
var   _view, _NRow: TfrView;
begin
  inherited;
//
       _view := frReport.FindObject( 'Mem_Npp1' );
       _NRow := frReport.FindObject( 'NRow' );
       if (_view <> nil) and (_NRow <> nil) then
        begin
           //
         (_view as TfrMemoView).Visible := True
        end;
  
end;

procedure Tdm_RepVipolNaryad.frReportBeforePrint(Memo: TStringList;
  View: TfrView);
  var   _view: TfrView;
begin
  inherited;
//
       _view := frReport.FindObject( 'SumKol' );
       if _view <> nil then
          if work_kol=1 then
          (_view as TfrMemoView).Visible := True
          else
          (_view as TfrMemoView).Visible := false;
end;


procedure Tdm_RepVipolNaryad.frReportGetValue(const ParName: String;
  var ParValue: Variant);

 { procedure _PrepValue( var _OldValue: variant; var _NewValue: variant; _view: TfrView );
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
  end;}
var
  _view: TfrView;
  _DepID: integer;
begin
 {
  if Pos( '', AnsiUpperCase( ParName ) ) <> 0 then
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
  end;}
end;


function Tdm_RepVipolNaryad.GetRecordCount():integer;
 function count():integer;
 begin
   MyOpenIBDS(dset,
              '  select count (o.id) from '+
              '  departures d, departureworks dw'+
              '  left join orders o on o.id = dw.fk_depworks_order'+
              '  where ( d.id = dw.fk_depworks_departure )'+
              '  and ( d.startdate >= ''' + DateToStr( F_BeginDate ) + ''' )'+
              '  and ( d.startdate <= ''' + DateToStr( F_EndDate + 1 ) + '''  ) '+
              '  and dw.fk_depworks_work in (select id_work'+
              '                     from s_worktype_work  sww'+
              '                      where  id_worktype ='+ IntToStr( F_WorkTypeID )+')'+
              '  and ( o.fk_orders_regions = ' + IntToStr( F_RegionID ) + '  )'+
              '  and ( d.depnumber <> 1 )');
    dset.First;
    Result:=dset.Fields[0].AsInteger;
 end;
begin
  Result:=0;
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    Result:=Count;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepVipolNaryad.Count)' );
    end;
  end;

end;

end.
