unit workSQL;
{$define Sentto1562}

interface

uses
  SysUtils, Classes,DModule, DB, ADODB,Variants;


type
  Tdm_workSQL = class(TDataModule)
    ADOQuery1562: TADOQuery;
    ADOSP_Import_Denied: TADOStoredProc;
    ADOSP_DirTelRequestInOch: TADOStoredProc;
    ADOSP_Resived1562: TADOStoredProc;
    ADOSP_RallBack1562: TADOStoredProc;
  private
      { Private declarations }

  public
   procedure Import_Denied(id1562:integer;department:string; Reason:string);
   procedure  Resived1562(id1562:integer;Id_order:integer;_id:integer;order_number:string;DateOpen:TdateTime=0);
   procedure  RallBack1562(id1562:integer;Id_order:integer;id_App:integer;OrderNumber:string;DateOpen:TDateTime);
   procedure  DirectionTelRequestInOchistvod(id1562:integer;department:integer);
    { Public declarations }
  end;



var
  dm_workSQL: Tdm_workSQL;



implementation

uses HelpFunctions,GlobalData;  //23.07.2013

{$R *.dfm}
procedure  Tdm_workSQL.Resived1562(id1562:integer;Id_order:integer;_id:integer;order_number:string; dateopen:TDateTime);
var str:string;
 er:integer;
 v:variant;

begin
//{$ifdef Sentto1562}
 if ID_order<=0 then
     try
       { ADOQuery1562.SQL.Clear;
        ADOQuery1562.SQL.Add('declare @error_number int');
        ADOQuery1562.SQL.Add('declare @error_mesage varchar(200)');
        ADOQuery1562.SQL.Add(Format('exec spRead_Kh_New %s, %s, ''%s'' ,@error_number,@error_mesage',[IntToStr(id1562),IntToStr(_id),order_number]));
        ADOQuery1562.ExecSQL;
        ADOQuery1562.Close;}
        ADOSP_Resived1562.Parameters.ParamValues['@number_order']:=order_number;
        ADOSP_Resived1562.Parameters.ParamValues['@id_order']:=_id;
        ADOSP_Resived1562.Parameters.ParamValues['@ID']:=id1562;
        if ADOSP_Resived1562.Parameters.FindParam('@order_createdate')<>nil then
           if dateopen>0 then
             ADOSP_Resived1562.Parameters.ParamValues['@order_createdate']:=dateopen
           else
             ADOSP_Resived1562.Parameters.ParamValues['@order_createdate']:=Null;
        {$ifdef Sentto1562}
        ADOSP_Resived1562.ExecProc;
        v:=ADOSP_Resived1562.Parameters.ParamValues['@error_message'];
        if v<>'' then
         begin
          v:='ADOSP_Resived1562 '+v;
          Raise Exception.Create(v);
         end
         {$endif}


     except
     on E:exception do
      begin
          Raise Exception.Create(E.Message+'-1562-');
      end;
     end;
//{$endif}
end;

procedure  Tdm_workSQL.RallBack1562(id1562:integer;Id_order:integer; id_App:integer;OrderNumber:string;DateOpen:TDateTime);
var str:string;
v:variant;
begin
{$ifdef Sentto1562}
 try
      {  ADOQuery1562.SQL.Clear;
        ADOQuery1562.SQL.Add('declare @error_number int;');
        ADOQuery1562.SQL.Add('declare @error_mesage varchar(200);');
        ADOQuery1562.SQL.Add('exec spRollbackRequestKhNew '+IntToStr(ID1562)+', '+IntToStr(id_App) +' ,@error_number,@error_mesage;');
   //  ADOQuery1562.SQL.Add('select @error_number,@error_mesage;');
        ADOQuery1562.ExecSQL;
 //       ADOQuery1562.Active:=true;
 //        if not ADOQuery1562.Fields[0].IsNull  then
//         Raise Exception.Create('Ошибка №' + ADOQuery1562.Fields[1].Asstring+ ' ' +ADOQuery1562.Fields[2].Asstring);
//        if         ADOQuery1562.Connection.InTransaction
 //       then      ADOQuery1562.Connection.CommitTrans;

        ADOQuery1562.Close;    }
       //проверим если заявка открыта в базе MSSQL
       ADOQuery1562.SQL.Clear;
       ADOQuery1562.SQL.Add('SELECT [ID] ,[state] FROM [DateTime_KhNew_Select_vw] where  [ID]='+InttoStr(id1562));
       ADOQuery1562.Open;

       if ADOQuery1562.FieldByName('state').AsInteger=1 then
       begin
        with ADOSP_RallBack1562.Parameters do begin
          ParamValues['@ID']:=id1562;
          ParamValues['@inSystemRollback']:=id_App;
          ParamValues['@fk_disp']:=g_IDOfficial;    //23.07.2013
          if findParam('@number_order')<>nil then
           if OrderNumber<>'' then
            ParamValues['@number_order']:=OrderNumber
           else
            ParamValues['@number_order']:=null;
          if  Id_order=0 then
            ParamValues['@id_order']:=NULL
          else
            ParamValues['@id_order']:=id_order;


          if FindParam('@order_createdate')<>nil then
           if DateOpen>0 then
             ParamValues['@order_createdate']:=DateOpen
           else
             ParamValues['@order_createdate']:=NULL;
        end;
        ADOSP_RallBack1562.ExecProc;
        v:=ADOSP_RallBack1562.Parameters.ParamValues['@error_message'];
        if v<>'' then
         begin
          v:='ADOSP_RallBack1562 '+v;
          Raise Exception.Create(v);
         end
        end;





 except
 on E:exception do
    begin
           Raise Exception.Create(E.Message+'-1562-');
    end;
 end;
 {$endif}
end;


procedure Tdm_workSQL.Import_Denied(id1562:integer;department:string; Reason:string);
var v:variant;
begin
{$ifdef Sentto1562}
 try
 { with  ADOQuery1562.SQL do begin
     Clear;
     Add('declare  @error_number int;');
     Add('declare @error_message varchar(200);');
     Add(Format('exec spImportKhNewToRequest_Denied %d,''%s'', ''%s '', @error_number, @error_message;',
       [id1562, department, Reason] ));

   end;
   ADOQuery1562.execSQL;
   ADOQuery1562.close;}
   with  ADOSP_Import_Denied.Parameters do begin
      ParamValues['@ID']:=id1562;
      ParamValues['@transfer']:=department;
      ParamValues['@cause_failure']:=Reason;
      ParamValues['@FK_ID_DISPATCHER']:=g_IDOfficial;    //23.07.2013
    end;
   ADOSP_Import_Denied.ExecProc;
   v:=ADOSP_Import_Denied.Parameters.ParamValues['@error_message'];
    if v<>'' then
  begin
  v:='ADOSP_Import_Denied '+v;
   Raise Exception.Create(v);
  end

 except
 on E:exception do
    begin
           Raise Exception.Create(E.Message+'-1562-');
    end;
 end;
{$endif}
end;

procedure Tdm_workSQL.DirectionTelRequestInOchistvod(id1562:integer;department:integer );
var v:variant;

begin
{$ifdef Sentto1562}
 try
 { with  ADOQuery1562.SQL do begin
     Clear;
     Add('declare  @error_number int;');
     Add('declare @error_message varchar(200);');
     Add(Format('exec spImportKhNewToRequest_Denied %d,''%s'', ''%s '', @error_number, @error_message;',
       [id1562, department, Reason] ));

   end;
   ADOQuery1562.execSQL;
   ADOQuery1562.close;}
   with  ADOSP_DirTelRequestInOch.Parameters do begin
      ParamValues['@ID']:=id1562;
      ParamValues['@system_direction']:=department;
     ParamValues['@fk_disp']:=g_IDOfficial;       //23.07.2013
   end;
   ADOSP_DirTelRequestInOch.ExecProc;
   v:=ADOSP_DirTelRequestInOch.Parameters.ParamValues['@error_message'];
 if v<>'' then
  begin
   v:='ADOSP_DirTelRequestInOch '+v;
   Raise Exception.Create(v);
  end

 except
 on E:exception do
    begin
           Raise Exception.Create(E.Message+'-1562-');
    end;
 end;
{$endif}
end;


end.
