unit AvrPictersDModule;

interface

uses
  SysUtils, Classes ,DModule, IBDatabase, DB, IBCustomDataSet, IBSQL,
  RxMemDS,jpeg, Forms,  ShellApi, FR_Class, FR_E_GR_RS, FR_E_JPG_RS,Windows,
  ClientImage,HelpFunctions ;

const TMP_DIR_NAME='picters_avr';
type
  Tprocedure=procedure (str:string;num:integer;fielname:string) of object;
  TsimpleProce=procedure(mes:string='') of object;
  Tdm_avrpicter = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    IBSQL: TIBSQL;
    mem_maps: TRxMemoryData;
    mem_mapsid: TIntegerField;
    mem_mapsfileName: TStringField;
    mem_mapsid_typ: TIntegerField;
    mem_mapsPicter: TBlobField;
    dset_id: TIBDataSet;
    mem_mapssaved_picter: TStringField;
    mem_before: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    BlobField1: TBlobField;
    StringField2: TStringField;
    mem_after: TRxMemoryData;
    IntegerField3: TIntegerField;
    StringField3: TStringField;
    IntegerField4: TIntegerField;
    BlobField2: TBlobField;
    StringField4: TStringField;
    dsetID: TIntegerField;
    dsetFILE_NAME: TIBStringField;
    dsetID_TYP: TIntegerField;
    mem_mapsServFile_Name: TStringField;
    mem_beforeServFile_Name: TStringField;
    mem_afterServFile_Name: TStringField;
    dsetSERVFILE_NAME: TIBStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure mem_mapsAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }

    F_Dm_PicterClient:Tdm_ClientImage;
    f_curmem:TRxMemoryData;
    Rec_Count:integer;

    Redraw:Tprocedure;
    FullDirName:string;
    F_ClearProce:TSimpleProce;
    F_year:integer;
    F_ordernumber:integer;
    procedure CreatedDir();
    procedure DeleteDir();


    function DelDir (dir_name:string):boolean;
    procedure SetShowMess(proc:TSimpleProce);
  public
    { Public declarations }
   f_typ:integer; {1-map 2 before 3 after}
   F_ID_order:integer;
   Current_Image:string;
    function OpenDset():boolean;
    function IsConnect():boolean;
    function Insert(FileName:string):boolean;
    function DeleteIMG():boolean;
    property Rec:integer read  Rec_Count;
    property OnRedraw :Tprocedure write   Redraw;
    procedure SetTyp(n_typ:integer);
    property ClearProc: TSimpleProce write F_ClearProce;
    property Ordernumber:integer write  F_ordernumber;
    property Year:integer  write F_year;
    property Connected:boolean read IsConnect;
    property Showmes:TSimpleProce write SetShowMess;
  end;



implementation

{$R *.dfm}
uses Dialogs;

function Tdm_avrpicter.OpenDset():boolean;
   procedure Savetomem(mem:TRxMemoryData);
    begin
     mem.Append;
     mem.FieldByName('id').AsInteger:=dset.FieldByName('id').AsInteger;
     mem.FieldByName('filename').AsString:=dset.FieldByName('file_name').AsString;

     mem.FieldByName('saved_picter').AsString:=dset.fieldbyname('ServFile_Name').AsString+'.jpg';
   //  SaveToFile(mem.FieldByName('saved_picter').AsString);
     mem.FieldByName('ServFile_Name').AsString:=dset.fieldbyname('ServFile_Name').AsString;
     mem.Post;
    end;

begin
result:=false;
try
if F_Dm_PicterClient.Connect then
begin

 if dset.Active then
  dset.Close;
 dset.ParamByName('id_order').AsInteger:=F_id_order;
 dset.Open;
 dset.First;
 result:=true;
 mem_maps.Open;
 mem_before.Open;
 mem_after.Open;
 dset.First;
 while not  (dset.Eof ) do
    begin

        Rec_Count:=Rec_Count+1;
        case  dset.FieldByName('ID_TYP').AsInteger of
            1:  Savetomem(mem_maps);
            2:  Savetomem(mem_before);
            3:  Savetomem(mem_after);
        end;
        dset.Next;
end;
end;
except
   result:=false;
end;
end;

procedure Tdm_avrpicter.DataModuleDestroy(Sender: TObject);

begin

F_Dm_PicterClient.Free;
mem_maps.Close;
mem_after.Close;
mem_before.Close;
DeleteDir;
end;

function Tdm_avrpicter.Insert(FileName:string):boolean;
var
    fname:string;

begin

 try
 if rec_count>0 then
  f_curmem.Last;
  f_curmem.Append;
  f_curmem.FieldByName('ID_TYP').AsInteger:=F_typ;
  f_curmem.FieldByName('fileName').AsString:=ExtractFilename(FileName);
  if tran.Active then
   tran.Rollback;
  tran.StartTransaction;
 if  F_dm_PicterClient.SavePicture(FileName,F_year,F_ordernumber,fname) then
  begin

  IBSQL.SQL.Text:=Format('insert into PICTERS_ORDER (FILE_NAME,ID_TYP,FK_ID_ORDER, ServFile_Name)'+
                  ' values (''%s'',%d,%d,''%s'') ',
                  [ExtractFilename(FileName),F_typ,F_id_order,
                  fname]);
  IBSQL.ExecQuery;
  tran.Commit;


  f_curmem.FieldByName('ServFile_Name').AsString:=fname;
  f_curmem.FieldByName('saved_picter').AsString:=fname+'.jpg';
  CopyFile(PChar(FileName),PChar(fullDirName+'\'+ f_curmem.FieldByName('saved_picter').AsString),false );


  f_curmem.Post;
  f_curmem.Last;
  Rec_Count:=f_curmem.RecordCount;
  result:=true;
  end
  else
  begin

   result:=false;
   if tran.Active then
   tran.Rollback;
  end;

  except on e:exception do begin
   if tran.Active then
   tran.Rollback;
    result:=false;
  end;
 end;
end;

function Tdm_avrpicter.DeleteIMG():boolean;
begin
 result:=false;
try
if not  f_curmem.FieldByName('ServFile_Name').IsNull then
 begin
  if tran.Active then
  tran.Rollback;
  if F_DM_PicterClient.DelPicter(f_year,F_ordernumber,f_curmem.FieldByName('ServFile_Name').AsString) then
  begin
   tran.StartTransaction;
   IBSQL.SQL.Text:=Format('delete from PICTERS_ORDER where id=%d',[ f_curmem.FieldByName('id').AsInteger]);
   IBSQL.ExecQuery;
   tran.Commit;
   f_curmem.Delete;
   Rec_Count:=f_curmem.RecordCount;
   if f_curmem.RecordCount=0 then
     F_ClearProce();
   result:=true;
  end;
 end;
except
 if tran.Active then
  tran.Rollback;
end;

end;



procedure Tdm_avrpicter.DataModuleCreate(Sender: TObject);
begin
try

  F_Dm_PicterClient:=Tdm_ClientImage.Create(self);
  try
    Rec_Count:=0;
    fullDirName:=ExtractFileDir(Application.ExeName)+'\'+TMP_DIR_NAME;
    CreatedDir();
  finally
  end;
except
end
end;

procedure Tdm_avrpicter.mem_mapsAfterScroll(DataSet: TDataSet);
var
 res:boolean;
 i_code:integer;
 mes:string;
begin
 i_code:=-2;
 mes:='';
 if assigned  (Redraw) then
  if  not  f_curmem.FieldByName('saved_picter').IsNull then
   if  Current_Image<> f_curmem.fieldbyname('saved_picter').asstring then
    begin
     if not FileExists(fullDirName+'\'+ f_curmem.FieldByName('saved_picter').AsString) then
      begin

       res:= F_Dm_PicterClient.LoadPicter(fullDirName+'\'+ f_curmem.FieldByName('saved_picter').AsString,
                                          F_year, F_ordernumber,
                                          f_curmem.FieldByName('ServFile_Name').AsString,
                                          i_code);
     end
     else res:=true;
    if res then
    begin
     Redraw(fullDirName+'\'+f_curmem.fieldbyname('saved_picter').asstring,
         f_curmem.RecNo,
         f_curmem.FieldByName('filename').AsString );
     Current_Image:=f_curmem.fieldbyname('saved_picter').asstring;
    end
    else
    begin

      Current_Image:='';
      case i_code of
       -1: mes:='Ошибка чтения с сервера!';
       0: mes:='Файл уделен!';
       else mes:='';
      end;
      F_ClearProce(mes);
     end
  end
  else
  begin
  end
  else
  begin
   F_ClearProce();
   Current_Image:='';
  end;

  if   (DataSet.RecNo=1)and  (not DataSet.Eof)  then DataSet.Prior;
  if ( DataSet.RecNo=DataSet.RecordCount) and  (not DataSet.Eof)  then DataSet.Last;

end;

procedure Tdm_avrpicter.CreatedDir;
begin
   if not DirectoryExists(fullDirName) then
    CreateDir(fullDirName);
end;

procedure Tdm_avrpicter.DeleteDir;
begin
  if DirectoryExists(fullDirName) then
    DelDir(fullDirName);
end;

function Tdm_avrpicter.DelDir (dir_name:string):boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir_name + #0);
  end;
  Result := (0 = ShFileOperation(fos));

end;


procedure Tdm_avrpicter.SetTyp(n_typ:integer);

begin
f_typ:=n_typ;
case F_typ of
 1:f_curmem:=mem_maps;
 2:f_curmem:=mem_before;
 3:f_curmem:=mem_after;
end;
f_curmem.First;
Rec_Count:=f_curmem.RecordCount;
mem_mapsAfterScroll(f_curmem);

end;

function Tdm_avrpicter.IsConnect():boolean;
begin
result:=F_Dm_picterClient.Connected;
end;

procedure Tdm_avrpicter.SetShowMess(proc:TSimpleProce);
begin
 F_Dm_picterClient.P_ShowMessage:=proc;
end;

end.
