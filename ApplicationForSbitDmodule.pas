unit ApplicationForSbitDmodule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, IBCustomDataSet, FR_DSet,
  FR_DBSet, DB, RxMemDS, frOLEExl;

type
  Tdm_ApplicationForSbit = class(Tdm_NGReportBase)
    rm_result: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    dset: TIBDataSet;
    rm_resultid_region: TIntegerField;
    rm_resultRegion: TStringField;
    rm_resultnumber_our_request: TIntegerField;
    rm_resultdate_our_request: TDateTimeField;
    rm_resultabonent: TStringField;
    rm_resultphone: TStringField;
    rm_resultabout: TStringField;
    rm_resultadress: TStringField;
    rm_resultcadditionalinfo: TStringField;
    rm_resultsource: TStringField;
  private
    { Private declarations }
    F_DtBegin:TDateTime;
    F_DtEnd:TDateTime;

    function PrepareRegions:boolean;
    function preparedSQL:boolean;
    function FillData:boolean;
  public
    { Public declarations }
    property DtBegin:TDateTime write F_DtBegin;
    property DtEnd:TDateTime write F_DtEnd;
    function PrepareDsets:boolean;
    function ExportFRToExcel(fr_rep: TfrReport;
     excel_file_name: string): boolean;

  end;
  {оставляем только вдс}
const SQL_Main ={( ' select ns.id_region,sr.name Region,ns.number_our_request, '+
                 ' ns.date_our_request, ns.abonent,  ns.phone, ns.about, '+
                 ' ns.adress '+
                 ' from numsorders ns join s_regions sr on ns.id_region=sr.id '+
                 ' where ns.date_our_request between :d1 and :d2 '+

                 ' union '+}
                 ' select ns.id_region,sr.name Region,ns.number_our_request,  ' +
                 ' ns.date_our_request, ns.abonent,  ns.phone, ns.about, '+
                 ' ns.adress, o.isclosed,  d.additionalinfo additionalinfo, '+
                 ' ns.number '+
                 ' from numsorders_vds ns join s_regions sr on ns.id_region=sr.id '+
                 ' join orders_vds o on o.id=ns.id_order '+
                 ' join departures_vds d on d.fk_departures_orders = o.id '   +
                 ' where ns.date_our_request between :d1 and :d2  '+
                 ' and d.id = (select max(id) from departures_vds ds  where ds.fk_departures_orders=o.id) '+
                 ' order by 1,4';
var
  dm_ApplicationForSbit: Tdm_ApplicationForSbit;

implementation

{$R *.dfm}
function Tdm_ApplicationForSbit.PrepareRegions:boolean;
begin
result:=false;
try
if  rm_result.Active then
  rm_result.Close;
 rm_result.Open;
result:=true;
except
end;
end;

function Tdm_ApplicationForSbit.preparedSQL:boolean;
begin

 try
  if dset.Active then
    dset.Close;
  dset.SelectSQL.Text:=SQL_Main;
  dset.ParamByName('d1').AsDateTime:=F_DtBegin;
  dset.ParamByName('d2').AsDateTime:=F_DtEnd;
  dset.Open;
  result:=true;
 except
  result:=false;
 end;
end;



function Tdm_ApplicationForSbit.FillData:boolean;
var i:integer;

 function prepareAdress(adres:string):string;
 var p:integer;
 begin
    adres:=trim(adres);
    p:=pos(' ',adres);
    delete(adres,1,p);
    result:= adres;
 end;
begin
 result:=false;
 try
 if dset.Active then
 begin
    dset.First;
    {пока поля названя так как поля в запросе просто заполним  их в цикле}
    while not dset.Eof do
    begin
     rm_result.Append;
     for i:=0 to rm_result.FieldCount-1 do
     begin
      if rm_result.Fields[i].FieldName = 'adress' then
        rm_result.Fields[i].AsString:=prepareAdress(dset.fieldbyname(rm_result.Fields[i].FieldName).asstring)
      else  

      if rm_result.Fields[i].FieldName='date_our_request' then
       rm_result.Fields[i].AsDateTime:=dset.fieldbyname(rm_result.Fields[i].FieldName).AsDateTime
      else
       if rm_result.Fields[i].FieldName = 'additionalinfo'  then
       begin
         if  dset.FieldByName('isclosed').AsInteger =1 then
           rm_result.Fields[i].AsString:=dset.fieldbyname(rm_result.Fields[i].FieldName).AsString;
        end
        else
        if rm_result.Fields[i].FieldName = 'source' then
          if dset.FieldByName('number').AsInteger>0 then
            rm_result.Fields[i].AsString := '1562' else
            rm_result.Fields[i].AsString := 'тел.'
        else
           rm_result.Fields[i].AsString:=dset.fieldbyname(rm_result.Fields[i].FieldName).AsString;

     end;
     rm_result.Post;
     dset.Next;
    end;
 end;
 result:=true;
 except
 end;
end;

function Tdm_ApplicationForSbit.PrepareDsets:boolean;
begin
 result:=false;
 if PrepareRegions then
 if preparedSQL then
  if FillData then
   result:=true;
end;

function Tdm_ApplicationForSbit.ExportFRToExcel(fr_rep: TfrReport;
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
