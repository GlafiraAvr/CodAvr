unit TrnaferFromAdoQToRmem;
{ класс для перреброса данных из TAdoQuety в TR_MemoryData
  md_Respunse - таблица 1 району 1 строка с заполненными id_region
  adoReqiest - для результата процедуры должна быть подключена к базе
}
interface

uses RxMemDS, ADODB, SysUtils,Variants, Classes;
type

TRansferAdoqToTrMem = class
private
  md_Respunse: TRxMemoryData;
  adoReqiest:TADOQuery;
  ado_dset: TADODataSet;

  key_FieldName:string;
  function FromadoDsetMD(field_query,field_md:string):boolean;

public
  constructor Create( md_Respunse: TRxMemoryData;adoReqiest:TADOQuery;ADODataSet:TADODataSet);
  {procname имя процедуры
   Pars список параметров

   field_query строка содержащая имена полей возращаемых процедурой adoReqiest разделитель ;
    например 'trunk_line_1562;trunk_line_telephone;failure_trunk_line_1562 ,
   field_md строка содержащая имена полей куда нужно записать d md_Respunse
    напр 1562_vip_tek_new;vip_tek_zhit;vip_tek_failure_1562
   колво полей должно совпадать!!!!
  }
  procedure fromquerytodm( procname:string; Pars:TStringList; field_query, field_md:string; field_query2, field_md2:string);
  property Pkey_Field:string write   key_FieldName;
end;

implementation

constructor  TRansferAdoqToTrMem.Create(md_Respunse: TRxMemoryData;adoReqiest:TADOQuery;ADODataSet:TADODataSet);
begin
 self.md_Respunse:=md_Respunse;
 self.adoReqiest:=adoReqiest;
 ado_dset:=ADODataSet;
 key_FieldName:='id_reg';
end;

function TRansferAdoqToTrMem.FromadoDsetMD(field_query,field_md:string):boolean;
var val:integer;
    i, p:integer;
    id_reg:string;
    V:variant;
    lf_query,lf_md :tStringList  ;
    str:string;

begin
  Result:=false;

   lf_query:=tStringList.Create;
 lf_md:=TStringList.Create;

 while Pos(';', field_query)>0 do
 begin
   p:=Pos(';', field_query);
   str:=copy(field_query,1,p-1);
   lf_query.Add(str);
   delete(field_query,1,p);

   p:=Pos(';', field_md);
   str:=copy(field_md,1,p-1);
   lf_md.Add(str);
   delete(field_md,1,p);

 end;

  lf_query.Add(field_query);
  lf_md.Add(field_md);



  if  not ado_dset.IsEmpty then
  begin
   ado_dset.Last;
   ado_dset.Prior;

   md_Respunse.First;
   while   (not ado_dset.eof)and
           ( not md_Respunse.Eof)and
           (md_Respunse.FieldByName(key_FieldName).asstring<>'')  do
   begin

    id_reg:=md_Respunse.FieldByName(key_FieldName).AsString;
    md_Respunse.Edit;
    for i:= 0 to lf_query.Count-1 do
    begin
     V:=ado_dset.Lookup('region',id_reg,lf_query.Strings[i]);

     if V<>null then
      begin
       val:=V;
        md_Respunse.FieldByName(lf_md.Strings[i]).AsInteger:= val;
      end ;

    end;
    md_Respunse.Post;
    md_Respunse.Next;
   end;
    ado_dset.Last;
    while  (md_Respunse.FieldByName(key_FieldName).AsString<>'')
    and  (not md_Respunse.Eof) do
     md_Respunse.Next;
    md_Respunse.Edit;
    md_Respunse.FieldByName(field_md).AsInteger:=ado_dset.FieldByName(field_query).AsInteger;
    md_Respunse.Post;
  end;
  Result:=true;
end;


procedure  TRansferAdoqToTrMem.fromquerytodm( procname:string; Pars:TStringList; field_query, field_md:string; field_query2, field_md2:string);
var i:integer;

    str:string;
begin
str:='execute '+procname;

 {IF dt1<>'' then
     str:=str +' '''+dt1+'''';
 if dt2<>'' then
    str:=str+', '''+dt2+'''';}
 for i:=0 to Pars.Count-1 do begin
 if i>0 then
    str:= str+', ';
 str:=str +' '+ Pars[i]+' ' ;
end;


 try
  adoReqiest.SQL.Clear;
  adoReqiest.SQL.Add(str);
  adoReqiest.Open;
   try
    ado_dset.Recordset:=adoReqiest.Recordset;
    if  FromadoDsetMD(field_query,field_md) then
     begin
     if field_md2<>'' then begin
     i:=0;
     ado_dset.Recordset:=adoReqiest.NextRecordset(i);
     FromadoDsetMD(field_query2,field_md2);
     end;
     end;


   finally
    adoReqiest.close;
   end;
 except on e:exception do
 begin
   e.Message:=e.Message+#13+' Трансфер данных из ADO  to Tr_memorydata';
   raise e;
   exit;
 end;
 end

end;


end.
