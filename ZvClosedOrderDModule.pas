unit ZvClosedOrderDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, FR_DSet, FR_DBSet, RxMemDS,DModule,
  IBCustomDataSet, IBDatabase;

type
  Tdm_ZvClosedOrder = class(Tdm_NGReportBase)
    rm_result: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    rm_resultid_order: TIntegerField;
    rm_resultIDREgion: TIntegerField;
    rm_resultid_1562: TIntegerField;
    rm_resultordernumber: TIntegerField;
    rm_resultRegion: TStringField;
    rm_resultAdres: TStringField;
    rm_resultnumber: TIntegerField;
    dset: TIBDataSet;
    tran: TIBTransaction;
  private
    { Private declarations }
    F_dt1,F_dt2:TDate;
  public
    { Public declarations }
    function prepareDsets():boolean;
    property dt1 :TDate read F_dt1 write F_dt1;
    property dt2 :TDate read F_dt2 write F_dt2;
  end;
const sel_SQL=' select o.id id_order, o.ordernumber, ns.number,sr.name Region, '+
              ' ns.id id_1562, ' +
              ' (select adres from get_adres(o.fk_orders_housetypes, '+
                                           ' o.fk_orders_streets,'+
                                           ' o.housenum ,o.additionaladdress ))  '+
                                           ' Adres, '+
              ' sr.id IDREgion '+
              ' from orders o join numsorders ns on ns.id_order=o.id '+
              ' join excavationsinfo ei on ei.fk_excinfo_orders=o.id '+
              ' join s_regions sr on sr.id=o.fk_orders_regions '+
              ' where ei.dat_closedorder is not null '+
              '  and ns.state_inner=1 '+
              '  and ei.dat_closedorder between ''%s'' and ''%s'' '+
              ' order by 7,ei.dat_closedorder ';



var
  dm_ZvClosedOrder: Tdm_ZvClosedOrder;

implementation

uses HelpFunctions;

{$R *.dfm}

{ Tdm_ZvClosedOrder }

function Tdm_ZvClosedOrder.prepareDsets: boolean;
var i:integer;
begin
result:=false;
if rm_result.Active then
 rm_result.Close;
 rm_result.Open;

if dset.Active then
   dset.Close;
try
MyOpenIBDS(dset,Format(sel_SQL,[DateTimeToStr(F_dt1),DateTimeToStr(F_dt2)]));

dset.First;
while not dset.Eof do
begin
  rm_result.Append;
    for i:=0 to rm_result.FieldCount-1 do
     rm_result.Fields[i].AsString:=dset.fieldByName(rm_result.Fields[i].FieldName).AsString;
  rm_result.Post;
  dset.Next;
end;
result:=true;
except
result:=false;
end;
end;

end.
