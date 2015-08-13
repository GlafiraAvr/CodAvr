unit VedNotCloseOrderDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, DB, RxMemDS, IBDatabase,
  IBCustomDataSet,HelpFunctions, FR_DSet, FR_DBSet  ;

type
  Tdm_VedNotCloseOrder_vds = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    tran: TIBTransaction;
    rmem: TRxMemoryData;
    rmemRegion_ID: TIntegerField;
    rmemRegion: TStringField;
    rmemAll: TIntegerField;
    rmemwith_leak: TIntegerField;
    rmemlocal_leak: TIntegerField;
    dset_all: TIBDataSet;
    dset_leak: TIBDataSet;
    dset_local: TIBDataSet;
    frDBDataSet: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
   ArrDset: array [1..3] of TIBDataSet ;

    function PrepareREgion():boolean;

    function PrepareDate(percent:integer):boolean;

  public
    { Public declarations }
    function PrepareDsets():boolean;

  end;
 const SQL_selREg = 'select id , substr(name,1,1)||lower( substr(name,2,20)) name from s_regions where id>0 order by 1';
       SQL_COUTClose = 'select  fk_orders_regions id_region, count(*) kol from orders_vds ov '+
                       ' where ov.isclosed=0 '+
                       '  group by  1   order by 1';
       SQL_COUNTLeak ='select ov.fk_orders_regions id_region, count(*) kol from orders_vds ov '+
                      'join s_messagetypes_vds  sm on sm.id=ov.fk_orders_messagetypes '+
                      ' and sm.group_message =1 '+
                      ' where ov.isclosed=0 '+
                      ' group by  1   order by 1';
       SQL_COUNTLOCAL = ' select  fk_orders_regions id_region, count( distinct ov.id) kol from orders_vds ov '+
                        ' join s_messagetypes_vds  sm on sm.id=ov.fk_orders_messagetypes '+
                        ' join disconnections_vds dd on dd.fk_discon_order= ov.id and dd.dttm_con is null '+
                        '   where ov.isclosed=0  and sm.group_message =1  '+
                        '  group by  1   order by 1';
  SQL_CONSTS:array [1..3] of string  = (SQL_COUTClose,SQL_COUNTLeak,SQL_COUNTLOCAL);


var
  dm_VedNotCloseOrder_vds: Tdm_VedNotCloseOrder_vds;

implementation

{$R *.dfm}

function Tdm_VedNotCloseOrder_vds.PrepareDsets():boolean;
begin
 rmem.Close;
 rmem.Open;
 result:=false;
 if  PrepareREgion() then
   result:=PrepareDate(100);




end;


function  Tdm_VedNotCloseOrder_vds.PrepareREgion():boolean;

begin
 Result:=false;
 try
 MyOpenIBDS(dset,SQL_selREg);
 try
 dset.First;
 while not dset.Eof do
 begin
   rmem.Append;
   rmem.FieldByName('REgion_ID').AsInteger:=dset.fieldbyname('ID').AsInteger;
   rmem.FieldByName('REgion').AsString:=dset.fieldbyname('name').AsString;
   rmem.Post;
   dset.Next;
 end;
 result:=true;
 finally
   if  dset.Active then
     dset.Close;
 end;

 except on E:exception do

 end;

end;


function Tdm_VedNotCloseOrder_vds.PrepareDate(percent:integer):boolean;
var i:integer ;
    _progress_shag:integer;
begin
_progress_shag := GetProgressShagLength( percent, rmem.RecordCount +1);
 REsult:=false;
 try
   for i:=1 to 3 do
     begin
       MyOPenIBDS(ArrDset[i],SQL_CONSTS[i]);
       ArrDset[i].First;
     end;
   rmem.First;
   IncProgressStatus( _progress_shag );
   while not rmem.Eof do
   begin
    rmem.Edit;
    for i:=1 to 3 do begin
     if not ArrDset[i].IsEmpty then
       if (ArrDset[i].FieldByName('id_region').AsInteger = rmem.FieldByName('Region_ID').AsInteger) then
          begin
            rmem.Fields[i+1].AsInteger:=ArrDset[i].FieldByName('kol').AsInteger;
            ArrDset[i].Next;

          end

    end;
    rmem.Post;
    rmem.Next;
    IncProgressStatus( _progress_shag );
   end;
   result:=true;
 finally
   for i:=1 to 3 do
    if ArrDset[i].Active then
     ArrDset[i].Close
 end;



end;



procedure Tdm_VedNotCloseOrder_vds.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ArrDset[1] := dset_all;
  ArrDset[2]:= dset_leak;
  ArrDset[3]:= dset_Local;
end;

end.
