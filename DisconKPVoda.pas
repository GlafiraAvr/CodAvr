unit DisconKPVoda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DModule, DB, IBCustomDataSet,
  FR_DSet, FR_DBSet, kbmMemTable, IBDatabase, DateUtils;

type
  Tdm_DisconKPVoda = class(Tdm_NGReportBase)
    Dset_DisconNS: TIBDataSet;
    Dset_DisconVDS: TIBDataSet;
    mt_Disconnections: TkbmMemTable;
    frDS_Disconnections: TfrDBDataSet;
    tran: TIBTransaction;
    tranVDS: TIBTransaction;
    mt_Disconnectionsordernumber: TIntegerField;
    mt_Disconnectionsregions: TStringField;
    mt_Disconnectionsadres: TStringField;
    mt_Disconnectionsdttm_discon: TDateTimeField;
    mt_Disconnectionsdttm_con: TDateTimeField;
    mt_Disconnectionsbase_prin: TStringField;
    dset_Regions: TIBDataSet;
    mt_Disconnectionsstr_dttm_con: TStringField;
    mt_Disconnectionshow_long: TStringField;
  private
    { Private declarations }
    F_DisconDate: TDateTime;
    F_NCDP: boolean;
    procedure PrepNSSQl(_reg: integer);
    procedure PrepVDSSQl(_reg: integer);
    procedure FillResultDset;
  public
    { Public declarations }
    property DisconDate: TDateTime write F_DisconDate;
    property NCDP: boolean write F_NCDP;    
    function PrepareDset: boolean;
  end;

var
  dm_DisconKPVoda: Tdm_DisconKPVoda;

implementation

{$R *.dfm}
//CONNECT 'tpo1:e:\!avrvds\data\avrvds.gdb' USER 'AVR_VDS' PASSWORD 'avr_vds_pwd';
procedure Tdm_DisconKPVoda.PrepNSSQl(_reg: integer);
begin
  Dset_DisconNS.SelectSQL.Text :=
  'select (select name from s_regions where id = o.fk_orders_regions ) regions '+
  ', o.ordernumber '+
  ', ( select adres from get_adres(0, d.fk_id_street, d.houses, d.additionalinfo) ) adres '+
  ',  d.dttm_discon, d.dttm_con '+
  'from disconnections d, orders o '+
  'where ( o.id = d.fk_id_order) '+
  ' and (o.fk_orders_regions = '+ inttostr(_reg) + ')' +
  ' and (d.dttm_discon<'''+ DateTimeToStr(F_DisconDate + 1) +''')'+
  ' and (d.dttm_con >='''+DateTimeToStr(F_DisconDate)+''' or d.dttm_con is null) order by d.dttm_discon';

end;

procedure Tdm_DisconKPVoda.PrepVDSSQl(_reg: integer);
begin
  Dset_DisconVDS.SelectSQL.Text :=
  'select '+
  ' (select name from s_regions where id = o.fk_orders_regions)  regions '+
  ', o.ordernumber '+
  ', (select adres from get_adres2(d.fk_discon_street,d.housenum, d.housingnum,d.porchnum, d.floornum,d.apartmentnum)) adres '+
  ', d.dttm_discon , d.dttm_con '+
  '  from disconnections_vds d, orders_vds o where (o.id = d.fk_discon_order ) '+
  ' and (o.fk_orders_regions = '+ inttostr(_reg) + ')' +
  ' and (d.dttm_discon<'''+ DateTimeToStr(F_DisconDate + 1) +''')'+
  ' and (d.dttm_con >='''+DateTimeToStr(F_DisconDate)+''' or d.dttm_con is null) order by d.dttm_discon';

end;

function Tdm_DisconKPVoda.PrepareDset: boolean;
begin
  Result := true;
 // DM_Main.ConnectVDS('AVR_VDS', 'avr_vds_pwd');
  if tranVDS.InTransaction then tranVDS.Rollback;
  if tran.InTransaction then tran.Rollback;
  tranVDS.startTransaction;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
    tranVDS.Commit;
   // DM_Main.DisconnectVDS;
  except
    on E: Exception do
    begin
      Result := false;
      tran.Rollback;
      tranVDS.Rollback;
     // DM_Main.DisconnectVDS;
      raise Exception.Create( E.Message + '(Tdm_DisconKPVoda.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_DisconKPVoda.FillResultDset;
var _reg: integer;
    _dttm_con, _dttm_discon: TDateTime;
    _how_long: integer;
begin
 if mt_Disconnections.Active then mt_Disconnections.Close;
 mt_Disconnections.Open;

   //
 if not dset_Regions.Active then dset_Regions.Open;
 dset_Regions.First;
 while not dset_Regions.Eof do
  begin
    _reg := dset_Regions.FieldByName('id').AsInteger;

    if Dset_DisconNS.Active then Dset_DisconNS.Close;
    if Dset_DisconVDS.Active then Dset_DisconVDS.Close;

    PrepNSSQl(_reg);
    PrepVDSSQl(_reg);

    Dset_DisconNS.Open;
    Dset_DisconVDS.Open;

    Dset_DisconNS.First;

   // mt_Disconnections.SortFields:= 'regions';

    while not Dset_DisconNS.Eof do
      begin
        //
        mt_Disconnections.Append;
        mt_Disconnections.FieldByName('ordernumber').AsInteger := Dset_DisconNS.FieldByName('ordernumber').AsInteger;
        mt_Disconnections.FieldByName('adres').AsString := Dset_DisconNS.FieldByName('adres').AsString;
        mt_Disconnections.FieldByName('regions').AsString := Dset_DisconNS.FieldByName('regions').AsString;
        _dttm_discon := Dset_DisconNS.FieldByName('dttm_discon').AsDateTime;
        mt_Disconnections.FieldByName('dttm_discon').AsDateTime := _dttm_discon;
        _dttm_con :=Dset_DisconNS.FieldByName('dttm_con').AsDateTime;
        mt_Disconnections.FieldByName('dttm_con').AsDateTime :=_dttm_con;
        if _dttm_con >0 then
          begin
            mt_Disconnections.FieldByName('str_dttm_con').AsString := Dset_DisconNS.FieldByName('dttm_con').AsString;
           if F_NCDP then _how_long:= (HoursBetween(_dttm_con, _dttm_discon)) div 24
                      else _how_long:= HoursBetween(_dttm_con, _dttm_discon);
          end
          else
          begin
            mt_Disconnections.FieldByName('str_dttm_con').AsString := ' ';
            if F_NCDP then _how_long:= (HoursBetween(F_DisconDate+1 , _dttm_discon)) div 24
                      else _how_long:= HoursBetween(F_DisconDate+1 , _dttm_discon) ;

           // _how_long:= HoursBetween(Now , _dttm_discon);            
          end;

        mt_Disconnections.FieldByName('base_prin').AsString := ' мя';
        mt_Disconnections.FieldByName('how_long').AsString := inttostr(_how_long);
        mt_Disconnections.Post;
        Dset_DisconNS.Next;
      end;

    Dset_DisconVDS.First;
    while not Dset_DisconVDS.Eof do
      begin
        //
        _dttm_discon := Dset_DisconVDS.FieldByName('dttm_discon').AsDateTime;
        _dttm_con :=Dset_DisconVDS.FieldByName('dttm_con').AsDateTime;
        if _dttm_con >0 then
          begin
           if F_NCDP then _how_long:= (HoursBetween(_dttm_con, _dttm_discon)) div 24
                      else _how_long:= HoursBetween(_dttm_con, _dttm_discon);
          end
          else
          begin
            if F_NCDP then _how_long:= (HoursBetween(F_DisconDate+1 , _dttm_discon)) div 24
                      else _how_long:= HoursBetween(F_DisconDate+1 , _dttm_discon) ;
          end;
//         if (F_NCDP and ( _how_long > 0 )) or (not F_NCDP and ()) then
         begin
          mt_Disconnections.Append;
          mt_Disconnections.FieldByName('ordernumber').AsInteger := Dset_DisconVDS.FieldByName('ordernumber').AsInteger;
          mt_Disconnections.FieldByName('adres').AsString := Dset_DisconVDS.FieldByName('adres').AsString;
          mt_Disconnections.FieldByName('regions').AsString := Dset_DisconVDS.FieldByName('regions').AsString;
          mt_Disconnections.FieldByName('dttm_discon').AsDateTime := _dttm_discon;
          mt_Disconnections.FieldByName('dttm_con').AsDateTime := _dttm_con;
          if _dttm_con >0 then
            begin
                mt_Disconnections.FieldByName('str_dttm_con').AsString := Dset_DisconVDS.FieldByName('dttm_con').AsString;
            end
            else
            begin
                mt_Disconnections.FieldByName('str_dttm_con').AsString := ' ';
            end;
          mt_Disconnections.FieldByName('base_prin').AsString := ' бдя';
          mt_Disconnections.FieldByName('how_long').AsString := inttostr(_how_long);
          mt_Disconnections.Post;
         end;
        Dset_DisconVDS.Next;
      end;
     dset_Regions.Next;
   end;//  while not dset_Regions.Eof
  dset_Regions.Close;
//  mt_Disconnections.Sort([mtcoCaseInsensitive]);

end;

end.
