unit AvarOnMapReportDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, IBDatabase, DB,
  IBCustomDataSet;

type
  Tdm_AvarOnMapReport = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    tran: TIBTransaction;
    dset_Order: TIBDataSet;
    dset_Bolts: TIBDataSet;
    dset_BoltsCLOSEDATE: TDateTimeField;
    dset_BoltsOPENDATE: TDateTimeField;
    dset_BoltsBRIGCLOSE: TIBStringField;
    dset_BoltsBRIGOPEN: TIBStringField;
    dset_BoltsTUBEDIAM: TIntegerField;
    dset_BoltsADRES: TIBStringField;
    dset_BoltsFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField;
    dset_BoltsFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField;
    dset_Maters: TIBDataSet;
    dset_MatersKOL: TIBBCDField;
    dset_MatersMATER: TIBStringField;
    dset_MatersDIAMETER: TIntegerField;
    dset_MatersMEASUREMENT: TIBStringField;
    dset_MatersMATER_NAME: TStringField;
    dset_Workers: TIBDataSet;
    dset_WorkersNAME: TIBStringField;
    dset_Equips: TIBDataSet;
    dset_EquipsNAME: TIBStringField;
    dset_EquipsNUMBER: TIntegerField;
    dset_EquipsEQUIP_NAME: TStringField;
    dset_WorkersPOST: TIBStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_BoltsAfterOpen(DataSet: TDataSet);
    procedure dset_BoltsBRIGCLOSEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_BoltsBRIGOPENGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_MatersCalcFields(DataSet: TDataSet);
    procedure dset_MatersAfterOpen(DataSet: TDataSet);
    procedure dset_WorkersAfterOpen(DataSet: TDataSet);
    procedure dset_EquipsCalcFields(DataSet: TDataSet);
    procedure dset_EquipsAfterOpen(DataSet: TDataSet);
  private
    F_OrderID: integer;
    F_AvarOnMapID: integer;
    F_Works: string;
    F_CDPBolts: string;
    F_BeginWork, F_EndWork: string;
    F_LastBrig: string;
    procedure SetAvarOnMapID;
    procedure SetWorks;
    procedure SetCDPBolts;
    procedure SetWorkTimeAndLastBrig;
  private
    F_BoltsCount, F_MatersCount,
    F_WorkersCount, F_EquipsCount: integer;
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
    function GetFieldValue( _DataSet: TDataSet; _FieldName: string; _RecCount, _RecIndex: integer): variant;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    property AvarOnMapID: integer read F_AvarOnMapID;
    property Works: string read F_Works;
    property CDPBolts: string read F_CDPBolts;
    property BeginWork: string read F_BeginWork;
    property EndWork: string read F_EndWork;
    property LastBrig: string read F_LastBrig;
    function PrepareDsets: boolean;
    procedure StartTransaction;
    procedure StopTransaction;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, AomComClientDModule;

{ Tdm_AvarOnMapReport }

procedure Tdm_AvarOnMapReport.frReportGetValue(const ParName: String;
  var ParValue: Variant);
var
  i,j1,j2,_ind:integer;
begin
  i := POS( 'ARR',ParName );
  if i <> 0 then
  begin
    i := POS( '[',ParName );
    j1 := i;
    j2 := POS( ']', ParName );
    _ind := StrToInt( Copy( ParName, j1+1, j2-j1-1 ) );
    if POS( 'ZADV_', ParName ) <> 0 then
    begin
      if POS( 'ZADV_ADDR', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'Adres', F_BoltsCount, _ind )
      else
      if POS( 'ZADV_DIAM', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'TubeDiam', F_BoltsCount, _ind )
      else
      if POS( 'ZADV_FIO_ZAKR', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'BrigClose', F_BoltsCount, _ind )
      else
      if POS( 'ZADV_DATE_ZAKR', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'CloseDate', F_BoltsCount, _ind )
      else
      if POS( 'ZADV_FIO_OTKR', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'BrigOpen', F_BoltsCount, _ind )
      else
      if POS( 'ZADV_DATE_OTKR', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Bolts, 'OpenDate', F_BoltsCount, _ind );
    end else
    if POS( 'MATER_', ParName ) <> 0 then
    begin
      if POS( 'MATER_NAME', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Maters, 'Mater_Name', F_MatersCount, _ind )
      else
      if POS( 'MATER_ED_IZM', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Maters, 'Measurement', F_MatersCount, _ind )
      else
      if POS( 'MATER_FAKT', ParName ) <> 0 then
        ParValue  := GetFieldValue( dset_Maters, 'kol', F_MatersCount, _ind );
    end else
    if POS( 'RABOT_', ParName ) <> 0 then
    begin
      if POS( 'RABOT_CHEL', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Workers, 'Name', F_WorkersCount, _ind )
      else
      if POS( 'RABOT_DOLZHN', ParName ) <> 0 then
        ParValue := GetFieldValue( dset_Workers, 'Post', F_WorkersCount, _ind )
    end else
    if POS( 'MEXAN', ParName ) <> 0 then
    begin
      ParValue := GetFieldValue( dset_Equips, 'Equip_Name', F_EquipsCount, _ind );
    end;
  end;
end;

function Tdm_AvarOnMapReport.PrepareDsets: boolean;
var
  _DsetArr: array[0..4] of TIBDataSet;
  i: integer;
begin
  _DsetArr[0] := dset_Order;
  _DsetArr[1] := dset_Bolts;
  _DsetArr[2] := dset_Maters;
  _DsetArr[3] := dset_Workers;
  _DsetArr[4] := dset_Equips;

  for i:=low( _DsetArr ) to High( _DsetArr ) do
  begin
    _DsetArr[i].Close;
    _DsetArr[i].ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
    _DsetArr[i].Open;
  end;

  SetAvarOnMapID;
  SetWorks;
  SetCDPBolts;
  SetWorkTimeAndLastBrig;
end;

procedure Tdm_AvarOnMapReport.StartTransaction;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_AvarOnMapReport.StopTransaction;
begin
  if tran.InTransaction then tran.Commit;
end;

procedure Tdm_AvarOnMapReport.DataModuleCreate(Sender: TObject);
begin
  inherited;
  frReport.OnGetValue := frReportGetValue;
end;

function Tdm_AvarOnMapReport.GetFieldValue(_DataSet: TDataSet;
  _FieldName: string; _RecCount, _RecIndex: integer): variant;
var
  _RecN: integer;
begin
  _RecN := _RecIndex + 1;
  if _RecN <= _RecCount then
  begin
    _DataSet.RecNo := _RecN;
    Result := _DataSet.FieldByName( _FieldName ).Value;  
  end;
end;

procedure Tdm_AvarOnMapReport.dset_BoltsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dset_Bolts.Last;
  dset_Bolts.First;
  F_BoltsCount := dset_Bolts.RecordCount;
end;

procedure Tdm_AvarOnMapReport.dset_BoltsBRIGCLOSEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Bolts.FieldByName('FK_CLOSEDBOLTS_BRIGADIERSCLOSE').AsInteger <= 0 then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure Tdm_AvarOnMapReport.dset_BoltsBRIGOPENGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Bolts.FieldByName('FK_CLOSEDBOLTS_BRIGADIEROPEN').AsInteger <= 0 then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure Tdm_AvarOnMapReport.dset_MatersCalcFields(DataSet: TDataSet);
begin
  inherited;
  if not DataSet.FieldByName( 'DIAMETER' ).IsNull then
    DataSet.FieldByName( 'MATER_NAME' ).AsString := trim( DataSet.FieldByName( 'MATER' ).AsString ) +
      ' (' +
        trim( DataSet.FieldByName( 'DIAMETER' ).AsString ) +
      ')'
  else
    DataSet.FieldByName( 'MATER_NAME' ).AsString  := trim( DataSet.FieldByName( 'MATER' ).AsString );
end;

procedure Tdm_AvarOnMapReport.dset_MatersAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dset_Maters.Last;
  dset_Maters.First;
  F_MatersCount := dset_Maters.RecordCount;
end;

procedure Tdm_AvarOnMapReport.dset_WorkersAfterOpen(DataSet: TDataSet);
begin
  dset_Workers.Last;
  dset_Workers.First;
  F_WorkersCount := dset_Workers.RecordCount;
end;

procedure Tdm_AvarOnMapReport.dset_EquipsCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName( 'EQUIP_NAME' ).AsString := trim( DataSet.FieldByName('NAME').AsString ) + ' №'+
                                                  trim( DataSet.FieldByName( 'NUMBER' ).AsString );
end;

procedure Tdm_AvarOnMapReport.dset_EquipsAfterOpen(DataSet: TDataSet);
begin
  dset_Equips.Last;
  dset_Equips.First;
  F_EquipsCount := dset_Equips.RecordCount;
end;

procedure Tdm_AvarOnMapReport.SetAvarOnMapID;
begin
  F_AvarOnMapID := EncodeAomID( dset_Order.FieldByName( 'OrderNumber' ).AsInteger,
                         dset_Order.FieldByName( 'DateComing' ).AsDateTime );
end;

procedure Tdm_AvarOnMapReport.SetWorks;
var
  _wrk, _measur, _length, _width, _depth: string;
begin
  F_Works := '';

  MyOpenIBDS( dset,
    ' select w.name, td.diameter, dw.additionalinfo, dw.exc_depth, dw.exc_length, dw.exc_width ,' +
    ' sm.name measurement, sum(dw.quantity) kol' +
    ' from departureworks dw' +
    ' left join s_works w on dw.fk_depworks_work=w.id' +
    ' left join s_tubediameter td on dw.fk_depworks_diameter=td.id' +
    ' left join s_measurement sm on sm.id=w.id_measurement' +
    ' left join departures d on d.id=dw.FK_DEPWORKS_DEPARTURE' +
    ' where dw.fk_depworks_order=' + IntToStr( F_OrderID ) +
    ' and d.DepNumber <> 1' +
    ' group by w.name, td.diameter, dw.additionalinfo, sm.name, dw.exc_depth, dw.exc_length, dw.exc_width' //+
    //' order by w.name, td.diameter'
   // ' order by dw.id'
   // ' order by dw.num_work'
    );

  dset.First;
  while not dset.Eof do
  begin
    _wrk := trim( dset.FieldByName( 'name' ).AsString );
    if ( not dset.FieldByName( 'diameter' ).IsNull ) and ( dset.FieldByName( 'diameter' ).AsInteger > 0 ) then
      _wrk := _wrk + ' d=' + trim( dset.FieldByName('diameter').AsString );
    if not dset.FieldByName( 'kol' ).IsNull then
    begin
      _measur := trim( dset.FieldByName( 'measurement' ).AsString );
        if dset.FieldByName( 'exc_length' ).IsNull then
         begin
           if _measur = '' then _measur := 'ед.';
           _wrk := _wrk + ' (' + trim( dset.FieldByName('kol').AsString ) + ' ' + _measur + ')';
         end
          else
            begin
              _length := trim( dset.FieldByName( 'exc_length' ).AsString );
              _width := trim( dset.FieldByName( 'exc_width' ).AsString );
              _depth := trim( dset.FieldByName( 'exc_depth' ).AsString );
              _measur := _length + ' x ' + _width + ' x ' + _depth;
              _wrk := _wrk + ' (' + _measur + ')';
             end;


    end;
    F_Works := F_Works + '; ' + trim( _wrk + ' ' + dset.FieldByName( 'additionalinfo' ).AsString );
    dset.Next;
  end;
  dset.Close;

  Delete( F_Works, 1, 2);
end;

procedure Tdm_AvarOnMapReport.SetCDPBolts;
begin
  F_CDPBolts := '';

  MyOpenIBDS( dset,
    ' select' +
    '     (select adres from' +
    '     get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_streets,' +
    '     b.housenum, b.additionaladdress)) as Adres' +
    ' from closedbolts b' +
    ' where b.fk_closedbolts_officialpost_ins = 1'+
    ' and b.fk_closedbolts_orders=' + IntToStr( F_OrderID ) );

  dset.First;
  while not dset.Eof do
  begin
    F_CDPBolts := F_CDPBolts + '; ' + trim( dset.FieldByName('Adres').AsString );
    dset.Next;
  end;
  dset.Close;

  Delete( F_CDPBolts, 1, 2 );
end;

procedure Tdm_AvarOnMapReport.SetWorkTimeAndLastBrig;
begin
  MyOpenIBDS( dset,
    ' select StartDate, EndDate,' +
    ' (select name from brigadiers where id=d.fk_departures_brigadiers) Brig' +
    ' from Departures d' +
    ' where DepNumber>1 and' +
    ' fk_departures_orders=' + IntToStr( F_OrderID ) +
    ' order by DepNumber, StartDate' );
  dset.First;
  if not( dset.Eof and dset.Bof ) then
  begin
    F_BeginWork := dset.FieldByName( 'StartDate' ).AsString;
    dset.Last;
    F_EndWork := dset.FieldByName( 'EndDate' ).AsString;
    F_LastBrig := dset.FieldByName( 'Brig' ).AsString;
  end else
  begin
    F_BeginWork := '';
    F_EndWork := '';
    F_LastBrig := '';
  end;
end;


end.
