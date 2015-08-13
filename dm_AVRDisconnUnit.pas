unit dm_AVRDisconnUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB, RxMemDS,
  IBCustomDataSet, DModule, IBDatabase, frOLEExl, IBSQL,DateUtils;

type
 // Tdm_AVRDisconn = class(Tdm_NGReportBase)
 Tdm_AVRDisconn = class(TDataModule)
    dset_NS: TIBDataSet;
    dset_VDS: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetPodrazd: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetAdres: TStringField;
    ResultDsetZhd: TIntegerField;
    ResultDsetPod: TIntegerField;
    ResultDsetStojak: TIntegerField;
    ResultDsetKv: TIntegerField;
    ResultDsetDK: TIntegerField;
    ResultDsetShK: TIntegerField;
    ResultDsetLU: TIntegerField;
    ResultDsetVed: TIntegerField;
    ResultDsetDisconReason: TStringField;
    ResultDsetDttm_Discon: TStringField;
 //  ResultDsetDttm_ConnWait: TStringField;
    ds_result: TDataSource;
    frDBDataSet: TfrDBDataSet;
    tran_VDS: TIBTransaction;
    tran: TIBTransaction;
    frReport1: TfrReport;
    IBSQL_NS: TIBSQL;
    IBSQL_VDS: TIBSQL;
    ResultDsetid: TIntegerField;
    ResultDsetid_disconnection: TIntegerField;
    ResultDsetid_podr: TIntegerField;
    ResultDsetdttm_con: TStringField;
    ResultDsetG_ATG: TIntegerField;
    ResultDsetG_GV: TStringField;
    ResultDsetAll_ZND: TIntegerField;
    ResultDsetG_ST_SP: TIntegerField;
    ResultDsetISPRIVATESEC: TIntegerField;
    ResultDsetweak_press: TBooleanField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    F_VDSSqlString: string;
    F_NSSqlString: string;
    F_Opened:boolean;
    procedure PrepareNSDset;
    procedure PrepareVDSDset;
    procedure SetSqlString;


  public
    { Public declarations }
    function ExportFRToFile(fr_rep: TfrReport; excel_file_name: string): boolean; virtual;
    function PrepareDsets: boolean;
    procedure SaveToBases;
    procedure SaveFileNameToBase(_fn: string); virtual;
    property  Opened:boolean write F_Opened;
  protected
   function AddWhere():String; virtual;
   function AddWhere_vds():String; virtual;
   procedure FillResultDset(_dset: TIBDataSet);
   function getAdressSQL():string; virtual;
   function getAdresSQLNS:string ; virtual;
   function prePareAdress(adres:String; isprivate:integer; gor_vod:integer;g_atg:integer;G_st:integer; g_pod:integer; PorchNum:String ):string; virtual;
  end;

var
  dm_AVRDisconn: Tdm_AVRDisconn;

implementation

{$R *.dfm}
uses ApplicationSettings;

function Tdm_AVRDisconn.PrepareDsets;
begin
 /// DM_Main.ConnectVDS('AVR_VDS', 'avr_vds_pwd');
  if tran_VDS.InTransaction then tran_VDS.Rollback;
  if tran.InTransaction then tran.Rollback;
  tran_VDS.startTransaction;
  tran.StartTransaction;
  try
    if ResultDset.Active then ResultDset.Close;
    ResultDset.Open;
    SetSqlString;
    PrepareNSDset;
    PrepareVDSDset;

    ResultDset.SortOnFields('Dttm_Discon');
    ResultDset.SortOnFields('weak_press;region');
   
      tran.Commit;
    tran_VDS.Commit;
   // DM_Main.DisconnectVDS;
  except
    on E: Exception do
    begin
      tran.Rollback;
      tran_VDS.Rollback;
      DM_Main.DisconnectVDS;
      raise Exception.Create( E.Message + '(Tdm_AVRDisconn.PrepareDsets)' );
    end;
  end;
  Result := true;
end;


procedure Tdm_AVRDisconn.FillResultDset(_dset: TIBDataSet);
var _Podr: string;
    _isNS: boolean;
    _id_podr: byte;
    function GetDisconReasonNS : string;
     var _place: integer;
     begin
         //
         _place := _dset.FieldByName('fk_orders_damageplace').AsInteger;
         case _place of
            1: result:= 'повреждение на маг-ли';
            2: result:= 'повреждение на вводе';
            3: result:= 'повреждение в колодце';
           10: result:= 'повреждение на маг-ли';
           19: result:= 'повреждение на вводе';
          else
            result := '';
          end;
     end;

begin
    //

    if (_dset.Name = dset_NS.Name) then
    begin
      _isNS := true;
      _id_podr := 1;
      _Podr := 'КХВС НС';
     end
      else
        begin
         _isNS := false;
         _id_podr := 2;
         _Podr := 'КХВС ВДС';
        end;
    _dset.First;
    while not(_dset.Eof) do
    begin
       ResultDset.Append;
       if _dset.Name='dset_NS' then
        ResultDset.FieldByName('adres').AsString:=prePareAdress( _dset.FieldByName('adres').AsString,

                          _dset.fieldbyname('ISPRIVATESEC').AsInteger,
                          _dset.Fieldbyname('gor_vod').asInteger,
                          _dset.fieldbyname('G_ATG').AsInteger,
                          _dset.fieldbyname('G_STOJ').AsInteger+2*_dset.fieldbyname('G_ST_SP').AsInteger,
                          _dset.fieldbyname('G_POD').AsInteger,
                          _dset.fieldbyname('PorchNum').AsString )
       else
        ResultDset.FieldByName('adres').AsString:=prePareAdress( _dset.FieldByName('adres').AsString,
                          0,
                          0,
                          0,
                          _dset.fieldbyname('G_STOJ').AsInteger,
                          _dset.fieldbyname('G_POD').AsInteger,
                           _dset.fieldbyname('PorchNum').AsString  );
       ResultDset.FieldByName('region').AsString := _dset.FieldByName('region').AsString;
       ResultDset.FieldByName('dttm_discon').AsString :=FormatDateTime('dd.mm.yyyy hh:mm', _dset.FieldByName('dttm_discon').AsDateTime);
       ResultDset.FieldByName('id_disconnection').AsInteger := _dset.FieldByName('id_disconnection').AsInteger;

       if  _dset.FieldByName('dttm_plan').IsNull then
         ResultDset.FieldByName('dttm_connwait').AsString:=''
       ELSE  
       ResultDset.FieldByName('dttm_connwait').AsString :=FormatDateTime('dd.mm.yyyy hh:mm', _dset.FieldByName('dttm_plan').AsDateTime); //18.05.2011
       if _dset.FieldByName('dttm_con').IsNull then
        ResultDset.FieldByName('dttm_con').AsString:=''
       else
         ResultDset.FieldByName('dttm_con').AsString:=FormatDateTime('dd.mm.yyyy hh:mm',_dset.FieldByName('dttm_con').AsDateTime);

       ResultDset.fieldByName('ZHD').AsInteger := _dset.FieldByName('G_ZHD').AsInteger;
       ResultDset.fieldByName('pod').AsInteger := _dset.FieldByName('G_POD').AsInteger;
       ResultDset.fieldByName('stojak').AsInteger := _dset.FieldByName('G_STOJ').AsInteger;
       ResultDset.fieldByName('kv').AsInteger := _dset.FieldByName('G_KV').AsInteger;
       ResultDset.fieldByName('dk').AsInteger := _dset.FieldByName('G_DK').AsInteger;
       ResultDset.fieldByName('shk').AsInteger := _dset.FieldByName('G_SHK').AsInteger;
       ResultDset.fieldByName('lu').AsInteger := _dset.FieldByName('G_LU').AsInteger;
       ResultDset.fieldByName('ved').AsInteger := _dset.FieldByName('G_VED').AsInteger;
       if ( _dset.fieldbyname('ISPRIVATESEC').AsInteger =0) then
         ResultDset.fieldByName('G_ATG').AsInteger:=_dset.FieldByName('G_ATG').AsInteger; //06.12.2011
       if (_dset.fieldbyname('ISPRIVATESEC').AsInteger =0) and (_dset.Name='dset_NS') then
         if (_dset.FieldByName('GOR_VOD').AsInteger=1) then
           ResultDset.fieldByName('G_GV').AsString:='есть'
         else
           ResultDset.fieldByName('G_GV').AsString:='нет'
       else
           ResultDset.fieldByName('G_GV').AsString:=_dset.FieldByName('G_GV').AsString; //06.12.2011

       ResultDset.FieldByName('Podrazd').AsString := _Podr;
       ResultDset.FieldByName('id_podr').AsInteger := _id_podr;
       ResultDset.FieldByName('ISPRIVATESEC').AsInteger:=_dset.fieldbyname('ISPRIVATESEC').AsInteger; //15.06.2014 часный сектор
       if (_dset.FieldByName('weak_pres').IsNull) then
        ResultDset.FieldByName('weak_press').AsBoolean:=false
       else
        ResultDset.FieldByName('weak_press').AsBoolean:= (_dset.FieldByName('weak_pres').AsInteger=1);
       if _isNS then
          ResultDset.FieldByName('DisconReason').AsString := GetDisconReasonNS
          else
          ResultDset.FieldByName('DisconReason').AsString := _dset.FieldByName('DisconReason').AsString;
       ResultDset.Post;
      _dset.Next;
    end;

end;

procedure Tdm_AVRDisconn.PrepareNSDset;
begin

  dset_NS.SelectSQL.Text := F_NSSqlString;
  dset_NS.Open;
  FillResultDset(dset_NS);
  dset_NS.Close;
end;

procedure Tdm_AVRDisconn.PrepareVDSDset;
begin
  dset_VDS.SelectSQL.Text := F_VDSSqlString;
  dset_VDS.Open;
  FillResultDset(dset_VDS);
  dset_VDS.Close;
end;

procedure Tdm_AVRDisconn.SetSqlString;
var D1:TDate;
    s:string;
function GetDiscontyp():string;
begin
 if F_opened then
  result:=' ( d.dttm_con is null ) '
 else
  result:=' (( d.dttm_con is null ) or (d.dttm_con>='''+s+' 06:00'')) ';
end;
begin

{execute block returns (emp_no smallint) as
begin
FOR EXECUTE STATEMENT 'select emp_no from employee'
ON EXTERNAL DATA SOURCE 'localhost:employee' AS USER 'sysdba' PASSWORD 'masterkey'
INTO :emp_no
DO SUSPEND;
end}

D1:=ToDay();
s:= formatdatetime('dd.mm.yyyy', D1-1);
  F_VDSSqlString:=
    ' select null weak_pres, o.id, d.dttm_discon, d.dttm_con, o.OrderNumber,  d.dttm_plan,'+
    ' (select lower(name) from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant_vds where id=o.fk_orders_applicant) Applicant,'+
     getAdressSQL()+' Adres,'+
    ' (select name from s_DisconReason_vds where id=d.fk_discon_disconreason) DisconReason,'+
    ' (select name from s_Executor_vds where id=d.fk_discon_executor) Executor,'+
    ' (select name from s_district_vds where id=o.fk_orders_district) District'+
    ' , (select name from s_discontype_vds where id=d.fk_discon_discontype) Distype '+
    ' , d.id id_disconnection  '+
    ' , G_ZHD,  G_ATG, G_POD,G_STOJ, G_KV, G_DK, G_SHK, G_LU, G_VED, G_GV,G_ST_SP '+
    ' , 0 ISPRIVATESEC, 0 GOR_VOD, d.PorchNum '+
    ' from Disconnections_vds d '+
    ' join orders_vds o on (d.fk_discon_order = o.id ) '+
    ' where ' +GetDiscontyp()+' and (d.dttm_discon is not null) and (d.fk_discon_street > 0) '+
      AddWhere_vds()+
    ' order by 6, 3';

  F_NSSqlString:=  ' select weak_pres,o.id, d.dttm_discon, d.dttm_con, o.OrderNumber, d.dttm_plan, '+
    ' (select lower(name) from s_Regions where id=o.fk_orders_regions) Region,'+
    getAdresSQLNS()+'  adres '+
    ' , o.fk_orders_damageplace '+
    ' , d.id id_disconnection  '+
    ' , G_ZHD,  G_ATG, G_POD, G_STOJ, G_KV, G_DK, G_SHK, G_LU, G_VED, G_GV,0 G_ST_SP  '+
    ' ,ad.ISPRIVATESEC ,GOR_VOD, null PorchNum '+
    ' from Disconnections d '+
    ' join Orders o on (o.id=d.fk_id_order) '+
    ' left join DISKON_ADDINFO_PPR ad on ad.FK_DISKON_ADDINFO_DISCON =d.id '+
    ' where ' +GetDiscontyp()+' and (d.dttm_discon is not null) and (d.fk_id_street > 0) '+
    AddWhere()+
    ' order by 1 desc,6, 3';
end;


function Tdm_AVRDisconn.ExportFRToFile(fr_rep: TfrReport;
  excel_file_name: string): boolean;
var
  excel_exp: TfrOLEExcelExport;
  _c: integer;
begin
  try
    excel_exp:=TfrOLEExcelExport.Create(nil);
    try
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


procedure Tdm_AVRDisconn.SaveFileNameToBase(_fn: string);
begin
    //

  if not AppSettings.IsUseAlarm then exit;  
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;

  try
    IBSQL_NS.SQL.Text := ' update SERVANTTABLE set REP_AVRDISCON_FILENAME = '''+ _fn +
     ''', DTTM_REP_AVRDISCON=current_timestamp where id = 1 ';
    IBSQL_NS.ExecQuery;
    tran.Commit;
  except
   on E:Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_AVRDisconn.SaveFileNameToBase)' );
    end;
  end;

end;

procedure Tdm_AVRDisconn.SaveToBases;
var _id_podr: byte;
    _id_disconnection: integer;

  procedure SetSaveSqlString(_id_disc: integer);
   var _SQL: string;
    begin
       IBSQL_NS.SQL.Text:=' update disconnections set ';
       IBSQL_VDS.SQL.Text:=' update disconnections_vds set ';
       _SQL := ' G_ZHD = '+ inttostr(ResultDset.fieldByName('ZHD').AsInteger)+
              ', G_POD = '+inttostr(ResultDset.fieldByName('pod').AsInteger)+
              ', G_STOJ = '+inttostr(ResultDset.fieldByName('stojak').AsInteger)+
              ', G_KV = '+inttostr(ResultDset.fieldByName('kv').AsInteger)+
              ', G_DK = '+inttostr(ResultDset.fieldByName('dk').AsInteger)+
              ', G_SHK = '+inttostr(ResultDset.fieldByName('shk').AsInteger)+
              ', G_LU = '+inttostr(ResultDset.fieldByName('lu').AsInteger)+
              ', G_VED = '+ inttostr(ResultDset.fieldByName('ved').AsInteger)+
              ', G_ATG = '+ inttostr(Resultdset.fieldByName('G_ATG').AsInteger)+
              ', G_GV = '''+ Resultdset.fieldByName('G_GV').AsString+ ''''+
              '  where id = '+ inttostr(_id_disc);

      IBSQL_NS.SQL.Text :=IBSQL_NS.SQL.Text+ _SQL;
      IBSQL_VDS.SQL.Text := IBSQL_VDS.SQL.Text+ _SQL;
    end;

begin
    //
 // if (DM_Main.IBDatabaseVDS.Connected = false) then exit;
  if tran_VDS.InTransaction then tran_VDS.Rollback;
  if tran.InTransaction then tran.Rollback;
  tran_VDS.startTransaction;
  tran.StartTransaction;
  try
    ResultDset.First;
    while not ResultDset.Eof do
     begin
       _id_disconnection := ResultDset.FieldByName('id_disconnection').AsInteger;
       SetSaveSqlString(_id_disconnection);
       _id_podr := ResultDset.FieldByName('id_podr').AsInteger;
       case _id_podr of
         1: IBSQL_NS.ExecQuery;
         2: IBSQL_VDS.ExecQuery;
       end;
      ResultDset.Next;
     end;
    tran.Commit;
    tran_VDS.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      tran_VDS.Rollback;
      DM_Main.DisconnectVDS;
      raise Exception.Create( E.Message + '(Tdm_AVRDisconn.SaveToBases)' );
    end;
  end;

end;


procedure Tdm_AVRDisconn.DataModuleDestroy(Sender: TObject);
begin
 DM_Main.DisconnectVDS;
end;

function Tdm_AVRDisconn.AddWhere():String;
begin
result:='';
end;

function Tdm_AVRDisconn.AddWhere_vds():String;
begin
result:='';
end;


function Tdm_AVRDisconn.getAdressSQL():string;
begin
 result := ' ((select rtrim(adres)  from get_adres2(d.fk_discon_street, d.housenum, '+
           ' d.housingnum, d.PorchNum, d.floornum, d.apartmentnum)) || '+
           ' iif (d.additionalinfo is null,  '''',''(''||rtrim(d.additionalinfo)||'')'')) ';
end;

function Tdm_AVRDisconn.getAdresSQLNS:string ;
begin
  result:=' ((select rtrim(name) from get_fullstreetname2(d.fk_id_street))||'', ''||rtrim(d.houses) ||'+
    ' iif (d.additionalinfo is null,  '''', ''(''||rtrim(d.additionalinfo) ||'')''))';
end;


function  Tdm_AVRDisconn.prePareAdress(adres:String; isprivate:integer; gor_vod:integer;g_atg:integer;G_st:integer; g_pod:integer; PorchNum :String):string;
begin

  if isprivate =1 then
    Result:=adres+' ' +'(ч/c)'
  else
    Result:=adres;
{  else
  begin
   if gor_vod>0 then
    result:=adres+' ' +'(г./в. есть'
   else
    result:=adres+' ' +'(г./в. нет';
   if g_atg>0 then
     result:=result+', '+IntTOStr(g_atg)+' эт)'
   else
    result:=result+')';

   end;}
end;


end.
