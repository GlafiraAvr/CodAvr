unit DamageBlagObjectDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,Dmodule, DB, IBCustomDataSet,
  RxMemDS, FR_DSet, FR_DBSet, frOLEExl;

type
  TTdm_DamageBlagObject = class(Tdm_NGReportBase)
    dset_main: TIBDataSet;
    rm_result: TRxMemoryData;
    rm_resultid_region: TIntegerField;
    rm_resultRegion: TStringField;
    rm_resulttype: TStringField;
    rm_resultadres: TStringField;
    frDBDataSet1: TfrDBDataSet;
    dset_region: TIBDataSet;
    rm_resultlabel: TStringField;
  private
    { Private declarations }
    F_dateSmen:Tdate;
    function PrepareData:boolean;
  public
    { Public declarations }
    function prepareDset:boolean;
    property DateSmen:TDate write F_dateSmen;
    function ExportFRToExcel(fr_rep: TfrReport;
  excel_file_name: string): boolean;
  end;
const selSQL = 'select o.fk_orders_regions id_reg,o.ordernumber, '+
               ' (select trim(adres) from '+
               '     get_adres(o.fk_orders_housetypes,o.fk_orders_streets,o.housenum, '+
               '     o.additionaladdress) ) adres, '+
               ' o.fk_orders_damagelocality locality '+
               '  from orders  o join departureworks dw on dw.fk_depworks_order=o.id'+
               ' join s_regions sr on sr.id=o.fk_orders_regions '+
               ' where dw.fk_depworks_work =1  '+ ///*раскопали*/
               '  and dw.fact_datetime>:d1 and dw.fact_datetime<:d1+1 '+
               '  order by 1';
const strStartTime = '8:00';

var
  Tdm_DamageBlagObject: TTdm_DamageBlagObject;

implementation

{$R *.dfm}


function TTdm_DamageBlagObject.prepareDset:boolean;
var cur_region:integer;
begin

 result:=false;
 cur_region:=0;
  if rm_result.Active then
   rm_result.Close;
   rm_result.Open;
  if PrepareData() then
  begin
    while not dset_region.Eof do
    begin
      rm_result.Append;
      rm_result.FieldByName('label').AsString:='КП"Харьківводоканал"';
      rm_result.FieldByName('id_region').AsInteger:=dset_region.fieldbyname('id').asinteger;
      rm_result.FieldByName('Region').AsString:=dset_region.fieldbyname('name').AsString;

      while (not dset_main.Eof) and
       (dset_main.FieldByName('id_reg').AsInteger=dset_region.FieldByName('id').AsInteger) do
      begin
       if rm_result.State<>dsInsert then
        rm_result.Append;

       rm_result.FieldByName('id_region').AsInteger:=dset_main.fieldbyname('id_reg').asinteger;
       rm_result.FieldByName('Region').AsString:=dset_region.fieldbyname('name').AsString;
       rm_result.FieldByName('adres').AsString:=dset_main.fieldbyname('adres').AsString;
        case   dset_main.FieldByName('locality').AsInteger of
          1,6,10:rm_result.FieldByName('type').AsString:='а/б.';
          2,7,8 :rm_result.FieldByName('type').AsString:='тр.';
          3     :rm_result.FieldByName('type').AsString:='з/з.';
          5     :rm_result.FieldByName('type').AsString:='гр.';

        end;
        dset_main.Next;
        rm_result.Post;
      end;
      dset_region.Next;
     end;
  end;
  dset_main.Close;
  
 result:=true;
end;

function TTdm_DamageBlagObject.PrepareData:boolean;
var str:string;
begin
result:=false;
try
 if  not dset_region.Active then dset_region.Open;
 dset_region.First;
 dset_main.SelectSQL.Text:=selSQL;
 DatetimeToString(str,'dd.mm.yyyy',F_dateSmen);
 dset_main.ParamByName('d1').AsString:=str+strStartTime;
 dset_main.Open;
 dset_main.First;
 if dset_region.Active then
  dset_region.Close;
 dset_region.Open;
 dset_region.First 
except on e:exception do
begin
 result:=false;
end;
end;
result:=true;

end;

function TTdm_DamageBlagObject.ExportFRToExcel(fr_rep: TfrReport;
  excel_file_name: string): boolean;
var
  excel_exp: TfrOLEExcelExport;
  _c: integer;
begin
  try
    excel_exp:=TfrOLEExcelExport.Create(nil);
    try
      excel_exp.ShowDialog:=false;
      excel_exp.ShowDialog:=false;
      fr_rep.EMFPages.Count;
      fr_rep.ExportTo(excel_exp, excel_file_name);
      Result:=not fr_rep.Terminated;
    finally
      excel_exp.Free;
    end;
  except
    on E: Exception do
    begin
      Result:=false;
      Application.MessageBox('Ошибка экспорта в Excel(TRootReport.ExportFastReportToExcel)',
                                'Отключения АВР', MB_OK+MB_ICONERROR);
    end;
  end;
end;


end.
