unit VocCacheDModule;

interface

uses
  SysUtils, Classes, IBCustomDataSet, DB, DBClient, DBTables, DModule,
  IBDatabase, Provider;

type
  TVocOpenType = (votOpenClosed, votReopenAll);

  Tdm_VocCache = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure OpenVocDset( _VocOpenType: TVocOpenType);
  protected
    procedure VocFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  public
    procedure OpenClosedVocDsets;
    procedure ReopenVocDsets;
    procedure ShowDeletedRowInVocs( _IsShow: boolean );
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_VocCache }

procedure Tdm_VocCache.OpenClosedVocDsets;
begin
  OpenVocDset(votOpenClosed);
end;

procedure Tdm_VocCache.OpenVocDset(_VocOpenType: TVocOpenType);
var
  _IsCloseBeforeOpen: boolean;
  _VocCDS: TClientDataSet;
  _TempProvider: TDataSetProvider;
  i: integer;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try

    _TempProvider := TDataSetProvider.Create(nil);
    try
    //
      _IsCloseBeforeOpen := (_VocOpenType = votReopenAll);
      for i:=0 to ComponentCount-1 do
        if Components[i] is TClientDataSet then
        begin
          _VocCDS := Components[i] as TClientDataSet;

          if _IsCloseBeforeOpen then
            _VocCDS.Close;

          if not _VocCDS.Active then
          begin
            MyOpenIBDS( dset, _VocCDS.CommandText );
            _TempProvider.DataSet := dset;
            _VocCDS.Data := _TempProvider.Data;
          end;
        end;
    //
    finally
      _TempProvider.Free;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + ' (Tdm_VocCache.OpenVocDset)' );
    end;
  end;
end;

procedure Tdm_VocCache.ReopenVocDsets;
begin
  OpenVocDset(votReopenAll);
end;

procedure Tdm_VocCache.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TDataSet then
      (Components[i] as TDataSet).Close;
end;

procedure Tdm_VocCache.VocFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FieldByName('Activity').IsNull then
    Accept:=true
  else
    Accept:=false;
end;

procedure Tdm_VocCache.DataModuleCreate(Sender: TObject);
var
  i: integer;
  _VocCDS: TClientDataSet;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TClientDataSet then
    begin
      _VocCDS := ( Components[i] as TClientDataSet );
      _VocCDS.OnFilterRecord := VocFilterRecord;
    end;
end;

procedure Tdm_VocCache.ShowDeletedRowInVocs(_IsShow: boolean);
var
  i: integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TClientDataSet then
      ( Components[i] as TClientDataSet ).Filtered := not _IsShow;
end;

end.
