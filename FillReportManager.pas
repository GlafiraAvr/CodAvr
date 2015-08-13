unit FillReportManager;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet, Controls;

type
  TDM_FillReportManager = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    dset_PrepRepSaves: TIBDataSet;
    dset_PrepRepSavesID: TIntegerField;
    dset_PrepRepSavesDT: TDateField;
    dset_PrepRepSavesID_PREPORT: TIntegerField;
    dset_PrepRepSavesPREPORT: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_TempDir: string;
    function GetPreparedRepID(_PrepRepName: string): integer;
    function GetSavesID(_RepID: integer; _Dt: TDate): integer;
  public
    function LoadPreparedRep(_PrepRepName: string; _Dt: TDate): string;
    procedure SavePreparedReport(_PrepRepName: string; _Dt: TDate; _FileName: string);
    property TempDir: string read F_TempDir;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure TDM_FillReportManager.DataModuleCreate(Sender: TObject);
begin
  F_TempDir:=ExtractFilePath(ParamStr(0))+'\TEMP\';

  if not DirectoryExists(F_TempDir) then
    CreateDir(F_TempDir);
end;

function TDM_FillReportManager.GetPreparedRepID(
  _PrepRepName: string): integer;
begin
  MyOpenIBDS(dset,
    Format('select id from prep_reports where name=''%s''', [_PrepRepName]));
  Result:=dset.FieldByName('id').AsInteger;
end;

function TDM_FillReportManager.LoadPreparedRep(_PrepRepName: string;
  _Dt: TDate): string;
var
  _RepID: integer;
begin
  Result:='';

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    _RepID:=GetPreparedRepID(_PrepRepName);

    MyOpenIBDS(dset, Format(
      ' select preport from prep_saves'+
      ' where (id_preport=%d) and (dt=''%s'')',
      [_RepID, DateToStr(_Dt)]));

    if not dset.FieldByName('preport').IsNull then
    begin
      Result:=F_TempDir+_PrepRepName+'.frp';
      SaveBlobToFile(dset.FieldByName('preport'), Result);
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(TDM_FillReportManager.LoadPreparedRep)');
    end;
  end;
end;

procedure TDM_FillReportManager.DataModuleDestroy(Sender: TObject);
begin
  if tran.InTransaction then
    tran.Rollback;
end;

procedure TDM_FillReportManager.SavePreparedReport(_PrepRepName: string;
  _Dt: TDate; _FileName: string);
var
  _SavesID, _RepID: integer;
  _Blob: TStream;
  _FS: TFileStream;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    _RepID:=GetPreparedRepID(_PrepRepName);
    if _RepID<1 then
      raise Exception.Create('Функция GetPreparedRepID вернуло нулевое значение');
    _SavesID:=GetSavesID(_RepID, _Dt);

    dset_PrepRepSaves.Close;
    dset_PrepRepSaves.ParamByName('pID').AsInteger:=_SavesID;
    dset_PrepRepSaves.Open;

    if _SavesID>0 then dset_PrepRepSaves.Edit
    else dset_PrepRepSaves.Insert;

    dset_PrepRepSaves.FieldByName('dt').AsDateTime:=_Dt;
    dset_PrepRepSaves.FieldByName('id_preport').AsInteger:=_RepID;
    _Blob:=dset_PrepRepSaves.CreateBlobStream(dset_PrepRepSaves.FieldByName('preport'), bmWrite);
    try
      _Blob.Seek(0, soFromBeginning);
      _FS:=TFileStream.Create(_FileName, fmOpenRead or fmShareDenyWrite);
      try
        _Blob.CopyFrom(_FS, _FS.Size);
      finally
        _FS.Free;
      end;
    finally
      _Blob.Free;
    end;
    dset_PrepRepSaves.Post;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(TDM_FillReportManager.SavePreparedReport)');
    end;
  end;
end;

function TDM_FillReportManager.GetSavesID(_RepID: integer;
  _Dt: TDate): integer;
begin
  MyOpenIBDS(dset, Format(
    ' select id from prep_saves'+
    ' where (id_preport=%d) and (dt=''%s'')',
    [_RepID, DateToStr(_Dt)]));

  Result:=dset.FieldByName('id').AsInteger;
end;

end.
