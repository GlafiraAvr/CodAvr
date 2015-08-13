unit GetToDoNarDMobule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, DB, RxMemDS, FR_Class,DModule, IBDatabase,
  IBCustomDataSet, FR_DSet, FR_DBSet;

type
 TTypeNar=(opened,closed);

  Tdm_GetToDoNar = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    dset: TIBDataSet;
    tran: TIBTransaction;
    ResultDsetid_region: TIntegerField;
    ResultDsetRegion: TStringField;
    ResultDsetcount_open: TIntegerField;
    ResultDsetcount_closed: TIntegerField;
    frDBDataSet1: TfrDBDataSet;
  private
    { Private declarations }
    f_dt_begin,F_dt_End:TDateTime;

    f_tableName:string;
    function prepareSQL(typ:TTypeNar ):boolean;
    function setData(typ:TTypeNar):boolean;
  public
    { Public declarations }
    function PrePareDset:boolean;
    property Dt_begin:TdateTime write F_dt_begin;
    property Dt_end:TDateTime  read F_dt_end write F_dt_end;
    property  Table:string write F_tableName;
  end;

var
  dm_GetToDoNar: Tdm_GetToDoNar;

implementation

{$R *.dfm}

{ Tdm_ }

function Tdm_GetToDoNar.PrePareDset: boolean;
begin
result:=false;
 if ResultDset.Active then
  ResultDset.Close;
  REsultDset.Open;
  if setData(opened) then
  begin
  resultdset.First;
    result:=setData(closed);

  end;
end;

function Tdm_GetToDoNar.prepareSQL(typ:TTypeNar): boolean;
var sql:string;
    typefield:string;
begin
case typ of
  opened:typeField:='datecoming';
  closed:typeField:='dateclosed';
end;
try
  if dset.Active then
    dset.Close;
  sql:=format(
  'select o.fk_orders_regions id_region ,sr.name Region, count(*) '+
  ' from %s o join  s_regions sr on sr.id=o.fk_orders_regions '+
  ' where o.%s>=:dt_begin and o.%s<:dt_end '+
  ' group by 1,2 ', [F_tableName,typeField,typeField]);

  dset.SelectSQL.Text:=sql;
  dset.ParamByName('dt_begin').AsDateTime:=F_dt_begin;
  dset.ParamByName('dt_end').AsDateTime:=f_dt_end+1;
  dset.Open;
  dset.First;
  result:=true;
except
 Application.MessageBox('Ошибка формирования данных!!','Внимание', MB_OK + MB_ICONERROR );
 result:=false;
end;

end;

function Tdm_GetToDoNar.setData(typ:TTypeNar): boolean;

begin
  result:=false;
  try
    if prepareSQL(typ) then
    begin
      while not dset.Eof do
      begin
         if Ord(typ)=0 then
         begin
          resultDset.Append;
          resultdset.FieldByName('id_region').AsInteger:=dset.fieldbyname('id_region').AsInteger;
          resultdset.FieldByName('Region').AsString:=trim(dset.fieldbyname('Region').AsString);
          resultdset.FieldByName('count_open').AsInteger:=dset.fieldbyname('count').AsInteger;
          resultdset.Post;
         end
         else
         begin
          resultDset.Edit;
          resultdset.FieldByName('count_closed').AsInteger:=dset.fieldbyname('count').AsInteger;
          resultDset.Post;
          resultdset.Next;
         end;
         dset.next;
      end;
     end;
     result:=true;
  except
      result:=false;
  end;
end;

end.
