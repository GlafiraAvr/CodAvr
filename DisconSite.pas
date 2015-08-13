unit DisconSite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dm_AVRDisconnUnit, IBSQL, FR_Class, IBDatabase, FR_DSet,
  FR_DBSet, DB, RxMemDS, IBCustomDataSet;

type
  Tdm_AVRDisconnSite = class(Tdm_AVRDisconn)
    rm_Adreses: TRxMemoryData;
    rm_AdresesAdress: TMemoField;
    fr_adresses: TfrDBDataSet;
    rm_AdresesREgion: TStringField;
    rm_Adresesadd: TStringField;
    rm_Adresesweak_press: TBooleanField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  function PrepareRegionName( var Name:String;count:integer ):String;

  public
    { Public declarations }
   procedure PrepareAddAdreses();

   function ExportFRToFile(fr_rep: TfrReport; excel_file_name: string): boolean;  override;
  protected
   function AddWhere():String; override;
   function AddWhere_vds():String; override;
   procedure SaveFileNameToBase(_fn: string); override;
   function getAdressSQL():string; override;
   function getAdresSQLNS:string ; override;
   function prePareAdress(adres:String; isprivate:integer; gor_vod:integer;g_atg:integer;G_st:integer; g_pod:integer; PorchNum:String ):string; override;
  end;

var
  dm_AVRDisconnSite: Tdm_AVRDisconnSite;

implementation
uses HelpFunctions;

{$R *.dfm}

function Tdm_AVRDisconnSite.AddWhere():String;
begin
result:=' and ((ad.ISPRIVATESEC=1) or (d.G_ZHD >=1) or (G_STOJ >=1 )) ';
end;

function Tdm_AVRDisconnSite.AddWhere_vds():String;
begin
 result:=' and (d.G_ZHD >=1 or G_STOJ >=1 or G_POD >=1)'
end;

procedure Tdm_AVRDisconnSite.PrepareAddAdreses();
var reg:string;
    count:integer;
    str:String;
    weak:boolean;
 function  addP(str:string;count:integer): String;
  var i:integer;
 begin
  result:='';
  for i:=1 to count  do
   result:=result+chr(9)+'    ';
  result:=result+str;
 end;

 procedure addAdreses();
 begin
    rm_adreses.Append;
    rm_adreses.FieldByName('add').AsString:=PrepareRegionName(reg,count);
    rm_adreses.FieldByName('REgion').AsString:=reg;
    rm_adreses.FieldByName('weak_press').AsBoolean:=weak;

   if length(str)>rm_adreses.FieldByName('Adres').Size then
   begin
     rm_adreses.FieldByName('Adres').Size:=length(str);
     rm_adreses.FieldByName('Adres').DisplayWidth:=rm_adreses.FieldByName('Adress').Size;
   end;
   rm_adreses.FieldByName('Adres').AsString:=str;
   rm_adreses.Post;
 end;

begin

  reg:='';
  if rm_Adreses.Active then
    rm_Adreses.Close;
  rm_Adreses.Open;
  ResultDset.First;
  while not ResultDset.Eof do
  begin
   if reg<>ResultDset.fieldbyname('region').AsString then
   begin
    if str<>'' then
    addAdreses();
    reg:=ResultDset.fieldbyname('region').AsString;
    weak:=resultdset.FieldByName('weak_press').AsBoolean;
    str:='';
    count:=0;
   
   end;
   count:=count+1;
   str:=str+resultdset.fieldbyname('Adres').AsString;
   if (resultdset.FieldByName('ISPRIVATESEC').AsInteger=1)  then
    str:=str+'(ч/с)';
   if  not resultdset.fieldbyname('Dttm_ConnWait').IsNull then
       str:=str+' до '+  DateTimeFormat('hh:mm dd.mm.yy ',resultdset.fieldbyname('Dttm_ConnWait').AsDateTime);
   if ( not resultdset.fieldbyname('Adres').IsNull ) then
      str:=str+'; ';
   ResultDset.Next;
  end;
  if str<>'' then addAdreses();
end;

function Tdm_AVRDisconnSite.PrepareRegionName(var Name:String;count:integer ):String;
    var  sm, l:integer;
begin
if name<>'' then
begin
  //Name:=trim(Name);
  //Name:=LowerCase(Copy(name,2,Length(Name)-3));
  l:=ord('Д');
  sm:=ord('д');
  result:=trim(UpperCase(Copy(name,1,1)));
  sm := ord (result[1]);
  l := sm-32;
  result:= char(l);
  result:=Format('%S%s',[result,trim(LowerCase(Copy(name,2,Length(Name))))]);
//  result:= result+trim(LowerCase(Copy(name,2,Length(Name))));
  Delete(result,length(result)-1,2);
  name:=result+'ом';
  if count>0 then
    result:=' '+name+' районе по адресам: '
  else
    result:=' '+name+' районе по адресу: ';
end
else
 result:='';
end;

procedure Tdm_AVRDisconnSite.SaveFileNameToBase(_fn: string);

var sv_name:string;
begin
//????????? ??? ???????? ?? ????? ? ??????? SENTSVEMAIL
//if not AppSettings.IsUseAlarm then exit;
if tran.InTransaction then
 tran.Rollback;
try
  tran.StartTransaction;
  sv_name:='disconAVRsite';
  IBSQL_NS.SQL.Text:=format('update or insert into SENTSVEMAIL(sv_name,file_name,DATETIME) '+
                   '  values (''%s'',''%s'',current_timestamp) matching (sv_name)',[sv_name,_fn]);
  IBSQL_NS.ExecQuery;
  tran.Commit;
except on e:exception do begin
 if tran.InTransaction then
    tran.Rollback;
 raise Exception.Create( E.Message + '(Tdm_AVRDisconnSite.SaveFileNameToBase)' );
end;
end;
end;

function Tdm_AVRDisconnSite.ExportFRToFile(fr_rep: TfrReport; excel_file_name: string): boolean;
var f: textfile;
    handler:integer;
    needaddH1:boolean;
begin
  result:=false;
  needaddH1:=true;
  try
    if not IsFileExists(excel_file_name) then
    begin
     handler:=FileCreate(excel_file_name);
      FileClose(handler);
    end ;


     AssignFile(F, excel_file_name);
     Rewrite(F,excel_file_name);
     Append(F);
     WriteLn(F, ''+DateToStr(Date())+'<br/>');
     WriteLn(F,'КП "Харьковводоканал" информирует,'+
                   ' что в связи с проведением аварийно-востановительных'+
                   ' работ на водопроводных  сетях<b> прекращено водоснабжение:</b><br/>');

     rm_Adreses.First;
     while not rm_Adreses.Eof do
     begin
      if needaddH1 and rm_Adreses.FieldByName('weak_press').AsBoolean then
      begin
        WriteLn(F,'<b>Слабое давление</b> <br/>');
        needaddH1:=false;
      end;
      WriteLn(F,Format('-в %s %s<br/>',
                        [rm_Adreses.FieldByName('add').AsString,
                         rm_Adreses.FieldByName('Adres').AsString]));
      rm_Adreses.Next;
     end;
     WriteLn(F,'<b>Приносим извинения за временные неудобства!</b><br/>');
     result:=true;
  finally
     Flush(F);
     CloseFile(F);
  end

end;

procedure Tdm_AVRDisconnSite.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  rm_Adreses.Close;
end;

function Tdm_AVRDisconnSite.getAdressSQL():string;
begin
 Result:= '((select  trim(gs.name) from  get_fullstreetname2(d.fk_discon_street) gs) || '' д. ''||d.housenum )';
end;


function Tdm_AVRDisconnSite.getAdresSQLNS:string ;
begin
  result:='((select rtrim(name) from get_fullstreetname2(d.fk_id_street))||'','+
  ' ''||rtrim(d.houses) )';

end;

function Tdm_AVRDisconnSite.prePareAdress(adres:String; isprivate:integer; gor_vod:integer;g_atg:integer;G_st:integer; g_pod:integer; PorchNum:String):string;
begin
 result:=adres;
 if  PorchNum<>'' then
     result:=result+format(' под-д №%s ',[PorchNum]);
 if G_st >0 then
   result:=result+format('(стояк) ',[]);
 if (G_pod>0) then
   result:=result+format(' (подъезд )',[]);
 if  isprivate=1 then
  result:=result+' (ч/с)';


end;

end.
