unit Search1562DModule;
//  для обработки нужно ID улицы !!  
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DB, IBCustomDataSet,
  DModule, RxMemDS, FR_DSet, FR_DBSet, IBEvents, ADODB, workSQL, IBSQL;

type

// TSortType=(stOrderNumberAndDatecoming, stRegions, stAdres);
   TZayav= class
   public
    id_1562:integer;
    id_order:integer;
    order_number:string;
    DateOPenOrder:TDateTime;
   constructor Create (nid_1562:integer;nid_order:integer;norder_number:string); overload;
   constructor Create (nid_1562:integer;nid_order:integer;norder_number:string; DateOPen:TDateTime); overload;
    procedure Sent(ADO:TADOQuery);
   end;



  Tdm_Search1562 = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    frDS_Result: TfrDBDataSet;
    ResultDset: TRxMemoryData;
    tran1562: TIBTransaction;
    dset_tmp: TIBDataSet;
    IBEvents: TIBEvents;
    ADOQ_1562: TADOQuery;
    rrr: TRxMemoryData;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    DateTimeField1: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    DateTimeField2: TDateTimeField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    DateTimeField3: TDateTimeField;
    DateTimeField4: TDateTimeField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    DateTimeField5: TDateTimeField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    ResultDsetid: TIntegerField;
    ResultDsetNumberOurRequest: TIntegerField;
    ResultDsetAppurtenanceState: TIntegerField;
    ResultDsetNumberReceivedRequest: TIntegerField;
    ResultDsetState: TIntegerField;
    ResultDsetid_rayon: TIntegerField;
    ResultDsetid_street: TIntegerField;
    ResultDsetHOUSE: TStringField;
    ResultDsetAPPARTMENT: TStringField;
    ResultDsetPlace: TStringField;
    ResultDsetABOUT: TStringField;
    ResultDsetAppurtenance: TIntegerField;
    ResultDsetstate_1: TIntegerField;
    ResultDsetRegion: TStringField;
    ResultDsetDateOurRequest: TDateTimeField;
    ResultDsetDateReceivedRequest: TDateTimeField;
    ResultDsetid_order: TIntegerField;
    ResultDsetNumOrder: TStringField;
    ResultDsetopened: TStringField;
    ResultDsetis_closed: TIntegerField;
    ResultDsetappuartenan_str: TStringField;
    ResultDsetdateclosed: TDateTimeField;
    ResultDsetNumberFloor: TStringField;
    ResultDsetPodesd: TStringField;
    ResultDsetphone: TStringField;
    ResultDsetabonent: TStringField;
    ResultDsetavar: TStringField;
    dset_regions: TIBDataSet;
    tran_s: TIBTransaction;
    dset_street: TIBDataSet;
    dset_streetID: TIntegerField;
    dset_streetNAME: TIBStringField;
    dset_orders: TIBDataSet;
    dset_orders_vds: TIBDataSet;
    ResultDsetrayon_name: TStringField;
    ResultDsetname_street: TStringField;
    ResultDsetNumber_Order: TStringField;
    ADO_resived: TADOQuery;
    IB_setstate: TIBSQL;
    ResultDsets_types_name: TStringField;
    procedure IBEventsEventAlert(Sender: TObject; EventName: String;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
    F_Condition: string;
    F_IsAscSort: boolean;
    F_strStartDate: string;
    F_strFinishedDate: string;
    F_RecordCount: integer;
    F_RegionList: TList;
    F_ForMainForm: boolean;
    F_ID_Region:integer;
    F_ID_Region2:integer;
    F_RegionsList:TstringList;
    S_Regions:TstringList;

    F_App:TStringList;
    F_isclosed:TStringList;
    F_Coming1,F_Coming2:TDateTime;


     F_Filter:string;
    procedure FillResultDset;

   function getorderinfo(id_1562:integer;app:integer; var number:string;var id_order:integer;var dateclosed:string):integer;

  public
    F_dt1,F_dt2:String;
    property Condition: string read F_Condition write F_Condition;
    property strStartDate: string read F_strStartDate write F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate write F_strFinishedDate;
    property ForMainForm: boolean read F_ForMainForm write F_ForMainForm;
    property  ID_Region:integer read F_ID_Region write F_ID_Region;
    property Id_Region2:integer read F_ID_Region2 write F_ID_Region2;
    property App:TStringList read F_App write F_App;
    property _isclosed:TStringList read F_isclosed write F_isclosed;
    property RegionsList:TStringList read F_RegionsList write F_RegionsList;
    property   Filter:string write F_Filter;
    property Coming1:TDateTime read F_Coming1 write F_Coming1;
    property Coming2:TDateTime read F_Coming2 write F_Coming2;
    function GetRecordCount: integer;
    function PrepareDset: boolean;
    procedure StartTransaction;
    procedure StopTransaction;
    procedure CommitTransaction;
    procedure RollBackTransaction;
    function Redefine:string;
  end;

var
  dm_Search1562: Tdm_Search1562;

implementation

uses HelpFunctions, StringConsts;
{$R *.dfm}

constructor TZayav.Create (nid_1562:integer;nid_order:integer;norder_number:string);
begin
id_1562:=nid_1562;
id_order:=nid_order;
order_number:=norder_number;
end;

constructor TZayav.Create (nid_1562:integer;nid_order:integer;norder_number:string;DateOPen:TDateTime);
begin
id_1562:=nid_1562;
id_order:=nid_order;
order_number:=norder_number;
DateOPenOrder:=DateOPen;
end;


procedure TZayav.Sent(ADO:TADOQuery);
begin
try
dm_workSQL.Resived1562(id_1562,-1,id_order,order_number,dateOPenOrder);
except
on e:exception do
Raise;
end;
end;

procedure Tdm_Search1562.FillResultDset;

var

  i, progress_shag: integer;
  number:string;
  id_order:integer;
  dateclosed:string;
  is_closed:integer;
begin

  ResetProgressFields;


  ResultDset.Close;
  ResultDset.Open;
  if _isclosed.IndexOf('1')>=0 then
     try
     MyOpenIBDS(dset_orders,
                Format('select 2 as app,o.id, o.isclosed,o.dateclosed, o.ordernumber,ns1.id_1562,ns1.state_inner,  o.DATECOMING '+
                       ' from numsorders ns1 left join orders o on ns1.id_order=o.id'+
                       ' where ns1.date_recive_request>=''%s''    and   ns1.date_recive_request<=''%s'' '+
                       ' union'+
                       ' select 3 as app, o.id, o.isclosed,o.dateclosed, o.ordernumber,ns2.id_1562,ns2.state_inner,  o.DATECOMING'+
                       ' from numsorders_vds ns2 left join orders_vds o on ns2.id_order=o.id'+
                       ' where ns2.date_recive_request>=''%s''    and  ns2.date_recive_request<=''%s'' ' ,
                       [F_dt1,F_dt2,F_dt1,F_dt2]));

     except   on E:exception do
     begin
      raise Exception.Create( E.Message + 'Не выполнился запрос  в нашу базу!!!' );
      exit;
      end;
     end;
      try
      ADOQ_1562.Close;
      ADOQ_1562.SQL.Clear;

      ADOQ_1562.Filtered:=false;
      if  F_Condition='' then
       ADOQ_1562.SQL.Add('EXEC spNEW_KhNEW_SELECT')
      else
       ADOQ_1562.SQL.Add(F_Condition);

      ADOQ_1562.Open;

      ADOQ_1562.First;
    except  on e:exception do
    begin

      ADOQ_1562.Connection.Connected:=false;
      raise Exception.Create( E.Message + 'Не выполнился запрос MSQL' );
      exit;
    end
    end;



   try
   while not ADOQ_1562.Eof do
   begin

   begin


    begin
     if F_ForMainForm then
      begin
        ResultDset.First;
        ResultDset.Insert;
      end
      else
          ResultDset.Append;


     for i:=0 to ADOQ_1562.FieldCount-1 do
     if ResultDset.FindField(ADOQ_1562.Fields[i].FieldName)<>nil then
      ResultDset.FieldByName(ADOQ_1562.Fields[i].FieldName).Value:=ADOQ_1562.Fields[i].Value;

   if not  ADOQ_1562.FieldByName('id_rayon').IsNull then
      ResultDset.FieldByName('Region').AsString:=S_Regions[ADOQ_1562.FieldByName('id_rayon').AsInteger];

      case  ResultDset.FieldByName('Appurtenance').AsInteger of
            2: ResultDset.FieldByName('appuartenan_str').AsString:='НС';
            3: ResultDset.FieldByName('appuartenan_str').AsString:='ВДС';
      end;
      if  ResultDset.FieldByName('state').AsInteger=0 then
       ResultDset.FieldByName('Number_Order').AsString:='';
           ResultDset.FieldByName('id_order').AsInteger:=-1;
           ResultDset.FieldByName('NumOrder').AsString:='';

    if not ResultDset.FieldByName('id_street').IsNull  then
     ResultDset.FieldByName('name_street').AsString:=trim(ADOQ_1562.fieldbyname('s_types_name').AsString)+' '+ResultDset.FieldByName('name_street').AsString;
     ResultDset.Post;
    end;
   end;
    ADOQ_1562.Next;

  end;
  ADOQ_1562.Close;
  if dset_tmp.Transaction.InTransaction then
  dset_tmp.Transaction.Commit ;
  except   on e:exception do
  begin


      Exception.Create( E.Message + 'Неправильные данные запрос MSQL' );

  end
 end;

end;


function Tdm_Search1562.PrepareDset: boolean;
begin
 FillResultDset ;
//  FillRegionList;

  Result:=true;
end;


procedure Tdm_Search1562.StartTransaction;
begin
try
  // if not DM_Main.IBDatabase1562_1.Connected then
  //    DM_Main.Connect1562_1('AVR_VDS','avr_vds_pwd');

   DM_Main.ConnectADO1562('','');

   try
      { if tran1562.InTransaction then tran1562.Rollback;
        tran1562.DefaultDatabase:= DM_Main.IBDatabase1562_1;
       tran1562.StartTransaction;
       IBEvents.AutoRegister := true;}
       if DM_Main.ADOConn_1562.InTransaction then
          DM_Main.ADOConn_1562.RollbackTrans;
   except
        on E:exception do
        begin
         //  tran1562.Rollback;
           E.Message := E.Message + '(Tdm_Search1562.To1562 start transaction)';
          raise Exception.Create(E.Message);
        raise;
        end;
   end;
except
    on E:exception do
    begin
      E.Message := E.Message + '(Tdm_Search1562.Connect)';
      raise Exception.Create(E.Message);
    end;
end;

end;

procedure Tdm_Search1562.StopTransaction;
begin
 if DM_Main.ADOConn_1562.InTransaction then DM_Main.ADOConn_1562.CommitTrans;
end;


function Tdm_Search1562.GetRecordCount: integer;
begin
  MyOpenIBDS(dset, 'select count(*) kol from spisok1562 '+F_Condition);
  Result:=dset.FieldByName('kol').AsInteger;
  dset.Close;
  F_RecordCount:=Result;
end;

procedure Tdm_Search1562.CommitTransaction;
begin

  if  DM_Main.ADOConn_1562.InTransaction then DM_Main.ADOConn_1562.CommitTrans;
end;

procedure Tdm_Search1562.RollBackTransaction;
begin

  if  DM_Main.ADOConn_1562.InTransaction then DM_Main.ADOConn_1562.RollbackTrans;
end;


procedure Tdm_Search1562.IBEventsEventAlert(Sender: TObject;
  EventName: String; EventCount: Integer; var CancelAlerts: Boolean);
begin
  inherited;
 //
  try
      FillResultDset;
      Application.MessageBox('NEW_EVENT!!!','AAAa');
  except
    on E: Exception do
      begin

        raise Exception.Create(E.Message + ' IBEventsEventAlert');
      end;

  end;
end;

procedure Tdm_Search1562.DataModuleCreate(Sender: TObject);
begin
  inherited;
F_App:=TStringList.Create;
F_regionsList:=TStringList.Create;
F_isclosed:=TStringList.Create;
S_Regions:=TStringList.Create;
dset_regions.Open;
dset_regions.First;
while not dset_regions.Eof do  begin
 S_Regions.Add(dset_regions.fieldbyname('name').asstring);
 dset_regions.Next;
end;

end;

function Tdm_Search1562.getorderinfo(id_1562:integer;app:integer; var number:string; var id_order:integer; var dateclosed:string):integer;
var
V:variant;
begin
number:='';
id_order:=-1;
dateclosed:='';
Result:=0;
try


    V:= dset_orders.Lookup('id_1562; app',VarArrayof([id_1562, app]),'ordernumber;id;dateclosed;isclosed;state_inner');
    if not (VarType(V) in [varNull]) then begin
    begin
     number:=V[0];
     id_order:=V[1];
     if V[2]<>null then
     dateclosed:=V[2];
      Result:=V[3];
      if Result=0 then
        if V[4]=3 then Result:=1
       else Result:=0;
      end;

end;



except on E:exception do
begin

           E.Message := E.Message+' getorderinfo' ;
  rAISE exception.Create(E.Message);
  Result:=0;
 end;
end;

end;

procedure Tdm_Search1562.DataModuleDestroy(Sender: TObject);
begin
  inherited;
f_isclosed.Clear;
f_isclosed.Free;
F_app.Clear;
F_app.Free;
s_Regions.Free;
dset_regions.Close;


end;

function  Tdm_Search1562.Redefine:string;
const SQL_NS  ='update numsorders set state_inner=1, state_outer=null where id_1562 =%s';
      SQL_VDS='update numsorders_vds set state_inner=1, state_outer=null where id_1562 =%s';
var str_ns,str_vds, SQL:string;
col,i:integer;
List_sent:TList;
Zayav:TZayav;
List_IB:TStringList;
begin
str_ns:='';
str_vds:='';
col:=0;

Result:='';
    try
      ADOQ_1562.Close;
      ADOQ_1562.SQL.Clear;
      ADOQ_1562.Filtered:=false;
      if  F_Condition='' then
       ADOQ_1562.SQL.Add('EXEC spNEW_KhNEW_SELECT')
      else
      begin

       ADOQ_1562.SQL.Add(F_Condition+' and  state=0 order by  id ');
      end;

      ADOQ_1562.Open;

      ADOQ_1562.First;
      while not ADOQ_1562.Eof do begin
          if  ADOQ_1562.FieldByName('Appurtenance').AsInteger=2 then
           str_ns:=str_ns+', '+ADOQ_1562.FieldByName('id').AsString
          else
           str_vds:=str_vds+', '+ADOQ_1562.FieldByName('id').AsString;

          ADOQ_1562.Next;
      end;
      delete(str_ns,1,2);
      delete(str_vds,1,2);
     except  on e:exception do
    begin

      ADOQ_1562.Connection.Connected:=false;
      raise Exception.Create( E.Message + 'Не выполнился запрос MSQL' );
      exit;
    end
    end;
    try
      SQL:='';
       if dset_orders.Active then
        dset_orders.Close;
       if (str_ns<>'') then
        SQL:=Sql+ Format('select ns.id_1562,  o.id, o.isclosed, o.ordernumber, o.datecoming  from numsorders ns, orders o '+
                         ' where ns.id_order=o.id and isclosed=0 and  id_1562 in (%s) ',[str_ns]);
       if  (str_ns<>'')and (str_vds<>'') then
        sqL:=SQL+' union ';
       if str_vds<>'' then
        sql:= sql+Format('select nvs.id_1562,ov.id, ov.isclosed,  '+
                         ' ( select * from  get_fullordernum(ov.ordernumber, ov.fk_orders_district)) ordernumber,'+
                         ' ov.datecoming ' +
                         ' from numsorders_vds nvs, orders_vds ov'+
                         ' where ov.id=nvs.id_order and isclosed=0 and id_1562 in(%s)',[str_vds]);
       if SQL<>'' then  begin
          sQL:=SQL+' order by 1';
         dset_orders.selectsQL.Clear;
         dset_orders.selectsQL.Add(SQL);
         dset_orders.Open;
      end;
    except on e:exception do
      begin
         raise Exception.Create( E.Message + 'Не выполнился запрос  в нашу базу!!!' );
         exit;
      end;
    end;

   str_ns:='';
   str_vds:='';
   List_Sent:=TList.Create;
   List_IB:=TStringList.Create;
    if  ADOQ_1562.Active then begin
        ADOQ_1562.First;
        if dset_orders.Active then begin
           dset_orders.First;
           while not ADOQ_1562.Eof do begin
                 if ADOQ_1562.FieldByName('id').AsInteger=dset_orders.FieldByName('id_1562').AsInteger then
                 begin
                      if dset_orders.FieldByName('isclosed').AsInteger=0 then

                      begin
                       Zayav:=TZayav.Create(ADOQ_1562.FieldByName('id').asinteger,dset_orders.FieldByName('id').asinteger,dset_orders.FieldByName('ordernumber').asstring,dset_orders.fieldByname('DATECOMING').asDateTime);
                       List_Sent.Add(Zayav);
                      end;
                      IB_setstate.SQL.Clear;
                      if ADOQ_1562.FieldByName('Appurtenance').asinteger=2 then
                         List_IB.Add(Format(SQL_NS,[ADOQ_1562.FieldByName('id').AsString]))
                      else
                       List_IB.Add(Format(SQL_VDS,[ADOQ_1562.FieldByName('id').AsString]));

                      Result:=Result+', '+ADOQ_1562.FieldByName('NumberOurRequest').asstring;
                      col:=col+1;
                       if col=4 then
                       begin
                        Result:=Result+#13;
                        col:=0;
                       end;



                 end;
                 if ADOQ_1562.FieldByName('id').AsInteger>dset_orders.FieldByName('id_1562').AsInteger then
                    if not dset_orders.Eof then
                       dset_orders.Next
                    else
                       break
                 else
                   ADOQ_1562.Next;
           end;
           dset_orders.Close;
        end;
        ADOQ_1562.Close;
    end;
   tran_s.commit;
   tran_s.StartTransaction;
   delete(str_ns,1,2);
   delete (str_vds,1,2);
 try
   for i:=0 to List_IB.Count-1 do begin
      try
       MyExecIBSQL( IB_setstate,List_IB.Strings[i]);
      except on  e:exception do begin
       e.Message:='Ошибка записи в нашу базу!!!'+#13+e.Message;
       Raise e;
      end;
      end;
      Zayav:=List_sent.Items[i];
      Zayav.Sent(ADO_resived);
   end;
   IB_setstate.Transaction.Commit;
   List_Sent.Free;
   List_ib.Free;

except on e:exception do begin
E.Message:='Ошибка перепринятия!!'+#13+E.Message;
List_Sent.Free;
List_ib.Free;
IB_setstate.Transaction.Commit;
Raise e;
exit;
end;
end;


  delete(Result,1,2);
end;

end.
