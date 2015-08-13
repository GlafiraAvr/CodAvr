unit WorksRegionDModule;

interface

uses
  SysUtils, Classes,DModule, DB, IBCustomDataSet, IBDatabase;

type
  Tdm_WorkRegion = class(TDataModule)
    tran: TIBTransaction;
    dset_Main: TIBDataSet;
    dset_MainID: TIntegerField;
    dset_MainFK_ID_ORDER: TIntegerField;
    dset_MainFK_ID_USER: TIntegerField;
    dset_MainSTARTDATE: TDateTimeField;
    dset_MainFK_ID_BRIG: TIntegerField;
    dset_MainENDDATE: TDateTimeField;
    dset_Brig: TIBDataSet;
    tran_sel: TIBTransaction;
    dset_BrigID: TIntegerField;
    dset_BrigNAME: TIBStringField;
    dset_MainFK_ID_CLOSEDUSED: TIntegerField;
    dset_MainFK_NAME_USER: TIBStringField;
    dset_MainFK_NAME_CLOSEDUSED: TIBStringField;
    procedure dset_MainAfterPost(DataSet: TDataSet);
    procedure dset_MainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    F_ID_order:integer;
    F_IsCanEdit:boolean;
    F_Idregion:integer;
    F_Error:string;

    procedure SatrTran();
    function GetIsData():boolean;
    function GetIsBottomData():boolean;

  public
    { Public declarations }
    F_IsNeedBrig:boolean;
    procedure openDsets(id_order:integer;id_region:integer);
    procedure  CommitAll();
    function AddTop():boolean;
    function addBottom():boolean;
    function Change():boolean;
    function DellBottom():boolean;
    function DelTop():boolean;
    function PostMain:boolean;
    property isData:boolean read GetIsData;
    property IsBottomData:boolean read   GetIsBottomData;
    property MyError:string read F_Error;
    procedure RallBackMain;
    procedure CloseAll;

  end;

var
  dm_WorkRegion: Tdm_WorkRegion;

implementation

{$R *.dfm}
uses GlobalData, RightsManagerDModule;

procedure Tdm_WorkRegion.openDsets(id_order:integer; id_region:integer);
begin
 F_Error:='';
 try
 F_ID_order:=id_order;
 F_IdRegion:=id_region;

 SatrTran;
 dset_main.ParamByName('id_order').AsInteger:=f_ID_order;
// set_main.FieldByName('FK_ID_ORDER').AsInteger:=F_id_order;
 dset_brig.ParamByName('id_region').AsInteger:= id_region;
 dset_main.Open;
 dset_brig.Open;
 except on e:exception do
 begin
  F_Error:='Не подучили данныз из базы!';
 end;
 end

end;

procedure Tdm_WorkRegion.SatrTran();
begin
 if tran.InTransaction then tran.Commit;
 tran.StartTransaction;
 if tran_sel.InTransaction then tran_sel.Commit;
 tran_sel.StartTransaction;
end;

procedure  Tdm_WorkRegion.CommitAll();
begin
 if tran.InTransaction then tran.Commit;
 if tran_sel.InTransaction then tran_sel.Commit
end;

function  Tdm_WorkRegion.AddTop():boolean;
begin
 F_Error:='';
 try
  if dset_main.RecordCount=0 then
   begin
    dset_main.Insert;
    dset_main.FieldByName('FK_Id_ORDER').AsInteger:=F_ID_ORDER;
    dset_main.FieldByName('FK_ID_USER').AsInteger:=g_IDOfficial;
    dset_main.FieldByName('startDate').AsDateTime:=Now();
    Result:=true;

   end
   else
   begin
   Result:=false;
   F_Error:='Данные уже есть, нельзя добавить!';
   end;
 except on e:exception  do
 begin
  F_Error:='Ошибка';
  Result:=false;
  exit
 end;
 end;
end;

function Tdm_WorkRegion.addBottom():boolean;
begin
 F_Error:='';
 try
 if (dset_main.RecordCount=1) and  not (dset_main.FieldByName('startDate').IsNull) then
 begin
  dset_main.Edit;
  dset_main.FieldByName('FK_ID_CLOSEDUSED').AsInteger:=g_IDOfficial;
  dset_main.FieldByName('ENDDATE').AsDateTime:=Now();
  dset_main.Post;
  Result:=true;
 end
 else begin
  Result:=false;
  F_Error:='Данные уже есть, нельзя добавить!';
  end;
 except
  Result:=false;
  F_Error:='Ошибка';
  exit;
 end;
end;

function Tdm_WorkRegion.Change():boolean;
begin
 F_Error:='';
 try
  if (dset_main.State=dsBrowse) and
     (dset_main.RecordCount=1 )and
     (not dset_main.FieldByName('startDate').IsNull) then
   dset_main.Edit;
   Result:=true;
 except
   result:=false;
   F_Error:='Ошибка';
   exit;
 end;
end;

function  Tdm_WorkRegion.PostMain:boolean;
begin
 F_Error:='';
 F_IsNeedBrig:=false;
try
  if dset_main.State<>dsBrowse then
   if  (not dset_main.FieldByName('FK_ID_BRIG').IsNull) then
   begin
    dset_main.FieldByName('FK_ID_ORDER').AsInteger:=F_id_order;
    dset_main.Post;
    Result:=true;
   end
   else
   begin
   Result:=false;
   F_Error:='Введите Бригадира!';
   F_IsNeedBrig:=true;
   end
except
   F_Error:='Ошибка записи!';
  REsult:=false;
end;
end;

function  Tdm_WorkRegion.DellBottom:boolean;
begin
 Result:=false;
  F_Error:='';
 try
 if (dset_main.State=dsBrowse ) then
 if (dset_main.RecordCount>=1) and
    (not dset_main.FieldByName('FK_ID_CLOSEDUSED').IsNull) then
  begin
   dset_main.Edit;
   dset_main.FieldByName('FK_ID_CLOSEDUSED').Clear;
   dset_main.FieldByName('ENDDATE').Clear;
   dset_main.Post;
   result:=true;
  end
  else
   F_Error:='Нет данных для удаления!'
 else
   F_Error:='Ошибка статуса!'

 except
  Result:=false;
   F_Error:='Ошибка удаления!';
 end
end;

function Tdm_WorkRegion.DelTop:boolean;
begin
  F_Error:='';
 try
   result:=false;
  if (dset_main.State=dsBrowse ) then
   if   (dset_main.RecordCount=1) and ( dset_main.FieldByName('FK_ID_CLOSEDUSED').IsNull)
   then
   begin
    dset_main.Delete;
    dset_main.Close;
    dset_main.Open;
    result:=true;
   end
   else
    F_Error:='Нет данных для удаления!'
  else
   F_Error:='Ошибка статуса!';

 except
  Result:=false;
  F_Error:='Ошибка удаления!';
 end;

end;


procedure Tdm_WorkRegion.dset_MainAfterPost(DataSet: TDataSet);
begin
  tran.CommitRetaining;
  dset_Main.Close;
  dset_Main.Open;
end;

function Tdm_WorkRegion.GetIsData():boolean;
begin
Result:=(dset_main.RecordCount>=1);
end;

function  Tdm_WorkRegion.GetIsBottomData():boolean;
begin
REsult:=(not dset_main.FieldByName('endDate').isnull);
end;

procedure Tdm_WorkRegion.RallBackMain;
begin

if dset_main.State <>dsBrowse then
begin
 dset_Main.Cancel;
 
end;
end;

procedure Tdm_WorkRegion.CloseAll;
begin
 dset_main.Close;
if tran.InTransaction then tran.Commit;
if tran_sel.InTransaction then tran_sel.Rollback;
end;


procedure Tdm_WorkRegion.dset_MainBeforePost(DataSet: TDataSet);
begin
 if  (not dset_main.FieldByName('STARTDATE').IsNull) and  dset_main.FieldByName('FK_ID_USER').IsNull then
  dset_main.FieldByName('FK_ID_USER').AsInteger:=g_IDOfficial;
 if (not  dset_main.FieldByName('ENDDATE').IsNull) and  dset_main.FieldByName('FK_ID_CLOSEDUSED').IsNull then
  dset_main.FieldByName('FK_ID_CLOSEDUSED').AsInteger:=g_IDOfficial;

end;

end.
