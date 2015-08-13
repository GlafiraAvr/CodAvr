unit DisconnectionsDModule;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBDatabase, DModule, GlobalVocCacheDModule,
  kbmMemTable;

type
  TDM_Disconnect = class(TDataModule)
    tran: TIBTransaction;
    ds_Disconnections: TIBDataSet;
    ds_DisconnectionsFK_ID_STREET: TIntegerField;
    mt_Streets: TkbmMemTable;
    ds_Disconnectionslook_streets: TStringField;
    ds_DisconnectionsFK_ID_ORDER: TIntegerField;
    ds_Disconnectionscalc_rayon: TStringField;
    ds_DisconnectionsHOUSES: TIBStringField;
    ds_DisconnectionsADDITIONALINFO: TIBStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ds_DisconnectionsAfterInsert(DataSet: TDataSet);
    procedure ds_DisconnectionsBeforePost(DataSet: TDataSet);
    procedure ds_DisconnectionsBeforeEdit(DataSet: TDataSet);
    procedure ds_DisconnectionsCalcFields(DataSet: TDataSet);
    procedure GetText(Sender: TField;
      var Text: String; DisplayText: Boolean);

  private
    { Private declarations }
    F_OrderID: integer;
    F_RayonS: string;
    procedure OpenVocs;
  public
    { Public declarations }
    property OrderID: integer read F_OrderID write F_OrderID;
    property RayonS: string read F_RayonS write F_RayonS;
  end;

var
  DM_Disconnect: TDM_Disconnect;

implementation

{$R *.dfm}


procedure TDM_Disconnect.DataModuleCreate(Sender: TObject);
begin
  OpenVocs;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
end;



procedure TDM_Disconnect.ds_DisconnectionsAfterInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('FK_ID_ORDER').AsInteger := F_OrderID;
end;

procedure TDM_Disconnect.ds_DisconnectionsBeforePost(DataSet: TDataSet);
begin
 if dataset.FieldByName('fk_id_street').AsInteger < 1 then
    dataset.Cancel;
 if dataset.State <> dsEdit then dataset.Edit;   
end;

procedure TDM_Disconnect.ds_DisconnectionsBeforeEdit(DataSet: TDataSet);
 var _old_id: integer;
begin
 //_old_id := ds_Disconnections.FieldByName('id').AsInteger;
// ds_Disconnections.ParamByName('_old_id').AsInteger :=_old_id;
end;

procedure TDM_Disconnect.ds_DisconnectionsCalcFields(DataSet: TDataSet);
begin
 DataSet.FieldByName('calc_rayon').AsString := F_RayonS;
end;

procedure TDM_Disconnect.GetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  Text:=trim(Sender.AsString);
end;


procedure TDM_Disconnect.OpenVocs;
begin
  dm_GlobalVocCache.CheckVoc( mt_Streets );
end;

end.
